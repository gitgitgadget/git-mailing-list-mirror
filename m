From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/32] files-backend: break out ref reading
Date: Wed, 24 Feb 2016 16:51:01 -0800
Message-ID: <xmqq7fhtr4sq.fsf@gitster.mtv.corp.google.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	<1456354744-8022-4-git-send-email-dturner@twopensource.com>
	<xmqqr3g1r66h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:51:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYk98-0006zv-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcBYAvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:51:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751949AbcBYAvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:51:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8018448D81;
	Wed, 24 Feb 2016 19:51:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wH8/5MG6NT1o6h7zH48PHhcaLy8=; b=OQznDR
	sEGeTsz6LMURBDrCB/LT9VHll9m2rTKtj8sU9otbbnUAsW05ToyCK21U6wAfIB/Z
	PC/0TnDJD9qHaV70ziu0gdmaMLDrYfrm5S5FDSgtj5aH/AprHwMS1+3LkuxWRT9h
	CRXCeiNp7/Ls3qHcvzd8U3RH9fJdrBwlzi7vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0q/xEcNEGOYJOR4Pww91DjAuDyrSc7D
	QcDO3KnJek4+qC7JGKrd+77e9n2HwD4NYzSd5L1ilzjL/WYBc8N+Ec5sPzSwiQ6+
	uaejishGnEmEVQxOrMe1OeHWuyhg/XaPufJ7vVoVXclkfXQc7+geoGqXtNbg8hNE
	Mf/PBIUpn4Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7743448D80;
	Wed, 24 Feb 2016 19:51:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E233448D7C;
	Wed, 24 Feb 2016 19:51:02 -0500 (EST)
In-Reply-To: <xmqqr3g1r66h.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 24 Feb 2016 16:21:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D822DFFE-DB59-11E5-BA6F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287298>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> You can of course standardize on signed int, but because this is a
> collection of flag bits, there is no reason not to choose unsigned.
>
> I _think_ I can fix everything up before pushing out, so please
> check what will appear on 'pu' before rerolling.

I managed to whip them into shape enough to pass my compilation test
;-)  Other things I had to tweak were small things like whitespace
issues, initializing statics to 0 or NULL, etc.

Thanks.

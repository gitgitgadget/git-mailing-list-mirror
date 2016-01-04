From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/17] check-attr, check-ignore, checkout-index: read paths with strbuf_getline_crlf()
Date: Mon, 04 Jan 2016 11:20:52 -0800
Message-ID: <xmqqr3hxnobv.fsf@gitster.mtv.corp.google.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-3-git-send-email-gitster@pobox.com>
	<alpine.DEB.2.20.1601041258280.14434@virtualbox>
	<alpine.DEB.2.20.1601041305020.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:21:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGAgd-0004di-44
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbcADTU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:20:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751902AbcADTUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:20:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B11D36AC6;
	Mon,  4 Jan 2016 14:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cbA6VKgF9gp+jFE559MrxJQBREc=; b=C/S1RW
	FA5yVT0taTPFZPBt/ABkS4oudJZupCTKtmWOFU776kJ7jCymUUNFHSEJ9ywavVxp
	XLFBH38owMEdXUXVGO8Bc1qy6OPbid/amdPXiA9/bPPOCI/8kEd7rakQyzyPGdep
	VB3jIfF8giKLMscvOThYgL9Z4vbpQfzVcBbMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWCdbq7c7t7P0KZERm1HX3UinSJhUlTL
	4T/G6XVCAVHxF11A/bZsEAZrUyh5XdHfeRFF/hi919gmi4MG69wz6AToKJQ7d9mx
	kHoyuMEjveppmX707jMl98f3QjJafV8gu5Iu4RRLCNB+DxV2AfEkICdrK3+vbwVl
	5FuYWtNJBjs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2329E36AC4;
	Mon,  4 Jan 2016 14:20:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9164D36AC2;
	Mon,  4 Jan 2016 14:20:53 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601041305020.14434@virtualbox> (Johannes
	Schindelin's message of "Mon, 4 Jan 2016 13:27:26 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45C94C74-B318-11E5-B869-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283318>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I guess I would suggest to change the name "strbuf_getline" to
> "strbuf_getdelim" first, and then re-introduce a different
> "strbuf_getline" which is actually your "strbuf_getline_crlf".

Makes sense.  I really hated that name "getline_crlf".

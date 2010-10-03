From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] Allow hiding renames of individual files involved
 in a directory rename.
Date: Sun, 03 Oct 2010 16:28:52 -0700
Message-ID: <7vr5g6etzf.fsf@alter.siamese.dyndns.org>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org>
 <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@free.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Xzd-0004vR-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab0JCX3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:29:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0JCX3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:29:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F8DFDB1C7;
	Sun,  3 Oct 2010 19:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OAi6/GP/Lrxza1ed+zSKD1KjF38=; b=evTpXt
	Ar/JpolY1btedvT/2gxSwB2/h+fBxbvLsRKRenNQbfjg2EMzbm7EQzlZyJ1Hqt8R
	5WvEjJACuffyh8HpRPr/cpxaeto8FMpKuFnQ7sJslsLlrxdIqvQD5ool8W6Z8RJF
	/YE9vsP2vOikW1kH9W4TROc2UMYKYcA5G96D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZgAeVaZgF0S0SSUzOl1BdMJa0qqhlle
	p6q4Ambij+m7/5ftdK16XXhlvcAhb58Sw6GCGaL3X+1ZunYVyJlO+4dT+vZaSM1C
	sqN1DZicMFUibsE7M6b9cHb0w3ef+nlJdBukcNQvycPiMWGB1xLtc9w0OH1cNXAp
	tQSQSIONBrg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC6BDB1C6;
	Sun,  3 Oct 2010 19:28:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DFB4DB1C5; Sun,  3 Oct
 2010 19:28:53 -0400 (EDT)
In-Reply-To: <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 4 Oct 2010 01\:06\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF00BAFE-CF45-11DF-8192-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157945>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I'd like to use this by default (but only for regular 'git diff', 'git
> log', etc., not for 'git format-patch') if/when it gets merged, can
> has config option?

Having a configuration variable might be a good idea, as long as there is
a provision to avoid breaking scripted porcelains when the option is set.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Thu, 20 Jun 2013 11:11:00 -0700
Message-ID: <7vzjukveiz.fsf@alter.siamese.dyndns.org>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
	<c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
	<alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
	<0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
	<51BF26F9.1080900@viscovery.net>
	<7vvc5cg0i8.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se>
	<51C2B8DA.6040400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Mathieu =?utf-8?Q?Li=C3=A9na?= =?utf-8?Q?rd--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 20:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpjKA-0006uC-AP
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 20:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545Ab3FTSLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 14:11:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758541Ab3FTSLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 14:11:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2E8329BFF;
	Thu, 20 Jun 2013 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UB04FMimK0SN6U8A/MuTAmbGHQ=; b=syHZ3y
	QIaTIb96AWoz5XQ8+MYAipjNVQ0do7jSXFHqolmsbgDxh0PEQ/xv4TSberadzTlw
	lSp8MMz688X2ZELY5ht45uWf1+A+gbCLvqSfeaRiEtzO38nwA9rBNmv6AapM5s99
	IEoKvDBrtaRT6+47VGpfoW9wwF8AlkFUhdFnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NbEYfkGRdiomvpjtDkgVuPt7L6N+Sidb
	4aZly0iEdhJU94EK69M0fScFxkiWucZJjmH6f8TcWngOtDJ3U8ZA/cYUikjF1dfW
	2ZrHx6KDkT2VGftVWFP2ramZCiMySnjrh0vVzG8ghGrGAw66dNFUyluImNQV0/C4
	vb9/jSlVTnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9650029BFE;
	Thu, 20 Jun 2013 18:11:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEC4829BFD;
	Thu, 20 Jun 2013 18:11:01 +0000 (UTC)
In-Reply-To: <51C2B8DA.6040400@viscovery.net> (Johannes Sixt's message of
	"Thu, 20 Jun 2013 10:10:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C417D034-D9D4-11E2-9D48-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228519>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/20/2013 9:56, schrieb Peter Krefting:
>> Junio C Hamano:
>> 
>>> But my understanding is that the reordering using printf() is the
>>> mechanism we suggest l10n folks to use when the order of parameters
>>> given to printf does not match the preferred word order in the message
>>> in their language.
>> 
>> It's documented in the gettext manual, and seems to be used in the
>> zh_CN.po to change the word order in quite a few places.
>
> It is fine to use %n$ in translated strings as long as gettext is enabled
> only on systems that have a sufficiently capable printf and these formats
> are not used in the source code.
>
> But you can't have this string:
>
>   "Splitting a commit while rebasing branch '%2$s' on '%3$s'."
>
> neither in the template nor in the translation, because the numbers must
> begin at 1 (and must be used without gaps).

Did any message we saw in the patch (and the discussion to possibly
improve it) need to have such a format string, or are you pointing
out a common gotcha we may want to warn translators about in
po/README?

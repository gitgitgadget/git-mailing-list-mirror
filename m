From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 22 Apr 2013 07:55:40 -0700
Message-ID: <7va9oqr4wj.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<7vmwsrqocu.fsf@alter.siamese.dyndns.org>
	<871ua2sy95.fsf@linux-k42r.v.cablecom.net>
	<87vc7erjhc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 16:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUI9q-0001EH-9m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 16:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab3DVOzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 10:55:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab3DVOzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 10:55:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C96517CE8;
	Mon, 22 Apr 2013 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WSvaVqBnWOswoVhS/4pBV++cKx0=; b=E1+am7
	WuHO+EsgUWLltGb6PpgJKwfClyoWev8T7mr/XqvKzYxkyI2X1Q5kU3zS1s5Dp4sp
	Fxr3jSsX1BS5au3+3elVDaWSCf3FxmoS23f6UVSRkUps63LwzSOYPNgPHx2bz0cZ
	j7ibXHB0CUNXBI3CT55BTIebwOMnyQIOyZtCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0dFNUCvdiKQL0kjhmW/H1d4JS2m2glh
	kOefFyqi0vVgweXxOXz4T9yTqRlJNZ0gaHFoFuDZbh7uNV5VeZs/Co6uoKbEL9Pb
	EvJGe4cW2AUA+EA/frB3EEL67ysJChsZbI2sOUghCYQi6V6r3Vin0yRYXynJ5pL/
	+805x9VKyxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73ABE17CE7;
	Mon, 22 Apr 2013 14:55:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB9D717CE1;
	Mon, 22 Apr 2013 14:55:44 +0000 (UTC)
In-Reply-To: <87vc7erjhc.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Apr 2013 11:40:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5C92858-AB5C-11E2-A0BE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222020>

Thomas Rast <trast@inf.ethz.ch> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> -- >8 --
>> Subject: [PATCH] git-log(1): remove --full-line-diff description
>
> BTW, I generated this with your jc/format-patch, but it stopped working
> after fc/send-email-annotate made it into next; I need this on top.  Am
> I missing something?

No, the topic has been stalled and left behind and needs to be
rebased on top of that other topic with your patch.  Thanks.

It also needs a lot more work to de-mime its output to be eligible
for 'next', though.

> -- >8 --
> Subject: [PATCH] FIXUP jc/format-patch: adapt for fc/send-email-annotate
>
> 2a4c260 (format-patch: add format.coverLetter configuration variable,
> 2013-04-07) changed the coverletter variable to -1 by default, so the
> die("... incompatible") always triggers.  Test if it is >0 instead.
> ---
>  builtin/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 4804229..c972e62 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1247,7 +1247,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	/* Set defaults and check incompatible options */
>  	if (rev.inline_single) {
>  		use_stdout = 1;
> -		if (cover_letter)
> +		if (cover_letter > 0)
>  			die(_("inline-single and cover-letter are incompatible."));
>  		if (thread)
>  			die(_("inline-single and thread are incompatible."));

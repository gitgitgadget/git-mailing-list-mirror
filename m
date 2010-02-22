From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a signal handler
Date: Mon, 22 Feb 2010 10:31:57 -0800
Message-ID: <7v1vgdgm02.fsf@alter.siamese.dyndns.org>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net>
 <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net>
 <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de>
 <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njd4r-0008H6-EV
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 19:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab0BVScL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 13:32:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab0BVScJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 13:32:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0A19CD53;
	Mon, 22 Feb 2010 13:32:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QaFe2YTXmDjGysoCN7PssAAvFl4=; b=soJvJO
	kVBmTu5DU8D9botybtBna+UaxvbdC/esUjW3HNMBwETewn5TQm4Ls5SoGB/PnwCG
	jOKbzzWCYK9p0a31bAqooPaA6kLpigtD6chErOo+KcKVTAmS9/GAUWdIIoifXewL
	266rGRXmQsXNSFZo8yTUFNd8txGQiRR5LZn+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVFQsZZspKfl4lMGAr3kpjlJbeRhvFyE
	ANH2LQGiDi24Dw+0ZL1z0MAxefyRo7GPYlSdK5F7u5q8p0HBrjnarBtyNTmVodzC
	5m28ukBvlwL+B7s5lJyyjDlZF9IvCUYj3BFhpaseMkmMLslxOf+RPG0CYQ45Wszi
	/J/0F+DWJW0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEA69CD4E;
	Mon, 22 Feb 2010 13:32:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E55529CD4D; Mon, 22 Feb
 2010 13:31:59 -0500 (EST)
In-Reply-To: <4B82744B.4060805@web.de> (Markus Elfring's message of "Mon\, 22
 Feb 2010 13\:10\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 930B2286-1FE0-11DF-B1E0-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140706>

Markus Elfring <Markus.Elfring@web.de> writes:

>> Of are you asking me if I'd apply your patch if you send a polished update,
>> and asking me to decide it before seeing the patch?
>
> Would you like to pick this source code adjustment up?
>
> Regards,
> Markus
>
> ---
>>From e138904a08ceaf469fa2f4d0ec87b5891be14760 Mon Sep 17 00:00:00 2001

It would be preferred to remove everything above this line when you send
patches.

> From: Markus Elfring <Markus.Elfring@web.de>
> Date: Mon, 22 Feb 2010 11:53:35 +0100
> Subject: [PATCH] Fix a signal handler

Please be a bit more careful when coming up with what Subject: says; it
will be the only piece of information to tell the reader of output from
"git shortlog" what the commit made from this patch is about.  E.g.

    Subject: [PATCH] log --early-output: signal handler pedantic fix

> A global flag can only be set by a signal handler in a portable way
> if it has got the data type "sig_atomic_t". The previously used assignment
> of a function pointer in the function "early_output" was moved to another
> variable in the function "setup_early_output".

The first sentence gives the basis of your argument (so that people can
decide to agree or disagree with you).  Then you describe why you think
the code you are changing is wrong --- oops, that part is missing --- and
what you did based on the above two observations --- oops, that part is
missing, too --- and then any additional info.

I'd phrase the above like this:

    The behavior is undefined if the signal handler refers to any object
    other than errno with static storage duration other than by assigning
    a value to a static storage duration variable of type "volatile
    sig_atomic_t", but the existing code updates a variable that holds a
    pointer to a function (i.e. not a sigatomic_t variable).

    Change it to only set a flag, and adjust the callsite that calls the
    early-output function to check it.

and that would be sufficiently clear without saying anything else.

> diff --git a/builtin-log.c b/builtin-log.c
> index e0d5caa..beccf7f 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -170,20 +170,14 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
>  
>  static void early_output(int signal)
>  {
> -	show_early_output = log_show_early;
> +	show_early_output = 1;
>  }
>  
>  static void setup_early_output(struct rev_info *rev)
>  {
>  	struct sigaction sa;
>  
> -	/*
> -	 * Set up the signal handler, minimally intrusively:
> -	 * we only set a single volatile integer word (not
> -	 * using sigatomic_t - trying to avoid unnecessary
> -	 * system dependencies and headers), and using
> -	 * SA_RESTART.
> -	 */
> +	early_output_function = &log_show_early;

Your proposed log message also needs to make a good counter-argument why
the above "we purposely avoid using sigatomic_t --- it is not worth the
hassle of having to deal with systems that lack this type in practice" is
worried too much, and it now is sensible to assume that everybody has
sigatomic_t these days to allow us do "the right thing".  It can be just
as simple as 'Output from "git grep sigatomic_t" indicates that we are
already using it.' but you need to say something, as this comment you are
removing makes it clear that it was not a bug by mistake or ignorance, but
instead was a deliberate choice.

> diff --git a/revision.c b/revision.c
> index 3ba6d99..62402fb 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -13,7 +13,8 @@
>  #include "decorate.h"
>  #include "log-tree.h"
>  
> -volatile show_early_output_fn_t show_early_output;
> +sig_atomic_t show_early_output = 0;
> +show_early_output_fn_t early_output_function = NULL;

According to POSIX, "s-e-o" has to be "volatile sig_atomic_t".  Also we do
not explicitly initialize bss variables to zero or NULL.

Thanks.

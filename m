From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sideband.c: Get rid of ANSI sequences for non-terminal shell
Date: Mon, 02 Jun 2014 10:59:48 -0700
Message-ID: <xmqqk38z5h0r.fsf@gitster.dls.corp.google.com>
References: <81E85F13A4BE084BAF4B1AA24173EDA0144E14B7@JWPKEXMBX03.corp.checkfree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, "peff\@peff.net" <peff@peff.net>,
	"spearce\@spearce.org" <spearce@spearce.org>,
	"j6t\@kdbg.org" <j6t@kdbg.org>, "nico\@cam.org" <nico@cam.org>,
	"junkio\@cox.net" <junkio@cox.net>,
	"kusmabite\@gmail.com" <kusmabite@gmail.com>,
	"mnaoumov\@gmail.com" <mnaoumov@gmail.com>
To: "Naumov\, Michael \(North Sydney\)" <Michael.Naumov@Fiserv.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:00:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWWm-0004yp-GC
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbaFBSAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:00:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53457 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbaFBSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:00:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F1D11D511;
	Mon,  2 Jun 2014 13:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xHZQiJMD4gje4DUAZt8eopbqNqw=; b=wJkZW6
	uQhOGSm316PA6bIwWbrgXVs9zSleJaHOfmF1ONroouvU4vgHmzQTOfFY/4XcLmJf
	wd+ITmVvW+mxcdQkRpmBzln1UCvk1ifn8ha7d+wWYoAeT2UOoqGzRfriKHGYIHIe
	rIilxsiUy54ko97JsvrHiFYnviduokP98/FQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=guryU3bxelo8E3XkUJz3Z0EBY/ogFSU4
	Sb4qc8OXGNsvjfzlUY7OlKzroc4T55pYVVAcY+L/MaRM5UPxnAfnhbS7rCRF69kY
	6zyXMoBzC9TN3bs89NkwWib24YIcX7yR96Zu/EK8zJ9tziMsRaTHuiy5uiHZf3zh
	vtpznB5voEI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F0C11D510;
	Mon,  2 Jun 2014 13:59:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 648381D505;
	Mon,  2 Jun 2014 13:59:50 -0400 (EDT)
In-Reply-To: <81E85F13A4BE084BAF4B1AA24173EDA0144E14B7@JWPKEXMBX03.corp.checkfree.com>
	(Michael Naumov's message of "Fri, 30 May 2014 23:10:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B12453DC-EA7F-11E3-9CA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250575>

"Naumov, Michael (North Sydney)" <Michael.Naumov@Fiserv.com> writes:

You either want to correct the "From: " header that appears in
e-mails from you, or want to start your body of your patch message
like this:

	From: Michael Naumov <mnaoumov@gmail.com>

	Some git tools such as GitExtensions for Windows...

if you want the author of the patch and the name you used to sign it
off to match, which is almost always what you want.

> Some git tools such as GitExtensions for Windows use environment
> variable TERM=msys which causes the weird ANSI sequence shown for the
> messages returned from server-side hooks

The above sentence, while it may be telling a truth, feels more or
less irrelevant, especially the part that talks about TERM=msys.
Even if GitExtensions used TERM=vt100, the end result would be the
same, wouldn't it?

If you are suggesting a fix to GitExtensions to make it export
TERM=dumb like everybody else does, that would be a different
story.  Mentioning "TERM=msys causes the problem" would be a very
relevant thing to do.  But this patch is not that.

> We add those ANSI sequences to help format sideband data on the user's
> terminal. However, GitExtensions is not using a terminal, and the ANSI
> sequences just confuses it. We can recognize this use by checking
> isatty().

    This on the other hand is very readable.  How about rephrasing these
    two like so:

    Diagnostic messages received on the sideband #2 from the server side
    are sent to the standard error with ANSI terminal control sequence
    "\033[K" that erases to the end of line appended at the end of each
    line.

    However, some programs (e.g. GitExtensions for Windows) read and
    interpret and/or show the message without understanding the terminal
    control sequences, resulting them to be shown to their end users.
    To help these programs, squelch the control sequence when the
    standard error stream is not being sent to a tty.

There are programs that drive other programs (not limited to Git)
through pty (hence satisfying isatty(2)) without interpreting the
ANSI terminal control sequences, and it is conventional for these
programs to export TERM=dumb, so and your patch still checks for
TERM=dumb to help them, which is very good.

> See https://github.com/gitextensions/gitextensions/issues/1313 for
> more details

And if you explain it like the above, I do not think this external
reference is very useful.

> NOTE: I considered to cover the case that a pager has already been
> started. But decided that is probably not worth worrying about here,
> though, as we shouldn't be using a pager for commands that do network
> communications (and if we do, omitting the magic line-clearing signal
> is probably a sane thing to do).

Sensible.

> Signed-off-by: Michael Naumov <mnaoumov@gmail.com>
> Thanks-to: Erik Faye-Lund <kusmabite@gmail.com>
> Thanks-to: Jeff King <peff@peff.net>
> ---
>  sideband.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sideband.c b/sideband.c
> index d1125f5..7f9dc22 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -30,7 +30,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  
>  	memcpy(buf, PREFIX, pf);
>  	term = getenv("TERM");
> -	if (term && strcmp(term, "dumb"))
> +	if (isatty(2) && term && strcmp(term, "dumb"))
>  		suffix = ANSI_SUFFIX;
>  	else
>  		suffix = DUMB_SUFFIX;

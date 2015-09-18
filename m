From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Documentation: make explicit that optional arguments
 must be stuck
Date: Fri, 18 Sep 2015 15:27:18 -0400
Message-ID: <20150918192718.GE11068@sigill.intra.peff.net>
References: <20150917174306.GA29171@sigill.intra.peff.net>
 <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
 <1442588510-7379-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Alastair McGowan-Douglas <altreus@altre.us>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd1Jd-0000B9-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbbIRT1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:27:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33333 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752618AbbIRT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:27:21 -0400
Received: (qmail 20250 invoked by uid 102); 18 Sep 2015 19:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 14:27:21 -0500
Received: (qmail 11048 invoked by uid 107); 18 Sep 2015 19:27:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 15:27:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Sep 2015 15:27:18 -0400
Content-Disposition: inline
In-Reply-To: <1442588510-7379-4-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278220>

On Fri, Sep 18, 2015 at 05:01:50PM +0200, Matthieu Moy wrote:

> The behavior of command-line options with optional arguments is
> documented in gitcli(7), but it is easy for users to miss, and hard for
> the same user to understand why e.g. "git status -u no" does not work.
> 
> Document this explicitly in the documentation of each short option having
> an optional argument: they are the most error prone since there is no '='
> sign between the option and its argument.

I like this. Even though it is redundant, it is getting information to
the place where users can see it, and I don't think it is so large as to
obscure the rest of the content.

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index dbea6e7..5f0082e 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -141,7 +141,8 @@ default.   You can use `--no-utf8` to override this.
>  
>  -S[<keyid>]::
>  --gpg-sign[=<keyid>]::
> -	GPG-sign commits.
> +	GPG-sign commits. The `keyid` argument is optional; if
> +	specified, it must be stuck to the option without a space.

I think this wording is probably OK. At first I thought it was saying
the wrong thing for the long form ("stuck without a space" would mean
"--gpg-sign[keyid]"), but I think the syntax just above makes it pretty
clear.

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 335f312..e1e8f57 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -53,8 +53,9 @@ OPTIONS
>  --untracked-files[=<mode>]::
>  	Show untracked files.
>  +
> -The mode parameter is optional (defaults to 'all'), and is used to
> -specify the handling of untracked files.
> +The mode parameter is used to specify the handling of untracked files.
> +It is optional: it defaults to 'all', and if specified, it must be
> +stuck to the option (e.g. `-uno`, but not `-u no`).

I think this rearrangement makes the meaning much more clear overall.

-Peff

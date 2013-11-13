From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix single quotes, AsciiDoc escaping, and other formatting/grammatical issues
Date: Wed, 13 Nov 2013 09:51:25 -0800
Message-ID: <xmqqtxfgdwbm.fsf@gitster.dls.corp.google.com>
References: <1384319951-31321-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed Nov 13 18:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgebI-0005aM-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 18:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab3KMRvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 12:51:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab3KMRvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 12:51:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4E95193D;
	Wed, 13 Nov 2013 12:51:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qwFDeTVvfL3QvTO7D0G00itoxno=; b=MdBWCO
	cDYwgNOwXHRdp+sok/hhcqxgEPM1jxz9Dh/xVGbqUbP3POLwZlRxaomeb0Q3UzC4
	CuWcHLNw4bAiVago9t+FRK7mxW0DBBvNbgV17sFdzkKZ6l4hYDnT69+A+4OJuE3R
	z9VLePPUrT9LsijVqzzdGhmdH0UhAlx49isj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCsqFefeVgrM0eNkoTUBYW7kH9Wc9rPz
	sG9jmiEcsydHIQELw9QETI6TVQXsnk/z0/KRm996rTSonh1Ux9M1j8FSHA7AIzSG
	vanYWuQvvAufdFF2h2yCuhvZwNM4aV/JGkwzK6apeKKvcJW3FZVvML94i35Q+mHa
	vMvGblWioYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 186445193C;
	Wed, 13 Nov 2013 12:51:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CF5A51936;
	Wed, 13 Nov 2013 12:51:29 -0500 (EST)
In-Reply-To: <1384319951-31321-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Wed, 13 Nov 2013 00:19:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 395A0EB4-4C8C-11E3-A106-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237795>

"Jason St. John" <jstjohn@purdue.edu> writes:

> rev-list-options.txt:
> -- added line breaks before some "endif" AsciiDoc commands to fix syntax
>      highlighting in Vim
> -- added line breaks after some options subheadings to fix syntax
>      highlighting in Vim

Can't Vim be fixed instead (just kidding ;-)?

> -- added backticks around options/commands that were missing it

> -- removed AsciiDoc escapes for "--" in options/commands
> -- replaced single quotes around options/commands with backticks

I think the former is part of the latter. Both are good changes.

> -- replaced "regexp" with "regular expression(s)" where appropriate

Good.

> -- added backticks around a file path to /dev/null

Good---this is a mere special case of "literal examples" and can be
thrown into the same bin as "options, commands etc.".

> -- replaced some double quotes with proper AsciiDoc quotes (e.g.
>      ``foo'')

Hmph.  No strong opinions either way from me, but others may have some.

> -- slightly reworded some sentences for easier reading
> -- fix some typos (e.g. "show" -> "shown")

Usually, these two are better done in a patch separate from the
formatting changes, but let's see how bad they are.

Interestingly, only the last bullet point is in the imperative mood,
that gives an order to the codebase to "be so"; all others are
written in past tense with implied subject "I".  We prefer to see
the former, i.e.

        Subject: Documentation/rev-list-options: fix mark-ups and typos

        Various fixes:

         - Add an empty line before endif; this helps syntax
           highlighting in Vim;

         - Add an empty line after the item label line in labeled
           lists; this helps syntax highlighting in Vim and also
           helps line-rewrapping of the body text in Emacs;

         - Typeset literal options, commands and pathnames in
           monospace;

         - Use "regular expression(s)" instead of "regexp" where
           appropriate;

         ...

>
> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---
> This is a resubmit of patch 2/4 from my earlier patchset:
> http://marc.info/?l=git&m=138395814108214&w=2

Thanks.

> @@ -213,15 +220,15 @@ endif::git-rev-list[]
>  --cherry-pick::
>  
>  	Omit any commit that introduces the same change as
> -	another commit on the "other side" when the set of
> +	another commit on the ``other side'' when the set of
>  	commits are limited with symmetric difference.
>  +
>  For example, if you have two branches, `A` and `B`, a usual way
>  to list all commits on only one side of them is with
>  `--left-right` (see the example below in the description of

> -the `--left-right` option).  It however shows the commits that were cherry-picked
> -from the other branch (for example, "3rd on b" may be cherry-picked
> -from branch A).  With this option, such pairs of commits are
> +the `--left-right` option). However, it shows the commits that were
> +cherry-picked from the other branch (for example, "3rd on b" may be
> +cherry-picked from branch A). With this option, such pairs of commits are
>  excluded from the output.

I am not sure if I see improvement here.

You left "3rd on b" as-is---intended?

> @@ -254,14 +261,14 @@ list.
>  	exclude (that is, '{caret}commit', 'commit1..commit2',
>  	nor 'commit1\...commit2' notations cannot be used).
>  +
> -With '\--pretty' format other than oneline (for obvious reasons),
> +With `--pretty` format other than `oneline` (for obvious reasons),

Good eyes.  `oneline` is a literal value for an option that needs to
be in monospace.  Good.

>  --no-walk[=(sorted|unsorted)]::
>  
>  	Only show the given commits, but do not traverse their ancestors.
>  	This has no effect if a range is specified. If the argument
> -	"unsorted" is given, the commits are show in the order they were
> +	"unsorted" is given, the commits are shown in the order they were

Not `unsorted`???

>  	given on the command line. Otherwise (if "sorted" or no argument

Likewise.  Not `sorted`???

>  `--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
> -format, often found in E-mail messages.
> +format, often found in e-mail messages.

Hmph.  I do not have strong preference either way.

> -`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
> +`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.

Thanks.

> @@ -814,7 +829,7 @@ ifndef::git-rev-list[]
>  Diff Formatting
>  ~~~~~~~~~~~~~~~
>  
> -Below are listed options that control the formatting of diff output.
> +Listed below are options that control the formatting of diff output.

Good.  This grammo dates back to Sep 2006 ;-)

Will queue it as-is for now (primarily for me not to forget about
the topic), but we may want to further tweak some.

Thanks.

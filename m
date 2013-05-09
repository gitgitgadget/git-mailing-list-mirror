From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] documentation: trivial style cleanups
Date: Thu, 09 May 2013 16:09:19 -0700
Message-ID: <7vehdf7nts.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZxr-00080T-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231Ab3EIXJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:09:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550Ab3EIXJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:09:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82F621DFC4;
	Thu,  9 May 2013 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ksPG3w4T2OPtoDyKppL6RUoW9Vg=; b=cijBR42yixthFKUBl8En
	Gw6Zk0WU33UDWKLa2HyddlKiZi1TXt1Sej1az0aHjz4WI8pzMiceW4FKanaLSzq5
	xHgnZv+GH5ytZB+Yzvlx/e/XpSDTEZIKeKeEJNPplkPQGFXL4SD0ec8PvZG3vvW9
	pR8kxtOIUcRHdVF01GbbgjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=C3B9J8TbDBf0AH4LkatWmTSVlQFJ8JsrCaYyZKH3KI6tCt
	gR0e2xoqWA1VuUhWR4doH846AygdOtQt90T14camxKJUVJFrtTM+84PUjstVFDPf
	eC2Rhv4ooHWtf8MgZ0M0HCDawpuuNmr1NqRvgOOxIVBMA7bI/+FCZJ14UCOJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79CA41DFC3;
	Thu,  9 May 2013 23:09:22 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A2921DFC2;
	Thu,  9 May 2013 23:09:21 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B8F7710-B8FD-11E2-BC97-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223799>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> White-spaces, missing braces, standardize --[no-]foo.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

This is uncomfortably big at this phase of the release cycle, but
thanks anyway.

Because I didn't want to review this patch only to spot silly
formatting mistakes that may break the documentation build (which I
didn't find any), I looked the entire files the patch touches, and
many of the comments below ended up being suggestions for a
follow-up work for people who would want to pick low-hanging fruits.

Hint, hint.

There however are a few things that should have been in this patch,
though.  I'll attach what I'd queue as "SQUASH???" on top of this
patch at the bottom.

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 19d57a8..5bbe7b6 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -9,12 +9,12 @@ git-am - Apply a series of patches from a mailbox
>  SYNOPSIS
>  --------
>  [verse]
> -'git am' [--signoff] [--keep] [--keep-cr | --no-keep-cr] [--utf8 | --no-utf8]
> +'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
>  	 [--3way] [--interactive] [--committer-date-is-author-date]
>  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
>  	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
> -	 [--scissors | --no-scissors]
> +	 [--[no-]scissors]
>  	 [(<mbox> | <Maildir>)...]
>  'git am' (--continue | --skip | --abort)
>  
> @@ -43,8 +43,7 @@ OPTIONS
>  --keep-non-patch::
>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
> ---keep-cr::
> ---no-keep-cr::
> +--[no-]keep-cr::
>  	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
>  	with the same option, to prevent it from stripping CR at the end of
>  	lines. `am.keepcr` configuration variable can be used to specify the

OK.

We still have two separate entries for "--scissors/--no-scissors"
and "--utf8/--no-utf8" pairs in the description text.  Do they want
to get united somehow?

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 5c16e31..a0727d7 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
>  	  [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch]
> -	  [--recursive|--recurse-submodules] [--] <repository>
> +	  [--recursive | --recurse-submodules] [--] <repository>
>  	  [<directory>]
>  
>  DESCRIPTION
> @@ -188,7 +188,7 @@ objects from the source repository into a pack in the cloned repository.
>  	with a long history, and would want to send in fixes
>  	as patches.
>  
> ---single-branch::
> +--[no-]single-branch::
>  	Clone only the history leading to the tip of a single branch,
>  	either specified by the `--branch` option or the primary
>  	branch remote's `HEAD` points at. When creating a shallow

OK.

We have "--no-hardlinks" without "--hardlinks".  Does the parser
accept "--no-no-hardlinks"?  If so, we may want to error it out.

I would omit the options "--no-hardlinks" and "--shared", and added
"--local={link,copy,shared}" instead, as these two options only make
sense when cloning from a local repository, if I were doing the UI
from scratch today.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 8172938..1a7616c 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
> +	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
>  
>  DESCRIPTION

OK.

We have "--no-verify" without "--verify".  Does the parser accept
"--no-no-verify"?  If so we may want to error it out.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 9ae2508..d88a6fc 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -186,8 +186,7 @@ See also <<FILES>>.
>  	Opens an editor to modify the specified config file; either
>  	'--system', '--global', or repository (default).
>  
> ---includes::
> ---no-includes::
> +--[no-]includes::
>  	Respect `include.*` directives in config files when looking up
>  	values. Defaults to on.

OK.

The SYNOPSIS section begins like this:

    SYNOPSIS
    --------
    [verse]
    'git config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
    ...

Other parts of this patch seems to want to have SPs around vertical
bars that shows choices, so "[-z | --null]" would be necessary as a
follow-up to bring more consistency.

The placeholders like "type", "name", "value", etc. are not inside
<angle-brackets>, which may want to be fixed as well.

It is unclear what "<file-option>" is.  A few paragraphs in the
DESCRIPTION section talk about --system/global/etc.; there should be
a sentence there to mention that exact term <file-option> to help
the reader make a connection, just like the paragraph that talks
about "type" uses that word to make it clear the word in SYNOPSIS is
about things like --int/bool/path.

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index bfb106c..61a5701 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  	     [--enable=<service>] [--disable=<service>]
>  	     [--allow-override=<service>] [--forbid-override=<service>]
>  	     [--access-hook=<path>]
> -	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]
> +	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]]
>  	     [<directory>...]

You can say "--inetd".  Only when you do not say "--inetd", you can
use "--listen", "--port", etc.  Further, only when you say "--user",
you can also say "--group".  OK.

As this is governed by [verse], it would be more helpful to show
that logic not just with the nesting of [], but make it stand out
with a line break, perhaps like:

        [--inetd |
         [--listen=<host>] [--port=<n>]
         [--user=<user> [--group=<group>]]]

(I do not mind to see a single line for the second and third lines).

> @@ -169,8 +169,7 @@ Git configuration files in that directory are readable by `<user>`.
>  	repository configuration.  By default, all the services
>  	are overridable.
>  
> ---informative-errors::
> ---no-informative-errors::
> +--[no-]informative-errors::
>  	When informative errors are turned on, git-daemon will report
>  	more verbose errors to the client, differentiating conditions
>  	like "no such repository" from "repository not exported". This

OK.

By the way, this is missing from SYNOPSIS, unlike all the other
options to this command.

> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index 8361e6e..11887e6 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -69,8 +69,7 @@ with custom merge tool commands and has the same value as `$MERGED`.
>  --tool-help::
>  	Print a list of diff tools that may be used with `--tool`.
>  
> ---symlinks::
> ---no-symlinks::
> +--[no-]symlinks::
>  	'git difftool''s default behavior is create symlinks to the
>  	working tree when run in `--dir-diff` mode and the right-hand
>  	side of the comparison yields the same content as the file in

OK.

We have "--no-symlinks" without "--symlinks".  Does the parser
accept "--no-no-symlinks"?  If so, we may want to error it out.

> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index 03fc8c3..efb0380 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -106,11 +106,11 @@ marks the same across runs.
>  	different from the commit's first parent).
>  
>  [<git-rev-list-args>...]::
> -       A list of arguments, acceptable to 'git rev-parse' and
> -       'git rev-list', that specifies the specific objects and references
> -       to export.  For example, `master~10..master` causes the
> -       current master reference to be exported along with all objects
> -       added since its 10th ancestor commit.
> +	A list of arguments, acceptable to 'git rev-parse' and
> +	'git rev-list', that specifies the specific objects and references
> +	to export.  For example, `master~10..master` causes the
> +	current master reference to be exported along with all objects
> +	added since its 10th ancestor commit.

OK.

We have "--no-data" without "--data".  Does the parser accept
"--no-no-data"?  If so, we may want to error it out.

> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
> index b81e90d..1e71754 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -10,9 +10,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag]
> -				[--upload-pack=<git-upload-pack>]
> -				[--depth=<n>] [--no-progress]
> -				[-v] [<host>:]<directory> [<refs>...]
> +	[--upload-pack=<git-upload-pack>]
> +	[--depth=<n>] [--no-progress]
> +	[-v] [<host>:]<directory> [<refs>...]

OK.

We have "--no-progress" without "--progress".  Does the parser
accept "--no-no-progress"?  If so, we may want to error it out.

> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index 6b563c5..d758f3a 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
>  SYNOPSIS
>  --------
>  [verse]
> -'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>...]
> +'git mergetool' [--tool=<tool>] [-y|--[no-]prompt] [<file>...]
>  
>  DESCRIPTION
>  -----------

Other parts of this patch seems to want to have SPs around vertical
bars that shows choices, so "[-y | --[no-]prompt]" would be needed,
especially given that this patch touches that same line.

> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 70152e8..f79c9d8 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -8,7 +8,7 @@ git-revert - Revert some existing commits
>  SYNOPSIS
>  --------
>  [verse]
> -'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
> +'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
>  'git revert' --continue
>  'git revert' --quit
>  'git revert' --abort

OK.

The DESCRIPTION section only describes "--no-edit", which may need
to be fixed.



-- squash --

    SQUASH???

    Update the overlong SYNOPSIS section for git-daemon. As the patch
    adds SPs around vertical bars for [choice1 | choice2], match the
    line it touches in git-mergetool.txt to also do that.

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 61a5701..223f731 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -16,8 +16,10 @@ SYNOPSIS
 	     [--reuseaddr] [--detach] [--pid-file=<file>]
 	     [--enable=<service>] [--disable=<service>]
 	     [--allow-override=<service>] [--forbid-override=<service>]
-	     [--access-hook=<path>]
-	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]]
+	     [--access-hook=<path>] [--[no-]informative-errors]
+	     [--inetd |
+	      [--listen=<host_or_ipaddr>] [--port=<n>]
+	      [--user=<user> [--group=<group>]]]
 	     [<directory>...]
 
 DESCRIPTION
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index d758f3a..07137f2 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y|--[no-]prompt] [<file>...]
+'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------

Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211533E378
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253048; cv=none; b=IRwxx49mWSCS1bVEb3wm9hlCu/PpRpxxf4jTpQrP5LICClLnaX5aEF+r8EEY2yab0LkrcY/Hn5f7YdJ33rzq/tXsymBIXJKbH3wW8AlSDShx9n/A+ZMbJekLvgpjX1/+I/sxhlAwLRJ66Mp0Hwyv7rzop5UZcgBzpLXBbesze64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253048; c=relaxed/simple;
	bh=0+Z6zw9z7WYt1fXAkrUwaPmBkZrvtEdNAyAbAMs13t0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2f97QYhIn5YW4cQ9wlyvwfIfVb8qAlHRmQTwJayni/ANtD3yR9Uq4gaueLoTL0OIle5PfyXPkYwKv5KR3pFhuEH1r9fK5thy6ueRzpjpfAkrVUn+RYPCHaqkbHS7ZBFVzRhlawBFXEgIQfWuZKPjE5YiGDnKFLeQM+VY1K0PYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Iswfxw5F; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Iswfxw5F"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3f0a:6352:d04e:7d70])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 6CE5EB00579;
	Mon, 12 Jan 2026 22:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1768253038;
	bh=0+Z6zw9z7WYt1fXAkrUwaPmBkZrvtEdNAyAbAMs13t0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iswfxw5FGyaLTEfRTJlE/dQU/wTeknXnb6KtOyeZroXJNXsmVw3rdeDUJu5fZ/igl
	 xJ/CIdRyME/6grDJVqZScTnqSYioIkV+dtESF1TeeTLomXezC8aHf5x6iPqfBC31FO
	 15kQxVEVGwzTa5McrFcENt5TXhA/qkMAPkdq6t0m86x4eJi6VdBzwIvnpvXV4gCvFu
	 RXYLYpSHCQP1I2bmYaXfifYwOReUX3KTJ4K55YCAP/k47rlOMvmbV+wv9e/gJE7NFZ
	 g0Y33WC/e4umTcv+2BvEJRTN/L9aHJoENrjBDTuCItYWH1iRzwNYwD3FR0WxKyZK1V
	 RvGggZ4n9W0rg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH 1/1] doc: git-bisect: convert to new doc format
Date: Mon, 12 Jan 2026 22:23:55 +0100
Message-ID: <4705928.LvFx2qVVIh@piment-oiseau>
In-Reply-To: <20260111204316.836446-2-git@michael.lyo.nz>
References:
 <20260111204316.836446-1-git@michael.lyo.nz>
 <20260111204316.836446-2-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 11 January 2026 21:42:48 CET Michael Lyons wrote:
> - Change placeholders to glossary terms
> - Refer to placeholders in prose
> - Delimit runnable commands and CLI args with backticks
> - Link internal heading
> 
> Signed-off-by: Michael Lyons <git@michael.lyo.nz>
> ---
>  Documentation/git-bisect.adoc | 67 ++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
> index b0078dda0e..65fec9fd29 100644
> --- a/Documentation/git-bisect.adoc
> +++ b/Documentation/git-bisect.adoc
> @@ -8,20 +8,20 @@ git-bisect - Use binary search to find the commit that 
introduced
> a bug
> 
>  SYNOPSIS
>  --------
> -[verse]
> -'git bisect' start [--term-(bad|new)=<term-new> --term-(good|old)=<term-
old>]
> -		   [--no-checkout] [--first-parent] [<bad> [<good>...]] 
[--] [<pathspec>...]
> -'git bisect' (bad|new|<term-new>) [<rev>]
> -'git bisect' (good|old|<term-old>) [<rev>...]
> -'git bisect' terms [--term-(good|old) | --term-(bad|new)]
> -'git bisect' skip [(<rev>|<range>)...]
> -'git bisect' next
> -'git bisect' reset [<commit>]
> -'git bisect' (visualize|view)
> -'git bisect' replay <logfile>
> -'git bisect' log
> -'git bisect' run <cmd> [<arg>...]
> -'git bisect' help
> +[synopsis]
> +git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
> +		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] 
[<pathspec>...]
> +git bisect (bad|new|<term-new>) [<commit>]
> +git bisect (good|old|<term-old>) [<commit>...]
> +git bisect terms [--term-(good|old) | --term-(bad|new)]
> +git bisect skip [(<commit>|<range>)...]
> +git bisect next
> +git bisect reset [<commit>]
> +git bisect (visualize|view)
> +git bisect replay <logfile>
> +git bisect log
> +git bisect run <cmd> [<arg>...]
> +git bisect help
> 
>  DESCRIPTION
>  -----------
> @@ -38,8 +38,8 @@ In fact, `git bisect` can be used to find the commit that 
changed
> *any* property of your project; e.g., the commit that fixed a bug, or
>  the commit that caused a benchmark's performance to improve. To
>  support this more general usage, the terms "old" and "new" can be used
> -in place of "good" and "bad", or you can choose your own terms. See
> -section "Alternate terms" below for more information.
> +in place of "good" and "bad", or you can choose your own terms. See the
> +<<alternate-terms,Alternate terms>> section below for more information.
> 
>  Basic bisect commands: start, bad, good
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -116,6 +116,7 @@ bad revision, while `git bisect reset HEAD` will leave 
you on
> the current bisection commit and avoid switching commits at all.
> 
> 
> +[[alternate-terms]]
>  Alternate terms
>  ~~~~~~~~~~~~~~~
> 
> @@ -144,13 +145,13 @@ bisect start` without commits as argument and then run 
the
> following commands to add the commits:
> 
>  ------------------------------------------------
> -git bisect old [<rev>]
> +git bisect old [<commit>]
>  ------------------------------------------------
> 
>  to indicate that a commit was before the sought change, or
> 
>  ------------------------------------------------
> -git bisect new [<rev>...]
> +git bisect new [<commit>...]
>  ------------------------------------------------
> 
>  to indicate that it was after.
> @@ -208,7 +209,7 @@ Git detects a graphical environment through various 
environment
> variables: `MSYSTEM`, which is set under Msys2 and Git for Windows.
>  `SECURITYSESSIONID`, which may be set on macOS in interactive desktop 
sessions.
> 
> -If none of these environment variables is set, 'git log' is used instead.
> +If none of these environment variables is set, `git log` is used instead.
>  You can also give command-line options such as `-p` and `--stat`.
> 
>  ------------
> @@ -308,8 +309,8 @@ by checking out a different revision.
>  Cutting down bisection by giving more parameters to bisect start
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> -You can further cut down the number of trials, if you know what part of
> -the tree is involved in the problem you are tracking down, by specifying
> +If you know what part of the tree is involved in the problem you are
> +tracking down, you can further cut down the number of trials by specifying
>  pathspec parameters when issuing the `bisect start` command:
> 
>  ------------
> @@ -333,12 +334,12 @@ If you have a script that can tell if the current 
source code
> is good or bad, you can bisect by issuing the command:
> 
>  ------------
> -$ git bisect run my_script arguments
> +$ git bisect run <my_script> <arguments>
>  ------------

Here, if you want to use to use the synopsis formatting, you may replace the 
verbatim block with a [synopsis] one:

[synopsis]
$ git bisect run <my_script> <arguments>


Otherwise, LGTM

Thanks.




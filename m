Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1714286
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078895; cv=none; b=DNNSJ+E7X2NvDxisOalWPP6V6v4srIQZsajVnhQqGALIkMwokDclBSZyl+JQKj1dzYfH4CrESQvz8nWOpkRfqs41hpEZbXwSj3/WeOywVNzltZnSJrgz+AN4wTA0DsoQCz8IxTh1B6ILWTOLncZd1qmlGIgxdfmZTMInaLaR0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078895; c=relaxed/simple;
	bh=qKayTf18zP+RkMUBmWJaGig1YyKpBkIu6cXNbg3wWF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw2+AW/DIAFlajHiwWFI9OPZgU6TLmp/P8G2y5BmOwFIolgS+NJcMbQ18bDldauosy67un6RJ6bB4xh2ULilg3N4S7jPtQAekDNAmKRGYqUUtaTlfBKqkZcomqt9C2By1ldVDRJeIoUUGltGAxB+jnZki0R2RO42OnYTf+Eb5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=phHDNAZK; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="phHDNAZK"
Received: from [192.168.43.16] (unknown [37.168.15.219])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 02ECC2003DA;
	Fri, 10 Oct 2025 08:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1760078890;
	bh=qKayTf18zP+RkMUBmWJaGig1YyKpBkIu6cXNbg3wWF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=phHDNAZK812jC9GRTHugBv0raFUvn5uIN+GRsI42HBXM5fFk/cKV6hSfmdsOihPYK
	 uxMJT+xlKqJPbRAxjFvNIY/6En2JNkkIbb+IQT59FlWGCwRNZ4zarZExiSoBWGGvuJ
	 ZAnlv7NicDlwSXxdWDf7HgW1u5lLLuIS1Qt15vzTaRJDvPLxdx5TEDC19/hJC2r3XI
	 /5lPkS2dxnINcYkkmDJDNyZ2NDSBkV6O4808uHE+bnS3ClNSLXIgowXWPlfHzArymN
	 TFuOsTYgzL6MoN6NN+wv300SvWXkXQXuWlec7ELZmlmYDkTMAzEqEs6KgH9etdy3ux
	 nFy4ej6pCvT1A==
Message-ID: <d0dcaea3-844f-497a-adca-6241bf39db41@free.fr>
Date: Fri, 10 Oct 2025 08:48:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <978261e3be4.1760043036.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/10/2025 à 22:53, kristofferhaugsbakk@fastmail.com a écrit :
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Convert this command documentation to the modern synopsis style based on
> similar work.[1] Concretely:
> 
> • Change the Synopsis section from `verse` to a `synopsis` block which
>   will automatically apply the correct formatting to various elements
>   (although this Synopsis is very simple)
> • Use backticks (`) for code-like things which will also use the correct
>   formatting for interior placeholders (`<orderfile>`)
> • Use backticks on options
> 
> † 1: E.g.,
>      • 026f2e3b (doc: convert git-log to new documentation format,
>        2025-07-07)
>      • b983aaab (doc: convert git-switch manpage to new synopsis style,
>        2025-05-25)
>      • 16543967 (doc: convert git-mergetool manpage to new synopsis
>        style, 2025-05-25)
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     Topic name: kh/patch-id-doc-part-one
>     
>     Topic summary: The documentation for "git patch-id" has been converted
>     to the modern "synopsis" style.
>     
>     Update git-patch-id(1) to the new synopsis style.  This is done based on
>     observing what Jean-Noël Avila has done on other documentation pages.
>     
>     I don’t know what high-level plans Jean-Noël and the maintainer have for
>     the rewrite so I don’t know if posting this update is somehow
>     inappropriate in light of that.
>     
>     § Notes to the maintainer[1]
>     
>     This depends on the topic kh/doc-patch-id-markup-fix (39969438 (doc:
>     patch-id: fix accidental literal blocks, 2025-09-29) merged into
>     v2.50.0 (because that’s what the topic is based on).
>     
>     (is there a “reference” convention for mentioning a topic + commit?)
>     
>       † 1: Inspired by
>            • <cover.1759097191.git.me@ttaylorr.com>
>            • SubmittingPatches: guidance for topic names and multi-series efforts
>              • <cover.1759873165.git.me@ttaylorr.com>
>     
>     This is part one of a multi-series effort focusing on this
>     documentation page. Technically that intent started with topic
>     kh/doc-patch-id-markup-fix, but I published that before I learned
>     about the idea presented in <cover.1759873165.git.me@ttaylorr.com>.
>     So this gets named “part one” in the cover letter (and maybe on the
>     topic name).
>     
>     The current plan for parts 2–5:
>     
>     2. Various smaller fixups (many small patches/commits)
>     3. Mention the two config variables in git-config(1)
>     4. Make it more clear that you can feed multiple diffs to this command
>     5. An “Examples” section
>     
>     Why a multi-part series?  It started with the idea of (1) emphasizing
>     that this command can take multiple patches, and (2) making an
>     Examples. But then I saw other things to fix. And they ought to go
>     first... eventually I ended up with many commits or ideas.
>     
>     I wanted to see if this was easier to review.
>     
>     • Focus on uncontroversial changes first
>     • Make all the series either small, simple/trivial, or both
>     • Leave the changes that might spark discussion last; the ones that have
>       to do with authoring new paragraphs/sections
>     
>     (I realize that multi-part series are probably mostly used for
>     super-technical changes that take 50+ patches in total and that only
>     three people on the list have the time and capacity to review at any
>     given point in time.)
> 
>  Documentation/git-patch-id.adoc | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
> index 45da0f27acd..bfbf23f49c4 100644
> --- a/Documentation/git-patch-id.adoc
> +++ b/Documentation/git-patch-id.adoc
> @@ -7,8 +7,8 @@ git-patch-id - Compute unique ID for a patch
>  
>  SYNOPSIS
>  --------
> -[verse]
> -'git patch-id' [--stable | --unstable | --verbatim]
> +[synopsis]
> +git patch-id [--stable | --unstable | --verbatim]
>  
>  DESCRIPTION
>  -----------
> @@ -21,7 +21,7 @@ the same time also reasonably unique, i.e., two patches that have the same
>  
>  The main usecase for this command is to look for likely duplicate commits.
>  
> -When dealing with 'git diff-tree' output, it takes advantage of
> +When dealing with `git diff-tree` output, it takes advantage of
>  the fact that the patch is prefixed with the object name of the
>  commit, and outputs two 40-byte hexadecimal strings.  The first
>  string is the patch ID, and the second string is the commit ID.
> @@ -30,19 +30,19 @@ This can be used to make a mapping from patch ID to commit ID.
>  OPTIONS
>  -------
>  
> ---verbatim::
> +`--verbatim`::
>  	Calculate the patch-id of the input as it is given, do not strip
>  	any whitespace.
>  +
>  This is the default if patchid.verbatim is true.

We also format config names so here `patchid.verbatim`

>  
> ---stable::
> +`--stable`::
>  	Use a "stable" sum of hashes as the patch ID. With this option:
>  +
>  --
>  - Reordering file diffs that make up a patch does not affect the ID.
>    In particular, two patches produced by comparing the same two trees
> -  with two different settings for "-O<orderfile>" result in the same
> +  with two different settings for `-O<orderfile>` result in the same
>    patch ID signature, thereby allowing the computed result to be used
>    as a key to index some meta-information about the change between
>    the two trees;
> @@ -50,7 +50,7 @@ This is the default if patchid.verbatim is true.
>  - Result is different from the value produced by git 1.9 and older
>    or produced when an "unstable" hash (see --unstable below) is


here also "see `--unstable` below"

>    configured - even when used on a diff output taken without any use
> -  of "-O<orderfile>", thereby making existing databases storing such
> +  of `-O<orderfile>", thereby making existing databases storing such
>    "unstable" or historical patch-ids unusable.
>  
>  - All whitespace within the patch is ignored and does not affect the id.
> @@ -58,7 +58,7 @@ This is the default if patchid.verbatim is true.
>  +
>  This is the default if patchid.stable is set to true.

`patchid.stable`

>  
> ---unstable::
> +`--unstable`::
>  	Use an "unstable" hash as the patch ID. With this option,
>  	the result produced is compatible with the patch-id value produced
>  	by git 1.9 and older and whitespace is ignored.  Users with pre-existing

Thanks for jumping in the synopsis squad bandwagon!

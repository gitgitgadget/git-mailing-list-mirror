Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3779EA
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593381; cv=none; b=uNrKH52dewtu1E8FWzXTrgmqNXUzH+vFzusTzKRuFdqOj0Lrx3r9V+OoAcCDFq8/pzxq3qQogO/ve29KemHCY7PZyyecprTPv2BRThnVupQGMOv4+q7vLMHP7iDqtMcJt/XvIynWed+D/R2S0nK2MqIYAoeHDL4ayVDvywyhbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593381; c=relaxed/simple;
	bh=dJfWY3RK7T76rOqzqfGtyiJskZcCSLMyr4Rvr8STRcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDUhc8wC2ojmw1Nbw3eWs8RvEbiqx3Yywv3ilsMQT8pY1IinveBNPmIp3GtSOhBNsLl6SPKNz+DTYv4+ieTmTV7MB90BQR7e17A4O33Rkf0UH7n9B/EoR7baT8dLqkch7z+wt/y1aZY1+3aEQ9Ba1q28AU8ydON54tin/1t01sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XrN54tWG; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XrN54tWG"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id C9DB54C953
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 10:08:03 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:efe2:1aa5:9f41:6f3a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 45CCA780371;
	Thu, 22 Feb 2024 10:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708592876;
	bh=dJfWY3RK7T76rOqzqfGtyiJskZcCSLMyr4Rvr8STRcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrN54tWGAAMyNExLpK+JyisKiPRD3IYK14MsfV3FkmKiYLqim+AEleluDeUKKaShn
	 LTs/MKlTdYkV8h7xjhEZFux1foo7MzgRN0IDZNCCZCOpZw+gvD+2WBAKKoGS/pSwWX
	 Nx+Z3GwJNY3G6o61cS0og97MPjYYHGTiDv5ZWr0Wqvvr+STrAo/nbdgeSVI2s4hMEr
	 G0FYV1JYvS7ITpI8yyFNuFPTC5Ri2iMUZ++FyaJCt9zKWNf42F5HvOhWlCPPajpY16
	 s4a/UK6cyecngo34TWeqCBdFG7fUYwkCjHjWtILlvMVM/d3OMmdAE20O8Ab7MerCOU
	 B3/5nvgq0J5Tw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject:
 Re: [PATCH 1/3] doc: git-rev-parse: enforce command-line description syntax
Date: Thu, 22 Feb 2024 10:07:53 +0100
Message-ID: <2926790.e9J7NaK4W3@cayenne>
In-Reply-To: <xmqqbk89molz.fsf@gitster.g>
References:
 <pull.1670.git.1708468374.gitgitgadget@gmail.com>
 <xmqqfrxlpvv1.fsf@gitster.g> <xmqqbk89molz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 21 February 2024 23:36:24 CET Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Backticks and single quotes are used indistinctively (by the way,
> >> asciidoctor does not process single quotes as markup) ...
> 
> Hmph, it sounds like a bug of asciidoctor we'd need to work around?
> 
> In any case, I practiced your "_<placeholder>_" rule on git-add.txt
> and here is how my local HTML rendition of the updated line in the
> first hunk in the attached patch looks like with "AsciiDoc 10.2.0".
> 
>     https://pasteboard.co/6koO0h0KJAjW.png
> 
> The actual HTML for the above part looks like this:
> 
>     <div class="paragraph"><p>For more details about the
>     <em>&lt;pathspec&gt;</em> syntax, see the <em>pathspec</em> entry
>     in <a href="gitglossary.html">gitglossary(7)</a>.</p></div>
> 
> In the first hunk, the updated "_<pathspec>_" is enclosed inside an
> <em>..</em> pair, which is made into "font-style: italic" via css,
> while 'pathspec' that remains is already inside <em>..</em>.
> 
> By the way, I am getting some typesetting effect from the pair of
> single quotes with AsciiDoctor.  Here is the rendition of the same
> part:
> 
>     https://pasteboard.co/LbDi95G8BNGv.png
> 
> The <meta name="generator"> element in the generated HTML claims it
> is "Asciidoctor 2.0.20".  The actual HTML for that piece looks like
> this:
> 
>     <p>For more details about the <em>&lt;pathspec&gt;</em> syntax,
>     see the <em>pathspec</em> entry
>     in <a href="gitglossary.html">gitglossary(7)</a>.</p>
> 
> So, perhaps we do not have to do a lot of 'word' -> _word_
> replacements, hopefully?
> 

Asciidoctor tries to "normify" the asciidoc format (https://asciidoc-wg.eclipse.org/projects/) and pushes for deprecating the 'word' markup which 
is a  asciidoc.py legacy.

See https://docs.asciidoctor.org/asciidoctor/latest/migrate/asciidoc-py/
#updated-and-deprecated-asciidoc-syntax

In the transition period (which is lasting), they introduce a compatibility 
mode with the compat-mode flag in order to support legacy content.

For all I know, asciidoc.py has entered a maintenance stage where it will not 
support the evolutions of the standard. Should the Git documentation migrate 
to asciidoctor and drop the compat mode is an open question. At least, we 
should try to stick as much as possible to the common markup _ for emphasis. 
This would have the added benefit of differentiating single quotes from 
backticks, because single quotes would completely disappear in the end, except 
when a real single quote is needed.

 For the migration to "standard" asciidoc, I would also recommend using "=" 
prefix for titles instead of underlines which require changing two lines when 
modifying  a title and are a pain for translators in languages with variable 
width characters.


> ----- >8 --------- >8 --------- >8 --------- >8 ----
> 
> Subject: [PATCH] doc: apply the new placeholder rules to git-add 
documentation
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index ed44c1cb31..b73071ba47 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -63,7 +63,7 @@ OPTIONS
>  	to ignore removed files; use `--no-all` option if you want
>  	to add modified or new files but ignore removed ones.
>  +
> -For more details about the <pathspec> syntax, see the 'pathspec' entry
> +For more details about the _<pathspec>_ syntax, see the 'pathspec' entry
>  in linkgit:gitglossary[7].
>  
>  -n::
> @@ -119,10 +119,10 @@ apply to the index. See EDITING PATCHES below.
>  -u::
>  --update::
>  	Update the index just where it already has an entry matching
> -	<pathspec>.  This removes as well as modifies index entries to
> +	_<pathspec>_.  This removes as well as modifies index entries to
>  	match the working tree, but adds no new files.
>  +
> -If no <pathspec> is given when `-u` option is used, all
> +If no _<pathspec>_ is given when `-u` option is used, all
>  tracked files in the entire working tree are updated (old versions
>  of Git used to limit the update to the current directory and its
>  subdirectories).
> @@ -131,11 +131,11 @@ subdirectories).
>  --all::
>  --no-ignore-removal::
>  	Update the index not only where the working tree has a file
> -	matching <pathspec> but also where the index already has an
> +	matching _<pathspec>_ but also where the index already has an
>  	entry. This adds, modifies, and removes index entries to
>  	match the working tree.
>  +
> -If no <pathspec> is given when `-A` option is used, all
> +If no _<pathspec>_ is given when `-A` option is used, all
>  files in the entire working tree are updated (old versions
>  of Git used to limit the update to the current directory and its
>  subdirectories).
> @@ -145,11 +145,11 @@ subdirectories).
>  	Update the index by adding new files that are unknown to the
>  	index and files modified in the working tree, but ignore
>  	files that have been removed from the working tree.  This
> -	option is a no-op when no <pathspec> is used.
> +	option is a no-op when no _<pathspec>_ is used.
>  +
>  This option is primarily to help users who are used to older
> -versions of Git, whose "git add <pathspec>..." was a synonym
> -for "git add --no-all <pathspec>...", i.e. ignored removed files.
> +versions of Git, whose "git add _<pathspec>_..." was a synonym
> +for "git add --no-all _<pathspec>_...", i.e. ignored removed files.
>  
>  -N::
>  --intent-to-add::
> @@ -198,8 +198,8 @@ for "git add --no-all <pathspec>...", i.e. ignored 
removed files.
>  	unchanged.
>  
>  --pathspec-from-file=<file>::
> -	Pathspec is passed in `<file>` instead of commandline args. If
> -	`<file>` is exactly `-` then standard input is used. Pathspec
> +	Pathspec is passed in _<file>_ instead of commandline args. If
> +	_<file>_ is exactly `-` then standard input is used. Pathspec
>  	elements are separated by LF or CR/LF. Pathspec elements can be
>  	quoted as explained for the configuration variable `core.quotePath`
>  	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
> 
> 

This looks good to me. 




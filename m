Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220C41C71
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969000; cv=none; b=p8czrsaMxoIZlsb2fnir0hBRdcX1SA1vTisJG/zJXzZHw3iJR7nV9pgEue3BPGIoi2bIg2+3nqVlqBudz9s/JdgVPBtKPQyKuOr+E6MRDhYBBo9QMZsN8jaUuTqdkq5YA4pxjNCf5YCliEfAcgVNQFJfrZC6QxwGeWbrTAnCTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969000; c=relaxed/simple;
	bh=quOlD03/F2H0Q9cTwt0c9zihqcPtJZnE0cHVDDVgZ0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiXhJHNBpqsyHpygFBG3JWj6p5KzMROed4/YKz8n6ql641SC7GEqsgljbUCioA6Vo5Q90ScwBZYrQnzWzpR2IGz94DYb3HP7Rys+FqAiYg31u+4Lb8d6a9ufvzdhjsRRywN8yA5CIqOAvUFr+wYlPYs9YAPCqrBVn6D2QMA4Sf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ib7v6dfX; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ib7v6dfX"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1W0AuYrgmbpaN1W0BupkQI; Sun, 06 Apr 2025 20:49:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968996; bh=B4TaDlh+a1JXyhAghQ0jEg2K58yP+9+mc2S8zq2yk98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ib7v6dfX3TSofPwdaw5dhdOVjyOsAdgw0PE+XzpMHCWmWIFhleXV6jgyuh5S/yRt6
	 Bs0/NK9xZvQbf8DdHx2YKDcygN9U7yQ5oWDP1ozCIIiwwVxbpzQHzUK56x4utChqyO
	 Z4dB4y9UTF0SHVm/xfzYkW8SoI84ePR18JypKwaasn1oGLWcgVXN2sln5XSYuN1vmi
	 bth44yiR6AkYpltxdVAvx8y8+g/qpRWgobimZz6wCIyz2Cw5a71C51kDLI9cgKJEZQ
	 wl2+P7Ko33RiMYnlqPYKU+kanHR2H38+BvQTHSXjPW6HcH2lpTiK/XZTjpavc5OD+C
	 Pi31Ka6Ign6OQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2dae4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=r1G5dvt-5keOLTON_isA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com>
Date: Sun, 6 Apr 2025 20:49:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] meson.build: only set build variables for
 non-default values
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMJk5QllvKAc8/o2uKqXTmwCq9jiUftHkZ6XgBb8Ak1zGke25Uo7JhqlTZWFBuD9B2vGYtIPkUGLzVu1u3Fdo3YDUG4uIjBf+naImrKQyyb/eZiZzMmh
 wNj3fwIMrpd+1c9EMOLkoAqyRqMsKj9oQjXl9Wwe68xW9BRNPugx9FKImAmdqkDtJYbgMSrwapnicroHNsuOM0JzySrfcVVdgpY=



On 06/04/2025 20:38, Ramsay Jones wrote:
[snip]
> diff --git a/meson.build b/meson.build
> index 88a29fd043..efd0bd3319 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -693,10 +693,8 @@ endif
>  # These variables are used for building libgit.a.
>  libgit_c_args = [
>    '-DBINDIR="' + get_option('bindir') + '"',
> -  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
>    '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
> -  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
>    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
> @@ -708,6 +706,17 @@ libgit_c_args = [
>    '-DPAGER_ENV="' + get_option('pager_environment') + '"',
>    '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
>  ]
> +
> +editor_opt = get_option('default_editor')
> +if editor_opt != '' and editor_opt != 'vi'
> +  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> +endif
> +
> +pager_opt = get_option('default_pager')
> +if pager_opt != '' and pager_opt != 'less'
> +  libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
> +endif
> +
>  libgit_include_directories = [ '.' ]
>  libgit_dependencies = [ ]
>  


It would be somewhat remiss of me to not mention here that this does not
work for any but the simplest of values! :( If you set a simple single
'bareword' like 'vim' or 'more' (even '~/bin/vi') then every thing works
just fine. However, if the value contains any of (at least) the following
characters: single quote, double quote or backslash, then things
stop working!

[I spent one whole evening (and a bit - always something else to 'try')
trying to 'fix' this problem, without success]

If you try an example that is given in the Makefile:312, then the make build:

  $ make V=1 DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork' all doc >m-out 2>&1

passes the folowing arguments to (respectively) gcc and asciidoc:

  -DDEFAULT_EDITOR='"\"C:\\Program Files\\Vim\\gvim.exe\" --nofork"'
  -a 'git-default-editor="C:\Program Files\Vim\gvim.exe" --nofork'

whereas, the meson build:

  $ meson setup --optimization=2 -Ddocs=man,html -Ddefault_editor='"C:\Program Files\Vim\gvim.exe" --nofork' -Ddefault_pager=more -Dprefix=$HOME -Dpcre2=disabled build/
  The Meson build system
  ...
   User defined options
      optimization  : 2
      prefix        : /home/ramsay
      default_editor: "C:\Program Files\Vim\gvim.exe" --nofork
      default_pager : more
      docs          : man,html
      pcre2         : disabled

  Found ninja-1.11.1 at /usr/bin/ninja
  $ 

similarly, passes the folowing arguments to (respectively) gcc and asciidoc:

  '-DDEFAULT_EDITOR=""C:\\Program Files\\Vim\\gvim.exe" --nofork"'
  '-agit-default-editor="C:/Program Files/Vim/gvim.exe" --nofork'

If you now attempt a 'meson compile' it will, of course, fail to compile
editor.c because the DEFAULT_EDITOR is the empty string ("") followed by
(C:\\Program Files\\Vim\\gvim.exe" --nofork").

Also, note that the directory seperators have changed from \\ to / in the
argument to asciidoc.

[Again, spelunking the docs for meson, it said that "if you want quotes, you
will have to do it yourself"! ;) ]

OK, so I couldn't come up with any incantation which would fix this issue.
I will have to admit defeat and ask someone who actually knows meson to
fix it. :(

Thanks.

ATB,
Ramsay Jones




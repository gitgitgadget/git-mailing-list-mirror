Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3024677B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603930; cv=none; b=utkoiDTqNtn7jyCK6TDqxvkQC7xTzocp0Hrn/V5m1SZJH9C7yowF+vjbx9rJa6Jb344Y6LYFylCud6pHOz4+2cCgS5yH7zJUQ6/Nd4KZFnFDiBajOVHkzybeByb5sAQgJzggQVGJh621Q0t2Hcvpan6yR3p3ZFIBp08cjU4v5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603930; c=relaxed/simple;
	bh=yiDuCoc1H530WhRibLCKHJJ3wk7UPQs9sVpaQby9vfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aExMOnW1jk3UqhvAQ+7UQv9N+BXh6D5m/2H6ecBoqZeWcil7IzUI+Z79+NaCJRtFeoxgOAYWNb/QzuGQVUUP7wSAtHf1nn1PGbDBn4xoD5dkUX2PeUA6seKW2PQkAeBoTrP8VS7YxPZLv+iR4DbUkvwUL2Y9JOI5Kjo9HkeBPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy8tB+Zt; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy8tB+Zt"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-610cbca60cdso3083919eaf.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752603928; x=1753208728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pce7SH4EmBnxxSrpkRuFrQuLao3Mb+YqNEx/TshDFfU=;
        b=Sy8tB+ZtK9PoRSyRHs49jfAOPBXADu+0PxQGMjqkIXOlGpIG0KQjXhqECSYNcpMmgr
         wdkXuR4mPAxUZw4MfBVUCpLpLdJ6F6345Rv3C4Zxe1JWdKXgTQTviVqlNIQdQ1CR/TSj
         Ln/yFt5rWcddCfwdrAQT6DRTw2ds35fqku0GlSXVNM+KiyCgKmQ3HSDBZ7F7xHmiF2Xq
         zwAIy6TRg+T0/MsLNbFrzxb3swJPk1Vnwj3szaaCiPBRWXUTH6Ipfya26I2Xl69sdiCe
         W3486czFRUa0dRjgbbsEV/sL42bYYNAdmqL4gwlYV5iP8cIqmFsCaLx6EQG4QnZa8ZMs
         cSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603928; x=1753208728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pce7SH4EmBnxxSrpkRuFrQuLao3Mb+YqNEx/TshDFfU=;
        b=ga4jUE3eRhkhb8N6fMDFEpOZfFe1eEDpowm2jU70NF62JkeTIUREAarB8wMcWMcdpS
         zd7iT8FDG/uv38/47dPl27NXZSgj/gpCdQvdyz2BYEWJIkN/ZpJ9/Ayo5q2JPZZYGc3m
         0lkM5mIJW16MMxOgIZ4zgs3suZcrPvcU2rLSfr2LT29K0s8SllkandbhwshnsCEVmaRS
         DdamW42X6eRE3baGmdImeL2GNl95z1b9L1x7uZHqNe8Bdgz41JyE/73TtTk7t8v3GvwR
         Rq8t84cv/b1r0t6doeHZ72BuZ4G38WXAkvQvod1bVNHWJIs9lHzh/Exln4UfVthwEkiS
         4Dsg==
X-Gm-Message-State: AOJu0YzZ4GDNsTiQpi8iY9CoxFyIh+FRW+4PVpkuevd+P49qTAuQ9J28
	oIGaQSmz/EcaSWdzYFpmqLoPvU6HIp0KpyF/x/Flz0BBN3IgazmbHFAX
X-Gm-Gg: ASbGncsqt4J6Scey4Gpl5ud87hjQVsw/ZneYBIotsez09k57NxBgbyQVKjD0N+h0ZKN
	2MS+3bYot4OoZZFimTc+tXTZFi/yZTFVI1RB1RAl2bCGCY+/wh3HYFrjoWc6vWrZLscmkokOdRu
	aL4/uY0RYh9tYh7DC+zehBfePumgqy+egBD0kIfHpD8Xn1wwmGIOjiLZyGMnZVmhWsBpwACbtkp
	KJqjJH0g2QAdSZ5jYGfvbefJCuFIoHkZzw2TeFY+FHQEBGBDwFaN+GpLTGNBOF64IgtNfLiWnvi
	nVIM096bpxC3SBgduwIDLPWLtv9A+31XRC805qtMipTt9v07YJXZjzMo1OdMnes5y6gYlP0cyPy
	Afj5MyNGIaJqb9HQ=
X-Google-Smtp-Source: AGHT+IHA4ZBzmZvsCI4HuXibV02n7adM1OTr1lP+c6Rx1fPPx53l6k5vsVX6+2hhrtkqxjSUZVMF1g==
X-Received: by 2002:a05:6820:2004:b0:615:92de:5435 with SMTP id 006d021491bc7-6159fde0eb8mr373220eaf.2.1752603927677;
        Tue, 15 Jul 2025 11:25:27 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12a6340sm2339788a34.54.2025.07.15.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:25:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:19:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
Message-ID: <4z7ho6hg347j425mzkgueywwptynk3fgj5mmmtkua4zbkprvui@taqrlenltxkb>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714235231.10137-2-lucasseikioshiro@gmail.com>

On 25/07/14 08:52PM, Lucas Seiki Oshiro wrote:
> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name says. Over time,

s/says/suggests/

> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriated command

s/appropriated/appropriate/

> to place them.
> 
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics), returning them in a machine readable format
> following the syntax "field<LF>value<NUL>".
> 
> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
> 
> Also add entries for this new command in:
> 
> - the build files (Makefile, meson.build, Documentation/meson.build)
> - builtin.h
> - git.c
> - .gitignore
> - command-list.txt
> - Documentation
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore                  |  1 +
>  Documentation/git-repo.adoc | 54 +++++++++++++++++++++++++++++++++++++
>  Documentation/meson.build   |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/repo.c              | 38 ++++++++++++++++++++++++++
>  command-list.txt            |  1 +
>  git.c                       |  1 +
>  meson.build                 |  1 +
>  9 files changed, 99 insertions(+)
>  create mode 100644 Documentation/git-repo.adoc
>  create mode 100644 builtin/repo.c
> 
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..1803023427 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -139,6 +139,7 @@
>  /git-repack
>  /git-replace
>  /git-replay
> +/git-repo
>  /git-request-pull
>  /git-rerere
>  /git-reset
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> new file mode 100644
> index 0000000000..6f8fe3f6ea
> --- /dev/null
> +++ b/Documentation/git-repo.adoc
> @@ -0,0 +1,54 @@
> +git-repo(1)
> +===========
> +
> +NAME
> +----
> +git-repo - Retrieve information about a repository
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git repo info [<key>...]
> +
> +DESCRIPTION
> +-----------
> +Retrieve information about the current repository in a machine-readable format.
> +
> +`git repo` will be the primary tool to query repository-specific information,
> +such as metadata that currently can also be done by calling `git rev-parse` (see
> +linkgit:git-rev-parse[1]). `git repo` doesn't query information unrelated to the
> +current repository or that is already retrieved by a specialized command, for
> +example, `git config` (see linkgit:git-config[1]) or `git var` (see
> +linkgit:git-var[1]).
> +
> +This command returns the retrieved data following a null-terminated format with
> +this syntax:
> ++
> +----------------
> +key1<LF>value1<NUL>
> +key2<LF>value2<NUL>
> +...
> +----------------

Being that this patch doesn't yet implement any output for the command,
maybe should should hold off on specifying the format.

In other commands, it is common to see a nul-terminated format toggled
behind a `-z` flag. We may want to do something similar here as opposed
to being the default.

-Justin

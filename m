Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2438301126
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477001; cv=none; b=oUmlXKClv1pT7Ggx+yHWK9g94HBRb+Sjru5xZucv+kvlpZFAGXUHNZ/q4a/AogwxCFacrYyi+Zm4PlT88XDUoiNkE3c9M1gto16MEmGojoKZ2YaQuMUxJKhIipk1a55TO4fpKBluzdyXUWCV/0g5TLPOcwN8p24aKZpsN9ZuyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477001; c=relaxed/simple;
	bh=RiaXcwqwoChEzE4SWsVZDtrjwU+udDPSOPRDkSbU9ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVQXA2KkRMikOlKwhS6PaqcDs/kWI84oYrrTJMJBmhwBKgKlm2gqLWBVOC/8PIi1Uv4U5skcg00VliEUqLLVf8vuBaN/IH1hq4Lrq5+U/iZE72Y/f0eFGRe7OTGrBq78/+3+X6p24dv0aVd46hpa6UrokLlyqF89p7qjbPlPE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzc0/QZg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzc0/QZg"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c14138668so2258838a34.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476999; x=1752081799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwkHEMIT7i5+KZovKpCC2tumjAJIzps5ZnSzQ6KZhvQ=;
        b=Yzc0/QZg2UY34ZQzyt54xjQM0PnytVbeH28t0cXUDaOTCOOtFcSpHFrIm2Si64mE/+
         KCKYanH2z9oimRK6B+cOJt57tl35MPX+i6CFspWn0xE9bJU1yNLi81ydPcBYsI7vt7o7
         i++iilOKqbd6wZklLbogWrQIn+AHMY+yYo2nBkoODSKZnPSJ/WrlGYKM7jQmJqZo+PnS
         Ac6kVBY6+y3WC32f9JVdl37ZCK1uqRvjv31A2C5lGQ2e5p0J7ZvsN/t7NF8igOwdfC5K
         TJUB757AG4YrV4yA6Kn+oSL+9DnbRg5urMzgRCxHUpbTiclpU+ZdhC88PKIX2x0vnu9A
         hJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476999; x=1752081799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwkHEMIT7i5+KZovKpCC2tumjAJIzps5ZnSzQ6KZhvQ=;
        b=VHSpfltke5+G6JYqKaDelhq28uxyjLukNiPfqMZ5e3GfFcDOhdRmetOEL5xOSSNHkC
         adO9ED5bOaDJMoguDJf7b3SKCGjG3Zwmh6vj9CACVk6mgVKBVaFQqENkC/gybjTRxDVA
         4eSiKnqcgR2b6wD1iXAFkHWJxt1uHQq9HCFPMDuPh6TbUmmXGhDR9bOcdrlAf66ioc4W
         u+d/C+z0WB5ZcQ5VQFUiS0Zgz78TQdhchjXENmLNkA7xjEzcOekpttiVV24S3vvW3QZQ
         m749kEekoNGaJdT/CGl1u3k6Xb/Fk61xQGMs9klxs8aR96M2yNF5D8Y9nfzpEqkQ1GoJ
         rHGg==
X-Gm-Message-State: AOJu0YyA38P6suJL4AJiyRzfG3y88qMGOjJKwLSh77ERUBpyKmX6HhGr
	i/qrztTYb11VebwoE3ISap651y8up8I/RzjyqeEtlLkuwnmro7k8w3sL
X-Gm-Gg: ASbGnctODSFAzbVcLZADhNr/KBixVEUE65fIbjxKEoujzYsPYC8IMpYoe9AzB6bquJc
	VYhMhlNdO1XApyMpELPy1vHc807Tj0lkHIJeJbPZ+Cub3BsXmxDRri3zTLgJ0Ow7f/0Yda1VWYj
	jLhwNYy1kE71xlQSkUMoMID8NmauO5vVnLuImme2Faugw1RkGXZSNniVzz+SpyeCNzcdAQl8mGY
	gO0AOZo2hEc++pqSS2PJ9PgkDGe7f6hO3qYS3LmFwn8UlmWJSjmcAFR6IKhtTm6ExDARHz0isnw
	DwyussO2ZAN8spGEUxvNB0OLAFczHGFwvRvbLcz1RQIJlKIkrMfDpn4=
X-Google-Smtp-Source: AGHT+IEt1W7LF1Ym+qgBIa3XwO40a68LXu75dl4ks9fYuR6u+ctH+/RrorMR4sfqNdhSwulz/Mkm5A==
X-Received: by 2002:a05:6830:3c08:b0:73a:8bf8:56b4 with SMTP id 46e09a7af769-73c897893f3mr184464a34.13.1751476998712;
        Wed, 02 Jul 2025 10:23:18 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73afb0e2f7bsm2575722a34.41.2025.07.02.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:23:18 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:17:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Karthik Nayak <karthik.188@gmail.com>, K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, 
	ryenus@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Message-ID: <q6zyvqpyxobtp65ptrmkdg3kvc2plxmsltaurqf52hglitikir@5p5jpcqc577o>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
 <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>

On 25/07/02 12:14PM, Patrick Steinhardt wrote:
> The "reftable" format has come a long way and has matured nicely since
> it has been merged into git via 57db2a094d5 (refs: introduce reftable
> backend, 2024-02-07). It fixes longstanding issues that cannot be fixed
> with the "files" format in a backwards-compatible way and performs
> significantly better in many use cases.
> 
> Announce that we will switch to the "reftable" format in Git 3.0 for
> newly created repositories.
> 
> This switch is dependent on support in the larger Git ecosystem. Most
> importantly, libraries like JGit, libgit2 and Gitoxide should support
> the reftable backend so that we don't break all applications and tools
> built on top of those libraries.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.adoc | 39 ++++++++++++++++++++++++++++++++++++++
>  setup.c                            |  6 ++++++
>  t/t0001-init.sh                    | 16 ++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index c6bd94986c5..c96b5319cdd 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
>  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
>  
> +* The default storage format for references in newly created repositories will
> +  be changed from "files" to "reftable". The "reftable" format provides
> +  multiple advantages over the "files" format:
> ++
> +  ** It is impossible to store two references that only differ in casing on
> +     case-insensitive filesystems with the "files" format. This issue is
> +     especially common on Windows, but also on older versions of macOS. As the
> +     "reftable" backend does not use filesystem paths anymore to encode
> +     reference names this problem goes away.

I believe even modern macOS by default uses a case-insensitive
file-system. Maybe we should instead say:

  This limitation is common on Windows and macOS platforms.

> +  ** Similarly, macOS normalizes path names that contain unicode characters,
> +     which has the consequence that you cannot store two names with unicode
> +     characters that are encoded differently with the "files" backend. Again,
> +     this is not an issue with the "reftable" backend.
> +  ** Deleting references with the "files" backend requires Git to rewrite the
> +     complete "packed-refs" file. In large repositories with many references
> +     this file can easily be dozens of megabytes in size, in extreme cases it
> +     may be gigabytes. The "reftable" backend uses tombstone markers for
> +     deleted references and thus does not have to rewrite all of its data.
> +  ** Repository housekeeping with the "files" backend typically performs
> +     all-into-one repacks of references. This can be quite expensive, and
> +     consequently housekeeping is a tradeoff between the number of loose
> +     references that accumulate and slow down operations that read references,
> +     and compressing those loose references into the "packed-refs" file. The
> +     "reftable" backend uses geometric compaction after every write, which
> +     amortizes costs and ensures that the backend is always in a
> +     well-maintained state.
> +  ** Operations that write multiple references at once are not atomic with the
> +     "files" backend. Consequently, Git may see in-between states when it reads
> +     references while a reference transaction is in the process of being
> +     committed to disk.
> +  ** Writing many references at once is slow with the "files" backend because
> +     every reference is created as a separate file. The "reftable" backend
> +     significantly outperforms the "files" backend by multiple orders of
> +     magnitude.

The examples above do a good job at explaining individual technical
benefits. I do wonder if we should include a more general statement
aimed at users as to why the change to reftables is beneficial. Maybe
something like:

  The reftables backend addresses several performance concerns as the
  number of references scale in a repository. 

> ++
> +A prerequisite for this change is that the ecosystem is ready to support the
> +"reftable" format. Most importantly, alternative implementations of Git like
> +JGit, libgit2 and Gitoxide need to support it.
> +
>  === Removals
>  
>  * Support for grafting commits has long been superseded by git-replace(1).
> diff --git a/setup.c b/setup.c
> index f93bd6a24a5..3ab0f11fbfd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2541,6 +2541,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  			repo_fmt->ref_storage_format = ref_format;
>  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
>  		repo_fmt->ref_storage_format = cfg.ref_format;
> +	} else {
> +#ifdef WITH_BREAKING_CHANGES
> +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
> +#else
> +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_FILES;
> +#endif

Ok so now when we build with `WITH_BREAKING_CHANGES` the default
reference format is changed to reftables.

>  	}
>  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
>  }
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f11a40811f2..e0f27484192 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -658,6 +658,22 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'default ref format' '
> +	test_when_finished "rm -rf refformat" &&
> +	(
> +		sane_unset GIT_DEFAULT_REF_FORMAT &&
> +		git init refformat
> +	) &&
> +	if test_have_prereq WITH_BREAKING_CHANGES
> +	then
> +		echo reftable >expect
> +	else
> +		echo files >expect
> +	fi &&
> +	git -C refformat rev-parse --show-ref-format >actual &&
> +	test_cmp expect actual
> +'

And here add a test to verify this change. Looks good :)

-Justin

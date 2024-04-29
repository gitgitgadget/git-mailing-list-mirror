Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8741E888
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431238; cv=none; b=UQ3RqELCs3CN1nKve6a2j8Oz+kxQPmoZlrG2OQU2Q2PyVQJTrMLLNJX05yFlUFp/hQ5zaK9XfHuBosAttgRXiUN7WYISYJ6yCAnLyRzxV9MrRuMaYUG90wX8PCfb8DV79N2Glm9pEIWSDyQf2FuzJnMcyDTrbt+0S2J5VhM8Qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431238; c=relaxed/simple;
	bh=/5WcpeQG+8aaebs79Oqq1flGcdr+0anV8NKHabhQKaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtJs1UDJjjJnUs/O6oQuwXpTsnYg9tOVf0VeRE5E6Na+RFlKOUC9Y5lyCfb6LrLwTB0FtMBexjiyeRao+Wg/ijVng7CZI8R+qZuZlgjho+Cx5ph/GT2kNqTmBS++ycJJAROmBidyks7CZDMe03P8sifQRl/ijCloWYRGjYHovM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4EZdn+v; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4EZdn+v"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c7510d1bacso3059014b6e.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714431236; x=1715036036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUbuZa9jBgWlTys0CGylak6zaI5CjYiRw4gvHBPC+NA=;
        b=I4EZdn+vrDjybru+EiiLXNCy7mTqVXX+fQWHHuTJaeO4oG5ktkbA/cgQanMVvSw3WP
         eaEiTtY+0QnnUqsayO7f9sOy/SUofXw5Km5E3HM8ITPMz/BlvyD4yjd0HC78bRnn79jJ
         U2O8bsp3UhHDSNmVW6kag+NmQsV4mx8RttyhtKbj/o/n2vTRKx79Nhd+Bfab3pbSxhnR
         avGsBhqJ28XeVTf34iprfvyZjj+cc2P7YyiN1LtSDMivmKQzTU6ngiXTKXJ1UHFDVg7/
         emNiFpXIPUxD9Ae8Zw0s69utQAI++xTrb0XccaHJTWoAkxhR/rCFsMwm4bj5t4CydTD6
         5vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431236; x=1715036036;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUbuZa9jBgWlTys0CGylak6zaI5CjYiRw4gvHBPC+NA=;
        b=ZmNZAvhWhVR8UdJ04QnArrn61/Tl/DBFiC084cPFsQwQ5xH5kbiDfa1KpoBAsVd9hF
         2VLasm5zd3o7HyGozrtLMXKjnB9EK8O/bCOdVkBkLKtVivaNuH+lXQdZ+DV3cM+z4Azs
         ZMPxfSoFxG/jpB8slQS/Q49I0AB0bwV60mL3iFgaklD3rufIwt8gJ/M9/YVz7WZ2jWhc
         Qze/B9ldvMCdhkosYsu982ftoj6gKponNE9SV7gleHitIbuRXLsWCXQO94emMMGK8DUH
         kUO49FVULBmanNSOc5FiGURdCUfs+uKjcUjAePeWKT0ZiVBSr96fq/HElndIhRBJsAWx
         kgtQ==
X-Gm-Message-State: AOJu0YzCCkejh51qWRLSr/BV1rERLnfIBGzlTuVK0DuAJeGIvovCDxKn
	DrAfayPzrK2/HjLgc1EyVobdl+vyzH8f7mtq2dvb83ds/rgjji5yEwYCzztJ
X-Google-Smtp-Source: AGHT+IHNOQ6vFfCPzZ+qM/Dx22QfdXlIXawd6eT43CrQ8KJ4hsrkLYkTnQMl6mPqtRXqBBZX04be1Q==
X-Received: by 2002:a05:6808:2882:b0:3c8:4948:ee2b with SMTP id eu2-20020a056808288200b003c84948ee2bmr14058496oib.5.1714431236585;
        Mon, 29 Apr 2024 15:53:56 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id m13-20020a05680806cd00b003c74efff6bfsm2867744oih.31.2024.04.29.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:53:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 17:52:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <5322n7eqkov3fqw2zw2seiqyqcmmrlo35camq76n546dkgycru@njuj32gmbogh>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>

On 24/04/29 03:41PM, Patrick Steinhardt wrote:
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index d71b199955..4275918fa0 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -497,20 +497,28 @@ exclude;;
>  	unusual refs.
>  
>  [[def_pseudoref]]pseudoref::
> -	Pseudorefs are a class of files under `$GIT_DIR` which behave
> -	like refs for the purposes of rev-parse, but which are treated
> -	specially by git.  Pseudorefs both have names that are all-caps,
> -	and always start with a line consisting of a
> -	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> -	pseudoref, because it is sometimes a symbolic ref.  They might

We remove the example here about HEAD not being a pseudoref. This
example seems helpful to indicate that a pseudoref cannot be a symbolic
ref. Is this no longer the case and the change intended?

> -	optionally contain some additional data.  `MERGE_HEAD` and
> -	`CHERRY_PICK_HEAD` are examples.  Unlike
> -	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
> -	be symbolic refs, and never have reflogs.  They also cannot be
> -	updated through the normal ref update machinery.  Instead,
> -	they are updated by directly writing to the files.  However,
> -	they can be read as if they were refs, so `git rev-parse
> -	MERGE_HEAD` will work.
> +	Pseudorefs are references that live in the root of the reference
> +	hierarchy, outside of the usual "refs/" hierarchy. Pseudorefs have an
> +	all-uppercase name and must end with a "_HEAD" suffix, for example
> +	"`BISECT_HEAD`". Other than that, pseudorefs behave the exact same as
> +	any other reference and can be both read and written via regular Git
> +	tooling.

Pseudorefs behaving the same and using the same tooling seems to
contridict the previous documentation. I assume the previous information
was out-of-date, but it might be nice to explain this in the message.

> ++
> +<<def_special_ref>,Special refs>> are not pseudorefs.
> ++
> +Due to historic reasons, Git has several irregular pseudo refs that do not
> +follow above rules. The following list of irregular pseudo refs is exhaustive

We seem to be inconsistent between using "pseudoref" and "pseudo ref".
Not sure it we want to be consistent here. 

-Justin

> +and shall not be extended in the future:
> +
> + - "`AUTO_MERGE`"
> +
> + - "`BISECT_EXPECTED_REV`"
> +
> + - "`NOTES_MERGE_PARTIAL`"
> +
> + - "`NOTES_MERGE_REF`"
> +
> + - "`MERGE_AUTOSTASH`"
>  
>  [[def_pull]]pull::
>  	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
> diff --git a/refs.c b/refs.c
> index c64f66bff9..567c6fc6ff 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -905,6 +905,8 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
>  
>  	if (!is_pseudoref_syntax(refname))
>  		return 0;
> +	if (is_special_ref(refname))
> +		return 0;
>  
>  	if (ends_with(refname, "_HEAD")) {
>  		refs_resolve_ref_unsafe(refs, refname,
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 948f1bb5f4..8c92fbde79 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -52,6 +52,23 @@ test_expect_success '--include-root-refs pattern prints pseudorefs' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--include-root-refs pattern does not print special refs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		git rev-parse HEAD >.git/MERGE_HEAD &&
> +		git for-each-ref --format="%(refname)" --include-root-refs >actual &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		$(git symbolic-ref HEAD)
> +		refs/tags/initial
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success '--include-root-refs with other patterns' '
>  	cat >expect <<-\EOF &&
>  	HEAD
> -- 
> 2.45.0-rc1
> 



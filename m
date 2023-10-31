Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AE2032C
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="MPOhR0Nz"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1BD77
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 10:06:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-694ed847889so5215598b3a.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1698771987; x=1699376787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyqmAcSN2PKtF0+3dN6liYrrDauDlreyEGWUWcbg92s=;
        b=MPOhR0NzEAGr1PfqaIQ73FJAh8bIF1NdYJH43oCbkNF1H7jvUqXSsB9UL9bchAGjx9
         AAiIpWXW7GRyeWIwwjNuCNyGmeCWSOZF0kFZ1bLpoCFbGEQYdHdCEQvil32uNJwyIbTj
         dppEeRzHow5+aF5BmgKcW0jZ0xv7FCthJRHP4DGgnj0oGtZatgRM8RpDIghHqAF4a5Q5
         uo0m/Jxhf3euWazOItxosUsnZz346gj43f1UqZHwxlI+qxL5Mx1XKIxuutKA4q8KAyHF
         LiBF+vHV38AtiN6mvtn4xnEDMahpcoyWhOBJnWYpH8AVGLsTj4rII+4lfqPlvu9xrUZZ
         CycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771987; x=1699376787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyqmAcSN2PKtF0+3dN6liYrrDauDlreyEGWUWcbg92s=;
        b=n/dLQFyAB3JmRc+24SKBDIQap8EPZJXQLzenpjavm+XdjwWdet/8Hy86xE/MWkzOm3
         yODeWMCVZ25WDvGVHKKtc9hEofjbRxP1XhDLjQdeqN/NlwQ5x7moucO1YWLq1OS3D/k6
         Hx7xQMUFjd4TMwpjyBPbi1zMOpVxxbiqmw2bl7v0gDHHftGV9TiGR0eG6WpTewsxOHXX
         a9LYM0pPz7XyabidxK45gm+syZzeaLkQNBXbXaY0dPInS0d1MeJ+mxCP5DhcV0Fm2uKj
         zwJRU01w1V3G0GKL5sfyvb643sfX6KWt/LROY+3llac20ZWNoYgmA0DI940TLzfPDxSk
         CqhA==
X-Gm-Message-State: AOJu0Yy8DvuRkj8FIiOO+C4T/wB/kT+sHUAmeVlq8+x3+mWhYrtzCVjg
	wvrTpqr1ew3+P+ddOXMHGCLx
X-Google-Smtp-Source: AGHT+IH/7YAGTDRj5poUTfUF5hgpwxwfnbWPmXixLjYkWx415duZL1CefsWRB8b1fuzRQvxSfp9plA==
X-Received: by 2002:a05:6a00:1a8a:b0:690:cae9:714d with SMTP id e10-20020a056a001a8a00b00690cae9714dmr11884354pfv.13.1698771987197;
        Tue, 31 Oct 2023 10:06:27 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id s17-20020a056a00195100b006b8bb35e313sm1484228pfk.103.2023.10.31.10.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:06:26 -0700 (PDT)
Message-ID: <31ebe4c9-84aa-4d42-9aeb-712e2a6cece3@github.com>
Date: Tue, 31 Oct 2023 10:06:24 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] ci: unify setup of some environment variables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698742590.git.ps@pks.im>
 <a64799b6e25d05e5d5fc7fe3c5602b5ce256d8b9.1698742590.git.ps@pks.im>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <a64799b6e25d05e5d5fc7fe3c5602b5ce256d8b9.1698742590.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> Both GitHub Actions and Azue Pipelines set up the environment variables

s/Azue/Azure

> GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
> actually the same, the setup is completely duplicate. With the upcoming
> support for GitLab CI this duplication would only extend even further.
> 
> Unify the setup of those environment variables so that only the uncommon
> parts are separated. While at it, we also perform some additional small
> improvements:
> 
>     - We now always pass `--state=failed,slow,save` via GIT_PROVE_OPTS.
>       It doesn't hurt on platforms where we don't persist the state, so
>       this further reduces boilerplate.
> 
>     - When running on Windows systems we set `--no-chain-lint` and
>       `--no-bin-wrappers`. Interestingly though, we did so _after_
>       already having exported the respective environment variables.
> 
>     - We stop using `export VAR=value` syntax, which is a Bashism. It's
>       not quite worth it as we still use this syntax all over the place,
>       but it doesn't hurt readability either.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/lib.sh | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 9ffdf743903..9a9b92c05b3 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -175,11 +175,7 @@ then
>  	# among *all* phases)
>  	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
>  
> -	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> -	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> -	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> -	test windows_nt != "$CI_OS_NAME" ||
> -	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +	GIT_TEST_OPTS="--write-junit-xml"
>  elif test true = "$GITHUB_ACTIONS"
>  then
>  	CI_TYPE=github-actions
> @@ -198,17 +194,25 @@ then
>  
>  	cache_dir="$HOME/none"
>  
> -	export GIT_PROVE_OPTS="--timer --jobs 10"
> -	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
> -	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> -	test windows != "$CI_OS_NAME" ||
> -	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +	GIT_TEST_OPTS="--github-workflow-markup"
>  else
>  	echo "Could not identify CI type" >&2
>  	env >&2
>  	exit 1
>  fi
>  
> +MAKEFLAGS="$MAKEFLAGS --jobs=10"
> +GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> +
> +GIT_TEST_OPTS="$GIT_TEST_OPTS --verbose-log -x"
> +if test windows = "$CI_OS_NAME"

Based on the deleted lines above, I think this would need to be:

	if test windows = "$CI_OS_NAME" || test windows_nt = "$CI_OS_NAME"

I believe these settings are required on all Windows builds, though, so you could 
instead match on the first 7 characters of $CI_OS_NAME:

	if test windows = "$(echo "$CI_OS_NAME" | cut -c1-7)"

(full disclosure: I'm not 100% confident in the correctness of that shell syntax)

> +then
> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
> +fi
> +
> +export GIT_TEST_OPTS
> +export GIT_PROVE_OPTS
> +
>  good_trees_file="$cache_dir/good-trees"
>  
>  mkdir -p "$cache_dir"


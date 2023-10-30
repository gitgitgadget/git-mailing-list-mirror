Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E63B67E
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvow320+"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1ADDA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:09:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso30652075e9.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698678543; x=1699283343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cFnLLpZh3wAoUOLmQh37Rrn3xwzyKRXOe2Fb4z1tE18=;
        b=bvow320+5eOS/lw49og0FNQ2Hdt+34mH6NRl3llLpR8tDZ2gD/yYWZq50iZXKsevNd
         CU8ZZOLIMT5wfOf+2OntKoTBx/sMqnYseTDlRPMWlzmJR54zkqPLMRo2PAI78PSf24LL
         +E3Z1c4Vl5Bf6vss9SGUqq9E60IsgENjhqEvyfDI0o9yfC01vk2YzB1T4YNby1g+Kdiw
         a6oOqUqnl52YS9LBtdWPBrlLCNb1VzLwKBwzFymHdzIBOo3KVQz3CjGIt1QG95XWgopZ
         Ie7jzMrzCSeNH/RtRhZVD4PVG/ZP08xaOkdOrqbgxWxkAxEU+Aqloc8Ao/3lrduaxZvy
         8fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698678543; x=1699283343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFnLLpZh3wAoUOLmQh37Rrn3xwzyKRXOe2Fb4z1tE18=;
        b=Vbqw5hXZeP/lwfpXGvA8nBv4wIX+iGRCgQmHQWzxxK00Pwzzw7k1uNsU4otWib3Ow/
         5fzTNJvJnsWuZRAMgoa6dmUnP5ar314EPmnyfG4LFFixM3qLx3HAONI46MA7PMsv6Hal
         QyWeiaRDOqGzJkrb5dKEY6+0J/B7+RyDTfbAUn7XqjrXbd5VkdRyb1ex8fVbZQolm8v8
         WqJHPljJfNmoE5Ln7m17/GyesG47C+NtWTfzpA+NOJiioj8rkm9aL1iSB5cwagcARJPS
         ELnnvxoYiFVwi13Syg/CCfz0EeDIOXWIJDKDqzhEhwUMc1yuRYOx/qPhuCsk6F3uGJKx
         h2pg==
X-Gm-Message-State: AOJu0Yxd7Z4EnzPm05epO0JDOUN+ujyTr4ZvY/AS+kQqZqMTvr2I1+T1
	RGOmD+0nKWKig5AOsngSXlM=
X-Google-Smtp-Source: AGHT+IExvXDIuXNGP1/IhwEXjF0jSGKXFpbH2UNxbh+zwMEV0sPiZRZN4cSbXtN0CyLTDwmJaXVqAw==
X-Received: by 2002:a05:600c:138b:b0:401:dc7c:2494 with SMTP id u11-20020a05600c138b00b00401dc7c2494mr9213785wmf.27.1698678542626;
        Mon, 30 Oct 2023 08:09:02 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id r22-20020a05600c159600b004075d5664basm12807195wmf.8.2023.10.30.08.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:09:02 -0700 (PDT)
Message-ID: <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>
Date: Mon, 30 Oct 2023 15:09:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/8] ci: unify setup of some environment variables
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698667545.git.ps@pks.im>
 <6af0075fd875f176e7fdf6c219e7117dac5cd71c.1698667545.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6af0075fd875f176e7fdf6c219e7117dac5cd71c.1698667545.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 30/10/2023 12:15, Patrick Steinhardt wrote:
> Both GitHub Actions and Azue Pipelines set up the environment variables
> GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
> actually the same, the setup is completely duplicate. With the upcoming
> support for GitLab CI this duplication would only extend even further.
> 
> Unify the setup of those environment variables so that only the uncommon
> parts are separated. While at it, we also perform some additional small
> improvements:
> 
>      - We use nproc instead of a hardcoded count of jobs for make and
>        prove. This ensures that the number of concurrent processes adapts
>        to the host automatically.

Sadly this makes the Windows and MacOS jobs fail on GitHub Actions as 
nproc is not installed[1]. Perhaps we could do

	--jobs="$(nproc || echo 2)"

instead. (Maybe 2 is a bit low but the current value of 10 seems pretty 
high for the number of cores on the runners that we use)

>      - We now always pass `--state=failed,slow,save` via GIT_PROVE_OPTS.
>        It doesn't hurt on platforms where we don't persist the state, so
>        this further reduces boilerplate.
> 
>      - When running on Windows systems we set `--no-chain-lint` and
>        `--no-bin-wrappers`. Interestingly though, we did so _after_
>        already having exported the respective environment variables.
 > >      - We stop using `export VAR=value` syntax, which is a Bashism. 
It's
>        not quite worth it as we still use this syntax all over the place,
>        but it doesn't hurt readability either.

I don't mind this change, but the 'export VAR=value' syntax is in POSIX[2]

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   ci/lib.sh | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 9ffdf743903..c7a716a6e3f 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -175,11 +175,7 @@ then
>   	# among *all* phases)
>   	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
>   
> -	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> -	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> -	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> -	test windows_nt != "$CI_OS_NAME" ||
> -	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +	GIT_TEST_OPTS="--write-junit-xml"
>   elif test true = "$GITHUB_ACTIONS"
>   then
>   	CI_TYPE=github-actions
> @@ -198,17 +194,25 @@ then
>   
>   	cache_dir="$HOME/none"
>   
> -	export GIT_PROVE_OPTS="--timer --jobs 10"
> -	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
> -	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> -	test windows != "$CI_OS_NAME" ||
> -	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +	GIT_TEST_OPTS="--github-workflow-markup"
>   else
>   	echo "Could not identify CI type" >&2
>   	env >&2
>   	exit 1
>   fi
>   
> +MAKEFLAGS="$MAKEFLAGS --jobs=$(nproc)"
> +GIT_PROVE_OPTS="--timer --jobs $(nproc) --state=failed,slow,save"
> +
> +GIT_TEST_OPTS="$GIT_TEST_OPTS --verbose-log -x"
> +if test windows = "$CI_OS_NAME"
> +then
> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
> +fi
 >
> +export GIT_TEST_OPTS
> +export GIT_PROVE_OPTS

I was wondering why we don't export MAKEFLAGS here but it is exported 
earlier on before we set it. Apart from the nproc issue this looks like 
a nice improvement

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/actions/runs/6694263874
[2] 
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#export

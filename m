Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161B3C46E
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Jyqv2WtZ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78333a8d428so14498785a.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704825822; x=1705430622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlc8JCmVHjIsf6jRvLLCY68E+S1Md0rdPYx34XEMwLs=;
        b=Jyqv2WtZncPTqcwoETcZiZeQNtd29EaPL3qO8CUTrPo+860Qt1fYiMEXRKeJcGp8ar
         OgDEwkEOwQXzW0p0Sm6qejRqduwvJoyxs8G7HYrqj0CEuN11CMJcluWb1vMB6Cq0rse1
         xvg5r9L/VOouluVVUmILxPO03FAtJKMOdgsJQrOA+nKnfRLFr8GhMNfqRyRvj18sXNF/
         FwcWOXn5S5cz7ekmnmklx3isEwQXWh5qqtyjPN9SyldV5gbted/XWZnbnhva7vFmtoSz
         lOJQhfReDKyBOjUzVHQYQMj2zil7sF5yjNzEyADPm+phUfwpf0dTLyGZzRypP9V5lqxQ
         sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825822; x=1705430622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlc8JCmVHjIsf6jRvLLCY68E+S1Md0rdPYx34XEMwLs=;
        b=JJMXg5tJ1O5/ZLGYelHxKRJl+gTGTg7rQlUP9mUw1rIefdLngrwtceLAg2TOu3AKNc
         czZU488XDrrHqyvkmL1XjgGJTYBLKLuPx3NY4kNzevm2EZLPpxHBztxd+KaUWKXhV+yn
         OeTqlwhnN1f1+1Ufx/jQFX2J+fTvmzBxCiZZKhJ9AZFprtPZ1fUrD627TTqafiWqPvAn
         HU4zlqRJoWP8pL/rsQlIwhrs/AJ8xRwoyr/8ZhonnfUJklSOvjoxBz6at8Vuj29EUJCz
         3+C0kn4b7CN9GzrtALxa1iKR8O0yofZoClbia95T+3gb2rwKy6rCuppV4kfrAfasiR0l
         wVFA==
X-Gm-Message-State: AOJu0Yw4eYx6X8p9wTtze8H+hqYqT4UqRUzzyxMlsq/dRLTN4L+B1XzG
	gMJvc45wHK+6ZRk3HhqVXB23fILu1Q+paQ==
X-Google-Smtp-Source: AGHT+IEMOVzjtihjbaMR+SjeLVYH1tKBG/tY8Qcopi54Txap+/AUEgt1BXlIJrTdn5XBYbKiwEJ2yQ==
X-Received: by 2002:a05:620a:45a3:b0:783:2408:b546 with SMTP id bp35-20020a05620a45a300b007832408b546mr1938032qkb.37.1704825821894;
        Tue, 09 Jan 2024 10:43:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d6-20020a0cc686000000b00680b7496635sm1092120qvj.42.2024.01.09.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:43:41 -0800 (PST)
Date: Tue, 9 Jan 2024 13:43:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] t1302: make tests more robust with new extensions
Message-ID: <ZZ2T3G+igA6zAIKO@nand.local>
References: <cover.1704802213.git.ps@pks.im>
 <9af1e418d47730f503dabb271d30c848bf74fa0b.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9af1e418d47730f503dabb271d30c848bf74fa0b.1704802213.git.ps@pks.im>

On Tue, Jan 09, 2024 at 01:17:12PM +0100, Patrick Steinhardt wrote:
> In t1302 we exercise logic around "core.repositoryFormatVersion" and
> extensions. These tests are not particularly robust against extensions
> like the newly introduced "refStorage" extension.
>
> Refactor the tests to be more robust:
>
>   - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
>     repository format version. This helps to ensure that we only need to
>     update the prereq in a central place when new extensions are added.
>
>   - Use a separate repository to rewrite ".git/config" to test
>     combinations of the repository format version and extensions. This
>     ensures that we don't break the main test repository.
>
>   - Do not rewrite ".git/config" when exercising the "preciousObjects"
>     extension.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1302-repo-version.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 179474fa65..fb30c87e1b 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -28,7 +28,12 @@ test_expect_success 'setup' '
>  '
>
>  test_expect_success 'gitdir selection on normal repos' '
> -	test_oid version >expect &&
> +	if test_have_prereq DEFAULT_REPO_FORMAT
> +	then
> +		echo 0
> +	else
> +		echo 1
> +	fi >expect &&
>  	git config core.repositoryformatversion >actual &&
>  	git -C test config core.repositoryformatversion >actual2 &&
>  	test_cmp expect actual &&
> @@ -79,8 +84,13 @@ mkconfig () {
>
>  while read outcome version extensions; do
>  	test_expect_success "$outcome version=$version $extensions" "
> -		mkconfig $version $extensions >.git/config &&
> -		check_${outcome}
> +		test_when_finished 'rm -rf extensions' &&
> +		git init extensions &&
> +		(
> +			cd extensions &&
> +			mkconfig $version $extensions >.git/config &&
> +			check_${outcome}
> +		)
>  	"
>  done <<\EOF
>  allow 0
> @@ -94,7 +104,8 @@ allow 1 noop-v1
>  EOF
>
>  test_expect_success 'precious-objects allowed' '
> -	mkconfig 1 preciousObjects >.git/config &&
> +	git config core.repositoryformatversion 1 &&

I'm nit-picking, but it looks like core.repositoryformatversion is all
lower-case, whereas extensions.preciousObjects is camel-case. I don't
think it's a big deal either way, but I couldn't *not* mention it while
reading ;-)

> +	git config extensions.preciousObjects 1 &&
>  	check_allow
>  '
>
> --
> 2.43.GIT

Thanks,
Taylor

Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8C1DC9B8
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615558; cv=none; b=MmOlbnrzjf1U2M7SKYXSTLvcMJMoOmPpytHdSr8tZZZwUh0lEIUYRb/UJ1tdxOYsKVt7p555h2V9hl4aoi4Ac4SEUm+Rzcj5cWPrviAuaa+t6mqg5i8RkHPcjo39+Yt326+JU/sa6nmxvX3rbBog96XFHCT3YqYHZ+Xdei7vHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615558; c=relaxed/simple;
	bh=uiVIMqWH/FsBVMb18+583K9OsrRyvdVuSxDm92mAAmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMoryP2NNelxh9kILlIOA372g+hD8qPtGrWeqVWkcgcQ5DTlbUk7cwf/Gd/1S2qkM3C9yRNPuzQzwprtBeTOC8sLHPxaLvKxkQSZDYOYqjY2VZRA4yUPVyYtY5U+f0ekF5kPTtEvgCTPZvzExAf1XXNG8x2+09PXYvP4HO5QFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq45URPT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq45URPT"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e5e3c6926so355476a34.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752615556; x=1753220356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lm8x8mQ3cVdr3q1odfvGjLgQlt1jI+GDKfe8oPeO3n0=;
        b=aq45URPTSSAAEfnO4Cl+fKHBTtYSo24Iqy6bZdtRuakoRQdAQgacPrC5sTzg+Q0/xr
         89ynQzgpsBSGdFqG3ULeb+bU+q6u44NZNxoDgNN7nZugTSMJnzrmO/Ymg60niZY9sedW
         1fjz1yngt35BumG9Ulx6NjZVMLYGfEAH2gvqvbgvrgQhACyNn8Ge513amh5l3bdu5K1Y
         qnCmvRT+rGO44zAWvE4Y9OML3bZs19O4AhL6WfnfDeoGUDFHy6knOK8h2dailhmewUB2
         n0pl2WM7EL0dpVxdhnCcpxH8XooA2VDulqbs+R0LCx9D2rTGzq7ppw0WPTMYM04AMvja
         HhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752615556; x=1753220356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm8x8mQ3cVdr3q1odfvGjLgQlt1jI+GDKfe8oPeO3n0=;
        b=YrKpKpjXTI8H7NokSz+WvgAoynRXkLzi5Qxa3vv17Bihdw1K7AVMJcbZUl9fXqFkbc
         RkS4OOTJPJl2NHL+AqBIUIFz1pgF/+ID4QVXmW3V+j4yKdw0bbNOJNBr+fxwVwLmM9Ym
         P8qM9e0x0SrxFx2cEJLQzeY7aBSNFzpKkfPNKBF7ghOCi6bCqJXYp9F5lqrvlWrgXTFd
         oaN2XYB4L06bsCBUEgA7bWT1hRcEgmjgUYqOWTpb3MNdai6b4F/gER95E5DpflDVxwZO
         yyYm5P4Otg3j2RLd9Yu7cYyxsCEPXUpNiIU6Tgc1aewBYtDjypdaTbwpJ0ZBZ6zXaQBU
         HEdQ==
X-Gm-Message-State: AOJu0Yxx296qEHUELxxpM13SXh0st3ohFh+gxrJI9UNyOniOAHMyOZgd
	B6D2d04XR1TdDWXn1il6mLNcIxcCM2CR5ZnEAzX3QynzKD1xur7hplDW
X-Gm-Gg: ASbGncsBoCjvrL8eoGy2nsT4lUTohCMqoRvqefUswA0cFuZVI5tupMPY+pZOln3e0YV
	rEl/F4XmMpjhFJbki9LhzCyAhkQWxh2NOItjBKvF7ULar07mV1i1XZJo3iwIFjRQy3CdvBhJgUT
	VCFjl/3A45p+gD6i18t9bYYudw7YVNbbsevDDWXvbgjtXpTw8cS15zYs4XRfNpg7Ijv6HTK+ODA
	Z0TJCIC2dx8Ml9K1YqSiznoMGSUu2/p/tVOZ1oAiuUGznE/hf6NvFF4aYdsO0lp4JJ1mRxR+RFK
	nfFSLZSyif57/DZqAVei4RbeltwPCqLg4a3Z1WzsWx3JmpEhFa2qxgDysL4kmB3dySiJ098tEBf
	OIpluPvL0cpGZil6RielyK+0Xsg==
X-Google-Smtp-Source: AGHT+IE/kbZjTqQ2p8ZwmaGjLH0UVcPp4HcUbo1w78c/kiMDCfI4yd4eK8Nhto2XpV1E3sdkBX4BAQ==
X-Received: by 2002:a05:6830:490b:b0:73e:54cb:1de5 with SMTP id 46e09a7af769-73e665f6e1cmr144733a34.28.1752615556091;
        Tue, 15 Jul 2025 14:39:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e5fc7c942sm521517a34.31.2025.07.15.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:39:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:33:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] test-lib: respect GIT_TEST_INSTALLED when querying
 default hash
Message-ID: <gszrut3ruxmzelqjaeqfx767njz77yaxiq7fvuktezaobv72g6@ehlzm3c4kydm>
References: <pull.2011.git.git.1752605874596.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2011.git.git.1752605874596.gitgitgadget@gmail.com>

On 25/07/15 06:57PM, Kyle Lippincott via GitGitGadget wrote:
> From: Kyle Lippincott <spectral@google.com>
> 
> $GIT_TEST_INSTALLED can be set to use an "installed" git instead of the
> one from $GIT_BUILD_DIR. This is used by my company's internal test
> infrastructure, and not using $GIT_TEST_INSTALLED when querying the
> default hash meant that the tests were failing because the hash was
> effectively set to the empty string (since git didn't execute).
> 
> In the two places we attempt to detect/execute git itself prior to
> overriding everything and putting it in $PATH, use identical logic for
> identifying the git binary to execute. This also has the effect of
> including the $X suffix when querying the default hash, but that's not
> strictly necessary. You don't need to specify .exe when running a binary
> on Windows, just when testing whether it exists or not.

The second paragraph was a little difficult for me to parse, but I
understand the change as the following:

In c79bb70a2e (Enable SHA-256 by default in breaking changes mode,
2025-07-01), when building Git with `WITH_BREAKING_CHANGES` defined, the
default object hash format is changed from SHA1 to SHA256. To select the
correct hash used by `GIT_TEST_BUILTIN_HASH` during testing,
git-version(1) is executed with the `--build-options` flag to get the
default hash the Git binary is built with.

When running the Git testsuite with `GIT_TEST_INSTALLED` set, the Git
binary in `GIT_BUILD_DIR` is used to check for the default hash which is
incorrect. Instead the binary at `GIT_TEST_INSTALLED` should be used.

> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>     test-lib: respect GIT_TEST_INSTALLED when querying default hash
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2011%2Fspectral54%2Fdefault_hash_respect_git_test_installed-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2011/spectral54/default_hash_respect_git_test_installed-v1
> Pull-Request: https://github.com/git/git/pull/2011
> 
>  t/test-lib.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 6dc2022ee10..621cd31ae1d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -134,7 +134,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  ################################################################
>  # It appears that people try to run tests without building...
> -"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
> +GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
> +"$GIT_BINARY" >/dev/null

Here we store the Git binary we should be testing with so we can use it
later. Makes sense.

>  if test $? != 1
>  then
>  	if test -n "$GIT_TEST_INSTALLED"
> @@ -536,7 +537,7 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>  export EDITOR
>  
> -GIT_TEST_BUILTIN_HASH=$("$GIT_BUILD_DIR/git" version --build-options | sed -ne 's/^default-hash: //p')
> +GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')

Now we use the correct binary to check the default hash depending on how
the tests are executed. Looks good to me :)

-Justin

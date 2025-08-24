Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B918A6B0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064489; cv=none; b=G1VOrwzYG8d+PrwDl4S/wEplg15OslRNbopK+1Urr/4y8+uGY6No0tpJ9gIEKhSsR+gGUdfgOJm8TF6QgvwjbA1cOtRgDdViTxJSY9Z8x8CeLjKzuuGXHumLTOQQyA7QdFajc/vDDoaR62AJ8OF4EFTWiCy54gj/Ud/NCuqaHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064489; c=relaxed/simple;
	bh=VtkdJULpHurcPe50w7LW9JlfBuOupTjWSvaCeBTsBOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuyIfPtzSWq3cG0zN17Q4zdiNEi2Wy+A1nnZi2xCcxgJadcaEfLkI99ZiJBQ1yVGElihNoTbz7sQYVHtyOVtBGtn2X9nF2XjSvrfT+6i4egIUCZFZbihkoTGG4zOvfn4CKmpAkumw71oxddazeJYJ7Jki7Dw+FfkrvhfdZTEj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaeLPuuX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaeLPuuX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so2664403f8f.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756064485; x=1756669285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uz1XhdhLzcC/FBK4mF4X4CyHNG5obV3PY2hJZNugqk=;
        b=PaeLPuuX8kFzuUaBhE00RC0FEwbTdTB5fzWYGfZBJYNzFPouAwhHYS2pw+DDVSkcK7
         niw94RQnxs68OhKZ2hjPkJDprcGJhJ177K6Nzun57k3a+O1dTdgKeWKSxvTyl3VGo5eE
         6bBA1/RA55987Pin2DpdfBrxe6up3eVivFXLOQSLsrBbB3koRTyxzHN8rtIUXq9/G6Np
         xjcIytUnquL1KZ+vpHRni3uUzTkVuXk34j1rStiTTwymEzXkm6s6ZeixuXYbAUGLAP1K
         hC7rLvDtR+Gn6m5oOvVqRBS2eZyPeQC238n0Mxy3jYY+To8ImFibbEsDrU+8LKSspQKC
         qX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756064485; x=1756669285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uz1XhdhLzcC/FBK4mF4X4CyHNG5obV3PY2hJZNugqk=;
        b=D6zSMen1vhsDcaLhJTkLVx+yRsqzhwOjl95esEkqAAkF0rhOBkkRRq93t7/zEJHK+j
         RdRPrhohg4AzpTp2//OzVoQPSm54s3qVu3hykVIMZJQijyfCfjBY/O6oPb01b/NPTfv3
         LqkgOUN9DARZUpog349zdLaMXmkk2WqAcXsXgsyMrv9k71g+1harfi1XOHV3nTZA/fal
         AIJf63qErrLHBJX8ewIddgRlFEQZxaUSySZPvwd6vad1p1Z1ni9hA4jkcxI81D37kVi1
         od2742NeVTrsQJV/cHzN0XlOzefCvbzzEJZVHum69r72oAuoXaHhXUNjW0HWkwV66R1a
         u38A==
X-Gm-Message-State: AOJu0YyJQxkkzA+faYmN0aYwf6ATm6XQdpkK5goMjwR+z+V3HeofbxvU
	l3MupasHEl/antylyRROjR4DNZI+zNX9vhL4XTqkgDwOhcsZLB/heuxp
X-Gm-Gg: ASbGncvf0NfzEQfY0xP7w1pxzThuWBQBsSBU9HQ+wAuKATiC6+6ivpHQsbL+2Dxia40
	bS8OtJ8aM4a13GRgtwjVe9T55bsCKJWN3fti6ch4Gmnd+zxNJJ/29h4fwbb0qxHD9evjlrOSTOY
	9W5y/GNIzlZRLroPo3Yvlcgyd5e4HthCnG9/4ODR9CNRZfcNUGH0JhFI3jp07A1/dUFbWImO8oN
	7gW4pjI8g+amKTk0y18V+EFjEQgpBilP/EQzJuSafeS3CZM5hxwJiZ4bZJp+eILU5nHkF2shc21
	HhaQCUo7Aw/qaR6h/lRd9rlKJ4lkL+q9EtNdj5YVrSyO8KPih2NUs2jO+dyUhG3o5SGxSIZWxaN
	9gDkeHp0/eOuOqLk7sdnhzm6MRwspzcvoq/JlsBsqGJTR50mQmaG1
X-Google-Smtp-Source: AGHT+IF49K/JOyEARw3qk6rfRe3vXn5+nSJQ7VXcIwrpI7RVmD6hcegr/hcnnzGf7TuoPe5NQQ++DQ==
X-Received: by 2002:a5d:5f8d:0:b0:3c8:89e9:6ab3 with SMTP id ffacd0b85a97d-3c889e96d40mr2037066f8f.46.1756064484723;
        Sun, 24 Aug 2025 12:41:24 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba1eesm8884724f8f.2.2025.08.24.12.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:41:24 -0700 (PDT)
Date: Sun, 24 Aug 2025 21:41:23 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/4] t5510: prefer "git -C" to subshell for
 followRemoteHEAD tests
Message-ID: <aKtq47vmCrUZCUCF@szeder.dev>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192716.GC1059295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192716.GC1059295@coredump.intra.peff.net>

On Tue, Aug 19, 2025 at 03:27:16PM -0400, Jeff King wrote:
> These tests set config within a sub-repo using (cd two && git config),
> and then a separate test_when_finished outside the subshell to clean it
> up. We can't use test_config to do this, because the cleanup command it
> registers inside the subshell would be lost. Nor can we do it before
> entering the subshell, because the config has to be set after some other
> commands are run.
> 
> Let's switch these tests to use "git -C" for each command instead of a
> subshell. That lets us use test_config (with -C also) at the appropriate
> part of the test. And we no longer need the manual cleanup command.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It is perhaps debatable whether this makes the result more readable.
> It's fewer lines, but there is "-C" sprinkled everywhere. So if people
> find this ugly we can drop it (and I'd rewrite patch 4 to use the
> subshell form in its new test).

I for one think that the original is much more readable.

With the subshell it's quite clear, even at a cursory glance, which
commands are executed in a subdirectory, but when using '-C dir' all
over we have to look closely.  Furthermore, when there is a command
outside of the subshell, we can be fairly sure that it's intentional,
but when a command without '-C dir' lurks among many others using '-C
dir', then we can't be so sure, but have to investigate whether that
was intentional or oversight.

>  t/t5510-fetch.sh | 202 +++++++++++++++++++----------------------------
>  1 file changed, 83 insertions(+), 119 deletions(-)
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 93e309e213..24379ec7aa 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -123,149 +123,113 @@ test_expect_success "fetch test remote HEAD change" '
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD never" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
> -		git config set remote.origin.followRemoteHEAD "never" &&
> -		GIT_TRACE_PACKET=$PWD/trace.out git fetch &&
> -		# Confirm that we do not even ask for HEAD when we are
> -		# not going to act on it.
> -		test_grep ! "ref-prefix HEAD" trace.out &&
> -		test_must_fail git rev-parse --verify refs/remotes/origin/HEAD
> -	)
> +	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
> +	test_config -C two remote.origin.followRemoteHEAD "never" &&
> +	GIT_TRACE_PACKET=$PWD/trace.out git -C two fetch &&
> +	# Confirm that we do not even ask for HEAD when we are
> +	# not going to act on it.
> +	test_grep ! "ref-prefix HEAD" trace.out &&
> +	test_must_fail git -C two rev-parse --verify refs/remotes/origin/HEAD
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn no change" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git rev-parse --verify refs/remotes/origin/other &&
> -		git remote set-head origin other &&
> -		git rev-parse --verify refs/remotes/origin/HEAD &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		git config set remote.origin.followRemoteHEAD "warn" &&
> -		git fetch >output &&
> -		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> -			"but we have ${SQ}other${SQ} locally." >expect &&
> -		test_cmp expect output &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/other) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two rev-parse --verify refs/remotes/origin/other &&
> +	git -C two remote set-head origin other &&
> +	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn" &&
> +	git -C two fetch >output &&
> +	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> +		"but we have ${SQ}other${SQ} locally." >expect &&
> +	test_cmp expect output &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn create" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
> -		git config set remote.origin.followRemoteHEAD "warn" &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		output=$(git fetch) &&
> -		test "z" = "z$output" &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/main) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn" &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	output=$(git -C two fetch) &&
> +	test "z" = "z$output" &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn detached" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
> -		git update-ref refs/remotes/origin/HEAD HEAD &&
> -		HEAD=$(git log --pretty="%H") &&
> -		git config set remote.origin.followRemoteHEAD "warn" &&
> -		git fetch >output &&
> -		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> -			"but we have a detached HEAD pointing to" \
> -			"${SQ}${HEAD}${SQ} locally." >expect &&
> -		test_cmp expect output
> -	)
> +	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
> +	git -C two update-ref refs/remotes/origin/HEAD HEAD &&
> +	HEAD=$(git -C two log --pretty="%H") &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn" &&
> +	git -C two fetch >output &&
> +	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> +		"but we have a detached HEAD pointing to" \
> +		"${SQ}${HEAD}${SQ} locally." >expect &&
> +	test_cmp expect output
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn quiet" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git rev-parse --verify refs/remotes/origin/other &&
> -		git remote set-head origin other &&
> -		git rev-parse --verify refs/remotes/origin/HEAD &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		git config set remote.origin.followRemoteHEAD "warn" &&
> -		output=$(git fetch --quiet) &&
> -		test "z" = "z$output" &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/other) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two rev-parse --verify refs/remotes/origin/other &&
> +	git -C two remote set-head origin other &&
> +	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn" &&
> +	output=$(git -C two fetch --quiet) &&
> +	test "z" = "z$output" &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git rev-parse --verify refs/remotes/origin/other &&
> -		git remote set-head origin other &&
> -		git rev-parse --verify refs/remotes/origin/HEAD &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		git config set remote.origin.followRemoteHEAD "warn-if-not-main" &&
> -		actual=$(git fetch) &&
> -		test "z" = "z$actual" &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/other) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two rev-parse --verify refs/remotes/origin/other &&
> +	git -C two remote set-head origin other &&
> +	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn-if-not-main" &&
> +	actual=$(git -C two fetch) &&
> +	test "z" = "z$actual" &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git rev-parse --verify refs/remotes/origin/other &&
> -		git remote set-head origin other &&
> -		git rev-parse --verify refs/remotes/origin/HEAD &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		git config set remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
> -		git fetch >actual &&
> -		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> -			"but we have ${SQ}other${SQ} locally." >expect &&
> -		test_cmp expect actual &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/other) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two rev-parse --verify refs/remotes/origin/other &&
> +	git -C two remote set-head origin other &&
> +	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	test_config -C two remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
> +	git -C two fetch >actual &&
> +	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
> +		"but we have ${SQ}other${SQ} locally." >expect &&
> +	test_cmp expect actual &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success "fetch test followRemoteHEAD always" '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git rev-parse --verify refs/remotes/origin/other &&
> -		git remote set-head origin other &&
> -		git rev-parse --verify refs/remotes/origin/HEAD &&
> -		git rev-parse --verify refs/remotes/origin/main &&
> -		git config set remote.origin.followRemoteHEAD "always" &&
> -		git fetch &&
> -		head=$(git rev-parse refs/remotes/origin/HEAD) &&
> -		branch=$(git rev-parse refs/remotes/origin/main) &&
> -		test "z$head" = "z$branch"
> -	)
> +	git -C two rev-parse --verify refs/remotes/origin/other &&
> +	git -C two remote set-head origin other &&
> +	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
> +	git -C two rev-parse --verify refs/remotes/origin/main &&
> +	test_config -C two remote.origin.followRemoteHEAD "always" &&
> +	git -C two fetch &&
> +	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
> +	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
> +	test "z$head" = "z$branch"
>  '
>  
>  test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
> -	test_when_finished "git -C two config unset remote.origin.followRemoteHEAD" &&
> -	(
> -		cd two &&
> -		git remote set-head origin other &&
> -		git config set remote.origin.followRemoteHEAD always &&
> -		git fetch origin refs/heads/main:refs/remotes/origin/main &&
> -		echo refs/remotes/origin/other >expect &&
> -		git symbolic-ref refs/remotes/origin/HEAD >actual &&
> -		test_cmp expect actual
> -	)
> +	git -C two remote set-head origin other &&
> +	test_config -C two remote.origin.followRemoteHEAD always &&
> +	git -C two fetch origin refs/heads/main:refs/remotes/origin/main &&
> +	echo refs/remotes/origin/other >expect &&
> +	git -C two symbolic-ref refs/remotes/origin/HEAD >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'fetch --prune on its own works as expected' '
> -- 
> 2.51.0.326.gecbb38d78e
> 
> 

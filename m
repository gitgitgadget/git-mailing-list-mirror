Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B162AE8D
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426859; cv=none; b=VMjCXjMgOugw2p3dTqcbk79b6mKuPpJoxjIwhe5V+HClsk2dWZN32dBuMarFGl11qkZjvZ38NOgF7F9stKQEtc5bpOFhOkAA1nY6qoAvwvBG0gf/8qBrRnMA3CLS5mKL5M4GFlnoKVqirhmLaIBrYcAOnlmQkoEK5ZX2h4/Hiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426859; c=relaxed/simple;
	bh=iH9Rr8B+2JQ5OaW5o+9pKuCSgl58SoJ15/ILeypHsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRGbNxo9aD+veHYFl94O3KpJfeGZ9niVp9pC1yPAmjJbzxMm6wlSj7BSfRPM6mx+3fpFbsfyfSCBpUPFbwMUG48Jsu2/oXJRwwYOMbUZBe5WCYT9P5flF2N+jds4guY7XFVDm44fBhxktc//r2dETlILHZkRtdL09SV6FZPXD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU6C7wlz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU6C7wlz"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so7107243a12.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743426855; x=1744031655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G69kMKdGF/+GOy/nRmm7b4worQOm4vmtsc9Q155zOEw=;
        b=DU6C7wlzjDx77wxK2u9to+MYI9k2sAfEfBcen+euxx1SoqFbTERPO36QlJ37uvL52w
         ewPWC3Hi+i7tYsFwgVbYCax+OkGaPSMrJi2Wc6Eq52gfA5xiqavvkwUTh3QWlFfLVZ5Z
         ccpReP7I76joDiImypasG/S5wdQXOJvsvd+OJ5owH1WxzgOEl2hHIKRtVZ0EARaP1yug
         CrxnGrPYSqJfK8T1Nly4NyoBIBf31krgfdq7rRYA0s5aDw33P6m8l5IMoNykY2D+sBy5
         Hn1cuzqv6YedlZBH1/IPmje6kdN2QPLzoao7EWfpB6/3tXq3h8+kzsm5W36EAaasXZ6X
         NH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426855; x=1744031655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G69kMKdGF/+GOy/nRmm7b4worQOm4vmtsc9Q155zOEw=;
        b=vvFBDaB4Fri/UwUG0/IbKDo8etYR1OS/dnFy7JEjlkgEyJwvWS3tMUrvBIt8LIIjYF
         4gquinrG/O5xhjeppg766FCcAI+SdVjy2QCYonKKkgOOu8aJ+0ryJVuczmzYb2HKzrCk
         8GJD3Q69qZ91Z/Lu2+W90cnLKaZUKRd9slsMx9WkiAzduZqyrOd1Q81YkY/7/Oom5nai
         mHwk5zV3WEUSZFPR2z4RRJcB7TS6q7s3uG8i56l7q9bU14NuMdUaQH4OwkhKs1Io9Wfo
         mFIJc578J3REh3IS+TnbA2CKZEH747rQEEVg+okTtPjsj91hV+TTz3FwlnNuo/pm9VPZ
         nh8A==
X-Gm-Message-State: AOJu0Yx7zSIroZGAIbZ8QTyY4pNh303ob8dPmsUf33aqyr3HLqiwcsb9
	rydK8g4xK23x+3tTUcdnzHczuA1HVpqtqnV6acRH7dJ8TZxdXk1U
X-Gm-Gg: ASbGncs6gwR9nPlyLnZnnkqQhqGjGQ1JK6yKAsYNbeVd+i0YcC6MSUSE67osbuM76K+
	yxyt345G5IeBCZAkq7yrrKf2fHAz5qzPDE0PECOJ9C5yUg8jZGoejJZyTFhbOlv4C3JddXhlEzU
	NIrP1YUZcnwEMZiFjVJzj5hTsSBljZbqd387tO9k0RRGSlp22IzUS0de4b+ZKMwXLEGA9ht82we
	CfWnRTgjbKz/zCASX6p0S52KFuetUMHcgUOxCSMMg4LtebGrjLUiJkPXLXPBWESGS+X6LVgC9U6
	E4+lxmuEit7CXF0xSRErim1pUOKiywe1RodKR+jMG/M4k9mWdK4hzIqXOk1ClDWb77CskuXFcCA
	=
X-Google-Smtp-Source: AGHT+IEt5aIX5hgK7fGMy5n1h1wbFtFxkfXs68tFg8ZtnZPFa8D2b0E18ytl5EMeXXykVjUNSNHNSw==
X-Received: by 2002:a05:6402:2753:b0:5ec:da2e:6f4d with SMTP id 4fb4d7f45d1cf-5edfd1572ebmr7098544a12.18.1743426854351;
        Mon, 31 Mar 2025 06:14:14 -0700 (PDT)
Received: from localhost (78-131-14-102.pool.digikabel.hu. [78.131.14.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16ed61esm5611349a12.34.2025.03.31.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:14:13 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:14:12 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Allow cloning from repositories owned by another user
Message-ID: <Z+qVJPQ17urm06QN@szeder.dev>
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
 <20241115005404.3747302-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115005404.3747302-2-sandals@crustytoothpaste.net>

On Fri, Nov 15, 2024 at 12:54:04AM +0000, brian m. carlson wrote:
> Historically, Git has allowed users to clone from an untrusted
> repository, and we have documented that this is safe to do so:
> 
>     `upload-pack` tries to avoid any dangerous configuration options or
>     hooks from the repository it's serving, making it safe to clone an
>     untrusted directory and run commands on the resulting clone.
> 
> However, this was broken by f4aa8c8bb1 ("fetch/clone: detect dubious
> ownership of local repositories", 2024-04-10) in an attempt to make
> things more secure.  That change resulted in a variety of problems when
> cloning locally and over SSH, but it did not change the stated security
> boundary.  Because the security boundary has not changed, it is safe to
> adjust part of the code that patch introduced.
> 
> To do that and restore the previous functionality, adjust enter_repo to
> take two flags instead of one.
> 
> The two bits are
> 
>  - ENTER_REPO_STRICT: callers that require exact paths (as opposed
>    to allowing known suffixes like ".git", ".git/.git" to be
>    omitted) can set this bit.  Corresponds to the "strict" parameter
>    that the flags word replaces.
> 
>  - ENTER_REPO_ANY_OWNER_OK: callers that are willing to run without
>    ownership check can set this bit.
> 
> The former is --strict-paths option of "git daemon".  The latter is
> set only by upload-pack, which honors the claimed security boundary.
> 
> Note that local clones across ownership boundaries require --no-local so
> that upload-pack is used.  Document this fact in the manual page and
> provide an example.
> 
> This patch was based on one written by Junio C Hamano.


> diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
> index d9a320abd2..286099390c 100755
> --- a/t/t5605-clone-local.sh
> +++ b/t/t5605-clone-local.sh
> @@ -154,6 +154,16 @@ test_expect_success 'cloning a local path with --no-local does not hardlink' '
>  	! repo_is_hardlinked force-nonlocal
>  '
>  
> +test_expect_success 'cloning a local path with --no-local from a different user succeeds' '
> +	git clone --upload-pack="GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack" \
> +		--no-local a nonlocal-otheruser 2>err &&
> +	! repo_is_hardlinked nonlocal-otheruser &&
> +	# Verify that this is a git repository.
> +	git -C nonlocal-otheruser rev-parse --show-toplevel &&
> +	! test_grep "detected dubious ownership" err
> +
> +'

This test succeeds without checking everything it is supposed to:

  + git clone --upload-pack=GIT_TEST_ASSUME_DIFFERENT_OWNER=true git-upload-pack --no-local a nonlocal-otheruser
  + repo_is_hardlinked nonlocal-otheruser
  + find nonlocal-otheruser/objects -type f -links 1
  find: 'nonlocal-otheruser/objects': No such file or directory
  + git -C nonlocal-otheruser rev-parse --show-toplevel
  /home/szeder/src/git/t/trash directory.t5605-clone-local/nonlocal-otheruser
  + test_grep detected dubious ownership err
  error: 'grep detected dubious ownership err' didn't find a match in:
  Cloning into 'nonlocal-otheruser'...
  warning: remote HEAD refers to nonexistent ref, unable to checkout
  ok 21 - cloning a local path with --no-local from a different user succeeds

The 'repo_is_hardlinked' helper function expects the path to the .git
directory as parameter, but in this case it gets the top-level path of
the repository instead, which results in 'find' rightfully complaining
about the non-existing 'objects' directory.  Thanks to the &&-chain in
'repo_is_hardlinked' this error then causes the helper function to
return with non-zero error code, just what this test case expected.

All other tests using this helper function create bare clones, and
they all pass the right path as parameter.

The trivial fix would be to either use a bare clone in this test as
well, or to pass the right path to 'repo_is_hardlinked', i.e. the path
to the '.git' directory.

The right fix, in my opinion, is to teach 'repo_is_hardlinked' a
negation parameter, so tests expecting the repo to be not hardlinked
could invoke it as 'repo_is_hardlinked ! <path>'.  An error from
'find' within the helper function should then always result in an
error of the helper function, i.e. both with and without that '!'
parameter.

Furthermore, this test should use 'test_grep ! ...' instead of '!
test_grep ...', so we don't get that misleading error message in the
test's output.

And there is a stray empty line at the end of the test as well.


Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228A3DEFF6
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648689; cv=none; b=jam6F/yqj6cEO0ZOHms3e1rmhLDIW476l6Yz0DIPIeScX4gPh4vOcw/t8rvBrs5Ihtd1St4z0h17mhbd8oCEBAp69by/7oxA81p1oEnavzM6tHcX+eqPPQKxbski8etwLqW7TGlsitfK4KWqT546wxbe/Cl/dXjf1tQHyEP5dlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648689; c=relaxed/simple;
	bh=skGb05ucf2VzTF/0qa35d5DkQu1jo/CURBiRaOyj0pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QqJ29l68GMRYKp9MTzjXlc8Qr8yUzsixtfqYynOPaSt3tb+ezt01jGhX/wUMHRz/9gczr65kipDqtn1jLWrGoCERnPclSmYQtz4sQkMZxjIPAjWGULrUkbY1XevIwxmdYSzxW9D/yhIWuq5Z1e94CnszwhdqKAIS1McCGjLcnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWxQyVNB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWxQyVNB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so3139439f8f.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648686; x=1788253486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6N2ekp9DwB0huh25zrH48YDLs3wJYQGwkwkQNjJRv0=;
        b=DWxQyVNBgQ2TWRFIkgrHarqNokcp9XPOz0YkgUXtG9fbgH4Nc3w2pT9Ml1uO4QAu/+
         LvuXrKhd2SdoOlaLxWnvTf1Kopu5Bg+PT3yOjoBUSri0TtlqyhouuPJs0UWhYwAZRCoG
         xRxFoCODM9eWYqrtrRqCZ2eh4sTUgZrZ6pr9vO5oAFnbQiH+TgMIKyHACupzKI8HQKPT
         HaigyjYetqcTqSvkM+Nf8yIpxpyH22kwZvxcQ0LgPhqNPJ2xwyzUKzk0YkaEs+KphPMW
         vl1UiCVi+ResdOpDzzZ165Bojgwt/PhvOTLztY8370vsV+xScI+uIZH2EG+z4D0fCnbW
         CjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648686; x=1788253486;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6N2ekp9DwB0huh25zrH48YDLs3wJYQGwkwkQNjJRv0=;
        b=b4BFblYF7xrXL8zDfd/ITs5LJzKU6/29PcM5k2EjD2+N4UiO0pNIj2m6SwZ0jC3j66
         wV7V3psPV/z21H3DHqCDYafoiNzIqD8C1pmKIuizaLNPQsUEFA0tvAknjq7uXqDvTPZU
         hYyxbJhGU/nS5R50XVmxprVqzb3P6+G6+uTUMRKGLeokb/Bahf0yQ5YV2Lwgn3IvcI50
         W1ns4kkUaicffKCz4g/MyK2fPXgh4BHNsge8/V4L8XAOA6UnlPko7R1f8ajObGqtfGrb
         g3fvuM7vYjYppGWjYxOx6wUGXnkdK4+WjvWYac4CX2e1AIi/jNIKQ3PE+Fx6ghCMkBgo
         yRnA==
X-Forwarded-Encrypted: i=1; AHgh+Rqo8urifFWk5ylnrLzxv4nJcHw/ZB/HdGN5x4vetehiaMeGajmhOGed3AVSE7YUkl7ln+w=@vger.kernel.org
X-Gm-Message-State: AFuF++ne7KsSLHjwb6/lIv+zdCFO7FWgLOhEWBV/Tq6eXvGHEMCPO9S3
	Poe6Y2p5podW1Tdd4MLoabfA5qwCF2LyOZTZp0eqbuwQDjEAzeMTR7rT
X-Gm-Gg: AR+sD10FwI1JTh5DkdB3jX8WM91Z9NuunGwkH4vfmtnxrXcnLKQgfiD9wufMTEx8Gc1
	El9XZEp5ru3nqNRjMvHz5aL58P8akW6UlWA05aV82KNpIhJNfEHlKGAGEmr4in8QdJAy2pgHBNY
	ebCGVEkk2ZSjlsgW4SwdqcVJsU3vHXGYSKqSM6ffNbQiHJbHT08PGedNXw02282+I7OWh2/enqz
	kEt2jPZupdV5o7pZpMAXpXLsowZZTksUy8ulw7u3nvndXqv6njNR4VjxAUW0Fnk7dEl28wxjJoa
	Wr+X87GsvEdT1XWF0atrOwlBfrokqOZduQbFFl8Dam3749KGS+eVsJEpZxc0RqtZU3kNi/Bd759
	c4EyQuHNv+xlelOSZvF6orczW00ljQoIwBxXI2xMlWhDxSZspq2rwmo9ekvTJHkA4/BndqQH6V5
	5ueEZilgypfY+HseF+untUmoSUm3R2xTXkWhCwnkq19mgDbM7rKZjkGrLGTLpELsNNWwAd5iL9/
	4NMZwZ+Hca4egYv8ZN91yFnD1NW14ZEwo/JcvriuChq6HdW0YnmZQ==
X-Received: by 2002:a05:6000:1446:b0:47f:c648:e280 with SMTP id ffacd0b85a97d-482d9f26da2mr5219025f8f.18.1787648684194;
        Tue, 25 Aug 2026 02:04:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482df59db9asm429672f8f.34.2026.08.25.02.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:04:43 -0700 (PDT)
Message-ID: <d6940aa6-9336-481b-8ee5-5e3d9f3d3a50@gmail.com>
Date: Tue, 25 Aug 2026 10:04:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260729233215.398654-7-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 30/07/2026 00:32, brian m. carlson wrote:
> Git has historically allowed either lowercase or uppercase hex for
> object IDs, but it has always emitted only lowercase.  This has caused
> people to expect only lowercase and not handle uppercase.
> 
> As an example, Git's own example hooks look for "[0-9a-f]" in several
> places, but there are many other Git-adjacent pieces of software,
> including Gitolite, which make the assumption that object IDs are always
> lowercase.  This is not to criticize the authors of these projects, but
> rather to point out how common this assumption is.  In fact, it's so
> common that we have only one test in our codebase that fails when we
> reject uppercase object IDs.
> 
> More critically, it leads people to make security-based assumptions that
> an object ID either does not contain uppercase characters or that an
> object ID can be expressed uniquely in hex form, neither of which are
> currently true.  Git itself normally uses binary object IDs, which
> avoids many of these problems, but most other projects deal primarily in
> hex object IDs, so they are more affected.

Can you say a bit more about the security problems please - I'm trying 
to understand why ABCDEF is a security risk when abcdef^0 isn't.

Thanks

Phillip

> In preparation for Git 3.0, only allow lowercase hex object IDs in
> breaking changes mode and document this as well.  Update the single
> failing test and add a new one to verify we reject new uppercase object
> IDs.  Note that in t5324, we change the hex character from "A" to "b"
> because in SHA-256 mode, "a" is the correct value, so our test_must_fail
> assertion will unexpectedly succeed in that case.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   Documentation/BreakingChanges.adoc | 5 +++++
>   hex-ll.h                           | 4 ++++
>   t/t1503-rev-parse-verify.sh        | 5 +++++
>   t/t5324-split-commit-graph.sh      | 4 ++--
>   4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index 73bb939359..dbc46d14e3 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -171,6 +171,11 @@ JGit, libgit2 and Gitoxide need to support it.
>     matches the default branch name used in new repositories by many of the
>     big Git forges.
>   
> +* Git will accept hex object IDs only in lowercase. The fact that Git has
> +	historically allowed uppercase characters in hex object IDs has been the
> +	source of a variety of bugs and security problems in software using Git. We
> +	don't expect most users to notice any change.
> +
>   * Git will require Rust as a mandatory part of the build process. While Git
>     already started to adopt Rust in Git 2.49, all parts written in Rust are
>     optional for the time being. This includes:
> diff --git a/hex-ll.h b/hex-ll.h
> index 9da76f17e8..2f9c8d7c25 100644
> --- a/hex-ll.h
> +++ b/hex-ll.h
> @@ -6,7 +6,11 @@ enum hexkind {
>   	HEX_KIND_LOWER = 1,
>   };
>   
> +#ifdef WITH_BREAKING_CHANGES
> +#define HEX_KIND_OID HEX_KIND_LOWER
> +#else
>   #define HEX_KIND_OID HEX_KIND_MIXED
> +#endif
>   
>   extern const signed char hexval_table[256];
>   extern const signed char hexval_lc_table[256];
> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> index 87638a4a2c..f07b45de5a 100755
> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -60,6 +60,11 @@ test_expect_success 'works with one good rev' '
>   	test "$rev_head" = "$HASH4"
>   '
>   
> +test_expect_success WITH_BREAKING_CHANGES 'rejects uppercase revs' '
> +	UC_HASH=$(echo "$HASH1" | tr a-f A-F) &&
> +	test_must_fail git rev-parse --verify "$UC_HASH"
> +'
> +
>   test_expect_success 'fails with any bad rev or many good revs' '
>   	test_must_fail git rev-parse --verify 2>error &&
>   	test_grep "single revision" error &&
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index bf7ba0e558..29db815c77 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -349,7 +349,7 @@ test_expect_success 'verify after commit-graph-chain corruption (base)' '
>   		test_must_fail git commit-graph verify 2>test_err &&
>   		grep -v "^+" test_err >err &&
>   		test_grep "invalid commit-graph chain" err &&
> -		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
> +		corrupt_file "$graphdir/commit-graph-chain" 30 "a" &&
>   		test_must_fail git commit-graph verify 2>test_err &&
>   		grep -v "^+" test_err >err &&
>   		test_grep "unable to find all commit-graph files" err
> @@ -364,7 +364,7 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
>   		test_must_fail git commit-graph verify 2>test_err &&
>   		grep -v "^+" test_err >err &&
>   		test_grep "invalid commit-graph chain" err &&
> -		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
> +		corrupt_file "$graphdir/commit-graph-chain" 70 "b" &&
>   		test_must_fail git commit-graph verify 2>test_err &&
>   		grep -v "^+" test_err >err &&
>   		test_grep "unable to find all commit-graph files" err
> 


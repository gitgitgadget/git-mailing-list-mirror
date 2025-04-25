Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE81253949
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589229; cv=none; b=PTNWvsxThaZidki9WM8VOBbaWiaR3mAoCNV5UMDW7tD3cNCSLlKSfvNRMMipHRulsbn/RdK2d7apXNYxtTsI2ffIsrbVz4R22T3S45gUwXHU+GyyHxAJbOCZCaTNvL++lkZ7iGvnkBFgcGJljwoH5hRhQAfCTRjx406sYq/8awE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589229; c=relaxed/simple;
	bh=2Uy7yvB65zsYrGjWrYBdo4f4gCAbSWdNDktaTE3IbZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwY3WKbGdjtEd0wAzpXtLAZqJ48MMLD6NPYIceh+/uJwr3HQXbNmmHXyQHAuoTIsXb/kYfQUU1zTTy+JS8ydSFZXJSsIUB9DvPIJ8680axn3bjRulxqxgSFM4U6B48tHccCGnoT7mZ+ezSRwtPmTzJ9PthWJdJ28wTqNiHgzoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCOYn+DR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCOYn+DR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso13095875e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745589226; x=1746194026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rKk8dbwcwRPv+V9UfhAvpwPgrVs4TDle2ebfpfAvJng=;
        b=MCOYn+DRGL8WZQjlt5Ag7klBg/Cvz5n7HGmatBMuGsE2h7xYgUbJ0vV2lQ6OSBwzG1
         q4cvnAZtGVLDkcKKVwTGf5kTFkpEEK31eGeSLTwRS6uGX1S7yu3wRZLd58zfpovFzKgj
         vojcV4CuZOsis6jGmfK4YzbFkIicuPbQCqZUGEgd5cW10jwDQ5vn92eDNaeH9NkxPguq
         Jq7KpqvAvIEZ0Iso03plag5YCmgLj6Z0X2vCukFzRbmtzBMqIhN9InyRqUKTZ6QV1JxX
         ZvpU2ZMInlaBiCf68RZAT+7uwvUe7mG3xq533RRLYFBzpVLizC9EbcsRLV+AeGOYjJ2A
         Se1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589226; x=1746194026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKk8dbwcwRPv+V9UfhAvpwPgrVs4TDle2ebfpfAvJng=;
        b=YehWqudbqgvAE+7YrCSMHUR67sdcCmgzxzEIhMjUjW7+EeJCmbHQgWA3t3W4NVCkmj
         mSFNHfqF6v5m1XYkKqvgaQ2W6B1aK35EHyJtyfy6mbBNB5KcxhOXeu9lEH3/D6bIVpAk
         1RrZhwMXt9EpaS+6UG6ZT5ipLTIoaFeeN1OmisiVqCa4/cr9z7IefsvylJKL+KCp2UTZ
         eYL/+AMH7eAy5nGwlK8e2a+M6YBn3tFvX2FhQjDjb43VsxqbOnAKpP8yrTvvjQ67JG96
         1VQa3X+zlhPQlx2AbfXOzKXsykOc5Jtu9noAoHrqyeUN8eR6tNTSWkhha+Agpeoqu0CV
         cwvw==
X-Forwarded-Encrypted: i=1; AJvYcCUp3/RwSqlj2zsaeGVca1eTUKd9jW/JnNJb0LrD4g7eXXnnRANh0U3OlRAcfA5Qw5BB2Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Sd0bA9hPlDbwbimbI6cbbCFZk4CpJH5oYlFRGzgumqEOYH9a
	43fdEpePhXZSToLcIoV7Rwl+4lGh7BSIPlvZZ/H1HzuRLrA+uzNa
X-Gm-Gg: ASbGncv3e2aXbkCRrw5XS1OP9MftxyW2nhVTMLkhjbJFcJ1EIzGOCdtnuA2s3pprg/z
	z3ve4B+ate0Uzuv10DtuNl/WF+Nsn+vDfbBVyg7L2ZE+cEJrbA+wVMhYTtE/i4JmQn5UIqpVPtP
	Id2zJv/SdQuVCOOyXTdKnkfpUzZiEjZjKgZlNcpKEcQGsMz/0qFg+uzAJdQMF8eyMVB1FKuXRAO
	tf63jKx3OW3ZufC94Q1+pMpi0VRPouCGVpMLUH2ciGE5tC2BTdQCAmwt6IDY9xdKeS3ZeuUkLbj
	xdH8IesSWL3yYRQRHqmJeyOi/0Vfu67QZSHBbIsiqIsZoSFWtQiwMU8mRBPXasb3Di5JHaCNywW
	kGHsafS2zyJBIh1a7
X-Google-Smtp-Source: AGHT+IENU5Di+VW3ZunA+1CfIR8ptWkb5RnDB6SWIzF7cq7gvVVbSLpqVVyKKTHtO8o1RceVhVnruQ==
X-Received: by 2002:a05:600c:19cf:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-440a66abe47mr16300405e9.20.1745589225749;
        Fri, 25 Apr 2025 06:53:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5287a94sm26267915e9.0.2025.04.25.06.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 06:53:45 -0700 (PDT)
Message-ID: <ce33a9ad-e931-4408-92ec-1a898e908c36@gmail.com>
Date: Fri, 25 Apr 2025 14:53:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Toon Claes <toon@iotcl.com>, Scott Chacon <schacon@gmail.com>
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Scott

On 25/04/2025 14:17, Scott Chacon via GitGitGadget wrote:
> Updated the test with Taylor's patch.

Thanks for updating the test, unfortunately the documentation update 
mentioned in [1] to ensure the refspec in the documentation matches the 
changes in this series seems to have been overlooked.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/56d8bd34-1301-40d6-8151-f85fb1d7560b@gmail.com/

>> bundle-uri: copy all bundle references ino the refs/bundle space
>> bundle-uri: update bundle clone tests with new refspec path
> 
> Scott Chacon (2):
>    bundle-uri: copy all bundle references ino the refs/bundle space
>    bundle-uri: add test for bundle-uri clones with tags
> 
>   bundle-uri.c                |   2 +-
>   t/t5558-clone-bundle-uri.sh | 202 +++++++++++++++++++++---------------
>   2 files changed, 117 insertions(+), 87 deletions(-)
> 
> 
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v4
> Pull-Request: https://github.com/git/git/pull/1897
> 
> Range-diff vs v3:
> 
>   1:  2ccbfdcc2dc = 1:  6957ee2fed2 bundle-uri: copy all bundle references ino the refs/bundle space
>   2:  d148b14c390 ! 2:  d9a114915a3 bundle-uri: add test for bundle-uri clones with tags
>       @@ Commit message
>            bundle-uri: add test for bundle-uri clones with tags
>        
>            The change to the bundle-uri unbundling refspec now includes tags, so this
>       -    adds a simple test to make sure that tags in a bundle are properly added to
>       -    the cloned repository and will be included in ref negotiation with the
>       -    subsequent fetch.
>       +    adds a very, very simple test to make sure that tags in a bundle are
>       +    properly added to the cloned repository and will be included in ref
>       +    negotiation with the subsequent fetch. ok, now it's right. christ.
>        
>            Signed-off-by: Scott Chacon <schacon@gmail.com>
>        
>       @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '
>        +test_expect_success 'clone with tags bundle' '
>        +	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
>        +		clone-from-tags clone-tags-path &&
>       -+	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
>       -+	grep "refs/bundles/tags/" refs >actual &&
>       -+	cat >expect <<-\EOF &&
>       -+	refs/bundles/tags/A
>       -+	refs/bundles/tags/B
>       -+	refs/bundles/tags/tag-A
>       -+	EOF
>       ++
>       ++	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
>       ++		>expect &&
>       ++	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
>       ++		refs/bundles >actual &&
>       ++
>        +	test_cmp expect actual
>        +'
>        +
> 


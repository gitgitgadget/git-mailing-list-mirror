Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABE1EDA35
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144350; cv=none; b=DXoV/hQpS/T7TNebRjoQcJF8nGe7HnIoBq9O89e+f0OpTMn/IIqJTeYGVx/VrKolZOFTaBYxuxjWrh+TAmWN3HHe/5l6H0E0JYrB2zv9X9sITq4uqD1sGIBnHnfqI8wSgqNO8XyHBqmkac/wl84OSEXFES5sO5bM+S58Emm6mLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144350; c=relaxed/simple;
	bh=sx01uNkcJrBi0+7BbRTW3CtKc6pD2REj4Y42QYe/Xgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIt3An/kT63TnEJntqW0CAMbXZQTj9eDCBvwg7TPJ8ZjYq9VYLju7qtFDjeIMOAR+/BRTOSX5ffo8RlBjBA36HafySebnsUxpha89mlGmjnlq6mSuzlY5OtbLpB5KF5wzdueip7Qi7dNM02c+7lDwp1xxO3mDQU027cs1SLX43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI7rUL1A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI7rUL1A"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b933f214so2575787f8f.0
        for <git@vger.kernel.org>; Tue, 13 May 2025 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144347; x=1747749147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F64LR2+oQ7N0+IWKfVNzsykcayQ40HmhkLmwmQUeux8=;
        b=bI7rUL1AHOjUHvnixZOdkNFilkqE8GezXdFCvUIU91bCvNm0j2epz53C7mqezS6tIL
         +88qBCfOUxCWyYycfYYkMQsotYA8dhf908sFZVE5L+PkLqsp4u8TWSVsL1hsld+0nsk9
         ifYXrnkCiC707lPmVBIoE02jovuasiP6linQOI7CBWo9OhtrqIfhZUliouxuwjBuCekF
         ZWQF0I/IUGdcKiFWumD9mlAxygbdrHQfcUFPLKrKOcJ+Cexzzvf4p10T1H9PN0q92LJP
         9lKfAeU5HqN6XhupCvw2BnhI/KGAd0fcF9WqOaFWvFutlhE0pXfsrkJpSD1xvMRrbM8l
         nHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144347; x=1747749147;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F64LR2+oQ7N0+IWKfVNzsykcayQ40HmhkLmwmQUeux8=;
        b=VuvtD2gyL3oION3clPe6Lkl3fHZC48hiIS65+LldazdPr7b5RXt/RS9BsQjLhmdrVm
         Yi3D1DiiEpfxmQwzmwRuZ/BDIlznOEO8gnEipTXS2fd3O771rPQaKTsxAK0H7L/OLJK8
         /OY6uOFKMKdXhKWcBZVniE34bGYl+Uaok1UFHfgiS9bpBkqt83Zd1R/eeo1uPrbPHKrV
         VIB6wVyg9JYluy8PKGJZXhDzT2VHYDX5T70B+ntMkY6DUZNgYa2jIYnpubmu7svl/yoa
         XJ+0LSYP/N1G2iR3o0s7iX2Ww0FawI6gawvcqQ4Qx6/5uxuX5+xsFag0wke6PD6TR2Sf
         03vg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsvu9kHsSy2P/kS/e4caJuEnb5K/ICmLqck7UUZutvgFDH/u0d9bbYqSOM+uZ00CHFvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1OZB7WWOe2pRLmaGKcWYEdRvPUqToVlINsics0S434jY9qbs
	uV/+nyuS4Ye+vp71eU9MHDwRLe9TfGGY8dC5+WxuzDCokPzUcQYo
X-Gm-Gg: ASbGncu1idlR/HZtkte4ja9I1S3fzC0xqjy4RSvDft1159JPIhZPLVELE3wKeZ06WCJ
	4TIEb/83QCXQUTNtvH0mk2mCrfJLekVnub/dgYe9ZShlVG4D4fd+vAduUfxNuLDrLFbULGMTVMf
	ysu1QYfI7lrUdZYeli4ITz44IhvHPmcW21Yz4qINT4KYaZakV+c0w9r86R/ZAo656k1isp1EZh/
	EZRrPRrNfkA9fl65bmxm7+02Wmek91B50e17UZ3OaOW0MaNHAxYPJxkHMFAWo1CTIeNnqqNzndM
	+LLE57GtXwsYQ2Oy96+qKUEP8aK+9ZpKGAiyfgElyvv4sGFCD9DF+BK7JRADnvMQhQXr+/9ETaV
	JyX2CVDUgHwhCvX4feFdBnbKwH80=
X-Google-Smtp-Source: AGHT+IHL3voC4AIaN1fZYQ64OMC8yTq4gLKliGTEmbioqhnZhZvBKXRoqMBBrF4C6oVD/gU9KlCBTA==
X-Received: by 2002:a5d:5f95:0:b0:3a0:b84c:7c64 with SMTP id ffacd0b85a97d-3a1f6435b6fmr14191448f8f.13.1747144346900;
        Tue, 13 May 2025 06:52:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2fc4sm16537200f8f.56.2025.05.13.06.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:52:26 -0700 (PDT)
Message-ID: <f00cdfa1-343a-4fa0-bce5-e06d1ed62c22@gmail.com>
Date: Tue, 13 May 2025 14:52:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] add-patch: respect diff.context configuration
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 10/05/2025 14:46, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> Various builtins that use add-patch infrastructure do not respect
> the user's diff.context and diff.interHunkContext file configurations.

We could expand this slightly by adding

This is because the plumbing commands used by "git add -p" to generate
the diff do not read those config settings. Fix this by reading the
config before generating the patch and passing it along to the diff
command with the "-U" and "--inter-hunk-context" command-line options.

> This patch fixes this inconsistency.
> 
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---

> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	repo_config_get_string(r, "diff.algorithm",
>   			       &s->interactive_diff_algorithm);
>   
> +	if (!repo_config_get_int(r, "diff.context", &context)) {
> +		if (context < 0)
> +			die(_("%s cannot be negative"), "diff.context");
> +		else
> +			s->context = context;
> +	};
> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
> +		if (interhunkcontext < 0)
> +			die(_("%s cannot be negative"), "diff.interHunkContext");
> +		else
> +			s->interhunkcontext = interhunkcontext;
> +	};

Thanks for changing this. This iteration of the code changes looks good

> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index 1384a8195705..c4b861c360cc 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh
> @@ -52,6 +52,46 @@ test_expect_success 'diff.context honored by "log"' '
>   	test_grep "^ firstline" output
>   '

It's great that you have written tests for this patch but as I said
last time I think the new tests should be in t3701-add-interactive.sh
as we're interested in testing whether "git add -p" passes on
diff.context to "git diff" , not whether "git diff" respects
diff.context. I still think there are too many tests here as we know
that all the different "-p" commands share a single code path. Our
test suite is slow enough already so we do not want to add new tests
that do not increase our code coverage. I would suggest removing
these tests and instead add the following in t3701

test_expect_success 'add -p respects diff.context' '
	test_write_lines a b c d e f g h i j k l m >file &&
	git add file &&
	test_write_lines a b c d e f G h i j k l m >file &&
	echo y | git -c diff.context=5 add -p >actual &&
	test_grep "@@ -2,11 +2,11 @@" actual
'

test_expect_success 'add -p respects diff.interHunkContext' '
	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
	git add file &&
	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
	test_grep "@@ -2,16 +2,16 @@" actual
'

> +test_expect_success 'negative integer config parsing by "add"' '

Perhaps "add -p rejects negative diff.context" would be clearer?

> +	test_config diff.context -1 &&
> +	test_must_fail git add -p 2>output &&
> +	test_grep "diff.context cannot be negative" output
> +'

This is great but again we only need to test a single command and we
should do so in t3701. We should also check that negative values of
diff.interHunkContext are also rejected.

Best Wishes

Phillip

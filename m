Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E92CCC9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402708; cv=none; b=Skct8brQarbQjA6w8H/LYlGM42nMAFa2C2o+Gl1WYCMFd0MgMUJ5Bf+mjd+Vb5y9IQfIvBMjPjNbBxTfhnoSpiUUQ3FGBjre7mBAqFFZZzh3GzfYfcmQD8aIxRRanSaoR2fy3BSAXA1pBCr/rY5CltxXk8NNIVChcWjk5wi0/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402708; c=relaxed/simple;
	bh=51/trB4G5+dgAe8MoM+miAdyHHA6Sj9Y1Wf5aqQxtJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eSLQ5xjPJeY16YTouVWoJI31JjRoRDzbPqTCQKSQWyrN5+lkXeH7BJaYQJDMuTqcbalYAj75gplhTnrjmUR41bJBOgJ3Uc1iFF/OczKee4wnwAbfuxh8hqr78UW1Zf+66kyZosq0ZWKjEWe6kcSd2mEvK84JTg+hg4CPXSmGpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBA4mXiH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBA4mXiH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee651e419so3565759f8f.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402704; x=1746007504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouf+PkqYVimnO1nNhOgreAG8ql+lNiBQEmy3NTb7W8g=;
        b=ZBA4mXiHzc/TtVh1NRRQ+Xqd0Y0hEbkQ6ZFo/n/76YVQDC4op8wqmjRXHCWX9jEogO
         F0mC0vtsvGgAamFwbGDUbbQ5lXn6v5fUakz5y2hmda+3JkSTlLvNbrZkvfmpSUE0N2vU
         ESDnea8afz2UsoCe0QZCoTSxfNeRfupPx4HkxrUY7sdR9RNm0AI+hREWrvMs3ehKkDv4
         IDQBa6pT8ijokkMO02IqqFDtIV0Xm32zA8q4/N74hZ7UfoxcLemRgddZOs4pU03i4Mqw
         7q8CvKOdcp8rr+eJiyluA4XlrHs23tDRV9R7+uLuVnrHeI1MVg8z7WhSdj1GIrTPv0+i
         CGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402704; x=1746007504;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouf+PkqYVimnO1nNhOgreAG8ql+lNiBQEmy3NTb7W8g=;
        b=WZmD+68b6ha3mPNQbfaUdWvcv4prvPS8GGzfkM5Anyi8m//b5aKmrSGyi3Wn8kV+Dr
         hGUK0ep1SMk3IJ5yNTTPBvFxwDdYgAZY7B53RuBZkXrYQsvOP3/8ckMBudMm31i7332S
         nitEXO0aMDH4aYmH4ND6yaZY9p7u5m0LqJYKWeALEaLwwoC4V6zavZELK8BQQVavG0Zn
         VBvb0r3nrr6pH9ZFbIOsAxp3+YGbK2udAt1clIM5ES3JTh7SkPphpUttj5PXo2Jy+J8Q
         ++ushW/ERi4SmeZt02ypcY0VtluHktbYV6smuCgkVzeJsML0qfxtrTFtogJsWc+MTBu6
         M/eA==
X-Forwarded-Encrypted: i=1; AJvYcCU4CNL5beHUqrPzeO1I9JEY3iA6orUz68oT7/Zknwiyplh4sTaurITK3O0u3/0eTkZEC5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4S0prTHbKNlMI57a5cfS8jn2x6M2vkZUDozLNGJuo3Wq6/Gc
	DTcSIiZS+lgvR7Xf98uu0/NUxyD+F+rwPt1mWSnycarlfXtiFIL/
X-Gm-Gg: ASbGncssWKHlUFAkwJNZVZL5JIfD2/eokxbPcFiUO6bAg/uswx8WNkeVbTtinpTBgIe
	RbFjoWJl90LBZuTViahu0oF5uVWt8XfmgQ3KVJ7f+6sjwacA/PxJOfI252dVx3U1elub7Me1gAr
	vHQ7rSCJh6H/XHigDW8idVJfMzTAAFLfFAw0SLbjDozvgWyA+PqLaaPFYeYzh5HzOFK3Q84jQla
	BAfsGAHvAaMjyVBjgyWq1q0y84GeqWSFXgn4U1QSuGnp9LM+RrI+BCmFi1gSGCBTekthMa5BLKw
	es/eSo1QUxZ8CO9Y/uLnsYfSwR71tSeIHuOKRhxJq/zYDc4ouFjn1kDxMM54wlHig05jhzPJknp
	k3tbKIXdPlO/ACIIo
X-Google-Smtp-Source: AGHT+IGa1O9WFpv3tCRDk5YibPXlfYmtiZ9nq2Y9OtbD8yutcHDxsgMhKJwMmcQ6/WLsSPqt1gmWPw==
X-Received: by 2002:a05:6000:40dc:b0:39e:cbca:922f with SMTP id ffacd0b85a97d-39efba3655cmr13021234f8f.12.1745402703909;
        Wed, 23 Apr 2025 03:05:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa3a1685sm18206591f8f.0.2025.04.23.03.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:05:03 -0700 (PDT)
Message-ID: <3607a937-9795-4348-981e-dce92203c6d7@gmail.com>
Date: Wed, 23 Apr 2025 11:05:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/6] ci/github: install git before checking out the
 repository
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-1-d1e2be4b2078@gmail.com>
Content-Language: en-US
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-1-d1e2be4b2078@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

This looks good, I've left a few comments about the wording of the 
commit message but I wouldn't worry too much unless you end up 
re-rolling for some other reason.

On 23/04/2025 09:15, Karthik Nayak wrote:
> The GitHub's CI workflow uses 'actions/checkout@v4' to checkout the

We don't need "The" here

> repository. This action defaults to using the GitHub REST API to obtain

I'd maybe say "falls back" rather than "defaults"

> the repository if the `git` executable isn't available.
> 
> The step to build Git in the GitHub workflow can be summarized as:
> 
>    ...
>    - uses: actions/checkout@v4 #1
>    - run: ci/install-dependencies.sh #2
>    ...
>    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh #3
>    ...
> 
> Step #1, clones the repository, since the `git` executable isn't present

It would be more accurate to say that it tries to clone the repository - 
if we fall back to extracting a tarball then we're not cloning.

> at this step, it uses GitHub's REST API to obtain a tar of the
> repository.
> 
> Step #2, installs all dependencies, which includes the `git` executable.
> 
> Step #3, sets up the build, which includes setting up meson in the meson
> job. At this point the `git` executable is present.
> 
> This means while the `git` executable is present, the repository doesn't
> contain the '.git' folder.

I'd maybe say "source tree" instead of "repository" as it isn't a 
repository without a ".git" directory.

> To keep both the CI's (GitLab and GitHub)
> behavior consistent and to ensure that the build is performed on a
> real-world scenario, install `git` before the repository is checked out.
> This ensures that 'actions/checkout@v4' will clone the repository
> instead of using a tarball. We also update the package cache while
> installing `git`, this is because some distros will fail to locate the
> package without updating the cache.

Nice explanation, the code changes look good

Thanks

Phillip

> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   .github/workflows/main.yml | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 37541f3d10..e9112b3a64 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -414,6 +414,20 @@ jobs:
>       - name: prepare libc6 for actions
>         if: matrix.vector.jobname == 'linux32'
>         run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
> +    - name: install git in container
> +      run: |
> +        if command -v git
> +        then
> +          : # nothing to do
> +        elif command -v apk
> +        then
> +          apk add --update git
> +        elif command -v dnf
> +        then
> +          dnf -yq update && dnf -yq install git
> +        else
> +          apt-get -q update && apt-get -q -y install git
> +        fi
>       - uses: actions/checkout@v4
>       - run: ci/install-dependencies.sh
>       - run: useradd builder --create-home
> 


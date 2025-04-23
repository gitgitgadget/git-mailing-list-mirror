Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC92CCC9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402736; cv=none; b=AeP27b+epdtp6s2GHXIUr8HHFmtjRPpncE7jECn68ihYKTymEiEPK0BhdANcMvRxEksmPxQd+xpPYCTtg3992/IiH3oniXAVCdRWglyEicgRcdKbEzCXa51QcdhAmq0aFBnqtRQYcdjqOcSsjAadQUm8sBUftkxXsdnY8XCupGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402736; c=relaxed/simple;
	bh=Nm3Vuw5UtdserRMTRb1qbHUQh7zi2cl0FEIcQJpgitM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gBr5P0vAe0xjjEFY67B8GwAdJBo4BHhzofHRd9CgPCNp5uhM3Qya7ako75QS/Br6mFgE/xrFoj8PTGjwVPi/l8OPxqQu0KAXLG1kCsZu6RXsJseVYy/1nlGwi9NzVK/cL58nqpkXWakOej+rQDt072KdUhcRmS2Sl6zxQ87uZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7632Gh5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7632Gh5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5670315e9.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402732; x=1746007532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orryWaBgt6BNwTQ2h1mpFJQLQPMG893hZbpCEsN8kP0=;
        b=K7632Gh5+nNb9XcvwPMfgY/wiw/tAO81cghi5I+dBarcmHEUeDZ6G3eRp0pCe2tjpq
         sDYBl8uo+aFqrYqwIFPkMp3JUveyCWoMWlswueqrf3iJC4vACqfN4pzghLuCqah9pwuo
         j4evKjbY9kX3leDoQKtCxc93T9nEur16ZRX7UGIEjlSVxAfYTV7svpbk5HtXTlhK4ZiL
         ULoC3PWSM67OzQ9ys66uTE5gPBe3sP3WgCztG/aQlLVLd23DmVapgkUGa2OtOcWZZTZ5
         IPlUoCoEkECAHMF7mFssTj7BUbiBOqD0+5e8dv2nUBvMkegDhz/lYybkifBVzUhy90OL
         I++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402732; x=1746007532;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orryWaBgt6BNwTQ2h1mpFJQLQPMG893hZbpCEsN8kP0=;
        b=nJEJdEpTjWS3fqVrp1QQIy9SEWcfqAijHrSzp4MElWtichvdKb2D5RvaSkt2225Sg6
         F7U7Cl+aYAqnpq/OffL7VOaaP6XsWYOydaT/1CcKGvDqCW+mlPDoW221lQo9uWYxV3jJ
         9Enx/YGw0QcL6xQnrfJUlQ774/4nv72Wj63fkI4fEdp1bUjXvbgHiWPSbsDOZ9mqarhd
         5M6vFe6nZTkg2JEfWdRV4cUUWQBPKDpyMv+q4TgEdCUDR8tDzaCzX8dq0+8Fvcwhudfv
         /jnxd1W0cN1IfDenanHyrMQstKnGp5BlxYIeeIXX8IF+vx9VZv1ngZRoHlWHnQ0YWoP/
         VV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYVyEQ2qOcIIJmALLPhg5ZqrVeQ3M0PqwWTNIk4Edhgvl91Troh0bSalH61wVWSvosM5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKikjJU4whAI99J+hU0/l0Feo5XC6zH54W/IypTQQKg5vI0+6P
	BtKdrzTBg/uR6SCb8hRqz160rMPEWrEtOAvthPn4TVKrkxDgIrjY
X-Gm-Gg: ASbGnctJ7xvfPC99bsri5ZDYkbSXCGf28s9Y4eWhn74mJ3IWZ+D1aOnJGcXSoi7WUgz
	Rf7HAN8Y1DLmW0wD1vn4xXAcD7oPSK/qJOtKKZO8lDBcEk7suSyOJm+/Vkl66MDKi4Ncigwwy+I
	LgS8Xq1Zt90A1+aY1GrH/KkU6nntWuH/WQumBFkiHyeTAsXf6KJWEkE2sEqO8Ag7GVGfvFKzUc0
	Jwl7AKeMpgXMGzik2P89dpZ03h5dKgq1UTfCp46csHx5esBKrl9HAIzy6/otdYOviGyLUCwTQxI
	AVlvCbkdvkmAtxDyKhpiW7YMUfT6krlUz2Vg4tYohoOU1NfGKfrvZy0aHW10+vzkkAfG9LmVZtm
	NxQVDHz/JGozLagdL
X-Google-Smtp-Source: AGHT+IGYSuf22IzwWHvQO5DHisDRu28FV3lya/LzZk0kpTJaaBYF/eWo5rDk0JUaLPIEBhGy8w+OzA==
X-Received: by 2002:a05:600c:4e0a:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-44091f1facdmr18314395e9.12.1745402732123;
        Wed, 23 Apr 2025 03:05:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d21970sm20111735e9.9.2025.04.23.03.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:05:31 -0700 (PDT)
Message-ID: <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
Date: Wed, 23 Apr 2025 11:05:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
Content-Language: en-US
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

This looks good, I've left a couple of comments but I don't think there 
is anything that necessitates a re-roll.

Thanks

Phillip

On 23/04/2025 09:15, Karthik Nayak wrote:
> To bridge the remaining gaps between Makefile and Meson, this patch
> series adds 'hdr-check' to Meson to compliment the Makefile's
> 'hdr-check'.
> 
> We also introduce 'headers-check' as an alias to 'hdr-check' as a better
> named replacement in both Meson and make and add a note to deprecate
> 'hdr-check' in the future.
> 
> The first two commits are small cleanups, where we re-organize existing
> variables to make it easier to add the target. The third commit adds the
> 'hdr-check' target to Meson. The last commit introduces the
> 'headers-check' alias to both Meson and the makefile and marks
> 'hdr-check' to be deprecated.
> 
> This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
> 'es/meson-build-skip-coccinelle' merged in.
> 
> ---
> Changes in v5:
> - Add a commit to install 'git' in GitHub's CI before the repository is
>    checked out. Without the presence of the 'git' executable, GitHub
>    downloads a tar of the repo instead of cloning it. This causes the
>    patch series to fail in CI.
> - Expose the 'headers_to_check' variable even if 'git' executable is not
>    found or not a repository. This ensures dependencies of
>    'headers_to_check' can simply rely on its length. We also check that
>    the '.git' folder is setup before populating 'headers_to_check', this
>    ensures Meson doesn't fail in tarball of the Git source code.
> - Link to v4: https://lore.kernel.org/r/20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com
> 
> Changes in v4:
> - Rename headers to headers_to_check, since these headers are only used
>    for static analysis.
> - Added a commit to rename third_party_sources -> third_party_excludes
>    and remove a duplicate.
> - Fix a typo 'gcrpyt' -> 'gcrypt'
> - Remove 'generated_headers', since we use 'git ls-files' and that would
>    already ignore files within '.gitignore'.
> - Link to v3: https://lore.kernel.org/r/20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com
> 
> Changes in v3:
> - Some renames:
>    - headers_generated -> generated_headers
>    - meson -> Meson
>    - headers-check -> check-headers
>    - headers_check_exclude -> exclude_from_check_headers
> - Rewrite 'headers_check_exclude' to also contain dirs so we can skip
>    listing individual header files.
> - Move 'xdiff/*' to 'third_party_sources' and cleanup
>    'exclude_from_check_headers'.
> - Use 'echo' instead of 'echo -n'.
> - Use `fs.replace_suffix` instead of `str.replace`.
> - Link to v2: https://lore.kernel.org/r/20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com
> 
> Changes in v2:
> - Add 'hdr-check' to meson, while introducing 'headers-check' as
>    a replacement alias. Schedule 'hdr-check' to be deprecated in the future.
> - Link to v1: https://lore.kernel.org/r/20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com
> 
> ---
>   .github/workflows/main.yml     | 14 +++++++
>   Makefile                       |  4 +-
>   ci/run-static-analysis.sh      |  2 +-
>   contrib/coccinelle/meson.build | 31 ++++-----------
>   meson.build                    | 86 ++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 112 insertions(+), 25 deletions(-)
> 
> Karthik Nayak (6):
>        ci/github: install git before checking out the repository
>        coccinelle: meson: rename variables to be more specific
>        meson: move headers definition from 'contrib/coccinelle'
>        meson: rename 'third_party_sources' to 'third_party_excludes'
>        meson: add support for 'hdr-check'
>        makefile/meson: add 'check-headers' as alias for 'hdr-check'
> 
> Range-diff versus v4:
> 
> -:  ---------- > 1:  d20993a59e ci/github: install git before checking out the repository
> 1:  0f1160fa78 = 2:  6eb10dd3b1 coccinelle: meson: rename variables to be more specific
> 2:  933b199def ! 3:  7950b44c6f meson: move headers definition from 'contrib/coccinelle'
>      @@ Commit message
>           makes it easier to understand as the variable is now propagated from the
>           top level to the bottom.
>       
>      +    While 'headers_to_check' is only computed when we have a repository and
>      +    the 'git' executable is present, the variable itself is exposed as an
>      +    empty array. This allows dependencies in upcoming commits to simply
>      +    check for length of the array and not worry about dependencies required
>      +    to actually populate the array.
>      +
>           Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>       
>        ## contrib/coccinelle/meson.build ##
>      @@ meson.build: builtin_sources = [
>       +  ':!t/t[0-9][0-9][0-9][0-9]*',
>       +]
>       +
>      -+if git.found()
>      -+  headers_to_check = []
>      ++headers_to_check = []
>      ++if git.found() and fs.exists(meson.project_source_root() / '.git')
>       +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
>       +    headers_to_check += header
>       +  endforeach
> 3:  ab04192864 ! 4:  7fd64b788b meson: rename 'third_party_sources' to 'third_party_excludes'
>      @@ meson.build: third_party_sources = [
>          ':!t/t[0-9][0-9][0-9][0-9]*',
>        ]
>        
>      - if git.found()
>      -   headers_to_check = []
>      + headers_to_check = []
>      + if git.found() and fs.exists(meson.project_source_root() / '.git')
>       -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
>       +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
>            headers_to_check += header
> 4:  69a4b5abc9 ! 5:  df0472be57 meson: add support for 'hdr-check'
>      @@ meson.build: third_party_excludes = [
>       +  ':!xdiff',
>        ]
>        
>      - if git.found()
>      + headers_to_check = []
>       @@ meson.build: endif
>        
>        subdir('contrib')
>      @@ meson.build: endif
>       +  exclude_from_check_headers += 'sha256/gcrypt.h'
>       +endif
>       +
>      -+if git.found() and compiler.get_argument_syntax() == 'gcc'
>      ++if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>       +  hco_targets = []
>       +  foreach h : headers_to_check
>       +    skip_header = false
> 5:  a0c799cf8c ! 6:  7d9a33767b makefile/meson: add 'check-headers' as alias for 'hdr-check'
>      @@ ci/run-static-analysis.sh: then
>        make check-pot
>       
>        ## meson.build ##
>      -@@ meson.build: if git.found() and compiler.get_argument_syntax() == 'gcc'
>      +@@ meson.build: if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>            hco_targets += hco
>          endforeach
>        
> 
> 
> base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
> change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
> 
> Thanks
> - Karthik
> 


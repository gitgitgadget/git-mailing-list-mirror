Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7A27453
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845680; cv=none; b=kvbS3gdy1Uyc/ZqMh5zJfb9SG7SPKPYhGGqH1KCtFCnCJPvWPHthkO8OEsKoXYpX7XGAMl6vq+CwLM8NmzEkip97OxkepjlTlRXtJOZX4pmbzTfpvJGlvU15ZrhmLcvTtJP+BBlC2cR7oxgEhJDpKG+P6TWtFrj62UCiepptFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845680; c=relaxed/simple;
	bh=/gmiwc80Owrux+wbfzARoPBoJ/HsNwEO3yZS+3LeePk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXSnSUh39FzYBif9tmsFers13BmKTpKGnAS0T7FMPIVee4w4ly0XKRj2W1tk5UlHiC/VPzXHrbRxVevAdWkREmic+15WjWAYFoZpFI1A5TVRAhl8EOVNJFiWVBNhymHQGE5y3UBpxCGuSgD1d6Bqg4vNvewFxUA+Bv8DOrFz0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a43q1uv+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a43q1uv+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a53359dea5so983636f8f.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752845676; x=1753450476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGR60nE2XpDaNVyONYMi7jHK1HAgqTIJekiKnbI2cY4=;
        b=a43q1uv+Il3dsYsVUi50G9lyHtPy4CGld6Pde5AZ+bNQEE8JJrObX4b67a0EahHBHo
         Y/uDcqhWyzQkeT3DEGNTckLuZacPuh6ODqpL9GX/XWe35NpPF9H7+nqSj2GQ73cWF20F
         ZAPI2TDxEOwlNGYjMoV9Iahd+crd4K3ZWqCqTZaH3X1x8fps0+EZXwu0E+4BsHe111Jm
         HlauPrKxOXM39KCLDq1SqXYrKWhjSx6/RbIEAFx9AEojoPNqA5iu3rnOh4LjYn6k5CXB
         NS0GrtYH8PgUzPreJFdC9PyIglutvx5ImW3XUPESEvEaHvoMtzrZKjfeHjsRHncVAwt5
         EH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845676; x=1753450476;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGR60nE2XpDaNVyONYMi7jHK1HAgqTIJekiKnbI2cY4=;
        b=Q3KE7fNnES3ZYwAw/FYoULTAYvpN0UfddFej7rOrTvAP6YimIgppt0GF4w8CX7ovAA
         0tsJGHQIiz7BF+vR/y8OQ8NDCH+NQAz15lPIhUdkMBHyZ9LccKexGGM6njF0tvmGlBbc
         YOldHc5V18BMkEYaxq580jUgabLX/ET+VAebfsYglyrVpM9o8NB2bIxkS32WAIUIwUEX
         Tgr3g549qnECRQCXhOEsUoUv7IE+9ZyWZAvO0Gtpqyy3sWL7Ht5llpXkoABcAhuKnz2q
         9TffC+EULlOp9Oh2S1MSZHYh+Sdo/C833Vz9B7cZGAzgevMxfEOhKsbAzUQlHYuB8ZA0
         ySSw==
X-Forwarded-Encrypted: i=1; AJvYcCUJEw0WYAa1yGjylSDPLD6P9xHH0cQY3Hl9KzF+yQcyvFpi8uGKUsASDt7j0IhciKeiFcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxgERpbPHLu6grWutHKncn9kyElG5HIv4sJw1MVIwyFbYr47L
	v6QYQd7/sWzypdCPV+QVdEO3iELjzoZLM6hrfNZWaQArkiEBxXv1BmAy8mgbiQ==
X-Gm-Gg: ASbGncueWMhhkTLgDfmlEODMeBYGC8YGZwopwiIGMBmARtr0F1b1P+dvQTk2eCpnqZl
	9PQJZxAfK7+3nbRVyTR3GLgfyWy9sB3wFmJawB340Up6PcpNO+f5QNau09Vyk1WSzqOcsEtxaHJ
	VbJxhShUAZtxus7mnkuNo/6Rc+Ql1IT3PgL7LjFVxQW/H1LPe07ROmDpbndoGqzD69QgAG+RVQP
	bz1JePPiRpdM7TeWWnhC+Vf5I4fO6YnST1g+2yUHrVe7o3bZ+H/wIhkLa3KofaGquMyfHVNYliE
	h8GPC4oo+JcZHaQ9he4zEVrVPbWqw+uSGXhZOblcZeH9n60LWfbk0m7y0VNaZ6dL7fQUQ5Xjd6c
	Qt27g2R2eBTyPa97azWaRhRH1xRY9yfz8AKqHxYESL/Tv/3pMswXzHJbgxumMN01sCCLQOdw3Bz
	lwVBagGFc=
X-Google-Smtp-Source: AGHT+IHzTmmIDRc+zw5JN+veXVlOsaIFORpgrZBwsIBddtEkcNVgCLSYu7w2UxCV+Axo3qiUYbIUeg==
X-Received: by 2002:a5d:64ee:0:b0:3b6:d6c:a740 with SMTP id ffacd0b85a97d-3b60e54bdb3mr8886220f8f.54.1752845676070;
        Fri, 18 Jul 2025 06:34:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b? ([2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89bfecsm79577105e9.27.2025.07.18.06.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:34:35 -0700 (PDT)
Message-ID: <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
Date: Fri, 18 Jul 2025 14:34:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ezekiel Newren
 <ezekielnewren@gmail.com>, Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ezekiel

Thanks for working on this

On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> This series accelerates xdiff by 5-19%.
> 
> It also introduces Rust as a hard dependency.
> 
> …and it doesn’t yet pass a couple of the github workflows; hints from
> Windows experts, and opinions on ambiguous primitives would be appreciated
> (see below).
> 
> This is just the beginning of many patches that I have to convert portions
> of, maybe eventually all of, xdiff to Rust. While working on that
> conversion, I found several ways to clarify the code, along with some
> optimizations.
> 
> So...
> 
> This obviously raises the question of whether we are ready to accept a hard
> dependency on Rust. Previous discussions on the mailing list and at Git
> Merge 2024 have not answered that question. If not now, will we be willing
> to accept such a hard dependency later? And what route do we want to take to
> get there?

As far as git goes I think introducing a hard dependency on rust is 
fine. It is widely supported, the only issue I'm aware of is the lack of 
support on NonStop and I don't think it is reasonable for such a 
minority platform to hold the rest of the project to ransom. There is a 
question about the other users of the xdiff code though. libgit2 carries 
a copy as do other projects like neovim. I've cc'd the libgit2 
maintainer and posted a link to this thread in neovim github [1]

I've left a few comments on the patches

Thanks

Phillip

[1] https://github.com/neovim/neovim/discussions/34987

> About the optimizations in this series:
> 
> 1. xdiff currently uses DJB2a for hashing (even though it is not explicitly named as such). This is an older hashing algorithm, and modern alternatives are superior. I chose xxhash because it’s faster, more collision resistant, and designed to be a standard. Other hash algorithms like aHash, MurMurHash, SipHash, and Fnv1a were considered, but my local testing made me feel like xxhash was the best choice for usage in xdiff.
> 
> 2. In support of switching to xxhash, parsing and hashing were split into separate steps. And it turns out that memchr() is faster for parsing than character-by-character iteration.
> 
> 
> About the workflow builds/tests that aren’t working with this series:
> 
> 1. Windows fails to build. I don’t know which rust toolchain is even correct for this or if multiple are needed.  Example failed build: https://github.com/git/git/actions/runs/16353209191
> 
> 2. I386/ubuntu:focal will build, but fails the tests. The kernel reports the bitness as 64 despite the container being 32. I believe the issue is that C uses ambiguous primitives (which differ in size between platforms). The new code should use unambiguous primitives from Rust (u32, u64, etc.) rather than perpetuating ambiguous primitive types.  Since the current xdiff API hardcodes the ambiguous types, though, those places will need to be migrated to unambiguous primitives. Much of the C code needs a slight refactor to be compatible with the Rust FFI and usually requires converting ambiguous to unambiguous types. What does this community think of this approach?
> 
> 
> My brother (Elijah, cc’ed) has been guiding and reviewing my work here.
> 
> Ezekiel Newren (7):
>    xdiff: introduce rust
>    xdiff/xprepare: remove superfluous forward declarations
>    xdiff: delete unnecessary fields from xrecord_t and xdfile_t
>    xdiff: make fields of xrecord_t Rust friendly
>    xdiff: separate parsing lines from hashing them
>    xdiff: conditionally use Rust's implementation of xxhash
>    github_workflows: install rust
> 
>   .github/workflows/main.yml |   1 +
>   .gitignore                 |   1 +
>   Makefile                   |  60 +++++++---
>   build_rust.sh              |  59 ++++++++++
>   ci/install-dependencies.sh |  14 +--
>   ci/install-rust.sh         |  33 ++++++
>   ci/lib.sh                  |   8 ++
>   ci/make-test-artifacts.sh  |   7 ++
>   ci/run-build-and-tests.sh  |  10 ++
>   git-compat-util.h          |  17 +++
>   meson.build                |  40 +++++--
>   rust/Cargo.lock            |  21 ++++
>   rust/Cargo.toml            |   6 +
>   rust/interop/Cargo.toml    |  14 +++
>   rust/interop/src/lib.rs    |   0
>   rust/xdiff/Cargo.toml      |  16 +++
>   rust/xdiff/src/lib.rs      |   7 ++
>   xdiff/xdiffi.c             |   8 +-
>   xdiff/xemit.c              |   2 +-
>   xdiff/xmerge.c             |  14 +--
>   xdiff/xpatience.c          |   2 +-
>   xdiff/xprepare.c           | 226 ++++++++++++++++++-------------------
>   xdiff/xtypes.h             |   9 +-
>   xdiff/xutils.c             |   4 +-
>   24 files changed, 414 insertions(+), 165 deletions(-)
>   create mode 100755 build_rust.sh
>   create mode 100644 ci/install-rust.sh
>   create mode 100644 rust/Cargo.lock
>   create mode 100644 rust/Cargo.toml
>   create mode 100644 rust/interop/Cargo.toml
>   create mode 100644 rust/interop/src/lib.rs
>   create mode 100644 rust/xdiff/Cargo.toml
>   create mode 100644 rust/xdiff/src/lib.rs
> 
> 
> base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1980%2Fezekielnewren%2Fxdiff_rust_speedup-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1980/ezekielnewren/xdiff_rust_speedup-v1
> Pull-Request: https://github.com/git/git/pull/1980


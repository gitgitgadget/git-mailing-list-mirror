Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367D221DA6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581936; cv=none; b=bslrVj6NCwu1+P7abnGnr6ikshu8bFRTSe3SSIgHomzjF07UahdWh25FrOXUm2bamg28tNJDPBtAqAhUAZHJtMmCrh3RSRsp/qcv2ZIB8VWGjfUJg5ZN3aOxePKR0L7SN4XrBoiXRfRpXBtl7HIbhEtVMPOz0+aFBVyfgib1gPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581936; c=relaxed/simple;
	bh=2TOiK/yxVoEfpRnfCLcO82kZYdh14VdKBPaS2HYQejY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NItoif90AVW9FMms3ZYI2FrrPJWeJiJQQzxZNWyaek4IdCraN3NM7jSWcureEoY/RgZe0INQ04n1PbQyglypYUVLzAwaMlpyWauk8b6XcXSXWmlg/bAk+Jqs6Rg3CTbDcl9BDPg3O3ixo45QiV6YCrCY+qk9jD0wbmMIF7iin5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LemjtE8W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LemjtE8W"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439a331d981so60544125e9.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740581933; x=1741186733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC29xXOpBQbUylsL57wtBwVqVDRnCKyohAm7iFfhFP4=;
        b=LemjtE8WZr7/CUNVYEMZK/wOQW/M6mQLYCRAQ7la1yw16icZk/YNgSDy31V4cWD9RY
         zs7ui94tbu8iv+BkRhmVNeo+8FEUXaWo5/aq9HzHYPBGivCZhBO1iigtiEJKsh3Or272
         V3IyNbAClJXHCp+hiOacQYt8BUqpD0yTVcRhfHz+RczI8hEOyh8D4von/8zx/HCur8vF
         iNJ4GHmwH6K9SNp+KVBV9qmZ6g4Efx6vtqTgOORTbZNxgKvzFhfpaWUmWSDePC6Y+PXp
         1kPLsMY0i9IsWD5iChhQzOnjrkoARnjgSKW4e23l74x5iJtnJSpyv2naXw6DtVixSrn/
         0Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581933; x=1741186733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC29xXOpBQbUylsL57wtBwVqVDRnCKyohAm7iFfhFP4=;
        b=aWJP4klSopXrXKtiBzA4E1/si3X8biDzHYZFIG0pzzRmt5luV19V8qDcPGU66Xo+lv
         DUvI/rXYeWTuHHjfBtm1gZufadWvt5Csjd5Pn3TEUvFHvbKiYutH3a33ecIcBhkZPrgk
         AtdvEY1wmFRXRT3n2zfX4oTDDBIyDnFt4xhmQ1hWR6cCDh+GzGiwCN5A4DkZwcbuq8DC
         4tfXlO48KzON8iFNkxheV7nreNME/mj3WDUJU7UVriTLz6w5IGlDPvldWybq1Sd+ornp
         /B3OVNhq2F7Z2Pxiip60NlIzajhB+/KfNOgkFMKkORm3GHOfQpSa0C5AVKpAxxwlWSvU
         eNqA==
X-Forwarded-Encrypted: i=1; AJvYcCXxetdlje2Me7dxNY9GBVEusFH2Qv801ijhm5spUxfRJbTSNdgmPpYVdBA1bj2uYjCsS64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNQ3jlMdO9eyu9wCR+nF/bpYJSooty9wB2a6oailRPXTMCQnz
	lH1sxcaxBol/BJZUJEJGZrGBrjQqn+mJ7/Q0Svy/I+UV/kgVbU1LY6doXOfRdUg=
X-Gm-Gg: ASbGncu0QhybBZJg/qzv+04pyrcys0rUwHBmCE8yfxT5n2ry0dmqKHU0khZy6+gpnNW
	kbsJu+qvmy/V0zLjY4BATPtnyNqpoeHMxBKvoUL2QD9LWiIvf6KIEOhOCp1HIX1OiQgVs53SItc
	rxLb+aKJQroO6lG7SidhK+j5rvO8O2SjTFgyzNFy5mskREAITI7GeKPKXTnf8i6/KDMSp9V3rxH
	cY5XMsJvdPTj15AW3RrZJb7cJXsW1fHP9VutLneqOuw56drvQU33MDOPEzYo/UbX++zCACPJCCF
	ZZB2UISfnCqImGSxUtvZ7AgJk73Dp03Hisystl2nbHIxzFh2OpvuvI/CNQzVOkeJBP2GSP+Npni
	SVLrN
X-Google-Smtp-Source: AGHT+IGgWOTAOk7ZS1ceH6h0ziggn3ikZKl0NyYl3uEuCVnPtsmkRPxOWQgobhhc8MMXbosa9f8LUA==
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr3231043f8f.41.1740581931776;
        Wed, 26 Feb 2025 06:58:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390df0e73f2sm905626f8f.9.2025.02.26.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:58:51 -0800 (PST)
Message-ID: <1e41249a-5241-4cd8-8a6a-3c9163fb0ea0@gmail.com>
Date: Wed, 26 Feb 2025 14:58:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] batch blob diff generation
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
Content-Language: en-US
In-Reply-To: <20250225233925.1345086-1-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 25/02/2025 23:39, Justin Tobler wrote:
> 
> Changes since V2:
> 
>      - Pathspecs are not supported and thus rejected when provided as
>        arguments. It should be possible in a future series to add support
>        though.
> 
>      - Tree objects present in `diff-pairs` input are rejected. Support
>        for tree objects could be added in the future, but for now they
>        are rejected to enable to future support in a backwards compatible
>        manner.
> 
>      - The -z option is required by git-diff-pairs(1). The NUL-delimited
>        raw diff format is the only accepted form of input. Consequently,
>        NUL-delimited output is the only option in the `--raw` mode.
> 
>      - git-diff-pairs(1) defaults to patch output instead of raw output.
>        This better fits the intended usecase of the command.
> 
>      - A NUL-byte is now always used as the delimiter between batches of
>        file pair diffs when queued diffs are explicitly computed by
>        writing a NUL-byte on stdin.
> 
>      - Several other small cleanups and fixes along with documentation
>        changes.

This addresses all my comments on the previous version, thank you. I do 
wonder if tying the input line termination to the output line 
termination is a good idea for a program that aims to to transform one 
diff format into another. Having said that this series is aimed at 
machine consumption of the output so it probably isn't a big problem.

I also think we might want to massage the output in the tests so that 
we're not running test_cmp on files containing NUL bytes. Using

     git diff-tree -z ... | tr '\0' Q >actual

would get rid of the NULs but does not improve the readability of the 
raw diffs that much as everything is still on a single line. Using '\n' 
instead of 'Q' would give us mulit-line output but we would lose 
confidence that the original output was actually NUL terminated.

Best Wishes

Phillip


> Changes since V1:
> 
>      - Changed from git-diff-blob(1) to git-diff-pairs(1) based on a
>        previously submitted series.
> 
>      - Instead of each line containing a pair of blob revisions, the raw
>        diff format is used as input which already has diff status and
>        object context embedded.
> 
> -Justin
> 
> [1]: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
> 
> Justin Tobler (3):
>    diff: return diff_filepair from diff queue helpers
>    builtin: introduce diff-pairs command
>    builtin/diff-pairs: allow explicit diff queue flush
> 
>   .gitignore                        |   1 +
>   Documentation/git-diff-pairs.adoc |  60 +++++++++
>   Documentation/meson.build         |   1 +
>   Makefile                          |   1 +
>   builtin.h                         |   1 +
>   builtin/diff-pairs.c              | 206 ++++++++++++++++++++++++++++++
>   command-list.txt                  |   1 +
>   diff.c                            |  70 +++++++---
>   diff.h                            |  25 ++++
>   git.c                             |   1 +
>   meson.build                       |   1 +
>   t/meson.build                     |   1 +
>   t/t4070-diff-pairs.sh             |  83 ++++++++++++
>   13 files changed, 432 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/git-diff-pairs.adoc
>   create mode 100644 builtin/diff-pairs.c
>   create mode 100755 t/t4070-diff-pairs.sh
> 


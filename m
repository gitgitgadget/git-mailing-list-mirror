Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786C36075A
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611222; cv=none; b=X2LM1jHjipoMA8wf4p0Ay2T/KtLW1zouPAzB1gJoJm6NhuluC3MWOwORCb+2CKHniwAO9WOZnqq49U/vEf6ql3YvEJDcsI11amDc8OvGvLjI2XvTjzYc1jR2YMI0qyQQFSYXgL2uNqYsCBA9PTJYCRct3xliDlNhwblFWXb19uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611222; c=relaxed/simple;
	bh=Gh7OjgDCIJS/4CzhHEEWvlrpAXP5iEWvxbuswoIaJOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5sjQ5gsrBYiw7rPU//imMjfjrQSRx6Va99lcFXpUN23TKfmQOZjO7wmXD5hbQlDBfo9jxAXdqQrkP1+Fu3ExtWXpYFaZhckQvoZ+IDLub4UWOU+uzd+IlrgdYcSIbDJJNrXgjTbWiloMKi6FKo+a5oGNc3WPejVIhLUSBFqfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS5nop0i; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS5nop0i"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso9316946a12.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769611219; x=1770216019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0TvLxifIv6wrFPNbgg0sjWHTmRCEJtwlTj3P0/b2NBw=;
        b=CS5nop0ik9+Svse0BYy8o6w6O6YLY1PDME2/V8gyawDFpYZYTsy41cK3vR8ybeiWRe
         NGh6PYo7LsgemjKgXdDYIbd8hee3c5jSDrvuijtOrNwH0rMt0aiZD52ZFdqHeBSlprGp
         MbwioLJce8Z6UmV02e3xgeqDSYzP7e1qjjVpOT5ot++Ux6xTjrw7bbrXPw3LmhrUjYDK
         TAd6B0sXm18XWKZNzxyYcSKdVtNJvh9CXNS4+69AJuss5LbYKVfJ9v7W0EGSlKojHLrY
         c/sCm7F6cpdUs2zPfsy+Xyc8VDMUqGJUAqA+MXco9UArpPdicVqLnlD0nRCW5aTQGdJh
         bUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769611219; x=1770216019;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TvLxifIv6wrFPNbgg0sjWHTmRCEJtwlTj3P0/b2NBw=;
        b=ttEhBEEB8C+FlEHBeeJwcQKg5k2giwqO/d0Sgi2z47SX/A9UsSuC2AlhXrgho1uqp1
         Vgez/pb3GCMNVHoK0QdEwv1fnKsKB0OKhGxVgMatUMrYaKDEg4i4VrLAfIdL6xtIaM77
         nZCHWR+ip5UoO3jy0qcXAmAv4ckvl8z4c+R7CxxHN51zcTsX+metMh+Y2+isW/GNNwra
         cZb1yrjD0Y9aRiH/IXvg0q1jYi4BHokFzDLLV816h0c3ApJASTFVhybQ+msoNSfqNMdZ
         RA84JDswM4Hx9rO53SIyDGB3X5Nsh8V0A4rwhukqbFnNJorP/3qudzv2RHg/nmFBiZMw
         kAyA==
X-Forwarded-Encrypted: i=1; AJvYcCUT1Tk0e6dzFP5yIoWTnZWhXmnuZS7LbtCROOTMWX/ofw/QX3BwesNVEqdePs6/3K0xQSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0lkHavHQ840Nj7fBingYC2fSBb5Irjpes4ye9Kr7Yx6/gY2W
	sAMfwp6qdqK2hULf1XqFx+9Ppmskg+080i2SO0SyF4+bXzzdfShcQcJT7ed6SFA5
X-Gm-Gg: AZuq6aJQl6tq0UF0QDzkLSI8tfBAfiClQAHGXbS9/7yrpbu84rWaQqcrWBKrtPmtf5F
	DBMTSo0kcOPX5rOfFuVdt2R5pu3Q578MOvKAipdtB0ytFyMil9CUOUQ1PnYp/F4vhcc1raGYbqb
	7R60Ul6/YfwR6gt8AiXZHxHHieqdWA0z+Z3GzU9bjnfTEyJAwXlIdC9HlJjAPR8aRneD3VCsVZ8
	xwNrRnyyheVK+sxtIbpPHhw5EFpwa2IfG+tiozzJsCGKGwRxHvn04gJ1mtlKnHI/i6xOHst5EDb
	ArbuwvngGwHtJCECAUgllMRbqyorNtvnHRpG1npJeb/jIehIat3+4Rj3vsypz43+9Ld36OZI+Ur
	owUeXxZbAdMI/4X0TC4EUMd8EjRrevWhlbIAoM3P8DbPoFcSMaMqLF397eKuQ1s0CheNz2ow8WL
	MApAFKKHmzZw/o/Jgr5Ov9Zy2V7sSStKP3gbrlviHyaNg7kQ7AVe1Doknk83DVOFBKqw==
X-Received: by 2002:a17:906:ee8c:b0:b8d:9d60:d591 with SMTP id a640c23a62f3a-b8dab37d75fmr426751166b.46.1769611218695;
        Wed, 28 Jan 2026 06:40:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2e0868sm130640766b.58.2026.01.28.06.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:40:18 -0800 (PST)
Message-ID: <93942e80-207d-4fbd-9965-7c072693b6e1@gmail.com>
Date: Wed, 28 Jan 2026 14:40:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The discussion of this series has got rather spread out so I thought it 
might be helpful to write a summary of my thoughts here.

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> Patch series summary:
> 
>   * patch 1: Introduce the ivec type

I agree this is a good idea to allow rust and C code to operate on the 
some data structure. The implementation needs a bit of work to avoid 
undefined behavior.

>   * patch 2: Create the function xdl_do_classic_diff()

This is sensible

>   * patches 3-4: generic cleanup

Patch 3 claims to "stop wasting time" but it introduces an extra pass 
over the input records without any explanation of why that is more 
efficient.

Patch 4 removes the common lines from the beginning and end of the input 
files before passing them on to the patience or histogram algorithms. 
That should speed things up (though we should measure by how much). It 
changes the output because excluding the common lines at beginning and 
end of the file changes the longest sequence of unique context lines in 
the lines that remain. If the different output is easier to read then 
that's clearly a good thing but you would need to do some analysis to 
show that.

>   * patches 5-8: convert from dstart/dend (in xdfile_t) to
>     delta_start/delta_end (in xdfenv_t)

dstart a dend in xdfile_t are the index of the first and last line after 
removing any common lines from the beginning and end. The proposal is to 
store the offset from the beginning and end instead in xdfenv_t. Looking 
at where dstart and dend are used I think storing the indices is more 
convenient - if we store offsets we end up calculating the indices from 
them which is a pain and introduces an opportunity to make an error.

>   * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
>     xdiffi.c

Here we finally get to use the ivec data structre introduced in patch 1. 
However it is just replacing a fixed size array and so does not 
demonstrate the more interesting parts of the API which concern growing 
the array as we push more elements to it. I'm also not convinced by the 
claim that this change saves time as it introduces an extra pass over 
the input records.

Overall I struggled to see how the cleanups proposed here linked to the 
introduction of the ivec data structure.

Thanks

Phillip

> Things that will be addressed in future patch series:
> 
>   * Make xdl_cleanup_records() easier to read
>   * convert recs/nrec into an ivec
>   * convert changed to an ivec
>   * remove reference_index/nreff from xdfile_t and turn it into an ivec
>   * splitting minimal_perfect_hash out as its own ivec
>   * improve the performance of the classifier and parsing/hashing lines
> 
> === before this patch series typedef struct s_xdfile { xrecord_t *recs;
> size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
> size_t nreff; } xdfile_t;
> 
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;
> 
> === after this patch series typedef struct s_xdfile { xrecord_t *recs;
> size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
> xdfile_t;
> 
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
> delta_end; size_t mph_size; } xdfenv_t;
> 
> Ezekiel Newren (10):
>    ivec: introduce the C side of ivec
>    xdiff: make classic diff explicit by creating xdl_do_classic_diff()
>    xdiff: don't waste time guessing the number of lines
>    xdiff: let patience and histogram benefit from xdl_trim_ends()
>    xdiff: use xdfenv_t in xdl_trim_ends() and xdl_cleanup_records()
>    xdiff: cleanup xdl_trim_ends()
>    xdiff: replace xdfile_t.dstart with xdfenv_t.delta_start
>    xdiff: replace xdfile_t.dend with xdfenv_t.delta_end
>    xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
>    xdiff: move xdl_cleanup_records() from xprepare.c to xdiffi.c
> 
>   Makefile           |   1 +
>   compat/ivec.c      | 113 ++++++++++++++++++
>   compat/ivec.h      |  52 +++++++++
>   meson.build        |   1 +
>   xdiff/xdiffi.c     | 221 +++++++++++++++++++++++++++++++++---
>   xdiff/xdiffi.h     |   1 +
>   xdiff/xhistogram.c |   7 +-
>   xdiff/xpatience.c  |   7 +-
>   xdiff/xprepare.c   | 277 ++++++++-------------------------------------
>   xdiff/xtypes.h     |   3 +-
>   xdiff/xutils.c     |  20 ----
>   xdiff/xutils.h     |   1 -
>   12 files changed, 432 insertions(+), 272 deletions(-)
>   create mode 100644 compat/ivec.c
>   create mode 100644 compat/ivec.h
> 
> 
> base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v1
> Pull-Request: https://github.com/git/git/pull/2156


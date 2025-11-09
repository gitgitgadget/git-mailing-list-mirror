Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58842FD1B9
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697930; cv=none; b=Xc0R2mhv0a1JdrWxXuvD9FTV4hsC+zs3lRPOsLPJPCLALQEt/wq2X1ko+ciWCmd61soGAIWfJsOwmLZ30O/q3ZHS+qfVUbOqQ5B8J4av+BQbbEPsXCGEGPPYAQlpP2mRKA4+Or+rjANhbeqmdPKw8DvJAZwj0OKjvyJyjg4PJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697930; c=relaxed/simple;
	bh=Dpwq3HGlFUl3XgHLg69gg+eKng0MjP7GITVRRwT/GbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGHaspv+eb974JxFl7zmaLn4cka1zQpQjAUTHSWhuA1Jj4oUudQLnNOL1TLkmBQQtCsONmwV/JP+B1YJkcJZgOSL9xe+2fVPJeWEPtVAVaFMTxmN0WuGxtGTebMGHbjhFxKlag8IEn907BXOKi4IEFxqGqsGfYDfV5nkyOrGsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSfNzd7l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSfNzd7l"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47777000dadso4898195e9.1
        for <git@vger.kernel.org>; Sun, 09 Nov 2025 06:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697926; x=1763302726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ/+fRJeZVYSU7JEngGL6KXuE/pQj14mJAyOLFAH3xc=;
        b=ZSfNzd7lN6H2J3GHPRGgXmXmEABRNhM1473kLgURrt4bK/3iwVIbV6J7u4MGCh0NiI
         6uYy8M2bw1vmUzqDFIMbijG5xIORTzia5r7Zgzm5FHayJfUD+ffE5sNI+6zUsiYoDSZV
         HfQbl+tuAJIJV/0typwdP1w/WqlDtyZqHDlYiA5iQIfi4c6/mKT2XUk87dTVKVHRxbKn
         bm/uRPYsMAx0TY/j5GMuSQ1mS4THwU5LtmIn9YjFUStlQ4jgKlFrD+p+JB8Aj38ebX5b
         aQY6uOZ9Vf0BY99JQTPInjSp1JHm4fHYcG89jnlAMPLDCdA5MvdTTW8dy9EDMtu4l+KK
         VMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697926; x=1763302726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ/+fRJeZVYSU7JEngGL6KXuE/pQj14mJAyOLFAH3xc=;
        b=SMLZC0WW2He9EgbtTdgx3oVH/lD3EbH0RXJft/oAgJxIdtWnO8S/Qq7wymBZ8eJTUK
         AdGmXgP6AhKmSFmcUW2oLYK7zK42cRvKyQb5Q+DxPOiWA1KwkUxwDPcVtMHxTYb6/V+G
         QwVryS94yJ5aSfrNWo/ie6DOVH1Op+nYikH1k3xkFWw03YLARV3YjiXqdXo+mdysu0eL
         uUL22u9L3P3EIsL7/wqPIMvstxW7LgnAezwUciqUpDpArNWZrVPwwsnNo+yAEBU90i2P
         R9Skml/8UvgC1RB4EVgWL0ebepgSYGPOyWvQWEh3grWKH93Kvr7GrxSXRRIM3CD0jGeR
         pnzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6Ilb95MuSnzPJ0tiDFyASEsx7vFQHJttORGjMljTnFiH1zfzgPZ2qq5ESg9cj6Pb3PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhGJhv5HR1Ac7mPG6Mqpmfj0rqfXKVn9hILNO53Bzkx7EbJT1
	jqWRjlwu9/oo7J+3816jqmK8oXeGnBzeVqikmu5gh1VdLAMW9TtLGsYH
X-Gm-Gg: ASbGncsHSmBABMGjQs2C3YjIGgseqNRr1bp3bcQoMNbnSoObT8Iakbd3Cv9ZvzW4y87
	2xGrlQ4DLX2b8syjLGpA2U30ieVyXYYsE2lS3E/hFwVA4Yezv9MkaV40goVCZeeEhAgwHb2K2MH
	9MMNjE6OYEGKHqxe4/FidPfoLJ6sbPAq1b2djr20xeTgaObCaWMjtYCxH+UbdzQv8oCM4+GUqEA
	VuJ5UaUrqNE41zvIOux1VlSXY3XO7LLOFN2iEJBve0EtgiCY7tMU39YuQUQhUnpunxib3EYogq1
	IFE1Yqo8yQ7hNgf0a9V8q2H6++idmS7vT8S0ZXNz568+rw73sUxq/xMdQQPo5DC+IIUqHI5J4W1
	joYSSFPudhJHwwR7LFicHHwfA6m9ow/Fkm7otGo2SF9MtOf/3PVovOOmg2hG5ja2Cssh8FO0diq
	c5QT/7iF+vtEhWiM7G21jMIRQWbRVxGvxS4S6cPNBBT5smfXvAmEy5
X-Google-Smtp-Source: AGHT+IH+OMa0e93ZSHj02yMHaVo0XSF22RWsZl/vmHeYjrnU2AoRRpLsUvAEMDvCsoWCV+YQvYACNA==
X-Received: by 2002:a05:600c:35c9:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4777b9abc33mr11937185e9.21.1762697925765;
        Sun, 09 Nov 2025 06:18:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm19602731f8f.41.2025.11.09.06.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 06:18:45 -0800 (PST)
Message-ID: <40a322a6-7fd7-4003-a23f-7672a36b5bf2@gmail.com>
Date: Sun, 9 Nov 2025 14:18:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: disabled quick optimization with
 --find-copies-harder
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <bbd1a371-b0a4-4412-b329-cb4d654a0ca8@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <bbd1a371-b0a4-4412-b329-cb4d654a0ca8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2025 12:11, René Scharfe wrote:
> If --find-copies-harder is given, diff-lib.c::show_modified() queues
> even non-modified entries using diff_change() because we need them for
> copy detection.  diff_change() sets flags.has_changes, though.  If
> --quiet is also given this causes diff_can_quit_early() to declare we're
> done after seeing only the very first entry, which is way too soon.
> Disable this optimization in that case.

Stepping back a bit I'm confused as to why we don't disable rename and 
copy detection when "--quiet" is given. I can't see why detecting copies 
or renames would change the exit code but maybe I'm missing something.

Thanks

Phillip

> This issue is hidden without --no-ext-diff because then we set
> flags.diff_from_contents, which disables the optimization in a
> different way.
> 
> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   diff.c              |  1 +
>   t/t4007-rename-3.sh | 10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index a1961526c0..84ac148c37 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -7188,6 +7188,7 @@ int diff_can_quit_early(struct diff_options *opt)
>   {
>   	return (opt->flags.quick &&
>   		!opt->filter &&
> +		!opt->flags.find_copies_harder &&
>   		opt->flags.has_changes);
>   }
>   
> diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
> index e8faf0dd2e..3fc81bcd76 100755
> --- a/t/t4007-rename-3.sh
> +++ b/t/t4007-rename-3.sh
> @@ -41,6 +41,16 @@ test_expect_success 'copy detection, cached' '
>   	compare_diff_raw current expected
>   '
>   
> +test_expect_success 'exit code of quiet copy detection' '
> +	test_expect_code 1 \
> +	git diff --quiet --cached --find-copies-harder $tree
> +'
> +
> +test_expect_success 'exit code of quiet copy detection with --no-ext-diff' '
> +	test_expect_code 1 \
> +	git diff --quiet --cached --find-copies-harder --no-ext-diff $tree
> +'
> +
>   # In the tree, there is only path0/COPYING.  In the cache, path0 and
>   # path1 both have COPYING and the latter is a copy of path0/COPYING.
>   # However when we say we care only about path1, we should just see


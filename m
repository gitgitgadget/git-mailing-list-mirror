Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6F1DA53
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738493568; cv=none; b=vEYwuOUxOCZvBiDQSkWUSkNyNXeQqpIA4xgcylAXNX93hYQdj6MuJ1yE6/u6ADoriUsp0+qyrd2l5gjiG3HHa8qq8FcvgKf159ZnbV59h9CVLRC2R7BUKTD77O4ECsHt9VUnWlfEOvseJALujjrjBi4c6tjqJZzBBHiFAKC1fO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738493568; c=relaxed/simple;
	bh=txVRcvBvZbaHGJqHL+SwHgZVRGfEI8alUgk0LqucZhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DopaF3n8pf76D2WMZrUOrLwAhtQMj11wy2px7H7DmagskOXF6/xUZkdu+MRGvUM0LvGmb1jBzmEs4nrMbxckI/d3Jm9W9EBwWXPDudUGddARycl5hvU1r6uKvkNJ5HI3oWsKFl6VqI54NEoaRU3Zmf/ygWynm87zlaEl88l5Ulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOUiOYWF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOUiOYWF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43626213fffso27850795e9.1
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738493565; x=1739098365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DfbX9Hl1OYch6Jul5DKIpZtAvFIWFUnyv/sjD3UBDEc=;
        b=aOUiOYWFmapuegyHm9omZqPanLMnB5uDeeSaG+PM/oHUbyYEBV1SZBTiyQJSshk+Tr
         uWzH2WDX6AGKywvnqUIiQug5H1wxjo24piNl6tOHZMEEgzcCYM0KJV1tLWxVRFn7baxZ
         +6NjOhbNesRVLKuDHF2dSRNqPVm8d4bHvF7419KSjQZ90kuxd+FM5lFSVc7GHIrWzUAz
         6MZ9MMI9gKle7gohBL/fu3XlRu2Lys15TsaZMpVrUXM9W+1Rwbr4hP/d149BnNnI4F8r
         mykYGeeSkWRfX4HtuiJzAQfCtJVe+yeoc5ZtaywJ/GCf7TUyXOxV2EmfaoavSiiTj8rq
         YwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738493565; x=1739098365;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfbX9Hl1OYch6Jul5DKIpZtAvFIWFUnyv/sjD3UBDEc=;
        b=fQZlae7SahwVUNeSoQzaPOOkzsRKq/rJd3ReCyW+Eur0qLtrO85AXTx7wQ/EqYGhDr
         8cp1urnLFYBqaG0vnMBLhKxA093ro/u8+oMmtziJs08q5x4yoKbAcaVg/o7JPJwlyFSZ
         wW4vx1hHObYdlrA48TwV+VfLo3HLGyD2D86500JASh7m0KNF5ws+9KyySp4lE4e48Hkf
         DRHDBgSF2CfVHlA/JHKj9R713Aualih33h1n8kI8irnNjUP3dZHHNaGO8LskU3Mi7ScR
         2JIvFEM716Mr5GKrX/F251aJC8R1tjQhpylbAMzGdqlYrH1Gzdv20jhoK3yJ+oRHZK4c
         VB3A==
X-Forwarded-Encrypted: i=1; AJvYcCWrUrI7FsX2AohmCOSQp5UxrKNR4qbxO3eYraZXiVGuDGo38EmMxgUIFkb7hDD2vqsvlQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESQFhE4TsvOqFkZAEVyG25d0tCHj+dj6ekywGWOpjmtucfEZY
	PbDt1gHercnWWMdde+3DLbz/Hx6nyVwotekr1vm/IVkaHEN0lHdD
X-Gm-Gg: ASbGncvxxd4EN7/FRsbJKaKPZfFjEO5d4YUIwrRcPDSBHALUlHYwxpdBn7wtEUilq5d
	nUQjq2GUBsIjqB+7be1f7rYlr+rvV6j5T/Q3UExQrYuRz2wN16s3gua7wvotDSSMubE2zMqOD5v
	/+H8Wz6uelylq9nMcB7lp1PBsPOGSJXUz9cVa/a20Lz9cG4zb1BPEovzQmhhO7O9vL6cl6O7T3t
	1yq3sc4+4+C1jG/4FbLfGk2gdBNApJWxiRZprgstVDgPnhUQ/lWG1+09hPmlJCiwB5M+JY26dIr
	C0jC9pLPZ0Yllpp73EqBbiQWrMrZY5p600L8Lp8vrH8bTUB32rqyxUNj1OPchi3QO5dOtw==
X-Google-Smtp-Source: AGHT+IGnMDTBMHrwmDGIpOvC5l25RTg9HhAYorOcU/yrM4ZzqohGZJTL9/2tCzuaHSvumjVklbN2sQ==
X-Received: by 2002:a05:600c:1913:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-438e16ebb49mr108551335e9.10.1738493564652;
        Sun, 02 Feb 2025 02:52:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec886sm9571392f8f.1.2025.02.02.02.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 02:52:43 -0800 (PST)
Message-ID: <76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com>
Date: Sun, 2 Feb 2025 10:52:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] quote: add quote_path() flag to ignore config
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
 <20250201201658.11562-3-jltobler@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250201201658.11562-3-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 01/02/2025 20:16, Justin Tobler wrote:
> The `quote_path()` function invokes `quote_c_style_counted()` to handle
> quoting. This means the output `quote_path()` is ultimately affected by
> `core.quotePath` configuration. In a subsequent commit, `quote_path()`
> will be used in a scenario where the output should remain consistent
> regardless of the current configuration.
> 
> Introduce the `QUOTE_PATH_IGNORE_CONFIG` flag for `quote_path()`which
> when set instructs the underlying `quote_c_style_counted()` to also
> ignore the `core.quotePath` configuration when executed.

I'm confused as to why this is necessary. All of our existing plumbing 
commands that print paths respect core.quotePath so why is rev-list 
different? The config setting only affects the representation used for 
bytes 0x80 and above, control characters, backslash and double-quote are 
always quoted.

Best Wishes

Phillip

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>   quote.c | 13 ++++++++++---
>   quote.h |  3 ++-
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/quote.c b/quote.c
> index d129c1de70..baec34ca94 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -370,10 +370,18 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
>   {
>   	struct strbuf sb = STRBUF_INIT;
>   	const char *rel = relative_path(in, prefix, &sb);
> -	int force_dq = ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
> +	unsigned cquote_flags = 0;
> +	int force_dq = 0;
>   
>   	strbuf_reset(out);
>   
> +	if ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' ')) {
> +		force_dq = 1;
> +		cquote_flags &= CQUOTE_NODQ;
> +	}
> +	if (flags & QUOTE_PATH_IGNORE_CONFIG)
> +		cquote_flags &= CQUOTE_IGNORE_CONFIG;
> +
>   	/*
>   	 * If the caller wants us to enclose the output in a dq-pair
>   	 * whether quote_c_style_counted() needs to, we do it ourselves
> @@ -381,8 +389,7 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
>   	 */
>   	if (force_dq)
>   		strbuf_addch(out, '"');
> -	quote_c_style_counted(rel, strlen(rel), out, NULL,
> -			      force_dq ? CQUOTE_NODQ : 0);
> +	quote_c_style_counted(rel, strlen(rel), out, NULL, cquote_flags);
>   	if (force_dq)
>   		strbuf_addch(out, '"');
>   	strbuf_release(&sb);
> diff --git a/quote.h b/quote.h
> index 2a793fbef6..84903951ef 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -94,7 +94,8 @@ void write_name_quoted_relative(const char *name, const char *prefix,
>   
>   /* quote path as relative to the given prefix */
>   char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags);
> -#define QUOTE_PATH_QUOTE_SP 01
> +#define QUOTE_PATH_QUOTE_SP	 (1u << 0)
> +#define QUOTE_PATH_IGNORE_CONFIG (1u << 1)
>   
>   /* quoting as a string literal for other languages */
>   void perl_quote_buf(struct strbuf *sb, const char *src);


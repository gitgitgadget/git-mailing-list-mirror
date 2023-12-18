Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04027498BE
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyP7EzKm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33663adf953so1214714f8f.3
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702916602; x=1703521402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tiej/g8WCtEX6iUPrYqtvXb15jsi3nuvt3AxL0HbsFg=;
        b=iyP7EzKmHGMH/rFkExCmNW+Wt6S91dnoDLrEbTIGADb48HQWit8rrxphUfyy6tx7UM
         e/FFJ7AuE2Dce/ICMxuY+UU+WkiO6EHjpfV/Cp5f4kLFVjpPDBNfhr/pyg1gXbNkxjj5
         pKa0dzpTw31RT0xaN2PFWE/NB4B8z6l2klaqCRUAFpgKWIqNvCDt3EGsQqNfWPbDZm5p
         gojHrScR3CnhE5ERkv2Xt3dWs8RRsWnR/Vw7WO+AGqpDVFyg0gMG8dPVB1t9yNZzE5ve
         yHoK76R2NmTWA/71NU0hLJo30EwnA39AISDdfo8IIevmYyQfxjy8poFkm5BxXkDlEbB/
         mzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916602; x=1703521402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiej/g8WCtEX6iUPrYqtvXb15jsi3nuvt3AxL0HbsFg=;
        b=vhBukuc/uclpD27obeEUbgSrbmDi99dDRCE0KWA/9N+GT4xb6whsej9VFQEF4Emtv9
         BnBDpKoYmdp4na2xZvnhyRtK3wsZafjfUXlo0cXSfsbmRNlkF8N5ecHKukG0TOo+H1Y8
         kiaOt/Zv2OSFYqsjGN8Fd5Fpwr8XM/PO65Ky92c3LI2TVqzu/piBvRO0qDghOxupOt6j
         y6oF9HiD/JNfScR61UB3hhfdQEUqwY4YQW5+lNu3cARulMha/101Bs6Mk+WPnOs29Gfx
         dT0YTqVL1FEVqFu4xpj8bYy1AhyWbhBUwBiJgSxJ4xerdM/U8n4F0kX7IL3MmEa9J9WJ
         cvHg==
X-Gm-Message-State: AOJu0YwuYz+pPKHsrjSjgLpo5xjIUZWOiAQFofPQV3WdqvcnVzzoDvas
	wirt5cK2NbGY0UIB2/VvLoQ=
X-Google-Smtp-Source: AGHT+IEFn00FklzwQMJ3S5kLIONyubDycl9p/fNlQf+InCbtRKwiYZyoEsfdyAj+XVwlBlQU+9vNaA==
X-Received: by 2002:a05:600c:30d2:b0:40c:4378:f110 with SMTP id h18-20020a05600c30d200b0040c4378f110mr7461569wmn.54.1702916600345;
        Mon, 18 Dec 2023 08:23:20 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040d18fdfe96sm5623155wmq.44.2023.12.18.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:23:20 -0800 (PST)
Message-ID: <b7a56625-46d5-4d77-b4bf-5595a6fb2aef@gmail.com>
Date: Mon, 18 Dec 2023 16:23:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: convert skip_{prefix,suffix}{,_mem} to
 bool
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
 Seija Kijin <doremylover123@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
 <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 16/12/2023 10:47, René Scharfe wrote:
> Use the data type bool and its values true and false to document the
> binary return value of skip_prefix() and friends more explicitly.
> 
> This first use of stdbool.h, introduced with C99, is meant to check
> whether there are platforms that claim support for C99, as tested by
> 7bc341e21b (git-compat-util: add a test balloon for C99 support,
> 2021-12-01), but still lack that header for some reason.
> 
> A fallback based on a wider type, e.g. int, would have to deal with
> comparisons somehow to emulate that any non-zero value is true:
> 
>     bool b1 = 1;
>     bool b2 = 2;
>     if (b1 == b2) puts("This is true.");
> 
>     int i1 = 1;
>     int i2 = 2;
>     if (i1 == i2) puts("Not printed.");
>     #define BOOLEQ(a, b) (!(a) == !(b))
>     if (BOOLEQ(i1, i2)) puts("This is true.");
> 
> So we'd be better off using bool everywhere without a fallback, if
> possible.  That's why this patch doesn't include any.

Thanks for the comprehensive commit message, I agree that we'd be better 
off avoiding adding a fallback. The patch looks good, I did wonder if we 
really need to covert all of these functions for a test-balloon but the 
patch is still pretty small overall.

Best Wishes

Phillip

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   git-compat-util.h | 42 ++++++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3e7a59b5ff..603c97e3b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -225,6 +225,7 @@ struct strbuf;
>   #include <stddef.h>
>   #include <stdlib.h>
>   #include <stdarg.h>
> +#include <stdbool.h>
>   #include <string.h>
>   #ifdef HAVE_STRINGS_H
>   #include <strings.h> /* for strcasecmp() */
> @@ -684,11 +685,11 @@ report_fn get_warn_routine(void);
>   void set_die_is_recursing_routine(int (*routine)(void));
> 
>   /*
> - * If the string "str" begins with the string found in "prefix", return 1.
> + * If the string "str" begins with the string found in "prefix", return true.
>    * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
>    * the string right after the prefix).
>    *
> - * Otherwise, return 0 and leave "out" untouched.
> + * Otherwise, return false and leave "out" untouched.
>    *
>    * Examples:
>    *
> @@ -699,57 +700,58 @@ void set_die_is_recursing_routine(int (*routine)(void));
>    *   [skip prefix if present, otherwise use whole string]
>    *   skip_prefix(name, "refs/heads/", &name);
>    */
> -static inline int skip_prefix(const char *str, const char *prefix,
> -			      const char **out)
> +static inline bool skip_prefix(const char *str, const char *prefix,
> +			       const char **out)
>   {
>   	do {
>   		if (!*prefix) {
>   			*out = str;
> -			return 1;
> +			return true;
>   		}
>   	} while (*str++ == *prefix++);
> -	return 0;
> +	return false;
>   }
> 
>   /*
>    * Like skip_prefix, but promises never to read past "len" bytes of the input
>    * buffer, and returns the remaining number of bytes in "out" via "outlen".
>    */
> -static inline int skip_prefix_mem(const char *buf, size_t len,
> -				  const char *prefix,
> -				  const char **out, size_t *outlen)
> +static inline bool skip_prefix_mem(const char *buf, size_t len,
> +				   const char *prefix,
> +				   const char **out, size_t *outlen)
>   {
>   	size_t prefix_len = strlen(prefix);
>   	if (prefix_len <= len && !memcmp(buf, prefix, prefix_len)) {
>   		*out = buf + prefix_len;
>   		*outlen = len - prefix_len;
> -		return 1;
> +		return true;
>   	}
> -	return 0;
> +	return false;
>   }
> 
>   /*
> - * If buf ends with suffix, return 1 and subtract the length of the suffix
> - * from *len. Otherwise, return 0 and leave *len untouched.
> + * If buf ends with suffix, return true and subtract the length of the suffix
> + * from *len. Otherwise, return false and leave *len untouched.
>    */
> -static inline int strip_suffix_mem(const char *buf, size_t *len,
> -				   const char *suffix)
> +static inline bool strip_suffix_mem(const char *buf, size_t *len,
> +				    const char *suffix)
>   {
>   	size_t suflen = strlen(suffix);
>   	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
> -		return 0;
> +		return false;
>   	*len -= suflen;
> -	return 1;
> +	return true;
>   }
> 
>   /*
> - * If str ends with suffix, return 1 and set *len to the size of the string
> - * without the suffix. Otherwise, return 0 and set *len to the size of the
> + * If str ends with suffix, return true and set *len to the size of the string
> + * without the suffix. Otherwise, return false and set *len to the size of the
>    * string.
>    *
>    * Note that we do _not_ NUL-terminate str to the new length.
>    */
> -static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
> +static inline bool strip_suffix(const char *str, const char *suffix,
> +				size_t *len)
>   {
>   	*len = strlen(str);
>   	return strip_suffix_mem(str, len, suffix);
> --
> 2.43.0
> 

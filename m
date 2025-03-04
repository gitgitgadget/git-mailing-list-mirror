Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42D24DFE1
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131872; cv=none; b=EeZWMHg0Fd1XXBn7Wlq60bckgrfEkS4yno4sZyaGMOEuHTznx9Jg7qae5NUqdiJXjADqLK2zX5+sXngHXM0ZIIZpa/YYQQqiXGAyTY21uoxRskPw8ASndNtcViEY7BVEO8Nx99wDupUnVShDASxMi2jxPQ6wam8hCD7fCb+TDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131872; c=relaxed/simple;
	bh=PEdLpM3BiQNTv0lpWkA+lMJ0kdIlSiAUrp304gQ1Ot0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc6EaiTUwxivONzD4QpUi4OhA4/RkQx/sktnGy4u4GkOZHcmdkF7lPDP9rYaSxP6QtMQsRjlQkM3Lvly8p/hkOpDRj3c4zTigBKiQPho/MTqXJvZPSKOI7OeXQ1Ulw9XLkUhU5DO2YTw/kV29Hn+/fvWDVuGQsRDQY7aoTm8hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBC+1VTx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBC+1VTx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fc6cd89f85so2535859eaf.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741131870; x=1741736670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLOvITaYLZUYpmkO+3VHMXcBSjXsxI+aPeTYM2L8uzU=;
        b=XBC+1VTxs0iI9T83Sp4BKU4yafcZx/QpiXTf6LiuNGKJPE5S+5V/yK1/uEteGJrAZU
         kjq8995jMafRs83KM/w6frhQjFLqOZZc0nZbZA1unad3jf9CpGP5udaZP9PJwOnZn0sn
         RPrmn4O81VejBPNvhOEnhVd+B+wLbOx85OK41v5WrKUZRpwlyQWrGDrw4Ahbcl+FNY8F
         KUKveA4LokXrFeHoAJGsAC4n6HeFYyDjjrFPSVLmFK/tbiEQJkobtjBjUw+4oMR1R+DA
         pVs9ICdK2O7FRgeSY+Uh+DqpnLJxIKHjvCvnoNCT7PVFBKQ47w3e8uqZ5XYyR0F1ENFA
         OqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131870; x=1741736670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLOvITaYLZUYpmkO+3VHMXcBSjXsxI+aPeTYM2L8uzU=;
        b=q/66lKPG5+dYZ6PBE3JFe3MnleLMChO762sSCX5oQWQRn7KS1cOT901MUcliG21Q/n
         h2A63vJHzA4EYN8iXC5hM6tPJPHu7N0zLCo8TWChZ7CLAo0NmIr8A3VWGJtgN7f8uHGR
         4rupTReeqX1KKpYETnAWENxAgndJxbnKSFzctw4+8yOg17Nsr5ys0G7GwUPIkhHvGtX7
         B6hPZZcdbjV4982LNERIZhkvnVWAFEeN8srktGaFs20hAg+mju3GrhkXIajcoqbG/8wK
         t7DJeJhmWP6GeD2JzUBCMfkjjdf4Syh/aBorkxdgLuyHlSuHo0zL1e/Z1MaNdfqXcYZH
         0UJw==
X-Gm-Message-State: AOJu0YwzVafIhMjY9316ieS7ZGriBoPKGBSrKGJ8GVpouZ6fN2tZGGJr
	9effd2h5o7XmF8VTpsf/ybii0oRU3C0nyx2zOMEakmXb2Hsn9TU7
X-Gm-Gg: ASbGncsKGDk7Zhs3tsRF6zwoH8WL0lGA1QvhZp6vsdiu8afhHg0fAZtoUtxsV/D3JFO
	x77Yd0QXzlxTJLIPN8t68rWblYDD/OWXGydgmT9PztyfkXrVV+dkyQJiONHD7jDjXYlct5rR01m
	6mCo9u3e55qsxTwXjfPbTvvx03QxJN68VKelLFa4eb36cORIHkBa8Qr5mfv+5a2mIKwqsCAYAFw
	AzjzfHBJ+KB7g0/ONZQMW3f6iYWf/YxLb/aHvYJnrqU6tEwZ/ivcIigT9cgsdmamx82wnnq4irF
	qJkp+rHsm07CRgJ2DVbajCbXl1XnLNQru9wWSg==
X-Google-Smtp-Source: AGHT+IFY0xQ2U1yWdtHFusnJgToNhpGVKDoulFJE9lbB1ixdOiHZEFR8xBsy7kdHnsDKrhtOGfUxRw==
X-Received: by 2002:a05:6820:180b:b0:5fe:9a72:3dea with SMTP id 006d021491bc7-600334786e6mr629315eaf.1.1741131870078;
        Tue, 04 Mar 2025 15:44:30 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5feb60033a6sm1848595eaf.28.2025.03.04.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:44:29 -0800 (PST)
Date: Tue, 4 Mar 2025 17:41:08 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>, 
	Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/6] builtin/reflog: stop storing per-reflog expiry dates
 globally
Message-ID: <usf4pzrp322xvfrvsasgy22rnw7d2a6krzuctwpp23ppdgh6ji@ram73wv5dn54>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <20250226-pks-maintenance-reflog-expire-v1-3-a1204a814952@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-3-a1204a814952@pks.im>

On 25/02/26 04:24PM, Patrick Steinhardt wrote:
> As described in the preceding commit, the per-reflog expiry dates are
> stored in a global pair of variables. Refactor the code so that they are
> contained in `sturct reflog_expire_options` to make the structure useful

s/sturct/struct/

> in other contexts.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/reflog.c | 30 ++++++++++++------------------
>  reflog.h         |  8 ++++++++
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 0910a4e25dc..a231cf4b857 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -88,27 +88,21 @@ static int collect_reflog(const char *ref, void *cb_data)
>  	return 0;
>  }
>  
> -static struct reflog_expire_cfg {
> -	struct reflog_expire_cfg *next;
> -	timestamp_t expire_total;
> -	timestamp_t expire_unreachable;
> -	char pattern[FLEX_ARRAY];
> -} *reflog_expire_cfg, **reflog_expire_cfg_tail;
> -
> -static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
> +static struct reflog_expire_entry_option *find_cfg_ent(struct reflog_expire_options *opts,
> +						       const char *pattern, size_t len)
>  {
> -	struct reflog_expire_cfg *ent;
> +	struct reflog_expire_entry_option *ent;
>  
> -	if (!reflog_expire_cfg_tail)
> -		reflog_expire_cfg_tail = &reflog_expire_cfg;
> +	if (!opts->entries_tail)
> +		opts->entries_tail = &opts->entries;
>  
> -	for (ent = reflog_expire_cfg; ent; ent = ent->next)
> +	for (ent = opts->entries; ent; ent = ent->next)
>  		if (!xstrncmpz(ent->pattern, pattern, len))
>  			return ent;
>  
>  	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
> -	*reflog_expire_cfg_tail = ent;
> -	reflog_expire_cfg_tail = &(ent->next);
> +	*opts->entries_tail = ent;
> +	opts->entries_tail = &(ent->next);
>  	return ent;
>  }
>  
> @@ -124,7 +118,7 @@ static int reflog_expire_config(const char *var, const char *value,
>  	size_t pattern_len;
>  	timestamp_t expire;
>  	int slot;
> -	struct reflog_expire_cfg *ent;
> +	struct reflog_expire_entry_option *ent;
>  
>  	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
>  		return git_default_config(var, value, ctx, cb);
> @@ -152,7 +146,7 @@ static int reflog_expire_config(const char *var, const char *value,
>  		return 0;
>  	}
>  
> -	ent = find_cfg_ent(pattern, pattern_len);
> +	ent = find_cfg_ent(opts, pattern, pattern_len);
>  	if (!ent)
>  		return -1;
>  	switch (slot) {
> @@ -168,12 +162,12 @@ static int reflog_expire_config(const char *var, const char *value,
>  
>  static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char *ref)
>  {
> -	struct reflog_expire_cfg *ent;
> +	struct reflog_expire_entry_option *ent;
>  
>  	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
>  		return; /* both given explicitly -- nothing to tweak */
>  
> -	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
> +	for (ent = cb->entries; ent; ent = ent->next) {
>  		if (!wildmatch(ent->pattern, ref, 0)) {
>  			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
>  				cb->expire_total = ent->expire_total;
> diff --git a/reflog.h b/reflog.h
> index a9d464bbf8c..b08780a30a7 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -2,7 +2,15 @@
>  #define REFLOG_H
>  #include "refs.h"
>  
> +struct reflog_expire_entry_option {
> +	struct reflog_expire_entry_option *next;
> +	timestamp_t expire_total;
> +	timestamp_t expire_unreachable;
> +	char pattern[FLEX_ARRAY];
> +};
> +
>  struct reflog_expire_options {
> +	struct reflog_expire_entry_option *entries, **entries_tail;

Now we can also store the configured per-reflog-pattern expiry entries
in the options type instead of relying on global state.

>  	int stalefix;
>  	int explicit_expiry;
>  	timestamp_t default_expire_total;

Now that all the reflog expiry configuration is contained within
reflog_expire_options, I wonder if it really makes sense to also keep
the expire_total and expire_unreachable fields.

From my understanding these fields are not really for configuration, but
hold the reflog expiry configuration for the current active reference
while iterating. This gets set by set_reflog_expiry_param() prior to
calling refs_reflog_expire(). It seems like this could be figured out
during refs_reflog_expire() now.

-Justin

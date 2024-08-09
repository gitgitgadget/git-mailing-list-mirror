Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325A1D551
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234108; cv=none; b=mLa7yjr411Cv3SheIynUkIS6tio1SM2lbZwrfb8bBb3gc9tF+/roLiAI5UKW2r717p/F+tbW9bVIZPx55deX4W6Lfx01+m9ueLuimWVSn57cC28vA0VOoVxBim5o5cAYd9u1J9vbyCxxSl2J8M+SWQUKs7QFYvmaJkmtblrVuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234108; c=relaxed/simple;
	bh=mOfNH3mOSbEKhPRo2maksnI01qrXY0MubtL9HU/KVjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK4kh93bhJghHf0YVWU9xYvOnkbJ4dWjiiys/y/WqXw0P66Poo6141lMa2MD0ojNLheIVWIDq6U3DGSYhqAztBWukt47UZ8k8bQJx4wnq+ojLDZu0ez0DdVS4Qa2LTxAku4KRboMpUoFaRbFhTOgdpaseJcsOcr0Bg50IpSNYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaKoynjB; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaKoynjB"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70940c9657dso1230698a34.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723234106; x=1723838906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1H22qZghwo72E2log/qM4w3YD//MBalUN2TKqmHQkEY=;
        b=XaKoynjB1dRy63DeK8O42yT+pO+XEODJxD1sFdIlhEupNwyebLmOrQqm40/2111a20
         bgbs5/RjBe+kZeRCEkC8LEbSEekLnBCaRNXedMsI027/EIyyLl54iK0PUrbjwPiCLWFn
         JRDVaFAT6D2chpb5ew/UG2BrkZg5sIE6aI0RLgj7Q/9/FNk7XSxKfZ7TELz5RLRO+Iz3
         U5lHGuUqZCFlTjpM/KJafcnPy5ds6EmY1g2L1Fin9xx8iN7BQvdsHUy5ARW8OygbGlDQ
         FMm8IGeWk3awfbNXz/ytcsM49idxgoHelzJWBubgSXZu5WTchg+XXLp90AhzAI7j71i2
         XQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234106; x=1723838906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H22qZghwo72E2log/qM4w3YD//MBalUN2TKqmHQkEY=;
        b=dGx5P0gIdwu3NEQlkp4hby680fIZY2u16v7qPoPFxrecdvkmnVHowQBRqZWtRkEvFo
         1PGpQLf+whQNeEU0jrkUFD2qR+mTN31yE5c+wwl7FTaatn2PQf3s7YNjeR2SJWEqL5gD
         x/OYQT1NDclUmKuehGMTxy1lPO54XisHQ4IEORda9rYUz1NQccBhxfQaygG6fQj9DFj2
         l3mnXfRlnty+vSY7yPiSBmBMI3kVNXP9oflPykFJ8J9gw9KxGiWkLnxvgPJbx2BTmxfj
         Z9+BVeJbyE3hVlr3AHYO/G97RR4VxBUGuXmnFCHG8BphybMHBe9yOWCrEQ7ovlTK//qB
         j6hw==
X-Gm-Message-State: AOJu0YwTXjSkP/RQ7oFx08c3zV7edqBOr3qaUirE4PK2EPqW3PPSUi/Y
	JNz4YyhtjaqVmj+0NRDjxYpDhFG0tjMWhZuOfqx0v06cU93HWbc87V8o3A==
X-Google-Smtp-Source: AGHT+IGoXIuV5ZMPGhGA10HpWsQXravR4NKSAjnaw+Q83agI5fMQiwzU5jsimdrxapMtxaGNgrCgMQ==
X-Received: by 2002:a05:6830:2b25:b0:708:b3c0:1442 with SMTP id 46e09a7af769-70b6b2fcef6mr3300623a34.1.1723234105738;
        Fri, 09 Aug 2024 13:08:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b80d451sm121795a34.4.2024.08.09.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:08:25 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:07:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/20] config: introduce missing setters that take repo
 as parameter
Message-ID: <rg5j5ehur5a2qvpt65ezfub5dmmqrbn7if5f2r7ibweuupsnm2@qeciml3qvdvy>
References: <cover.1723013714.git.ps@pks.im>
 <feae2ad31ac91baae75c46c22c5c3ef3b58c1897.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feae2ad31ac91baae75c46c22c5c3ef3b58c1897.1723013714.git.ps@pks.im>

On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> While we already provide some of the config-setting interfaces with a
> `struct repository` as parameter, others only have a variant that
> implicitly depend on `the_repository`. Fill in those gaps such that we

s/depend/depends/

> can start to deprecate the repo-less variants.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  config.c | 93 ++++++++++++++++++++++++++++++++++++++++++++------------
>  config.h | 15 ++++++++-
>  2 files changed, 87 insertions(+), 21 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 6421894614..ac89b708e7 100644
> --- a/config.c
> +++ b/config.c
> @@ -3178,21 +3178,39 @@ static void maybe_remove_section(struct config_store_data *store,
>  		*end_offset = store->parsed[store->parsed_nr - 1].end;
>  }
>  
> +int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
> +				   const char *key, const char *comment, const char *value)

Instead of prefixing with `repo_`, should we instead use the `config_`
prefix? Maybe `config_repo_`? It might be nice for names to align with
the config subsystem here.

[snip]
> diff --git a/config.h b/config.h
> index 54b47dec9e..b13e1bfb8d 100644
> --- a/config.h
> +++ b/config.h
> @@ -298,14 +298,18 @@ int git_config_pathname(char **, const char *, const char *);
>  int git_config_expiry_date(timestamp_t *, const char *, const char *);
>  int git_config_color(char *, const char *, const char *);
>  int git_config_set_in_file_gently(const char *, const char *, const char *, const char *);
> +int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
> +				   const char *key, const char *comment, const char *value);
>  
>  /**
>   * write config values to a specific config file, takes a key/value pair as
>   * parameter.
>   */
>  void git_config_set_in_file(const char *, const char *, const char *);
> +void repo_config_set_in_file(struct repository *, const char *, const char *, const char *);
>  
>  int git_config_set_gently(const char *, const char *);
> +int repo_config_set_gently(struct repository *r, const char *, const char *);
>  
>  /**
>   * Write a config value that should apply to the current worktree. If
> @@ -318,6 +322,7 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
>   * write config values to `.git/config`, takes a key/value pair as parameter.
>   */
>  void git_config_set(const char *, const char *);
> +void repo_config_set(struct repository *, const char *, const char *);
>  
>  int git_config_parse_key(const char *, char **, size_t *);
>  
> @@ -341,9 +346,11 @@ int git_config_parse_key(const char *, char **, size_t *);
>  #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
>  
>  int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
> -void git_config_set_multivar(const char *, const char *, const char *, unsigned);
>  int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
> +void git_config_set_multivar(const char *, const char *, const char *, unsigned);
> +void repo_config_set_multivar(struct repository *r, const char *, const char *, const char *, unsigned);
>  int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, const char *, unsigned);
> +int repo_config_set_multivar_in_file_gently(struct repository *, const char *, const char *, const char *, const char *, const char *, unsigned);
>  
>  char *git_config_prepare_comment_string(const char *);
>  
> @@ -372,6 +379,12 @@ void git_config_set_multivar_in_file(const char *config_filename,
>  				     const char *value,
>  				     const char *value_pattern,
>  				     unsigned flags);
> +void repo_config_set_multivar_in_file(struct repository *r,
> +				      const char *config_filename,
> +				      const char *key,
> +				      const char *value,
> +				      const char *value_pattern,
> +				      unsigned flags);
>  
>  /**
>   * rename or remove sections in the config file

The rest of this patch is simply implementing variations of existing
functions that explicitly inject a repository and looks good to me.

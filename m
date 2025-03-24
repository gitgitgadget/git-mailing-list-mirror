Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059925D902
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808720; cv=none; b=f+veUscwjlzeRmZHB9/sBDuxnUV/r/0bQZIrp1wC1Py/9mbmiw0ux5u8nMo6YEUDsKT4ILBlafrgMnxcen+1B4K35ZWp2nvnK6wneDSga+ksXQRxmnSCpAloX2fvFuTeYMtaifvMKSmgfRed8PnieA88sv31uhcMtKcoeMteLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808720; c=relaxed/simple;
	bh=5MRyFS39NZ77Zq04FcG3ETspl6qBXQo7cvvRfCug95U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoUGIvVX334MAMfVEnGzmRhkUt/1ycGeXzuFtJOqEdBih6MBDwdPOc8WIBqHzKcLVAqDo3NeoclRCYTFw5xt9ISxj649oZXbczACdmN+/2vHjW+WJDcJJoVbZP2ZqybibKhC6BWJcswBfc1HM1cVXK0ES2ORil5s/7L7DfKFFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6nmzcnk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6nmzcnk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so41766875e9.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808717; x=1743413517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8R3aM/vR+FVIAxIOccGUGFKTs8LCSN/1qeiXRbCtH0=;
        b=j6nmzcnk/kH8HRfglBFYSAHjA9c19hkiJoSxad21rbzV/xui/MNEga2x5cTfPPWXdC
         RrS7CIeFC0uYvCNsKirriN5BFGfiKtbjm2Jv+hk0ijB56HhBTwUpRajNGr3YK5bVpfmT
         7jmSIFJQpQMygHgP81nUigd8NFltbxNp+TWH4xWCrvw6P0BFx5JDtm0e0tejUUUXah2L
         MFVnjx33zaJWrwONubp7szlTevXFCf2cc8YggfzT291r9xl7yf6g71Qc+i7cOEqTKfy/
         yATPeWatYNz2asm4glnhyiKDtkljnqMFQCq5+ZpmHrrYA8glz+ZJwxeOeUsLMiymWheU
         69ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808717; x=1743413517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8R3aM/vR+FVIAxIOccGUGFKTs8LCSN/1qeiXRbCtH0=;
        b=jVYjxytoz4BrAWR697bSvQNU+ASmeQ21RgLeRTHs5Rnz9iHNfE/Yxw7/CEYJgnV1ws
         2iZH0x5ljrrDivyfu7LU9p9fbno39WSI8S6LZGububLFqDB2pLc/Zbo2YqI/asoxGDXf
         QeCabMRkq9S0RWGeRiCaeDwU+rvPpIfxELGk1wJq6z5WnSrOcE/690GBgGvctOBexNGF
         iBOdQ7zWFNZsW3pvwKTAJmj5oNDArKniHJSVjUMjx2nrDUvD/moI9y5OdGQeyxZ9pN/X
         tN/U9BTa0j5D879x7QG62634xG6qWdEphNmWKKuBOKGy12ymwrCwn/zEbMHkOe/bM09a
         g+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV23RfWMZ8F7RupBQ0QniP2PBmK9ULg+trvmLs0az0uSbUgrBV/hiM4w+vxJImdlIfyldE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7X8SnrZ8GG1NA15RCebkSgnViHhtemOGnTsnxBYu/+GEkpnS+
	QVn67yX2cjt07/qNXPo8RoiNSAJ9Kwd2E/8qP5b8qv+8rhbJvOzNRZiWyw==
X-Gm-Gg: ASbGncvLqneLP2uYQkBpVM8mzSR+KPrmwOKoRZTgAsc0QmDkQUMOAbJ97sy58naXL7q
	BTu/IwruAUa4wsMqRHEJBKUNW5S67s9pQNY/c4ggheUY0IhkTanYO9t5gQUoqbNWqk5z5H9Ujpw
	VH0afzXbgl+mA7AeS3inOIoV7nVIGOiRNT4b1dQGT1NkW5yqXyFL8owYugXBLtEVbIGwYOfE5+S
	aZiEWcg5aC2SMLUsQAAmsOIMTA9rMKOttnWzQQ5qD3zrpqQ7eYRepbuU3+IyJcM3bf/M5fE10gN
	FncBKxKkbK7OrMdk+BzZFTP8onpthWh4869n+zsh3v4DA811Bp3r5cYGpvhFtM2E2Eazw8vVTlv
	J5uwiIX8JhHU12txCXPzmYGGYR1J7Go8=
X-Google-Smtp-Source: AGHT+IFxX1U8rZjVpIr2LA2y2FE2JuQBPURXeLuEXqybrnVJhM/cB85I156XRw7S2iiyohXAwWcBdg==
X-Received: by 2002:a05:600c:3c9b:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-43d50a361f8mr78687755e9.27.1742808716579;
        Mon, 24 Mar 2025 02:31:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9956b4sm10326543f8f.7.2025.03.24.02.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:31:55 -0700 (PDT)
Message-ID: <106cecbf-6a7c-46bd-8115-2b5fb06cc9af@gmail.com>
Date: Mon, 24 Mar 2025 09:31:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] remote: allow `guess_remote_head()` to suppress
 advice
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, alan@norbauer.com
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-2-jltobler@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250321231639.180762-2-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 21/03/2025 23:16, Justin Tobler wrote:
> The `repo_default_branch_name()` invoked through `guess_remote_head()`
> is configured to always display the default branch advice message.
> 
> Adapt `guess_remote_head()` to accept flags and convert the `all`
> parameter to a flag. 

This makes sense if we want to convert the boolean argument to a flags 
argument. However the only callers that do not set `all` when calling 
this function are in git clone where we don't want to emit the warning. 
It is probably not worth a re-roll but I wonder if we really need to do 
this conversion or if we should just hard code guess_remote_head() to be 
quiet when it calls repo_default_branch_name()

Best Wishes

Phillip

> Add the `REMOTE_GUESS_HEAD_QUIET` flag to to enable
> suppression of advice messages. Call sites are updated accordingly.
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>   builtin/fetch.c  |  2 +-
>   builtin/remote.c |  2 +-
>   remote.c         | 10 ++++++----
>   remote.h         | 11 +++++++----
>   4 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 95fd0018b9..763314bfcb 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1638,7 +1638,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>   
>   	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
>   	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> -				    fetch_map, 1);
> +				    fetch_map, REMOTE_GUESS_HEAD_ALL);
>   	for (ref = matches; ref; ref = ref->next) {
>   		string_list_append(&heads, strip_refshead(ref->name));
>   	}
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 1b7aad8838..d2aeb5ba1f 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -511,7 +511,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
>   
>   	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
>   	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> -				    fetch_map, 1);
> +				    fetch_map, REMOTE_GUESS_HEAD_ALL);
>   	for (ref = matches; ref; ref = ref->next)
>   		string_list_append(&states->heads, abbrev_branch(ref->name));
>   
> diff --git a/remote.c b/remote.c
> index e609cf5c56..1db88beaf3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2297,7 +2297,7 @@ struct ref *get_local_heads(void)
>   
>   struct ref *guess_remote_head(const struct ref *head,
>   			      const struct ref *refs,
> -			      int all)
> +			      unsigned flags)
>   {
>   	const struct ref *r;
>   	struct ref *list = NULL;
> @@ -2315,8 +2315,10 @@ struct ref *guess_remote_head(const struct ref *head,
>   		return copy_ref(find_ref_by_name(refs, head->symref));
>   
>   	/* If a remote branch exists with the default branch name, let's use it. */
> -	if (!all) {
> -		char *default_branch = repo_default_branch_name(the_repository, 0);
> +	if (!(flags & REMOTE_GUESS_HEAD_ALL)) {
> +		char *default_branch =
> +			repo_default_branch_name(the_repository,
> +						 flags & REMOTE_GUESS_HEAD_QUIET);
>   		char *ref = xstrfmt("refs/heads/%s", default_branch);
>   
>   		r = find_ref_by_name(refs, ref);
> @@ -2339,7 +2341,7 @@ struct ref *guess_remote_head(const struct ref *head,
>   		    oideq(&r->old_oid, &head->old_oid)) {
>   			*tail = copy_ref(r);
>   			tail = &((*tail)->next);
> -			if (!all)
> +			if (!(flags & REMOTE_GUESS_HEAD_ALL))
>   				break;
>   		}
>   	}
> diff --git a/remote.h b/remote.h
> index 6be5031f64..7e4943ae3a 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -387,15 +387,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			 int show_divergence_advice);
>   
>   struct ref *get_local_heads(void);
> +
>   /*
>    * Find refs from a list which are likely to be pointed to by the given HEAD
> - * ref. If 'all' is false, returns the most likely ref; otherwise, returns a
> - * list of all candidate refs. If no match is found (or 'head' is NULL),
> - * returns NULL. All returns are newly allocated and should be freed.
> + * ref. If REMOTE_GUESS_HEAD_ALL is set, return a list of all candidate refs;
> + * otherwise, return the most likely ref. If no match is found (or 'head' is
> + * NULL), returns NULL. All returns are newly allocated and should be freed.
>    */
> +#define REMOTE_GUESS_HEAD_ALL	(1 << 0)
> +#define REMOTE_GUESS_HEAD_QUIET (1 << 1)
>   struct ref *guess_remote_head(const struct ref *head,
>   			      const struct ref *refs,
> -			      int all);
> +			      unsigned flags);
>   
>   /* Return refs which no longer exist on remote */
>   struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);


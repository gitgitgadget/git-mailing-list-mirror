Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7A2C3242
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017507; cv=none; b=Pvk9u75hFs7aSc9Zy3d8gdLX6xnLZ8MJ+/NhcwX1hxRwWzWcPjcRv3iIKs8LWs0X1wMqojq1GQNl590mM+OmfW58yy5eqDojOnjSkGxt85fgIdIe440r2stk000v8uKqUNuI16MLNfDIxPrnRnDh2Ry+O76DOT6yC9yOr4xnjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017507; c=relaxed/simple;
	bh=lO4DWMDfwsk0hUNY/KnLvbdiFNtetOZU7XzBqmpTVPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuvVu8ElKEXwLQ9vHA9TZdzey4QIbCts8rVu8ND9vKMjDaQRsJWZbzS7mOjeVLw3ecub7XtiLIcrAWIF3HRoyEjfGDkGCk6jIqVIvx1EtXa10R8d6DAZu0Jqf7DHdEm8La1dShVhsrn10sm0DciIiyonDXkfIgaoT8DTF8aF9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW7/2hNL; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW7/2hNL"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6196c753e66so918252eaf.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017504; x=1755622304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxynbyrTMxy+j5SB4y2mOvfSh7AFIqMxPk4Q6x3yUaw=;
        b=nW7/2hNLFqo0dTr3nCBNJEhrt0WJrdvBld+i4DDnoSWOAG3OcJ6gN168ZaAFwKYFNR
         hCGn2LPobwmWXAl4Kcvd/bjjozUDWiT/58x80I1PUlyp/u4DHb0tyS3vgQnQaaAxqNDX
         PepBZS2IV8a5vshPWhg1U8LSA4cn/RWF4dBMxH4ae3wIZTjpIa3/MOs2rND+U7sRlysk
         uzxZ5dZpCA7KJJNlfL2KtihXeeKrhIBQa86ERXXCYwNiahI7AekGVvQUazD9+P09XmTk
         L+Zx6oACU9yCKITzQ5gKntRbiTae5HxWxRlrbVn9XmYVkk4tO1H741wY8a/DkYvMFWzU
         afVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017504; x=1755622304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxynbyrTMxy+j5SB4y2mOvfSh7AFIqMxPk4Q6x3yUaw=;
        b=KdwqPwItbuurF/IBwN4xYd2Wp4sBLiobfdyZcnnL9EVU9Flep6uiBLDdceXtvXbwHt
         hr20xmfs0yACG9mvfgMvZN4HzrYQY85/w1kjfqnAE+U7V8zx7ij3dYiWLmnYvNrvnT+e
         guo1JrSUkzDBCxOAZQFoLcdb2AYMCrmDQZ2QMAh7c/iuss9kER0gZ8PomumWv+HnwfTU
         6MyH7EkIU/vltqNA/Km3NIWF/693IQyVHm8tWPcdKS7+5qa+7N4Jh/nC2mLOz4mYRXAx
         SOdrGpahpPCSQyFOFbk+b6gG2i/52p4I7JKtqRI8c2ZSvneLz85JX6tv2ZD/uLFmwerT
         V+Gw==
X-Gm-Message-State: AOJu0Yy0LQYjqDXh6TD51Nb5gHUM0aua14wN441Rx5clDBYn3ds7faEk
	7PnT2aRTUFIenQMWY3gtJdft+8MZ/w3qPTR50/wQSbp12EPpxSqF7yp/
X-Gm-Gg: ASbGncvZyY8oYh6GrGyQBfyJaltpaWTFdTuBBs1v0qeXAkFsQ6dfI5F+lP8IisxYe9f
	RF9wwCxZ4UnDEerQBqXrRc3oxGuTxDTo95Biu1+yaYKQymFhsN3ys5vy9qP1KqMQeiCiWpBE1Dt
	ElgFL8ly2jG40cE5udOE8XEVlcSGV7Y8XpXuBQboq2Cx4e7aSoOsA5WZ6bXFXWG5URgkpbTz5ak
	uiwsR3nJdNCtZfb+5yAcJwXXv46lN3CLdLM4X1KE7kA+haI5HsbHPSXVjH+vqFHBC2UDMkEY23C
	W7ckQ4Xgv475q9J/YzEcnHMjf3IJWHn17eUuaWjOxR1nT4J6woLDS+OwJCiqt8VNzeSEfO1QfgM
	1nSJkPwTP6vnp4z4=
X-Google-Smtp-Source: AGHT+IFpa7bQJP9S+t3OrBEmBN9a6uSXfmQ9j2Uz9/qtXBYmfu2BurTae6OHB/3LozNG3lbMGsWp8Q==
X-Received: by 2002:a05:6820:16aa:b0:61b:924a:b793 with SMTP id 006d021491bc7-61bc43cd36dmr295981eaf.2.1755017504391;
        Tue, 12 Aug 2025 09:51:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-61b857deb43sm1182508eaf.3.2025.08.12.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:51:44 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:51:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3 4/8] reftable/stack: fix compiler warning due to
 missing braces
Message-ID: <puevci6dx6qf235usn7sxi52hlt2n5dcbe4gb2r3l4yekvr7mq@qp7l4nwkbnvg>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-4-cf3b2267867e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-4-cf3b2267867e@pks.im>

On 25/08/12 11:54AM, Patrick Steinhardt wrote:
> While perfectly legal, older compiler toolchains complain when
> zero-initializing structs that contain nested structs with `{0}`:
> 
>     /home/libgit2/source/deps/reftable/stack.c:862:35: error: suggest braces around initialization of subobject [-Werror,-Wmissing-braces]
>             struct reftable_addition empty = REFTABLE_ADDITION_INIT;
>                                              ^~~~~~~~~~~~~~~~~~~~~~
>     /home/libgit2/source/deps/reftable/stack.c:707:33: note: expanded from macro 'REFTABLE_ADDITION_INIT'
>     #define REFTABLE_ADDITION_INIT {0}
>                                     ^
> 
> We had the discussion around whether or not we want to handle such bogus
> compiler errors in the past already [1]. Back then we basically decided
> that we do not care about such old-and-buggy compilers, so while we
> could fix the issue by using `{{0}}` instead this is not the preferred
> way to handle this in the Git codebase.
> 
> We have an easier fix though: we can just drop the macro altogether and
> handle initialization of the struct in `reftable_stack_addition_init()`.
> Callers are expected to call this function already, so this change even
> simplifies the calling convention.
> 
> [1]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/
> 
> Suggested-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index ed80710572..9db90cf4ed 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -664,8 +664,6 @@ struct reftable_addition {
>  	uint64_t next_update_index;
>  };
>  
> -#define REFTABLE_ADDITION_INIT {0}

It looks like there are only two places where this macro gets used.
Being that `reftable_stack_init_addition()` is always expected to be
called, deferring initialization of the structure to that point seems
sensible.

> -
>  static void reftable_addition_close(struct reftable_addition *add)
>  {
>  	struct reftable_buf nm = REFTABLE_BUF_INIT;
> @@ -693,6 +691,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
>  	int err;
>  
> +	memset(add, 0, sizeof(*add));

Looks good.

>  	add->stack = st;
>  
>  	err = flock_acquire(&add->tables_list_lock, st->list_file,
> @@ -739,8 +738,10 @@ static int stack_try_add(struct reftable_stack *st,
>  					    void *arg),
>  			 void *arg)
>  {
> -	struct reftable_addition add = REFTABLE_ADDITION_INIT;
> -	int err = reftable_stack_init_addition(&add, st, 0);
> +	struct reftable_addition add;
> +	int err;
> +
> +	err = reftable_stack_init_addition(&add, st, 0);
>  	if (err < 0)
>  		goto done;
>  
> @@ -866,19 +867,18 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
>  				struct reftable_stack *st,
>  				unsigned int flags)
>  {
> -	int err = 0;
> -	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
> +	int err;
>  
>  	REFTABLE_CALLOC_ARRAY(*dest, 1);
>  	if (!*dest)
>  		return REFTABLE_OUT_OF_MEMORY_ERROR;
>  
> -	**dest = empty;

Now resetting the `reftable_addition` is handled by
`reftable_stack_init_addition` automatically, which is nicer IMO.

>  	err = reftable_stack_init_addition(*dest, st, flags);
>  	if (err) {
>  		reftable_free(*dest);
>  		*dest = NULL;
>  	}
> +
>  	return err;
>  }
>  
> 
> -- 
> 2.51.0.rc1.163.g2494970778.dirty
> 

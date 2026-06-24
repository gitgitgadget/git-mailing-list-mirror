Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4C242D84
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338798; cv=none; b=tmysdj4vaiI0jEmgyi4QXehxTiJp7vQckuAAWmhITDgK3WblFZL7kEDaJLLURFuYAVelNowmtMs9CchqYMHjPc1WuY8rSPnJhIIZlYeToDkPdKSjla4rwHSj+hxxZmpeB5cWrVIm6uieKeW/AmO5WwuNzDw2P1szepRzPKJQMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338798; c=relaxed/simple;
	bh=1Z893bDH77liQIoedfI1Y2keKyAJJ+BCAWFBx3qBWYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=telyrVboP0MNLlz3FF5ETXp6z2hKj3rdXK31sGxqqRg0o09HRoEqGi/ftJi97+txWPhZ1H6sNvf+Zzwj3TG1c9zKTxUygsjzELr1y5zbfPkXAl5dd94QIHZXks1aWjLGEuiHDuvOtLkAQKmQiyiJhWOVf+UhsPCWkTAZTOePBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV31SiKK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV31SiKK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b5c374e5so292425a34.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338796; x=1782943596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euviLyMFWDWtBs5bWW2P8UJMB38/4NFog0g45rvm0TI=;
        b=jV31SiKKpXeHjdBr2hWm83ifwT9qnyipwePvuteAzn3teoBV/mtwqWL47izZobzOK6
         1nDwv+cOrj/M5HmKAtDNyI+z94aboqzgtpE1+NgjQCdlX+qkyx/9Gdeqlerc2NznTP2j
         ujEL9e0OEaenMfYCeeoQz6X9cZyGPfg5OSX+/DI8ZdRJ+Hn0S9JeM6iI20cqIW+krk5w
         TaSji37UWe/D9ms1pAL6VaMEQ+6f9Dzjk0HJUOKaL17EabnIHdqzlg5vxRHloTzUiPx9
         b12jNkDY7e0g6Qq7DPny/MlkdE3r0IOsqtrS6Eivef/CecGidRwivksZM0UwEWZbBFKe
         wKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338796; x=1782943596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euviLyMFWDWtBs5bWW2P8UJMB38/4NFog0g45rvm0TI=;
        b=WWEsaoo1QhX5dEU+MzMG3Q4vRfl8QoBrlzWz3BP6qevuqsSFGACbzSHPPCuFvyyEXh
         iXSnfDYWBC4/J2Cn6sQQbvFKKg78WtH5JpPzDrnJzn6NhfjMmxeCEIngdjv+Y/igAH3p
         N1o9bsk9oiAVBQPC6UI+GAThf+j6mn6EB+cNJebHcSaGcD9v1u6lDZWl1B+kclx2V7cr
         +GPd5SPFG8DQ0PvUurdBvp3xBQrbdmDpaW0Ql2imJzs+SMzYJwRBWdYOH1JoAqbkMURc
         uySzdZce2puBiEY0+VrmRWo778lDD6TfTBbGimkPDlyNHiIMDHG2OY+SJd0dyXGU37H3
         hy2w==
X-Gm-Message-State: AOJu0YwN/PtzGbwSyVSco0DhMRqcMlzl+HSBYvB5rNlFRAhv6HJmKxVr
	4AB/YbZA21kEsYzbhnxHd5lzsHqb/gselnQli/3NZ6oQGM1F9Pa4GpkS
X-Gm-Gg: AfdE7cm/JNbnBlw+yUEM/3q07/oKM+ZgehD6jjDV4qn2IDw3fZs7BLjZ887tIH9w2fI
	K1PGizrjUscCzBwXQudNgUdpc+VCI6230YNSdoFOXO5Cjypb/0rE4TJacO+SP72gKs146OrCHUj
	hz6AHl/AdKGG2Rl/izzK70SSWhUM5yy+HpG0UbUdHEyb7isszolbn4vhsEblA8LyFaz9Mf6gY9p
	Aw8wzZpyyXBv8QZGGpjA9e4AmCFN3tUwFEtQxWqBVjmKlYZZoc+mWu7dvVRAEseeoMgESiFZ7jq
	JTXZ1SR1n/bRMKHYz9S6rypP8jxYFzbEOv3fEm8S0NGFjGaj7CSxIZfYJSHK8+6zbMy/nFl7KwJ
	LXQW2ZUoVrg4hjXSbq+NlRgG6Aluk5sUPmiJjMFJYBJablde84sKQJjfPf2gaos/rMMEy3scSnI
	1cYUsejA==
X-Received: by 2002:a05:6830:82cf:b0:7dc:cb0d:9e02 with SMTP id 46e09a7af769-7e9915d3000mr1669458a34.9.1782338795646;
        Wed, 24 Jun 2026 15:06:35 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94406d488sm12265306a34.8.2026.06.24.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:06:35 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:06:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 09/11] reftable: split up write options
Message-ID: <ajxR2fLRsIvNYFtz@denethor>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-9-018475013dbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-9-018475013dbc@pks.im>

On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> When initializing the reftable stack the caller may optionally pass some
> write options. These write options mix up two different concerns though:
> 
>   - Of course, they allow the caller to configure how new reftables are
>     being written.
> 
>   - But they also allow the caller to configure the stack itself, like
>     its hash ID and the `on_reload` callback.
> 
> This is somewhat awkward, as it doesn't easily give the caller the
> flexibility to for example write multiple reftables with different
> options. Furthermore, this requires us to eagerly parse relevant
> configuration when initializing the reftable backend.

Naive question: are there any current use cases where callers may want
to write multiple reftables with a different set of options? Can
reftables written with different options pose any correctness issues?

> Refactor the code by splitting out those options that configure the
> stack itself. Creating a new stack will thus only require this limited
> set of options, whereas the caller is expected to pass write options to
> all functions that end up writing tables.

Splitting this up sounds reasonable.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c             |  29 +++---
>  reftable/reftable-stack.h           |  30 +++++-
>  reftable/reftable-writer.h          |  17 +---
>  reftable/stack.c                    | 100 ++++++++++++-------
>  reftable/stack.h                    |   2 +-
>  reftable/writer.c                   |  21 ++--
>  reftable/writer.h                   |   1 +
>  t/helper/test-reftable.c            |   2 +-
>  t/unit-tests/lib-reftable.c         |   8 +-
>  t/unit-tests/lib-reftable.h         |   2 +
>  t/unit-tests/u-reftable-merged.c    |   9 +-
>  t/unit-tests/u-reftable-readwrite.c |  38 ++++++--
>  t/unit-tests/u-reftable-stack.c     | 189 ++++++++++++++++--------------------
>  t/unit-tests/u-reftable-table.c     |   8 +-
>  14 files changed, 258 insertions(+), 198 deletions(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 5115a3f4ce..608d71cf10 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -48,9 +48,9 @@ static void reftable_backend_on_reload(void *payload)
>  
>  static int reftable_backend_init(struct reftable_backend *be,
>  				 const char *path,
> -				 const struct reftable_write_options *_opts)

Ok so now during init we only care about `struct
reftable_stack_options`. The `struct reftable_write_options` are only
needed during reftable writes.

[snip]
> +/* Options related to opening a stack. */
> +struct reftable_stack_options {
> +	/*
> +	 * 4-byte identifier ("sha1", "s256") of the hash. Defaults to SHA1 if
> +	 * unset.
> +	 */
> +	enum reftable_hash hash_id;
> +
> +	/*
> +	 * Callback function to execute whenever the stack is being reloaded.
> +	 * This can be used e.g. to discard cached information that relies on
> +	 * the old stack's data. The payload data will be passed as argument to
> +	 * the callback.
> +	 */
> +	void (*on_reload)(void *payload);
> +	void *on_reload_payload;
> +};

These are the options split out from `struct reftable_write_options` and
are the options used at initialization and expected to remain consistent
across reftable writes. I assume these also won't depend on reading the
config prior to the ref store being initialzed.

[snip]
> diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
> index a66db415c8..6ff4ddfc60 100644
> --- a/reftable/reftable-writer.h
> +++ b/reftable/reftable-writer.h
> @@ -28,11 +28,6 @@ struct reftable_write_options {
>  	/* how often to write complete keys in each block. */
>  	uint16_t restart_interval;
>  
> -	/* 4-byte identifier ("sha1", "s256") of the hash.
> -	 * Defaults to SHA1 if unset
> -	 */
> -	enum reftable_hash hash_id;
> -
>  	/* Default mode for creating files. If unset, use 0666 (+umask) */
>  	unsigned int default_permissions;
>  
> @@ -60,15 +55,6 @@ struct reftable_write_options {
>  	 * negative value will cause us to block indefinitely.
>  	 */
>  	long lock_timeout_ms;
> -
> -	/*
> -	 * Callback function to execute whenever the stack is being reloaded.
> -	 * This can be used e.g. to discard cached information that relies on
> -	 * the old stack's data. The payload data will be passed as argument to
> -	 * the callback.
> -	 */
> -	void (*on_reload)(void *payload);
> -	void *on_reload_payload;
>  };

These write options are explicitly passed around during write
operations. I assume some of these options must be parsed from the
config and thus will need to be lazy-loaded to avoid "onbranch"
conditions prior to the ref store being initialzed.

The rest of this patch looks to be adjusting call sites to wire these
options through as needed and looks correct. I don't see any changes to
lazy-load write option configuration yet, but I suppose that will happen
in a subsequent patch.

-Justin

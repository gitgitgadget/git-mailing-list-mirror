Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792815421;
	b=gcRuwRPxrWp9Jjv5uwEQ61gaGZxjw1eIbmeu8bv1NdZpmz+iqP/RHdipVHOwjVp8jsb1
	 +vYcHmDitXDKE77wDvcvGCRHItYcO3nYVkP352MeSGwsh4xi2g9+70Fsx+FJ9pHtgnNaB
	 XXYoraPBfNFS90s71NWITNi6wdUZD2AFAFIKszERDqW1FZvqrCEe54PwD0/23ntXSjZ2l
	 EQgP0v4FHnOlhwvKtK5kzMzlUoCNQzLhTIHnSB8lmkrPps4oUpOWDIR32Y/F58rxiFltu
	 zHn5cbNAoyUAaI6fjTEdYPDEXno11/NOtlguWgngSQqIBJ3uol6iTLc/1M9fLFQLwEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ntRGyU5XzcOh2J0pRNCELW+kPIwEA18RsQJBa3e+O1Q=;
	b=5ArEikXf9/yWE0BgVndk35yDGenmzzlY9DcUKDXTtl+sVUq0ldz+4vqyK3TrSXrNQ+Ml
	 g8W4/kDOYoFGcSwzDHKecIZqkrjLNYP2LCFGZ71smCq+BPaDEX9MKqGDaqfeEEi2imNVO
	 AFyJXlTjjNyttlDVmj9XIs4NUWPPUxuEoH4DoON6oAcb/yaXecn7j1goVQELDYvCjKv3H
	 dJnW0aDkBtZaNy/XEwhOoIMyHM5ip5ByC1isK1yJm98dc0gkrUQfQ8e0dHMzs45wkNV00
	 NOvQzGxMBFIaFchpbP250+vrlJvJrQ5Bn2juI91zWqW6JrtLZByYvVp7P4e+uXnVGaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5zm+DCp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27E606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 04:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF27E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5zm+DCp
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e948e56af3so654522e0c.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792815420; cv=none;
        d=google.com; s=arc-20260327;
        b=KoDCgR/tdMEcftS8h4WM96XhKwxeN3Y3qaauXg1TI7zjTLmEKoFVP5m3SJHcX6z2Hy
         B2HIyGPXsknHeHMbbvuUVcMY/mw0Ztzk/DBsprDC0z4Dr5NqBGhRAGbc2q+a2hz107ha
         7wnTt4HyPft0YKCFCDsEQyMRHn+RkV367/WHamE+qRZNLWvxX69uV4jX58uU/nh5wKiB
         K1mq3mcew/HYrZrVNSb3LdnLquYNPXY/mPNvDZgAaWHrG//1xM1LdFHnBn2TwG5yYMPs
         ZBLjRqfRkR89UMSeB2IsIL9VtzSilnJzR3O50cwy+iXofbfEXuulX0aT6AmghcDP1yn7
         CcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ntRGyU5XzcOh2J0pRNCELW+kPIwEA18RsQJBa3e+O1Q=;
        fh=VFkujceCi6Ml8oCNInE1wM/xgv0A/hbpIb5lMNmS5oU=;
        b=NefaS8ltOwN8qq0i5M8W440VEXXE1bSmrHs5vJ/dNzkT8zVA8L/6+iIfy0YN+JYOIN
         2cyq8eGuAj3cAknbkjOHa958sKnCKX3smnGLSfrtACapmdl++3vc1hmf0HSZsfldkToM
         POXe9vdh2jgyMI7wdfC+YHD3KxQ+Zi5XDcdR80CW2l8+kTWlfzG9gvpUZ7c/53YCUNf0
         jl8ZCgGQUO0xDwL3JVsZEmqqV7mS3oHSeIchxACn77OWedIuAxJVELu1RqC1SbP/KTJi
         nRU4gsnKsL73T1ACyRQ0suftazoKzyzXQwL9Z0k++FUEPfUtdzOtUiKZE52z+G8QVlfc
         2cOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792815420; x=1793420220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntRGyU5XzcOh2J0pRNCELW+kPIwEA18RsQJBa3e+O1Q=;
        b=K5zm+DCpgeqJe5M59ZJCynW2j9UvVtSMiY3v6AhJQdqzGoHtVSs6CvImGNaqgAJRrq
         P4H/VhNB6EBOupK5GYDg90ukm34I+Ee+w4z+rwkql0WV7QVKfDGb31qquKwfNCZKRhBO
         VpqaD2tAvpKQ/VkD/taFkASbvnC5QiTul9By5qWkadMrxggO8iuyOIb5pJlscZKLzTRY
         H81JjMTum0o6duPA1YyQjdV7lWTROcEbtN0M0tzOVxySDtU/ukIZUr6GmW1N46MKibqy
         7kIN9ZrOmqBXpqbsM7BPjoyvfBB07q9aVQi2J3ki0XPlNxJaaID5G7CyG7+aQT5kPqz4
         JCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792815420; x=1793420220;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ntRGyU5XzcOh2J0pRNCELW+kPIwEA18RsQJBa3e+O1Q=;
        b=NhOT5kzdJUlYrpgF5oXkkdmGShr98B+MqFiE2/iMGo9iBFAXjHhpXKHAMygyrK5XHb
         CEIMLmWr/QulT7fw7NAtmOMpYdnO3CyZYTtmEKM3FrNCeUCirbBlBmLEuhpg5V/ihJkp
         wIZdQNymB0d14R5ntLZufuqPNdKmOeKiNpyIIMrD5krCBUpyThkhA//n9U8cKucJzdEQ
         6KrU1bkxcA9UEcTg1ckWVu8cf442dBM9Hf6V+yRvZTlCF+5fMnxsGtr5NnsjSRdgYthS
         DcDW59xYRwNU+6vmLFdVrL6MgIb3V/UbHCnobeKQiWupHEYED8A6aMBV0LyaY5EA6FCJ
         TEAg==
X-Forwarded-Encrypted: i=1; AKwUvByFUApqS/rHA7hPiMsvpPOMiQlph7zD5M7sAEUSHbizL/XREfNP8HbcoUlwL0kfmIjHjxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK40HqYr8JEIdALeeoc2M+kMmgBjxR5T2euOcrcXoDJL9Qu8lVv
	0YhPDQ+zI1BreyYLae4Jx7XDF0AZPl16mBVKJ8tDipmvT98GaysJ9GVG07om6+9pM+hwrwZSoVx
	LzP4oQdn3MzkbTywdNjAmU4U7bJ2CxwM=
X-Gm-Gg: AYBFou1hY6TQgUkLk06gAAd8xup4E60gL2A4l0zxybGIRi4I91Zu9A2eQ0spAdiL+OD
	+A8kZ4ZnbTOdxi09I5zLN+DVWp56/vWGKe+qzoRoHDbZ6R0P6c1TnlFzUhbNxq93uNy0AZTtzsH
	DyLtMy8/qd4z4HHfiSF4hlQzS9yVQWx5bxhIaUcCifw8w8+0+Mvw2Up9nHT4jlKBYB4GbXGbWbc
	GH7D3NsQjiO5UTMr/vwei/nH1gsm8Ma8oR13Dv8yKKqeps4NOJR8EqtP/hiAoinIJN7aPZMzcj9
	lsprjSg+iPXE7OATQWXHgL4XW/TkNlUr6xJ7KcwDIq7kk8z7U0uJ9p67YbYE5JXyvP55LFA8phd
	PUrbiAkhHJ9H2oo1s0jXV25oiWJqOXqH3/0exIQ==
X-Received: by 2002:a05:6102:38ce:b0:7a6:b8fe:e834 with SMTP id
 ada2fe7eead31-7ce5cd91472mr293444137.27.1792815419631; Fri, 23 Oct 2026
 21:16:59 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <pull.2266.v2.git.1792428811100.gitgitgadget@gmail.com> <atsGfWzCMW0LMHNX@pks.im>
In-Reply-To: <atsGfWzCMW0LMHNX@pks.im>
From: Shashank S <shashu8660@gmail.com>
Date: Sat, 24 Oct 2026 09:46:48 +0530
X-Gm-Features: AclHuK8LbOzRd3Hy4NWzx4MgWv6w6oN9h2M1rUNYsO_ZoWef7_EK1a6JLYR_p9w
Message-ID: <CANHmUQRSckmVkxk_+nDmEb2uySewheJj7gvsFRTVD2ByVDh5Uw@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
To: Patrick Steinhardt <ps@pks.im>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 12:32, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Oct 19, 2026 at 04:53:31PM +0000, Shashank S via

> >        ## Commit message ##
> >      -    prune-packed: remove USE_THE_REPOSITORY_VARIABLE
> >      +    [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>
> This prefix shouldn't be part of the patch subject itself.
I will remove it
>
> >      -    Right now, the prune_packed_objects() function uses the global
> >      +    The prune_packed_objects() function uses the global
> >           the_repository variable. To help with the libification effort,
> >           change this function so it takes a 'struct repository' pointer
> >           as an argument instead.
> >      @@ Commit message
> >           prune_object() callbacks to read from this new struct.
> >
> >           Update the builtins that call this function (builtin/prune-packed.c,
> >      -    builtin/prune.c, and builtin/repack.c) to pass their local `repo`
>
> One small nit: I don't think we need to have the list here.
I will remove it too.
> >      -    variables. Because we are now actually using the 'repo'  parameter
> >      -    in these files, we can safely remove the UNUSED macro from them.
> >      +    builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
> >      +    variables. We can safely remove the UNUSED macro from them because
> >      +    these commands are all declared with the RUN_SETUP flag in git.c,
> >      +    which guarantees that the 'repo' pointer will never be NULL.
>
> As mentioned by Junio, this isn't true. The repo pointer _may_ be NULL
> in the case where "-h" is passed.

I will improvise the commit and submit a patch v3
>
> Thanks!
>
> Patrick

Thanks!

Shashank S Mogaveera

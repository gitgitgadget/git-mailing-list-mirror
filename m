Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896292;
	b=02Gog3fsWXSG+FEAql7KbplNM5oDQEN36C1D6vHdsxwrDPUM92R7pXkYjbhv3DbJhun8
	 PnNMNNIEnMcjycK+nqI0f4lsWH7VNj9L/IDpNBsQ0Czpsxg+W+5PVtBCDrscy4hjwmASh
	 6Un9gJ+LLXoX2deRsUZtBcQ/FYZlLh1ZgJDhtIQMoXPtksWKjGGtLrdAPaxN1epMJU6VK
	 t6AwicrR39IB5oBPEw69q7I3W5UuaWdQze0MKeJ8L9F4l9+M33zZR76aePDHlfwxE9iAV
	 TY9HmNe/pUJilotzrkOAAPkcMK8vwRbef4E/nRGuPJJtVjd4S0tUib53W59C0xSKXjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tWSiJ4HHEEfEjfMhziiYS1jYmeKmz9xdDi80xZipqZM=;
	b=B+276gHtKszkKdF4N56STIGwYcAHdvnyVFL8zFxiGTWHiGrnavQuTL5L/b+VRETGIm5m
	 IrbBnfGSR+vWK8b6UrsetVGe1K8DcjWhBV6f9Y08q15QMw1sHKaDJsy2tv1Hk3A0pvr2e
	 XcxePiXg9OYm4snOFes6EdKbSiZ+QgiLQB6GJnvkdBvzJTx7YTEszkn/I8x0knt/XqH6T
	 e9yX8LFyYega8/S3xLhupWw1X13wOi2Ou99+e5MA+weeSyeBS62xLlDRQAil85N58/BmC
	 M1Z4KNQFDGUv2qluE9PhBYk0iIlhXYC6SW8pRYo4xnKSVOQKt+3Yt9dYNDgsQ2PbGlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="j/gb0Wqn";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5639606EEA8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5639606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j/gb0Wqn
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so958139a12.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793896291; x=1794501091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWSiJ4HHEEfEjfMhziiYS1jYmeKmz9xdDi80xZipqZM=;
        b=j/gb0WqnbXMKMqOwby1PJz80pM1FPPxV/eXtmuV/vXazaWZ6EhO5+TdlR/11m1vHD8
         uubWAKi78SpOdB+pStIL6qlEm5V1Z21BQc07YB4zN918YlOEYoasnuNKCoC1XNtbVYg4
         HXhgmfaT41zhO80k748ZHQSkHQIQbjuvuRiuE3jzSIZUKMkhzX25AbVl7MLA568n/7P9
         BTSk1Ce5H2pW/HSF/SBLI3sIvjYrGVhR1+J5MC5bb0M2ss0mhwUtoCGaTsmrP4s7p3xq
         VGTKwFyVs0Asnh43Uxrp3PlaJPAi8uzB6RnG0hpEJomD5Whd41k1C5COMCXx8TfXJXe6
         Y41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896291; x=1794501091;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWSiJ4HHEEfEjfMhziiYS1jYmeKmz9xdDi80xZipqZM=;
        b=v2jn+Nhq/nTOlOie5Y//u0IGLBiI3zHpps+aTDIEkd+OtwvXtJ67YrIEiPixkun54N
         BgJFZpAJIBI6anxzeYtby+ZX4IjbrOK0uQ+SfgGyO4pgccpAODAQGSDuL4GeW7uk0KF/
         AlcghshuXF+Of+RT5/LVS9WyXoQvSUtieBUVqfyGbrBMR2PDrMFm67a0LQ31wUUxPgCu
         NQt+uqR+6/5O7YwikcKkcI4UMgAxY6FZRZ4dBR4CTx97zJK5dXazhTXK8Pj3tKOZF/H/
         53es0GdirdahewoPmYUkoBovfAqb1QwfhByVRgoozUwEINpZDNcjUCSFkukDAyZU/ItW
         0pOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTSylFd+8ND/QMhj3XhtRA8mj6rQ1JpYAnOg8+jkcjeAEpq6UTKvtRyIqSiQLuuxHjGgQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+f3QJKzrwjDsc+bXkZkVlM71SbkydWnCDkp5jVK9WnP1T58F0A
	Xj9T+PWMz/cv5ViQQDSH0264mofhEHaxfecxhRw8zyl9GBRwTlomNafT
X-Gm-Gg: AYBFou35C52RTi//1w3FQQWyapkSW3+MIPRLEQrasLeQiXxnp/4rWSgAm0qDuHvQdwW
	MBXhYzKRezbkge/rAMJKbU8yIeTo6Y1yzypQJMFPZZMJp2AdLK+7bATMeWdhrzNkxOS5wEAVlJj
	lMJDjVOABc2OcxZ8mekCjqeeJw7/Ve13LRcL07vpbUJSoUUZSXz0usAlxNZ6QxOS4lZ2tezICfA
	GUDrwCkkHbwPJ/Tb3ZgbbjOkPcUk93l7QDqvav5HrUJpmGNrTBH3wrA+BbbS3jDfUxlBxp2F0J5
	v1IAbrJPfmqghJQuEa1Ca1P965oZLLvjvmEZQjznR8rOOJRocSPoeR82nFEZ6JEbc3DbRHuKbS4
	1PpZfFTAb+Jjhnv2H8ZVHYihfsobXJFxCJ4ce7c4vcjKUm35QZ+FneY7lz2zpXC6VjLjSFnicq/
	MeraPBrUhZ5o2Ngg3oX6ioKjFL5c/qbBDfUZiBVGoI3TP/r3djKEGY8rT3Dir2PJ3lwIhXBhAXk
	c5OSXbMvB7KkhFBns8C1vhy0r11fGHxxjUpfI4Zb7+UUw0x4IQCV7rfmE1hlbomy+N1WOWPkvJ4
	KXx9XBUTzZnoO4q4EnkvIm7mLdNpyxkd3n3NtYg0f/g=
X-Received: by 2002:a17:90a:ec90:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3ae89831a14mr16791280a91.49.1793896290920;
        Thu, 05 Nov 2026 08:31:30 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31d2b5esm4465816a91.15.2026.11.05.08.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:31:26 -0800 (PST)
Message-ID: <894327d9-57b5-4adc-b300-25d946211606@gmail.com>
Date: Thu, 5 Nov 2026 22:01:22 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Yopa Nelly <yopatatchou@gmail.com>, git@vger.kernel.org
References: <20261104172434.691381-1-yopatatchou@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261104172434.691381-1-yopatatchou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 22:54, Yopa Nelly wrote:
> From: Nelly Yopa <yopatatchou@gmail.com>
> 
> When a repo has multiple promisor remotes, Git just tries them in
> the order they happen to be in the config. If you want to try one
> remote before another, the only way is to move lines around in the
> config file, which is awkward, especially once you have per-worktree
> or system/global configs in play.
> 
> This adds a promisor.fetchOrder config variable that takes a
> comma-separated list of remote names. Remotes listed there are tried
> first, in the order they're listed. Remotes that aren't listed are
> tried afterwards, in their original config order. The
> extensions.partialClone remote still ends up last (that's done by
> promisor_remote_move_to_tail() in promisor_remote_init()), unless
> someone names it in fetchOrder, in which case its listed position
> wins.
> 
> The sort happens inside each pass in try_promisor_remotes(), so the
> existing "accepted remotes before the rest" behavior is unchanged.
> Within each pass, the order from fetchOrder wins.
> 
> I put the parser in promisor_remote_config() next to the other
> promisor keys. It stores the parsed list in a file-static
> string_list. The per-remote order field is set in
> promisor_remote_apply_fetch_order(), which runs at the end of
> promisor_remote_init() after the partialClone remote has been moved
> to the tail. The actual sort is a small stable insertion sort in
> promisor_remote_sort(); order == 0 means "not listed" so unnamed
> remotes still sort after named ones without losing their relative
> order. It's called once at the start of try_promisor_remotes() and
> is effectively a no-op on the second pass if the first one already
> succeeded.
> 
> I didn't validate the names in fetchOrder against the set of
> configured promisor remotes. A typo just means that remote doesn't
> appear in the list and keeps its default position. That's how other
> list-valued config variables in Git behave, and it keeps the parser
> small.
> 
> No test, and I want to be upfront about why. The t5710 fixture
> always has the server satisfy a filtered clone from its own
> promisor remote, so the client never actually triggers a lazy fetch
> inside that test, which means the ordering change can't be observed
> there. I'd need a different fixture, one that gives the client two
> promisor remotes and keeps the server out of the picture. I'm happy
> to write that as a follow-up if that's the right direction.
> 

To be honest, only part of the commit describes the change. The rest of 
it reads part like you're talking to the people on the lis. You might 
want to give the SubmittingPatches section a read:

   https://git-scm.com/docs/SubmittingPatches#describe-changes

Also, this patch kind of tries achieve a part of the project without 
actually going through the RFC part of it. That feels a bit strange. Did 
you possibly misunderstand what a microproject is supposed to be? Did 
you possibly read the following guides and have some difficulties with 
parts of it? If so, I'd be glad to hear more about it so that we can fix 
the same.

   https://git.github.io/General-Microproject-Information/

   https://git.github.io/General-Application-Information/

-- 
Sivaraam


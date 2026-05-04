Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C591212FAD
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897972; cv=none; b=ZUlcCMbXvs+PBVnOECNu17Hoyws7hspOGNVR62Nx+ydNzyj6kajcIPwMmlzi0SmV16kUsTtqEW3vevMPloH6I4/cJ7bVmRtZgJxT1+KDMWHOGJUeUAhWlx8ZcJRW2uz7P+d1T+wzwITWB+nPQgYDZ956T/f/gOZmGKTC6cWdW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897972; c=relaxed/simple;
	bh=KRmA/w0Ftl0KIu/brc3R3JqSrHPGoLYuhDjysk3VIuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEhhnz/c2Z+6JlKVH3FxxYmwcw7Ux5eow4DKn6nxiQ+S6hkBpNwqxMIrxmb2oBPWZ5GlX3z88/bkq3zlDxhjkql/2n2cEfU4yEMMqncMcowJuxlty0/xZwKbw0Irkk1utmYZrZZ/5ofoTC3lBx6ipOXxwvz14X98EFKkInku4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcQKCvJ+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcQKCvJ+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d65f4073bfso560484385a.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777897970; x=1778502770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lc6Quo+zgzv0k3nPnd9lRfk7rWtDt1F4oNyQaoiLqvM=;
        b=PcQKCvJ+oGiGIvqIfjKYwkgRfMFsN2AQMnwCG+a0GsBdz5zzcPd0hrQ7uQvGMt4Nq7
         lA2ZGlGy6Xi/tMbziRAs7ub9NnvRFCTVleAty9c2A6uFtrseYq6vi6LNuhDXiVAqEjjV
         od19WjMujNktmKOIMgmqFcgYd422Qm01jpP14UoPShdYoAk0lVJC5KJavzHOcmZcOvLj
         PUqgzevyszN4aPAUsBPCc3ria7446Q9omRnooq8TQ36Dx/Iur8GuHR+7qbD+G5I7ieSD
         /qUCj4Y3bRBOMmivb5nWnVvs3y+qvvvR8Rnc1ZsdnGlvgi7QN+1P2uHBsndL4J59MnX0
         xP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897970; x=1778502770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc6Quo+zgzv0k3nPnd9lRfk7rWtDt1F4oNyQaoiLqvM=;
        b=nj+64mrFfC92kqFixM+UbK1AbLv1QiUd/pwAXxG+dH8SYck9rD4BXmtUs1Sy5R4WmG
         QigsOZrIZpvnlIRRvvBHNT4kaOYof1XTV7Ta3BinMgyvb1wxqL6/lrBoZEEte+w3i4ug
         h4Dg05k19REYkicQoMb4i7R6anKTdFj8C3M1zyOnZZBROBMlaABL6xMyCeC7JCv/rdg2
         Y+t6J0g+HBd526zYchW+PhnblF5nWNG8j0TlOpLTpbsxkhCX8UyPI4UlfK1/iInU3Naq
         dxYn+dncOXwc9Z3P1VPCLQTSNymOsBmIZMyKLNvVo9KBkXzysFCn2JWzLycVlBTSOfio
         XluA==
X-Forwarded-Encrypted: i=1; AFNElJ/Wu2bQhBHIVr0zaup9lbZ2MMRPFXWNOcgr0gX9pZuLmtopmcAXFZVG3yJWrt8Zb3xfOME=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEucX2KFePKoOYqzZ2TyDNILuekkIvVzQkZG7quv+/FLbEM8Q
	cg0M08+QUsV0cn99zbnX0X0q3/WjvgdLPnr8N5EHJPWkcNxZF2sO04Tp
X-Gm-Gg: AeBDiet+Rr37iNt/1ou5kDuD+7M61hZmL8979279zzbzLjHjwogNfUno16BZ82imC21
	+PbQFueu4Hkym2Vz9A0qF3yY78FZ2sc0V4igrglYKMFRNoGsbCJfWpSiQkekjs85ud+4kOmxVIT
	PXoW1HnW8fNq0qtGf6mXET4Tq2pEyWsXwCtKTrDMin/gYqc/KIDPKEfS4THRD7f5q3CW4JaHsDA
	xCqFPYPOipXsGGU2BRZPxIIObnDhPA66KqS9bTrtP85PCzUKM8ZaVZzmCs3OMNvflyKyb6DSk5r
	hMXMUnRq6CEPdFDmfrGKDhtq/cBqkXjGYUoywF1K9oWWT4AVsgIz1FAUWxZBQC04ZlFAzQ8GLO/
	vZWNWvHH7LW9jMuPSDc3qThX9M3wlDg/f6Z/re2XrLqCFuS3RewBRt7hQsTzopBR3mTcC6jnC9S
	abx9dYdizIugW95a51ZTkGBPXXzZU5+eSTKkQwPEJOPRy5kwkoghK4qgg8+5DVMycxcYMR5Q35y
	rVMAwUb
X-Received: by 2002:a05:620a:25d3:b0:8ed:e1d4:1644 with SMTP id af79cd13be357-8fd15ade523mr1343065185a.3.1777897970518;
        Mon, 04 May 2026 05:32:50 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253c17sm1126700385a.30.2026.05.04.05.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:32:49 -0700 (PDT)
Message-ID: <f8a376a2-33dc-4e9a-9365-ae453c1452c5@gmail.com>
Date: Mon, 4 May 2026 08:32:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] path-walk: support `object:type` filter
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1777853408.git.me@ttaylorr.com>
 <db46c1248ece57476b369a9bff920facab24be04.1777853408.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <db46c1248ece57476b369a9bff920facab24be04.1777853408.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 8:11 PM, Taylor Blau wrote:
> The `object:type` filter accepts only objects of a single type; it is
> the second member of the object-info-only filter family that bitmap
> traversal already supports.

...

> But there are a couple of side effects of the "trees off, blobs on" case
> that need fixing:
> 
>  1. 'setup_pending_objects()' previously skipped pending trees as soon
>     as `info->trees` was zero. For 'object:type=blob' the call site
>     needs those pending trees: a lightweight tag pointing to a tree, or
>     an annotated tag whose peeled target is a tree, can both reach
>     blobs that are otherwise unreachable from any commit's root tree.
>     Loosen the gate to "if (!info->trees && !info->blobs) continue" and
>     similarly retrieve the root_tree_list whenever either trees or
>     blobs are wanted.
> 
>  2. The revision machinery's `handle_commit()` drops pending trees when
>     `revs->tree_objects` is zero (see the 'OBJ_TREE' handler in
>     revision.c), so by the time path-walk sees the pending list
>     after `prepare_revision_walk()` the tree-bearing pendings would
>     already be gone. Fix this by setting
> 
>         revs->tree_objects = info->trees || info->blobs
> 
>     so pending trees survive `prepare_revision_walk()` whenever we
>     need to walk into them. Path-walk still resets tree_objects to
>     zero immediately after `prepare_revision_walk()` returns, so the
>     rev-walk itself never enumerates trees redundantly with
>     path-walk's own descent.

Both of these changes are very valuable bug fixes for the path-walk API!
Thanks for catching the distinction here where we should still be
walking trees in order to find the blobs we want.

Thanks,
-Stolee


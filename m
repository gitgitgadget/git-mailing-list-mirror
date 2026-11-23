Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472747;
	b=OuyR0xWcAsMYUr5/4RGTu7QznXFeH4Ys5ii+HSNO/pZg++yiHg7kJJpF323Gi+yH59fb
	 wVPiaXuQ8oCOrB4jOITPVr8qh6wlxeUy6xAHDDURRI590n0NY9T8EC6LcvbAC2PwG9J95
	 M6n59Ikh7VDtiHpQuVYDTLiLhYo+zaefkl5CI8XmDoCiaXqquGUennvXn2Qvu+sxUJNNd
	 M5wAXVtlZXgGSaocQf7q9LFWSGK7bFwFfsssQtCgDHLJQZTd4i8hzSUdtxdj7XY3MRUhy
	 jDTD73XzZcoWM6vnRZ0cOvSRhzuBmkqPfOoBGXzUf+pNq2fkkIIUmoDaxdx9TgzE4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OfAcoRbmopzXJQ03Lq48cglqJd9e17BZdWtQAftXNW8=;
	b=34T1kyXpWQs4+l3FdzTRAvFvuHN/qJ5NdkL9QzOrlyh8eqbz7B5V923x859HCnzV9iug
	 +lhFs/+SeFmoNToiUHs4uvVSaAkPFK1kFAlmJ6OstjnLtXt8Q9myYnM5YwPEXwNPc4fHh
	 7FehNsOHXAH2w526dywwpaIQME3ExxruEXKsqUNa6Qh+ziElimGOwlNGJVNtDoyTHDhg1
	 IDOw4Bi47vvQ1A2THICCpEf+ZESMUdngUd49sJsjwrlNgFKHYhsNbvzP+FIDdh/uMazRQ
	 Uny2eewIigoWsdhxvnTu50fTLKEis9sFQXXs+FyZx9ylZHp1t+C+Jjqdb0WwjPPCICQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=takXWQMv;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24B606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D24B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=takXWQMv
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso1545425a91.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472747; x=1796077547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfAcoRbmopzXJQ03Lq48cglqJd9e17BZdWtQAftXNW8=;
        b=takXWQMvqmmreKKjtUXP9wOkJN/cvvJH8CtpolhhNfQtwyPpTc5WvTf1/hpfZnZmxI
         h1Mm6kCzZYrRTr1k/zC6bN6giD91DRCHHn6P6A1Up5RvZ81lZQral/js1KpvFpBw2X91
         jlUOo6LoWMgLm0avfQRnKxJIeVabwxrOKzzYOGCtszeJDYNgwA3BvSTzoivAYBMBvmPN
         o+DbjJSUdfYlWD9mqJDP3MR2PKzdKFVFSMfZml4Dgy9r5Ee4xnlDwET/ylpj/CeakKo4
         VwyvffWQtv2YMQo4bKPg0GTGt4jHnyETZbd4BbSbCn0KXe6Z3sED9T82QnD34YoVGJNV
         gPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472747; x=1796077547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfAcoRbmopzXJQ03Lq48cglqJd9e17BZdWtQAftXNW8=;
        b=k1pKzD+66oTZunQzTR+pceFOL15+iCZGeJSoBxQec9tyHyplkqr5CI7vImIyvz0M/0
         JEZWOEjpjJlwWK7+I96P3ilrLq+8C+Z4+lInJtXex8SgkOZHY4XJhje9DogmeaQb4IZN
         +krobuF3mREz0f62mI5yVe5QDuu7bA9Cg8Bf8/ax+HydI8tn+VrLVfZymZBxZ8v43+54
         WLWsHodx3Dyn+iP04AP8xnE8hjR/GfdZcWT1lddune8dHDZyUyu90zNAS2+32gHrS+lU
         sCOTSlCs0LGNtBgeC7Ys99T4FjOz90jR9pJqMjxPryxezXAZE2kL/5Al4psr9TeRuIDz
         i5uQ==
X-Gm-Message-State: APuU4Z89b3lQWqQ0A3p2YAIl1w8kKFG3+D2fRerYhcVhYYEERBPwThi6
	rp8meW6MIbxDiazSTz0/ZwTPeKstl5FzBsmS4XyaIHww6utbAdPJK+ZUiyW2+s7gDGo=
X-Gm-Gg: AZFdTZfTR3eNtiZyaP3NOa+Ql1IGhn6j+YaLxMidujnB7XrCnKrIIvKqiXtb0jTciGg
	mOKZk7HFr6JhJ6MAFK1T/BNeoGZGHRR+7ZqRMOHuqStVLOAsSdoiXq2EeHBx2HrANd7kcVtL2Hz
	3fMaCU+COvlqZVF2UTxPaTsA7OILLt3l1DTzQxxDIY0MptmHGOI+E92cV+yjRaVYEGZODmRoAv8
	Na7BUDhikL42yE7iY7sYywkoR/ycAegTVlHUEK3QJkbKcbiIFUy+TSVS0r6QKIrXZrN9JG9DHzP
	22mwHJas2NI+IuSmHm2IBiWPZ5trP7PqiPcCF3FFFgFx3skSCSoUw/S/mboPVYRDixy8Vzpe+OH
	aNqcHgjVPIoIQf3laDa3+zj+g0BrMx5j3XayRyf8lzbYroFESRT9L08wkBMxot6uLmFABGQ0x+6
	qpHA68koZ89ioDgm7y5aqrIElQWD+zZKvZStP68uCK7JuJc7TXKWX/Y20yB+9jMjrdbrH2M32dE
	uAGtvXHLdK2v52GLPfxwxuNr0CJATKUhrQ4Ge+g5lb5bxSZFfi/Hrj8ZoekBEAu667U7oI3D4w+
	9nQyruwh338bgDc/5XiItnGWvHn3bZmg13dnfvpVW0OjSDHhqfwgRVUpWCxyYjVk0Y/EE0hDVJq
	gVYYYGY1Ar7GaUHkT9/czOg==
X-Received: by 2002:a17:90b:2688:b0:3b3:b71e:b2e7 with SMTP id 98e67ed59e1d1-3b41c92a209mr10575386a91.36.1795472746555;
        Mon, 23 Nov 2026 14:25:46 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm22972365a91.10.2026.11.23.14.25.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 14:25:46 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 3/3] bundle-uri: do not die on unresolvable relative URIs
Date: Tue, 24 Nov 2026 03:55:41 +0530
Message-ID: <20261123222541.60600-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq1p8b5kfw.fsf@gitster.g>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com> <cover.1795415793.git.aniketgupta3001@gmail.com> <ce37d9588d833d306df3cc9d0e656e09c32e6b44.1795415793.git.aniketgupta3001@gmail.com> <xmqq1p8b5kfw.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is minor, but because bundle_list_update() places the bundle in
> the '.bundles' hashmap of 'list' before we come here, a failing entry
> will stay in the hashmap with '.uri' of 'bundle' set to NULL.

You are right. I am able to repro it with a server that advertises a bad
entry: after the three errors we already print there is a fourth one,
"error: bundle '<id>' has no uri". A list given to --bundle-uri does not
show it, as that whole list is rejected before we get there.

> which may or may not be what we want.  After all, we have already
> issued an error message, so...?

I dont think we need it since the earlier errors already say what is
wrong. I tried dropping the bundle from the list when its URI cannot be
resolved. The clone behaves the same, just without the extra error, and
the bundle-uri tests still pass. I did not want to hide it in
fetch_bundle_uri_internal(), as a bundle that is advertised without any
uri should still be reported, like we do today. Will do the drop in v5
and add a test for it.

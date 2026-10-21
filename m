Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573456;
	b=NfdkJYKww3U5m7IFUGiUWDDN2lFMIJgiunzhU2h3MMy6dKOyd/JVBXcWTlOAXk+J3WCo
	 D7EDgoASX2utfvsvGi1vXzGcqfDZItfVP441g7z2x7A958lxEFAYH5WLdGoUTziB48BCe
	 oJdTVvTA3DF00jgHjZ8q/26/vS2vOISLDgbqPH2i+SyfiBdVz4EaGCvXgyaGmlDoJBN9F
	 6k4SxVhrkvlHNbeTEl4/4WMmvyQX44UtVVauMoDXwgf8TH7H5ovqq4AM8DdxWKpejKqZh
	 kxRn7IkAxJ6q0Xww7ENN6oHqToNFODa6jg6PlRl1g4Lplyv700keDBDyWOUloJIlvkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ee1Yy9Qua5SIns2VUqjJNgeQAFYnihwL5OW9PlE3+E=;
	b=eF+gbwK3ayATZvmjmrZd06btjkViDq/LpX/NF+sNV2DR4fm/xxAbmbkWoEYFOAnq97uH
	 GhXRJsSX79/NeVcmD3QqZ+lCtMYLm7uMpGgdFk+BoAATmwtldvHHaqLiOOuhmkQKovYTr
	 lUj9dvwL8d09F0PUEVZ+htq27uNz8VcQE1pF/sDegRK618IfCEpMwdUWBftwc42QjtHt3
	 Dn9ecfKtSVWEWUKPnejPYyKwAdivvRJWi2p9foNpn7izYz7cHTE9Y2aitn0eaRt67LUYW
	 ZT96LOLkVmYYeGNmyn1vRnrE96cJkFPWiRMplGD9/4yBqAAehtEg+tAMKRuWJtf/MCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XXMTU9U+;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F5606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5F5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XXMTU9U+
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dc202a60eso187176f8f.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792573454; x=1793178254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ee1Yy9Qua5SIns2VUqjJNgeQAFYnihwL5OW9PlE3+E=;
        b=XXMTU9U+2JQQfYDfcfFUio/sQwGSy8ZVOTq5nVFd2MOp70Etfu6vfXFiOnIuWdUnWG
         R+i3SGVrTYdGzt1enhbq/1KnSe+C8K03QVdWrU4j9wXrovKLpEGsQOVAtf9Zl5wdy235
         864ng+NWkRMFMAosioudHC42wcHEAM0dU49+fc1HwgoIAYHg8KBEkkVSRaDfnrUYPifo
         2q6xMK158Eh33Jr4ogVPU4jY5khcl5UXSNmnmLvb3Mco6LhBj6/cHCIJuEHzssM8kT9z
         XkxUR86JBOVrjPg6CkCo55++7frSXbCbMRumKpXkgAJ57fmkXv9VUj4Vj2nzHEx3mAXx
         VZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573454; x=1793178254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ee1Yy9Qua5SIns2VUqjJNgeQAFYnihwL5OW9PlE3+E=;
        b=SzSa02SplCd+DIk7nCs31tD2R3iW3uzanvzZom7PAwuP7QuNrQp/9911eD5nVqOwY0
         5XMA2kF3HDSYMFm8J19I9HWNocd+lBbwbSSTZBs7ydiptbGTE33sNxVMeW2YtB+5nIyB
         UrS7EvhfP8CocK9YIIj2Yk4IUtU0G6VHS/wy+YXq7r+fkHUSNspXXO6xKW+9ruTG0DwP
         c/Ku7xuWMajotmQ85jzIw3u7RN4pAtWMq83mfGj9gjm96OOsgALoW6vATckUPvCuWCzy
         klPqIuRLNJNq5s1rAi68Bhxb4pr/TDR1YZy9CrSC9n1SYDN3/MXE0uj8HlhCxaIZUcYh
         GdJg==
X-Gm-Message-State: AFq9FYIFh6fM6LPtbv47IvV47DKwV/4VK7QVyxYPg0lpo+fJVUFULZpF
	GFjHJn9ZWr7Xi5pbRvAJOGenqq1MmKd+8EcooInnVWl3E2LzKWkVbv+o
X-Gm-Gg: AYBFou1dwSS7PYLouE4jQa8q/u3ueeMWlJ2yF2tZYbIcm4Y02KvqQLzV2+A+aaboI/R
	spDwIgLsVKvH8ZB9Wk8fpkFJr7Z5QqkRY7HLlRpjTp042vOq41psZe+u+mWsO5Rs/45esjE7ZZb
	Gz+Tkt8JNiXNK7sUEDFe0ig6rd8IO5MV72RP90IneWRxopu5XaoaDvM0vkyvLDfaYz6JPnmctYZ
	XPe5qburygP4xR5DOuNx4AvIrMWcYyw+Ze6irK/+dTPO+QuogCrKmZK7RTxFr3XAbREBH8tnw5C
	RKPv7kevRAFPPbcr6mPmOF6HpVkvEfYJOLzefBPsD49OHpxIzLjw1TqahMTh52WZh9NipaY7ogQ
	JWg6ZvGhFIJa2/bsraYtJTi0PeFJCDcdVJ7hb+dXv+B/f5Tl1XZXX48ZSdnsITcQSoLqt9imqT1
	v5AJsrybwr8rSKwZuev5ZDGnZOYKcgOWry0JDI0BCEBtOxBwHrLW14EeimdXzZXYVJnMeSAGkoN
	Ztc97PcnnnIVH4I5AmIZCkxzhuOMQGyNUbs2Vf+1MRBuvTgeuI/kTvOeGuXa8wtzgejyqgXDRO9
	kDeu7ZYHi2Qzabe/rbuvI1MkIw==
X-Received: by 2002:a5d:4848:0:b0:48d:ef0e:b791 with SMTP id ffacd0b85a97d-48e264f518dmr1876673f8f.54.1792573453926;
        Wed, 21 Oct 2026 02:04:13 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584afe1sm4466126f8f.56.2026.10.21.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:04:13 -0700 (PDT)
From: kerylefondji7@gmail.com
To: Muritala Mudi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [Outreachy] Microproject: use Q_() in builtin/checkout.c
Date: Wed, 21 Oct 2026 10:04:08 +0100
Message-ID: <20261021090408.835-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
References: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
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

Hi Mudi,

Welcome to the Git community!

It's great that you are taking the time to ask these questions on
the list first before preparing your patch.  As a fellow newcomer
working on a microproject, I found that discussing things before
coding saves a lot of time!

Regarding your questions based on what I've learned so far:

About Q_(): Yes, converting to Q_() is good practice for
internationalization. Even if the English text seems to focus on
plural, other languages have different plural rules, so using Q_()
gives translators the right structure.

About keeping the scope small: As a beginner, keeping the patch
simple and limited (like starting with builtin/checkout.c) makes it
much easier to review and test without getting mixed up in multiple
files at once.

Also, Junio C. Hamano recently shared an update about how we should
approach review discussions before sending new versions (v2, etc.)
in MyFirstContribution. You might find it very useful for your workflow:

https://lore.kernel.org/git/xmqqa4o94e0r.fsf@gitster.g/

Good luck with your contribution!

Best regards,

Keryle

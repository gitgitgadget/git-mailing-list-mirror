Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491744;
	b=i7PHSa58H5MeZFBJziCgCKY460xOqUH2hSSHXqjxyP3Q8n5nvmBS4jfeqc9hQ+goACfi
	 N+WUM3oeOXsZ609Wvm4norgVzyJdvyAF7fO+76Q0BuUDtNRQOtv5Y1MBMCiReDpTWkikZ
	 0mcA4E4ArSBB8odafIMbUWyvLuSrITscEB8uhTjloT+pqrJlo/YbnUX/KKm4Mgm8ZASvI
	 nuxo7c6rlAJ+fs90yIfnqzW1+Hj4/AEwyYJ4Dw2g9tjyGONFY0QZQMsVBb/DJoRTJsJR2
	 Q94wrG8CozfVLHPzQsMcQTj4EmKR5uHj8UwZ+aE/YmlPceYGpOJjC7MtmGcn6RTWNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=goAGoYok/yPZ7kDGJ5kxCTKsFJkF6nbkyhbpiuMxu0E=;
	b=5GNlofIpaz0G4RKCiFXZrMSYjpRHONlcNkV23D1gQxjerjAu0si05iimqxkQWptnUmP8
	 rvlyJ1VOF+L4uTr3as0wb8YGYjjw4uuT0sjpoYlPTLd7h2M3ZfNYh0qGAJorpr97kyqlc
	 HSWRS/xRdliQX1BO+B14cZc/6LBGmDBVigNwcrWHKZROi5I5ERHeM9W/zP+FT9psHVgg6
	 l0Y+OV27Le/hJmXcE0wO+9Xn9PhoSrvKbF3Q8gsPlOR1Q3aYndAnEpv76MNllU4v+hBig
	 00MbEi3++0VzXSRHtP6QmLC5w8qj5IVp81CL/X/C0TZjlpjnJ6zUIh1fK45biq/sQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQ3ILJRo;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2D606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A2D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQ3ILJRo
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1944843f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491742; x=1793096542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goAGoYok/yPZ7kDGJ5kxCTKsFJkF6nbkyhbpiuMxu0E=;
        b=fQ3ILJRoowCxpuZin5k7kX0UJ+qogIIP9+0hR1NFtOIH859S6waC+meig/uyAaz2T9
         mcNCT58Ikjr11WnIunC8EMpDKyt8uki2xhzHalWXuokCMtOKp6vrL8wAa6bNGC+ht0bu
         bDOVK32kMB0lO8vg4AGeO3SgysjtFFdgbceTuSkfR+5Se9PjVr1V+4YlwoAnaO2fKLdR
         bkdyLMutWTx+pBcpypULvrL2BReKaIllySb8tj1aHQSMKxiQHCgD3zQBJfb9zQdUQZyX
         YO9bXwVuyZQCZxcOJ8TFqS7mPV5jpyqTgFa/WoXpXbU8A1QdFkDGtH09iSaRmmC845vV
         x59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491742; x=1793096542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=goAGoYok/yPZ7kDGJ5kxCTKsFJkF6nbkyhbpiuMxu0E=;
        b=xE+x+L9ypPyIsywWFen/Zm3aKnFz1xWKInHZrA55i8kSKcUO4tzdiki3NrYMhNIumx
         PeZx/HeSZPVBIRDYBWeJzMLHVN8UBg8UGxpD5iSPmQbCITJTIbl7u/3HHlIYpsSLKXQV
         JTp+QN4aGQE7/Ke8DlNXizpdXiEWuK+Dff6MFoicPzIWBORLx37cmvEyA6nm+Vi8kiaw
         hNbZj5QPysUGHUjCamONycX5pFJ+R/hWlCdi4EHRv5MQGP8OrendeI3d9RPjKhmQQb61
         ePQMh3SGLMLhk0u/+UZylZVHbPJfkL3Zcx5qr7Dash5ls4rjhjq81xzxf1/+WYEha/xD
         xXdQ==
X-Gm-Message-State: AFq9FYKsM+4LwAdqVBDrWGt56gkSkijkSthQlTckKCJb21BS6gSx7ST7
	HWAzqrqXt0RydfqkVZPzESUOM+l6wS5ZTLc31KHYnohMzK+CEvIs/q6kLqPEZEtp
X-Gm-Gg: AYBFou3rcPJZ6LFQ/bHsLv4RLyIqYRjkiDyDrsrAmPNTFON3OPDwtHAtqsS1Q+80TJE
	XYUYO/ge8Yi8itmMmNEw4HXNkPb9lmEXxTeCn3QfbUKjcB727CV3GmleghH94FfpMBqJhrK6hvc
	x0PrXqgealNYQzmyFqPk4lQ5LotnG1TZMvBg3QZktRlwSaap1RteGavDlNy6AylU7yBvM9dgpiC
	r4vXylMEc+DbcNUWVCe+wbEgggqNWqMJHjONA95sK6j6IQjTzkehdgqTBzESxy+w2/cJqj3rya0
	7GYFxJWIiuSJTwAVXqMNcsBfcTAtTULRtytz/kxUM3nLjFtEOx1VsirN15e3KzxEE18b5SzO2r6
	otDK5EnBdZGwrwHPxq9sT11ef2NMfAHLLMbRcGGisoUHcZsvKEk7e4x6OmLaa2eF7/4ziVkeqA4
	P5xhVceEdNTy2ZlfRdYfVF7knou/OQmABH4iCBAmqzb97/VP0BlMc0UoWKZ33KOhl0lFgRcxRU7
	8zI13Z9tvFPAxTUNE5p/6w=
X-Received: by 2002:a05:6000:2011:b0:48d:f14a:917e with SMTP id ffacd0b85a97d-48e07baf651mr20715786f8f.11.1792491742172;
        Tue, 20 Oct 2026 03:22:22 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6db78csm5254913f8f.2.2026.10.20.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:22:21 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v3 0/1] archive-zip: refactor 'path too long' error message
Date: Tue, 20 Oct 2026 11:22:09 +0100
Message-ID: <20261020102210.829-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqmrs92y4c.fsf@gitster.g>
References: <xmqqmrs92y4c.fsf@gitster.g>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

This v3 addresses the review feedback by wrapping the overly long line
in archive-zip.c, while keeping the proper use of Q_() for plural forms.

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221819;
	b=vGv2S4mHZiLkGtSt6RatwwQIr0hLbLqqJlyxbx/JuYozXIt8l/332wr5OwtvFe6RvrQi
	 8Lc7uVB4MU5Zijm3PdeR8pjDuA+bEXDWZDb/GXuuqwmyvK9++C/ETVw0IUpUZzqt6s9Lu
	 OQu/FIAK3k1V1bPK5gAQIRqnnOIv092PIvNLSOrbkPNjORG5yqNR0QnN7DUK5C9slUa7Z
	 6m6cscpiw01RjupuPZInE0MtM82Uwvrmi27I8SSG0JB4V36SVSs/wbYPibGNNjXw5Prz+
	 Sz7gaUL18SAYffKhgqtGbW4MU/AnpKACEvV+2rDkzF1NTtjzKAlBtyxbAYDxe9adxZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S1s86Pn8hmoKQcEhFv1MD8JWMK05wKNPgpprgCmdSBw=;
	b=DXLzpWcMt0zsrfDlahX/QR6wu4yJJ+TwjRgpn5KA8bFvSVVSjaj0IjP3ymxsMVsSkN+/
	 BwZJkWB4on0Y88QMYh7ULNQOaldynojfHUBrNjlo89QlvJudgssf+nzVaYP/4G8Fcrp1X
	 /xGlG9FOoLQ7ktKmZcRJKk12VR1h9SNSKvEaMroh8QrcsaZgQNe45QTZSfJhN7NaL/N3t
	 eceSU5JD6IK7zE1pjSss80kHWOlPAN/9ZM8htm7plCQv/xM/k40nUaYL6QtIdbxybPrY+
	 lVTi4ZeFRY2dqhY/guFJI576xLTZNHY0ZqsMWxmk3dERGCveopD6NND4K8IyPap6iIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sKbhOtt7;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5A606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D5A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sKbhOtt7
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed0e2015aaso2513605ad.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794221819; x=1794826619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1s86Pn8hmoKQcEhFv1MD8JWMK05wKNPgpprgCmdSBw=;
        b=sKbhOtt7yfavSgar6QYs4zW+mUU36uEZo3dkQGw6Y14IPmJ15tRBHroLmtBPGmq3CM
         aT8TSwu5+YkLjKZ9KQ+2mxkhSWBAiYKeXpkSMfbgqmsdSuFbP2wWk5hrBxDhzHXoe0Yk
         YRGC+ho2JbXL1AqE6SrlA/hT/Hd7l4Z7afqvf/0GdT6XEQwXI2KCmH6YI8utOt2KPTIJ
         LxXNi1SJ5lpJ3M++4KEjzmLwC9Q8d8f8whNzdLryKBiTZMCPQS6qS5/062xDY3cAhC+J
         oTZ9nECUKfdzMbp8AW40wyLvBzPylKnFUtqAh6PSNCB5BMapriKt8pVPQzeEDIqcXVQc
         hJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221819; x=1794826619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1s86Pn8hmoKQcEhFv1MD8JWMK05wKNPgpprgCmdSBw=;
        b=Nik2ppk43pxNJn0lgU7YMU95fCmmjaekSzm0XETchyprF8Ml34C7ZwI5EqISInSm8X
         5fzysFdTEmUQGUHfDmjbiYHs5AqXaBVaP9xAIAWl7elSTIoE9x0sQ9i5TiD7LLq0zZI9
         0woxU2YzMXGN2KJZkR7h8X5tRaPEJUt+/BuqVZ7+tJLgg1OBWmym/LWWK1iTZ0p8MoU0
         ZOiIKb2V5Uz7ZS1W9kpjbg4OYmPzFQxQWeAPIviuualjf4EupGEgKoJNiGgRPEHG+1mf
         3tdI96iUW8J7zb2fq4NisI9qUbabulrWEYE8aj+/mwsygLxe+ZSogNKjZBkPlaytUmV7
         IGjQ==
X-Forwarded-Encrypted: i=1; AL+hErFPfffvslnQHfpLb/RWOllmo5sVtXQBOD+NhcgipBjkxz5b+QQ9EJKDVKYSusgj6KTPhno=@vger.kernel.org
X-Gm-Message-State: APuU4Z81wmG6P3aTBW8DbHb8VS1CdZkbSWlwnW9giv+aTiLCpT5fcp7D
	b8es3++NAN1uCxHLi4SWZGARFGvgGVPNTOmnv3wR4NkrmzfNLEZXfgp0oPXc067RMSs=
X-Gm-Gg: AYBFou1X8e2lhnaOX4p6vKQXuoEtKUjis03NxUwJQy3p1LMaOegCbpL9jWlR5VwAYYS
	C7oM+IvlMuIW+r7PVEqBWKu0yAhU1E0XrtR0fuZRNrdXyCBgF4MK+Gr7CYYSvBrnjykFPOntTbJ
	gZhnT2oE3TYrYDdTUTpABLpriuyc20IqT1B66AI6ZUaebb4n/WKb4zu80SuY7BRFCRJj7V3iEVW
	TCMOhUI7dEJRd9NDR7y61Sx6a9sgjsW7L9823/gOMyuIbljH7Nw1rykYCaiIXc9Qu3W9MY8bSZr
	nOUo0ydgpBaOLJq6EzuzamJtNFzEkOy7KwiAaW8gf90uGaKKgCeOiO6JypaoCKHRLIln5gyyZEh
	da+9Qlr4AkQLCVg/DUBUG90yi2tIX96kT8gZa8w4rHdx+jQlz49o8GUER8YkWCA3X0eq3XQG8sA
	4vmAawvM5amwkp/C+0T0s9L1fvDBQayYYkyugnYGCR34WDUQ8bZdAn4SalJDpKNoxgfdcPamMJ+
	gisM1QPV3gI0I7/ZeFXqqP7rnKm31NMRQVBpzZE+gMchdZ+cz9XG5+5ZT4zSiizrCWScDVTLRRM
	lWiTtTdtPL4T26JctzvYRe65R2SpN6lZL2UTRbDAdLbdeCTOPxTAmZnhgPaLTsQpiUFOynNZOXa
	0BqfyO89rgRN3nEfupG4=
X-Received: by 2002:a17:903:18b:b0:2e9:5c51:19dc with SMTP id d9443c01a7336-2ed837726demr37188955ad.41.1794221818766;
        Mon, 09 Nov 2026 02:56:58 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81745f12sm9243985ad.68.2026.11.09.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:56:58 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] bundle-uri: do not die on unresolvable relative URIs
Date: Mon,  9 Nov 2026 10:56:53 +0000
Message-ID: <20261109105653.397878-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <avGR422rPHr1Orv5@pks.im>
References: <avGR422rPHr1Orv5@pks.im>
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

> Huh, where does this quote come from? It's certainly not part of the
> mail you reply to. Also, you stripped all necessary context for somebody
> to know what this was even talking about.

Apologies. That line is from Stolee's review of patch 2. I replied on the wrong mail. I have answered on patch 2 thread with context: https://lore.kernel.org/git/20261109103916.397673-1-aniketgupta3001@gmail.com/

> But the other part of patch 2 should definitely be retained in my
> opinion, because printing an error with the URL after we have trimmed
> "../" components off of it is just plain not useful.

Understood. I will keep that part.

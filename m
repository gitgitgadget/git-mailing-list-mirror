Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515289;
	b=KGPghe68x6Ang4e0C21McATVQOw+MtRX5rmOyXXA3hkVAvneYEsTLRN4Zqyh4hM0LipN
	 nYGy/47fnJhB3aqj70svmKBX7UcehuJevzt6nQyHW9m4FwuYdWusQML3vzS6FaNLpDLwi
	 OgNJ+H2U8sZ1xjDxFF9ffksqNAJl2SmDxzV1HZt/ZCc/eVZ/+M1Douex1QFTFmzk0/luG
	 XQ2tei+ITGZh2xvZpGcYx/ZYlORRX9F9cyw1XzwwEsnbCh0UR2lneB7q+8ijcrE6AIgKG
	 QurMjhHIVzrMBdug9UGGgb0cfMf70tBmLevOlZOzhBvVHfsojnetYX3fIzghvhC+ASA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rolcaPEMyCPvLT63aMjZlyK+/O6R0Zp9RDnUBbZLOc0=;
	b=Cyx6L6SYUwaCxqPnnSB5PG6q1nmK+bLpA/PsHbxarJz7oGtaGogSxhExrsedRWsbN5Kh
	 R6h3ldgO+vNT9ie1+XBh5P2TbMWSEarUMQvnvM+yhh1xau7mRcfs+hqZ9IK7nn/b/rtUm
	 dY3wk827RfSoFVAaBQjXymiufWVeSCnUFdK447WZ7zE8f5DNJhr/5HPzk8HlLq8y9SIH+
	 Y5JOpv1OHQ0cEQ3x/LMODoHZxtijzysn7M3htsOduwPkLY8CEJg7WCB9mc+Se06yo5r+H
	 IRUHSqMelq65J9PBWEHXUrHvNkJlAISJjcJ2ZZFmUiY4rnu142v55Gmugn/4a+UPleg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJw3Lb6H;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A88606A331
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A88606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJw3Lb6H
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so14304a12.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515289; x=1793120089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rolcaPEMyCPvLT63aMjZlyK+/O6R0Zp9RDnUBbZLOc0=;
        b=WJw3Lb6H5gCLcAnWw4AEvsUtU4JDnN9lms6bxfPbdC+Gam5irPM+1sIZLeDDWAK0h6
         31CEPAJuW1mL+VRoFMyIfq4a6t7F8lZoaxDyfbMMmXwqsdMdj8E1aAqsGoEehvmjawLI
         LboHDifeVPPMVNdIbQrlMPrvhDjdq6hrMNtGicZzJDs5KuL90YTdBL/KouMd4kF3kR+o
         fDmmvG2mg+BblRRwjKfq4MjLZmNfidRNq3d+iU56NfC1NQ371r5hhXsdV0hW1RUujRx8
         VgrFPgdxxwq8rRzc7eakp3sAMx955iJhDmoiNpIDrXGeUhbtR/owNE5y2JjmQvT05QBw
         GaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515289; x=1793120089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rolcaPEMyCPvLT63aMjZlyK+/O6R0Zp9RDnUBbZLOc0=;
        b=zRUsTjwxwNZ7eRKn3L27i/i3Yo9Ah/pNr0WJO2KrrpRKeid8veAFtOg0eFa4bUP2k2
         Hk0JDXjeE7qCYZkI/QAOw0qVWeR4KWO+n00oWhb5lOcfybd9HTsKYlS2qBFaEK9hjNo4
         z89QTcVZ1pcO9oIVdYAblPAnQ9q+369xgdpS5y0mRtKZtehd/+LLEhsfoMQBOS5pIwD2
         s+MvRM7dJMGJsgQBTtgAVIMPRisQgAAZ3mAsUgqozUL+aR9JR7XRbxDHNkkFRZoWeNfj
         Bt8SwOyHF6Ul/kM4v9PZ4PoV90JqwKZOqGVwgiOQSvNY/g0MQI54T5fRJM2yeA3EhGQf
         deGg==
X-Forwarded-Encrypted: i=1; AKwUvBw9+YPXjda3p1jjLqOs43fRSVqgJEWWpino72liqokQV6oJRmfWqEBbQFklLzJAC9FaYqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmFbd8NsVWQdUvLSqmJYChIdaUGuXUwLLPeTjs2ftNIKDTipmY
	CIN3GOZO62NlXAeYPQBf/+w91IbU/ScWlundGQiwyaE9dzfJVsNmMbWvYc72qBI2nUs=
X-Gm-Gg: AYBFou1k0xbaCPnR4ds30OUtzEb9+dTVrJrHuoYRaemaOc3L7ARa7H89axnYYaeSKT4
	89IrdvOqLO3p4x6O+VeQsWxDo1T51hEz149CpfFG/ToUz7bwYaKxNxIPuxHp/Q5QeCj+hcakv+K
	zDSPwctI84cY26pLXPLo1ph7yE8PE6HGc6qvmezjhU11xoE2YTQq0bdP1ZsT4aX/i1Evq5sSPfm
	dUm158jZ2AO4qL+EykB+oUasjzgE/mXmu/7k/mFejX3Wl5Bw6Jtd7I22RYa5pekS5ZG/4AKzBFD
	h5zXFSI+NbhOc/YJoR+DnpPSFdgcFfAT3WfWE7c4GMYfLlXnkzkR6XJJIOUoJyK5TdsPRFR75kU
	1NpGkgfLygeEaPw7div7kF18/omv51h+wjzG4twP1jLP/e0bi5OzVxod4y7/UKWdZmqpS9acCfg
	tUG8iMSAWYpijXkZWs8ehAKwXgxu5LJJDOvNHS9zdSsAUNaqw8RuQQCpAixSDed1FGl76GErh3n
	umWiFUmGo3MbIxoc9HZtcgeFS0QoMjnKMfsWmjybg==
X-Received: by 2002:a17:90b:4d0a:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3acef293029mr9982102a91.24.1792515288691;
        Tue, 20 Oct 2026 09:54:48 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.84.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80219f83sm373018a91.6.2026.10.20.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:54:48 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: m@suozzo.co,
	git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: [PATCH] reftable/record: bound an object record's offset count by its length
Date: Tue, 20 Oct 2026 16:54:42 +0000
Message-ID: <20261020165442.59954-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
In-Reply-To: <atcKOhm0Kd5XryAg@pks.im>
References: <atcKOhm0Kd5XryAg@pks.im>
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

Hi Matthew,

> By fixing that one function we also implicitly fix all the other
> callers that may currently be wrong.

I tried Patrick's change on a 32 bit build and it works for
REFTABLE_ALLOC_ARRAY. However REFTABLE_CALLOC_ARRAY goes straight to
reftable_calloc() with a size_t and gets truncated. I think no one
passes a 64 bit count to it so nothing breaks but maybe worth a
mention in the commit message?

Also the new test passes because of the count > in.len check. If
that check goes away in v2 I think it might need a different test
since on 64 bit nothing truncates. Maybe we can test
reftable_alloc_size() directly?

Aniket

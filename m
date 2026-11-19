Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108800;
	b=ETHMn0oBq5rnNMZ2XfNk4WdZKOLCVYEoY6fdgrmofIRG7Rvz+43bnUKy63qYbgUwUOIm
	 rG+3zUN4iQDlAr5OCQ3/lWkoIt8mJcDK9yhP+oKSNgJs0Us+BYp2FrgBcvgZochzyTcgL
	 3YV6LoDe7Hz9J09bTaZ4YRj7paOHNAqgqOWL6FE1lROsNNc2AhJGJ+99z5H9S3sr/L95p
	 6bHfAdhUlG3+gOB3qqnfqle1sjKBJjuQ/Xl+akD4e6n0f42sEX9sBf2yeCv59JXbrZ31T
	 PQMG3+ZvrQcHi6E+JRykFgbLXkq9r+6FkNNjyuD0+hF7Q3xmnhjJnwcP8xagRbf3Nqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ydkEHy0FWY00gdN6aG+EUpm6Pu6s3yuVoBFoa2yGFRc=;
	b=ocIXqeU3/RI3kxvS8iz2EUeVMERz0rqCbJ3i6c+nyNdH2z1JkKAQBLbH3jdp8yiv7rVv
	 OEuiquRpVLjYcEcGa8kDY1vdPn1BzIOdaLBWVIGSBcgjVm6+tk4xBQpooxmEtAbf61WZ/
	 52Vp+FD2sePBf4JcdPCn6oix6NZ6wEZGPXVO88OBG7Z+stjivC3T7FKlSNS768vD1/D22
	 f2Ujqk/02AoAoR4Kck/bpkOtRaQdsbUIgA0uf0Ue/tfpVH4JSV1sZdbs7i+9G65Vlq5dH
	 Vtr+3uJYWeEHX0QuKg6rMydT2AuZOjIQM6TKBCttjs027T1+OwnkdkOxcLyS9lgkHsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DD7Rt977;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF8606A32C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0FF8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DD7Rt977
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2efdbab4e03so11788655ad.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108799; x=1795713599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydkEHy0FWY00gdN6aG+EUpm6Pu6s3yuVoBFoa2yGFRc=;
        b=DD7Rt977IQO2FG+O5YfwmKmHvsyWA8bhLiIW94/fnXKANfu1JEADoBRLCnbER5Jony
         gJsjrNeex3DTC8TEGpP7fD37gEisYq6uwdEVXdO8axl+VkQ6vdx9qZAh0+/TiTnOiI/a
         I1cZD3nURVx/F6FO7FwkBjQynPtiUc+bq/4/PsCL7U2rObF7QdflQoQ34Kv3VbPnGQ9q
         v7oTXYB+uUvYFzKQoYDFkj+OkeAPx/ViTzxfK+O82Hl2hhCV+Efavt5Y55bxmHdeiRcJ
         pkiB0dJ/vpDIc7LTsZscH7WldXJA+FQ40fKKP35QCFAmUvn7L89EOTKCRcWnoklgGPqB
         MbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108799; x=1795713599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ydkEHy0FWY00gdN6aG+EUpm6Pu6s3yuVoBFoa2yGFRc=;
        b=UNP9sRO5J0DL7rAB6T1S2GCTE9H8aTznO2CGzTexrhlleBi9+bUPSbVEtUnryiVz/L
         0rBlnJ9pFCbq8Zy01aS3G4iWG9AK8I/rNPXf+ZF9dE0zym6Q3thNJ2LsWF4uUAP+Sv3l
         J2/Mc2HGjzty9VHeUwaiseGFVF1pncUl/pM+xmNGr5H9Sw3Mt5yqDITra1Q2jPSD4lvC
         LDL6DWoHV4O0UxsoCuIHK0iOAl5Zw0JRkuSzfMNatV/8fju6zHqrlk5WzjjEN35rJFHQ
         F8d1hU4EmEYd9WCmnujUuWqLBRTUNCiFvvwJG1UNEDuU++WUc/GgRlGI75sCrv0ZCSus
         D5yA==
X-Gm-Message-State: APuU4Z/Kam6605xQErvImtAQ4ztKN5jeQiCWgoD+vHz0/d6hu9m560CQ
	oAzZoZ2kRtxMFVQrIhvjTFaaCoStiiqBKxwyNI0QenuFl/yIJqHQ9GVnUCrw40Tz
X-Gm-Gg: AZFdTZdHgvJJhcSDEdH6PMSBMfuPnJdhCotjU8uex7pFIU5n79Pz4/dLMXkWKK3mhcp
	C7D3gRXTZkJFTBW1sg37hdF5yAjoNdkcGxTScU+rlbfAVNgpow34nNmqGj49kW2G1wXOA754gQd
	qBW15/MUL3wdP4Zn7jnOI9ExF4z0lJVZVpCNA4d1i3SLio6dPxwu02mclJ/J9HTPT98KxDTdl+M
	ekgQub/bshvSaIa4fwxekxYNYp2oKKNlP8o3oOtF39hVgxSYwnujBztqk1Qalq10/7cmVIOWdYl
	rygYNbyOS9Vtqjsz164/9Qpnkp1lP8UZMsXbZB8stBEfyQ173eEpygfxjdsRz3wl5o6g3KHbct9
	HuUUY87QsadjTq+ziVAABhrbUQ4LXCqHxIQ2OFDFCF4F/Z7Qm3iMP49k2L7cb9RYtvLEPwUyY71
	S085t6tRLpsmAc9J0IglHlAhycRNRrgQ5mw+BqC2mOOS/XI/sIxgznAk2l2UXYhvmoyBiF2aQIV
	QsWT+h5IsWyMXRsGVxtV+BIHg3tcrX2Jx5j3GMJ3T9MBDzWMK2yoEnXAlNSLHlUkwPkqa9qZSlf
	rXbtsx2ay3dE/UhZuGq0TTngeCMlPqfNnxbvGchdsj4+TDqEMHfgpCUSa64GX0sbGTaIakN48tY
	1JDR9ewZxj9jJkfXp0E+ztA==
X-Received: by 2002:a17:902:f645:b0:2ef:dc42:10a9 with SMTP id d9443c01a7336-2f03ef3d32dmr4672515ad.7.1795108799108;
        Thu, 19 Nov 2026 09:19:59 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm2752035ad.70.2026.11.19.09.19.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 09:19:58 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Coy Geek <coygeek@gmail.com>
Subject: Re: [PATCH] merge: honor --no-overwrite-ignore for real merges
Date: Thu, 19 Nov 2026 22:49:54 +0530
Message-ID: <20261119171954.85707-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107044419.209119-1-aniketgupta3001@gmail.com>
References: <CACgTecNrMKHGexWTkm1bqpVzL7SVWD5Hwo17wVokVGe3_Rnx0A@mail.gmail.com> <20261107044419.209119-1-aniketgupta3001@gmail.com>
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

Friendly ping. Elijah could you pls take a look when possible?

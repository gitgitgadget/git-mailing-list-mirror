Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071436;
	b=TQ8GoV8h2R+shH5l+08i4QjQa/IhKf24Oh6ZQ8WmXc5knBDxzmjNCPC6que09TL7H8Mb
	 9F0wMWxeR6RlXGS4XuCZ3QI3HAaoMpT0N2GlCmG09JeareJ+rAdvafyjp5rmzHIpUr2l6
	 S9YnO/3znM4CZzHh0m3QsCFz6Qo3OJFmOIq5r7z5aEfSaT1Ud6B5ryi6xM2lRAJfYnspc
	 sIBGOoTCj7NCNvETiTOR7cB2H0DxQ9EzKLKIhn1S3nNo72k8Iosmls9WBB4VoWoXXKAXN
	 JZeW7Q5uNIYW027ZCyoOKhHxK9oQ3fVm9h1NtioI5erosIe79M64Ua97CHR+MGENGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ajLSumPrH2Wgm5GXb9uyCpHFBo5R1rCPDQdpdYNmZAE=;
	b=UGdDuXQduOMJ0SzlaxQyI7JKIdjtgI1oak4At2pIr77eyABr+Xf/5u6ybnA9qTdJto84
	 yk91/pk8gKxCpp+lm+son2Si7QBqNhB3p2mJbbFtWVbviIVYY8f8NsawMA+rmxy2MgbwM
	 la6bKaRwsIL/Xk/8a00ezcWjqUxW7WMpmBfrbMWi6RGFiKKIhVfMO3AOwIouJecdcs4a4
	 moJURIZZwg9JhgOWWnoJ8KG7u6AZzMe8Q1gEzQOt2v7kuJdjftZVeGkgsiP2BgvSwt/2C
	 dilsk8or0CNH1t7odCD7qzMuSMz30dqrBJwNCV8471lejYw+fqvLzKzGbnPcO0qxH2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTYuZpeC;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93731606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93731606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTYuZpeC
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so13607705e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795071435; x=1795676235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajLSumPrH2Wgm5GXb9uyCpHFBo5R1rCPDQdpdYNmZAE=;
        b=xTYuZpeCfLdKAC9CF5THQKkN+sTNi/pusGC0DjQRdYzwoc1LytAINu9Qk1MOczLb49
         RjeM2mHD34VsLPlc0tu8QwStvlxPFZEHnLwbQ+k5dF1KPZm0p1XWfJ9trwfUVC15CaTT
         REK0ci6JL4LmbQoGYcYO81gqAezYzHHCQiNtZOx+Mb813pCLvZ+Vm5x/p0oqs24dpO+Q
         1nXF4yMazmre1thSIgdSjGQXN+JOI6OweRwkFRqJoYVwHQrgcYe0Htxjbq690CzHQ2qX
         lw0F/YQhXAry9n99OwNb5rj4G54wL18bDQlnk22HIBPrQs0cwZbl2MO+9XAdFRacuET9
         1Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071435; x=1795676235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajLSumPrH2Wgm5GXb9uyCpHFBo5R1rCPDQdpdYNmZAE=;
        b=F3HL4UJjWjWF71YVQQyvuMVakL7m5ZSYlcNaAKphNk+waX/SIytMqwGeYifYCirfyP
         UVbSUE7xa8L7Swq5LnBQq7FjgNW11on9YCEEIHkklNfHx7GaTGonpjg7aSCe0GPoC1nT
         S+shUZTRQE8QUfG5rUyWLpJ2JsqTNOidviC/U6eKTUYmKajygJJ1UlhpFv4QdKZgqi9s
         feKd43/gpIgFxBD8y2En4s/xAPwLl0nicrGHAQTQQS7qfMsGz2eV4kqOitkRyEPcDJe3
         b01strR9XKIV9MTNxiR0+rCRSm7RiOhdUT/fAaziA/FXtF7+Q2mYV9Y2fOHYtbmaCZ+q
         048g==
X-Gm-Message-State: APuU4Z8D54aG8ZC8SpHAH+eXIBwIg98VdOjficwWr223ThM6s4M04IvU
	PUxJ21shOK/xo8SNl0QlmdKgf6p5lqB02xjeeZ1mmpbCn5KFj7/UbYXBdHL9sg==
X-Gm-Gg: AYBFou0BBeRE0BZMGu96RMZ4pL/SiT1E++juM5OA/d3BBCJouuCGb1LZHgyrkI/CRNL
	UN2H57DFEY07aoAdC30a0qFPvI/UGcrb0Tk7vs4hIt40ZknZxc39YnSFmL+OzyAVrtnGUqPIheX
	VOyJkNzTXpyIrTRm7ta+ThLlRs1QT6CKycGEVkBbGnHPROSUMaUNqTlUt4sbPj/2m5TadIGJJHx
	uyYru8gQ3fj8rPzEB3Ss6jR+v3empEPxmkO0e7iRlRwma3FlZEdFQSxMzOzv0KMa8Iq+H9QHBjq
	4/3Tjgt7FIYt/DeTnQjKLs/nkT43y58fj71oBYEAyJYOycgUtZfrepEzmFpXPrnrDghyn2hArAx
	VaPwZ324f2d8rFGmRfMA+6Z9u6W/37zi4R6UyJU18y0PuVT7XqgjNr/E7siIo0EGVK4HYUyPmfT
	1PNs9lSg9lOkb4kf+xcM5QCZ+vSdTSEfyOxV5aJ5bchR32RRvdr1pjbvDYQ/MFhLzkKLorNzcE9
	a7CWU/LSVa9JcCp9KqX2A9VWCTRPYUzkcdx+ZNFfHEabaBO+Xjn/tErjDK17UW7t6vRvFSpHu5D
	DIj9D9+obE2or3YqzREV436T56HRAiedX43lVpxJeGCf9EKWYDJSseUNa84XY8g=
X-Received: by 2002:a05:600c:4fc5:b0:4bb:71c1:3ca6 with SMTP id 5b1f17b1804b1-4bb7da27e95mr96947015e9.21.1795071434790;
        Wed, 18 Nov 2026 22:57:14 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15933565e9.14.2026.11.18.22.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:57:14 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Matthew E. Luallen" <m@sph3r3.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] archive, apply: do not truncate files of 4GiB or more
Date: Thu, 19 Nov 2026 07:57:11 +0100
Message-ID: <20261119065711.827536-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793524457.git.gitter.spiros@gmail.com>
References: <cover.1793524457.git.gitter.spiros@gmail.com>
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

Hi,

A gentle ping on this two-patch series, which has had no comments so
far. It still applies cleanly to current master (e1ec09b23c) and
merges cleanly with 'seen'.

1/2 (archive) stands on its own. 2/2 (apply) has a question I should
have raised in the cover letter. It fixes the file written to the
working tree, but with --index, and so with "git am", the result still
goes through odb_write_object(), whose length is an "unsigned long"
until "use size_t for a few more object and buffer sizes" [1] lands.
Where "long" has 32 bits while size_t has 64, the blob written to the
index is then still truncated, while the working tree file is now
complete.

I see two ways to handle that:

 - pass the size through cast_size_t_to_ulong() in add_index_file(),
   so that "git apply --index" dies instead, as 5/5 of the loose object
   series [2] does for notes, and drop the cast once [1] is in;

 - hold back 2/2 until [1] lands, as Patrick suggested for a similar
   case in the pack-receive series [3].

Which one would you prefer?

[1] https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/
[2] https://lore.kernel.org/git/cover.1795069177.git.gitter.spiros@gmail.com/
[3] https://lore.kernel.org/git/av2pBh7vLj5DVDha@pks.im/

Thanks,
Elia

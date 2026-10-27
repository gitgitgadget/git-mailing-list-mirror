Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793138273;
	b=qTMitTKr2D+3TPMlRYS+ZAGIgaqNuLA2uVaRw10Dfh6k99n7WBRyUqbslvnQov64uqBf
	 aDEHQ7tALMkwFvjgG7fkLj9VW8K65BStBkfbgfsGopS9oGstSFiGopAUxguZj1pcDvdXz
	 9I1ADlsUaIrjxSqm3+i4IjKLzqJk8WKe3Qhs6u9CQg3304yKrOnSlnfxiSt048Th5VsSq
	 ladqd85Ke2LefjVjTsZyC9WcmwOaNsMiYl7TZz026P001dPGYP8j/pIAVUY6eI6mHqh7y
	 mgz4r6mPrJZ+h4HUJXXIjnChlqDXVXR7wGexxuDgPykCnTkU69ahvRUsGao7K//NkYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dXVZay2I5lHUSJF5z94WfGHNZ7k+ZH3gNi+V1Ata0RE=;
	b=JvhbW6uQoLfyFHllJqwdyfdM08syQqY0HHpwFYZbnM6vHxy8B3kKkdIAKtHiE7ys/H8/
	 7tCdtypK6xDfRu08w4OTTY5JAsMmt6/ya2N0g8VgzrQcvtELKhK+C5K3z0Z4yqXXxaW9S
	 dvM5B+wgavaXRg9I0TWTNmoORzi2sp7gA2g89k2ioL6hXxIVnOLba1u8znlmpscrrB6JZ
	 96RtrWHHz/jfUCdCD5J9+mbzsm2XMZ8Ejt63Lfeka2V1SnDyRIEeh4lFrp/HinicsaUVO
	 DS7xduPZZfeS0gshhQRra/EjBl/9Y1+gXB7JbV4IJ5VjRxiLg/iyHvv9xvroJMR/soQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z9gt5PGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95B606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D95B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z9gt5PGj
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso1492265ad.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793138273; cv=none;
        d=google.com; s=arc-20260327;
        b=hDMXdCORFFmVKgQXIsjyGHz445Xyp2O1M6lztYccVWEZfeHVyia9jCZBb/2V28IqSt
         ExFUzsq5xEVwZ1mS+jmM0W6Z3/u4IVHR+1DENVLv9Mb1/1dde+lF9Ed86CiUNjyvxvaa
         7MlryvxnrCIENv/8lUynMg3eFMZ+0hI8bscFw8mmPc74/nkgQFfDkB2W1tRvkMNsVvQD
         XPGcUZtO4pjSaAxfpwYcul/YKewZZng3CsFlU6C8rtSgOHOsp8wRLpzx4ZkcbWJ9LyCo
         dm8RXw6eMbDOCN4Vlr/uxbFftg3rMQaFuWcWNPRuNEvBYN7VvDyB81zFaxisM3Y9duhJ
         MgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXVZay2I5lHUSJF5z94WfGHNZ7k+ZH3gNi+V1Ata0RE=;
        fh=sskDQk0ftbRM44sviy/NzFRfu/yh1ZTcalkMFbM5Vc8=;
        b=VpjNkod7hafJ2e+2/dJe9KOns0xon9YMB2vy12y6v4gp9UXhDP2QQfVbkbIZ3KvmfR
         k8stsaps95XZOw28ekcl3PqEHroIyhyVMWmPcnz2JgXopFJBFFwtcu9X1LKKsnRnPUbJ
         pvwl/e3IaiqVGV8VZt+paCHZ1tNYNqCJNRF1Sf/Unxfo4nLdE74ni/i9nv7ZfqSahvhp
         6TAUK+6WQ8FkGZjPk3HenyG9RwFVlX7tKAwyb7EKrhXH4MPNxdMUnI3LCkzKTaVhKd3S
         UmKFPIVeN399cao/ChvLlFaypaoBePhGJsonevFLo7IxlRt2TD7Y7pSQiX6t8fJLrF8m
         y9sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138273; x=1793743073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXVZay2I5lHUSJF5z94WfGHNZ7k+ZH3gNi+V1Ata0RE=;
        b=z9gt5PGjcn+UHI2uXcim2hbLnh9TnTzicqdtbPGssW/FwqH7Z8lPJIpUlRTDPfRlaz
         d+UErL+K6dIW1ea4NE2wMPkr83ODSWFH7ME8qLzMlbLxEhRoN9xNa5DYiC7QjNiWgL7C
         SdHvz4TwVmn5BLC72qiygSvL27nMYuhsijDW2OeBJBeYlOyHYWjubrFIGb1Q2vsGbRwC
         hgJvZZrzN7SG1f+kDgBJrmp0WUuMpQhwbqP4CLd0cVsRB6gdN5BjCsajzUegTX9HkNNs
         laDJqfZ1CgZL+Z7UdQ4UIDmhihs9+caCuC7xjmJ/44QS0NonkqCWZr8Vx+AZl87UyrZb
         S6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138273; x=1793743073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXVZay2I5lHUSJF5z94WfGHNZ7k+ZH3gNi+V1Ata0RE=;
        b=lTylbbxaJtQ0rI6B/L2723Swse66/pLRCYZPPHuGUQN0j8JNAgVb/Ao/qM6q0BGJQ/
         C/BRTxqieyhQTE/MIk1jGjlA1j9SfHuS3VWeo9pjfobuVAo5rnhLzwbT4bjKbCTQuy/l
         o8eF1XXKZVRRVWp3iapVt1gM2Qpa/OKdrIUoTxyAUjGwLshHzjj5wlkfjhZgbD6KhlUS
         i6DCLz3v6FLEsfW4viY0yuI5WdvbfOPC6+cniX9SlUImImwwi6Q9kxa7wYbG7aoIPH08
         v+YpxsRZPPsCDVtKJA4hbuXAEVCoyUQzFt7FptcC6Adm8SIq5llxDCKeeS2g+mzMOF0D
         zpkg==
X-Forwarded-Encrypted: i=1; AKwUvBziwVU8dRGZm+pmvnoEw1TTELhK1j2ql2J98yPSttoby5W06SCe8nxlbnr5SFzZqoXkhrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7WnBS08UzKZwCzzDqMsCzJGiLLUSz3fGte26QHlFjLJtLHgkd
	3Gu3FMBevxD4lN80SqUW7yviD7ys9pfCIMYur9XRxdYgJR2t9QC10BbaWNDV210NjX+l19nVLMU
	fIQUQfqyHPciOLiAEto41irtPDKxUzOYcTw==
X-Gm-Gg: AYBFou16bYXUg1ZaxuE2QRc2g/piILpSeU+cKxM4IZXn5kERn2Az24wrMxrylO+VsPz
	Mh+IP3KfA+QlFfusFp99SVVPe1gl7ckxTV9ilwaEj8uIhUK7OrXAxpRJVbPrkVRzgQ0Qzyg37j+
	/x+KS4eBib9Zvn4iJMfyd56pi32NoGwO+qmioRahaD0j+KB13ykIg/h4hozTPX1tvSInzI0kZds
	ZcRdg8iDN/vrf7bEMWBXoXIR/Syf8IMoMNiacKknMGDzvNcSktfpFGTe/sftbHKNWo+N3kRbzMH
	k7kftIt3At4098jjmB5GWjta4q+FyK4ob8dVHVjpql+9i4Ffubp7NKlKWFoIpYLGxnDWWdda/sq
	1zMwZBgVT0JMeN+nDTigI3qUwgyu251v9wAk1g7ZjoeMQ848gbfno1vywn+F7pgKhHLC4wH2jey
	dl+JbNmk7vi+dAgtynLnTBbwOpiNUpZjhd4ugVI0RBo591S0aSlxnqERQFOC0kAQC9QfiFR5k8A
	YYQCxl+HvP0WY2G
X-Received: by 2002:a17:903:8c6:b0:2e9:64b9:a330 with SMTP id
 d9443c01a7336-2eb002e1eaamr5870605ad.11.1793138272890; Tue, 27 Oct 2026
 14:57:52 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
 <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com> <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
In-Reply-To: <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 17:57:38 -0400
X-Gm-Features: AclHuK94TdvgA4zxA62YbE1Bqsd50JKJvuWVJ5aup4v99bci1hVMXMnk56BQYJM
Message-ID: <CALnO6CDpsQtAX0rHr9Cuot08K4j_6WMpiPOKA38sjDbWB-wj7A@mail.gmail.com>
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the
 precompiled header
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:00=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > And, what about Meson?
>
> I think it's not touched by this? My goal is just to speed up my local bu=
ilds.

Yeah, it'd generally be nice to keep the 2 on par though ;)

I don't know enough about our pch infra, though, so I'll bow out from
here. Just thought maybe we should make Meson do the same?

--=20
D. Ben Knoble

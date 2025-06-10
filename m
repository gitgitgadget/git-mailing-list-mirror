Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04952951D3
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564021; cv=none; b=g7eHsZR3RXLZMG02x3gkvHdi47vBn2vCUZF/hc8HmTZTupf5Bj3NP1RdUzXh66/51+/vfTXTzOKmifckUuYAaHzw4u8dOkquVra8EJxF96x7KcGHKOOw8cNIpbK5+/NDN8f1Rwn15mcmIN7Vmz1kLVj+RbmCoJJRGOH1TGRoVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564021; c=relaxed/simple;
	bh=Blk4J8FlSZWI2vNNBFJBx/XlqWOnB7xs6vn+1xSfdVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIBlwoUR18yB5a/PHmOCwG+zdsmWKezJi6e8CfyWip9ShQXyHC39WrP5BYkyn/ZVpQTsZes91IVxGFpRIZ7Xo6+DPbqj3zMwaixo0AS4TMivrStnh2JQrYAA0OhdD0Jh9x2P2m9jx7Iq/OyIrcdGEYK7NaM+spfPSmHvEmo4ie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYkqK1Rw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYkqK1Rw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1016914966b.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749564018; x=1750168818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blk4J8FlSZWI2vNNBFJBx/XlqWOnB7xs6vn+1xSfdVU=;
        b=gYkqK1Rw9kx1k+mx/5eOT59gjPRBE7gX2AGsnefvy/b89PVK+hHHrgMx8XpJ0USLMs
         Co88rkqdmRt2f44k9Zl6zf0bVNHe92M1/vKcWlfDtxQfK9o3/Wy0Q87qFx/tpUJZpVBt
         3g8zZNh4FMv4NireLWALOkf89BDsH38xkI8L34czQv55XGh+yUMLJ2zi6RBlUxoi2fY4
         sMFduJgxgZeRqOhxQfZg2gEywthcqVTT8GAN8ocPCVvZLfbk3VsZrDkDSfRFTJfBL4lz
         csHB76fEv1NgK53XlVIa+VO0ldWsDpcV6f+BhRynyUPe+vMkjqslhPT+45Si7RzagSRD
         IrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564018; x=1750168818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blk4J8FlSZWI2vNNBFJBx/XlqWOnB7xs6vn+1xSfdVU=;
        b=XFFvKj7t4gxlYkyxuQTF9c4O1BcV5XEYUCXEkMWEStgOry6RdCueWC6wMytXoVAn8I
         yV9L0axU3blSJLVI725I9ZQpDHcLcwQbFZP5uyqXDwq/WR6HEk7CqsJwQLGnCagHW3Hm
         0rYszraZTLF+FMDFr8S4BRKYNevsuwDgmo5yTLgjWPQoJwOKgyJsKoZiydh8jKLxBk28
         g3fONnZ2tuVj7CgDOn2q5qbnleQZVgOtPh9xFsABpZu3BMCH7FYeiCWkC2qMG63WWtBW
         ePf3lBc0BjrQ83ZOCVbcfKrpAdLmts53rK/LxAcjTbCpHPN86lP+BS3C7VCfObjoY9si
         dzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXswdHjyWjwTwZE+SIknfmOLwGkrNNfOtlkm2vbkZjr/1mR5BJbh3KupmPgAWgO/4V0JLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEqxcKCRj0fS5PVVy9N0ZhdaCbYHosnMtWdfHpkzP4NO+IQ6Q
	XnqmSWktsMAyXBbhebnBilZRs4gYiM08I8KmpnP5XX7DD4UBVmpo76l9rxIh8Ioj3Z6IusgWv2H
	MciIhcvrxMwiaf9FyzaHeHqBl6XhqQKE=
X-Gm-Gg: ASbGnct4PTq7H7x3D2Tk2BTEv/QdLJp6vrI3taqBNB7kYojoc0yGkdEEh6ugK9ZvcwI
	S9j0Z5ai8rbXuYtYMzuBRoW7TfJltz+DfCOtLuaOaNZFw0XO7kxLrZl3xTneSM0ZABXvdFX0GZ7
	RZPv1jZJMZrzlzGD3DAq1O4KcScWPzYoG0+7HUDD1FARpUfUChpVGV0O+oWeUgF6ttAhRCiW0gN
	LZMQA==
X-Google-Smtp-Source: AGHT+IGWsWSN+qIidwghhaRhAZEk5kn16lOwsnSijg8hoWNaDNsG1iLmq79gngNA4uMoqwarrOQrWfU8H6X9lWvh8Pc=
X-Received: by 2002:a17:907:72ce:b0:ad8:9c97:c2f7 with SMTP id
 a640c23a62f3a-ade1aa0fd86mr1515344866b.2.1749564017837; Tue, 10 Jun 2025
 07:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEcq7sbPx57r-qKK@pks.im> <9E2E7CDE-907F-40A5-8C4D-BBE57F7BA08E@gmail.com>
In-Reply-To: <9E2E7CDE-907F-40A5-8C4D-BBE57F7BA08E@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 10 Jun 2025 10:00:05 -0400
X-Gm-Features: AX0GCFtYxRFGo2qdXKXbNjzCcUysbUnhd43F-9FFx-tYbI1R5nXAO0ruatxneRc
Message-ID: <CALnO6CBWUEu=2-qzc5pSydgJ7ofNi-PRdJZu-dS584KGRZUH+g@mail.gmail.com>
Subject: Re: [RFC PATCH] test-lib: add missing prerequisites for Darwin
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:30=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
[snip]
> If I have some time today I will run the test suite with this patch from =
Junio=E2=80=99s tree on my (old enough to be unsupported hardware) Macbook =
and report back.
> D. Ben Knoble

TIL: my mobile mail client doesn't send the signature in plaintext
(which I'd mostly removed recently), so this recent mail probably
bounced. Sorry! Will fix going forward.

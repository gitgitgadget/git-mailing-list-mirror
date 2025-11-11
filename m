Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7810942
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819977; cv=none; b=lfcSYQAmy69vWgt2w4vP7C3bj5izLdeP7Ow95zc5gey2utFiPahy6P7yNFx92fCMzsNXh4OKbtft/Rln6QNCVhKPH73wSW+NwH/NB3i1lN60QXZfN0qp9Q2HMk5O5bnS9DbpYtwW2Tq8lHx1YYbdVwEetyDA/mj/zYUh92Yemkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819977; c=relaxed/simple;
	bh=c8W+z3gd0gsPd4a6+35xVId/I93EfIz2TgEcXsRjSFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMnLZSCCdGdq3P+xaPsjQJs9TUVOI7wgABjaxtCYQxMg90/73A8G2eh4dW/4Mboco0BP99vXMpJGsvgw8JlwI9+fMnwKxayv3qixGiwe49biyjcjOkHlgXVkUzVkQLPGLEQERjspLxIY04RhLT/QuBvyiGVgdBo2zjxmGDVl73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUHC+OZo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUHC+OZo"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a2d9cf22aso2446961fa.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762819974; x=1763424774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX4QKaLHaoDENkx7pDHc9wOV5AwKCeypiC5Oi02ey7Q=;
        b=lUHC+OZojokVSRKn657DAlbBy8cJn0v1CXPBiQ3RMfYKbWr7Wwzz/xaKe6zWZ4s8gD
         5FiHd6knywUNdEgqH8iWvl9DE54i3RPy3k3f4ItUFpDb4D2BRHqsQ4GDnQywV7rOQW7d
         EtFsVdigZ0aWIXSEMiMeMx7mj0EQA0g416/iyS1Wp1cQutAKJULiSgrkCwVY4ggIwQr5
         NOHMzUfyEPcUaMsY7B6cSfR74MmQ7VeK1hLwSt8di/GcbZPW2iJF61zx7LCavNOklf7i
         KRk+Hi6P9/vCb71oNzw3YSLoUGN1H6Vzdep1HxiarAifteBXM//B1xfFEowI1q56Pz/l
         0o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819974; x=1763424774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tX4QKaLHaoDENkx7pDHc9wOV5AwKCeypiC5Oi02ey7Q=;
        b=dyve+mQbHr33OgXQR9n0uWvk8aZa7CKvokU6eEZ8DYIFKPFgns+8lYfTRmp8uv/7lb
         E91lPBApuR/LX9r38vax6NHFC/ROp7sokJ+ZxMfDCdalDJ7sLkgSaB/dSUCbPnoG9gqe
         vZgXysOBGjp6KMVejYNT9La9T601nwSolxIec8la+IlxpFO5c31maw8gglHh/J2a8TIe
         po6ZctDezpEcYMeovDHq0VtXFcVtbQ/2PvJ3r3WEU+aHJFfrWMYPrn7bBcrPicOXYiGe
         o/6avzGWd1MeMzFJv2HuMjGLst0Corwhm0KuNZkzEAlG5VdbcM/rGIuBw4VQZxcwBGBc
         a34g==
X-Gm-Message-State: AOJu0YxKoPCpPnchjwwmnD8iQ9mIIcevFPoqqHrSOk06/Bc/QF9GDy6o
	txOBZpX9f3jTMHUDV/Zi7Bf1yRuS3AvOObveZOS8AK2hfqouCIxE4v675d32qsHeocI4Vn/D+vz
	Jaqy5jzQsgufLjxixu0jxhjT3peU7UKw=
X-Gm-Gg: ASbGncsZxvAvK/og/YF2y/v5hPNvTy/ix5SYhfIfL7ppoCSq/9ZJybZUSobQfZOZUrh
	DbY+6x3y2rJRgEWAUYmqBv1W9/vh3J1pm3TnDiYgKfvi+HcXhohQxyyg7ncjkUdtxCAeRA3NMt4
	7WMo9h6GbGlKCuoA5tFvKUCMoDZpCoT/WkMYcySFI03/eZtaIhqzldXzx3s3AMt37tMP7P1mQfw
	A3tlUI9EVq88rfTbQitmNLgwDGoP/777pkVfd6EegNiC+Uh048jgx1OvVhowQ==
X-Google-Smtp-Source: AGHT+IGY+UmUMgLC5pntQamS7MGdUW5G9nO0wbXECuUdh19GM5UWiw+7l414FQFIU12ZzNG7QuxoJkcibbUkI+DyLkY=
X-Received: by 2002:a2e:6a18:0:b0:378:e3a7:5dfa with SMTP id
 38308e7fff4ca-37a95389c5cmr2415901fa.20.1762819973413; Mon, 10 Nov 2025
 16:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 10 Nov 2025 17:12:41 -0700
X-Gm-Features: AWmQ_bm6djEeGCc53cg5LEUHEWZhAr4BBeQ1BTs6gjsEbi0eg1yt_q4dWSdHQCs
Message-ID: <CAH=ZcbB6k8p0wwD1MiN_D-bqKhkqumM9sOvAxLj+pUu43M8NNw@mail.gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:44=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This is the second part of the SHA-1/SHA-256 interoperability work.  It
> introduces our first major use of Rust code to implement a loose object
> format as well as preparatory work to make that happen, including
> changing types to more Rust-friendly ones.  Since Rust will be required
> ...

I'm working on a patch series that converts the Cargo crate into a
Cargo workspace. This means that /src will be moved to /gitcore/src. I
plan on releasing that patch series after v2.52.0 is released. Using a
Cargo workspace over a single crate is discussed partially in [1].
Patrick has decided to let me introduce cbindgen and the Cargo
workspace conversion [2].

[1] Patrick's patch series on cbindgen
https://lore.kernel.org/git/20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127=
@pks.im/
[2] Patrick discarding his patch series
https://lore.kernel.org/git/aQ3XOTX0AT_eFc5P@pks.im/

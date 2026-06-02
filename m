Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E533D410B
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394938; cv=pass; b=QgXLnvYzl9n5Xd2hP1Twkb9oG049tLUuAoCQOVU8bmC5A5XrrW6p4XAlSKwARzgGzkTwMINXLsZ0hOuOV2W+2m/lOKoOe7QRg9ZxtdQSYcohot67EEhD3A6ZikrS1GobF1aGctFphTrgKddcDf47dDL1jsczRQnW1t8WD0SEuck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394938; c=relaxed/simple;
	bh=jZ347DOspHlrSzQwc+sUspvodJ+DS/yaaB7+XklVIBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBCIC1ju0nlMaE7sjCt9QTc0HU9/ACpGz7w5sHfrcgQ9mMchgDUjACVWYBGanO07W0XLe2v5MlFYbOD7bMsrKIZ6UHMwJqtSlJfLPsM9c32xIUUbKt28lskOrH9rS2CpKX7IWx2nwwjEekOxbqOBnYgVNdovuDqg2Frl+ole+8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHcftuvA; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHcftuvA"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137f27712fdso40065c88.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 03:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780394936; cv=none;
        d=google.com; s=arc-20240605;
        b=eqRZm3wWSvc57+6JWhYm4gblQ3QO7RmlMNRcEd+C8C5LznjLSmNG7/DJCWvJP6phgN
         QwMpwY259ZujxlTm4rFmXg6OwYakBb4ibw/uwgAX7Nw1RfDbUHFhZ6hpOAU1yzUk+Hsv
         Z38PIXSArRScVTyUoHomMysy6RHbepxHpLTl92B/KB2tQmHVKmJeZQGQAjxJAldzg5VR
         89tD1XlNOMqlCPUOmyiTv0fu0BVr/9VIWwSSh0a2Adyfr5LCgNd7nfvXZNDk8PJ386qx
         qp7vha6FGaINZ5I0OQZJh+qqZF58/40acA3ONGctNnS7210moFBlR0dyJCQjCaMFZwjf
         bWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZ347DOspHlrSzQwc+sUspvodJ+DS/yaaB7+XklVIBA=;
        fh=WEVyCi/rJ3lsXR2sgWRZ3jRmR3XJT8ZWJ5WIGpeYs84=;
        b=b/qTLHFyx3Rnf9s3ZVFi0rVWmZLBdQb0nv7VeEy4QPI/+QRv0RH2S4tD0Zrs2RonAw
         mVj9X4001fq+9qojSxKKHdy04SI3sQccH5A+mti9AQRzkiMWfMmVoGNXtLfOxzLU7VQD
         S2JC84LK4jSfLjwEzB2qUmyjWahHu8zgiozoBD3VQAnZUjKmq4af/IEjLP9EW5p/aNlR
         /XIlIT1H4Oa7iLYEoBeImMp5HqCD6dimx73texU2fZfCvL5BkE9tOZZzv87dwG5m7Qpo
         xv2FF5G1e0yONJzGKXr9wXyo1AVMtPqF/5AtcV/XLObSB5jmKnN5iLnnwqcd3FRKA92o
         b30w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780394936; x=1780999736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ347DOspHlrSzQwc+sUspvodJ+DS/yaaB7+XklVIBA=;
        b=mHcftuvAHN7zNEqkdzSZNsPahYKOMQWVIuwr2pVNIjO3TOQH7Mgt1VCdvtETCJgV7v
         dnOtWIaGawGx3R8gw5INXmSyh/hSg8vi87junZqkzkMopkRwLdEdwmTPuVqj15ofZWVj
         6BuZzmbIs280+51blO3XYplwUFor3yOYvyUKEDhiT7dwz0iXGATxI56qMPTHrWbN0QBF
         7EwtJyLGfl6mQidvmUG4Kbs/bZsqPRwNLgcB9R4y3kPzBqYL/GEfNS42OES40X5pn97h
         swmfKwJvvWoCPU03mbpirb4mSTErzdYWNX2TNEERLPzCQPLAan9Od2q1pgpPbTuYjYMA
         TIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780394936; x=1780999736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZ347DOspHlrSzQwc+sUspvodJ+DS/yaaB7+XklVIBA=;
        b=qps1cXbwwB98vrqZSgJTWZ2jCh4YUHMCacCHw9ZUdgS53JAMoAcVsax0Pl+s0T0bLL
         /lOY8T4zOcO/xtpnTAye4z2O8+VJPjGzgSIXO2SzMbb3mxXQ825gEEkKvYMsOEcirJyW
         xH390mI4WU2trrFiAH/DqN0bGc6V6POy5vUrf+AfWe+mhHPgmg07OmTSEapPtOPeFcK7
         Xn61I5SwyY1RZedCKMvL5FFllsQxzQecbZgZvQhEWJCCF19Z29dOEpJGUNHJl/0s2get
         lQA1Cu1+Q4fM2yXfD/rHMa/OJXVzp3jxe9RuTBWXCpuOQoc4MJ9nGpeIrPxmaG7qLhzP
         rqMw==
X-Forwarded-Encrypted: i=1; AFNElJ+3PAmoopI8Zg2Snt1wMT8cpjuiGO3lyAeJITviudu1AuDcxSKe6XRXB4WtyjV1T4j8RTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTq4J6yYlx48K7ANnjjmexxAbHPoMQsTRY1EoPfrWiHQVUGbh
	qWF6EXsiRaxeY+FseuO7TZxzzj02Pw2V1B+4gf45TAZ250QyOU/WqWN1v2TkxeTGFbdoQHl71Az
	/k2MtkTij85fpmmrs/+AaG2YlCURwPPw=
X-Gm-Gg: Acq92OFEGAf9b/s5yEAPTSGYW3MNNzRsbiRc2wp0o0ibXL+5ogWaDJRxDZykj5ta9X4
	O02CR365XHwAgkhgbavMUN6p/D/IhSeEO+/Lrjxild+Heq6HuKiqWa83D5BTb1Ohny83Pe8592k
	0l/pGUCllyF0YGIU43L5RzpKBNC/LWrSKvmda5MhptQqO1vB3IFR6sKDJqgpMivbIx3GhJeHDHI
	ngq4f8keBGY100R7QVGarEbwPDzVsJRZ38Ib2eULj5xt9cXR9oujSMP9sBgRjGxxBDO98n/l02H
	QAVuLQO0XyZp4lSC2HCoUMlshKEknjvmG10s7m01ojD16MnkMZv2mSYJFhK8ndIlCqAg1jtMWeT
	gh7bx06LMvS0RbA==
X-Received: by 2002:a05:7022:21e:b0:137:1ae1:bc19 with SMTP id
 a92af1059eb24-137d3c10d2amr7107111c88.5.1780394936464; Tue, 02 Jun 2026
 03:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423160832.114816-1-belkid98@gmail.com> <20260601154211.82370-1-belkid98@gmail.com>
 <20260601154211.82370-4-belkid98@gmail.com> <xmqqpl29ztx7.fsf@gitster.g> <ah6QgwfK_TykIiBp@pks.im>
In-Reply-To: <ah6QgwfK_TykIiBp@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Jun 2026 12:08:44 +0200
X-Gm-Features: AVHnY4IUOPt6y9TGFF6GBnL2eLN-GMUjf5LUvUvK41nqXcu4L9KXQ9ygSp3wg4I
Message-ID: <CAP8UFD2J_482vT3J3hYpSeqG+of_ZDjO3a-paGocRyRgn0=FDQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] environment: move `zlib_compression_level` into
 `struct repo_config_values`
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org, 
	phillip.wood123@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 10:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Overall, I think it's sensible to always use `the_repository` at the
> callsites in a patch series like this so that it's obvious that there is
> no change in behaviour. So every patch series that gets rid of global
> state in a subsystem X will basically bubble up the global state into
> the next-higher level, and it's then the duty of the next patch series
> to address that next-higher level.
>
> The only exception of course is subsystems that already got rid of
> `the_repository` -- we really shouldn't reintroduce the use there.

I agree that it should be fine to proceed like this. It limits the
complexity of the patches when we separate getting rid of
`the_repository` from getting rid of other global state.

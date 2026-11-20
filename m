Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163455;
	b=rV/rFvKe+2DR3QxflT4jQGl+epn7Ohh1+hLqvc1W8CufwHptRCtbSl7oAAMnj/3b+Kci
	 6UpGy26nAGDNAAWvKYn2wCW6mDBYkEyf6g/eeI6cdSX45FyZ3deoL+zMy3EHYsNeVJsdh
	 5d/JSjO41VPVMUWjCT4PY6mHs/EQ++fvMJGfyYNdsvnTM6TorT7aan3C8MKdXGy+wBU1R
	 70gkUwAdwhmfk7LbTsU8H/WeVRnhSWKw2731iMfscjtNqsUIHncWdq0YmWp9tk9UVkyti
	 LgWCvOL/KpcPfVhcpS5iY413Bn/ir9P0Krztqb62zIQZdlmBo77ucLqx7+ADBAPva3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=276HR4GVjdlztaRpFIrRJ7ojiNuVXUd53QDJ+2g94zU=;
	b=KFnBwpuJF7E6ivn5Z5AvRmOGHeqYnMvmV0Zwx4HNuSWpQe0G1SpnZjDglAY9Wo0ieHUJ
	 5j1vm4uRGSzlQoE47RFlBKiJ7n+UyoybbfhABE5njVaP1iMtONCMmudwTnMOJbITTv7GI
	 PLLWXbd8O5nEtoeazDX27nB5CZtdcH6lWLh2th1QbqFN7nfxLomU63c/bwZKEKQshjUP2
	 JjwoWwm4GUXhHyYLR2bnKAfBWHjDZnUhmT1RQ9YDIU+LPi36dNGvFYVF7+6pUWeWDTsgf
	 oxD2poeuw1ZwnzIkYjYVFCr3VWmWtLWcZZLDQRpECgkUtWISR2vCQn2d9fLQojRqD4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlPyC7jF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B30606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B30606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlPyC7jF
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3b4944abeso562843c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 00:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795163454; cv=none;
        d=google.com; s=arc-20260327;
        b=lhZT8HR2xE0ZvRO2cU927bR5UpLsmXoRonInEXukeupJXv7hypvTwgzsUTbNTwN4dU
         yBUdRtLaaXNrViTi2V8xG9s7VC/uu/g04wrF6SxdKz0U29ytWnaCZX1LfpH8GvvSmF3h
         TiXSeFGZh5Q6LdRMdA1Cku+XUtdOdB91G1gDa2Li178i6HU7yipFv9UOt0h97cL8FKFp
         FkvWqVToFS/OU5zlcqAyKyQrK9bqpWPtdF/Xpq1V0zn9cIj2Y+5W34z51HbmP1reBm3h
         X7lbOwHWvVs+O7ddhNKK6yAfjsG4FEMlvt6dAiDeQRdf+wB9uQwVaa+zExp6gfwmX3zQ
         yzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=276HR4GVjdlztaRpFIrRJ7ojiNuVXUd53QDJ+2g94zU=;
        fh=Nnzl3L0QduZ/QeMzQdME8pcF3GeSkdtTfImvzCeTeHw=;
        b=K/6aSA3OIhXyDJcjdiVHu8urEQKkSm7+tAP2/3GepfLEUb2u9F78eVZEMd6agJ5oM9
         ttOFrHJiqePEs/ctwklGvWNCZW8qGLHxac1O54qpeysw4XhxCqOQDpJEXhldmEPYcHGw
         nzf6KxaUeHiy5gTSi1cxMWD3Lus01UZckr0FMGGPkmJfRmBo5lClFVNRjfQ8xsBD+oD2
         FL+x1xAvGpzAxY+aKxYV61icPKjRJH8L79wtz7KM2WmsBMMt+5xrW1mqGTRryA+j6of4
         qp2rhPxhyiocPqYZg7v+TGMrHeASLOO258/elqf1gLmn7LwvyJjPUBqXPtjpr1UXpxS/
         VPGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163454; x=1795768254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=276HR4GVjdlztaRpFIrRJ7ojiNuVXUd53QDJ+2g94zU=;
        b=xlPyC7jFJ3jZ8nARy5ju9kEy+bW/ZVv3tzcQRklxnf6Btf+HO9WaE+YZNmMX1cchJj
         uFjD5ufNVDiHfsI4Ik18Vch2NA8GnOCcv10H4TmLfeGoyLDqbOxH8rKUEXQupmv4zoNd
         aLSLJmrreMkvk99EPD94xsiXQ1CCJvHPo2Qi1h6fYDkKTr9gWC+uXuokdgR+cwT9Gr52
         pW++3EmU3cw/hKniT4gI3Sh3zk1/wi8y0Czb9Cp0VMMSyn/p2WCFIR5YOV6YxhLbXoL7
         KSZBmbNpi7+VSen3LBN3GBgwqWZPHzdNqs4ac+HW9IZPTW32yPj17hS7vEHfCDDPdC0H
         2BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163454; x=1795768254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=276HR4GVjdlztaRpFIrRJ7ojiNuVXUd53QDJ+2g94zU=;
        b=GzuvyFeQ+UZGDCeOF6CbYjePO0b98Z/JGYVb6ewKuqsCmetFQbN2fU5vJmRhIHfVdF
         9NQ30P+6P/6K4LU+J2ue/+BrwiZNYGaHeTbLi+GcUG77ph2BEEbsRltIL8HB//sMl6dd
         ceW4JdRIgHM2nJzEUccGlk/Q+UUuV0X0CiOtnsDmKK/686G/ZTs0gSIZD1ZwYl6xBM8l
         dUZ6krNbb9dCeCMaPuFEF4pg2cbtPICB9QCV5DDUEBbBrDCHSntt1M7zgsuv7VJIrNX2
         cHgWoa2wAQEQWsSrybU/b1+9hJ7BPYCukkTIuYt/awe8Y+JgV9PWXgUsPdheodTscWoK
         /9jg==
X-Gm-Message-State: APuU4Z9PVqowbZRNl9vrqxtS7nHxD1rlz9QQtH7zaQjZs4oZ64wRomlS
	D+LbaHldyWHIfD09GH6+wpYcfsld9uDLmAR+ierUnEdPstp7h6LT6dmzlWqWFLk3SqxazbOfB95
	OnOcwssGrujScblm0YS7nsVAi5m09EGQ=
X-Gm-Gg: AYBFou2qgqch+OWJl235dmxXhq4HXKWvpvOL8tTsQ2vUOXtybAdRUf3CwAByWUfrSMn
	+plec65NSlOnWvxnl9UD8rDykhEjtQnpw5riapx/qQndYcq5gn+m6aAYwXfQDcqC0+TCnj0Oifg
	OBFcIPglydDZj6u7lCj0MEPcOPYFDUKREQ6zbQKFU2yVlYwd99QcrgcD3Cssk0PDnJBgLqssDKa
	GDDxhf7TQhgzqFkk0mJ0SShq96JradTAdkub0jUXwzdirEgu9dUSk1+FxTfiHtiuKOikDvaSrkX
	KKSmcoIsxEHp18WtIObaHZT4UbCdKqDIBvezAOt9hRJrTf39IM2kTEGoRkuMdUWLIx4JO6pY2mb
	RSmzi8cZTvVrnDmw5aX32CkWHfhxivgH4gSLFn13QNcpbjaqWUNzydMTY5BHBVtyWuBLO57MBJJ
	/rERy7/suOtaOJLyiChUBpif6mpzChpYijFHWoPqDCOAuiHoWFoXxfLuN1KTaZgfLVBQj57pNPZ
	ftlIMXYQXRbhSmdVJ1uW8Fj
X-Received: by 2002:a05:7022:ea4f:b0:1a3:dfb6:e593 with SMTP id
 a92af1059eb24-1b556900a0amr1794856c88.27.1795163453568; Fri, 20 Nov 2026
 00:30:53 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117174353.1158905-5-christian.couder@gmail.com>
 <20261117174353.1158905-8-christian.couder@gmail.com> <CAKrRMNqMRkkb9+n+11p04YDhn6p39uoc_Upc9voYhZZoLyPXBA@mail.gmail.com>
In-Reply-To: <CAKrRMNqMRkkb9+n+11p04YDhn6p39uoc_Upc9voYhZZoLyPXBA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 20 Nov 2026 09:30:41 +0100
X-Gm-Features: AclHuK-tM_A_SCSgwDhU-9qToOuf5b-skhEcqtdApacUfKJHV36wOxNCODUVx7g
Message-ID: <CAP8UFD3Yw0kshhQrz_5_PKCBpenSHc1qNTEh2bvz5HkSQ1NYPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] xdiff: drop LONG_MAX check on merge result size
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	kaartic.sivaraam@gmail.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tanga,

On Fri, Nov 20, 2026 at 12:51=E2=80=AFAM Tanga Joris <tangajoris@gmail.com>=
 wrote:

> On e1ec09b23c, the two big merge tests are skipped, because long is 32
> bits there. "merge-tree dies when merge buffer size does not fit long"
> passes. With the series on top, both big merge tests pass.
>
> I also ran it natively on a Windows laptop with the Git SDK, and got simi=
lar
> results.
>
> I went through the other callers of ll_merge() and xdl_merge(), to see
> if any of them still pass the result through an unsigned long. They
> all end up in odb_write_object(), write_buf_to_worktree(),
> strbuf_attach() or fwrite(), which all take a size_t with this series.
> So I agree the check is not needed anymore.
>
> Looks good to me.

Thanks a lot for the tests and the review!

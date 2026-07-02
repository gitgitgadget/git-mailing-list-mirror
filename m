Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CA2517A5
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962676; cv=pass; b=kdNjDsRwO4Zpct7YaKG7UuXpeAQ6AvXYkTTujZ943oAeDLfLlor5QzRey4iunz+kbKWoSLxrEarUBS9+D2H+5d+1deYIzf/ykJZCkqS0BYRvjF5gns3GSm5+BlTc/9ixgpzEdv9sMBD/+wJRvb0GpQ2PD4HUNkw385dPZIqwEug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962676; c=relaxed/simple;
	bh=tUbhE0HjpQ3n+pGGKXRbGmeftEAD9Q9d89AL0/gnYSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctPy9px04KH/kkKgQG83XCs1s2a4ZeSzdmFJOUsiOImzjR5gMTN6PI3D5741E2McyNJyOCryUUS/Kw9yenCYTQurB9MiDcHk/zVapW+autWJICr6IetJql8WmU8f1uZfHXeoWokBSeUt8Jg6fcMYttP2aR/4odoiRfRB58j53vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h90KM/zy; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h90KM/zy"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-448b89f700fso852443fac.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 20:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782962674; cv=none;
        d=google.com; s=arc-20260327;
        b=OIvU/ls3S/Ec8qM+aNOLTPUitr6hYS3nQlctfBzMXF81kMBnPw4kIsC9GEfggyUBNh
         +hoFAdD5Yv0o/34hxR+sxD0Qzc/u/aP+wt1eDED9zIDJZ8iU7BGBLCPR8vajtoRkrSAr
         QT/nWrdwINlUOzx3P5vMvHPk1lLQ43xOuMTOkDAgTKYrNNR5UzH7zUZWhTNqSyhXH78V
         taN3TcMfWnpWAPZKHQbzjPFW7imtnw0clXAF9R/eu9q21aNPr9a48PmRsldxm7fRYxK/
         ZLOBxewjH5Bl8qLTZ406p3Vxm8flA48rXj3FE4y1dDsaubKKhR5KM7szVq5kHQaraCuI
         DkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUbhE0HjpQ3n+pGGKXRbGmeftEAD9Q9d89AL0/gnYSM=;
        fh=8Uw8fxdmZqoAF2ZU6zFvbmpPR0V4pFs0GroEv+QYibY=;
        b=P+lXXsfmzamTOL5I2McgYLNpTO1aq3Qe5PiEYjCap0WwjjH8i1e51Zr29SOq6z3yyY
         ILUZDtmii0xamVerKiDcvj0DFfuCPkj1k2AFLrXUmhVQjmsAGPgujxv1rz1EaFtu6SqE
         g0YVO0SpGe4q4xF100ntx4yvtgrJcIfzjbj7PfG6Dl+vC8N6LfN0rK++Bdb/K3mBK6Bo
         rYo5kp0Ka4ap1PPRQbObl2XOWdh/SU8UOQnuHWtTd/w41xrEOLFlHy64vX8/s+9fxatS
         HYIj5hvboUnxlI92MoQIb6YQop6g4HmGdXMKXeh9lmDaWqispwjjzOgLXDYhaHcypgFQ
         lZag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782962674; x=1783567474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUbhE0HjpQ3n+pGGKXRbGmeftEAD9Q9d89AL0/gnYSM=;
        b=h90KM/zy3hefZftGzp1q3u3D+rCg5rJKtaCg4goPNnwI6AG5QgzU+pwwci+XtcKNFR
         X3UTUQGLR3qzS7McuR/bQ8V5j83VaFAD7E9WanoGtmy796wdPRW9Y8/tz5iY5IODFYzy
         1LIcXOGQ51M6aAsBb59GMYoQaXfmTwRKLqyvXtOdMxg1S2zuC7MGeE4zPwrbPX1VOPee
         k2l5wdrWEhNucG+phKyJwK1UVjqKVxXee0Xspbw8HWp8FytVEX91JpL6w4Z+YrdpU4Ec
         ulxpr8soN22GC2LtLnTQ2j+AqkFVU+iONC5Do3BJY6l3dOtOPha/xmVSiIXZqFpjiAIN
         gtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962674; x=1783567474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUbhE0HjpQ3n+pGGKXRbGmeftEAD9Q9d89AL0/gnYSM=;
        b=tAGsvFDFD5aS3rJsq9sdwzgqnXw914ybD7vQWAmP1bzF2GJK2pgGy+Td+Bv1hVkqlv
         f3W07oP8gU7rmJOJPs/Fx749Bm8oLNX8tiiup7dxBoK7D1C+GwLdqr1/gbW63qphB0nR
         wmoxpD0GHj1M4F0JapmuCeCW6Wj5ckiUDBnQOf9d/7D3CDiTaYAPRml4/2AOVU6ezxGE
         I38/1wl0yTBBpjJFxf1RN2c5b38mxim6QVHxkjcwDQvYa+FulfmkYQIdYfrpm8vlqyso
         xyeltc/UOwtGODpAI+sUwFiDEXf0+XRlg7IvBFJNGy7zSqFIP2xIFXAo2ysJkmRzzJWl
         aV0g==
X-Forwarded-Encrypted: i=1; AHgh+RoG6j8Ptf3uYsyndUVmwzqjKBrGI8Dg67gEoHwnTH+XzuWLKu6SMijLKAZ0WBTF1AO69K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBq4bu2oLUGhk0oqL1H0l2HcuarsWC0bEw9rGMeNeETEWaUHWz
	WKAUKZfNTbK3ri+SSynhK0JhHDAAI2en9leMqn8swXFDZntJTfI98t9sde/eNtDfgFQC7uSVYh1
	ohXMnhOrFRuZkV+MZPC5ZuiTtNknUyTinFRKH
X-Gm-Gg: AfdE7ckTlLbUyq3kVO7fMKP2RxDaElW513n6knlBT1u6WA6asoKLp4w8q/8P00oUgv/
	LSX3NYDocdOIg9nlayNhIRV+ITlAyG+v/XFFf+wAafWMQgto5Ql/ATVsKCsW7904TcacUUCwj5h
	+zZUk3W0GKeqKiDaNrpnIbHMwucTUmpSF7twKoGeRYt3kPMv/AcrLLQKf4HmXuqAbX6QEg/iOfi
	3uZgJuO4TIXHyRtR3Xl3f2xosIXRwH8OXNUz3sgCY79Myzod7ss6KkLQEnGK4j3fhZyPCcpKZlC
	IvZi3JwOL5ufCoBJzGBG+nvIwny4EHmYCfg+qONGq3OR1bOX7Ka/SMqEvL31pw7JdBxILOd/9wd
	5WITNbQm0EuLsUFY=
X-Received: by 2002:a05:6871:4416:b0:447:17a2:aabe with SMTP id
 586e51a60fabf-44cabc26de4mr2605828fac.31.1782962673812; Wed, 01 Jul 2026
 20:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628075716.GA3525066@coredump.intra.peff.net> <20260628080009.GA107826@coredump.intra.peff.net>
In-Reply-To: <20260628080009.GA107826@coredump.intra.peff.net>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 1 Jul 2026 20:24:22 -0700
X-Gm-Features: AVVi8CclCvdNXuy2aT7MFcvN-eBjzUSRnXaHiw7s6GhSgFg7WRHiS-Y4Ea4lHZI
Message-ID: <CAC2Qwm+0-O6aL3bEN15+L+8EtVdF3msNARxhysfPCFxxdrBnPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/lib-httpd: bump apache timeout
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 1:00=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> I didn't reference Michael's bugzilla report directly, because you can't
> read it without a login. :(
>
> Maybe it's worth doing anyway?
>

I also thought the report being behind a login was unfortunate. For the
historical record, I ended up submitting a patch[1] to their public GitHub
mirror that describes the issue in more detail.

[1] https://github.com/apache/httpd/pull/676

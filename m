Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D359385D9F
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061985; cv=pass; b=t1vFymKFWy/4mDnZI7IV1vL+IKHWWGolGp2RMCLMZ+OEaS5/XI0g1KgewN55fiD/P8ALTYwRQsnelV7ChKXZjHErFEK1p7un8Rp9xjSrr+e43Dshi0bUeiMRF52AGLR9pfks7dyMdwpyzr0T7Rt3ngqsqpE4qntqqOFsi2XrpAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061985; c=relaxed/simple;
	bh=oaEQbyQ9oCt/JPO3T+3GgCGzS/tWRvFveMInznZkouc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS+RFI9t/xKCMVd4ZMdW5xx8zJyhcVzreGkzeHY8HQQ1ShwsODk5TOXDHeAKH7NGr0wEtN1qOO0WB7eqAIJ5ld90YXcsdkWpDoDEY9cTB5XecMjfwyrP6wGMwTza6TIqEYY46z1K7Ls9wV/+ownsL7z/JC05FGFEGix1yoz6CEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV7fC9pf; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV7fC9pf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so231168b3a.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 23:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061983; cv=none;
        d=google.com; s=arc-20260327;
        b=jNBYH8jv1gxylZU+uji1REe/VHC4OpyfN+fWPhxl/SProDpyteA8d/j37IwpkZk4sQ
         zI3qbKpjiGevNZqcOfnBhqFEKe/WZEGQpgmLc+xo5ulKlFWUX/U+2cs7s51pOBSgpmIF
         5iqo/sUZFeOwVoxpi1KLY+OYfyiDVq0aBA+KjbeWQ1at1hSbZTVFh5jz/HvPRgdeIRUP
         lYh2+gKe4GQujoEWBNL6NLhT0YeFGV4WzEGs4yNUi1iBe8q3ekr3ff6bXKHvVpTTtTqi
         ccPbPJazJVuBbT18rWrWs7w9O7MDfBu4lvDSdTTYdbG6Gj/afp38TxNZYU36O+KkkrVP
         8T8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cv5tXd11k1+cGkSFkHLehC84ROB0ZExDpMZwARVhpP0=;
        fh=NBuqo4SefB35QRIgWelYQtL2t+NSesZoSkW8edUAe4k=;
        b=m2WWWCFUQn1HMDW4+iTOH2IhDTLBLiy8fbLfSWhB+euUJqX8m48TlWwZzmrJpNKeVn
         hJhGU36Tgk9Fff5ICTQ+YwdLGQCslatoJdbSL/3nbtACYMUbHwyhvb16A1t711l/iCod
         yjCzerrbifLX3FjUKR9JpHerV62HeJl4TCpcdf9JGvz0EPWE93Zg8LsMysgrNm1CHHn2
         TJar8eOzHzjtOmMDoud6PBCsjny7tH3uYwvpibLCkMKw68HRViwCoyX8bFDcLr7lHE3T
         CjS4dYj3plEPIKCI0wh3xjiyIg6b5/ykVbEf4JJS2fwe+xu3V4Kv7WDiKYVljsxutIE1
         vBtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783061983; x=1783666783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv5tXd11k1+cGkSFkHLehC84ROB0ZExDpMZwARVhpP0=;
        b=eV7fC9pfvX4VOKu27w5V6WQAX/KtAgIL2pyjc96YFd1hQK2wqYDRVh1aU8TRjn4w5R
         H9zVFt8uQtYyjqoQItqUdbMecr+FTANzVj1H83d0hBogxrO9DSw02Qc5x+kWQlag1nWM
         TmamjnuVNlA0Lpa5FxYKpcx2KbtRxxZVWl9ExM+XwAscRAzeWYTNvrASTevJdJgdPg4G
         ShmHc0XJl9kKNrcDdJFTc25cdVLqVx6qFB2uC3NVJV7w4XmQ/3Im2gNRWW0pcDkD/KBD
         EyrFS0/QE3sxuBa5x8cWJcEBuIM/7zgJMagtDwOTUbfX2/07pFTKOvL1tkUYMb+4uxjI
         GLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061983; x=1783666783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv5tXd11k1+cGkSFkHLehC84ROB0ZExDpMZwARVhpP0=;
        b=AFCi2Sy6NQkNqlzQl02So1l7BV+XMpJZd4RlF7Q9HFADyQuoG0WHaVe8iCqprvWlJ9
         vi/wJ39XUi+/uLvJt2al9qFy2+2jCRgdqhZrvffbPAUaPoeohlOLJ6pI0P5VnSVl1qRl
         PxQ0MvPd7JHpDA7fR/7Agv86y8fRktBbvFXZRh4IfHi9PI+TRAwXLcGApQfiUmop9t2E
         qzedB+txfjHBIJtHMDc1smWTCnJMC7X2DHAM3ZZaFVSudGmh/mbxIp7F0Gw018ri2b5/
         EkPqlvsYgCSBbQM+CXSguyB3NxQaxpW0rLoCqW5Z+1YHM5y/ZGCIWrSK+9vAa9AmawBy
         cwng==
X-Gm-Message-State: AOJu0YydVaGN9czjrul5YXRLe6K+gPIMzvMh2IMaWKnKlzzvBwPW2MRU
	gkHla0GSN8P+CrBazobAn6xfxsEQ7GFrQ6R2kkTyDmHuQDN58s1T2OUyOw5uP8d27U7cbpCBh5G
	8/pTxUKROINlbXXsyZCGmpLAwoH+7qN4=
X-Gm-Gg: AfdE7cl9ymop8Gghvo7lfXfZ4O3p/EOZ8bXlrM655/HfqWLVgadPcHf3/DDWU338wYm
	XRe+++qTPUHmXySNlok2wVwQgWmGndLqM5R+hQ9DI3lV5ocbTXTb20+Ko6mYVItt+94PV8YPpTE
	xTQuGCKT0iAub6vU46Iy707gQY41HI0AuhdiiyaM7GyP3JWNF3yAo+yp431Vo8IVdLX9ERg9SiR
	2rXGoyIdtCqI9PtAzgXRyPqpJfv+KtWSWWAss01i+X56RAT4EpTgvIL53k4rUhUW820ftvVzoFO
	Ce4Pf4qf740AOUsHvAJHL+URFEIuJvImjw1ofs7RYsAIlkjzmWXXtaa4Iw==
X-Received: by 2002:a05:6a21:b88:b0:3bf:6222:2e7e with SMTP id
 adf61e73a8af0-3bfed0e254cmr10861993637.4.1783061983506; Thu, 02 Jul 2026
 23:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im> <20260701-b4-pks-history-drop-v8-6-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-6-19b5cdf1facd@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Jul 2026 08:59:30 +0200
X-Gm-Features: AVVi8CdDv8ls8youzYuML7WF7Enmow1uSvjJUIkqv9nPb6W4GJPB8yGxE47I3gw
Message-ID: <CAP8UFD3RZv=PGC15xms3xZZkNQsGLpgq_ogt8P9ux-8p4HwW6A@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] reset: introduce ability to skip updating HEAD
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:35=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:

> @@ -113,6 +114,9 @@ int reset_working_tree(struct repository *r,
>         if (opts->branch_msg && !opts->branch)
>                 BUG("branch reflog message given without a branch");
>
> +       if (update_orig_head && !update_head)
> +               BUG("cannot update ORIG_HEAD without updating HEAD" );

There is a spurious space character between `HEAD"` and `);`.

> +
>         if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LO=
CK_REPORT_ON_ERROR) < 0) {
>                 ret =3D -1;
>                 goto leave_reset_head;

Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0B12BF3B
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208783; cv=none; b=nTIAC3z0vmzajYc829+NYbr/ekC7njKEt7MGr4RAsdu74cOykqgV1ti01Sd6sWWw/sIS3Q0xR2BTCYymfcI5fmNP5fePn2fZGs9PQPJco2TLfSRXamGH9UPVmwrmexEHN+SURxTDP7bozu9B6OfeXpwXTG2sY1bwdgOolm2QEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208783; c=relaxed/simple;
	bh=au7qGeKaweLqeUmSdD1Al/vrIm1eBsgtd2GD/Piq88Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK3PCsKRB1Mj2IsDWs+MBOlt4lA37KyypHSwd547DJoBqt1BTcKEC6JmjV6aFLI8W+xZjlepw/NT/Mx/Ba8zyIEYZXlagFrGm9WoX+4/J0mKpWpI92fg/5msMrLEgZbwGnF7ZlAKcHRJG3//S/lWjj1uVRZExmjaFmVKivad/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9tkAkIo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9tkAkIo"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so72999481fa.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707208779; x=1707813579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au7qGeKaweLqeUmSdD1Al/vrIm1eBsgtd2GD/Piq88Y=;
        b=e9tkAkIoDBUYy1XxMejxAh49DqZ1WR1UVH5RoYxsvM+BCTRgvgnKwC1lbRGZ3iEYFb
         +Wq9Y8vEKUGJNJpG6WfmwXm++pMK85sbbdpDY1IDnZaOgGs4vzb9cU3SrqfKEFg3HD3e
         vf9FWRV9/hg2Zw6plzdsBXRtPFUY5XkA8BH46O//XdO3en+czDs+wuh67cy8zkJwUHmn
         ir0EaYngcoyVo8giP8ik78aNDNnnLBHICTi4JVwxCdquTGG63AC3+jKBGIywAcS+dDtd
         Srmfn787tD2HHF0etoxgR0YS7IR5i+kQCTQP7Mi3tNN2Jq9i7M7NlutlbGUDhYRhIKGD
         xPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208779; x=1707813579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au7qGeKaweLqeUmSdD1Al/vrIm1eBsgtd2GD/Piq88Y=;
        b=O7nzlJrKT3R8t8qdK4loL1Ia+8qH7DT2aD3TNNCNxd6LoboGvXj3aMD/pKOoQoxYao
         ugoMcRBqSR4xnLI0zJjEnCai3GAMYId9Yw3/67B1p0Kvrxpy5kYbhYcUbuXXT6W1Kna1
         mCq4tndxtG4yZNZACnGg/l431jWZ0jPdwaLOHFco0BgJl38/bWeu3qUGDDpXcI4JJ0Rr
         zGZEEnfzNLc8uAdVz/QNblggTI+aNCwNv8TxWJFtrJmy9bD9Qj/hAfZNiDk6X+1tfxID
         W+hWQKsNEa3jEzFvrcMr1mo2M5unAHL2AUoZfKPMDj7Pbsu88rJlC/BSKGKVG3jlwArX
         CDpA==
X-Gm-Message-State: AOJu0YwVrKB1ESMDKe53DnVTLfHuL/HIVcqX14AglFxFYCmi/7l4PYyn
	9ArSPpOFH/tqDZfseiDcOzj4GWt38GmuJtb2nuvcq14uiJblrn7nwfxeXhT4EcBHxyTdbFvpeRv
	DpIvcYjtHo2CLkfhwmtgtahsUsJI=
X-Google-Smtp-Source: AGHT+IF6cjad3vZwmi05v+ifZ+NHWIyXEpSWoE20/9oPHcTkVtSbNpnSCoLIJgolaQ4843a5L8Bpv/2PCgKNGK0TtyI=
X-Received: by 2002:ac2:4a63:0:b0:511:452c:10bf with SMTP id
 q3-20020ac24a63000000b00511452c10bfmr1294220lfp.19.1707208779341; Tue, 06 Feb
 2024 00:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205162506.1835-1-ach.lumap@gmail.com> <020a01da5859$89e41210$9dac3630$@nexbridge.com>
In-Reply-To: <020a01da5859$89e41210$9dac3630$@nexbridge.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Feb 2024 09:39:27 +0100
Message-ID: <CAP8UFD2pJOU7sAWROENcK+8g5J0oZpXPeQ9UOh5CwS+CvVpx=Q@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 1/2] date: refactor 64 bit prereq code into
 reusable functions
To: rsbecker@nexbridge.com
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:34=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> On Monday, February 5, 2024 11:25 AM, Achu Luma wrote:

> I would suggest that you also take into account whether time_t is signed =
or
> not (more difficult perhaps). Some platforms use signed time_t to allow
> representation of dates prior to 1970-01-01, while others make this signe=
d.
> Some other platforms (S/390 for example) have retained time_t as 32-bits =
but
> have a time64_t for 64 bits. It might be useful to account for this.

The goal of this small series is just to port some existing tests to
the new unit test framework. I think it's a different topic to improve
the existing tests to take into account whether time_t is signed or
not. But thanks for the info.

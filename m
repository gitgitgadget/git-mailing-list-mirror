Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FF340285
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811712; cv=pass; b=f4PxiUM+TPpWM8LQ/5vRYlbbNJ6/AGjRjO1mwANYtTUR5X32d2TPCCAZJsWRzKiRneCYdixtLrqKwOb1q+O3ip7y5UYsjWH2Q2oFyBqXIldHtPcmFBPiZrWNyNaj8MzKmzPKb6FTSx/Em2gPZs6ke6YM/8GhuBTbNpzPZ5l6SP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811712; c=relaxed/simple;
	bh=ZhNDSuBijIrTs8YpyMu0buKPfMTnNBVmD5uWRx9AqlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f89Nq7ChtY4M/72ejwr5cn1ekj2hFwzhsQ6UQTwJtmhqehKkfEaRXo0YLdOT1FpsnnRPNY27kYVqa9vudxjvLnV9KF8Dhj8wm7cjktkAYawiu5pnjvqR0ejo0THteDRJcCxglvacKZKfX95iLf+8lvuavGztrLKQqiaODx9mfzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrG/Bbuh; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrG/Bbuh"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121a0bcd376so3170292c88.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 00:34:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768811699; cv=none;
        d=google.com; s=arc-20240605;
        b=jqwil7sKbgCARsM9Gc6fj1XNhf1ebIipVHlDk39dR/jmRvJaIEHeFOvKjnDwtciu+N
         lcrudeRknHQKs2siFF+6WiaiPj9nmaAh5NKY7eRSOUASPkBxJsip4Op5Y29A6CsbU44e
         /txwCgv2BnrKQsRMfMUJFBcEVW345oJv8uUVqm/fESrXbcHCwXGplz8Y2kYoPjVoAzoz
         k2LgThRJ3Lx0XysqaPOkqL4PT1KU7PKfrPmOZ62q8uG5HcezKoxM6ye50aJzZ1m/Y4FT
         qQlH/YmaR/lJZchc8wsmgFmdsIPUn2khSj/Wozv7QEm+pSfgpU8ZfuEsfY/to+wTOSLf
         CClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhNDSuBijIrTs8YpyMu0buKPfMTnNBVmD5uWRx9AqlY=;
        fh=73oZgCR6zCzhkJuKIjixP3KAg/dKod1Y4x4r4c/7nhs=;
        b=Fuq/phkUcoO3128qo7tlrdAdM8e3idTpK7tX89JRelXz6sZMSxVECpDQfHdVdPlAM5
         vxu90S6Ns9HuOrbd+2TgtyOP/G2gYEFeUvlEWU1cvQHpoe3ReVJ+/fU9Xzceg25cZ943
         4B4TrSABhlvSRJrVs4kQO3ktyCz4TPgYLY4PH3mv1NszwdiCw7DhcuYADaMW+SgUc4ju
         SH79iCprijry0OklD47MoUx4SjWzAgpUMdhoX7Rx6js1oxf0ZmxrRXCbtR60+D72kiU+
         DwdT/b67Kvxk5RK8eoqxl1WhcZU30dBWyqrkDI5Y583g6d4RkHvoYMKIZFWVzMvfvr88
         fObQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768811699; x=1769416499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhNDSuBijIrTs8YpyMu0buKPfMTnNBVmD5uWRx9AqlY=;
        b=SrG/BbuhCzOyz0T6Vds4W1LhTDxXO7uKnOdfMmxUl++AQJ2boMUGjmwQTaWheeNRY4
         T7QUbVQgBoGixgnNiKXwm+HEZ1l7j2EbJNDS9444sRKFQ96LfskheV8gRseMsMdDz/Hv
         Pu+a/MjKIBMFng6DniR53MoVGQ9KWRTwiHqp+c1hqslxp19QdLVe1gXEI1YIMPVK88dB
         k/jhYHlIPqKEArcWBrsiNNGs8KtPmB1I5f8Cb8y7IuVh1BSIOMFuzEB1SnZUkkXxwQFz
         DRBwNk0JBupyc/Fhzi9x8YryzOahTRoN/2sYrkceaQpcW910G5PeL5d0eu//+C6gGi4a
         /B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811699; x=1769416499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhNDSuBijIrTs8YpyMu0buKPfMTnNBVmD5uWRx9AqlY=;
        b=b73nLXvc1riiNTCHOESksuK3IlAGiM/bJwxTpEqM96OyxkWrpEny0XpoWwRWs8CGO2
         FFlHGyMIXg1sQ3+zfShjQl+52IjHnbLC20lmn0FZIRxit9USRXrqtvrVeMd3IDIN9DQb
         QHH4fOqKKV86oUosIGYg58aVjj2fhXdSAEsCe30HoqtHV44oPZOY1iOk3FKVjKCr4LMk
         4dyYd/wwAmXLVrEzUWbimY0/ctX3xsmIm2tKscSpzjQYS7PbzHZPWkq9ijBGUyOSsBq7
         2tECbK31+MQ53zZWJz4rPmQpKcM0/W1leEQxItlOhdHxd4y79yWXQme6z/N68UQHeNdt
         QRoQ==
X-Gm-Message-State: AOJu0Yy3jwX3mR7TNqUiHF8bAD3tGeMEHrHe+GkK10bCXa10J4GPhnGR
	Sirj8VuvVmd+tm6JmcKAuczLKD2SWE33FSqCEO61XIaQNMEWtAC0/yImcf/g+SoTlCgVE2BXd1s
	CXdNujtqEtcXLZ369k7gVGhVjZvnSEns=
X-Gm-Gg: AY/fxX5nIEbG0vmykg/RUU7BFFOXSs4VZWsUQmwT0U3ktTQ5l97/4n5TuDhIxs/xUpc
	Br0W8myhp+8MhXEia3CldbV/A4GL+8cY/mSNQrABhztsdWMaa3G3QmnxP0PO3hJb6ZBf4x48TRz
	8fsCXd1qiUN6m2fRf3jbXD3bnZ0VcyBrwi5dwqrq6C5Dz31K84Q1NQD41QziNywRmYdCucG+ROt
	6WbbXW7tO7NoG//Ky+cm02rRWkPweVjyv8Cl6FPrmr2SbIBPfvSTaigvIAMNCySsMB2SSAre6h3
	WMlOyutj3K+S4FoxHiUbcVDxIzn3/NNCXzT0GkZhS1VK+mLaRlkyP9Sv
X-Received: by 2002:a05:7022:1281:b0:11b:88a7:e1ac with SMTP id
 a92af1059eb24-1244a6ee136mr8332918c88.19.1768811698934; Mon, 19 Jan 2026
 00:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <29682837-D2F2-47B7-B1A4-5CED32FCCA49@gmail.com>
In-Reply-To: <29682837-D2F2-47B7-B1A4-5CED32FCCA49@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Jan 2026 09:34:47 +0100
X-Gm-Features: AZwV_QijIZ2tL1ie1wcgHJl4TATwzsr9aHHHjLEThzsF1umHW0YUjpGj4HBbI3M
Message-ID: <CAP8UFD2LOpmXxF0kjbLO1V4YS3ti8Dqj1w8Pu6-JSz3y=fXWpg@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Mon, Jan 19, 2026 at 1:44=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:

> I've just finished my master's and I still don't know what I'll be
> doing in the rest of this year, so I can't guarantee that I'll be
> able to be a co-mentor. But I'll be glad to help in the Developer
> Pages.

Thanks, I will add you to the Slack channel.

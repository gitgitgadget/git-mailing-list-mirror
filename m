Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AA4BB278
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949506; cv=pass; b=iDiDrw9rk3cTLAuqLr4CkS3jjI/sIizKH3QoMj1WHuT6u5yBA5Vpz/E7Fqe6gnuyvs+k9kHMBENK+tX1qbGsrKX9O9y+p9ta1mAdtlf1vNGyYk8trMik6PAstpiU5MMfko+AyEeUCBECwTM1wwbG3K3meP1a7KlJ5wVIPO9GFgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949506; c=relaxed/simple;
	bh=e/rICZRgyifl7x9u3xGJWUfJ3OQY8vCRUtB1l2lrQ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugpyukN0GGXJDK1f/TBDT+W3MF/kd0Witi3PnytQtf89QedW0LpNkOoRRGEU15uRd8EYJETEZAEnx5RIoBM77z18Rnh0ZLizZLxZ7o3bXLaVw3K1LKon6SgIejGoUkf/Kq+4o5V3/icdmTfyh0G5ppnfUPVL+7IW5FCfHvO9CeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMYht4/I; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMYht4/I"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6afa5b9150eso682864a12.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 06:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790949503; cv=none;
        d=google.com; s=arc-20260327;
        b=G0ZJv8BtG8AaWp0l4QXutPT+HRy1ULFwec4kagF6/aITuUIowZREHiagUytuCcjrc4
         OJ7Zc/4b4cJwMawaR25iotkNiu2xbuGp7h4EVSMW233jAtbw5x7H0+dtacji0lIJ0v8N
         SmoNg2C0CghUs3OMTBnYfdNrPIeLdVqW5trZierftZ4YTIHugBtEg44lfBLCEbNjq5aD
         GjYDYxwY9C+oLvCVZgLU/XfvMJCw5qyZkRkGv0ewDvmFWPStuTjNfCkwch/bz/j5uqoK
         rGcEHMgRTf1LUoTsY8e4BJkUpKS0kZKm2VCcyHQmrwkkusDqlfzvPahkCa+clok/CcFt
         iOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FIpemGrJw1PVM5EBPvH+cvAO3Nha/iyq00o0zMab/No=;
        fh=/MN4agrpClKW3fwgr/OcBKhLlyRbzF8USnGQ45TIfu0=;
        b=sx+pA0/tm6Z1kdO9ZBytx+70EzJunkStaCS9YWw/XKrw33PI7Oe5GRjMAsnHe9L48f
         5B25I+62HsqkV1twepTJDjP/FBqCrrl6l9D9kmyl8N1xV/XJpoQD+mA5qwG97wBX+U/8
         //wXY+umTB8VhX425IA3INQrW8LCqn0L3KUl+iLZNhKCp98O8wEg8AcfuLGAR1rXQzLB
         zdqG8hsa/6hXcWN/wEJRUQR+VDtkxqpm1J3KaBth/LajG4ZYvXLdw6oBl/XLfYsA2mR8
         BeAxEu+NKYXQ8RTLBGr2zNE+XKJiB2cjF2t/vFLWlQlXmQgvQVbX8Yjx+2ufbWsdlrIM
         2DYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790949503; x=1791554303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FIpemGrJw1PVM5EBPvH+cvAO3Nha/iyq00o0zMab/No=;
        b=lMYht4/I7qsnXgimjip/ZMDQJ5/f6ukqiFv71R8fezo/ssv6w2NkwPDEwpfZpEKV3N
         W09JaW9Q6e+34owpuM/uvHDJrKglaKGoLLZjPCdPoF1Fy2ZidHb8iZNoOQhyNnD+Tb8M
         9le5ph8cPZCNw7Lw5H6dR/AEfeobz+hDfbrAF9HHzKQA6usiIRqSjF3CnFKUvnM06X05
         TulTqMLf9BjbAngAW3ElH59LrAgTLLjQbHgWEPkB0chRX/kpSZJswvPlehirad7r0C+V
         R3gXc2LqoOaxfa7Fy8sz//HcnbgLH/km+KYA1RAzpJYEWhGowkAp8TUXYE8QJySR6fRw
         CD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790949503; x=1791554303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIpemGrJw1PVM5EBPvH+cvAO3Nha/iyq00o0zMab/No=;
        b=J9IesUcTJW27RczT1VrWDlLbzZcHjx2s6dVtaXo7fxmqIQW6q/yqfD6Q9ZXsR8c0az
         jfD9H4JW9ylmPU3SNrgt4jMeeRUMddJQJhzNmls25UN6UOAbqWgxagsoadbLyqhpwRL6
         DH48l/NLrY/6pQX37vkTsyNCNifCAEtduSzLmJWN+uq9v6b8iq5SHOQZmVsJE9/07JuI
         t7ZmqyNGu5fAmsKHcRbeCCrs5IhapvWmID1DM5eXgMS6Rn5d1NyZ97MtQHx9ENCCAidv
         +YN7qVv9KuTzfQeKTIlg5EEKXESnQK5AyuTZZe42izrM4Q8TcCbrMUHDwdZgUYBpqfkk
         Dbrw==
X-Forwarded-Encrypted: i=1; AKwUvBwmKo6eQDVyCvwlUdQC+j8d1tLxGVq0x5sr/dw2hBqRXD/XfeYzRUsP1CDZ3GAmXEm+9aQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiwM4BDrg1bcohetrjySfVtu2yPOeUoLTtDEVmczZD6B4ZNiVA
	C92q9RxCxYUO7UU5l7SVgtrPtmluR4UHCZxWI77m+ZvdxwpbaFaK+uVlHOvYOaOhF9St1cBoe4b
	L82hrKBMpAIH3Em2KP9kdxaGmEoL+79prJ80r
X-Gm-Gg: AYBFou2m9BlQbpu3Li0PdxjMaFaHyZpsBg9iIpGOlV9gqpFkVeFtAzqV2bcS5nvt0PP
	ifYf8E3xE310irPeU/ck5LX8/x51YvjA5/BLyFrOeC/zuDpaEXu4NWVPhxmimCxEFpTdyYIz5Hv
	ipYxdMl1ei5ob50gE/NGbD+omrLma05PSxoEwOhL75m/icAPwoPvs1kmFa0SrnJBZcBqoZwH5/G
	8see+LrqX6yonHxa33D6LfWeT7/T4wv7M+rkB4X268Sw+qZr00wYF3/Uih7Ugc9ZKxUQ1Z5Bcea
	sSGK4YDusVt2JsrT8XjtF0r1DLM8c7vtSmRdx6CJO//D4eXfPHJDLTM=
X-Received: by 2002:a05:6402:388d:b0:6a7:e514:1d85 with SMTP id
 4fb4d7f45d1cf-6af9e2dbda2mr1980266a12.13.1790949503179; Fri, 02 Oct 2026
 06:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com> <81BD7B8C-6E7E-451A-9D48-49ABD5FA5F68@gmail.com>
In-Reply-To: <81BD7B8C-6E7E-451A-9D48-49ABD5FA5F68@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 2 Oct 2026 15:57:45 +0200
X-Gm-Features: AclHuK86CB4ulrupyf1GuatfOkySHaKrDXl6qhKL5vkP7Te7CZKj3-4PSppPcF8
Message-ID: <CAHwyqnV4KzDvqeSt-t6NUyV8L3pkstdYNP9itNKLS2guQ0yJuQ@mail.gmail.com>
Subject: Re: [PATCH v2] object-name: accept @{p} as short for @{push}
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +test_expect_success '@{p} is short for @{push}' '
> > +    test_config push.default current &&
> > +    test_config branch.topic.pushremote other &&
> > +    resolve topic@{p} refs/remotes/other/topic &&
> > +    resolve topic@{P} refs/remotes/other/topic
> > +'
> > +
>
> I don=E2=80=99t recall offhand if @{U} case-variant is supported, but I w=
onder
> if we might not want to preserve as many single-character shorthands
> as we can, since there are a limited number that are reasonable to
> type.
>
> If upstream already supports different cases, though, symmetry is probabl=
y best.

It surprised me too, but '@{U}' is actually supported already.


Harald

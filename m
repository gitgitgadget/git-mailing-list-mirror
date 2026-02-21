Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE2BA34
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771664820; cv=pass; b=honFWKr2GK2KtjKhqDqlVpl5eCGlfTGkHkqWHnGXz8hztjUTkqAQTr1Qrj3b2fQo/6KWBa7uo0UJhQTH4/S33/iU5hLJtvI2/T3dZpBo0Q3HGWRhuHpCDNap7RUQVpx0JHOUofSs77GUCKZNdDZheWoIknyRyihgsKDuOwGudoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771664820; c=relaxed/simple;
	bh=BP171aR8PiQUtorsRwnwtevISrC46TW0V42uzcNy1qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9PE2cQMf+FRlTrt8RRRVisKYV3oRVA7rYrcUfSRjG2vQoruqeOVw355RgH7xeMrNnQVOdyyVEUOCgKJL2PJNwxmLk4EPIjhmIsunttfrlxFTDOJGIllmhxJNDBeVqOhC10VbeJ6Nt4xuV0p7tYWdWasU02rGNhPV7IF1SrqtG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmX5NljL; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmX5NljL"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5674f3e80edso2659405e0c.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 01:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771664819; cv=none;
        d=google.com; s=arc-20240605;
        b=GibNH4FXJbF0k3chPsqVZmDVn9rZymm38V4s/P0uvOInOLNhjFNLNKQD31iSR5hfBw
         beAqyaIImE9J66FbM3jF4cH7mNP/dg18T8GQmxmD7ewEW/7f3AWdLd4Tiu3iv+wFV2nw
         EVF/5N/VrX2a70ex/wDO5uPM+S+VU2kxzmLtk6xDEasRWJ3S6rXKCc5FP3AOrGqTbkve
         GDYzO6zjn8xTxVIwAI2MvihO9wfjqO8Rmel4VJ53KGZCx61oR6JYVk/UVdsi2qcL45UA
         cE+2b/mF8lsUgSirbHbVwnA0OylsBSrlMcUYx15HjJYCs+nntrCUwVkaE3xSIY8XxGFR
         FIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YlTbzyf0MSIh2JHXOqfjsO8fwqqOYN3BJMhKXC/WC5Y=;
        fh=wMEuQs+GpV4sPE9aqLGoS837e9vPIyS4RJzxckXqt0E=;
        b=azXfKy6WP+LlzeXOVo0w72zcphc8kYpxIkItoe8nqnDQaIL2xiHUb+tx514Y2eO62d
         CXX7jtHz8Hnl4GI/boMXqDARFZ3DsiLmcaxpCzoS3WIOFZMLqcFVVmuPiTz+buDGVHSk
         bMh6ua8t/zVSgqeDDVDPoTIt2YcnBcvvnzS1YGQRFw1tYeFTIjnROiUX0pPekx3VE+mI
         b173R+UAKgd0TME1vsaY26+WiNzOz6Ki4xMbIWcdvrtPN0n2XvuXdJq5/3nrl0nKb400
         m5JxnCD4rFLx/4CLXw+BssBntSMzq8ZSu39tQk2Um9aN7i5Y0DAjZ1JseYB2Y4EKngFV
         TzlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771664819; x=1772269619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlTbzyf0MSIh2JHXOqfjsO8fwqqOYN3BJMhKXC/WC5Y=;
        b=XmX5NljLekl4F9XXdDVHpxdhKqojkrLY2fmCzjMPUKHSmc93DQHVM6YoCFyTwQtINi
         cXnIYa5oaBWVilEiQED4sfmoV939opYC1601umTqGKIm21Zw2L1T2gVRUUyDH79C1JyL
         QbaD0zmmSkoshUwClsDhWL//iyM/de8tsvkqr7cXBM41Uq8eUEgbJtQt2z16C0nAxrHo
         ksX5GM217ewLfBD46yvmmFcQ7Q6nDIEAXSLe4nkeSFkRBdZ2dE2O790O7JcdAVf99NEY
         Ne1SmZ/MhhokDQGv+0dY7lfkTlQCHxPvJkZlTIKfC2UFr6C895C5ZND7XxwcT3KrQEBf
         egZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771664819; x=1772269619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YlTbzyf0MSIh2JHXOqfjsO8fwqqOYN3BJMhKXC/WC5Y=;
        b=Zc7gyeo2mX2ZZuQZf5SVmA6NoWw54CZdLRExZ5DkTS08gqZynMs9ovb5+/oMvvWbJo
         KQ+pUvWY73B6lhhVP37o9iCpYeKorEzQXl+VUZgkMmROqpnLU0iFwWMB0rhQji9PsTyS
         GY+LLXOypqfmxk56GuTrE51k6qQmcahXBbAmhFnlx2e52dG8sa0N/1YLwJIjkWDK2Iw1
         U3Sa49G5icMqNVt1HK9avR6fha8UKL0fjYJ36U1uRRAwLeTyJrH0cRa/CC2u1QsBpNHu
         5bFr4Gyf8G0zr75yzex80vadDLB0UOdqpVxTUM+kKOs+g2gnjwf+D/mb1dba2/YnEFUq
         Qvdw==
X-Gm-Message-State: AOJu0Ywnsg91kMbZPtn6gCAPP1mlDf6z/U63RZz8uzGZwQee0e3m6IrI
	1pzR+xEI9lltQUwc+CXl5BHUBL9F7d5KPieZlLe8X2yRNyiqKVLpDidRrIEz7Dkv10Jshc1xWWS
	U1dLxvyQUoAz5eFtqdMknV62xGF3yDBY=
X-Gm-Gg: AZuq6aKJnfjwMrgxIcfztJYx1im1fNW5UkE0sG9vdlv94U8WFkwjY/L59LO60Wnhw6M
	5cfO016cDj9E0nNXzxTiYl27W9RfGqsyHPIpG6+gc3ACDdlw16CGJi9WnYD7vL0P9Ucix8VgwDH
	sshoPbhjeib5XQ96uzsLMv4/Hf4HJDtNsnv6FpFgf62TmFBLpxY+aGEocD17ANFiuXiR0mtuX/M
	5MLeiYn+rIJbYCzxgX9nwX/6cx8gtV9Z7mlSeAjmPOcCsuUDcHKmMXJK410dJ+M5Wx14Ss456SZ
	nw6EpmDqSkmKp2u+TZeRXg==
X-Received: by 2002:a05:6122:1789:b0:568:8dde:5384 with SMTP id
 71dfb90a1353d-568cdcbe512mr4443022e0c.5.1771664818671; Sat, 21 Feb 2026
 01:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771066252.git.abrahamadekunle50@gmail.com> <xmqqwm07uju7.fsf@gitster.g>
In-Reply-To: <xmqqwm07uju7.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 21 Feb 2026 10:06:59 +0100
X-Gm-Features: AaiRm50Om6RdX7F5h5zPVyc22dWj8k-C6ERJ-fH9AlCrI6kxZ5GloExW00ls56A
Message-ID: <CADYq+fZcR6Mry-j4XFF2d1SAVPtpQ7Hmc-XkYiuQAfDjqgaBgQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] introduce new option `--auto-advance`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 11:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > After after more reviews and deliberations, I have been able to
> > rename the new option name to `--auto-advance`, where the
> > --no-auto-advance implements the feature and does not auto advance
> > while --auto-advance is the default and maintains the current
> > behaviour.
>
> Haven't seen any reviews on this latest round, and I think what we
> have here may be good enough.  Shall we merge it down to 'next'?
> Any comments?
>
Okay.
Thank you Junio, Phillip and everyone for the patience and guidance
in completing this patch series and also the one for my GSoC microproject.
It has been a great learning process.
I appreciate it.
Thanks

Abraham

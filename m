Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FB3812EF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686627; cv=pass; b=ZP0gnNP45YZ6p5+mizLu9OZ9FQDqq/uTVZ1Bqv9zMXJecsqvtAwyePWa874qHKSRFpYromd29zby6WPKoIgSHGDq3GADX3kKJo+mgYDrWVL46QG/p9XuEOKaH4C4aFM8O7U6TtBwudAppe90S3LqJ/cm44w/89Q1pRQYlGEen5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686627; c=relaxed/simple;
	bh=+gWEqjtyTsMXSXK4cU0mB9ciHFRYwQgV3Z4sSToepOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBw0PltZKNplh3Tt8Qbzdvo/qyO274triqXESm7/uPemJ8PPLEo/b59tFTQdibNQp4J6sf8FNsj3pBcGtitM9YKBx6Dk5furp7EN1KJmX9EchQTfulvEx7ZgCpSOac3rE3J3NtIVb8BKk/hg5FiX5Ps48yPOput7LVdIpwMQsXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrSNR+iJ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrSNR+iJ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6957f9ca440so325876a12.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 01:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781686624; cv=none;
        d=google.com; s=arc-20240605;
        b=UMt0JGYAiQqcXO23+Ou/7dNymEa3+dXzKoyZZnYQMC6qxT5+lE9OHp29C3YzMuyGXr
         +7sbtz7Y/6u4HK/1U4PVuLWNbafdC3qYX9nap+BkTY9YkqAOwawHmwuI1BkVfVEyLyaU
         9Id63uXIOuaNg6+SdbMbps94pH34tCh8IANtY98UUwI5hFliagUKXValKsFq1T8F/GmM
         IWGuZRlV2eNHOPzO+16ni1odKqPGGyLHZ2iDArRUUaLDkByg0yvMvD53oSFvzi1J6qjZ
         XdAmUfTp5emEkXHsB8im1fOSAnYvtpuj9+wkvReBmgSU1a4m3jhyEFbvH+puIcr8Xazv
         hxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+gWEqjtyTsMXSXK4cU0mB9ciHFRYwQgV3Z4sSToepOE=;
        fh=yJOfUDRzeAnjpBbvHKJdHsp3X0xGFT8vcGFsGKjYJM0=;
        b=jhSESFPg40LpjArQ0uiOO/Z7YgJTqfvJF1QMFATfHYLkFvtBVqVxSB1iHB8MaEUZME
         0SEW78Qufqq+4d+vAsm/T9UWQ79I0BGo8HZkPuCcyhiERV8DgURxGIvdHEvY3ZQdyiMA
         br7BB9zt5OUpuD2eozTYfPZ5fY4VpzH1IqKG6C6UMp1lo0ffCn5Kilq1zIV8XduHHtGA
         O3baOOCICTa+fLpo1KHVXEvdGOttlsr5Y85tfQBOtDOd7TxiIQOEjf+S77uq81S6a2o7
         hYxua+5cp+qb6N2WTfxpihNfzcZceMQZZoND53BYQ3IbfTBwPsexE/GVhphl20+a8Cyq
         CFaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781686624; x=1782291424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gWEqjtyTsMXSXK4cU0mB9ciHFRYwQgV3Z4sSToepOE=;
        b=qrSNR+iJZ1wFBOR/0MKp3kqaxTnnnKRjjzbIX6iTMLeA/K6vhXiMmxBL/KBB2Fr02R
         jv9vAZ1tvIkm3VkB9tJfjP1RW38ES4TEBJSo2vgIfiuzqGjwzRAyxuqMC3HcC2ufX2gi
         4ESoEyihYewpvKLzUuYXY+M5+XA6d0mRjQo7Mtrcchg33LOjhCEmkD5aRd4wb3iMoW7o
         8OmrVYQjhrHzw8FI/3Yi0bRBnuZUsciQU1JpgEhJKSBnazyPi6J8lWj/a5pWK53hPOu+
         em78Hl19y+6wSxHjLU2ZC70yxlhuKEk69rvnOaj3y94I/SENDgfm4+yPtyxbshK5cNof
         TkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781686624; x=1782291424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gWEqjtyTsMXSXK4cU0mB9ciHFRYwQgV3Z4sSToepOE=;
        b=cl84tQyicuLCKNcPb9dHn2TobqSu03c3EZZ4BsVUBqAl1nQGju/zDhC++D2onohxDg
         Y7jL/SN21Zoqh6PaAdTbhY/HjkcvFp0hg/4FA46JdsK1g4EJii8Yf/FdMB4b48IHec5V
         7ZggZzjiP6moQ7ON1AwvEkb/W9v9UbbE/UfDoCu+ZoSmp03qWet06BuZt9kJUp4wKAi1
         s2aF1MUQs4QRBWE2sVxVz2aoaPtQAUSyttkEEgEkhiYSQ9XAiQgHIe0rnR5cys6cf38P
         IRETFNl35jSrmIroqhJSGV+IphZ4pqTjdMoHUjeaTFYZFmHVfQpAcd5HNtd1cAbv13RW
         dQsA==
X-Forwarded-Encrypted: i=1; AFNElJ/5x1lqIGX8cGyzQlUeCj274sh7thRmf2mpQx89KrIFobzEaMnu76QyPHBT/MDlXgoBcfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkgacbB8nZeC3yvUwpLXTXfr6aBYHLlYPRKFsAltQ4I8JI/5i
	IjGN5CSx/EXU0E4C4AnWeOIW3WEdrTLuCIm4JUh7yJ3/TNREJL2OHP9+TO4ppy/haN8e5QEDaXV
	yy8C7x9aBXPEHHQnyvph2ci+SxMhGRBVlOXUc
X-Gm-Gg: AfdE7ckoZ8pdi4oCQUrnOwiciJawDRHL2yYfGZ9ylm6DlkYowxvDC+zNY4IZmPWEWxL
	9KwsiN4f+mrBk8vUCGFRr7P82jGd1ds7FGK27CeldtDieoSPeV9S0MjN0rUDImldyv+hClk1c7l
	klwJy6LR9PwvX90XjraAu+oaWVSf1uBcs3slDrmLso9iPGkbxgCecmW3vHG0KQfokijlaV1fiDr
	lIKwdvOzksLi+iDIna/I507trECiS3qnt7HuVrS4Vb0T0D1JZ7Z6rKsQ7KdaOrmk4pn1kiN
X-Received: by 2002:a05:6402:43c6:b0:678:f8f4:a7f3 with SMTP id
 4fb4d7f45d1cf-69546c63bf4mr1589716a12.0.1781686623958; Wed, 17 Jun 2026
 01:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
In-Reply-To: <xmqqpl1q2xw5.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 17 Jun 2026 10:56:27 +0200
X-Gm-Features: AVVi8CdPBn50bnKvZ7yp756Drr2-hA70_Hu1q4e6njSc5tJNJuDRrqMnTDYma_4
Message-ID: <CAHwyqnW=rfXhSw+Xa5r148W1cxrXD48vKC=DSTMTCTyx53WcnA@mail.gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the record, I have gotten into ill-fated rebases, and then it
would have been nice to have that message there. Sometimes you realize
after starting that you chose the wrong upstream, etc.


Harald

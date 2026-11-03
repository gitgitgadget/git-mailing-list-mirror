Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745650;
	b=oI+gTrLkGFrML8XDEmaWsrcAdmLn+SMfmkZrB+TiIyMeHuotiU4siKUD7W7A0aP2xq+c
	 k9AoiXCzpPEUGipdL0XDPSscw8a64lNE4JggYwuDzkefiOZJqCtOB0O6PWYN+aDfIGdz0
	 3TvaLaU3J6v3nugltJm8VIpPFxWiIUFBHsPipKdMMfmZ7bvOdQRbS9/l3jJIHfTE3LlKW
	 pM4CZ3s4DDt9iyRKzxo/oHAoVMEAQPTx62dk4OwMcyfaOQNO5WqIptBfjtm4E7EUqb7Rc
	 Waa2M+4564AU/f/iQ1RXOFbKKBNcZyrA6+2r4M9CINmr9LD/6uG9p5Q1kqjXxRCyzqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=rk4Otd7BiX8AmnGx/rD4THrbfbuN0vGymiFp3CDosus=;
	b=DUlWuksZGm1HGkXkpuygvYVa4YIlOsbn2qGZL/r0m/6vn5XNpLT1gjGGR8HVzHfaUReR
	 bDl6UgdYQnCJaCV7rUiQJCM9kuQDYITWW9AvJk2alwwEqIxtiIiJj4MrPdfcJ0kl1f5fr
	 s+MIw1jC44rSSTj9lvHnJriphwwuc0FqGlhKM8uJhxKo12pI/RBV1viwjXe/vG/tFLRCn
	 KSPZCpLPXsfUJAkSvTJ9bmC0TCcbjaD3v8Z9Nv9NEwQrLLSbgNkoyGVbjlkVlJaW/COQJ
	 MaSiv+NINQsVKkxt6eTM2ti70k7RNxLD6osrh/sE7WlCER0Fd6SgKYuSrcEfHfJLl3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KX63weoi;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA8606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 22:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3AA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KX63weoi
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afbd2c386so45572f8f.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 14:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745648; x=1794350448; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rk4Otd7BiX8AmnGx/rD4THrbfbuN0vGymiFp3CDosus=;
        b=KX63weoiib/kvSEsBhTx1ewBSWbr45hdWwuE2HygRIpDNdAiAQ/0tQNuro9dtytaB/
         m0dWbk+Wa32rFbeB8dyVtmNPAx8a0jNW0LlphrK2NlQOJAUCQNve5+mFef1f+4GbWdrl
         XQVWKKeT0OouMuYB8VrDWaLDee6qRToxxhGCwQsSJAX9VjWH5lhQbcylQcVi6DDS8xGK
         4BNkQmLwdjN74c2J0wxSenLNgOGImqnetePql3sn2X7CGGpxxICKjXbwIoVG+SpE1pMB
         6orf/pPXN4zqHV678sM91/enjpo/YmDr2M7C2OjENMW8HynI/GUzmEDLKi+cbks4Ojh7
         8Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745648; x=1794350448;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rk4Otd7BiX8AmnGx/rD4THrbfbuN0vGymiFp3CDosus=;
        b=mRRz5JqF2UyefL3uHELNf+yd0MYMNwMIuHfMZiPv90PtTNGBLycdmrKXftf/pLLJVN
         6s+53PlIecn1PFyjM/3BXu2GVvmEW+c7DdSUv/R9693HZMl2VJtEMqzI/XC5mUtwXWvY
         mY9/KOBz6fg6FR5irpJj4n33XLoun6uNrzbT+wyWGttA+n7BfUkAV4U4wWOhpb0A3j1n
         qVGgost9dZwvo1+95B1GsK/UFtXZ0+4mzIXScNuLEkwYlhdCaQRIfMnV+i/t9eFjSkqA
         fbZzjfDNcrNazeP5hDsmhVgoDxaIx2UgsJEV+fq1miV+6Ti3v+onRT/uybTi5kOti4eR
         mMvw==
X-Gm-Message-State: APuU4Z8UoaeGexiD8WpWodDDL4lNxcCIZ2cCh7zW6IY+PRcQfrEMPDCS
	61c3XJBPDWu8gHNr4l7FmSh1uzozZ6mXoEL6Lu3GyK+dwkp/okIrz/Dj
X-Gm-Gg: AYBFou27YHadw+Hww2daXNJdFRrGy8jwl+0w+AFwceFdea/+Sn23bsjieXMO3AyvwWf
	rMUtysQtZqFo2VlaCq9wPfbUEOHcEHDn8q7rryb6MWWOkZccfEajYrisMyTKWOSkYYxin+J5UQF
	G8Gn2MOa6fQaQr5oKh/vA4OOLyc88TMohRMItfyTWA/YNJVd6v9OUoUB7vNmr9oyOEVApYvA0gj
	PMNDF+RGk9ojakfUgy2NVzHiWKpw6NZUITX5UFmB8mlovJPgCUp4oFKZXhylE2TUjDymlpZMnyq
	HMlGiStkvjP9pZy4qHvZ+a23+5Brtn9bPsT9Iq1h2XZVFOm8xPr3YgSJEjZh1KTr93Qr3WOJkvY
	MWKNlFrkweW8Al3wpbj3MJJbR9N75bvywzIp2DNrpTdahBO07ZZnDYxZ4ldkIfbTdjGi0BpkTUS
	p7n3ehgicGtVYyBkfi4W0WCGv0UdQJx6t8LDmqGpYnGyzRiWTQxfW2rAjEYoq0V9qpHuFrFmizY
	IQRf8+2IXii6RA3Z138XwsVY5mWLGmAKPCa31KRgqnaYNvM8Ch0GVXnqljmJKu39b2pPIxpmuMF
	2y9pEl5IT2bF9wH1jo/RU0E6T8bqXnOx3o4WHPDpW+i9bKjQ1CJaIMSZGHEvoV4EbG5uLZgPKgi
	PeOEmXQWtKQFtVrZiNyKmm09T8xa3gL6xoazNdYtxh7I4NvfdLu5bIGZTVANPfBHwhSliVc/oSY
	roLf/2IK6DwHMzWgxzFyEsHgvYj9b7D55PySz/Bl4PxgbdnvKWyjPglg==
X-Received: by 2002:a05:6000:4013:b0:48e:6264:c388 with SMTP id ffacd0b85a97d-48e6e2ff911mr30688579f8f.23.1793745648078;
        Tue, 03 Nov 2026 14:40:48 -0800 (PST)
Received: from localhost ([2001:818:c665:a700:a4bc:846:cdd6:3f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm423137f8f.14.2026.11.03.14.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:40:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 22:40:45 +0000
Message-Id: <DMLXRHPI0V08.3JFJGR1LRDGXU@gmail.com>
To: "herr.kaste" <herr.kaste@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, "Karthik Nayak" <karthik.188@gmail.com>, "Chandra
 Pratap" <chandrapratap3519@gmail.com>
Subject: Re: log --graph draws an orphaned branch with parents
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com> <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com> <DMLW72EXMN1K.3IXVPHWNYQ3EH@gmail.com> <DMLW93TBSOXK.2OLM5O3HGK1ZY@gmail.com> <CAFzd1+6fiuT1R3B7aK6mN842g5+EiQ4Qt2_GCS1YFMVs+mXFaQ@mail.gmail.com>
In-Reply-To: <CAFzd1+6fiuT1R3B7aK6mN842g5+EiQ4Qt2_GCS1YFMVs+mXFaQ@mail.gmail.com>

On Tue Nov 3, 2026 at 9:51 PM WET, herr.kaste wrote:
> From 48bbcf965dc630251cc32f38d7efca5e6fb77c5e Mon Sep 17 00:00:00 2001
> From: Caspar Duregger <caspar.duregger@gmail.com>
> Date: Tue, 3 Nov 2026 22:38:22 +0100
> Subject: [PATCH] graph: do not indent visual roots with columns to their =
right

Thanks for the patch, but it's wrongly formatted so b4 shazam can't find
it to apply it, could you sned it with git send-email?

Regards,
Pablo


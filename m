Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0A21CC51
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844751; cv=pass; b=O82cw8TXByImUwqyW+IJCCGRRkZMHfQy8/NF7eX4Fvu6mXUPSYO4irEDlsHLjGuKneMLOb5dSVP7+lbC/dmXZ1KiOne2OKA9YJHfP3BqYT4XY+TUNMVnlYDTtddR6xNriinNGMf0NMJ7GyVJhAQkfuGs8QM5+l/tF27mnc0hmjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844751; c=relaxed/simple;
	bh=bGsjTD5SDS0gGwZM0USwKw2LrhGm8AsqdiTzhq5tUL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfMy+wNoezs7dgesbRLWmg3IkzhtO9WkHGR2nxIghXx5ATIWsVzF7etOvSEumZM8Q+g7WJ6uFG190JQBnHY6OsriatBsC3+4/08tEgwork+9W7ODE4a15f2ym0ho13nwLxjyzpeTJ5fY08xTXA6qLppV9iOiIINr5aBxhRcD0Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctTg8GS3; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctTg8GS3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so7144514a12.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782844748; cv=none;
        d=google.com; s=arc-20260327;
        b=BCtHklSvipsT+Rf8gUGVArMrVvkJU4pU6XBrSbdNwbbMOJl/qHuT4QWpRU3PU/g9Tv
         zmJk7OU0l51cNFCoOM6tNaKs6tBAyLrsh58xFKV+Yi6Uu0X7fLccEzZTH8BqMXo0dtn1
         uz3r8XGqCMut09WK1S+T0PraAv43qDnPAx3pUEFZv0tIgP1s36UL5VNQwEjFeNwcbet0
         DUCWTjflr1pSezDyrJh9JVVIfN6Gamuq7Z51IceprP0kxkM1+AIVdNHTSmRgWudrR6Sj
         Ke6ZOkX8T6wXhkyjtxDegPVJnr9N58Sm4TeWZrTHkdbPqqn+6ozTyyw7rq9hGNmSeXJa
         1m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bGsjTD5SDS0gGwZM0USwKw2LrhGm8AsqdiTzhq5tUL4=;
        fh=MWs8DuVxT5ACC6FUT6cxh7/sMLQwck4EBRi5cXQQh4s=;
        b=obVw1z/+S5fOVl04kW5HF0qYfKBKRYTxtr/VonTJ2SBRzfJaUx3fpl/o8hoNcZ1OYl
         dtC6wG/iYsKZf4zJn7jjgIbd/ekTuMaY/Mujl+p4hzJkj0/gW5ilUbCuizApT7eIw5Hj
         /nlWua+nUGOQoKZxLhCNykxfrZhJA60fzMXWSWEXGiW+hHYmpjqxT/8pfIXl/tRuJhhM
         jsy7lfdrj5O30KfQMFUZ7oKGUX2ewzLGnbiQ0H3gtJuE4zTUhm+DKv9VtdQYivrvn4Qs
         GPtaXLwoJHNRniWfxZPCKjOnbFkhBRkPIHoG/FVZdDqxx/9IuGc3SfrxflS75q5RtVqg
         77xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844748; x=1783449548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGsjTD5SDS0gGwZM0USwKw2LrhGm8AsqdiTzhq5tUL4=;
        b=ctTg8GS3uImH4pafFKW1Y8CVnQUqIbKlFKWOkVBo/PnDf4JrrlSGNrQMAM4TixJ+t8
         Beefz0rH0ySNWtPSzV0dsuvYJamwrzyGHASdvo+3ubreIXxmkBl5Y4qpwh7BJbfEpONH
         19dWYVOjJelKWXT0xLZ4VSovuLRutRPp2ry7/RuegAajyxrJ+6kfY54oF6TDs/U1eaf2
         MIrF9sOKZdk3bFCyDo5h0cQ2M7fKPn2GQ3R7HBvmgLXQ2Hn2/eOh229A3GESma1Ibfe3
         ngN9KLWiL+XAL9f7bl1nx2E9ZBoZoRm/60u4IksoJbVOiwQshm8/BuT6IP7AVMzn9Uii
         uB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844748; x=1783449548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGsjTD5SDS0gGwZM0USwKw2LrhGm8AsqdiTzhq5tUL4=;
        b=Le5jd4KbWTY39pLPS2HgZXapTHwVhq+mWgy21UvAcwjUpEeXUsXG1RJrFN8Z2rRYW9
         LYRioRYIWJmjdT8bh4kQRb7TORP3TjvQhVRFl5pNt6P4vB2BcuZ/wo/jhgI5e8jfDcIa
         +S7P2x8MzxLZX5rxvpn0p48rKc/tOdEorh7KaXMMiEhHZKXfsb8GnU2D8u6mTY0kho2q
         kAVaX9LbWxdgD3BdW9h76JXvlLdyLF5QuQuajaIj6GhtVtC68qosNutBPoGGf9dhUlna
         dISRwhf5WhhwoDLSwTzjJjFB+1h3QbUqCIwBKcTJAIMdz0mQzt8g44d6WmIVeuzQQY6X
         0bLQ==
X-Forwarded-Encrypted: i=1; AHgh+Roayvjo9TVLJldSBRqET6O99mDMkIM3FqlT9gZHP0cja1EB5xQR6ecOesFedJAY0oUR1u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1XgfOMw3FGaJmbGo9w/stXMLYAhtYAQ0Vxd5a29VEM7o5Wix
	d0H3DhBMdnD56vhHUEptWe9phdQss7sx1dsorcCyqkyr8c+JiX4TKO/wTLr2P30Bxdl1GGJe65i
	MSEREjs4iQG1Rs9IlhWbv1KtpjGwoharZNklVESw=
X-Gm-Gg: AfdE7cmjkxgQghy+0o/rohfAwb+WsOw5uUmzT8eZodqBGbfClXlnqatBjao81cE1Fx+
	rKVNFULL5SEj7BSkDdcy/izYxCuGpNT7ie0GJGew4/ZUUIM93hBm+XZqVp8TD1y+W0bNyDv6uxv
	89UKHI+SR4pOqgkciotZurKHRyrDAKRljvj8wCVaBgyqAmbYIESdCu4gdVCrb1cNAGM0VSPEdiW
	+o1ZC1pYKJlfenyoIRmNxdhNkKofa7V3aNhOSUXu+k0JNehrgNKk+j9ZzXWbdHjRKceHA+a
X-Received: by 2002:a05:6402:4307:b0:698:3fd4:47da with SMTP id
 4fb4d7f45d1cf-69887891df2mr889798a12.26.1782844748247; Tue, 30 Jun 2026
 11:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im> <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com> <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
 <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
In-Reply-To: <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 30 Jun 2026 20:38:30 +0200
X-Gm-Features: AVVi8CdepHWCcv8vJe9pU8jkMwLA6N_H5gMOja4Fk2BqsBvqc2Xg_sBHpThHeWI
Message-ID: <CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I want to avoid creating drift between this and the format of 'git
rebase -i', so if we want to change this, maybe better to change both
at a later point instead?


Harald

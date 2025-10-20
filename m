Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366A2C21F0
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986259; cv=none; b=SD22ajkD6fjL3umrGQhyK7QSAE6M8XBH1DOUsxewZZmoT+bO6rL/zsFJl14bwZyWFCg6F6pkuMpphSHTlybJBbqJtv+2p3NfCc6bAOmJbrJchcxZz6j0dSJb6EpBu910xyfB/zskSKQrH6llc0ja+NzxhWlx0L8kf+WDFs/s+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986259; c=relaxed/simple;
	bh=6scQaP2s6djnTxwTmy2x9TFtKmvrLffPsbaZdQ6Ul00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DX6cKxDnDxNord9HjHMWYB35UYmZ4j8RUjsOG/Vky4T/ctWeAOe92znm3k96wvxzxP3cFD3q6qHOPPsxNs8pPDH5Dm1lDEauA1cgPlqQx5Vyjq4acM1ZHr2vSzuXHvKk4ataZbfle0ouORZl8qAm1GNe7PGBGHalA0vGtUgSAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZd8uiUt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZd8uiUt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3870288a12.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760986257; x=1761591057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX1p91Prv3v3FyWgYlde0FxTVBp76JSHUmEMZEzrWIw=;
        b=YZd8uiUtofrM/FlwYEpGCVWarV2sLwWtTYRLKJMLj2HwgOC7wHP6bLfWY92siUYSXn
         g+SVRamhTEhZzLSHjvEHhOltrUfvhA+u3SmfYv93RRfaATGBJ9b4rVIbcczsxFtyDpa+
         R46iv0RRlkc5YhScNmkxi5Ep5PfAf+ruTBkRCXvTX0Kg93sSYuOjXz3eDzCO5pERmrfq
         5goJ7CNfjMMi2k7jWOBvXtfCS9SCLpbmtLcXRUlgHE5fsr8gNvNdWCrJcrPUQzJUyL5m
         FvAgM/ZLe8dU7j5CDR2piK+i2TIGeu5XxPH59DgSfqe0MnQ2zRk4D6WqeOlqq7QL9IR7
         7oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986257; x=1761591057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX1p91Prv3v3FyWgYlde0FxTVBp76JSHUmEMZEzrWIw=;
        b=v1v6D9VRPQwDnXloi5FjsmenWSKIQHhET0QlimqcCwC1rmfGO+97+cZM+sdVA8WrTn
         ilHCSCMisomqDz8oLW9Ig25jCaqaEYYOkhJzJ6RkS0QV/AF+C60fJxXX9OLj7U740g5W
         b+wK2aYwsYL0/BvMLeDBLl2gPDrtci9EpfsQ5ixbi1m9tlKCnKLHB1nTNodStO/RUopJ
         +/htYJukklDctHU5ijTPrg9TDDC1Btumju2eO6p55UG9VBH4IjvaAecJfEGi8pGelQAx
         Lq9G3EnHIx/fqAAw+PrnaNbCrVXngsSXsSvGGTU1vmaIBPmd9cL86fOHY9KEcWQcTnE5
         W0QQ==
X-Gm-Message-State: AOJu0YwHlwN9zDXTYX3BVZhX2TjBDMxI+kw/6huzMwHbwW9Giw0RiGnN
	FFMHniGSLjnkNL3DPZ1lGvajg7E/6PMEH7XXbzs3wHGxLPsqhbVqT8XSPFu6O8/c2rUvSYhw/19
	htdQpocpvyw4NAILdFep5kqnOBbmn9Cg=
X-Gm-Gg: ASbGncvcxB0AEEXfP+nFmQvCyBK+nTDEmpU1ARPOvliCjIzYGNnhrz3IRM0gLRTW11u
	wwBv1d/ck1dA1JuXldB+6+3jsEL2EEWxD8mUPOz+3WhM1apwKKhrxdE0E3z8aKB1/PmVG2W4TdE
	cIS53ejmIG2kE1R5CiYHZt1X+dOmAysKFM5t2lsMOiPHeEarTevvzySUB6OSwibvGMy7HmchAL7
	f7uw2I5VFnHnqF1qmit5STEdhmQsq94RSxIz90q46Sh299kh9AWMpDo2fCHLg==
X-Google-Smtp-Source: AGHT+IERjxKb19+MIj9zjeBlnWpWctFSWZ526EwoM3kkaaS3bLTD4BaMBqNg+Kh0XRbf5ZJCZqMOABaw/7p922oczDQ=
X-Received: by 2002:a17:903:248:b0:290:cd73:33f1 with SMTP id
 d9443c01a7336-290cd7334edmr175527155ad.59.1760986256955; Mon, 20 Oct 2025
 11:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <4bd36d2e-7629-41bf-9731-493cf3bd151a@app.fastmail.com> <CAD=f0L_4O9oLxUToLn3QwDopFCnYAKQwBPOXwb+xuPkqXh=p1A@mail.gmail.com>
 <1cdc170b-569d-4874-b1d8-dd645c0545b0@app.fastmail.com>
In-Reply-To: <1cdc170b-569d-4874-b1d8-dd645c0545b0@app.fastmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 19:50:57 +0100
X-Gm-Features: AS18NWBarq57E4IMSPIzA0Q2YpB1aQ2dHxOwvub0HhlM1krpygmNrUr68Z_KKb8
Message-ID: <CAD=f0L-Q2pFDr5RWjEfUwn1SOKU-PVgRebhVKbQ-FFmQR8540w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2025 at 19:37, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
>
> On Mon, Oct 20, 2025, at 20:25, Bello Olamide wrote:
> > On Mon, 20 Oct 2025 at 17:46, Kristoffer Haugsbakk
> > <kristofferhaugsbakk@fastmail.com> wrote:
> >> Signoff should go at the end of the commit message.  You=E2=80=99re sa=
ying that
> >> you are signing off on the changes as well as what was written in the
> >> commit message before that line.  If I later add mine:
> >>
> >>     Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> >>     Signed-off-by: ME
> >>
> >> I would be saying that I am signing off on the changes as well as the
> >> previous lines in the commit message, including that line that you
> >> wrote.
> >
> > Please just to make sure I get you correctly, you are saying the Signof=
f
> > should be the last thing in the commit message.
> >
> > Like I should put it below the other tags so that if you also want to a=
dd yours,
> > It can easily go below mine and it would mean you are signing off on th=
e
> > changes including my own Signoff?
> >
> >>
> >> > Reported-by: Junio Hamano <gitster@pobox.com>
> >> > Helped-by: Christian Couder <christian.couder@gmail.com>
> >> > Helped-by: Junio Hamano <gitster@pobox.com>
> >        It should go below here instead?
>
> Yes, that is my understanding. :)

Okay noted.
Thank you very much Kristoffer

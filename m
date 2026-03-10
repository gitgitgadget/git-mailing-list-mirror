Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3F35839E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176673; cv=pass; b=opzEN3jI1maXCyPOqrbo+QJvJvlaVl2DC96zL18zMvpAsR953VWO9SoInDf5JlEXblLzJDIsiDy5RZSl7YO5XrQjwV2ZPe6CvTrkupTD1g4m7vHT2aXAVfmlmKqJrEdURxaWhb3gBgxS546mMjc9ohfvHcQRwIj0EDhGy1tDwHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176673; c=relaxed/simple;
	bh=Wnzok8t+yTGXsQoBqczlInpNF4QTtKoQXjn6v1jqxWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrJCOfEjKzYbNpnckjnvbAsX+4oLpaWF7RIUVNOyqbp5OvrGblPEZ7xUFjjlLNGTWI7GNW/oa/LpdGqzLLIAWHhXccvci7XYah4b1DVnd7WUcipxxpeCOGCe76FcXszL16I5paraB7f1L47WkXJEiJIlQlC4dDEogYe7NXpkTXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=javGwllN; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="javGwllN"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662c6aca253so2108177a12.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773176668; cv=none;
        d=google.com; s=arc-20240605;
        b=IKPfAEWRmuNotI6Yp1/2UxPjiKE/flu3tywGbEylugQgP23Nv74yYaJULdgrmbWo+C
         ETs6JoaNHJEeF93wYQcKmxrdGlZov/qP7tqSOs6+YAXmA7DNdhd3dnWfaDs8J1qN5nlo
         juf8JptBp8LWe8p/X2GOaobe5wQjdm9O81T3BVL1OiNO96YrzQEiXAP7H+mIm9qX5Z+2
         TyO2BFBGPtI/wnoUukzVCkZwgXHSejHG5aFknIApsp0b3woKie6Ilhhkfeg5PSCxpO6+
         bOHt5Es317kXwkg/siAr5zC8bio5/HiTlM85WWoLFpGGWGj3HRhXM3C5/755YfkIqp/R
         z5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMY1plktygG8CZYA/ogp4cPjkySGGdZ2Ru/WedDshEU=;
        fh=D8LjM0GryWT91YMe6x+BjgHXAho7T5XDfUVf1vySzvw=;
        b=aSP7gPO4IXcYhMgipQFBtxgtPSgfsGuuB294I1MUotRlmttLwvPrSa6ZxQX4dbKu+i
         fIJexNNBD146DS3VJnMl5cS+SKs7IBjqjkwTq9azoQ9LtjV5vWpfHJLzHvxF5GQG7fA9
         IqhkbdDCNUQ3g75OrBKW/lR2NyKhFhjyNOxt5hItDwN1u7H4KQpPJa1dhe+cmEpgSUOQ
         sWXtIXnIL9Ym/VX35ejscRX0YSJaw1nnICbhuDdjP+W0bNKJJpxPhjg/ceHbL3sC0hry
         rE/d9bvt1DJHIp2NihrwEiTiNhLaj609ofrk1WxFwAb+f36cKtVNp6DhB+KMisnCOlx0
         Z2eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1773176668; x=1773781468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMY1plktygG8CZYA/ogp4cPjkySGGdZ2Ru/WedDshEU=;
        b=javGwllNIQ60K4Gi/YU8OgTA0C/CevsE8swgHer0Plaxaa49emcgHWy9YM5Wf0+VJ7
         ZlekJTMx1qDB19CvOr/928m40aQoyASMnAUh0EpbNYuUbs6WgLASnX2jOzwFsB2RR1CO
         0aWV38+3CZ9VVUZ5e2H2I1OuIEQUp5JpA4vbHpdLVcT5Wk7XZblQxqNPC0tFPAQAktHS
         Wwg1fqWQg8zNRkTCqgaguZqN5LPjhDe7RBdQf0oqhXn2XyNGCu79HyAyKQuWos5xKFDa
         98kfot1cDDkDZc//CgcWKR9kGMBgptq9IBE9W8/6I+FOloRnNmKvIbEoCSQjat47bRHp
         tNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773176668; x=1773781468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMY1plktygG8CZYA/ogp4cPjkySGGdZ2Ru/WedDshEU=;
        b=btN+IaWJUCRViFCibVGP6iaEdCeS4jNbA7i0e4Fp/u4NXu+km0QKqgGNkNzw5Sn1rF
         1A+eWZ5NIozucLa5t/owb6gRO7FHEMsvgDXmrxnaZy+UuPtH4XxqnQ5g0/wZ1LVzQga0
         ChD9Q0yF2tiSTsh+2tKYceL64GGB3QVaV37AzMDiNpUGeIvG8wT+qGFwlZuDOZiRezpj
         wtIrnlQ4GYPZ+CHwKMV0WfIk1/231KrNRAJosQ3uI92S0b+ECTcR6wk9iLPMdSx3zbR1
         O7DJk280ysIMj582XbmLhs4bpoAlPJI9WQ8gDUCAsEFAdBmH3vPWtxDIfazJQ8hCXyoM
         nHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMwnnPCdrhAkcoUFlUs84EpZKFT3pEY+t8RYj70rOnHdmJYnn0TnE18TSGyXtpSm1amfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxpp3enrWLAjdYWkQH1iMR+JXrRDWePRUIFaoB18Fu8Eyu1V2y
	f1F884FwDfSADtD9wfMZ3iiao7WSXF7Uo6Wou7ctEnpPF2UJcmYQqwwLrOICxnTTpxsW/dXoOi5
	HQLrjeAWWou65q59RlB91xDFceCD2rF4tsskGjQ4Q
X-Gm-Gg: ATEYQzyVSAfg+d8pIjOTHJ+L8Rk3u/HftuO7KyIpuHhfuHBbpu488aEzMCyhBo+egIJ
	Z9Kaa/+TSN5X0ujv1FD5tT33EHaTtyHtO8/7VB9Z18LCr5wOUoCkdcq4VJCfLlM24K3AwHAczqh
	GoPfbmFVt3VzeRvUb/8pf/SW6q/lrpT/3K1YA6RoDckibzxIpCDU98KlpjW8LfWn3xy9W8mjJ+O
	0mtVTYkMF/bQN2paeNjTpMyjETnJI80SzAl12yfWVCGmfWvxcuwKsrRpJyKfNPV+EQN+QcaEarb
	pU2+GbknaXWuP1O0oOYDOdPtNNQrw+GGQkAnbiCLqL6X4ZHD1MJU4owILqmfw8s5igwAkZwytgW
	Y/UMgDzNYO69rUzXPTw==
X-Received: by 2002:a17:907:96ac:b0:b8e:d1f3:4744 with SMTP id
 a640c23a62f3a-b942e159a99mr818390666b.55.1773176668250; Tue, 10 Mar 2026
 14:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
 <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com> <8bfaa14d44e224c5f8a3cfe1a0c55e9ca9415a98.1770384180.git.gitgitgadget@gmail.com>
 <faf8622b-b960-4f58-add7-28b5e081afb3@app.fastmail.com>
In-Reply-To: <faf8622b-b960-4f58-add7-28b5e081afb3@app.fastmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Tue, 10 Mar 2026 22:04:17 +0100
X-Gm-Features: AaiRm52UZVT7gjz4z0gZ8DKUYvF1zR7T-V2jUdzztyHIOZkZAmBa0dobM3bJRmc
Message-ID: <CA+GP4brEROn5jhmtjW7gwk87hi8T23voyG+LEx-ypwUE0Q5F=w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Documentation: update add --force option +
 ignore=all config
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Brandon Williams <bwilliams.eng@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ..

Thanks .. I will fix both.

Br
Claus Schneider

On Wed, Mar 4, 2026 at 3:02=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Fri, Feb 6, 2026, at 14:23, Claus Schneider(Eficode) via GitGitGadget =
wrote:
> > From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
> >
> > - git-add.adoc: Update the --force documentation for submodule behaviou=
r
> >   to be added even the given configuration ignore=3Dall.
> > - gitmodules.adoc and config/submodule.adoc: The submodule config
> >   ignore=3Dall now need --force in order to update the index.
> >
> > Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> >[snip]
> >       all;; The submodule will never be considered modified (but will
> >           nonetheless show up in the output of status and commit when i=
t has
> > -         been staged).
> > +         been staged). Add `(new commits)` can be overruled using the
> > +         `git add --force <submodule.path>`.
> > +             The setting affects `status`, `update-index`, `diff` and =
`log`(due
>
> This is in `next` but: should be a space: =E2=80=9C`log` (due=E2=80=9D.
>
> > +             to underlaying `diff`).
>
> s/underlaying/underlying/ ?
>
> >
> >       dirty;; All changes to the submodule's work tree will be ignored,=
 only
> >           committed differences between the `HEAD` of the submodule and=
 its
> > --
> > gitgitgadget

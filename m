Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC9283FDD
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856737; cv=pass; b=pZoUDMYqiZ24CZndS0nxMK88dw+9MhtCaLOSo8KpzBHIMxTf+JO0MspXYAsANjKuKmbSk0uwarx8TKgQTtS6qngKt5rw0i6mC6xoRRQQ5wUuv0W38xxAqbfDKI/gO+GpicNi9XS9IfAeFOuX/pd/Ol02tbS5m4ezwF2rryMQefU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856737; c=relaxed/simple;
	bh=CDl4OybUynYFl7NsujGWs8KxerFTIFzABASAc2bXsmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF6ARGvR1ZngZj/4XY5VZiCHtSHmj8+nYJy8ylmvpgnk4yji5IVyGNmtUKtk8IhpdwO1dyb1unZAhkVw2zBRfB77u7USQm2ohosL15yLgG438KTWw9slp57uPjinbUhtnzQPvGpCMkqZZgZBopI9KcJ1HrUR7n/4UHW/D8Rhb+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp04VuiJ; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp04VuiJ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39657d28132so26565261fa.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 11:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856735; cv=none;
        d=google.com; s=arc-20240605;
        b=IZUCb5B8WgP/VBl3CRZVd+/MXgI3AfYTWemvZ/9LLBP4W3a8RPOfNaK64rxyge/u4e
         SIPLgevtKqFAuFhnBqI/OQfZ0DrdBObjg/RAtwoTIVAw7et1xTWJskfmfl1oYldEPccf
         WUwO+aKz7fyW6Hj+Uwa0nTOwzk9b5ToIz64+EG2JCBqliU7stoimWLINSCg1kwg6rLS6
         3Uoa8fmZZ9CohUDZHndTrVoSTYlPGLpl8jracJDJjtBNziMA7/5x1TTb//j5ahceiR5O
         xcemfhnU3pqx7w7GorTlWCZT/ZRBSf9YNrZdiPZlVUh/q3Atksn/uoQG3DbUjHKIZhc5
         GtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5yJWoMyMyTN8emlk9vgJWv/t4Zj4rB/VsRwkuC463J4=;
        fh=1SP2px6+A6w50wzykHi6UtvgdCVkDYKf5xEn4bI4XRU=;
        b=i2WCACF5c8781AeRpomB3KnuYNr/f2i4KfkhC5D4B/uRe3Z8QZ+ltDj4aTRvZF/PgM
         2/eQJaxgwRQuLOM9ep28A+LL9Txt1xmfZPSWZPEOwx15PmfhwB63Y2fMTDgKJED5KhaO
         sTZMr2YYYMh5hT2Aj0rMrzcb1PMgvbty1kDdLf+744yUwo7lK0ctdM9nYrCgqH8P7LmE
         PTO0lUmlKjU8NxI1xCBCpDnRBIuFPA4DtYJlDADqJ056uKHo6BrTDnZ+Z3aZBG7ZLCFP
         K94uz/iFnpav0fqfvPSyCWLEpgT3zb4YjHb2c2RLnQ7XLfidEqzzccpbvy5jFfRs4D2B
         E51g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780856735; x=1781461535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yJWoMyMyTN8emlk9vgJWv/t4Zj4rB/VsRwkuC463J4=;
        b=bp04VuiJzzZlM0hLyLHwLzZgQY8UEQuJuMsotG89tL8Hn5D5vCNxKNffaplq6f68Kr
         fI2c+lMSwp1l+n5nVs77g8cLo5nIr7/8swPDhTJbvOC8cz1p3PnVII82rKxiqS+BdVUv
         ws4dL7zZlzKPaHWIUcTY1mFGvTB9dhCPi0Tpsm1XwwJs7dgyFPIeDpLgSuCwsqyEwASx
         QSCJpxOmfm4NEwawM/JeQVE+1uujucTGsViefBJ8j+jv6g+jgobTAGivxw2YvIrfIcpi
         K9PGmDvrczS1GVFAcsFg0zo7dF4nwPdmM7UInx2XFsfI2lwfPyEgzOk1EZBhQVFhBe06
         7HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780856735; x=1781461535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5yJWoMyMyTN8emlk9vgJWv/t4Zj4rB/VsRwkuC463J4=;
        b=XiyIC4vhoob7XWJwoqTXw7ivMuGx/4Gm8r+aFcQq46ty4rHRDJlueB1+Ubu8v/VMoS
         Lq5gkVnya8Dtm//rT/Z4sh0XuENumeKw72AUWMgolwsw26qtdh0Zz4APJiHUCjMnPMM+
         cS//hkfs0kGv+U8hAjxVTpRuNCMWp3Y4GVyWmI6QsbS1HzLRB9lVMceQIq4Yk540tHbZ
         cQenm7J+u2H3GXWvnQ7fPhcR1y4iRMWVyBFV6NulJW9fueOd+U56FGw2vZnen9SIRUHt
         tgKWWsWz/hi043gRHD8AETUVZshJf0HwbmWVHi5JIU4RLKxupeWh9Wzu7ulhHjWrb+Nm
         MTNw==
X-Gm-Message-State: AOJu0Yx/GHgjGAAeuIxiJUGOlyV9D8WUpRa2BKurLud0HuxdmdPlYD7J
	yxU0/uSGZoqmzVbZyTDNzyRwJJ94AVQF0pGVblGQhbzgjvdXKSOEET3e8YqONAtVuQlI9Xw6sq4
	+TmEQR/OJBIhKBhYpVBU7YkoWIoT1I7w=
X-Gm-Gg: Acq92OGqLvt9znBtWQSh9Tf2hbhvplOa3+4gQT7+RhOKbU3xT9ani8y65OUDX35TFQP
	V+tRgZskKygEO3p8C+FXE4t4opRC1qei7+F4F1doncQH++X/5z7vqwqqziDQajvNE2VKD7mYAY1
	kMd8+PrRnBZN3gr+PkDF3bsrRu3jSVoQc2Xnt8uQ12TyHKP0WVhkzWqRx0GQcLuuU5XOR5MjzCa
	++mnZPg4bbzyGniinGKE8WKHhwDZMvw/RvVa9mgYEk1Vu9TYuruMtaRySFAO8Q5C7jeqFZTEsSf
	Rl4FQ28Br+PLmL9P9UuKU1FCw6e3PxLDy/WjQM5v2aqgiB5R4fHzrPgbiNny5MFmHFONl5BaKS6
	XP+fmtnEkam9wFt0lyeV7T7oY/QH3TA==
X-Received: by 2002:a2e:be2b:0:b0:393:a2ec:da3f with SMTP id
 38308e7fff4ca-396d07d1dbamr33407541fa.4.1780856734501; Sun, 07 Jun 2026
 11:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <8f3bab63-3b37-4492-a39e-95e610a15a07@app.fastmail.com> <CAJ-ks9nXybntsa5FCJVWSQ2u+hzxaMdrfCdL3D+vmzjO4e21kQ@mail.gmail.com>
 <e42fac49-5037-4eac-b4c8-58bc62857ee2@app.fastmail.com>
In-Reply-To: <e42fac49-5037-4eac-b4c8-58bc62857ee2@app.fastmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 7 Jun 2026 14:24:57 -0400
X-Gm-Features: AVVi8CdRxyI0MbLKr2TvPv4vQYsdKYbK_YW_BixlD8Uld52Xwd0jTZhMDfI1U18
Message-ID: <CAJ-ks9ksEujH2Y1VQ6t8i6MW2umS_6ObCTkkTxgu73yMjHDLkg@mail.gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 12:17=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Jun 7, 2026, at 18:07, Tamir Duberstein wrote:
> > On Sun, Jun 7, 2026 at 12:02=E2=80=AFPM Kristoffer Haugsbakk
> > <kristofferhaugsbakk@fastmail.com> wrote:
> >>[snip]
> >>
> >> I have done the same thing in our company repo, crediting <LLM> for
> >> authoring or co-authoring or helping with a specific thing. Using a
> >> =E2=80=9Cpeople=E2=80=9D trailer. But the intent was just to show how =
some LLM was
> >> involved. So I think I am going to switch to the following trailer for
> >> our company repo.
> >>
> >>     LLM: Yes
> >
> > This all sounds reasonable to me. The kernel has started asking for
> > this trailer
> > (https://github.com/torvalds/linux/commit/78d979db6cef557c171d6059cbce0=
6c3db89c7ee)
> > and I saw precedent in Git as recently as last month
> > (https://github.com/git/git/commit/7a094d68a27e321a99c8ab6b700909e50390=
4bd9)
> > so I erred on the side of caution.
> >
> > I am also OK with this trailer being dropped or replaced on apply.
>
> The most important thing to be aware of is =E2=80=9CUse of Artificial
> Intelligence (AI)=E2=80=9D in `Documentation/SubmittingPatches`. :)

Acknowledge, thanks! Will omit the trailer on future submissions.

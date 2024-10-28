Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6E1917D2
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104088; cv=none; b=RARgm4D0buOmGQsr/W6Bh1qmWwUwKxBuFTq2GqzjfxfolXV9ysuLtsFlOcYnD9gaHj8soaTBawKXMPM6svB2ehgBjPPGISp5TRSHOeaipeV8N3E2MY6NnzwYOMrh96sN0Zn8afqwh72xYvJkUS5Jqd7TAmSZQN846wXhxObLIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104088; c=relaxed/simple;
	bh=Sqy343ztIr2eto445POKmV5xkA1CaoFwBsGI3r1YRDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrvILyi6Mkj6dhXdVlrrlOeE2cs+P3F7Wl376nQJmd2eDu72R2bn88GoBU7Jq8zbRqFoqpDVdc7cgUGUTKLf5TTX3wwOQexAiA+IyfI4Fe+mSc6eMatrp6PKDbVGpBIv/iQ4dP5aZIrBJ/T/HOYkiER6bdLs9/JbAJiulZIDY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR9aueCC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR9aueCC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso41455935e9.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730104085; x=1730708885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqy343ztIr2eto445POKmV5xkA1CaoFwBsGI3r1YRDk=;
        b=KR9aueCCJ73kitfJ5xXtEz0d/0cykBi1TLhF72liNtk2SDMcuwQpnoyu+2dPSdqwur
         ay+ZSZLwHDbEmtLSYmQL0vafr48S2WCsI0zvLfacFeN/Swh6w97/pM/fRxIePEhbNdyO
         GGWzN1Q4+UYoia5cTvzSKnhplu/BuzcfqIoNB4F5Vew/VjJ4Z1Hdi/ioecAUCbmSytOW
         U2VmsErzZU3wC4KMSF8xvF3+rCw1OZGgQXBmlUmDVeFGPBgrBBEVTVLwhq7TLtNhxmrK
         dL6E9RF/k8JvwuKRXnhFIRAPhQs81wyjMqWG/bvkZQcrMl+ctURblnzJwegcS8dpgmGQ
         Bhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104085; x=1730708885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqy343ztIr2eto445POKmV5xkA1CaoFwBsGI3r1YRDk=;
        b=EmtRt+CcU2FZByUB4WkwRc4+8soOSAQOHEqTLNAmSXiM0Xi9qX00faqCmSBCF4pgmp
         1jV+/ussBqlp1apfXO8fZbMLk/kgH9tSwkzvhuX9VUq1dPaUgCYn9+3pEa8kDAnSBLaC
         JsZj+Z5V8zB6lIHDCudeS8YG0KEiwA+TsnSK2qN8dVnCLw3QY9vzAXKIjpfd4ZsuLmL7
         aTD4OrI2e0YZJJIGAn0oW3BKA+HTPoGxt6HKV2h0soEfNFF1FPfdDUUbdlF4/0uSYRf3
         txs7G8boIBwrnjsoqHd0Yb7g0VMcfziht7SW6L7io2YctEKGMSych4qB3hXWi+rzCZhS
         TCyA==
X-Gm-Message-State: AOJu0YxmNY6PFJ0XwV5btRcA9otABS+EkmufzgwJ/5rL+6Gs18KhbjyR
	v3H3IyO3wDCPykMqR75Q8rybsKGdCrrJiTzeTt2GC1eNpoNvsZtDr/OtykBQAqoMK4rYImOyYIo
	4CpZHz358y2+lyqluum7MoAtyIzxLolxg7wuFJwo+
X-Google-Smtp-Source: AGHT+IGw7Pja71AwVC4une1o9m7XQmUm03oTstxa8JHuzlaOoIgTI7h/T5hlDHuKFa3Yb/iwF67nGMabRMXgccTtNZY=
X-Received: by 2002:a05:600c:1d8c:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-4319ac94a2emr62337865e9.8.1730104084811; Mon, 28 Oct 2024
 01:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
 <ZxttGFtt5nnc7g9Z@pks.im> <CADYq+fZeTDnpsvBenLV6GHz5vBRW0nwcmWqQ4kvpNd5LocPRow@mail.gmail.com>
 <CADYq+faOBCRMS3GiQMuACJ2pLdirnODJBxuJTsR=2QPPpzwo2A@mail.gmail.com> <Zx8mqmzN2d3pU0zC@pks.im>
In-Reply-To: <Zx8mqmzN2d3pU0zC@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 28 Oct 2024 08:27:55 +0000
Message-ID: <CADYq+faGcH4KRDm_n91vA1zdD8V3i=sfXXr4pOFKuN+Z9YiL0Q@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar testing framwork
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 25, 2024 at 07:56:05PM +0100, Samuel Abraham wrote:
> > Hello Git Community,
> >
> > I hope this mail finds you well.
> >
> > I am Abraham Samuel, participating in the Outreachy internship program
> > and I write to express my delight, enthusiasm and interest in working
> > on the project =E2=80=9CConvert unit test to use the Clar testing frame=
work=E2=80=9D.
> >
> > My first exposure to Git started with the book =E2=80=9CLearn Enough Gi=
t to Be
> > Dangerous=E2=80=9D which taught me the basics of using Git for version =
control
> > and collaborations and I felt truly dangerous :-).
> >
> >
> > I am passionate about FOSS and now that I am presented with the
> > opportunity to contribute to Git, It is indeed a great opportunity to
> > understand what happens under the hood and I have never been happier.
>
> Thanks, this version reads good to me overall. Please don't forget to
> enter all of this online with Outreachy if you haven't already done so
> :)
>
> Patrick

Thank you Patrick, I will like to add that while I have submitted a
proposal for the second project
however, this will be my preferred option.

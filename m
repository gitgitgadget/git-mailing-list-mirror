Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E527CB0A
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100433; cv=none; b=XTDRKxxcUpZCbGchrUCXuBPhhaloD6dtTn8Mu0UbTId8g1oRcQIdjlIVxDDEg/3+9CHCL7sJhsLyrTHFkGfBpSXxeqqzOAzqCkslyct9OHu6tzpsMlLdc0pZDZw4QtZXJfTAiGeeMPrGjDDlMPr0bFmhpfAfrPzeE5LrH6+/pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100433; c=relaxed/simple;
	bh=aPuGIqupFJsWZ8rZ1Z+Z5VxR8QJ4WE1dZHLqrWV697Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5mldAnCafIyOtlsNw1MEhS5S6mRNdU8qyErfqIzh7aQ/qqNGPLbnxpO2vYTe8DAdRDZoo0vUGdfQsENx51Xg1x35Psv6hgLJTcqmuLczqrRWdXPvaiX1L5g09pU9OU0T1Y/pla3J/Unp6ER9/L2e4b9icQp+wT3SS+FldbMHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYBiv6Eb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYBiv6Eb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c2f335681so946009a91.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766100431; x=1766705231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPuGIqupFJsWZ8rZ1Z+Z5VxR8QJ4WE1dZHLqrWV697Y=;
        b=IYBiv6Eb02NIyPvN/M/1mPjEpNvM8vnH4BRj+SdjJLRB6IrLB3B/lGq+9Qao5u8m0+
         7ZjEnfQT7+48nSmFhA+A3OwCNb/yDrz1FzA7Wj8wuTVdGMGijSoRTZXNwl5Iu6Nt424s
         +7jCpwdPFJ2hboj1i+/Q78kByhbbpWXkiWXoHaRAdUwwbLrjgHqIxUQCvtaCAIajr9pt
         Dpg+EoPdY91RDPqfCHkw6+Wb77zGJNixn0feRgk5/KKFfUtMp5y/sUAu22PNkFYyK1pH
         kml5M2iq2D6TKCIlkdgkxZbVzj5kWtLjTC+LldPTkYSuDXXqwB8nt7u+KrRauqklpvIF
         z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766100431; x=1766705231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPuGIqupFJsWZ8rZ1Z+Z5VxR8QJ4WE1dZHLqrWV697Y=;
        b=uGyF5ZmIOCQZwMEdhU/IQScy0UqbyjbZpzAQXc12/ynBNzwdUZWROihas+Eyj3DQXp
         f6Vq8T9hxfRo2xDYy2kAX7rjvaDpMFDDrS0aw8xvW6IbQBYcZjzSOJ7CVHflTgbdiB4N
         HpHgCd/EJYYuKg0XekWSsC8Iu8LH9G9mkDcojVEWeFOLG+FwKpx+h8iP2ZJS+aAOpwLw
         mKtZDUUtCpv9yvw7tdTQaoBXdDTCbJFtnzWckfC/1OME0EmTRWm7rUFGNs9asxOD5th7
         wUhJ2wqCjSuQEjiLzQtHBNtBlTr16EEAB2YbVBPJiqLiuVNwe3FkK7AG/wu1RylW7u2a
         8scw==
X-Forwarded-Encrypted: i=1; AJvYcCWNzA5bXpKEf2MDE/lfEp6vi040Y3qzZKGUgc3trBWXpn27m1UpUKcCxBAJe7m+xt3yPtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHU5u341dycI8t5tP3t4N7Pu3EKJVcDwkZcrN/9xdzE7QMxXj
	z2uvpKqQWLmAjz3YvpfWP2SyNIh6Nwk8vpWUep2kaIDqgvGDhzdGWFkCjGDXqF9IgEDQVUOjqjf
	3hfZQg3l12GZNArlut9QJWMHpVi7U0n8=
X-Gm-Gg: AY/fxX7FPsZCQvfGwFuFf/uJMgq6tSTcrey22+YTfV5oowHyyk5bAn3sCGEBDLsg8Mw
	gUxD0wYog/1yWjKpcfYXh9DxIsieskPIbueb+kcq49W60q8AO80MCB+7FrD3Ndcb1AXu9nuxS3v
	cXsYCobA2pEKuRmxliU6C6oiK1v0SE2R+PMBvhrS7bP2madYOPqlbPTcIieEUrM2KYFMTqjmvwf
	6Ss/TLmwjpb+wj8Dkeb9v/37zuNe5VldDlFrN8nYwJplIiK5gjjBPPasaH7zUPfGqXf2HZToR3T
	w6/Gay4=
X-Google-Smtp-Source: AGHT+IFMjKFY/Oww1OKfx4TIDt1Re9I3HYYCOyq0h9+wyBAQlL8coH92/YVuvD1xA6f18ZmxhOQ3cM56kK5jr08D3KE=
X-Received: by 2002:a17:90b:3d4b:b0:34c:97ea:e4d with SMTP id
 98e67ed59e1d1-34e921df30cmr690888a91.28.1766100430912; Thu, 18 Dec 2025
 15:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUApKxjYHMPHNIac@pks.im> <69EAE286-A7E8-43CE-A503-FAC707541244@gmail.com>
 <aUOl5h-13jMOPJhD@pks.im>
In-Reply-To: <aUOl5h-13jMOPJhD@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Dec 2025 18:26:59 -0500
X-Gm-Features: AQt7F2pHl3fyepWiH_VbLdWVfezA9e1IIDZx7J6Zsl1gOJxsbq42LXvwomtnT5Y
Message-ID: <CALnO6CDhe+MLK9-fvk1USZ5+8bpgHUmwLrZR7m3_SsvYPwTVLw@mail.gmail.com>
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Git <git@vger.kernel.org>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Dec 17, 2025 at 09:56:02PM -0500, Ben Knoble wrote:
> >
> > > Le 15 d=C3=A9c. 2025 =C3=A0 10:28, Patrick Steinhardt <ps@pks.im> a =
=C3=A9crit :
[snip]
> > > Ah, indeed. Would one of you want to turn this into a patch?
> > >
> > > Thanks for the report!
> > >
> > > Patrick
> >
> > Work is ugly this week. I hope to send a patch this weekend.
>
> Thanks! Let me know in case you don't get to it and I'll be happy to
> send a patch myself.
>
> Patrick

Should come in as
<a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@=
gmail.com>

--=20
D. Ben Knoble

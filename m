Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C35405D4
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603350; cv=none; b=ELqOREzqAyjPqMu1SIcn7uzK8vy60a/AeWWXeSPGiKcb8/R+i3xwLR9hTBTF3TbveT1tjvBB7PHX/ryKZYLIrTUHmQni5BNJOxowMM7bq5nsT9Pb3oZsZRkxXhbDZ/eBANvDBU5HDx8BOD/Nmv1HfoXc3QqelTKGfISDpG5mNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603350; c=relaxed/simple;
	bh=SH13dqbrTjUav6swfCXBWGBtLydk9ckaYNLTbUjrSPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g457ZkSAH9mcU79C0+2XPj9axvU2Thdc+20jk3k7tJWPP6haPHIgzTRZI7WQht0byGmdl81bSujZ9pVnutvB7iAZduWvuIUBNjpQsGWvMDUzk3YY7iwFs1DNFCo8af7a8qvmzTkxjD+f/ijIJBfjJBYr59l6w7nK5RyBs6FWN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8oT76Zd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8oT76Zd"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e82664d53so593824766b.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708603347; x=1709208147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH13dqbrTjUav6swfCXBWGBtLydk9ckaYNLTbUjrSPk=;
        b=m8oT76Zdr+gfdgCOpAZyyqP4T13+DXBYYo15afZwFOyNkInD5QaI1FugG186z8eL2x
         YlbD2U1P9DNjPv5D5UzpnljlCI/FCrnQPVg6r9AzZuac+E0JN4YWrhGY2uobQi4wQRDc
         k1ecKPw021+FudPI8dTzMfkEN6NAAndxKptaaXBAYeNNiWWL9TaCSPUUGh9DZIsWYrPS
         EdZytiufu3ARwdYwZlUzWa61FtUdLrLFzC225ky2NoZKeaNqs2lAQ5pa4ng3LzR4YWlN
         W6PBJB1BSC6DVCANL51BYUD6SEqeSZJSjN6lm+u5CJzCwAEJk+Cpj7yRmIdbolBhuxc5
         daAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708603347; x=1709208147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH13dqbrTjUav6swfCXBWGBtLydk9ckaYNLTbUjrSPk=;
        b=RPVhPh2V/cG//9e1V/a3Cfw9qIvjqtxQ8+VG9sUAavy4aFKK04wDJwB0kLIFVKQbv9
         DZSZt2oT//vZuJVS6eugn828C0ms0nTuhymrWL4Og9LabBDY6DK5vl1wP/LEa9xhZ2J1
         7MxAxOY772TKbnHYFqi9KGaiLjFS6FzvdUW92/qPY6ZPWGIuaRgRVyySAklDLHcd3oM3
         9pdpfqWGZM/OecQT2vILnhyKWO8fGVm4sr122Fgd/w/ERSO+fyNgZOMR4byDAhvYOP1r
         RMN7K1CwJzDK9L5Hb3zXFJKh3YLqMS3edGyekmcPRqJ/iXaY3Sq01p1k9zXI+4U6mtD/
         OeUw==
X-Forwarded-Encrypted: i=1; AJvYcCUB/4+MgoP6tFkqm0aOyJ+TGgNPzbFUutP90ypsX/2vtQ7dsUr55kCail/ClEjOtXfDeJdFsb5Dh4nChhOkf2W2HkaA
X-Gm-Message-State: AOJu0YynOd/RJXXBSGtU4ViKO8zuKvFLWshw8Y7ksLnx8VXC1d2VJK7f
	Alyfx2z8iLcAG29OfYutMKN4WGNUMm78d69MoAFJqqAW6IWCObbKUOpjMUeGXyprSt7opIqxnvK
	DXhTkB47R+jYdCIghRrCgiYDGvAw=
X-Google-Smtp-Source: AGHT+IGN2VkRhfBXfhUs29lBsqLE9z2GjnCTtF/StWCg+yjjmtOjESvrluWJM7daDTmd3foYVwuVisVADQg9BdlpVzU=
X-Received: by 2002:a17:906:b0d1:b0:a3d:4ed8:f5bf with SMTP id
 bk17-20020a170906b0d100b00a3d4ed8f5bfmr15763636ejb.2.1708603347347; Thu, 22
 Feb 2024 04:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
 <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com> <Zdb8lnUSurutauRa@tanuki> <CAOLa=ZSq-X7s2XwFAEu2umrQ5z2fsa=X2ai4EaU5ufyoacncVQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZSq-X7s2XwFAEu2umrQ5z2fsa=X2ai4EaU5ufyoacncVQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 22 Feb 2024 13:02:14 +0100
Message-ID: <CAP8UFD2_K-7TfMYSYh0xunWQcfA5bj1MiXSx-6HRGNE8MzjncA@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:57=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> On Thu, Feb 22, 2024 at 8:49=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > On Thu, Feb 22, 2024 at 10:01:54AM +0530, Kaartic Sivaraam wrote:
> > > [1]:
> > > https://summerofcode.withgoogle.com/organizations/git/programs/2024/t=
imeline
> > >
> > > [2]: https://summerofcode.withgoogle.com/programs/2024/organizations/=
git
> >
> > I can access the second link, but the first one is broken for me. First
> > it claimed that my Google account wasn't connected to GSoC, and after a
> > reload it stays blank now.
> >
>
> Both links seem to be working now for me.

Both links are working for me too.

Thanks!

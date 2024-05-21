Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BD17997
	for <git@vger.kernel.org>; Tue, 21 May 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308332; cv=none; b=Aa4H4m8bUqCBqDHYe5bo9CI7XtV4NORZHSmb0s+PYp0hgQ05zvrLyMV6LxDQyWUEcHndWLvawSPlecJmcHQwUpPqc0VOPVk0FlxsBvU0X2KMVmMhvOUtCOk4XTLKtL1LC8sTyZ3M5+mJlsdVJswk3woj4qfmB8Za1oKo/ti33LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308332; c=relaxed/simple;
	bh=ZWMUBB9AUMt9DJypjI3zMQdKNBcOWsW7jn+tzwazpy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBsnIE2ylToxPlku5wsTlUTXCiWOMgBeMrx+nw/KYDT+BLXnmu/Ov+61nMRuV0NqNRR4vu2rnSCc7UasNu/kCaPFRl/UqXtKhwXHry0XzH88NBsFJbwSVUyapyf6xdXuMR+78O6Nio6969T/1iT6ZTHL9PFTpd/BqUPgIWW3bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b514d3cf4so2526136d6.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 09:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716308329; x=1716913129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWMUBB9AUMt9DJypjI3zMQdKNBcOWsW7jn+tzwazpy4=;
        b=b9fElxQMTBwCWu08STwRyUgudSKRHa0mEU0ay3soEIuk5FNM3gASUBc82XVGjEfB2T
         +k6W2gKQnxzFKiJVpWdksafg9CM5kTsKxOMxJdNrWPkVM9r5C/GI+vWeXt0QmuEp6wuV
         FY8ajXT0pPxlYg4/c7KyGr6fpP6OZfkouUI6fAGKFGBSeKeNRqYjbuDqP6SBSl42aedL
         ix7/+T7Ry5IPUwnsBJI/WIfzwF2Z8J0dgsiq0qTdcJJ12WWSxNGdtlmtrtdbPZ90Xew/
         UrKO0FWsFeu58XDFgSNPtGbvOl5v7ZHuNJBwEANR83p+UrftcBH6tAnVctYxbnn0Kwwd
         YpPg==
X-Forwarded-Encrypted: i=1; AJvYcCX/swQbr8BQHtC0R133MfErD5tIBO6vc2EDmJrkEzgbv6hkmiWHRS+n1i1sZbeCbdhe2fxFXHpDXTm5LOa7eHSbNDIK
X-Gm-Message-State: AOJu0YxaFRlS3xAuzmOhhRmmYexximJXrCXu5Seg8iORsV/RrgQswxSL
	+c7TTRozZS1u6CmvMsN1JtJnlHQLcbaeBwS8plH4aCilNMReAo1zjZEkHqXVa51ZCeRvLLAEf4l
	wsmesTZ1OdwDWkrpm8/eTom0PoiM=
X-Google-Smtp-Source: AGHT+IG3V5NBmzFigQgQ7e2Y3y3f8U7oRcd955m9edFQ2vDAawKVHICATtjPn81gTWQoW03g+piAE+vWA+TN48lhF9o=
X-Received: by 2002:a05:6214:4a86:b0:6a9:8f2:74d6 with SMTP id
 6a1803df08f44-6a908f276a5mr96598656d6.28.1716308329573; Tue, 21 May 2024
 09:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net> <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
 <CAPig+cQYJL+6J9PJX-vrNRXJ4TUCJCQRDQstUnPf4OOwOVCUnw@mail.gmail.com>
 <b3bef1539c4f81780b5f705e55b12898cb084254.camel@physik.fu-berlin.de> <6861baa7663cc6cb78bb2e0be664c07530d179ab.camel@physik.fu-berlin.de>
In-Reply-To: <6861baa7663cc6cb78bb2e0be664c07530d179ab.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 21 May 2024 12:18:16 -0400
Message-ID: <CAPig+cTfHktPySO3rHikhOUwH0WW00PN99HLpNJWs9i2_TN7vg@mail.gmail.com>
Subject: Re: [PATCH 0/3] improve chainlint.pl CPU count computation
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Michael Cree <mcree@orcon.net.nz>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:28=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2024-05-20 at 21:23 +0200, John Paul Adrian Glaubitz wrote:
> > On Mon, 2024-05-20 at 15:19 -0400, Eric Sunshine wrote:
> > > Thanks for testing. Were you able to check whether it fixes CPU count
> > > detection on Alpha, as well?
> >
> > I can test on Alpha, but that will take a little longer as I don't have
> > my setup ready. Will try to report back by tomorrow.
>
> I have tested it now on single-core Alpha and it works as expected, so I
> think it's safe to land the patches.

Thank you for testing.

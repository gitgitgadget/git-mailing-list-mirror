Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166516F288
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569222; cv=none; b=jI4yXem1nf5+MV23K1+6poUvMy68bUGX5pmsWTWI+ddRuHOwiaZoNBbNSSZD3zjJI6a5SZ8FfFguXlz5DvO4UZyoQsKzuNb7WNvyE1IGsZcFBZcrAFDGBEUK6Z40CJ5ynWLwT+PBBIeUNwbF5V8Fjh9uBb1myJbY6UmH5h/BZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569222; c=relaxed/simple;
	bh=l8uPr57TyTTCnT+AZ68vvCW5rPJRnJZAd9oMzit69Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHpiHTKZCs66swYLDuFhk8uSOs/ziSvuGLIoXQKg5BWfGBLy6ApTwsaRDkPLAES83HT0k1lAsfbL14Fc1b+bwyQfIP7/rO9tCEQpIvSNlyBsU/utAopS5xFaPpoZphVJManxebenpfmmUDUelropNzssNvA7otYTy6r9IQ2Jd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddUgDJJi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddUgDJJi"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f8f2d6c2so39375021fa.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569219; x=1756174019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8uPr57TyTTCnT+AZ68vvCW5rPJRnJZAd9oMzit69Tg=;
        b=ddUgDJJi++5t8rkhdbPyG0Q5GnZvsrvk+UL6R5gQN4pDtkBf7dr4B//WEsXopRoXhy
         vS7kWagGJQVs5KmHWftOELGrditBIa7VDT9RPXi5YHmNj7Pq7pgIe+HZBpD7szQ3wfxb
         LX63uyRJW86V/Dy93IwprexgnKyRBQmsAE02aV6CsZNuzDB3bx5+XhLgKYXNhXvsaR1N
         N8bp3lWs9wlKLHDeIiDZi53YvSuITDw8NMj61i6BndCQq6cd4Rqz/FyvtbKJfUEqN76g
         9ty7lz717VlZNoJtyn9qsP5eMwHK9s9Z9EXWICzBHGRsBd8MC9DmB2jIzcfbox8dWdRM
         SNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569219; x=1756174019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8uPr57TyTTCnT+AZ68vvCW5rPJRnJZAd9oMzit69Tg=;
        b=NOARy9enZXfXkErINx8uBlCph3hp3HDngSGuFXvbQqQ9fn6fVHXcYaXfoVmXFFwVnf
         euEQaJfEpOHDHwWbHIWh4u+n4un3SvNxGjORdIImITM6xWwtUDHwhFEJuj3OkgWDLudb
         OVBz6Sdnsubq9j+V2yA+bLuv/3XJnGiUvq+eOgUbK9bfhn1qb2I6hW8inEy151DK5JfX
         S3nN3Z4ql+HHv8SVagBxTx9upkkXneMcKGLXykfzTCxq/kwXdovOSG/Gtd8uVlaNj1Qp
         xAB3XR8C6OnbDaLoYFX8n48P5gQw6WuH99o0zDC2B7owkz9/4cqPgVN0L6M5FtQKAXdC
         yXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVgEw13YUaNnjQidillwih1ivQU46tZDdT6Xh1WotCgIoPk4yMq73oPwoqFV8cc05/wZRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/Tg1jNvLx0rLjbhey04EkKAN3Xnzf/38XetLuSoNVqumR7dI
	Qug0geZgbkE+4h+ZJAEN7GOkjjRA9VW4A+55rYKNRkZoK1FWo5SwgwPBdbQUD1Qx98QZJNd1xka
	hVL8hPwWPYe3VWIuwHfs1FkDsWK24AcQ=
X-Gm-Gg: ASbGncsuxx4bCDz2hBo0rqlEDNZPyVvHbRkA2Ul98G4dqnhg0MGBCJz+l11BIVERrkF
	teSxbxpfAgj3O8eM+LjB9woQSt1CI1k9NuDv0H/2htapJd8nK05jzMT8jciM+VUo8/9c2rd0Knv
	MawGFZHqnPcPB4kcM+56evQOwePHLNoe+rsThVN+TuZFSh5GEBhOPmJjJ6h2YURX5HjvRT9UNjC
	drURVOz
X-Google-Smtp-Source: AGHT+IGJ6wlhOSp+IpXK75DxLO3lMxt7tiRGzhGELr5AS/RZTBWIl8yrDbQYmDGR59WhH81rGa3KEFyryqGsJXlCpdU=
X-Received: by 2002:a2e:a98b:0:b0:332:1720:2eb3 with SMTP id
 38308e7fff4ca-3353029f7d1mr1829401fa.0.1755569218633; Mon, 18 Aug 2025
 19:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com>
 <DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 18 Aug 2025 20:06:47 -0600
X-Gm-Features: Ac12FXywx7HY29C5mSXLwDVtAITqeszUQHMHB-fzzDj1yffQjo-Au5QwpGivJeE
Message-ID: <CAH=ZcbBmFGt3hVoPe2NSp=4Ew+kFF0-PWFQFey0fXhYBXB6Yrw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] doc: add a policy for using Rust
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Cc: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:03=E2=80=AFAM Matthias A=C3=9Fhauer <mha1993@liv=
e.de> wrote:
>
>> +* Supports Rust and the toolchain version specified in link:rust-suppor=
t.txt[].
>
> s/rust-support.txt/rust-support.adoc/

Thanks for spotting that, I'll fix it up.

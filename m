Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337562E3F7
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453454; cv=none; b=Q9lp5x+FYxYEvBnYgJMTtFJQ6rYqdUZAcQIt/9VbKDF9+EDyquflIoifC0er+t6P+vsX3ShCbk0rXQxnsskAtnWTJW9o0ZM+09aYCfXVa1wqIEJtwVT+4gg5cr6DRoa/rmIxxWEVi9/KBjX+iqKit09F2WZsKYMqkg1q556C4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453454; c=relaxed/simple;
	bh=rc/xait9sWO1NSGLAiIsa77QOXTqebclkCuNtzoBn50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCUklNCZbpcH4NPkj/urmBJNcTVaFlO5IefW/1Zf7iil9Qb/D+6ZXA9gyiAryi4/4SB0V/3sLG+tvMAGSiDeUWime+qRa6SX0gwqMYRLCD1e5vU2U5RGIerTVDgwwOEZmGTeflQK766UEAq7IN7fdL6BRuHrUkszm/DEY8RanEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bba6ced3d4so20727726d6.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453451; x=1724058251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv3qdHeIXw7wSj7C1mLrZjjTlos8XtNwyjo5ldt4TTo=;
        b=C2wZozFVripVz3UDcC+TbiljOJh89cWw3MDRzGNCGwUXtaRNHPPzl5VA4lKjuPYZ1T
         juHnCshVd04fLJcfgG1bayIxTPbm55KMwlZQ1oX00W5PypninxB2Tly60+ukoXrtl5HI
         na5EltuZWK3GnOpvLpYl+JvIE6btEw/vU4JhOZSC3OhndM2TXbt778vnUvC+4I+pnde7
         +u6rJjJLCMIPUETX5P+iP7TPeD4XyZ6Mg0k0m+V5RoyviUKb7FMJoN2hEKKaM7WhqbR7
         of00fgRDwnktxvhVJXj6oFWL+TY3fA90gK7GvRRaB+LXnGqvPFIVw2doRXNhCN3vQpdC
         c9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRgSuVSB91Q/M/WI1BcTgiErSEJ/RQ6pXWDNhYu56dXa53WLgwIM3oCFRmKg4zA3k5jRQJ59j5WQbN6lPG8XlcGPHG
X-Gm-Message-State: AOJu0YyyDxLDkI+5gdotIDp4xLCdAWdl3pOsweIG0cDYyy/fcvBHP6aW
	c4eRvHQ5gRXn+q7cGtuymwzBeXEvRBQXojfOrB5Ypb6V0XkzvrQpYQEHThDmt2mvC8/BE/L4lAt
	ynDUL1aM2mwRXsPTbtwYhSv7nJk8=
X-Google-Smtp-Source: AGHT+IGWVYQQw9MsISxyoPCabEDCyw/ZNymX2zjZOzkdO8M3UbNXgGZ2YEUdH3rLRfqXSephnzu2RdHVcQ0q1caxpyE=
X-Received: by 2002:a0c:f303:0:b0:6bd:9622:4972 with SMTP id
 6a1803df08f44-6bd96227231mr20617036d6.14.1723453450969; Mon, 12 Aug 2024
 02:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com> <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com> <xmqq5xs688cz.fsf@gitster.g>
In-Reply-To: <xmqq5xs688cz.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 12 Aug 2024 05:03:57 -0400
Message-ID: <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> The original iteration had this:
>
>     * bikeshedding on the name (yes, really). There is an active, unrelat=
ed
>       CGit project [4] that we only recently became aware of. We original=
ly
>       took the name "cgit" because at $DAYJOB we sometimes refer to git.g=
it
>       as "cgit" to distinguish it from jgit [5].

A tangent: Speaking of external/other projects, I don't think we've
seen an explanation yet as to why this Rust wrapper is proposed as a
`contrib/` item of Git itself, as opposed to being a separate project.

I can only think of two possible reasons why they might want it in the
Git project itself...

(1) Easier access to the library portions of Git ("libgit") since that
portion of the code is not otherwise published as a standalone
library. However, a workable alternative would be for the Rust wrapper
to carry its own "vendored"[1] copy of Git. This would also ensure
more reliable builds since they wouldn't have to worry about the
"libgit" API changing from under them, and can adjust for "libgit" API
changes when they manually pull in a new vendored copy. Hence, I'm not
convinced that this is a valid reason to carry the Rust wrapper in
Git.

(2) Perhaps the intention is that this Rust wrapper work will allow
Rust to be used within Git itself[3]? If that's the case, then
`contrib/` seems the wrong resting place for this code.

On the other hand, as a standalone project, a big benefit is that the
Rust wrapper could have its own release cadence distinct from Git,
which would likely be very beneficial since it is such a young
(indeed, nascent) library; it is likely that the maintainers will want
to release early and often at this stage.

[1]: Other Rust projects carry vendored copies of projects upon which
they rely. For instance, the "native_tls" crate has a vendored copy of
OpenSSL[2].

[2]: https://docs.rs/native-tls/latest/native_tls/#cargo-features

[3]: https://lore.kernel.org/git/CABPp-BFWsWCGogqQ=3DhaMsS4OhOdSwc3frcAxa6s=
oQR5ORTceOA@mail.gmail.com/

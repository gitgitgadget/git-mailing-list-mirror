Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AB188907
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701867; cv=none; b=C0zVkBOQ05FUTQE1tdbgGRynyvQEWujlBB5PotdO6+rgO3/LY3jnRFeI8cmLntbaHSmsYRxiVnzw6cK+l3pJcYTuiml4K2KJDtDFCL9rtSgIaNIfvHjbZfz60LBtToUZ/5X4/qJh0cf/beuaox6uREvCKLYES1ssF8RblwAb3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701867; c=relaxed/simple;
	bh=V78r09Zw5p0V+kBs27gv8AYvGLlXU82ZepA/RfIN+6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aMxgGXRxqY11Gngmwkm4dy+s6ET8eq2r41cXKNRe7iuAkakBOsD+5Y72CpGiqx3qP96Ki8tHGu4aULXXAttb+kOG8gecEBTFXyIuKuo/YzuD4GBOLWBdqmYhUz+hFY40AXm2b4PaOnFvhD5xqA5Ir2U97vzWGgo1RVPwhAtdhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kx4jjeE2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kx4jjeE2"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47e9fea29easo50881cf.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750701864; x=1751306664; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBASxig7kkKaaEJMDP8Oroico2G3pXurehV/Im0gNtE=;
        b=Kx4jjeE2kRfRfgmAoQYt/ukeytsN6J1YOo5Um9hrwBh8doL7dnyDqq5aMAs05rP4Wl
         ANCI7yObmVoduxxxmYtR9EP5DkuBmrYYjX2m/KBbSxeA9o9+Xn2WUHdeus1PuaZg5Pxj
         T7xyD/JcZuEdG8FEpbKpy+/wZLQpc1sCYWPJiIKYsikkoX3YVFuiciPpKH6tPT5Vy485
         fw5EiieBcVL3/6eSrcjx3mLtkUe9M/dOxavvPVwBeLX0wYzCf3i3WCt1oXFDg06v1qik
         fZpmRVPh3QyQSavQfHI3kmbtBoiEyhWRWFI/p+Q9G/AmbBboo7GYF/ZNpm5JKxVbjUcy
         bEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701864; x=1751306664;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBASxig7kkKaaEJMDP8Oroico2G3pXurehV/Im0gNtE=;
        b=L0brqqO7jeLp0jK29ryOQix0PH4E5avhOIgjIx49ZspnuuP+Gbc7LpI8oWZZjKH5CI
         rqRTVRYsV2DPXwf8CBNljQ0p8LIOdW5d9/1p6lSjxEe/og2mRN2IMj8uqx7Aeq0BI+bL
         2Bcz0dofd7bHDREIoJWjjxGaFpcshTU0EV3fJtkmzQPGryKd1I1/h10pgqidweaQ3UKh
         eNSvhrFIOULcO42ZahNlQViRAjE5bVBBioKzqLZzOIKXUSKKK7JGRcPto8OBKgKDqITh
         bHkL2V5G+ak0yH7dKTIZpCwW9BwljpfW9v/i/GBUtQ8sw6qmOYBryzCoIoG/z10iziLh
         yeag==
X-Gm-Message-State: AOJu0YwbIHqUUjE3GxbnJ2cTbUlTuxXFYz9LFE2tltvLchcm6mB69v2k
	xGZzKkIYTHm33Arp/2UcDjyzrxT/7zoIX3ta3INfe5oadeyi8f14jIWoJGVpwdjCBCkgiND93IX
	ZfqEtjcCGmv4jj8kGKcO/B81clSKcsUKGyGgISm0XUSLx5NrWr6lf2z20wOM=
X-Gm-Gg: ASbGncuid0q5Gm8tUJFVyZ86AmhYzrbbyA0RaCAIuS8yUXxw4EtzxjRx5JqobCKy55R
	xiQscw6J8+W9E67gnYXI7a1HsB+XpG2NZ9G6m3gnhqRC06WaI0cYuMc6rDeXifhFc0lQr3oT8/z
	T126PvopFp/qU2APOqYEEom0KGEPEyVPSiPLOaDhUYlAXOCsx+EB6smNabVl2VRzyyUkAe+EiTB
	g==
X-Google-Smtp-Source: AGHT+IHXdJwiDMmCCd4WmzPopAnXDKA7Zl0RdrAxaj2i8Uah0wWAtH/+TdzXIe2FK/x2FALoj5sgqXtwOR0MRCrrzBA=
X-Received: by 2002:a05:622a:894d:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4a7af7d5edfmr119561cf.6.1750701864057; Mon, 23 Jun 2025
 11:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
In-Reply-To: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
From: Kai Koponen <kaikoponen@google.com>
Date: Mon, 23 Jun 2025 14:04:12 -0400
X-Gm-Features: Ac12FXyF7ggD7GLw5I45lLiQc-7A1Oy-NUTgW5FK_g0Pq6ziEyZZIg8_P4Ecrqw
Message-ID: <CADYQcGoH3jHMZ5K1Hrc5YVyqH5-Tm+LxN81iUchOqsHb00nD4g@mail.gmail.com>
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
To: git@vger.kernel.org, Kai Koponen <kaikoponen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Re: rev-list perf bug, some `git bugreport` version information:

[System Info]
git version:
git version 2.50.0.714.g196bf9f422-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.13.0
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
compiler info: gnuc: 14.2
libc info: glibc: 2.41

On Mon, Jun 23, 2025 at 1:58=E2=80=AFPM Kai Koponen <kaikoponen@google.com>=
 wrote:
>
> Reproduce steps:
> ```
> git clone https://github.com/golang/go.git
> cd go
> git config core.commitGraph true
> git commit-graph write --split --reachable --changed-paths  # Without
> this, all calls equally slow (~1s)
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/clean.bash > /dev/null  # ~90ms
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/Make.dist > /dev/null  # ~100ms
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/clean.bash src/Make.dist > /dev/null  # ~650ms
> ```
>
> The rev-list call with multiple paths takes over 3x longer than the
> sum of individual calls to it for the same files.
>
> Expectation: rev-list with multiple paths should take <=3D the sum of
> the time it takes to call it with each path individually (ideally <,
> since with the count limit it should be able to early-exit and search
> less commits for either path).
>
> Also reproduces without the -10 arg, or with a lower count (double
> instead of triple w/ -1), but these results are perhaps most
> surprising with a count present.

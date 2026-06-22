Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C931195B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143388; cv=pass; b=FrMVfpW/XQP6xJ9xLNbx152HMrpsdVoLBU3nPmX1zyQ71oYcppxPt7HrV3RyWSLp/txVCrJSHI/5Zld6bps7lKrF06sEJMAWMf78CVhXkwGtngBK3W04kuH1QqpUA5XmnXUEZsRvtcsgLom0u0617jaRaSTFaQZvIpzf3Vv+NZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143388; c=relaxed/simple;
	bh=phf4C4/JxtPTlnAW29Nn9qid5coR7LSl+xNGu5oId4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/DMtqijeuaznBKNAc0/OV+dxeldOSCVDab4VMp4V86HVykZdfzxZQvd+weIBa1I0uld7sz1Xf+kNQTVGaWPvt+snntyN9tJjWJ7fUdaaeWF+OoVb4Q/e2+nBkloXTul5c98D6bwCxZS9PhEmJnLjtgJVwfRffKrv8dNNxI+Zc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIPMEyWQ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIPMEyWQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so17571035ad.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782143386; cv=none;
        d=google.com; s=arc-20240605;
        b=aZf2odwRdFIVxyLZrhqZUI0rl8L+o67nhWrJB+sIt/QE9it+SkqI1ZSVYJXkzCvK06
         NErI2uYKoOaIIswqnAfLrHCZSljD6TcFfFnzYYnhXkGv9QqegN6KhskJpudp9Zz0qHIx
         I89w0+Hm+4jPsVwwIWZ/pmhSRQAB4OcgL16IIJJSH1vLmiD8T5rvlan3BC7yvcVmZBMQ
         Vu6viG6ncUAWhZE8U0DOLXUjlYIcaD5aeKqsVp/zIn6zS6ch6zbGBQKKZ1QmndApLAkO
         hqnj/FSZtM/bY76FoeAVvaeJvQ/6OFp5miSKNATDPEKSG63c+PkIyQ9zjDLFqWu429DP
         j0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8OgCkhntIjTfqK9b1Ujnf90//07Aq4dCRH1JkLaiVM=;
        fh=j9Ml2IaXs4fZf8Py46bch+05yHnLW38wPhTS0Lg3+sA=;
        b=IPM9zJIdiDV1WUrnwj3nXrotkk/1/uMtb1DVxf8jfDOBsz+h5nyhcljzruZLVZTEXy
         V9hHX1Fez46MxRbcXQZgp2VDO3AhagnqSpr97voF34Gl/cRb5oY0h/QLef8e1xjINiE8
         8N0EP3UvMNjuAssh9XSQq0EaMLbJ/Pqmma7rO5oHfipvWAbRstdJgUqm61wfXd1g/Ak0
         1LOPb2853Q2hctFT61qsnv+0gfFNb3ctBXlmoMAu92iOgaahFDkc8KxQ0UBZzAISL3kv
         FDhWh0kxUXQB8l+7x65AGGDtOEocX8E/BReTD2blWYUbYShUyH0ey/QhFADtU8wHzNum
         Ke+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143386; x=1782748186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8OgCkhntIjTfqK9b1Ujnf90//07Aq4dCRH1JkLaiVM=;
        b=WIPMEyWQKN6NgTKQyUcatSknvwkLw49QhPHj+71vwhhI//3kmAnukHE96T0cmK0KBx
         TL28DcK8H/YAqJn217LPpK5yeayq1TfHd79VxG+2rdnXPYrvNX5mMGUoKdxDiYvYSMgd
         vdHlm5KrLfjKERMaeKu1SIOE7iwrm60/7PocIVDSZRHhG8tvXzr99TyWfAZ3VS1dHFAx
         oM6IGEREyRPZ1USAJ60JqVHiVtuoq7uGNgYaVrUQVxey+0H8UXwVXF6K3kCatDkAkIMW
         dxgbpRl9n6QD7nGURWFm/deczghcQJNGYSkVI/DZVzbmnFxhJpFpu1m8F35dxUZKlJc3
         qEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143386; x=1782748186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8OgCkhntIjTfqK9b1Ujnf90//07Aq4dCRH1JkLaiVM=;
        b=NZA2d9qOjYA8iG5j0G2JhKH4w+S0e33mhMJlIp4Y+mqVEoG0uF6nC9VhgGOpYiJMuy
         ELVoe4TarW510ie2wYINCd22XJ9Y098IyOmlcXo0FmrzBVcBNeJ4TdIyd7NCq2L/zN8F
         6nJbBEbARWuLGBqScT75Q35q+b4gDeusOMyBaR+I+CklvIoSwWDG7pAxwpxTzuv/obpo
         NLlZcJe5PE+ZPULCZisCzmItJK8SZjzwUqpOxzP8xou+/E8njXMQAQEH2Lj8kGV0INzh
         oKUugqMzE7iB3UG87Md+CDao8NYC4Vc/2cMIECoEPDA6TboOTYy0stWex3v9aTjKGuME
         RSVw==
X-Forwarded-Encrypted: i=1; AHgh+RpXkZrJKyzIqNnBaB5I6roZ7DHUzCzIz/Ac1P0rYkvuF4MotSsrxR2TrEDDhXIhPCf7JtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHtA4PPBGT7AL7/m11SHVNtlYqoOgcXKg6q4cgR24sB9Eczmmc
	1MVGrgoSl1KoRjMEumBBWWQ0hSMlXf5qt87piUA/tz5vud8o/ehefXnPsE8NAOQAATN/QBtgeqN
	7YTLeOV4VgwKk5v6xix68y0DX8XMu+Po=
X-Gm-Gg: AfdE7ckH6BCYenHPA6F+VT4a5k7FwD9IKVABSOaxcvjXY7MrDiWF2cjSTTn2eW9ETKf
	kWIQQtkXb9+mlV62lEC4ux1aCk3D2ZxWjOEs7TjVZuVCkJqFN3viTugTcovxeP+D08qiE9/2s49
	WUNQMyXk2DCPGHzgPQNPnplbPGNntmrLG3PYfnVJp+DNTfq35go6CYNyQtdozYFA15WtXjzU3dp
	znWm+nCplJLgMnSUTao/hNx5tiEwqy7Bx9hOMfrwrzY5GYfoHKV1d1qnY/wUJ5Ogj4X0pd+yMCV
	49zsMe29KUPWwypV4wxkhM7viKOgz30byNqGDui9o9EcNjmYTlUqSoIZI3m7oDMRIpf5J3cwWUg
	ejKkU++gSHcUOoqct
X-Received: by 2002:a17:902:f688:b0:2c6:6926:8968 with SMTP id
 d9443c01a7336-2c742b1c878mr105138595ad.20.1782143386233; Mon, 22 Jun 2026
 08:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
 <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
 <xmqqv7bei2tf.fsf@gitster.g> <CALnO6CAgNdkg0PnN9Zy=zLurLUSb2hUXYAGe_qB0oceZNy_=gg@mail.gmail.com>
In-Reply-To: <CALnO6CAgNdkg0PnN9Zy=zLurLUSb2hUXYAGe_qB0oceZNy_=gg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 22 Jun 2026 11:49:34 -0400
X-Gm-Features: AVVi8CciP217NHjDMYBZE8N1UIaVomq0X9I9Xfk-KFzIOrXeGg6BxUaFrOjvrGY
Message-ID: <CALnO6CCcBdmPniu3wOtktygZ4TFdz3Bp+CXNqJ9nx4_qw=to+A@mail.gmail.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 4:58=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Fri, Jun 19, 2026 at 6:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Harald Nordgren <haraldnordgren@gmail.com>
> > >
> > > Building on macOS with Xcode 15 or newer emits:
> > >
> > >     ld: warning: ignoring duplicate libraries: 'libgit.a',
> > >     'target/release/libgitcore.a'
> > >
> > > Some link recipes list the same archive twice, which is harmless.
> > > Quiet the warning instead.
> > >
> > > Pass -Wl,-no_warn_duplicate_libraries on Xcode 15 and newer, whose
> > > linkers added both the warning and the suppression flag (ld64-907
> > > and dyld-1009). Earlier linkers reject the flag, so gate on the
> > > linker version. Broaden the existing -fno-common version probe to
> > > also match the "ld64-NNN" and "dyld-NNN" forms Xcode 15 reports.
> > >
> > > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > > ---
> >
> > Yeah, this looks like what I expected.
> >
> > A few things to note.
> >
> >  * Can folks with different versions of Xcode (or is 15 sufficiently
> >    old that practically nobody is expected to have anything older?)
> >    test this patch?
> >
> >  * We only patch Makefile here; can folks who use meson report how
> >    well your build goes?
> >
> > Thanks.
>
> On one (old) machine I have available:
>
>     $ pkgutil --pkg-info=3Dcom.apple.pkg.CLTools_Executables
>     [trimmed]
>     version: 14.2.0.0.1.1668646533
>
> On said machine, I don't get the duplicate warnings on a Meson build.
> No issues with the patch when running make.

That old machine has "ld -v":

    @(#)PROGRAM:ld  PROJECT:ld64-711
    BUILD 21:57:11 Nov 17 2021
    [trimmed]
    LTO support using: LLVM version 13.0.0, (clang-1300.0.29.30)
(static support for 27, runtime is 27)
    TAPI support using: Apple TAPI version 13.0.0 (tapi-1300.0.6.5)

> I think I have seen this on my other machine, which is much newer.
> When I get around to trying it there, I'll report back as well.

Here's those results:

    $ pkgutil --pkg-info=3Dcom.apple.pkg.CLTools_Executables
    [trimmed]
    version: 26.1.0.0.1.1761104275

sans patch:
- Meson: duplicate warning
- Make: duplicate warning

w/ patch:
- Meson: (unchanged, obviously)
- Make: no duplicate warning

Under Meson + Ninja the warning I get is (status line may not be
helpful given parallelism)

    [705/708] Linking target t/helper/test-tool
    ld: warning: ignoring duplicate libraries: '-lexpat', '-liconv',
'-lresolv', '-lz'

That's in addition to a dozen or so

    ld: warning: reducing alignment of section __DATA,__common from
0x8000 to 0x4000 because it exceeds segment maximum alignment

Under Make I get (surrounding info may not be helpful given parallelism)

        LINK git
    ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'
        MKDIR -p t/unit-tests/bin
        LINK git-sh-i18n--envsubst
        LINK t/helper/test-tool
        LINK git-remote-http
    ld: warning: ignoring duplicate libraries: 'libgit.a',
'target/release/libgitcore.a'

(No alignment warnings this time.)

Linker version (ld -v) on this machine:

    @(#)PROGRAM:ld PROJECT:ld-1230.1
    BUILD 16:18:08 Oct 17 2025
    [trimmed]
    LTO support using: LLVM version 17.0.0 (static support for 29,
runtime is 29)
    TAPI support using: Apple TAPI version 17.0.0 (tapi-1700.3.8)

--=20
D. Ben Knoble

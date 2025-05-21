Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61645262FC7
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834030; cv=none; b=ffm61+LFqQmtWcJekei0C0xFEisP6TeOi/CK60vY3nGOZGSkgQ48SlPak9JqedoX4eXfk/cm2eEShhvdmoelNxqMxuh4GZ8PLwfD6Jw1hmti8UlOC5h0hrzYIr/Sb6K0dtfPv4YVf7c0jZ2YA1OWzYSkxgEOPGo5bBxQ1jm2jbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834030; c=relaxed/simple;
	bh=DFVNr6e3KP8EMFTAu2A/u4h37f4DmK0YTrVJFyFwoTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNuo4ZJWpr5xya6STbLQvivgWzSeMlSLTl1zZJLeRL5frGFrfjeQX+ZvR1Is2OuvSAofLDxe2d3KINN+cWYbQ2SK6d73rU7P//L2EbqDhXau6O5kDmKlZNEierOdsRYNilQvN6rrSkpPIwe0qv2pU+qqwmO7ZTGTWyJvdDy6yoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mntQeUzG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mntQeUzG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad551342f08so257075966b.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747834027; x=1748438827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFVNr6e3KP8EMFTAu2A/u4h37f4DmK0YTrVJFyFwoTQ=;
        b=mntQeUzG1lz4gwKQWbkuQTo9kbHVmxJtlINF0hN5zA4ViZrWvmVOSiFQaeWMAp9Z9K
         yghV0A8bj0JCPiBB5gH6mUF75IwMchf+DGBlBkgevEPEYunruZ3owTEGgodGVdnMNXi6
         GcnidcNIlhcq5cNDq8Q1VwO96NmWWk66JkggzUOIvYH6YPMe5kx90UtkLRjMD+iN7jY+
         Dz+iz8yceV6XS6MpEEk1wxJ4WT5jRepqr14jG+38NH3qsQnvPu2jalMk6JdLH/JlqnIq
         3wdtubygZGXTFmkx/Tr04PsnH7CQl6TmKlbIjuUu1GoZ8IdFiN8MBFfWGibqUUdUgG9R
         kGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747834027; x=1748438827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFVNr6e3KP8EMFTAu2A/u4h37f4DmK0YTrVJFyFwoTQ=;
        b=H4Mm0c7heeFa6y4fVwN1HdJFqZytQKBCfrXXBAbU0biGIFNfe3PtuXmB0Fmos/IsuC
         UBZ6gPFXyd1ioc/2UoStBTrNR1sCcB1hpBvb1k5a0ofejwWBqOd/btjH0ZY6yXGWberj
         BS31NR/AjPHJzgvDWgfhBLrG1LG5s2FgdCEZvAPiCRllhxOuVZUrGQZbsNpwGY65sMxn
         IVX9VGnZd5OiVKD2zwrInqwSQZQWtOgdNfl0J+Iiq/+IAmvZ2PiC0zCAIO+Qg73FOJB/
         cT6W3/Vs2h2iUv2vHquKY3O0ciDxdKab8ouetbZGwxyz86NdEReHweY/mI7878h1qtzA
         YPcw==
X-Gm-Message-State: AOJu0Yxx/6TpgeViFT3J2Pqz0PkTgR3ULRemm55exUxzOIfG0JYeKO6p
	6/A15VLzJZJjcpGekdBHboIjoRin4cSRt2Pz23kjJWYrcwCa5lkWfWj9p/677xfZparZD1EKXGU
	wRWVs0SKpiFOiPk9bwmPgDDVAnIrbCdw=
X-Gm-Gg: ASbGnctugwrgEyZLtECADWJnC3OW4vnfinjoxIvChBnV6XV6VDB5tuGJfoEL3fqoHa2
	H9pn5MXkboyGKJ9I5ULZG+p0ortNlC0svw0wfxebTzpCYwyDQtlCN4Irx3SGVadLvoeh4mV5Fzs
	PbmgMUZp6IyYfD00umXIu2ji/S5gk4c/9rYyQ10CNLzlOLksuj+2ib7xeJcN91+oyrsuI=
X-Google-Smtp-Source: AGHT+IGfSlCsGaiBPWpq1tW6KmNFq5rb7VSiFJRzFnQBICIV4et0Ea6ORbeL5QvgXHUVensqaUq3qZkHAqd/XFoQlvc=
X-Received: by 2002:a17:907:26c9:b0:ad2:3616:8c3d with SMTP id
 a640c23a62f3a-ad536bca53dmr1995825266b.26.1747834026573; Wed, 21 May 2025
 06:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-3-ben.knoble+github@gmail.com> <aC2HF1VEosDMY_A2@pks.im>
In-Reply-To: <aC2HF1VEosDMY_A2@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 21 May 2025 09:26:50 -0400
X-Gm-Features: AX0GCFv-WJDYjpPn4Eaz4HWh1F5P10oJWZ_1D87VVoBxavp0AP7v_E-x3szyjjg
Message-ID: <CALnO6CDGGiw2HJTjfhvnmLQpQYDJqQux7UdO1tv0c9-LqNXMxg@mail.gmail.com>
Subject: Re: [PATCH 2/4] editor: use standard strvec API to receive
 environment for external editors
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Calvin Wan <calvinwan@google.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, May 20, 2025 at 03:34:56PM -0400, D. Ben Knoble wrote:
> > Going back to the introduction of the env parameter for the editor in
> > 8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor a=
s
> > well., 2007-11-26), we pass a constant array of strings: as the
> > surrounding APIs evolved to use strvecs, the editor code did not.
> >
> > There is only one caller of all 3 editor APIs that does not pass a NULL
> > environment (the same caller for which this parameter was added), and
> > it already has a strvec available to use.
>
> Okay. It would've been nice to explain _why_ we want to do this change,
> but the change itself looks sensible.

Ah, yes. I think it's really just "cleanup" here=E2=80=94it started out as
"maybe necessary prep for later work," and I kept it in this series.
Will expand slightly in reroll.

>
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The order of these trailers should be reversed -- your SOB should always
> come last.

Thanks; I didn't know that! (Aside: rebase --signoff seems to add SOB
even when it's already present. Is that a bug in rebase --signoff or a
misuse of the trailer on my end? Setting "trailer.ifExists =3D
addIfDifferent" didn't seem to affect it.)

>
> Patrick

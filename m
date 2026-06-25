Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A642FDC20
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378949; cv=pass; b=h7DWF7MpdAjlWREFLe2HJKIOOqWIRO5Ka3aqalD3p+64J/x59AHTnS8Ub3XOiOdyxfP4eV8e5xTo2Ck5FoVcR5Vh4saMCylDT8EyDZDI0CAtwXLN3OMP70M7p3Q86p0YC/8gzr/L3EW8sKeL08YMX9eyWEnXcfsATWHhNM3Ae+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378949; c=relaxed/simple;
	bh=wo2Y/G4XkgVapuU06gK8KALOunfRZBOTJDHXbVS9tTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9L2dxN0fKB8fgxsOrpuZoJY9pYVysUjc9qaDFBE9EHUGUdsrXPUZIS8iiIe8v4vH4FTTFOM7m7gYakizs3pKjBHuXROqE3h1v+xuqhJS1dl1EPqTfr8weMbBhpraCLcBFbr26Ahe7mNwaRVVmfv4OtKTyFQS88yBBK+mZmyzKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=XEQg2itn; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="XEQg2itn"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80af6f707b5so734077b3.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 02:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378947; cv=none;
        d=google.com; s=arc-20260327;
        b=Gh44X0CMx3FymuhPuTthix4JuLKubWHdJl5zZBReMB1lfpFdWch0S65CMcUOohaoaO
         0QVNkFTxQkXi656G+0FWVj29Xs0EZN1qBoiaNfWiUlMGvsSeMM0k+kL5gJVaGcw8jqh4
         Mo8H9PkEJPId23Xf4U1pD28HOEG/LiVut4+Xj1cHxrd/SNkgn2MF6qzYhOlMAMQiNSxg
         IvwlCmLLeZOD9d3gKpozEHIPhDlXGK+voxPVG+nYxKdxKaw6y1uKMWU5o4MHD5PlVBRT
         QreDI81hyYM53VhG7076/ehrdPGMzRBoqmFsQgVdmdao4NYR2zgSuPHc0z7FckvGG7lL
         2X9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lLPAUusuyt/FOeLDUrwIPfqgivryXzr5ibbsgOrcSHE=;
        fh=IZPvVnRZQr0pTDhi5FuVCYRK6m/h/dGIM6xak8Pdq2U=;
        b=fzTK4P/bSFXDvPF+eP5nSPoEPz2IX/TTtXmG5sMOZTGnWGNd0ucx4dWJOu6h0BZnig
         VbXP5TENulpL1arKx7MDiB40i/pkhH0BHVNpKKrfmAyJlR1Hvd+UZvjmNUuwHmAkhuNU
         qFsZzlln9qBSFUQvA7bAJMC7sH/yNgTQCv9l3DMZ+UTFVSiYOtNaJWmbL4Tdl6NOx4Fe
         RKBhiBqglXVfTGXBMhlVGesJJg8TBXDJtrS8lD0NGC9akZuuJpyOOFDg/sbFdaOjPhOg
         hvA5ChatCXtukiO1rvIsfrIudaczmLU/69fepJQqEN7ah9XCNQFDqroHyZh3t8TnU/eD
         TTGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782378947; x=1782983747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lLPAUusuyt/FOeLDUrwIPfqgivryXzr5ibbsgOrcSHE=;
        b=XEQg2itnzeehRJkf8r4aabD2bCymzmzUrIz2d/nDbgdCzkXMV9AmPVV3clVTFOu/3e
         0KHW+PWSYuIrsqZejOQiOnmlxJKPy4NOcqb4CMPPC21vbG7tI6D/11x8+XYPyZUUqO8A
         xZUegdYmEKZpHmEQexxoFEe59WSO/a0wqNEro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378947; x=1782983747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLPAUusuyt/FOeLDUrwIPfqgivryXzr5ibbsgOrcSHE=;
        b=hukiHZ3bUJY5zL1kBVMT6p0Jv1PFceLrrx1egf/ddtcUafBccGNb/T9143V8hPKmEF
         YeslyEWlp7qD5AhG5pUIaDyLr0Ap9PGGVQRRCMdqy0C5+X8yTMrgViYcv0rO3z2O4wNz
         +nH1jEc3L3JKm7XAWVeXnwfqrPwiW5A9D6vc9Js5xPjjaqgoUkjjx7B0nTMQoUYqwtcN
         6ePBwHnXkT/ZZgYjCNpwDcuydvybfGHhLnheb6Kn9iKgiUCDvLuf5ZtzBPhdKmh55LVH
         qf00sm9iz0sv4gyADcgZFjuVBY9CIN2ouaHwM+fx8Z1u/JcgZo3ROQH5dWAWrBvt6ONZ
         80Qw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9L449Or0wYTW/pyFt96sFTjAbs+tw5mFKCDQwOmwEA/o9Hy/XsQ8wThwxL9SeLrJUGUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPouTPEbQwpSrxA/CmdQgLiDLFCVc8u43djyO71NHRX8kDCkPY
	i03VuvUDlghRgJaCguCAnIkXQPEQWlCKUOAr8K0De5I8DGGxKB9WrsYQ8LrlMkoweyniAz9pFp6
	QfNEI81VjJ2exmL0iur6ChJ3bpE7oqj9NllDYNhEnjw==
X-Gm-Gg: AfdE7clq5iTmUgLBMhtwHk0g0iAIRSpvRWxbGWblHckORaMzF2q2Ov80fdK/8QTCM/M
	H19mUZTHb+jc5S3ztve8aMyvC0MMp6LMWmPVcu213lYDdOf/9QB59qD39eJCoT0LOFIynOokCXc
	f8moLzfc5XbyBoeIvVX49LwqNuju2Vhh56Wx6dFjk/eFgy9MUXmQZzOtZtOHghKszdP6RJIE/06
	cJDf5U6Nbhn32E2bxM1tvyuP3l35OkKy9cyH/nAvOPu+MeUMcR9o3xHufo+NgOmju5Vt0LSCA==
X-Received: by 2002:a05:690e:4186:b0:662:cb52:ce2e with SMTP id
 956f58d0204a3-66487dd29f3mr1288759d50.33.1782378946866; Thu, 25 Jun 2026
 02:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5x37h6fj.fsf@gitster.g> <43C04FB5-7FE5-4535-A79A-C35449EB38C0@gmail.com>
 <CAHwyqnWdsYGHMcMT=B-Vdrb_DUK61QBs0-YvWkdeq958v_r35w@mail.gmail.com>
In-Reply-To: <CAHwyqnWdsYGHMcMT=B-Vdrb_DUK61QBs0-YvWkdeq958v_r35w@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 25 Jun 2026 11:15:35 +0200
X-Gm-Features: AVVi8Cc2AHs03jg3IUmho-0WpPmhrpDVwgiswTPzsgeXkzJro7R240UasF6kv1M
Message-ID: <CAL71e4MiijEiM26TKJcOYT7L4pfQeMM_F2oT3U3igP-wOZm2Ag@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jun 2026 at 10:54, Harald Nordgren <haraldnordgren@gmail.com> wrote:
>
> Hi!
>
> I think you are touching on the critical point here; Git is likely one
> of the most ordered software projects that exist (I haven't worked on
> Linux kernel but that's the only one I can imagine is more stringent),
> and every "real job" I had has been fast-paced and chaotic.
>
> I believe that we must leave the ivory tower and make Git great for
> the real world.
>

I wouldn't call it an ivory tower, but rather a very solid foundation
of useful primitives that can be composed and extended by higher level
workflows. I think this is a good thing. The git core is kept clean
and simple and it provides hooks and tooling to allow for customization.

For the combination of fetch and checkout, it seems easy enough to add
as a git alias:

  [alias]
      newtopic = "!f() { git fetch origin master && git checkout -b
\"$1\" FETCH_HEAD; }; f"

I think the usecase is valid, but I think it can be cleanly added on top of git
instead of changing git.

- Kristofer

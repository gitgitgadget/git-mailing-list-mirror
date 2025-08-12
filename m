Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844731A9FB7
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018483; cv=none; b=O2ZylAEB5q7Dd8XHW2nUmvyfs5QnuPB3djyywLWEjiDPOjUHR3Tv90Grx586RHN9IWH1tnEOL8Xr3oU5F1xgmhn5yFlnRKG/614VLPoqgynkdNr+8PQeWH0BzsAg91VdSBfamAwptotMSa+PYtgTCcrnVBM3gjP/Jciw0du0R7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018483; c=relaxed/simple;
	bh=rUKaiipHbgo1gMNFwSfP9YFrRtKakFiQOjuLpTG3tQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6FxmVknYKV/E/bAJ06hrSLVv5nJwjAcHJtNE9YdUb/VWiR2noVwVNc53duFZScDzAeYgu5Yh+rUz5JIAib7ccES5p6TU+ojhGSQI8/bavdrMj8h1Oa8AJNSUSDlOZ8ykoBGTV4nJ1kVrwvELOmJRujF9wGcPz5VOGp2N2lms4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpjxXW+9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpjxXW+9"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af968aa2de4so1027693366b.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018480; x=1755623280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX8AoDuwAc/Qbn/y4q0SVZYMABD8HNIV2yYFEYZFuW8=;
        b=ZpjxXW+9/cxFdG9JyOMV3MaOsAC3vvA2vj6rH18J3fWqZTr6CGRjXyuohGoR0AMORs
         u2AS1vdI4XjadcJ+KNqyZYdBRmGsuPzcAoSji+vQFZ6/JXeCako76Lg6i4QgkiP8XdXL
         ZzV/i/lhGKkCn9ZTrYFm/Polu3AcIzJuaI/Up59zQz8hbfwYToR+hcrAlOUBd6bxs11a
         7ecPJ6F/oSzPV6IPpgxG6AAE4LgB4rX2GyLkNBWnpiomgUEX8zc1fG83lKzPYU6buFY1
         XJ4SEYKTyJhd2WI3IKrtT3iWCdz4RuV7sQbg/WpKTStXRun1qKulSGF7RgIgZTa6F+60
         fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018480; x=1755623280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX8AoDuwAc/Qbn/y4q0SVZYMABD8HNIV2yYFEYZFuW8=;
        b=nwMBUN2XLTKsZIfnbQiPI0eq0Nj/TpePiuWXdE6bvTozcW/eRy+uInqnrsipmvfmHJ
         af+olyqQ48Dm1BD7lgfRPYImVfAsCB3s7TqSrMnxjW741bZSMprhZLEhzRR4Hch/+DQw
         dhD3gvr/EGm3F2/9g59Qa3dDBPL41RLfjvSpkTjsmSB9kG2EljENWVYBgU8AYzGSMX1Z
         QjGKgogIK4VE5AZyuDMK2yvVpQ3gnDxKas8t8clrQqsU8744z2j7a3s7hvKxkPoVSYVW
         UbtXItJHR7AsMyT9lCjisWdG00fynRGnTnSRcpP4kX6ejIq2kwU0HLNWDqT2by/P19X7
         qjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXzfO15TjjnFh2YZpKBIZRwS0SB13BvhwzKYGgsFp7xYsXRAoFFoowsOW521OAc25/SEZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVM3pI/dkQ1WmktJTFP25Fx7K0fX78KELmh59P88Imlix0sS0
	ax227FguQsVoowtc9tZj8C/ebPwz9LxnFMCMD8L8kEYVSW05I0Y+eqDUeyzzyDbEzpTqwFvDBUw
	0IGHH68t9RvZsZ5IC+J42PVppbocMMF8=
X-Gm-Gg: ASbGnctSEnq7cUGhuJu56P3wZSDX152jpu1OAkysAI1419vrHPyjOwyI2UE/xxXhFv8
	lFEhiTH3MK/iBlfKZeB1+gavRHkWol0nsRBBPzoi3WDliwpUFr/n2OL4268E4HDidOAA3nc6qbv
	IV5jTItGrcypc7bCGLh+Hhq1BHSy+GkH0VdOxx/tPadU1iOs+A54aTT+ShWTADGeidc1tGRx8dU
	OqEcVb575Vry04umragvOSz8DC5M30KH3AOGe8=
X-Google-Smtp-Source: AGHT+IHE/Z8ndAKr4KhJLhELuiUuYC9xwHw1ne+dZi/4tNLEMRJm98Hs0IiR7Egs1Mc4DDbfucwqa/xt03HFNO5ub+w=
X-Received: by 2002:a17:907:6ea2:b0:ae9:c365:7f1f with SMTP id
 a640c23a62f3a-afca4f0ad84mr4755666b.56.1755018479647; Tue, 12 Aug 2025
 10:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
 <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
 <84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com> <CAOLa=ZQwwcfEQNbZqp3o6YfTWMhUr=s0Vw5jP87pUELsktLRaw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQwwcfEQNbZqp3o6YfTWMhUr=s0Vw5jP87pUELsktLRaw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 12 Aug 2025 13:07:48 -0400
X-Gm-Features: Ac12FXyfq75qZTcsW6HnY9ImHEbhPWkNMZxQH8wOfvdU8Rkk1DpYoP1NSSih31A
Message-ID: <CALnO6CBqChfU62TJuk9mBd=gSbPKDEyBKv8r-rCygsRDD2yALQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:11=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 11/08/2025 10:13, Karthik Nayak wrote:
> >> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>> +
> >>> +You want to transplant the commits you made on `topic` since it dive=
rged from
> >>> +`master` (i.e. A, B, and C), on top of the current `master`.  You ca=
n do this
> >>> +by running `git rebase master` while the `topic` branch is checked o=
ut.  If you
> >>> +want to rebase `topic` while on another branch, `git rebase master t=
opic` is a
> >>> +shortcut for `git checkout topic && git rebase master`.
> >>> +
> >>
> >> Nit: now that `git-switch(1)` is no longer experimental, we should sta=
rt
> >> recommending it over `git-checkout(1)` as necessary. So perhaps, we
> >> could s/checkout/switch here?
> >
> > Junio has already expressed a preference for "checkout" here c.f.
> > <xmqqldnte6h3.fsf@gitster.g>. I think that is technically correct as
> > "topic" can be a commitish and "git switch <object-id>" fails without
> > "--detach". Also rebase does not do any of the extra checks that "git
> > switch" does before switching branches (I'm not saying that is
> > necessarily a good thing).
> >
>
> I missed that, but since we do mention that `topic` is a branch, it
> still makes sense to use 'git switch'. But either way this is okay.

In the general case, it may not be a branch though. (Of course, that's
too confusing a detail for this section anyway.)

--=20
D. Ben Knoble

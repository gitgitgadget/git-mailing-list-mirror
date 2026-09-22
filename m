Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764904AD7FB
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109274; cv=pass; b=MW0dxq//jPiyNTR+nuHrn2Zls/H9OXV3wgLccS79uHPcmVVu4KfOW/do/GWNWCYHVACtiJoj3nEqYtX7qnseGMsEfaT9Sud9NoYPTl0kD6Rhdrr7XpLE6gONNjS8kVAK+eflaXC0jX6l8K4HHDomBieZXT5IeKaXI3QD9mliC9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109274; c=relaxed/simple;
	bh=gsgEXcbSoMoXjy8ZMrIj6wl7CKkRVliHR9fg5JIwdGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgQ+sBQM4R2RrizEYmzb5sEOAY99AhSEn3kXg2DE2ad7t6MO5YbFdBijw6n8oLvFrGkJrHMnIS13jy6h+m8U5K8CZKICOAWra3iCBQwOpAW9O1Z6jSymv21yb6kYfJPVhhCTiPtJ631o+VhhITXC7o+XKYF/xt5yeDPkGmjelLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRIZgE0U; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRIZgE0U"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f20513so230743b3a.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109259; cv=none;
        d=google.com; s=arc-20260327;
        b=DwgCbzQTKgNy7/IZQRLriqFrnN3b1ycCJLH5hjyH+Ba3wtVOdC5x7kRR2xTfGqUuHM
         L3P7pk5eS7bzISOa0GyEBDVKSEvv7sJKME+6h3yu57ktvxv3bImXFN4LAc7NYJguI4wo
         bhMiuC+LH2zFJErBzxfor5tyM9qTwLqPbnvSTBCmkx+ux37feMveRog0adEBWPKfysNu
         KANYyj9Cy46Zd7OpeBL1ThJZvi10RJMPfCQxCHdduMKow4ThkHSTWmTQeCJCWNKZMPT/
         5qk9DJdia9KomNFPLoegUXKBTeTQG1+i+b/7zzb/p7Bim97VdBx3vS96CH9NXemPDkNd
         Gb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiEPpAVr9JAxc63+5jfzoOdojRjXMFRiN9NkZ/FSC5g=;
        fh=JwKIycEK1A425YJY8qLMxO6Yc11i7Y5uCpj/+wYJcqw=;
        b=YskojMXtm9DqEkQsibmdScwwRHiiBRxUjqZuppiz698pVdijmnK2nwysiYD88ho/AJ
         phqiwbP2WRIFPv7ixTr8osUh7uMdw5YIs2L9WJbPuqMu4/RviGL4u+Q9l7Ntu3KUaOhp
         GbXb7N5WOi/dN4xN4orjfvoSPi8E0Hi2BObnVRs0kGqHBdiU9/2Q/9g/MLoQi5wm8sp3
         eNomgS9muF7/xrSNayRcU0+w6C4XSHgbdusnqA98dE40Nu3FOQ2P+oY2IYKmXvSbyrg1
         XkgyDejNizzqWSeIEyr/MKsn3ZLQ0gV64Ij/x1vZ+cnSp9WYVwRGQwl77iP6DJ7uU/oe
         z15A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109259; x=1790714059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yiEPpAVr9JAxc63+5jfzoOdojRjXMFRiN9NkZ/FSC5g=;
        b=nRIZgE0UtVsclPaOoAVT4iy9vxxAk4Otv4j6bl4bGZkcSGHPfg1X+gjUJspU8gW/gJ
         zJBtQJ0G6iLp+jN72necxsF28ocHGH6pJ46LUXiGBKSO+0U4QyukiH+sn+wo/U0Kma9p
         CEu3u8+q+Jf4Y0OWnKwbvpJqdm4m5W66Di4pqZ8dy1f7vRy5FeJDuTfSstUBx1xuFuAM
         nELf8t9rBlCD/KRs9CZEfZfLx4ZN3Sj6nTFdq+gU1r27+e3mp8tR3UtF+b73cxEMz3dc
         pBN8bGgl72KQ1PFx2Vqvgnvjp236ulk3pZTDxYgy9aLl2B5GppDSenntUaEi8iyD72nY
         eQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109259; x=1790714059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiEPpAVr9JAxc63+5jfzoOdojRjXMFRiN9NkZ/FSC5g=;
        b=12nf8WkzUnDGvI8016sstoqBt0XtcgO/X/KuzAK2pI1s07CUHt/nhlPcFJlOL4Mun2
         /EEJePJaQosFjDAvCFwY/R8tbHN/BB3bw2YPH9azr0bwFzZ2jhhXXCQhafKJCGyGjd0Z
         1SVcekd1L/V50nyzH8amfOSRhe+LRS8jVWb96TuVg58ETqIz/CDf8Esb85YOZzqHAV3H
         THmdjAZGQ7zwVNPerQTpXH1Ij40dHS26dcBJbNTxdqemjvm1rtZOTz1tlUKKUl4/RF5n
         UPdEUNyNu9X7qSaYI3lPA1+8G97KClU3PBSiy1ZIpSMVbBgSGLcYz+fKUsN9+/uwsIQe
         iUWw==
X-Gm-Message-State: AFuF++mkQLV/OTsv6wtS1PCD0B5Y4cUSGxzXetXboTA5wcfjff/DiKiM
	mHnvgk0JRwUOWxDu7ZYoZ0o4fDzJPl5ZD4/NzHomfv7EEfAfWFjM3btRt7BeIr+EJYxOg4kIhhg
	20K/UJ6IiRaueSGyXPKSJCl+vLhg1kTw=
X-Gm-Gg: AYBFou0Bdm4q7/+H/8ARNZcSZmc1galJ5ljxrGQMnqxazGsMyt8n9A9FclZcKwmXbDo
	D7p3N+Jx+0zShgPAU8wrADNs/HH7OGyhcPvMOZ63/9CexJSuTT6rLljLTLIrTh6atW/pnXmeZZy
	IgYezCY7LJRKs7RkTog7FoFdf7Tdc/2U3kVEoDVkYMeiUKH9gxzreZma5ueGMtjOmA2r1XiMB5g
	WlGHhLAa+3ZmTL0aetxRcklKISralKsvCuzVm1jZeh9cLYdPMob7m2cguhe6c53/bbC2grhuYeG
	30x/Uc3yDB/mSVauKUtrMufmwhTDq8nbUPKPa49W/WwVdIb2MpcuWBYEOHe6HFYVJL7K9F88vKl
	d+gWSrQYudQZ8VIAENfUEI1kphZwU4WsAcovBFe/sCPeWQFnefR6/ERx8DcQZ+tfgIvqv30n77N
	jvbdYkH3w=
X-Received: by 2002:a05:6a20:958e:b0:3d3:ae1f:d7f8 with SMTP id
 adf61e73a8af0-3ddf7e7a20bmr685858637.24.1790109258425; Tue, 22 Sep 2026
 13:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
 <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com> <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
 <41d28f9d-b86a-4d65-9a85-656ea9d216e9@gmail.com>
In-Reply-To: <41d28f9d-b86a-4d65-9a85-656ea9d216e9@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 22 Sep 2026 16:34:07 -0400
X-Gm-Features: AclHuK_sD2RBCMkoBVl9pTkSJLG5dhFWbhpyn3qyfc23VrF3eOTnCEocPuLK4Q4
Message-ID: <CALnO6CDxew2b0X+HMiT0Vai_hj+MaueV9Ht2BOB5zrsZ27QUwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, Adam Johnson <me@adamj.eu>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Victoria Dye <vdye@github.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks again, Philip :)

On Tue, Sep 22, 2026 at 9:57=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 22/09/2026 13:43, D. Ben Knoble wrote:
> I think there are wierd cases where one diff algorithm results in
> conflicts and another doesn't because they generate different (but
> equally valid) diffs so allowing the user to tweak the algorithm we use
> via init_ui_merge_options() is probably a good idea.

Gotcha; I've already queued this locally.

> >>> +                     o.verbosity =3D 0;
> >>
> >> Looking at the code in merge-ort.c it appears the verbosity option was
> >> used by the recursive strategy but isn't used anymore so I think we
> >> could drop this.
> >
> > Intriguing. (Assuming the default "2") There's a "< 5" check in
> > path_msg() that wouldn't be affected by dropping this, and a "> 2"
> > check in checkout() that=E2=80=A6 also wouldn't be affected?
>
> The former is not affected because we're cherry-picking so never have an
> inner merge from merging multiple merge bases. The latter is not
> affected because we don't checkout the result!

That's very helpful; I find it challenging right now to navigate the
various call-graphs here :)

> > But it might matter if something is setting the verbosity elsewhere
> > (config, GIT_MERGE_VERBOSITY), and I think we really want this merge
> > to be quiet? I seem to remember reading commits in this area quieting
> > "git reset" and so on to keep the noise down.
> >
> > So I'm inclined to leave it for now, especially in case it later does g=
et used.
>
> merge ort does not print anything - it just adds messages to an strmap
> in struct merge_result() which we ignore here. I guess setting it to
> zero might avoid a little work generating the messages.

Possibly! I still think it signals our intent to be quiet better this way, =
too.
> >>> +                     oidcpy(&index_tree, &result.tree->object.oid);
> >>> +                     clear_merge_options(&o);
> >>
> >> Looking at replay.c:replay_revisions() I think this should be
> >>
> >> merge_finalize(&opts, &result);
> >
> > Hm, possibly. It does look like that does more with the "result,"
> > which is probably needed.
>
> Oh, we definitely want to free the strmap in the merge result.
>
>  > But it doesn't actually clear the merge options.
>
> Isn't that because there are no allocations in that struct? (obuf is
> unused - it looks like we could clean up the struct by removing the
> members that were used by merge-recursive but are ignored by merge-ort)

Maybe---I was more worried about un-reusable state, but it's true that
the clear function is a no-op right now, heh. So it was a bit of "in
case one day this is mandatory," perhaps.

> > On one hand, I thought it could be important not to reuse that struct
> > between merges. But if we do use the "ui" init, it might be ok?
> > replay_revisions() does use the same struct between calls to
> > merge_incore_nonrecursive().
> >
> > Oh, but one other thing: we unconditionally reinit the merge options
> > later on in do_apply_stash(). We could conditionally initialize there
> > ("if (has_index)"), I suppose?
>
> I'd just move the call to init_ui_merge_options() above "if (index)". As
> far as I know it should be fine to reuse it - any state is stored in the
> result

Yeah, that's smarter. Locally I got tripped by the case where we said
--index but skip some work; but it should be fine to unconditionally
initialize those options earlier.

> > Funny, I was getting aborts before removing the asserts because I
> > hadn't set the labels, aha. Looks like we've come back around to
> > keeping the labels.
>
> Sorry for that detour

No worries.

> > I'll probably keep a similar structure as the
> > working tree merge uses, I think.
>
> I'd use fixed names and not bother with all the conditionals around the
> label text to keep it simple.

That's what I ended up with locally, yeah. I finally decided it was
too complicated to do anything else for labels that would be really
hard to find.

I'll get v2 out in the morning, probably.

--=20
D. Ben Knoble

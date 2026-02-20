Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D829D28B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613526; cv=pass; b=Z4DqxBt7XVhsQ+C5uneu8Szbt3tQWz+ohfFogvdJa3XiUK+uZ6i2xJN4kTGiuXdiU3jYVZ3s9v0C81A+j1MDY3C2HT7m3U27tKg0DTmiFFOwLfxYRNs+xXvqBP8I/cj17V0IjXAcQIQwVZIfOsFdUcD/3wJKO+5//+i97ADv8mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613526; c=relaxed/simple;
	bh=z9BEAHcHnq4nXee/j157/zFFM+yYBbCfh1wsIcR6YuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peivqk7qwuDgEfkGAQKNQY0SxG9B6T94D913HVwkx0+xHv2yuWBoDET6SRwA5AsSvLWpNqVxkEhrQb1UsnQb0+4idZwS7M6ACAhfr78cVQ6JxtSHUJtdmBaBUmsfIP9t47jK3MSMI46O9uCogwnbbFWIO8RVvoeOAO1zQy3VX8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVYbq3gY; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVYbq3gY"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6798f3b7163so1482725eaf.3
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771613524; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTw9uP0d16Krb3u221fgB4JzcEj0/BXw9VqlgFppiWhI2OZ6NqO+qwEib47hPyvtiU
         IBYzauBXmlZAJg6yfdB3XfiMdnnBsvwKLmppcrJjFAmRvaQrzs8m+5V5BJ/OIKzZS3ow
         JY0wHOM5ee856pYniLDAeurmxhGN+yIQGfBa8BECgr8IiEFfPFI+Op2gtmajWhy8P8NB
         myEVS1EePgNeEDFnSMkhHwWZgsHZKUAucXgjCg3gc61Bn6N2pKGD6BGSMVpDIU2cHhfs
         guk4ebcidVDQFAPPpfbgl303aHGNr91EmiADIH4RZxFZiwMJ/tjbFXOLZBf2xs9oKft0
         pOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRoXa9+P5xq24tIwSG9L9ouidxphvuU//a1fteU3ppo=;
        fh=e9VE6rghLy4XVrW12A1Pt+dKxT6ADsLaAG2B9Vx/irI=;
        b=fO3zr5+othfPVc86s11kJy9k9qF5NanhBDoLaZYYnZPiNuUrvH6+O0nTcfWah3w1Uu
         RCVTwnmc0JkbxG9UspOgk6hlCCqIFV3Ds5u2Z4/Bi9BaAJVcuQD6M9WI9lP5Qzw9SSL6
         ijH6bXfuWRjJNpP/fZqUR5//BGd7kJrAVv40O/7CpZqNIGk/sr+WOSUob1tpQnbRp5Jg
         FV5JMvf7nIBY2UDlmrmGvXFOxNiemBizBrLs/onHnEEAnow19zvCk3FMuEUxWQXc72ry
         76vuGWpId325O14eN8CUycCkXX0tlDwhg660kGnu7B7UpElyIboyZG8Px3mWJOaA/AYt
         ZGDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771613524; x=1772218324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRoXa9+P5xq24tIwSG9L9ouidxphvuU//a1fteU3ppo=;
        b=AVYbq3gYCb7uJ6T5UWkGBlK1UtGTyM9b0EE5hsOloMBRu1/K38+vTxQAuoGOwNRihw
         usIPLzwPtdVMD3+TnzhExUw02f/BEcgFN9AXp/YGzJ+WCR4txNYyan6hqvymLNjVFErs
         Fqo1DtG672zNl0O19afApT9lINy/rvB1uQ2yk9O0dtD3CJ3mD2V2n6W7voP0zvcmrTuS
         IgwEr2YnO2bG9AWznWszO4biZNVN4MFRjSye/OgJpZtWUBhIs5NMp9AVctZen1DlZsrM
         mQMx7AK2PfSaPd0Utzj6WJ6Vpyyci+f7YQ0ElRcvIue1L6+rk2JOBKD+5eDlm38NDe5v
         4t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771613524; x=1772218324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRoXa9+P5xq24tIwSG9L9ouidxphvuU//a1fteU3ppo=;
        b=coSrnXgixCLBzruBNpKUs2acal1dEcJufeaUZicl4zCyO1vJAWRJ3k8etGunPJrChb
         vfzeUnzGJZR/5Mj/SBUAYIZupU56HfMxLNkjvqd6IQPI93YMahC0ESbCGYmvvx2VfaeT
         EX8UekbGxAwNzvox44GppF0a1yArghOHx0G+bpiCZJYoYnDPaTV03t5Yk6P8FA9ibT/M
         TM6YJdvLZ2NJr4OHZVH/mbym3BQMJjrZzNQ7qwgD9Vf26/ihtLwAH8zrM6XRwctaFRKe
         hmseKcTf7aK9Ozg8UHimRNN1k8SXnZrnr+Fga7cdZuxfww40F+u9lB3vwyxQ1guanDSJ
         NK7A==
X-Forwarded-Encrypted: i=1; AJvYcCXcTxINDCgbqfdpqDD4LFfQME3IzSQiy4Ui3Obb8gSdlwXgz/ZvGcPhQXuneb9n0Gp1j7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdqvFopVKWDc3k12LPP1thzMu37wsunVQvodLB19bi2kZXZ8R
	Amp2KcICGUWp5x8HzcdfdAtqIYjXFeMa2PYRqi0h/jCYOQfM/HaJIZ9a4KtvlWRS4DNWNLh7Qi9
	grepfyX2jCDIJ1bTr1/LriLSTxKZo4nw=
X-Gm-Gg: AZuq6aKzpk3GQLjs5lBtUhVcBOKToH0/mWFvmQbVI8shm2LeZbsiduj78R/8PGzlfzX
	mnhRN49JVujktUzd2VqL6de7qQ0i1iWhyIxgcZ+3KcZC4n38wzbaurGLkYUyb+dLrgg2AX+MHFR
	q6Vnl0aeVlI33sA5Q07/QypHJyngg3Pw7cx9oP7ifzt/VKz8PGgEhaT6YIMXmcCwNKKcDnLBlmR
	PFfzNouFzK4OsMZ3P0gcdC5+34P9ReZn9A75iBDwNunDnANjJKQUz1R0fADnPNbEh0GygK92q39
	Im6p4jaIHsy2XZL1wfRx0h/In4qbwSchoKxXGqYj
X-Received: by 2002:a05:6820:1c91:b0:677:b586:d134 with SMTP id
 006d021491bc7-679c465d017mr469160eaf.74.1771613524194; Fri, 20 Feb 2026
 10:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com> <7155a0da6f8bcdac90cf1ed085622f2c8b68675e.1771552788.git.gitgitgadget@gmail.com>
 <aZgZAuIlCujcoEIt@pks.im>
In-Reply-To: <aZgZAuIlCujcoEIt@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 20 Feb 2026 10:51:52 -0800
X-Gm-Features: AaiRm50WvSTEV9jOyLR7pdgW1yECg_HyF8n2L4KqP1HMSVZ0pysH3HJuWopVPvQ
Message-ID: <CABPp-BGR5Mrm30sSb9Y96VkFC5-XFTYkoAp60LMAf6gCgW3QEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] merge,diff: remove the_repository check before
 prefetching blobs
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:19=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Fri, Feb 20, 2026 at 01:59:43AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > diff --git a/diff.c b/diff.c
> > index 35b903a9a0..91d81f66ad 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -7176,7 +7176,7 @@ void diffcore_std(struct diff_options *options)
> >        * If no prefetching occurs, diffcore_rename() will prefetch if i=
t
> >        * decides that it needs inexact rename detection.
> >        */
> > -     if (options->repo =3D=3D the_repository && repo_has_promisor_remo=
te(the_repository) &&
> > +     if (repo_has_promisor_remote(the_repository) &&
>
> I wonder though -- shouldn't we also pass `options->repo` to
> `repo_has_promisor_remote()` now? Otherwise we may support backfill
> fetches from arbitrary repositories, but we'll only do them in case the
> main repository has a promisor remote.

Doh.  Definitely yes.  Amid having this patch originally be last and
rebasing and whatnot, I didn't look closely enough and missed that.
Will fix all the callsites and resubmit.

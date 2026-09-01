Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B548167D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281294; cv=pass; b=iG76Ik6+B0pxLb9HxlRQKbrCi3wVHORth/HOe0sOzQZteDsdsDtoQxg2O/8Jd519zxwHBXb/KXSRJwamGpVQJSJ5Bo9S9/p2NuLdq4y3RnLftFIhkNiwZEW/khj3BQNVWZ41n408jP2Sa/gIQT6RH0wvKQg/yyXfh19oC6FtrTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281294; c=relaxed/simple;
	bh=EYAKgCZfELrIyjApxyfRvsSxCfaHvs15VTp7OL2OSgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB7Nnwdn+dHmU/gnKqBNcEsQZDE1nA3iksA9SAM5YtgJAvycnkt9z7ijBkzwhtHKY3SMbvsJnk9MteqlTD8EpwzGH/FqafSsgq6fllU3mhcU/FAVPzAvSWqjn6kqkj2kr1gu2FyuaE3qE9dIarpiPSukSpeheKMzNz6RX6UoCkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBfhxpt/; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBfhxpt/"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1161637a34.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 09:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788281292; cv=none;
        d=google.com; s=arc-20260327;
        b=hwkf+r+NN9/pm4KNM2hPFxoD2XRlKr3sy/7FnQmu9lh5iLZlCqtS9NaNeNv0SEtrcM
         hpnV86PbeHJZRTMdlNSlGCDSQiU2nm4qL9wvRa0v1hLnztPZYr0oPkLsm0kO9nll/qAp
         k0eUHnfcSBf9uto8vlz2INvwb5udDxlsY+X5HSVsqfDXh/benBwBUYjazCmOuulUbXCz
         NeHQWWbxNzOekujdsriyAsvlaOkP9WuC8ap6CmABlnN1UKppMKnuIroJb8Ukzm4nTGbG
         /W3ETkwRblUbTEeXzaXgbNq5urpbv7OitMw3aXF6ASK/b3xTaCFm0T5JP/O3ni15YYVQ
         KDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFixXRo2vJNaj0PrIeJuNI9jjJOWhijXGJEKE2uIfL0=;
        fh=EkKqx/Umh3RHds8yvIaS0S+SCZ0Mil5pBAzcFSNWpk4=;
        b=aPvlbrmBb//LmHaRrYJ4BhP6ndAnPLBF1DyNhJjI8ZSeC81yOQ98YPbfy9YdgyP/q6
         us4vOH0HQ/YQiCK8A25FID1E0OM6OAARekcusth9/ms3sWCkpEclt8qeXUreTePuXYlm
         26Uk1H5BzB4fEEVoreO7cZWZMSPPjruVyb3Ldf/Qxpwj8GYM3BbXmCh6bvyT5YOZRyml
         tTm4fDN4YDtYl1ujrBRYyTEmfcAcy/l9aWRof2gRhUi+4cTk/Ca4auEZPDiYZtI4X4th
         TKP5L9SlFXnMEecoXzgSzaZYVMFqWyvgBoYfOSd2Pf5MmdswJyv/r8S0Odj/1RqSgM9E
         AFmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788281292; x=1788886092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFixXRo2vJNaj0PrIeJuNI9jjJOWhijXGJEKE2uIfL0=;
        b=WBfhxpt/5v0U85Op/GpAfTFj5Jch44tevrl7oAAiDl1WGa5DGvPBOe7qW1BMzgkKQ1
         FqeFETAfPR0YT/IZQqYOU4Fktt92JCf/BRb48aiG9PD34Sl4ixx5I1Xn8xdHCVs2bb+a
         BTJ+8jeP+t4XVW4a9LkG1gpO2qvl8a01v1q2TInfx7Ec4RawsNklzij7DNQSmJNFYoK3
         YFb0jY7wL9NjZwL1/Gir1tbk98TVrtODYCbdlAzTwDpYR1btYVOShVNC1R90r0DW5VGa
         aKl66ml4FTU+/zTmwvGIwIJNNzViwHrZ4DBqBgijf+kfgrOywgj7av5L9an0bhf7LZwX
         Px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281292; x=1788886092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFixXRo2vJNaj0PrIeJuNI9jjJOWhijXGJEKE2uIfL0=;
        b=Q3VO7oI/dMt3NwT69Xlp9n4AqDEinUlscyCQKtYnLvW2FHqy/amxAvtHT944Px1BwB
         SmoM/K3mrxFDx2BlrhNv7cx1+eY90UdMAs0vWKgon2ag6/2G+lKw5aXhSy4hloRKXUii
         HlisWA4M5zOEcGCRGWDbAO31ypR3nPsFRpu0rcDCrSegxwbtpNOXDLdcfdYTy8VCvHz7
         QurPnn0wN2mLSeM7fOXbVLclvmn9kJUvzyydjFQTxptvs63MNkwLjLFtsZbrxxTblC1H
         ofWgOtlVD3J4a2vSLGmD6ckeI5L/T2XyQtj8H+RsLlj+t7S2aY43Aux6aWN7RaxFck6p
         1pwg==
X-Forwarded-Encrypted: i=1; AHgh+RpZl/VEhT4DTczJw+Q+Lc4ZSYoFuRi/GMq4hit3W3F0HVh4ntd8LyuaRC6ANSd1E+2BjvU=@vger.kernel.org
X-Gm-Message-State: AFuF++nhweiHImsxVi2WA/jedBdmzLsFtx02CieFrejamrDldCVRFs89
	rJvMbVj/g6xeLYiPMTaqQQmdKOm+SAeMupB97DibQJqgXYNC3QO3fErGuJ+EVdsjFJYyOPK8SSV
	gOB7RkPy3lrOGYNdfArtelLbufzqsyl0=
X-Gm-Gg: AR+sD11egA38NeHIpN3VqOqeKyR0jyiT+1OtCP/KGYg28+xxnWShlS8mLJqvmeMJmL9
	Mj28ye68RoCQ+5WT/b/ZdwbgYT8Zuk/BmcpXdsbHH3fSht/TQkGFAYisFrRWE/W6GOFZ1Am8KgN
	xK0KYYSEO6c+7l3FKIc6AdYcNu2E4SQdv28NaKEQH5lJSApIkCSxk4xmsBFLJomUiB7E8VbCQzb
	xaJ5UQdo0U5NKO2IBfRrEDNMSF9XlU19fqWQ4I7PRTHm9pjLlwTOW8kW/VjSBQBMFMOhYknlkYG
	rYbGU1x8wQlu9WYIqnagCvYGbQvq+FIXlVgdwzotSBiURIgFIx7mFf6rvYA97/y4u9iHXv3Y4a4
	1clxEn+95vrrCpYhsBLTp0P81XAN9j7oIQtDd4vJ+eucA13KRwBefkg7aR627Yw==
X-Received: by 2002:a05:6808:3a16:b0:4b3:1a95:42c2 with SMTP id
 5614622812f47-4b398037d07mr37070460b6e.3.1788281291646; Tue, 01 Sep 2026
 09:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com> <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
 <944945ab-dde7-41e5-af92-fc520485fc53@gmail.com>
In-Reply-To: <944945ab-dde7-41e5-af92-fc520485fc53@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 1 Sep 2026 09:47:59 -0700
X-Gm-Features: AcwNN1XZFR-5L79FbSqznJFamhgRZoyXS-cxhv3zktaml9YxfRHhEt-I1tAI5q8
Message-ID: <CABPp-BEK8f4Dh=3z-Q768iBV-d-wdpXGSKhsfFacGwHEFabZKA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:26=E2=80=AFAM Derrick Stolee <stolee@gmail.com> wr=
ote:
>
> On 8/29/2026 3:00 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> I'm late in reviewing this patch, so forgive me responding inline as
> I discover how it works.
>
> tl;dr: Good patch. LGTM.

Thanks for taking a look; I wanted to point out two minor clarifications...

> > +     /*
> > +      * Recovery for a concurrent-repack race: a stale MIDX may still =
name a
> > +      * vanished owning pack even though the object survives in anothe=
r pack
> > +      * the same MIDX covers.  The regular fallback above skips MIDX-c=
overed
> > +      * packs, and repreparing the on-disk pack set does not reload th=
e
> > +      * borrowed, cached MIDX, so scan its packs directly for the surv=
ivor.
> > +      *
> > +      * Do this only on the second read, by which point repreparing pa=
cks has
> > +      * already had a chance to find an object merely relocated into a=
 new,
> > +      * uncovered pack; only a genuine hidden duplicate reaches here.
> > +      */
>
> This comment does a lot of important context-setting to show
> that we are in a very narrow case: the stale MIDX has multiple
> packs that contain the requested object, but the "newer" one
> was deleted without creating a new packfile, so we need to
> look at each contained pack for the object from its pack-index.

Actually, a new packfile is typically created, it just doesn't have
the object in question -- and doesn't need to, because a pre-existing
(also midx-covered) pack already has it.

> > +     if (midx_result =3D=3D MIDX_FILL_OWNER_UNAVAILABLE &&
> > +         (flags & OBJECT_INFO_SECOND_READ)) {
> > +             struct multi_pack_index *m =3D store->midx;
> > +             uint32_t i;
> > +
> > +             for (i =3D 0; i < m->num_packs + m->num_packs_in_base; i+=
+) {
> > +                     struct packed_git *p;
> > +
> > +                     if (prepare_midx_pack(m, i))
> > +                             continue;
> > +                     p =3D nth_midxed_pack(m, i);
> > +                     if (p && packfile_fill_entry(p, oid, e, bad_pack)=
)
> > +                             return 1;
> > +             }
> > +     }
> > +
>
> This is hopefully a very rare case, but it's good to have
> this "fall back to O(num packs)" situation.

It's actually a fall back to O(num_packs_in_the_midx); on developer
laptops that's probably about the same as O(num_packs), but on busy
servers constantly receiving pushes, the total number of packs often
dwarfs the number of packs in the midx.

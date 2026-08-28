Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B73D1CAD
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902203; cv=pass; b=WkSAgeFn4yrlUEQxQXJqb8ZnHhprzLzu11Ik0P1N5x/qPRiLJ5PLPHYksT/mjO28Obx7EqBxyMKUhhzCCvBWpc8uzJJU14x6z2uDLYMJsxGvCkVK+DyTVRgtGQlq9FvB1WKcSuqDwZ37SLSy6bUPgzAyoH6tStIZIWEssCbfYD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902203; c=relaxed/simple;
	bh=OEoenIBLHo8oCzPZLHxLJn012UmISzO1WM85UIQZdGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+lPGMwy4qYgLTKSl9cJBtn/qASFc7Z3FHhr4Km5rILtqceoyhQzVU5FUdaIoLOe2meD6XQ323UP92NfAPRLqNbx74DsnhN6Ry51JKQ+U4ohn+oWKf7r80TRHqd6Npyq5QZbkIatmwD/briSNPxsDiIhoZ2xJyBSXgw/uf3kvxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuPIpHsv; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuPIpHsv"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f18c0e03e3so290595a34.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787902200; cv=none;
        d=google.com; s=arc-20260327;
        b=NCRs1Cq5XvuHbFbvkZcGhRV1OEqQkg/WHcEfkCyeIrAFFSf9tq9ItLckhWADP9Cmsr
         t5Zca+jdPAwawbePC/DjWJl35F/A/pFhZr1Ici+LTyDJKOiUaevb8oazgYv/ol0fU5ck
         k8BMKDPGODMaGdVeLne2NgF7BRRhoaK8aLdGv/TG8p6fQujgxPMHsz30L5riH4s8LZ3H
         oRfaunRwg3H6rUPhGjqR3Ibg2/hOtYLbEk7wqzOq1aFoSgwHha0uuXDHzADdbpReZ6Ei
         KfiAqLaJ6YrESHg07bGTy/jByar6zEBqeIL/lUIoCzWTop92oSD9XIgZxGVissaI0HJu
         bmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E+fKh5X6Z1nMCIPxcJQ59rNWECTMFtiXIS5l5ESeYHY=;
        fh=UX4f2OII8oc5eE92cLka0pnxuep5muFubAXku9oCiCA=;
        b=ClcMDjwMdSIavjX4OQnKx1cH7D+TK4RX3wyWaXPXrvfZhSaEiVZO2FDZf/HiZ51sa7
         YJVdKCGeNvCSaZr9ZT3Mu3i5gc+deTpRsHl2cRSty7Gb0A/LrKYzDgT+yBaEyXhskuNr
         s3kjTsjVB6mc8HI3FO9riEOybKsFCmLwvsO/7eRNjADBOtggW+6/MGt8UWWZfT3C/AVm
         7REOxcu3WzbeQKVFmQOImlCX2dK42kBZBqsH2w7wxJQ5zXXgR1mmA+OoTy4wnlnMaPRI
         ogaLULos745hEvdxe8Iply4hrTWZ0ER9tsLj6ebfcAmg4jqb7S5eoIl8wxXNwG3z8gue
         hXKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787902200; x=1788507000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E+fKh5X6Z1nMCIPxcJQ59rNWECTMFtiXIS5l5ESeYHY=;
        b=iuPIpHsvtwdL0D3aacMSYpno+9qswfAkvbpr44yFwZoOA4X+bz06GTjWULREvIlhQv
         dac2xI/htDeIY+pEkzwMowcEfJUQPhsWEjTz2gKyb5qXQYdNVfRiDqxr+iCwHUAT01uJ
         U+LQX05p2hiAEgsNatUn60b3HsJvN6vkCGRTE5/ELe18AbCUwL1DGMnsWLwiVsgkI/Dt
         vNbCttlREhmRccq13BzXH13H6cnW3l2Jfw4L/SfsypU2Nqk8N195tzMzNlQHp9i7LUXp
         Kgnr9spcBcK8rPZXkElj2wusCsMCXCka9jeDEYl53QZm5QF9MTTLEzvrjbJyhPWpHIqC
         dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787902200; x=1788507000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+fKh5X6Z1nMCIPxcJQ59rNWECTMFtiXIS5l5ESeYHY=;
        b=XsvBNkyxsYmDXC5LGIxYSu2iemHC8UPPGKBCBkU9qHQrySXuPb9jE/IkkwvTNL81/9
         mK1TZmXQRz/9nXgt7RfqZ6kH1jjW7C6U51AduX3nS5hiWO80+oy4TFiPI2l+mspJCv96
         ISgj5f8hLcl5eaQhoQkZmS9xIIoKEW69UO4QXsiR2GND4k1Qjw3Dln17/3fMxg1EKOqM
         9Mv3MnAeI0EmHVWH29ezPDaqijPD3IljAVsbr+QwVVASp79ItFx/OlQ48MZE9lhelWno
         0SfjzZPJEGlUcjgHkuU6Cm6tYD7FU7D6a0KW0W/zCGO3MYLeGy7O8PbhpDGf5CA4GF9V
         mX0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqLHtQP+Tmo1eMZDbAiNFZkmsf9PxZou7XOIrpW+JjjOZpG3gNeRWsUyfkA1zQJKbUyNrI=@vger.kernel.org
X-Gm-Message-State: AFuF++k/jSYTrtIJ3fTtP/9tgzxb/5a+uH45bthDizuueBit0SkYArEQ
	5ulHo2HWLMT/9OJfJhF1yejdrbeBzNoJdfmmVy3hIBleonWdEV7gpZf/EG3zaUnN4vE0B/6t8WQ
	hmuVIXZ7NeVtrl/KrGwxANUhcS4JCCYTebw==
X-Gm-Gg: AR+sD11GaW5ryE86Liz7vDoC9V3CNGR4hjus1WKDJPoOAK8K7EDAxgxOwGOfr/AG5as
	3YPuee0EKDwa2wmsiMhJtKo5/6xmUj+y7QtUp/iY8yrnl9UWCvhuxM8LLIh3rLCDyIoZ6gr124L
	ExTsUIiClSyakoQmc/FGltY4kWRTRnH+DEvMyJ8VA+FDDuKd9ImufO6n2vEs7fkJi8Ykfo1JH/7
	HsmeIHF6CDd4IioWfvXiDWPvmwmiVUmeLRsvOL0S41MM0OAi9Qgpptoaq/pfoiSzjEMMZw+bQ3L
	Utj0G6YifT9Mul4jL+uD/uDDl1q24n3P5lpKEpebILiJ2QQ/jXoOUE1nqgvmjsaxH+7mM4a4b2n
	FIMjUIGGFgBOxIj14rYbX9aBIG+eX/jBCE0m7Z47KAwk8EQwC1gCfBtoFhokL
X-Received: by 2002:a05:6820:25a:b0:6ae:a950:9faa with SMTP id
 006d021491bc7-6b1c65cb077mr3517506eaf.10.1787902200128; Fri, 28 Aug 2026
 00:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com> <eacf6ba4b11e366466da18b7b668e65793c532a9.1787684429.git.gitgitgadget@gmail.com>
 <20260827060622.GC189659@coredump.intra.peff.net>
In-Reply-To: <20260827060622.GC189659@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Aug 2026 00:29:49 -0700
X-Gm-Features: AcwNN1U1xZEEJqrq5_Pjot9p4CpKlcGDlnscZO_xs0O_-FZZMauXRCirmrx5Rgw
Message-ID: <CABPp-BFhPONjNuVZQfgwKuYdgbm5Fjjttz5q5wSYX6j1Zdwdww@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] packfile: recover when a multi-pack-index names a
 removed pack
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:06=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 25, 2026 at 07:00:29PM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 399acd0f22..30ad7d822c 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct=
 object_id *oid,
> >               struct multi_pack_index *m =3D get_multi_pack_index(files=
->packed);
> >               struct pack_entry e;
> >
> > -             if (m && fill_midx_entry(m, oid, &e, NULL)) {
> > +             if (m && fill_midx_entry(m, oid, &e, NULL) =3D=3D MIDX_FI=
LL_HIT) {
> >                       want =3D want_object_in_pack_one(e.p, oid, exclud=
e, found_pack, found_offset, found_mtime);
> >                       if (want !=3D -1)
> >                               return want;
>
> We've changed the return value semantics without changing the signature
> (or name). So we need to make sure we adjust all callers, as here.
> That's _probably_ OK in practice for such a specialized function. But we
> could also rename it if we wanted to be paranoid (especially about
> new callers added on parallel branches).

Any suggestions for alternate names?  fill_midx_entry_result?  midx_fill_en=
try?

> > +enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
> > +                                   const struct object_id *oid,
> > +                                   struct pack_entry *e,
> > +                                   struct packed_git **bad_pack)
>
> OK, so this is our tri-state fix. Mostly looks as expected, though:
>
> >       if (prepare_midx_pack(m, pack_int_id))
> > -             return 0;
> > +             goto owner_unavailable;
>
> I'd have expected just "return MIDX_FILL_OWNER_UNAVAILABLE" here. But
> then, I'm not sure I buy the need for this stale_packs_detected stuff
> from patch 3.

Yeah, with the drop of patch 3 it becomes that.

> >       p =3D m->packs[pack_int_id - m->num_packs_in_base];
> >
> > -     /*
> > -     * We are about to tell the caller where they can locate the
> > -     * requested object.  We better make sure the packfile is
> > -     * still here and can be accessed before supplying that
> > -     * answer, as it may have been deleted since the MIDX was
> > -     * loaded!
> > -     */
> > +     /* Make sure the pack is still present before pointing at it. */
> >       if (!is_pack_valid(p))
> > -             return 0;
> > +             goto owner_unavailable;
>
> This comment rewrite seems superfluous at best. Can we try to keep such
> patch fluff to a minimum?

Yes, sorry.

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
>
> OK, and this is as-before but now gated on the SECOND_READ flag. As
> expected in this revision.

Thanks for taking a look!

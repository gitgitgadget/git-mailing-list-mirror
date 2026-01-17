Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F393595B
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768667661; cv=pass; b=DTbGm9857PjH1dfMEtpnvgGQWirwMuzosh5ksGaZqAA+6ZKzkBBZsYK9Rxihvup+f5XbiIjjkTm2W8CqaTI8F7UviyzAKHf56aXG2LIDnZ+5XMHymp3cWpkUSKsan9MvYg9sdlIGqAoofRltCCif9+FzeQbgYikzCGQiaJrf9H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768667661; c=relaxed/simple;
	bh=oZdDh/fZ9cAs3V7LWSpawZ4i6tK6tbmO8get9u6Br60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhrGhO1G0zjM43FsrEcJmJtMvXws81tZ3fDbR51MlJUeZ5DjqubPYVXMVCZ0iUDvjnE8P4zzUQkS75Vb0h7jDLLRKCS61QUbSnPGkXGur4y5H1qh996C0VMh3bT/zb7DGGkJwesriPoOROSh+keED62cmG26bxb10Oxtt+MDZMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXM7Napx; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXM7Napx"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-382fd8aaa6eso27604841fa.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:34:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768667657; cv=none;
        d=google.com; s=arc-20240605;
        b=F+zVWt9nbLTVirP+v+/qdnFqYTAUniRBOjco23Qt1VZyr0GhIW7BI9r0muiL9/rZQP
         l5GIoEQl6PujwR+4273VYRrJp6ffcYrrvwPVrXY13vX6SMseps7mNWuYrqrMJOPHKAOf
         fZ1zAjlbG+Mz8bZxYyI05OfoHv/8jwJBK1or2UWpg2lMfnwbpgjvWHoTUush3590CaL/
         Dkhb3rX2vf3Ip7WDad+Mq3ryBtMEyl2BOLmF+8V1ttRzSGs6bW1Nrn8r5QJ0LJhbjVfh
         YsrmK2h2k9sawI3sj3wed+/loY94QbrUwJN09MCjQUgOAYUvhXA7ak1Al28H9sN3m+Uk
         JU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZW0/TUlkgHCI/PtnmhUqm3OHXVrnWtrkliwjnouSQA=;
        fh=jyXB0PR8y5/vDXsLVzs76k2RCVjdIY9dFG3JyOgGfjY=;
        b=EK62xX7qYDTdnB5PP95n6izDPjQVwcdydP5K9WxShFVSaqjx5UbQVwdYOwi1yBGShZ
         F7hSWaEetM//Q53z09mgFqzpqtJTp/5alireeq3EC5zNXA5brWgGsiZ3kMPV0nIOL+r8
         18baudFe8aD8vCSObFCcqGebavpJ1RkAeZRDn/0qLvSrrn0j2Ps5qTnw6m26jmjuK5Jq
         EGoiszDFyvzZMmYpDfau/zKGrDvHBW4st7r+z/o49u0vAmjtaA/FuLPkcsE1GlpgdFON
         qdkUZwFngX4pxQKOgDRTVPlOq77pW9qCNKqzTD/oqoR1RSnT+zTb5r2Nb3TqIUPV6RWc
         a97Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768667657; x=1769272457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZW0/TUlkgHCI/PtnmhUqm3OHXVrnWtrkliwjnouSQA=;
        b=OXM7Napxhxh6pMYNWiP9hOCihYsFfnbes8UZ8u6d4MH97LhIVtrcoeryBsoLgnCEl3
         5uz6yHb4Q3BHUVUneujrklEimNGndilIyIMgV3STxizt4ZcpdASI2zvo9n3xX4ctO/zR
         LytDfffF2LJYMmlAf3P0kHtwMQsObrDFa6tEHwKJ9R7McQsqfJujzAAPShx0/OYbXsgg
         HRHkqDLwe9XgdhziikGz3u/x4IksnEjN9zqtoL4N9kKIOMqu42wXjgMONMfzsx/4KoFY
         xc1oWC11teQDi/RK1OmTQIceRUe/GZKg4LqpSXzGWTxCOqzrbBWDlHegxqd3lMR4iH/t
         ynyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768667657; x=1769272457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZW0/TUlkgHCI/PtnmhUqm3OHXVrnWtrkliwjnouSQA=;
        b=wObhyQyIWcjOWh0+WQw2goWDxzbRsJb8VWSgoqzO8P6t+JycXDtew7AhwreQyXTA+B
         2Mfq4qMAIbMMSAfSAQEXVXdwVPE2/ddpwNzDc0Ogxx+7YywhVH5XvegD+vQfj3d8BLCW
         sRf1cTJBGWsOI2o3num4adroJWtR/7Cgo96jqr1Jh739i7LDwkzV0/HPOqtZFIwthx39
         ar4BkmHz+vG0s0X/XgQq6Y2oBwdNmdZJqBWcdHTwq9/zJ0wmjh2YIFGeVWEKAamgoM3s
         loRwIHq8Va/xyDiyx/S7MjonN9y4oVT7mVqSnP/xsHC9iVIyTq/KF7l8eYldHI7IEgg6
         rf3g==
X-Forwarded-Encrypted: i=1; AJvYcCXJtln9QFX1+kinY2KppLkaNqlDY9jwq6eZi7t2tbylKibmkYoZBfkDMaKB7WJNIj1iub0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqyn4AaV3aNLSCb2ExRNMdCGazp9w6Jqzh3BSRD9MaHuPZmBRR
	j9ckTyUS7893JdMuCQLIoSzkBvAvIhC3WDkfzbWKokYCI2KsTqrMZ7wvB+VNyWoN2Z+U/q3EyTr
	J4ypx2cLzj6UlzZmO7PydGRizcf2P9CA=
X-Gm-Gg: AY/fxX7OfEeeLGnlj1nw0fTwyGzldYPFi2/tpf5mBN6utZLB+vsxF1vEhyMiBXUY0jh
	ag7zCULVqgfzid6Jrs2vL6zL+bpIyS4QzjXN2fcfV5upGQGstOy9JfYsW62WerT9egrKwDNkMDY
	51n/BlGe+E2AT1AeBTZH/Xb8odp/R42LEnaINQmqeu/BNRU+d+8EyB+Ew3L16zlq82bsVxokR8a
	xDxqSrhQVtQiyWiwtQZM3kXEmKix319Ygmw4s/lspeSno2Ws4jbfeN2iVb0peaL/Ypz+Rk=
X-Received: by 2002:a2e:a595:0:b0:380:989:f615 with SMTP id
 38308e7fff4ca-38384148c0bmr20860521fa.6.1768667657310; Sat, 17 Jan 2026
 08:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
 <07ca298a-ad32-4998-88ff-d69c04418fdd@web.de>
In-Reply-To: <07ca298a-ad32-4998-88ff-d69c04418fdd@web.de>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 09:34:06 -0700
X-Gm-Features: AZwV_QgDZvegtaxm5xbMBKYKpfLE8vKi_QA4J6YepT_FJkrr3ZyYmQvzclV59yo
Message-ID: <CAH=ZcbDw0_Od3+zuGLsy3Z=bLR-4ByH8Fguiuw_MyLTi=U7gcQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:19=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> On 1/2/26 7:52 PM, Ezekiel Newren via GitGitGadget wrote:
> > @@ -253,22 +250,44 @@ static bool xdl_clean_mmatch(uint8_t const *actio=
n, long i, long s, long e) {
> >       return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
> >  }
> >
> > +struct xoccurrence
> > +{
> > +     size_t file1, file2;
> > +};
> > +
> > +
> > +DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
> > +
> >
> >  /*
> >   * Try to reduce the problem complexity, discard records that have no
> >   * matches on the other file. Also, lines that have multiple matches
> >   * might be potentially discarded if they appear in a run of discardab=
le.
> >   */
> > -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
> > -     long i, nm, mlim;
> > +static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
> > +     long i;
> > +     size_t nm, mlim;
> >       xrecord_t *recs;
> > -     xdlclass_t *rcrec;
> >       uint8_t *action1 =3D NULL, *action2 =3D NULL;
> > -     bool need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
> > +     struct IVec_xoccurrence occ;
> > +     bool need_min =3D !!(flags & XDF_NEED_MINIMAL);
> >       int ret =3D 0;
> >       ptrdiff_t dend1 =3D xe->xdf1.nrec - 1 - xe->delta_end;
> >       ptrdiff_t dend2 =3D xe->xdf2.nrec - 1 - xe->delta_end;
> >
> > +     IVEC_INIT(occ);
> > +     ivec_zero(&occ, xe->mph_size);
>
> This array is presized here.  It is neither grown nor shrunken.
> CALLOC_ARRAY would work just as well, at least at this point, no?
>
> > +
> > +     for (size_t j =3D 0; j < xe->xdf1.nrec; j++) {
> > +             size_t mph1 =3D xe->xdf1.recs[j].minimal_perfect_hash;
> > +             occ.ptr[mph1].file1 +=3D 1;
> > +     }
> > +
> > +     for (size_t j =3D 0; j < xe->xdf2.nrec; j++) {
> > +             size_t mph2 =3D xe->xdf2.recs[j].minimal_perfect_hash;
> > +             occ.ptr[mph2].file2 +=3D 1;
> > +     }
> > +
> >       /*
> >        * Create temporary arrays that will help us decide if
> >        * changed[i] should remain false, or become true.
> > @@ -288,16 +307,14 @@ static int xdl_cleanup_records(xdlclassifier_t *c=
f, xdfenv_t *xe) {
> >       if ((mlim =3D xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMI=
T)
> >               mlim =3D XDL_MAX_EQLIMIT;
> >       for (i =3D xe->delta_start, recs =3D &xe->xdf1.recs[xe->delta_sta=
rt]; i <=3D dend1; i++, recs++) {
> > -             rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
> > -             nm =3D rcrec ? rcrec->len2 : 0;
> > +             nm =3D occ.ptr[recs->minimal_perfect_hash].file2;
> >               action1[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim && =
!need_min) ? INVESTIGATE: KEEP;
> >       }
> >
> >       if ((mlim =3D xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMI=
T)
> >               mlim =3D XDL_MAX_EQLIMIT;
> >       for (i =3D xe->delta_start, recs =3D &xe->xdf2.recs[xe->delta_sta=
rt]; i <=3D dend2; i++, recs++) {
> > -             rcrec =3D cf->rcrecs[recs->minimal_perfect_hash];
> > -             nm =3D rcrec ? rcrec->len1 : 0;
> > +             nm =3D occ.ptr[recs->minimal_perfect_hash].file1;
> >               action2[i] =3D (nm =3D=3D 0) ? DISCARD: (nm >=3D mlim && =
!need_min) ? INVESTIGATE: KEEP;
> >       }
> >
> > @@ -332,6 +349,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf,=
 xdfenv_t *xe) {
> >  cleanup:
> >       xdl_free(action1);
> >       xdl_free(action2);
> > +     ivec_free(&occ);
> >
> >       return ret;
> >  }

In Rust the memory management macros defined in git-compat-util.h will
not be available. ivec was built expressly to bridge the gap between C
and Rust. I'm avoiding using those macros because I'm trying to get C
programmers familiar with how Rust's Vec operates without forcing them
to read and write in Rust. Also, it makes converting from IVec to Vec
super easy.

ivec_zero() also sets length and capacity. Also CALLOC_ARRAY needs to
know the type of the pointer which ivec_zero() does not have access
to. This is one of the few ivec functions that does not have a direct
equivalent in Rust's Vec, but is faster than what is logically
equivalent in Rust.

In Rust the closest safe equivalent would look like:

let size =3D 35;
let mut vec =3D Vec::<u64>::new();
vec.reserve_exact(size);
vec.fill(0);  // requires that T implements the `Copy` trait

The unsafe version would look like:
let size =3D 35;
let mut vec =3D Vec::<u64>::new();
vec.reserve_exact(size);
unsafe {
    std::ptr::write_bytes(vec.as_mut_ptr(), 0, size * size_of::<u64>());
}

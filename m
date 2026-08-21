Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9F2DEA61
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287277; cv=pass; b=o9WpYtK7BCNGenOpdozV+LKvE2AHN33mkB79iqInf33ySbpGUWca0PmpVPrLUFrqQ0hnYtYOVwxhq03+PVD0cbTKP8jN+jDWkC5d0yTSm/t34kZ3+NfDwsfL4DYwcllhLblplM6gZlf90VuTIy5vvrGPRx8zoFf+ygyZ2xbeKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287277; c=relaxed/simple;
	bh=4RVYx8fPw9CaKxgtY3mI/l/dwu4F8svamfW+Y4xGVl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGw7NcvKbpixxzKLT0AO3p9LKwTh/DQVV1SHtDLCDq0EUWWw9Vg/2ugyElGD+/UVoIKRZzAekJLNdhGe+F5sfS4Lhc7B3W0ZJ38pSix/FL8v0Te68cA3H1x0Qn3gQn4L6C+u8KdrZzG+bEmkjYsX746K437iG8C/kPGGQjAqHRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvaGK4/X; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvaGK4/X"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4ab89cff9c7so250489b6e.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787287275; cv=none;
        d=google.com; s=arc-20260327;
        b=WVN/4625L+K29fT5Y7ZdYIEbS3yJndJDGk6gwBxfXdx81XR4nSNwQqT0MAsJ9Ic9tw
         aJsxyQOz9TWHBTmVO9h9aE5EkTsj1UZdnSUE6osXekfdHoQA8B4sOsd+lBywkGqwI0fM
         enxBt6yx7sBAVt9AJlrzdHMcrh6MiIbj/puW212nh1bxP9vE/HdOB0YWpJGOvm+8I2iY
         9RfT46Zyq2x8GVNXLLjazkAeV60bq0CdcmzV0U33wJvONFIp9mgLPHcA79Sm0Si0/HGc
         UPFKMDs8F9oJdlL8e/cUlyAPf0pSSaESsKrffcInbKVvtXx1hARKPLYKMhYLDDgoObxb
         vvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnXzjQ1d9vGarjXXvImAiyeaKZVJEiR2CGT3JE9tN1w=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=k/Om6mByWet8z06FcyeJUM/Lge6+jozVC4J1HeDkIxRP+haGj9CAF/smUpfVJXVJKI
         GS0yGRjuvy6eop1YO7gmfV3PaVNzYAXK6NcB3GLwRL8X9nB3AA8h4stgmA21M+eNMz7w
         cfRW7gjTVsC/sMnsvKih73G7wgVv1/AJV1lG59G6NcNN2i5AGXroSG8GyCOLypA7iIS1
         PrxA9NiOp79wOnwjy9zcz2Abh/BrU0nMBaNWy01SVEYW3ERhlzjnstyVAvUOcXX7klVv
         I0sNXgo+4VkS7cHkRlz3wM47ve+rMi6ejbWstA1QLk8YulmLiRHTMGGbAmCsZKIVaKKV
         hVvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787287275; x=1787892075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnXzjQ1d9vGarjXXvImAiyeaKZVJEiR2CGT3JE9tN1w=;
        b=fvaGK4/XzcPu+1OBBCrkbPpp8zrfiHxV3MW/WEj1TMcry09tUSqXiLUblU9UQsCVzT
         JYhM6ubW8lIGivAskxiTy3jlasEXxS7Xhf0+bnDMBCJtWjLehNZ0WuJmqDXjgj3ZO180
         fRSZQyauBqmsWgDGk1K3+I9cP3Du2Gx/plK59TBx5tMFbbqIj5Dtso59MOPe7AR11mSC
         K0TzJiXN0HefSKoKAgcMFh2Il1iObLQsRWL1jhdfL+KY0iTHGSTYadA0+qJeIU4QTbDp
         attseNUELvtJqYC/E3wa/v951Ag+CPUNOJerYouzAxLFYUuQwOHwuR4n7xVMaEucXAmn
         jltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787287275; x=1787892075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnXzjQ1d9vGarjXXvImAiyeaKZVJEiR2CGT3JE9tN1w=;
        b=Vkk1Tzb8mWNJ+C+ZiEK/+38RM5zAGK+mX4waXJqYTI26ssdngptJEh1nTiEyR5RJLF
         MwL1yKvTyWP5U/Y6wSICzIy278mcBAIxJyDxBNXaCHh5ZoCu8ynuYgsKxRt9Uyz2i2D+
         seeALndn5r0vrYHuiWNHSKOnIvw03fPeGKuUo2HQS+cltPlwIyesJvyGyEopT9xN8OGU
         qzokP7MRk0NGdk/oqAImxhQRuqq6+2Fw9zxBcXMLSJpy1cAS8m4AIRCiuWwViAnMRMuX
         Jz7vzcsB+4ypBp8zK25Ogyx4/IbPWsDiaC5wo4VkwBzPBLY+cxVDAUpAs/47JVuWT+Is
         TlSg==
X-Gm-Message-State: AOJu0YwqoiCN6c/kR9u1z9J9Y6OicLaQ/vszEoy5Qc6PAeeUvqQx2PsD
	bLTgUv7A2qmNHvWKNebb0JP8wLBuR3v3wcGyVC4qXxbZhndI1ag+pe1kltKK5UphSBDy5pYNPyG
	dilxLO57J+Zt+0ehpM43HHGNljS9e12w=
X-Gm-Gg: AR+sD12ybAqNf9S5sG1zGwRMfFkW4LFJqwC4DqR5bWHgdSCMqXwhe3LU93DPP0OKZg9
	LX1VVb0PWOIb7kvBZdRogfKEOsLFAvY8R1/oZxYEXEy9nH0BHrLcLOzrsCtVIh8C24Xt35lCrql
	y0kwZroAP3i1Nwxq+dAnkBBramWl3lIb+FxIll+LpQiwLY6Prv0D98uGaS2ZmbtQ6WZBTrv8FNF
	gqmoOMNi2BKZkEDrwoQe0hUOH+bin4jgvgzyA661Olg31ZPs90o9rsuL8f3zgZxAMLsNumve2LW
	6eF9KQkgVmdhzD516IPBxhiW5Yiw4qcfM2jY11K+ge6RMGCFk4B8CCjlKvR9wyaITjfk7xFAEcD
	skSXtaj2nhEzhm677aopV+5TDIfpTsEg13MKzYLSUdCWJTAZFvYyHHc+Z7Zpp+8I=
X-Received: by 2002:a05:6808:15a3:b0:496:fd2:94e8 with SMTP id
 5614622812f47-4b2ef332787mr3501276b6e.12.1787287275053; Thu, 20 Aug 2026
 21:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-1-4c8a96ccfdb3@pks.im>
 <CABPp-BG3_xvbXtt5BucyOy-dHXqX569d4FBfyZwbLiAb-qRPXA@mail.gmail.com> <aoaYL_BinFtgdJ5N@pks.im>
In-Reply-To: <aoaYL_BinFtgdJ5N@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 21:41:03 -0700
X-Gm-Features: AcwNN1UMroIhemZZYo0qr7St4utvp2NI2Q9V_9xlUGidKUxAR-a8llNq6GP-kOg
Message-ID: <CABPp-BHSFW38sF4dZkqZuGaRASVRj2FVG2NN1OTA7-Dd6Pt6rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] odb: introduce interface to generate packfiles
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Wed, Aug 19, 2026 at 09:56:56AM -0700, Elijah Newren wrote:
> > On Sun, Aug 16, 2026 at 10:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > +static int odb_source_files_generate_pack(struct odb_source *source =
UNUSED,
> > > +                                         struct odb_pack_generator *=
*out,
> > > +                                         const struct odb_generate_p=
ack_options *opts)
> > > +{
> > > +       struct child_process cp =3D CHILD_PROCESS_INIT;
> > > +       struct odb_pack_generator_files *generator;
> > > +       FILE *in;
> > [...]
> > > +       cp.clean_on_exit =3D 1;
> > > +
> > > +       if (start_command(&cp))
> > > +               return error(_("could not spawn pack-objects"));
> > [...]
> > > +       CALLOC_ARRAY(generator, 1);
> > > +       generator->base.out =3D opts->pack_fd < 0 ? cp.out : -1;
> > > +       generator->base.err =3D opts->progress_fd < 0 ? cp.err : -1;
> > > +       generator->base.finish =3D odb_pack_generator_files_finish;
> > > +       generator->cp =3D cp;
> > > +
> > > +       *out =3D &generator->base;
> > > +       return 0;
> > > +}
> >
> > Does this have a use-after-scope bug lurking here, due to the
> > combination of clean_on_exit =3D 1 (which makes a copy of &cp for later
> > use), and the fact that cp is a function-local?  If I'm reading the
> > code right, start_command() calls mark_child_for_cleanup(), which does
> >
> >     p->process =3D process;  /* where process is &cp */
> >
> > and then cleanup_children() accesses various fields under p->process.
> > You do copy the necessary fields from cp to generator->cp, but
> > &generator->cp was not passed to start_command(), so p->process points
> > to the function-local cp.
>
> Oh, that's a very good catch indeed. Out of curiosity, how did you end
> up discovering this? Did you just happen to remember that we store the
> pointer out of scope or did the copy make you have a deeper look?

Neither.  Went to review the series, but I was worried I'd be missing
context from not reviewing earlier odb refactorings.  Used AI to help
orient me and give me its own findings from reviewing your patches.
(AI will sometimes spot things I miss in a review, though it'll also
miss some things I catch.)  And sometimes I iterate with AI to dig
into various areas.  Anyway, it flagged the potential problem, and I
dug in to make sure it didn't look like a hallucination before
cleaning it up and passing it on.  I'm still looking through your
other patches in this series, but should finish soon.

On a related note, one of my local patches happens to have a semantic
conflict with this series (namely 3/6), which piqued my interest.
I'll submit it soon, using your series as a base so I can submit my
patch with the conflict fixed.

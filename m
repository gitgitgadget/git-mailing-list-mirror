Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207648AE17
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734248; cv=pass; b=OsnlLRkgw71KoTblxUZWaK/gS953xar/d9CxD5mLHxGciqp5Iaie7VJfQLr068qaj8JISbGSdgYW4a7TtDd6V3sd3LFWRuMjMkDQma1JoPu/9E8P+cOPvM8FIBGfgaop2EqXukzioWwXOIv0SZ/XeKht4dzNboegoRl0zAtDIu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734248; c=relaxed/simple;
	bh=MarlxUM/iT9Mzziu32Oye03iT8tlE1Z81OgYAmeR1kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6jsb8Y/FxdUrwtnUEzqedidI49zFCZMAOPvMfVQbLyM/KjOx/GhIpyA+v5qFAmwCsP/mm06ibS6Nt5CmCHYUq8sDC3FQoloRu36UfsooavHYYTKbH0Q+y5grycGmyTDbFi+HcRQEiGXFTatmCeptEbKpox14q5asfa1QaMPWhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mckYr+0c; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mckYr+0c"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38101f85591so2379344a91.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786734247; cv=none;
        d=google.com; s=arc-20260327;
        b=QJGMhSK/7coStCzLChZxWKSY4QAp4IA82uNQQL7U9VPmxUhdtakbZLW2BjOHXDKPQN
         6tPucdfyrSLXxYWW7qial/S/z5fMaorCA/ZnKZJghytDKHhingFcn6wveMCSnCpkVBAs
         QjoA0Rf0ACfR3p+txa6iVNtxoi8y86fP4kusdpLy1e2rayDg9/8o6CUG3a47bkcO7sr+
         6Pgid2itZ/JzMYuJAX8267Yz2hNhXEiDY5nkJiHia6rTC0HVc7Wk9+ymrveEeHqJJBUZ
         zRnJ1TGIW2u/EnvDwhZQrmxNmgLP87PR7fdeoXuae5wa18DygMs0FGAwCnt7O354L4G2
         1PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=flIBGhUI1878pAHzNQn7bKVsitFh618ZHJ5Oyx51vu0=;
        fh=7D8fZI4fKKMmTXXbgX9IL3PYOy16poSgwXx+m4r6Hp8=;
        b=nlny0Iy+N0klsaIaLnAiTxh9u4m5U5tYCqjpn4pA8k9rrzoz/Btdrkerf4cBu/pHFP
         WNd1IExwDeVA6tTMGEyZX8pa6vcvzAvpMF8bElkK7ZAj4WnbInTuZK1aATS6j3zLPgdS
         QvCNSOYi9XSlByvy5ZQqk/xrEykG3v2gvswX4VyBiA6BELFufENyAtbHYBWqb854822I
         rxizfm9+qiYyKqsyUPjsvx0LH91i2qFt5fV2d/VyVyAEktOrXa12dZDZhYALL15W5Bou
         M6k28YD26QHdYujw9U9sGlA87apYuIxAysE8u+0ymGVWC0gn9elLIz7TkYsfUgMpHkV1
         vKfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734247; x=1787339047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=flIBGhUI1878pAHzNQn7bKVsitFh618ZHJ5Oyx51vu0=;
        b=mckYr+0cBnifYtLIW3kI9kQpqexo4LKE8uWsIjnX6HKIaYC/PVn1aqso6eausUDR25
         9cmf7Ri7Ms2F0mTcSbzWBMS0xo2L9b3jP/mhLwb/f+qWcYUui7IF/fB5Y6ePqnXzEcT0
         L5NTOfKYp0jBIbxxHA3SLkHgpHeldAVv9LH5fKR/ctcHud7dse6Efr14Koso+8AfnaJ/
         KGDsx5IgskjUzw8O7hW6jgEMeQOpHfMgjLYAlDlJArQkc9/rWm8xZAJAMEdgGN1olNSF
         5NH1yBsvMUiM4R+d/CHfkkyX2+SOkD845kRylOTRpLgqLXwm6EJwg6I+9MhOMEgpfuyy
         UsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734247; x=1787339047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flIBGhUI1878pAHzNQn7bKVsitFh618ZHJ5Oyx51vu0=;
        b=WwLci7wtAJ8SBqinZ0cixqJaH+m8Z9G9rD3MCsnwj4d+4/48t7tUxhnUPl9MoBssVq
         BoGiMhCD1FHWw07wP0DJpp4QmwPgy1EEIYKWvftsujz53qYb4s4wQIp7V0tK4E5wkf+x
         3BBEXwp5TlHB5JbpNC4hiSujfnK6/iWLdgW9cIi8+GGzhTAqyD7gZUzpHhwsiExEEDSD
         JpmSFLfgDgf7jWhB7uIDQni615tzKaXR9rLUR2nxIM30gaIS2MNToFSK9xxeSfiRQ140
         gQNR/wEtcYGk3jMo94rZu9u8lybavd64zP0itU7vsvsVeClm1Eig2Ji87a4SE3yiL+Lo
         JxlQ==
X-Gm-Message-State: AOJu0YxmjWjdfHV5NXB9Bj7vZZSondvV3wVFy59H+/PHArlQ4oa+3fj+
	qewkgLBiF9vVj3Y3+oW0is8heP1qj9pHYP6lRP8aEcaNm7j6psT039CFDB1yWlb2rvVWSRsp7dh
	lNw0o8oAVLwJ2e6un0yMOujEmfqJ/pjY=
X-Gm-Gg: AR+sD100uACOMvrAxxsJDr1ar7cg0hg4du9lYG9f2Sk8CMtp/UDJCyS3ZsBk5udrM2E
	DcHSPdgqPOH2QR106OfcHFm8SGAwlFqRFi6ebIkgf7UFcnAsqB+43oBxuc35bVeCz1HPbkBmbRP
	yYqJ8B7yaXV0SRSiQhJx8iuBUMY6yd36GCdL8dL1mAkLlSMqhLnX69Vjxj7nx5CUifPq+OmBr8p
	rLoWqhnnogEkUo7pWFkwwt32aMpCfVIc4aVF+TqW0mhJ1LZ23zH6lkNQgqrwHyMN2BdRgljy5/S
	5JYsbRL6NXLqUVQ001wvlwn4sor+ZUObFlhKpHK6iCJQwNC5mOEDd2ZtB4iJ79iPYiM7g+4jlXE
	eTmKgbeO5VFw0gdDM89LYzBCEYELedWqcCFVC8BF/Cx+mDf/Mg6R6TPGgSUCOUJ0t6ziKoI6N
X-Received: by 2002:a17:90b:38d1:b0:38e:4e61:c9e with SMTP id
 98e67ed59e1d1-3933b168bbfmr5550525a91.21.1786734246673; Fri, 14 Aug 2026
 12:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1786710807.git.ben.knoble@gmail.com>
 <2d1424732af6af9c82c775e8256ea914204e8e43.1786710807.git.ben.knoble@gmail.com>
 <xmqqzeyoodxk.fsf@gitster.g>
In-Reply-To: <xmqqzeyoodxk.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 14 Aug 2026 15:03:54 -0400
X-Gm-Features: AUfX_mzTfeTZOoJmdO659xrnuYVD2qK-9HOxyeIKE8QIbdGUwzIqez5W4sUc17s
Message-ID: <CALnO6CA96y0g9iy+GRMV1v86zk3eKpCKxeJWid=097sFNXEknA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>, 
	Olamide Caleb Bello <belkid98@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > -#ifdef USE_NSEC
> > -     if (cfg->check_stat && sd->sd_mtime.nsec !=3D ST_MTIME_NSEC(*st))
> > -             changed |=3D MTIME_CHANGED;
> > -     if (cfg->trust_ctime && cfg->check_stat &&
> > -         sd->sd_ctime.nsec !=3D ST_CTIME_NSEC(*st))
> > -             changed |=3D CTIME_CHANGED;
> > -#endif
> > +     if (cfg->use_nanosec) {
> > +             if (cfg->check_stat && sd->sd_mtime.nsec !=3D ST_MTIME_NS=
EC(*st))
> > +                     changed |=3D MTIME_CHANGED;
> > +             if (cfg->trust_ctime && cfg->check_stat &&
> > +                 sd->sd_ctime.nsec !=3D ST_CTIME_NSEC(*st))
> > +                     changed |=3D CTIME_CHANGED;
> > +     }
> >
> >       if (cfg->check_stat) {
> >               if (sd->sd_uid !=3D (unsigned int) st->st_uid ||
>
> This is iffy.
>
> If you have core.usenanosec=3Dtrue in a networked $HOME/.gitconfig
> mounted on both USE_NSEC-capable and incapable platforms, what would
> ST_CTIME_NSEC() yield on the latter?

Perhaps "if it hurts, don't do that"? This config is definitely about
exposing the underlying system's capabilities to Git, so if you cannot
confidently do so globally, you probably shouldn't. That might limit
the usefulness of the optimization for folks that share filesystems
between multiple machines in this way, I suppose. Or maybe it will
incentivize folks to be nsec-compatible in more places ;) Either way,
users that can benefit from it will have the option.

> I wonder if cfg's
> '.use_nanosec' should be force-disabled in NO_NSEC builds, or
> something similar?

This does, however, make some sense to me:

- Git today with NO_NSEC doesn't bother with the USE_NSEC paths, since
we #undef USE_NSEC in that case.
- Git "tomorrow" should probably say "I was built with NO_NSEC, so I
will (continue) ignoring platform-specific nanosecond optimizations."

I'll queue this change locally until I send out the next version,
unless someone objects.

--=20
D. Ben Knoble

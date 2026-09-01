Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC84CCDEE
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266198; cv=pass; b=aB3F5f2Gms4d6PkuKbAE3Mm4FE90ThGcsP5+rbWRAPhQQVi+yfSvZ9jMdxVWpnxAL2FkQdgMS/03/XmynV3jlimQinn4JWjoL8UNjZEPsZ6IRfN1vkI7tEvj3D5tmSphyg3r9GgHkMD37uakNc2DLYSagliIbufcal9wLjNz7mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266198; c=relaxed/simple;
	bh=CXw77L2d/CbsMqhMDEAYhEB6o2p4JtPRk8Awf2U7S/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMdiF1WOeGH/NJuZHWA8d6pXk/S0V6iEKas2RmruvkiOGx4TeTBRF/aRCtHgIFmOpXwALI2xs2csNfoy0oChl8MkKv+YYxrg+foiuJX/FX1rqxtNWGRLL3jHGULs1c8Dt8HiZt9XBtmkqYlhjP6WYcb6nncgtrnCOf6rt3SD7Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGSks4wu; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGSks4wu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d032846c95so52903285ad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 05:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266196; cv=none;
        d=google.com; s=arc-20260327;
        b=AXnojvfdJ/XTyic4B7VCA0QHtXg3uI055+FD6wpbX/0TWUZs5jS2f7ekBU40PSLFYr
         o51zrhMZV19CRJIQh1dOXJzZPsiCRW+WQBBx/yR3BYoHaR4Yfd5oEZX+5rOQt7DNEdf3
         VAvqWNizNDhhpX5OVvxeVZMM/lUlYl0foQ8UeNf9saWfDthwd6mQ40kn5qMwdY5Vz1ED
         2xga02UFGDvtSAT3RqdWqD0teWncVms5Ow7PJ1FBg9QZWvhmRkTPUwb1yG8BMTT4aNKk
         voAmx/19hSbphIiey5CEVHSsnI3LOSniy2mx7tcBj4O0PkHhx4ub5+Lt+GvlA8qvAm2K
         Pplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KY6dyWU796DT8/cFGbOJnqgAj4hLsggb4o5twfib8Yw=;
        fh=ohR0hr/3s/cgHIKMyGWaarnhvQbgqJKZd8DchVsM6ow=;
        b=UjLf0t0/4icmCElZDUZkyHHV0Q7txsSmlpDeTo0nhNuN+LVevQEqdakg9yLySPQhrg
         zLh7kE2ZvMBtg0hSR8Vg4kD1h+zAoolQhYqjFbQRmMZinOa/15pB7p7zmaXNBekjDA9v
         iO56SuzYyIfDxj0wb55Xnf2NqJVeIeT31+JqIQ8fyjS0PuCEmwf3H4Cq1d8Y7/vDxsJK
         s1ddBMH9DZ636sY5iA3nMTsFRmMCcNx/JXFTNWOH6sExj4u0P8Wb3gHXCorCdLba7qJw
         x6XZMkWIzMrqTyo+rzt8XIGdm21iX/Ob9hIG9Rch2Zwlwd58hg5KuzjKqt5dLfe6LGCy
         QLvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266196; x=1788870996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KY6dyWU796DT8/cFGbOJnqgAj4hLsggb4o5twfib8Yw=;
        b=kGSks4wuxnN8+0gOyR9sgrCkzQNw2kARVgh3ppdNtG1n8eMTbKRmgr5t0/EfuHyxLH
         YE/y5hFB95u4gv0e5pSzvekt6uw9PGpuASFdLly/LWaIFRohHufO9dkCDmHFaSDG4SOe
         +wHC1i98PJHM222M8XASdm6Ywwi4ciLAog9OeGKaXPjy2WUdM5/E6rxKC1FMktCZ4uvJ
         VW348FcNJe91ABg0UexQprPpypC/N8We5xJUTLN/j3SixYHE9OwDNMhzvzNNqi18Nf65
         YRpI0Ki8aADaWtOvlpzAWOLlDReb1f6sjIdm7JU78EhusawjXjUxcTqNKmnuRKBdQKJN
         D+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266196; x=1788870996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KY6dyWU796DT8/cFGbOJnqgAj4hLsggb4o5twfib8Yw=;
        b=HL72rntI+FGqT9ALmg6UzxxtG2rktViSe8CEGJipuoD65xSU1Nvdx0deLXM48Dq3Nc
         yGlI1J5Bq36e0Kmfzbgv9uMjjEtNY2jJKJcbmcbzvrG+iG87qRCvsofxj49w4DnMh5V6
         keDfv3ivhgqfMSsxOBiaphEum2ShkCCcNf4uJmjjK1KxKzRk/SC0UfZd/9HPipYFCLg3
         I8elcLj3Y03xLTTtLc8xV2cJmb2BwTJnRTQMzS2gZ+SOLcaipLxWzAGNyTEJB1Az4R9E
         /bokdT6JjaoA8bne2PooY+geHfo6yM4et191ZsOPFX3GNBzIDVYlIPa1NmRN+WUAmqCz
         VjBQ==
X-Gm-Message-State: AFuF++nDpqHUo9vIGvtEEX9nGHsNgkiQQFk8kq+0AfKwfL1yR3wWheAK
	hYQJ+PIS0fukPZ18C6tGjqtZMB+XwRUXN4YVb56UBH4ThYCL8HCdOaA3qj0MCrKO6Yd3bFQJfMm
	vB5688a17mcYiK0EjNxL/JwmkWr+E2C0=
X-Gm-Gg: AYBFou3186MlM98aPo91Buub7SkfGxYqpdGOnaFs7IsCf/eZ01cMdQeh27jRt74ipdd
	HjnOw50PEf0fR2CpLj2N6iZbdxsJhw230A54hYzHo7SAkgZQXCQwVDl1YgZ+HOafCf56KleVfBX
	zd+/AwvId06QLhZmVUYQ6Z2/qmNvj9tym7Ol+ruAyAndjXeoK1x4R9OTJ9WYExLw6yP0nCttWLZ
	vKNYfw8gypBt0r0JhD0wXyoO6OobBHcN2j7rP2ZsdraJg9zM/SxbPUumBP4/bLsvORJudjLltQX
	Ocwkaawt8fRkWKNRm9IQnVKYRiKQOqk5oHM8EzHO0Zz3nILidfksda7tZdCHBryKgW7cwrRxleh
	cSwrkzjJC2VSeLdXZ8Nr4FLaJhYWDVMkXqWm91pTGCsGKzxEDBNlPEFviGfr1PGYl/3YWo9yz
X-Received: by 2002:a17:903:38cf:b0:2d9:4358:73ab with SMTP id
 d9443c01a7336-2d94a96743cmr113483485ad.19.1788266196308; Tue, 01 Sep 2026
 05:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
 <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
 <20260901045403.GA1075462@coredump.intra.peff.net>
In-Reply-To: <20260901045403.GA1075462@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 1 Sep 2026 08:36:22 -0400
X-Gm-Features: AcwNN1UrBzYY830QxK2LPTvRbBE1r5ugR5HzEfxRpchMm389QE4WOO3_AOgQeNM
Message-ID: <CALnO6CAZYvnv3fMWkU0pqY+XN3ncBqVav49ZEvzV0LMtmkYO0Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Todd Zullinger <tmz@pobox.com>, Olamide Caleb Bello <belkid98@gmail.com>, Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:54=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 31, 2026 at 04:01:37PM -0400, D. Ben Knoble wrote:
>
> > diff --git a/environment.c b/environment.c
> > index 6676e6f5ae..c83cf44839 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const=
 char *value,
> >               return 0;
> >       }
> >
> > +#ifndef NO_NSEC
> > +     if (!strcmp(var, "core.usenanosec")) {
> > +             cfg->use_nanosec =3D git_config_bool(var, value);
> > +             return 0;
> > +     }
> > +#endif
>
> This hunk made me wonder if we even need to do any build-time magic here
> at all. If your platform doesn't support nanosecond stat entries, then
> you're probably not going to ask for core.usenanosec in the first place.
> But if you do, I think the code still works; we fake the entries as "0",
> so they'd always yield a racy tie, just as if core.usenanosec was
> disabled.

At first I thought you meant we fake the cfg->use_nanosec as 0; it
took me a moment to realize you mean that we fake the index entries as
0ns. (That is what you mean, right?)

In that case, yes, I suppose it would work. Might be confusing in a
debugger to see use_nanosec set and checked, though?

> I guess you might be able to get into a funny state, though, if you
> build two versions of Git, one with NO_NSEC and one without, on a system
> that actually does support nanosecond timestamps. Because IIRC even if
> we aren't _using_ the values, we still store them in the index. So an
> index generated with the regular build would store the actual nanosec
> stamps, which would then get a false comparison using the NO_NSEC
> version.
>
> That seems quite unlikely to happen in practice, and there is a certain
> amount of "if it hurts, don't do that".

Hm, yeah. I haven't thought too hard either about the interactions
where you toggle core.usenanosec on and off, but giving it an initial
think they seem fine. Unlike this hypothetical case, when it's off we
don't look at the ns fields, so I don't think we end up with any false
negatives.

And in this hypothetical, by restricting the option parsing we avoid
reading the ns values on unsupported platforms, I think?

The build-time conditional _does_ mean that if your distro (e.g.)
provides a NO_NSEC build, you can't access the core.usenanosec feature
without compiling yourself, even if your platform supports it. But I
haven't thought too hard either about what it looks like to get rid of
NO_NSEC entirely, and I'm not totally sure if that's a good idea.

> But it's not like by dropping
> this #ifndef we could get rid of NO_NSEC. So it would not simplify the
> code overall, nor the number of build knobs that we expose to the user.
> So it probably is reasonable to keep it.
>
> I haven't been following the topic closely, but from my cursory read
> everything else looked as I'd expect it to.
>
> -Peff

Sounds good, thanks!

--=20
D. Ben Knoble

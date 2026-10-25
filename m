Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792937698;
	b=k480XbGJtbAGpzyh4ydCmSxTnenOrliYR3jImEPoo4nlWCrgj04X5QagQ/q2j9wBskm4
	 usYM9CqBxmFRrgSeWPbVloOi/l0pU8Pqh18vkUHvHHwHXn/BwybahsjJ857rI79XpwJzF
	 fWDjEr1QTcncB4CWtkSYGe+nIol7/jmAu0zXM/8ipHKCNO8Mf0dK+1tcxMu+lEvHmTJWP
	 aLUy9tusSg/CS29jgQz7JUbsbyCdWN/m2vdvN7ZBVhFTV4J8rhGxHvsIF8OmUdtv5Tq2I
	 pVieFMqY7kcnUgv5HQbr3xJ1UVPAIQzjchwf+14vYCqbXK1VfFMY0dBFH21tYRUukmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Nrkx/HSREElmg+5sdYd+3YnYSgbu0X8Mmjf3JCv3Zlk=;
	b=J9QThvtbssyYc0/lhuiWYri+yZGKs5ogWUYspuScWP8QejDLr7ocgcNnC+9kOiH/3khB
	 A+/eU7PGdfdEXOHeshikcLm1rg+67o/RyRCJ+9cMgNchyyyoeliVu2ES7TuNiF9pO9vdE
	 ncqNV3pjLvsGbxXmzoLYA/RpPuesKDDXPeaYzgiF8PpET980f2BOX4Qgc1St/nqOPtWwB
	 7CFukYROme+MoMI2oAX9J1I7dfsG29gyWK7YilNigYjga0dVh65qcW8+CPsS42G05hYr1
	 KTsgvcyS8qPaLmr+cxDA7bOv0ysJgVw1hA2KOoEB7o+QRfdW1gPpEjp7G5Rc1lPnJVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNVs0uhH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92472606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92472606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hNVs0uhH
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2751592a91.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 07:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792937698; cv=none;
        d=google.com; s=arc-20260327;
        b=NXvdqGOhkL9Mq8n67tO6gN0QQ3cMJgRi0INEkXdfjJnmOUppTV4RXlo5IiTb8DRlp2
         oa6qx6f5f2rYYnTRockrh1xMOOEgQELL5GDLxDRH93IdPEJKzNLpvf7ln9/H95AGqQu5
         ZTDiCJp2Wu2+XC5cvnKcYxiiFYLmLIzXTCtf1b1qFtRmXlzLfVXkxeG5/bddrDGJiOiG
         ZIzdZPse2+CXfJGCYxs3uU2EzYZ2HRYgJ4q15NvpUDLc0eFDRUv0PhSwjXl1FuK9vdAb
         6Kq64ysxHnUhXctQc5az1eFUVTkItiYSkX8209g2/Ee/JJtg4DlwZScBJzQ5ggAIkzta
         3uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nrkx/HSREElmg+5sdYd+3YnYSgbu0X8Mmjf3JCv3Zlk=;
        fh=UBOJTmzfJAC+jekJQ0nbVwwxAczvwMoNUKPTNAYQphI=;
        b=N7DChGPdPF75R4RsE+aNJQuaB0JF/lN5B7CFJ/RDamvHXJnLftJZO/dPcLj33o/s8Y
         LYts/ASTecTihg4ETSrC0S/MD5E46qfAecuvsUer5FSYRJ19O444Uk6BcENb1e1wsq3G
         MLGosFSuO/PVEpCJQUlmT7IzvCH+T3a5S/Mluh5DvIwQwfkEsMnQmvtRjzchn5vnxtE0
         J3Wh9/aBGO22tdmLGTdgxZ5ym/MdnxFpc2J0S3sLyaxVE05hjGVNDr5KMmbONYsof2h9
         wHZVlloYc60+fFuzY89M/MGefwW6wqAEcCc8NufUVNQyjRmADxfM4kqyqAm1qcqSjruw
         SxVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792937698; x=1793542498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nrkx/HSREElmg+5sdYd+3YnYSgbu0X8Mmjf3JCv3Zlk=;
        b=hNVs0uhHIby59OGEAeu4rx2LPmEQW/Wllt7UW4Falm4AvYwZTaibXAtFYr40RWC3gh
         ePmuNJKSirPzr+RxRdAFgI+sT8aUQoHxU+nGNfBV+l63wgHTy2MD0ibB/oyN51ov+OyI
         E+wOXQA1zW7yMaIbHcRWDVv1km//eRK3ZjBjyf96woS9Srh9MHrJQ3fD2r7wbAxbrGvO
         X1NT25YEhQRZAtKDftaNX3kZrIxOF+FI/F2SAmseKx4jiE+X9Nse7FpEvNhGfxQ+zPDe
         3bS9JmCTCSZLbXi6LB/JTI157Px+zn+Vw0s/uYmtqG+mdoXPjcfEwM+eae3a+5CO+ULa
         rG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937698; x=1793542498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nrkx/HSREElmg+5sdYd+3YnYSgbu0X8Mmjf3JCv3Zlk=;
        b=vGgS5VXh5I8wyVltzevEul8Sin+WypvNb3WentJPuiIQKvaNdejvzhMclAFQItXGi2
         NDPN8WTMtCz6QB7SbLkUmkZAIbdkETnmTnusCsjG3PjR73JHWzM3jKigAq/kctPcgDFw
         n7Hs8mguZEmRoke9kAy1wxVnRAFQjMF6eVc1N0hsNZUHAbSaEmPcSJGZK6YzoXUZGMES
         0V+He+JdUvcuqS6WoBT/juvIAwN1gCn8tdH1wDKjlMzbZ81TB2an3gA+ptAL6vxCrQKQ
         ds8tXHrHwTRWWYXseojc3z+k/cEKGZNq8B6ZdZvnh7YxdhfKxnPktrTPBkPGjnoTZqlu
         IpVw==
X-Forwarded-Encrypted: i=1; AKwUvBzFz2Z97VYeFCTVVl1wAE3PbkkmGrLifVOAgtaFVEJRgdT1JSKSCKrq0I3ri0j6CypSuG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+RZef81zO2uY1D85ul90JZAG5krtXNBPzf/koQFttzA3/2Vlx
	mxsHXRPgvSHVqub3SKa21JR4TPlKwke+DuKd71gX2MtdsiPROG45UA3eRj/AO9UPK5J0ktangW+
	OPvTQAqMgZHBkq8nzydxw8NAbwzHF8g8=
X-Gm-Gg: AYBFou0UH5Ho5KNeRkfvUnOR369fYqOHBHlYi+L/hI+LxS4WN6sMPPyXmftHe5+JMQI
	WWYUJK0kFU8pZNn9GQyhIMVBXCfKDXLYRQ+l77fRmH/w/S5TwVlGotvCRF3PeBRBHcPZ5LQ60Sd
	eqRTe0FDEULtQkhDIjHdD4lP9HY/dtOxIXLPxoCvSRalVTVEtmc7ZvkSFAX7XsatS72+ngguOfz
	nJxwtaRjyWbjQGpsv1qtSbdiuKHusCvoxa94E5e+dAmyfPBgyWMd66R2k4oasvzVb+XvKZGYb9Y
	3iRtwnEnMsBfKXbr0iTqXRQAe8/Ue5p6sBklqKlf2/lKRaPTKFWqaEF8GmWU0WMvtvqXzORwvgb
	Obxb/hI6iP+c9QBWs9fu1jDI8tyIJ/tKwXvQppvbk+lKLF6fKTdXw5nabi4stfLLajTZvmJZgZZ
	Ri5OpqH29ftK0/n0YrW25Zvf3qt7etalAJdJMeQovpOgOBBfwvJvhO85faiqW7xKmR7g==
X-Received: by 2002:a17:90a:ea94:b0:3ad:fb12:9bf5 with SMTP id
 98e67ed59e1d1-3adfb12a171mr1994991a91.62.1792937697843; Sun, 25 Oct 2026
 07:14:57 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com> <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
In-Reply-To: <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 25 Oct 2026 10:14:46 -0400
X-Gm-Features: AclHuK9SmbJk6EwQiITaAXIbF4BlhWKrEEwP1NnNXUZRpMSKgE9rEKOz-CMSFg0
Message-ID: <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 1:19=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > remote.h says this procedure does "For the given remote, reads the
> > refspec's src and sets the other fields." Ok, and glancing at
> > refspec_find_match the idea is that "refspec" input is a query (with a
> > src or dst) and we find the matching entry and fill out the input's
> > fields.
> >
> > So=E2=80=A6 I assume the usual idea would be that refmap is a "superset=
" of
> > the fetch refspec, since I might want to map refs that I don't
> > normally fetch. (Or it might be disjoint, if none of the mappings
> > apply to my usual fetches.) But that means that remote_find_tracking()
> > won't be able to find entries for the mapped refs that aren't part of
> > my "normal" fetches? Are there downstream consequences of that? I'm
> > not sure, I haven't looked at how else remote_find_tracking is used.
> >
> > Could that affect, for example, --delete-merged?
>
> Good point, I will change it like this:
>
> ```
>  1:  ba7f1354cd ! 16:  4603c84d68 fetch: add remote.<name>.refmap
>     @@ remote.c: void ref_push_report_free(struct ref_push_report *report=
)
>       int remote_find_tracking(struct remote *remote, struct
> refspec_item *refspec)
>       {
>      -  return refspec_find_match(&remote->fetch, refspec);
>     -+  if (remote->fetch.nr)
>     -+          return refspec_find_match(&remote->fetch, refspec);
>     -+  return refspec_find_match(&remote->refmap, refspec);
>     ++  if (!remote->fetch.nr || refspec_find_match(&remote->fetch, refsp=
ec))
>     ++          return refspec_find_match(&remote->refmap, refspec);
>     ++  return 0;
>       }
>
>       static struct ref *alloc_ref_with_prefix(const char *prefix,
> size_t prefixlen,
> ```

That does look like it would fall back on the refmap, but to be honest
I'm not sure what is "correct" here :) I was hoping for more
discussion of the questions I raised to see some thought about what we
should or shouldn't do. I suppose falling back might be important for
the later step with --limited-fetch, though?

--=20
D. Ben Knoble

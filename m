Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1720DD72
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651589; cv=none; b=Iu3oK+F6Rf+1m8Je11yVy01DFQ/RXQaDpvZxvqGVHG42sC7N452CasdWpjdKHtsW6HLhPuMyLgWt9K2ZrFA/rfH3w9q0aXqpVu9n5CjZRM6q+ZmSkWfXmyArpou+/7t/gT0OAjdea/Ckt3gBm2VqQ5wMcBaUVoSkN27aPtMxbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651589; c=relaxed/simple;
	bh=7agdt18lwIE3jUqY/cwxYwr8k+vK7ScmCMGXVBiI1o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7OxWf0YrteIq7fLyWqx/yebOBgZTcQHZlXIYz94Yyvjf7fFNmtoOq9MFnOYZLEYzusCabzlQa4QpoCzMcOmW3o5I3CsqyaLOwnvyVclv6Y7e/5XVhb8VIvwXWXnaxexSuGa15MIB3ifiDIZVa+gx51qPi1bC8ECRbF53cwpmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=calmm8iR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="calmm8iR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso436388a91.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767651587; x=1768256387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+rft8pXgNh7XjHSkyfVHsoV0NL1PbmypMm4zGP9vws=;
        b=calmm8iRhtL/rOhXp1Fw3M70lWGU/vERa1fSBPs3D9r3TZcm1sFA6gd3wWH3PeMztj
         tqDsvy9yY47NDnRiS6dxbdG98K5E+6R8Zb2jScQWBKcwn+gxJbqsiFZnSJ0OJcoF0bK3
         OmXyRDBoADqnukbKNAoejyDV/OrNjVKusDmpKo2v/SaGmRiFMEkQvgiKN1MGTpKxshSl
         s5VvYs8ZcmOpO347KSsjIjG8y8uofx3gjmcGUF/j6YRorWGlZXIfdPkzHgidxQxhC09H
         wxOe0XebbN4VYpP21dyyfcDlDI9+FRs4M2yitPkMSXiW/vbFgrCfcVwN5uuGTLbMTOML
         zU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767651587; x=1768256387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+rft8pXgNh7XjHSkyfVHsoV0NL1PbmypMm4zGP9vws=;
        b=mjEEeBsFBuN5HsLxff+mJ1IZIRuIVobwhWuLdJPpVzssqDSh8Z0brdagAqdbjY7kFD
         O5FYNaGWCvFjOGdU8n7GwMEG0BEmokn2fkkwyHaZWW+Fs5QMMIoZYN/wahPiWbKO6dzs
         bm8F+8kDWkuA8ZL6ZGjIwIGn9zB1RmWt6bPuqz6lRJVayiYYy6WC1VxfYtGdeJSsRL/2
         Rn6xliuBJNBzyQLINK/H/rt0huyGeLe9xy7VNWlTxNhIlZga8KCv40RMgbopDrer9om7
         PwGN/PtJ98Px2Lws712TVF+UhkIre3SjWg0RoeJnS8Bts5fUKVKxa9h3gEiPiDdNmV0X
         nSEQ==
X-Gm-Message-State: AOJu0YxAc8rHM9I0PzhaPmBE0DMqAaRAl4M9BKJe9SAZtMVlUMlVQ7/h
	ksz1/kn9VY5a2d0RduRE8jgLL9+NooI1JnLlffKGQxmpEvvsGRFB1w44ZBuxW9XrSNmN3jcU9ux
	G2H/zCNgu8PPfW4Xo/KWZRDRDCHLGCucfpw==
X-Gm-Gg: AY/fxX7BKYwJAydThYJLPDDf41nAnl+FTJ3fGVL89MPTIjyC3kvT1CUtHUJEpg0IUm0
	wkhzOl1MxIh1Jc7q42rLI19e6Zf8SHlQAX+5/Cz9g01BFgJsCW3+GDH8yXGNDisXs5O3JDqNRdk
	MwguczgvPn0Yu5+FtWHhlFAVeXRBH3my7HuuWu25YHoUG2gPCJjMC0X7cd/TOan2wveWRd5x98r
	DIq+PVdJrMM7E/CPWgwjtH7bRSagqL7ovOgnvq3c19S2QEVuwJusIpo/bV5tutYh4QLao4rrFeb
	/ju8YU0=
X-Google-Smtp-Source: AGHT+IGnBAEJjlncQvbaVhvgxiVtrorxaA1TWboLDIWG0YEgfsXxVBTh5yJrBebAB4tatYdEPMWqgo/ualSeDJNKTa0=
X-Received: by 2002:a17:90b:1c07:b0:341:2b78:61b8 with SMTP id
 98e67ed59e1d1-34f5f301a25mr550620a91.20.1767651587016; Mon, 05 Jan 2026
 14:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHwyqnWwJuD4T9tuCArW5eY=rPCHKT71LroRRx-aYfDGwr8E9g@mail.gmail.com>
In-Reply-To: <CAHwyqnWwJuD4T9tuCArW5eY=rPCHKT71LroRRx-aYfDGwr8E9g@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 5 Jan 2026 17:19:36 -0500
X-Gm-Features: AQt7F2qWu9nrleEGtMOBINaAgIrECjSSGGOiDeYgVirIXcSvrKls6SdModyj_sw
Message-ID: <CALnO6CB7-w0tNMiYn5=SCBow637vRRrKRj_9k1h1DS4crJaVtQ@mail.gmail.com>
Subject: Re: Triangular workflows
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 2:43=E2=80=AFPM Harald Nordgren <haraldnordgren@gmai=
l.com> wrote:
>
> Hi Ben!
>
> Did you ever get to this? And does it match what I do in the tests for PA=
TCH v10:
>
> ```
> git config remote.pushDefault origin
> git branch --set-upstream-to upstream/main
> ```
>
>
> Harald

Yeah, that's definitely part of it for me. I've been meaning to write
this down elsewhere for a while, but here's what my setup for
triangular workflows looks like.

First, there are typically 2 remotes (but not always!). In the
examples, I'll use "origin" (the place I usually cloned from first,
the most official version of the code, etc.; also the place I pull
from) and "benknoble" (the place I push to). The setup works just fine
with a single origin, though.

Next, I globally configure

    push.default =3D current
    pull.rebase =3D true
    branch.autoSetupRebase =3D always

The first works with other settings to make the @{push} ref work (and
to make "git push" work without arguments). I really like the @{push}
ref, and I'm not aware of any other way to enable it.

Then, when setting up a repository I configure remotes and make sure
to configure

    remote.pushDefault =3D benknoble

(if there is such a remote).

The next step is usually starting a branch:

    git switch -c branch origin # or origin/main, or whatever

With the above settings, I immediately have
- branch@{upstream} (@{u}) -> origin/=E2=80=A6
- branch@{push} (@{push}) -> benknoble/branch (or origin/branch,
depending on the case)



--=20
D. Ben Knoble

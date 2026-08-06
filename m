Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8E3DD508
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001505; cv=pass; b=AkrLYlqVPgYon6GfwY4trr2V/a8sJJz95PbhJYcCZNy1kFIJsjMtFIKaopqzgQD+siaIS80590LzLlz1ZeC71ZZJ6J4tdV4PQQp4jEpvQCgdeD+/L9Jry2sX65VydgAyLK1Kl9t/kfWsnrUs6/neVyOvVO5I4UtvvzKLsnJKzFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001505; c=relaxed/simple;
	bh=PwnQQGH4vZE7gi8JvrgmYk9oc/2JFEljBYnRsEHg4vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwE6wSK8jJjF4Mx34C8sG3b0+IAhuU7zMrzdxY2t6kbEJUntxJ3vroFp7JMw1d1rw9gBnUXHJaCiCXQIq1BTGxoGrkCWu/RKxc/1B3sUp+8SQ957bDYHvvuNVvY2m7KmcPrYeQf/5wrf0FMAF5WVgNLz3jVsZGI+K3CNiMjKOWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPGfKJJx; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPGfKJJx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso1696093a12.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 00:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786001496; cv=none;
        d=google.com; s=arc-20260327;
        b=LlCANN4f7ZNJZt2FTFxvuq8ZgStq70E3QeH0LtyafuPgsoUkkTXsqA6DgDrrn2UjQY
         zBUcszqaAw6hvUuaIKi1O2A55SNkgVxFywm2OubaqpPWS+FmIj4+S/+2gfRbD6Ybrinf
         TubtpHzE+4/NXn+7kfJPW5hkvUZCOpsxiH5Dh+DwrgadNJA0MGLjAjUGGzxKiu/kgk18
         kD+dyAxoSXtqSqGD6pLnAsYWbJxZv9FwXmf6blTz9dJdTTQ5HSirM/n90Ulsqw+S+l7T
         Fq2UzVkiOZ595qSk2KvYRns4zO+jFVWWFdUTfOQgH9YHxs8AGppLBTrufXtMx87uT+X0
         V59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mmwHz+smBW1LFh6aApKosoZkVYYbuMZRoXGQnQlUr2k=;
        fh=Jp7jTIzcDIQ/Qdv2pPENQxOkkisMUMeYta3Wdo78fac=;
        b=IiBLRrswJGMgdrIa5c1EUmGnr9ShPoqVfrYAkiZmyWIA23+ZlsCVxnTf3H8OA87j6t
         LPfQyF19qq4jkr+W4bkvK2iCsyw+8xsRtgG4g09ROL8ga0zuwhCrniS1/JZ1mosE1tqu
         DHmDr3KKg+chOP0JorhKDqLCzCMo/y2pPr4Edl0f7tNGzWBisMuHZVC11j6wqMLFGX7b
         tj/5vZ0I7Pi5x9MJPPtWO39hTW74U/y+mOY9g64ODFbHVYA5c3D1NwkMH7q4M/QaDqdo
         h60T3ktCaOgpK7Qykz2CtPukFFpE4HTs81zkBJp2C0i0dodmwlwIGOS60GxQ0qW3Sh0v
         CKIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786001496; x=1786606296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmwHz+smBW1LFh6aApKosoZkVYYbuMZRoXGQnQlUr2k=;
        b=VPGfKJJxuTvaQKrNcIaxUvZA598Gct+9JJQzOBYHA0mRKE5u8Me0lVzOLWiyQWLycM
         in8Bj9LGk14Da9c4vBB6IZvHbDolHp7G05YvZfk22/nZlobVRsa3R9vUnPl9qO1K/oEf
         XdJnmX2c9pSQQHlyrT5FSmW5IWVYWn38Y54EnIXHKgAmX2WzVYujM02YxoeTzMgej/Rv
         i1yomlt8tKL7ZNC0zl+guRKCHBT5cjepVOVgzr+LyWdJRvdsMKstuAet71gvOrfeh+Y3
         ItU1P/rPPdr5pjOjD6waWxKWy8N3qQsHfPZhVSFnsalHwDhAyACfTQfTd7LWFVW0hfzO
         1B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001496; x=1786606296;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mmwHz+smBW1LFh6aApKosoZkVYYbuMZRoXGQnQlUr2k=;
        b=Hx8gyjsy5ed2uVfPO/e9qK2kzpRnGktvECqOAl0PUNdY8jTIBtD033m6drdGD+T3pV
         Zk8JKpyZ+2COoWR7soxnXZpJRDdcphS31ewMeGKMQFru4C5/aXVjD2850tLkQWDP8ofr
         0srgEuQ/b8wny1ssb5rwhqmuY62Uk5hepxu/ew9FR4c07EGARXqdU8YLpM70sTxt0AoX
         3575wHHhSqg0XsxlSys7OlvZs/FyTs7hUPrveuSSiEcqXHKQUryHrIQW+H3CQ8fV2f8y
         6czU/MkbV4BFq9XY5bh7EpP3L06pID+2+JOHD1++i0W+o/9xMpj2HLraqmM2FF6QSGcO
         qUVA==
X-Forwarded-Encrypted: i=1; AHgh+RrDsNYBtMk5b59+pXPNoMo8fK21aE25KrPamhho34h9mhIDvLMenmj6iqlvW3UIkeNKFDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/XAik5gGFB/d8Me/aUgD/MULGUaKHFvimoHHvLNQ3Erhv2pp
	JwhPVPTAAMpeMqLFTcoCCg+dLDEqis5CmEIlAklVjGIPAf+xIpNruP6qaelmZMYTpNV/msJRmeF
	AzgvELd0ItGTKUhc4gxpNwCxSm0So1A0=
X-Gm-Gg: AR+sD10CNi2UcdyPaC6p2rn4gcq+fGrddKPOoq7audBzCzF+HIoa4ZBRO3BdrvS2BN3
	tZcLhtczx30cT0h9J3bgYN0+Pxde8gir5iuPfvdESYhexnRQDZA87rLNz34naoQ5BoTpKELS5Un
	2MRpxdhLEUea0I8KG/VdDIhRwbByVX25DwfRmS3ASfHGXbRTU6QdUTI0PyioLJv1c1IKxh479iT
	av3rBZm99VRUxraW7LMuvdAlAAL971Ap1Bivq7+Mzd7yQ11LhDT3VfKGs6CFCoz4cFrcYKTZ0OX
	mEyKWMJVX/9hx0ZUx628qR1FtLVptBCahfFA5Vbo33BeZzVr7WUaWwY=
X-Received: by 2002:a05:6402:28c4:b0:6a0:927e:39e4 with SMTP id
 4fb4d7f45d1cf-6a14f09aa8emr6629135a12.5.1786001495699; Thu, 06 Aug 2026
 00:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
 <pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com> <97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
 <xmqqjyq812wr.fsf@gitster.g>
In-Reply-To: <xmqqjyq812wr.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 6 Aug 2026 09:30:57 +0200
X-Gm-Features: AUfX_mwQw0s--sZG-6P2vR8pUkD6XoesIIbf4UUo3W84O6Kbp8rWqSkN6eHCWC8
Message-ID: <CAHwyqnXOno2De_eOvH=LizyfWSpyVWpzGBwV4ZGW4bxOEtETOg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> > @@ -682,7 +761,8 @@ static int bisect_successful(struct bisect_terms *terms)
> >       return res;
> >  }
> >
> > -static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
> > +static enum bisect_error bisect_next(struct bisect_terms *terms,
> > +                                  const char *prefix)
> >  {
> >       enum bisect_error res;
> >
> > @@ -705,7 +785,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
> >       return res;
> >  }
> >
> > -static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
> > +static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
> > +                                       const char *prefix)
> >  {
> >       if (bisect_next_check(terms, NULL)) {
> >               bisect_print_status(terms);
>
> The above two hunks are pure style clean-ups.  When having others to
> review a 500+ line patch, you would want to omit them or move them
> to a separate preliminary clean-up step, to avoid distracting them.

I'll remove.

> >  static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
> > @@ -1489,7 +1614,8 @@ int cmd_bisect(int argc,
> >                   !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
> >                       usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
> >                                      options, argv[0]);
> > -             res = bisect_state(&terms, argc, argv);
> > +             else
> > +                     res = bisect_state(&terms, argc, argv);
> >               free_terms(&terms);
> >       } else {
> >               argc--;
>
> What is this change about?  We used to see if the given terms
> (bad/good) are sensible and otherwise barfed with usage_msg_optf()
> that never returns, so we did without "else".  With "else" you are
> making it more explicit.  The value of such a change is debatable.
> Some would say that, just like 'if ... die()', it is already
> explicit enough that 'if ... usage()' never returns and does not
> require an "else".  Some would say new readers may not know die()
> and usage() do not return, so "else" makes it more explicit.  My
> stance is that we should not optimize our code for total newbies
> [*], so I may have a mild preference for the original over the
> updated version, but it is minor.  In other words, I would not mind
> if an author wrote this either way in new code.
>
> However.
>
> If an author is adding a new feature, I would recommend against
> making such a change that would only force reviewers to read more
> and think more about the change.  Do not waste reviewers' attention,
> which is a precious resource, to something much less relevant for
> the goal of your topic.

Good points.

> > @@ -1497,5 +1623,15 @@ int cmd_bisect(int argc,
> >               res = fn(argc, argv, prefix, repo);
> >       }
> >
> > +     if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> > +             enum reset_when_found_mode mode;
> > +
> > +             if (read_reset_when_found(&mode))
> > +                     res = BISECT_FAILED;
> > +             else if (mode != RESET_WHEN_FOUND_NONE &&
> > +                      bisect_reset_when_found(mode))
> > +                     res = BISECT_FAILED;
> > +     }
>
> Are there "dead end" states, other than '1st-bad-found', in which we
> can no longer make any progress?  One thing that comes to mind is
> "you said this one is good, but that contradicts what you said about
> its ancestor that you said is bad".  I wonder if we want to do
> anything special here, just as this part of the code handles the
> '1st-bad-found' state, for such "dead end" states.

Maybe, but I'm not sure this topic is the right place to dig into this?


Harald

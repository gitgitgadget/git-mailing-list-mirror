Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374818028
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343303; cv=none; b=rD4EWMMm7VmZmhgm5Z3fwNwAkwcsbNKKOr8noBzy1zle8rbrozOCv6eJIRiuVsC5G6EpV3N6GOJcE5wczUmltmB2WLJXti1rzxL40+WN5yTw3v16x6tgUjhONdGH+8Hp6YJxzYUdHf39p8s7+yK4DxUHuCn9rD1K85obU1S8q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343303; c=relaxed/simple;
	bh=zUulxWPcg5Nd/qd20FHilavdJr0+mrcjE0hZqCEDPjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i76+lvGE/SuNXBkaqUh1XokB5UlNOUSjmIXYpFZrIIZmanlTf+IiNs4QGhovDOH3kvebBelExPEdDtqRz8b2D9JngV1/njwRvEh22kuKXuX29f1P/BxQs6saxTxu/q9F48Bx2VzOGKblVVJoo4fOe/DzsJelNu9KaVSCW7q8/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hruDXVNl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hruDXVNl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so1500785a91.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725343301; x=1725948101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If0tOP4/CPMDbffc2IHQA+39kZ1zZEhun1t6rI5GHGg=;
        b=hruDXVNlM56SN9M1xfyJlKFD1a3tilROvfm3uUcl3cbEHITDCDM8PDn4uCQtXqSgbO
         y6RQg/RsHWqyniE8yA+DchhjrOH+erPoMYC9PnlVJ1u+ozkw638Z+pEQOm0NE+HwSnM/
         CjJOtbUDj/PN8SezVKqascydYXySvM7X4mO6xo+Gm6b5uUIIcotfEXGyRisYp7hp1DNl
         gAXQgWYPBDiMn8d+wiJ9OOh9bqC+2pchrlBHeaxDdeUTxUPpzG+Pt6l6Sc50GDuQQjRD
         pVWZC/LFXWSN9oYkwhLWgMhEdD6ZgvA20NncDMGX1nXJGcO5wEDZONVam31Nxca7MLon
         rsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725343301; x=1725948101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If0tOP4/CPMDbffc2IHQA+39kZ1zZEhun1t6rI5GHGg=;
        b=rOtP5TWVigKq9MHFoRBcnjfbiuW7vM8UchA0Xjm0rmNR7u0gC7muHu/ArGcA4br/Ke
         x3h+Jgwxoq0A50Aw53KoZEJVLJMhDgUBkb0Q52NMzWP98zTDhgykQxKsggdTe2Gs0YaC
         q3RpGfB4mw5sir0ya7SBOqZ7k+swEXGSttEl5lP44Jk3wvWyF+2CQwumdxo/0Xi0RY/8
         +vpUcQbHGfY2C2h2/h5KqQzHpT450OZYfR/tDLhRkQSCqTDqGPaqxoStVuRs0vUsBBwk
         9ld13x7gMpQxz3UL4lef3Iv7UkuaauSYBtGJuTsFpJnAGOBo533Eo3HF/NHmPdRtJhGT
         Dyow==
X-Forwarded-Encrypted: i=1; AJvYcCVPZuWHhcSda+Vj4Jd5+y1ysCIRcjUG9p6/JLRsTA1P7Sh5Z2JU+ZNcquv581FdeGGzZAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cILFNwPDSqdny/gIe02xoMeSStyrZXNGP9VOG6vyZUFNVu2Y
	TBFwOhCSqbduRc9nkpqXTfVYa3civoJpL82OgilgGg8xNbgIz/pgNpmn/r/GJde2VfWzvV6c4Zz
	yE+Y7dXiVleD26PE1hmcGQ0eGnrw=
X-Google-Smtp-Source: AGHT+IG6pPti4ergEb40fmCIXvris0PGGXXFQJ2p2OtTiZW7s0eLw4K9HpcgD4n+02LXc6Xck9WglIZ04ywaVJs6fww=
X-Received: by 2002:a17:90a:b111:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2d89051e390mr8009871a91.19.1725343301202; Mon, 02 Sep 2024
 23:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki> <xmqq4j7438yc.fsf@gitster.g> <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
 <ZtacHCuql0pX3V2u@tanuki>
In-Reply-To: <ZtacHCuql0pX3V2u@tanuki>
From: Shubham Kanodia <shubhamsizzles@gmail.com>
Date: Tue, 3 Sep 2024 11:31:04 +0530
Message-ID: <CAG=Um+17JYyqC6n0gU3GSNaVz1PaB1U50M1hy87zObB+Rc03Qg@mail.gmail.com>
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes to fetch
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Sep 02, 2024 at 09:16:24PM +0530, Shubham Kanodia wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > > > I'm not aware of any discussion around this...
> > >
> > > I do not think so, either.
> > >
> > > I agree that it makes as much sense to limit prefetches to a subset
> > > of remotes as it makes sense to limit to certain hierarchies (e.g.
> > > excluding refs/changes/ or even limiting to refs/heads/seen and
> > > nothing else).
> >
> > I'm seeking advice on the configuration option structure for this
> > feature. The typical config format for maintenance tasks seems to be
> > as follows:
> >
> > `maintenance.<task-name>.<option>`
> >
> > A natural extension of this for the prefetch task could be:
> >
> > ```
> > git config maintenance.prefetch.<remote-name>.refs refs/heads/master
> > ```
> >
> > In this structure, the 'refs' value represents only the source part of
> > a refspec, and both remote and refs can be configured.
> > Specifying a full refspec isn't necessary since the --prefetch option
> > may override the destination anyway.
> >
> > While I've successfully implemented this approach, I'm open to
> > suggestions for alternative configuration options. My concerns are:
> >
> > 1. Most Git configurations are nested up to three levels deep, whereas
> > this proposal introduces a fourth level.
> > 2. This configuration appears in the config file as:
> >
> > ```
> > [maintenance "prefetch.origin"]
> >        refs =3D refs/heads/master
> > ```
> > which might look odd?
>
> Agreed, it does. To me, the most natural way to configure this would be
> as part of the remotes themselves:
>
> ```
> [remote "origin"]
>     url =3D https://example.com/repo.git
>     fetch =3D +refs/heads/*:refs/remotes/origin/*
>     # Whether or not the prefetch task shall fatch this repository.
>     # Defaults to `true`.
>     prefetch =3D true
>     # An arbitrary number of refspecs used by the prefetch task.
>     # Overrides the fetch refspec if given, otherwise we fall back to
>     # using the fetch refspec.
>     prefetchRefspec =3D +refs/heads/main:refs/remotes/origin/main
> ```
>
> The prefetch refspec would be rewritten by git-maintenance(1) such that
> the destination part (the right-hand side of the refspec) is prefixed
> with `refs/prefetch/`, same as the fetch refspec would be changed in
> this way.
>
> An alternative would be to _not_ rewrite the prefetch refspec at all and
> thus allow the user to prefetch into arbitrary hierarchies. But I'm a
> bit worried that this might cause users to misconfigure prefetches by
> accident, causing it to overwrite their usual set of refs.
>
> > Also, hopefully my mail is formatted better this time!
>
> It is, thanks!
>
> Patrick

Interesting. I guess if we put this in `remote.*` instead of
`maintenance.*` what's unclear then is if this setting should also be
respected by `git fetch --prefetch`
when used outside the context of a maintenance task =E2=80=94 since that'd
probably be a bigger change.

For instance, the `skipFetchAll` remote config option seems to apply
to prefetches (within maintenance & outside) and normal fetches.

Additionally, we'd need to discuss what to do with backward compatibility:

If we were designing maintenance prefetch right now, it'd probably
make sense not to fetch it for any remote / refspec by default unless
explicitly enabled since
fetching all refs can be a waste of space in more cases than not.

However, since the current behaviour already fetches all remotes and
refs, I don't know if breaking this is something we could do? If not,
the behavior would be =E2=80=94

1. If none of the remotes specify a `prefetch: true`, then prefetch
all remotes and refs (backwards compat)
2. If at least one of the remotes specifies `prefetch: true` then only
that remote should be fetched
3. Two-tier `fetch` / `prefetchRefSpec` hierarchy to decide which refs
to fetch (we can decide on the name later as `fetch` and
`prefetchRefSpec` seem asymmetrical)

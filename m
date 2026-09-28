Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5E4CC262
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602980; cv=pass; b=Gubbnx5XR4GxrboIU5oPsgdTNA4tDcAGaSxU8jZbLw6lhnpQomr4KIo9TAwjeedK7NJm02t8sispSRsFJmlP+jkhnKfaef/Py4B403jZN16PnR22OI9ediV4RQ3bT9P1a1JDm5Z4hic/NHUcFKpCsavdxg6VZNCU8aAVPqPXG0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602980; c=relaxed/simple;
	bh=WPls+SFrlLxBaIybw0j8UVHqGp4xLvfKH3GOpI/4m2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4eICBr/UzlLXfeahyPFEIb3aoZsqzMT02swHsSpgmvkufdVE64q7BDbOcAFmLy0IXLtGvElgpfp9EGHaAMMkFneTKxxAid1tpiUtaElbhykstFcEIToZKafDwezU5Nhr32NuebGUV5q8401IhhxGNqP82RXApPuAOxupf1hx+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7OxGrpu; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7OxGrpu"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so2522823c88.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602977; cv=none;
        d=google.com; s=arc-20260327;
        b=GFBNIr9jdmi052UGqDtpoIUsOzOsMIoo2bFiLsANtcZJfoXT2KAey4v2d3JxqL7SaI
         x+S5rlkVK/0o7UC+5sDm4tEsBZlKIIO6TBDsvXusjAUoBjNFSoCBP8w2Fb3SypB+uoC6
         HCkY4NFNZ0ZywlihC9VJefb6iHfcc8Kt2EKsRCSVOMNzh7yo7ZX/XBJnyByZu8E/ba2F
         Egaik9kLLzzu0Nqld2FYZz2pJg4Y/uzEVRnjZALKBKeWNi53UjlNahtw95e76y6eGnX7
         +YqRvaGNEzxm1ks6ukYLDjaOfoOt8/kRJgaOCQ8n6kz5j7CYyLjZm6GjtPAFXohLeBTY
         UfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JWiXCYKo1ajln0FQJI6NPTbrxK/UeMuKyNgK4q6K2cM=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=QZ0iVmSGex5t2CN+nEws00FyxSEidFTKO+s6EifxFt09ka3x3x969e8ZrDQdTbIZF8
         yV/oXrpE7xaL5WSI+N1YnpnV0iZxsJ00MGfrai4Ib3g5N+8PbECDiijM/+n+ckSWWxDr
         1W62tMegc9nfb0CwbpYHN6wXniFb2Qvuvum+W/R9o6CyPhJbq3KzYyRIdYhrnBRHQ1jL
         UsuOZ9DGV2Fo1CshbCC0Jh/1/fG4JC6vTlHubUM3/uq633BF89ovvT+5yLzaBqV9u3qF
         s/9QVxUS4P0OjFggD0FvPJgnXsI2IFGblk3eQhC5zCSftTcPdHHj+eNpra7BnbIPdgDG
         JqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602977; x=1791207777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JWiXCYKo1ajln0FQJI6NPTbrxK/UeMuKyNgK4q6K2cM=;
        b=F7OxGrpuhZ+1PlnN/YgGZVUwYpQfCgwGSRayJ3SwPi1RxDSf/m9BCf1EJLq2DRLl/X
         DJ0a5FFHS+NTZUKcPSckoZJu+bIRt6e55pLES8yeESczdKySpubY28C5kIt3ft9+Zjct
         HlI7Phce37E9ElTMYeioIvuWy11NT2tzdftGbU3jXcE187YsKSoDi/DvUF+VuYVoe9NA
         mL/MP4yM63Da93lmzmtHP9iEaJq10NM7qXYYKm7oNgxtch3K3WbmWziQuAPXTYjpRfbv
         I/iCTA6onFhydkw4NrVRYZrQbSN4SUdat7K3Rr/E8zUJSyDRAHMWA7sUY2WXHAnFGP+W
         uZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602977; x=1791207777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWiXCYKo1ajln0FQJI6NPTbrxK/UeMuKyNgK4q6K2cM=;
        b=WDPoa7xN/Cr5BOqlF88E7ILR2oDzRI+25QhdQQ+SOXRzeo0qJTohx+yv+askSpH4nu
         4yEzMAYbpdehzi2y7W8uRk7QlfqDMHL7KEFpqyb5BqbmmJ5BroGI2hB7PIUasUkeq6XN
         wy6xU4duHtmlgXyHnEBi+zN9GhONbDXWoI6cDIPOKLgxdmTgA4Ar+5Tp08uuUEGify2h
         lmaK7mlnnGOMKSv8AS3siOYCb/LEPSZ3DWpJ2dfyqYHa53afZabL06wUKnyKMNJGq3bP
         4RJmdn+HqBzQMUMbjgaJ3xQ6+1D56+6HRI3A/5d9ebofLh1hMP+5VweSenHYbxv6kbnZ
         yNUw==
X-Gm-Message-State: AFuF++nSbIvI6tFAvDBx/LiFqICL/GBpoJ734cHTHAWxsGootPbJyWdT
	WYMaqth0GS8dtUGD4BdkeVUErIaMfev9r7vIHd7CZEjkTvNwlX2EGSaJ0cxTcofCf4tle10wZ/V
	Rer5it2BSQFdg78wooug0DVE/SYMYyYg=
X-Gm-Gg: AYBFou2CTHa6o7vnzt9IHAR8WNZii0iQpzL7yJTcfnzCOSD5cA97K1dbIqRXmSHAvqN
	JoeenG3E+QtNQE8Nq6eel1pzS39gahRnnPYM+OQhaBJIHvSZiXDvjDEaAcQmLyDZuT0/5yKlkkI
	nzufuRZuYD26mT4BiQ9wuOvXYkhCFq4ruM+1NkiDpdNcF6zSjljFKa6YALE3JCYWsicZy2xGImv
	EYT9BD4NoQEXGUEhmB0esL9d6hmkmAL6iEzUhYiI1N27hBlXWh0sIXOn0znWU5ChQgKMyNhE6cS
	4cADTJkPhUXHc+u75LPkWT8Z+JMYwMzcSqZKMfpkBP7x67l/7Q3XMaWDngRQqjvGoKR4S+VtS4k
	EEN1MDfn1d5SlI7C0Nh4TaltIYmKIgIl50ubtDwseB1wGatfH1VU+7blCE8G0tSRrmN7HaHvZo5
	clxBZ+5s+ETJTLkG/ZnnzUdwRURZedhv19I2Pke97F7L0OhnssGQ==
X-Received: by 2002:a05:7022:50b:b0:144:fb31:a597 with SMTP id
 a92af1059eb24-146d0a61938mr13551243c88.47.1790602977218; Mon, 28 Sep 2026
 06:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com> <20260908164129.560396-6-christian.couder@gmail.com>
 <xmqqmrtrwq0k.fsf@gitster.g>
In-Reply-To: <xmqqmrtrwq0k.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 28 Sep 2026 15:42:45 +0200
X-Gm-Features: AclHuK8dWIsQTz5z3i6lasVlQ5ENcIebUgsYQ1TCg7j3EL70PQWhswEC4UQuWo0
Message-ID: <CAP8UFD3gsp1wJnsf=de=5KT47Zm5KiJFNOQha5FKurordf2VCA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on
 trusted repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > A previous commit added a new "uploadpack.lazyFetchTrusted" protected
> > config variable that can contain an allowlist of repos, as well as
> > functions to check if the current repo is in that list. But when the
> > current repo is in that list, we currently do nothing.
> >
> > Let's instead set `GIT_NO_LAZY_FETCH` to `0`, which allows
> > `upload-pack` and its `pack-objects` child process to lazily fetch the
> > objects they need to serve a client, for example when the filter used
> > by the client and the one used by the server don't match.
>
> While I agree that it is a good idea to make it more lenient to work
> with remotes that are explicitly marked as trusted, it somehow feels
> a bit unnatural for a configuration variable, or a conclusion
> derived from the setting of a configuration variable, overriding an
> environment variable.  Who is setting this environment variable in
> the first place?
>
> If NO_LAZY_FETCH is what server operators set and export, I strongly
> suspect that not honoring it merely because the new variable could
> be used to give them a finer-grained control would be very
> surprising experience for them.
>
> If the answer is "this never comes from the end-user or the server
> operator.  We used to automatically set NO_LAZY_FETCH from the
> process that spawns uploadpack because we trusted nobody", then I'd
> imagine that we would prefer to see that code that automatically
> sets NO_LAZY_FETCH to inspect the configuration variable and to
> decide not to do so.
>
> And I think that is what the code is doing (in other words, from a
> cursory read, I think the new code is doing the right thing and it
> is just the way how the above is explained that I found it iffy).

I have tried to improve on that in v4 by rewording the title and commit mes=
sage.

> We used to say "when serving a client, we do not lazy fetch what we
> are missing from our promisor remotes by setting NO_LAZY_FETCH" and
> it was unconditional.
>
> I think what we want to happen is:
>
>  * If the server operator has NO_LAZY_FETCH set, we honor it and do
>    not do anything.
>
>  * If the server operator does not have NO_LAZY_FETCH set, then we
>    see if the configuration variable is there, and if there is, we
>    let it take care of which promisor remote to allow by not futzing
>    with NO_LAZY_FETCH ourselves.
>
>  * Otherwise, we set and export NO_LAZY_FETCH just we used to.
>
> and what you have in the patch is close enough to that (you left the
> historical "disable lazy fetch upfront" so worst case you export the
> thing twice which is not necessary).

This should be fixed in v4, see below.

> > This allows server operators to properly control lazy fetching. It is
> > their responsibility, not the client's, to decide if the served repo is
> > trusted,
>
> If "the served repo" refers to where the client is fetching from,
> trusting that repository or not is up to the client; if they do not
> trust it, they should not be coming to you.
>
> I may be misunderstanding what you are trying to say here, but what
> is up to the server operator to decide is if the promisor remotes,
> which the repo that is serving the client uses, is trustworthy,
> right?

I think that by listing a repo in uploadpack.lazyFetchTrusted, the
operator vouches for the following:

- the repo's configuration and hooks, because git fetch will execute them,
- the promisor remotes it is configured to lazily fetch from, because
objects will come from there.

I have tried to clarify this in v4 with the following in the commit message=
:

    +    Note that what a server operator vouches for by listing a repo the=
re
    +    is that the promisor remotes this repo is configured to lazily fet=
ch
    +    from, as well as its configuration and hooks, are trustworthy. Whe=
ther
    +    a client trusts the repo it fetches from is a separate matter, and=
 up
    +    to the client.

> > As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
> > environment, this works for `pack-objects`, which performs the lazy
> > fetch when serving a client, without any further plumbing.
> >
> > Now that "uploadpack.lazyFetchTrusted" is actually doing something,
> > let's document it and reference it from GIT_NO_LAZY_FETCH's docs.
>
> > diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> > index 32831fb879..8b531ca724 100644
> > --- a/builtin/upload-pack.c
> > +++ b/builtin/upload-pack.c
> > @@ -42,10 +42,13 @@ int cmd_upload_pack(int argc,
> >               OPT_END()
> >       };
> >       unsigned enter_repo_flags =3D ENTER_REPO_ANY_OWNER_OK;
> > +     bool no_lazy_fetch_set;
> >
> >       packet_trace_identity("upload-pack");
> >       disable_replace_refs();
> >       save_commit_buffer =3D 0;
> > +
> > +     no_lazy_fetch_set =3D !!getenv(NO_LAZY_FETCH_ENVIRONMENT);
> >       xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
>
> I am not seeing what is in the postcontext of this hunk and in the
> precontext of the next hunk, but I wonder if we can just remove this
> xsetenv (without "no_lazy_fetch_set" variable at all) here ...
>
> >       argc =3D parse_options(argc, argv, prefix, options, upload_pack_u=
sage, 0);
> > @@ -62,6 +65,14 @@ int cmd_upload_pack(int argc,
> >       if (!enter_repo(the_repository, dir, enter_repo_flags))
> >               die("'%s' does not appear to be a git repository", dir);
> >
> > +     /*
> > +      * Relax the GIT_NO_LAZY_FETCH=3D1 default if the served repo is =
in
> > +      * the "uploadpack.lazyFetchTrusted" protected allowlist and
> > +      * GIT_NO_LAZY_FETCH was not already set explicitly.
> > +      */
> > +     if (!no_lazy_fetch_set && upload_pack_lazy_fetch_trusted(the_repo=
sitory))
> > +             xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "0", 1);
>
> ... and instead check the existing environment here, and do the
> choice from three possibilities I listed above here.

Yes, that's what is implemented in v4. The three possibilities are
also listed in the commit message now.

> Other than that, this is a great endgame of the series.

Thanks.

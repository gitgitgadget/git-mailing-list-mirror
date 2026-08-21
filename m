Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19828381B10
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333780; cv=pass; b=LdU5Y8L00TFWNv7TujCmw7+bI91adHURFwkqB/TKPiRYQcwpg22uQnIR8OHef2sy+rnBDgSvG6ZjfV+UwRbviyqIfltQeBitSh1jBV3H5EgVRaKqwCbwCRrMw/NEaJZSmNVoPo8NQH+SdjAx5BkwrqsLd3VPGJ+HcDfo/xDGusc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333780; c=relaxed/simple;
	bh=ih13K5eUAOz9o7lJ+K4HsvKgMWjcvoD/SVcHRJYhv88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmUIkVv0L+nwibfNPQF67zCrGDEHvUji7D1qnJdVA9DEAOX0Kf3J1rko3hXJJOCvWxAELOqffKT3HOKaVv82+zQF3Iw1F3PCRiimBU4sQ4AkGT1hRK3V7mCCWwTBr7nMqsxYDEZkEL162p68jYYhHKU9izrT4x101DUODF21Nxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG6Zh4vs; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG6Zh4vs"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a456e44e01so872471b6e.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 10:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787333776; cv=none;
        d=google.com; s=arc-20260327;
        b=SaxKRO4kLiVCUKYjT4HD7b9q+BA6wq0yI33Jr2/YcNH07uygtqdKBdhCSb6fkw4vZA
         xqL3FOexf/75ZSLAsBj/MMMcFPA46W6bSk63JLAEs4w003IAGXi36sm+4PFXMTRCJyRz
         iwuCXrn7Uv+xYdZHPlFTbQYtazTl48nS1LbyJxwhYVjXTxzgheQAHL18h1mzuORf3Q+t
         xd56yPIOtFzhyDvM6/nVEFPBkFG/svvXUwYxbWPuXp8BvCE8S1SMa3C/q0N45H2u4Ac8
         dM9LNFTejuWr9Z2+mK0PyCL/BZPPQGpPhfs4oEzmmwV83YCIKNG+eugzoxQwodOqnf1B
         1OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvLd4QWadXuvU19pH65P75e3PbRoTjX5DM9gMlwE4Lk=;
        fh=fdUUVNZi35b7GXdWi/hlIXRygFmZrL9a8prTlzD4D8I=;
        b=IyihE0nMD4IQ5oyHS8hpifdxLqNdtIr2DWRZGJWTN0dE0a/HUeNCuZhwRuxBcJ/mI2
         P7epfQQsJSrEgbPkfp7QV1Wr47e3pRaL3u8ZRcSvmssWPEs7XZqRaQ+58DvCyjjkYYMS
         DA8tA2gfqCx8W/Pd5f4k/aygq4uXjYu021MNNdaKZ4R+T2ERqmMiTUVvGrLCnVvVCm07
         MJOIruVCddrIJ1GEblgUI22gorv/OKrSPSKj8XdTzhp1Ojju1/iFoqUbKVdkprOilPBB
         9brt00M/k78edDVaK1sq0zao0QbJoynFtBoKxyvbHOHNl9zeYy1oNwGy+GLOPW50o9W7
         56Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333776; x=1787938576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvLd4QWadXuvU19pH65P75e3PbRoTjX5DM9gMlwE4Lk=;
        b=AG6Zh4vs3pBbSF/958yFiGT7mqo95gBpru2GFqTTx72EXrvI/y4kJb1/2/c271bGxB
         nWnUaHkQD9jYm6UnhD24wYCqUbWE3MAC4FdBcU86aA+yhDArcLZSc/f/Uo6K3Apx7MWg
         5+eDgbOhoajdFOhoJxYhDO87abl+fVKh+R+motRBw62ZV5ueQvJclNP6Y3Sd/Uh1ozbp
         ir85mDzD3nBhJmm8oxU77fn0SBeSbKTqMlUetgJxa9d/ADL0Py+lROsgY1C35iPUKGzS
         WHoOfnDR/acm1zkQ2UnHK8WxO/FhC6QXj1VsI/lzRjVFApvWtiliVgi8uH8AJHb+5xfC
         iwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333776; x=1787938576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvLd4QWadXuvU19pH65P75e3PbRoTjX5DM9gMlwE4Lk=;
        b=fe1mpToItKeA18BgjSCMjsUgyKSYRP7iO4DArc3YhXFfXFIyf+fsVl6OkzF7IBmIM1
         2wxiWgZrFqbgzEOpCLvZQAbd3LEpgaUPXkzX/mbscLYtO3UlfA/NdRp7XTawrIDfq/PS
         EJoPsz8y0W8mp2JAGxumbS6I5zyOGe0w0mxt/1s5/SBZ0h0hUTgn4uQA+pK/lpSC3+g7
         ny2OM2C4IBqPDWiBzn2rUQPZye1pBn4jAu2TmaFf99wQXcSgoRdfJczKLo8B88DoCVAN
         n5O3f6xVG3r36AfKNlFm9PhH3HfkB9KHKGKl3yCrq1DVzrsdl6wo0ZyyaRmX5UBjDZy3
         NQeg==
X-Forwarded-Encrypted: i=1; AHgh+RqfYZIDD++XSuthykrYgBrz923/oUnXO0HnVVVi4u/yEMG6i/d44v9GpUO/EJCTQoWOUQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIR4TbDLzPglO8RKYDbNMZhZo/RwEBwvGGjacXUMmSOShPk8Q
	oeUkOJKwWoWF26v0vs5qH51m0eHiz+yaY4eVTq79cavAr8URJAB7OkNsAMuqAv77sMNYiNb32Qf
	Bs/WywzL0uyO7f0ZuH640iGhjmcFL11yBVPSZ
X-Gm-Gg: AR+sD11QQgObvfIKj3Z3xCD+PMa05s9ObUo7jFXIYsw+qMowg0hzDPGYryerDtzE0P7
	WLy/ZGpGkrushf9RWLAl5pJEiqTGfLU+jAvluYc0MwLv8GddUYvcgI1isGKZ1/WNsU6bqbXeTRT
	FmMeXwiRgL867T94yk057R27DsbNkLGgLRixDKac6fyqa1ykbl6By64gEA1oceQyR4HxI+NbNID
	6Vbnoq3nzOt485nGFIN1F7Lg9Qg1b4pj8tsmBr5RSWlFJb2bHoyEl6KArVTT6TehytMDemMwnq9
	k/NnqI5xBrvGFvZEfiD/K1qaYkNj+P+PNgWgGX0Amr7yMxYjAgAbn0c7W/WeGmSuWzYLaqG65Pg
	6PqSgGZWEZYoc1cSaLevcrwDvSGxWP/rLge2r6W/TNxhW1txGEIOuMfYZqHsms1o=
X-Received: by 2002:a05:6808:124b:b0:495:f74a:b572 with SMTP id
 5614622812f47-4b2ef21b725mr7964645b6e.5.1787333775567; Fri, 21 Aug 2026
 10:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com> <aohP7GMx9oX3ZCsQ@pks.im>
In-Reply-To: <aohP7GMx9oX3ZCsQ@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 21 Aug 2026 10:36:04 -0700
X-Gm-Features: AcwNN1VyFrpY_aM4ed9zraG5EZL8k37vOcirmb27AZGS8ZbvkxDYha91irPZ5Mg
Message-ID: <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing from
 a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Aug 21, 2026 at 06:55:51AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When pushing from a shallow clone, even if we only have made a small
> > one-line change to a tiny file, we often push the entire toplevel tree
> > of files.  For large repositories, this could be gigabytes instead of
> > kilobytes.
>
> Oh yeah, that issue. It's a common foot gun indeed, and the common
> advice here is to never clone with "--depth=3D1", but always with
> "--depth=3D2" so that there is at least one non-grafted commit available
> on the client so that they can indeed perform proper negotiation with a
> server. But over the years I had to explain this again and again, so it
> is clear that this common knowledge might only be commonly known to
> people who have spent way too much time in the Git codebase.

I don't think --depth=3D2 actually helps here.  What enables real
negotiation is push.negotiate, not the extra commit, and
push.negotiate works just as well at --depth=3D1.

Without push.negotiate, send-pack's only negatives come from the refs
the server advertised filtered by what we actually have.  In the
foot-gun scenario -- clone shallow, server advances, then push, using
depth of 2 just walks one commit further to the graft and then
re-sends the whole tree anyway.  Running the four combinations (server
advanced after clone, optimization disabled) in a small test repo:

    depth=3D1, push.negotiate=3Dfalse:  Enumerating objects: 205
    depth=3D2, push.negotiate=3Dfalse:  Enumerating objects: 208
    depth=3D1, push.negotiate=3Dtrue:   Enumerating objects: 4
    depth=3D2, push.negotiate=3Dtrue:   Enumerating objects: 4

--depth=3D2 without negotiation is if anything a hair worse, while
negotiation fixes it regardless of depth (the negotiator offers the
shallow graft commit itself as a "have", and the server ACKs it).

--depth=3D2 can in rare cases help, but only in the lucky/accidental
case where some advertised ref happens to point at the extra commit
you now have.

> It's a good question to ask. In theory though, can't it happen that the
> client changes the commit in question locally, e.g. via `git commit
> --amend`, and then pushes? If we now assume that the local commit exists
> on the remote side then we'd be insufficient information to the server.

Oh, wow, I had never thought to amend a shallow graft.  As soon as you
asked, I assumed it'd create a corrupt repo -- a commit that wasn't
itself a shallow graft but had parents we didn't know about.  I got
surprised in a different way, though: commit --amend treats a shallow
graft as a parent-less commit, and thus creates a new root commit.
That does avoid corruption, but only by providing a different kind of
foot-gun.  (If users really wanted a new root commit, `git
{switch,checkout} --orphan` is the tool to do that.)

Since we've got another place where commit --amend can serve as a
foot-gun that I've long meant to fix up, I'll submit a separate series
that'll make it throw errors for both cases.

> There's another question though: can we properly determine whether the
> tree of the grafted commit matches a tree that the remote side has, for
> example example by including the tree in the reference negotiation? I
> have no idea whether that would break git-recieve-pack(1) or any other
> clients out there, as I don't think we ever negotiated down to trees
> until now. But in theory, there isn't really much of a reason why we
> cannot do so.

Interesting idea...but doesn't this happen too late to help?  Without
push.negotiate=3Dtrue, I _think_ (double check me) that the flow is:

  * server blindly speaks first, advertising the refs it has
  * client responds, including its shallow <oid> lines and then sending the=
 pack
  * server reports status

If I'm right about that, the server doesn't know about the client's
shallow grafts until too late, so it'd have to advertise the toplevel
tree of every commit it has if it wanted the client to be able to take
advantage of them.

Alternatively, we could change the protocol, but we already have
push.negotiate=3Dtrue that is implemented and is more thorough than
sharing the common tree (the common commit contains the shared
toplevel tree).  The only place I think a tree negotiation could win
over commit negotiation is when you keep a tree the server already has
but under a commit it doesn't -- e.g. you rewrite the grafted commit
but leave its tree (or part of it) unchanged. And if you changed the
top-level tree, you'd have to recurse and share each unchanged subtree
to avoid re-sending common history. That's a lot of machinery for a
narrow, contrived case, so I'm not sure it leads to a helpful path.

> [snip]
> > Update the existing shallow-seeding tests in t5538 to set
> > push.shallowExcludeBoundary=3Dfalse, since they exercise that
> > receive.shallowUpdate path.  Add tests for the optimized default and th=
e
> > opt-out, that a rejected ref does not cause an accepted ref to be
> > over-excluded, and that a shallowUpdate receiver still rejects a
> > rootless snapshot by default.
>
> Do we have tests that modify the grafted commit? It would be good to
> learn how such pushes behave right now, and how the proposed change
> modifies it.

As noted above, modified commits are actually root commits and do not
have a shallow history, and thus aren't really part of shallow push
testing.  I think it's a bug that modified commits become root
commits, but one that really is tangential to this patch.  I'll submit
a separate series with a fix.

> [snip]
> >     Users can work around the problem described in this patch with
> >     push.negotiate=3Dtrue, but while we can educate some users to set t=
hat,
> >     trying to get them all to do so is quite unlikely. Let's help users=
 by
> >     providing sane default behavior.
>
> Makes me wonder whether the default is something that we should adjust
> so that this defaults to enabled. Are there any downsides to doing so?

The only one I can think of is that it adds a round-trip to every
push, which increases latency in order to sometimes reduce bandwidth
and cpu.

It can dramatically reduce bandwidth and cpu, but not always (single
person projects would probably never see a benefit, for example, nor
would anyone interacting with a fetch v0 server), and it always
increases latency.

> > +static void append_reachable_shallow_grafts(struct repository *r,
> > +                                         struct ref *refs,
> > +                                         struct oid_array *advertised,
> > +                                         struct oid_array *negotiated,
> > +                                         struct send_pack_args *args,
> > +                                         struct oid_array *haves)
>
> Nit: it might make sense to mark those parameters as `const` that are
> only used as input.

Good point; will fix.

> > +     for (ref =3D refs; ref; ref =3D ref->next)
> > +             if (!is_null_oid(&ref->old_oid))
> > +                     oidset_insert(&known, &ref->old_oid);
>
> Okay, here we assemble the list of all objects that the remote is
> supposed to know about.
>
> > +     for (ref =3D refs; ref; ref =3D ref->next) {
> > +             struct commit *commit;
> > +
> > +             if (is_null_oid(&ref->new_oid))
> > +                     continue;
> > +             if (check_to_send_update(ref, args))
> > +                     continue;
> > +             commit =3D lookup_commit_reference_gently(r, &ref->new_oi=
d, 1);
> > +             if (commit)
> > +                     commit_list_insert(commit, &pending);
> > +     }
>
> Hm. Why do we loop through the refs twice? Wouldn't it be possible to
> combine both loops?

Oops, good catch.  Will fix.

> Instead of doing a manual walk like this, shouldn't we use higher-level
> interfaces like `repo_is_descendant_of()` that can make use of commit
> graphs? That might be overkill though as we can assume that in most
> shallow repositories we won't have deep commit history anyway.
>
> I guess the answer is "no" though, as you don't only want to check
> reachability, but also whether any commit in between is part of the
> commits that either we or the server has advertised.

Right, that's the reason: I need to stop at commits the peer already
has and pick out graft boundaries along the way, which a descendant
check doesn't give me.  Shallow histories tend to be short, so the
explicit walk is likely cheap.

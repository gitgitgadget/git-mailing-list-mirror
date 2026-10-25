Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792949265;
	b=4AEmz7o+2DVJRUEOOzwXju1uo2ENeEsEIThaLOwih7WWAJZJ+M6sJoY5wVzSEmdKAwW0
	 GJbnIdLGVpXz0qMXRdk6UhpKOVAtXmpWDF8WW34ilVDoeqM0ohnKy3HgLXeySYsZdh6i+
	 FSv8UOkn9cdzCHuLch9x4BWaocf+ySQrc23aPDWPDTocFvQ1KURLM4LaCoBdJ5tM41S4V
	 85vj+2NqrPRMbWDGxJzVd831cY5uyzvOCSW4p2jmm9AYa7bXaZ4eaiYlb7amUBfTeuD1S
	 ScPTGhj0uhMzPWkFSjlzymOYwaOFhWvukKkTYZF9UwP7g1CpNTUwmIThlJ5bfSf2IAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2U1GnmzJ0BcbkVRtOfZHis5YzAZuB1pW3M6k/8okIZc=;
	b=cZuc8jnzfdYGMpUaFLnrnQrESsIbQBavX5bpwzC8WOy0AZ3zJhWW6/B40RTMQM6bwXwk
	 4md6/EF2ODfXAs9XPjYuj9wAHeuKPHAvwD5N+4NrBxmC6E19ucMfsvMC0mQEq+QJeqFDz
	 zm8YmgL+5Zi6Nnc2B7xFpcydACpyJ51eRaR9HOA/XyU/ffP1GFtyI+r8SBd/rsEvMKMlC
	 p9VG19PsxHf9fp0GpQG+R0yeFh84jovv/wvqjy+u/LRa5kmJ9KTvJ9xmQXPmWJW22qOHK
	 6EkeBG4VRmBOZnvebXhSYpNeawFWWcYU1bPDlgA1cfvkuklCf5QfFsMwZANpQvS4b2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YLtHFuPR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C855606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 17:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C855606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YLtHFuPR
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3277273a12.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 10:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792949263; cv=none;
        d=google.com; s=arc-20260327;
        b=DV9+9a8eDSyC9Fti+Y2zGeX4L2ggESxpxLVeFpkX1JhSREySmqfdXoG7V7eGUwComP
         Mlss7lH7qk5p12CCpmF4Xk1sp5zAnGW8ScA/1CdmOxYY9u92XxvJgRpihENER6mmv/4J
         6YaxGfdbk412cARclTa+Ppq44uMBucK0pd5N1cWXbmF9XVB4sQSAiDMe83Se86kHSdAM
         FrXDcG1oSyAM9C3p+b+DWNhFrG2N/BEWUjAunPfsyi9ikxb/pia53va1Fy5VRfIJv6XT
         +FA95nQPSMGZIuB7IW9qP3FuJcrrbL+Nb0BMQQ4YgcB3wrzbGuhTWZTLaWiBHMANSJ20
         42WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2U1GnmzJ0BcbkVRtOfZHis5YzAZuB1pW3M6k/8okIZc=;
        fh=+EbqtoTGLBV4sjbR9yaBPp8DM8sA7UUx74SBphIgiXk=;
        b=FXiq3FGnJInuz/bON/9Q61CudetksG1wQCpfI8rl8qLv3J8aHnjQJMqLSuQteNQhsi
         G84dYJQQnaBrNTmlS18FYyn8aO+F6mJ4Q7gZ5Mz/4EjTD2RT1ZkwUE4TG2rE58+D5+Qr
         7IsNFn5UO7vOeDq9LPdwHeWo6eQPBemgy6nBaG7GFroYBhHi7k83mPH9IYSrxYmmVmv9
         8qnnQqhnNIhdrxirED7JYcBovlb69nTIjNJuVskuGU2C54bE9gwm8+iiGtU+sYfbtOXU
         ffKtMk5mjAdFzjYdWYMttl6Q6VWkBNyarkszq+lx1/LlPKxTMOr5ycYJBoR7bzjcV7nU
         Bsmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949263; x=1793554063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2U1GnmzJ0BcbkVRtOfZHis5YzAZuB1pW3M6k/8okIZc=;
        b=YLtHFuPRw+nA54mF3bNvS4k7Ee3/x17WZsT2/ASkQ/OalB5oqfQBMxUvwQn1qNyXTZ
         rW78smb/yeYk8dzGJuDHCkPlZfDAxnSqp+2gbf37qFmx6zS4btfTKUO4LCmfERj4WBZk
         lLsHhA9CVp7j+pck9DPdGG+p+SRMsuy8G+wFaJQ4XfS1UdlLTjwBkHaWzfYGWCw5cThV
         oMPZyjaR1ZGGSBnoTvTvKHyWMF64m1Qag0ZieCw/J9+0+91nCJ/dheKbD+312nwf6FaK
         i07mIIJAx+hRUsKtMry0IM/7OH2SKumgz+WAmn/Y5iLiZXBDi88qk5oLflRa3uTdC6NR
         LKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949263; x=1793554063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2U1GnmzJ0BcbkVRtOfZHis5YzAZuB1pW3M6k/8okIZc=;
        b=cRCp2cky6kOQ3J6ICeeIkcQnCN3CLFAsSYO54Um8mY0Ebq3xn0wwjWXuOl9mEbRQYD
         JdfkbmBHZuGStWjRV6Fu3bsHMIJVecyBHnOkgJhDHj1MagkzzAGj9Dge23AP9YWFAcvi
         37rneUDfG9wlDVxNyJKE6IRLbC2TztknegAWI28JJojo1kn+61FmUwYCBr08F+QN8aSJ
         zPXSUZlbjshoUEUX7oUNATMPjPhZgpuSna2QKrDxtp55gdMu68Ouil3g3DEaGBp3vBZF
         nex6gDYAOKo3SEa0kjMjK/AFnmakkUS3EhI3I/tPbGEXCwkw93ZoQxzL+w6BYe5PvXaJ
         kjIg==
X-Forwarded-Encrypted: i=1; AKwUvBw+QnJragsbIljz6Bw+Av9mWRS13ocBpT3FrRehS/L+ByWsmqGq9FXRaBotvKliU/zbc2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiPPPi2rp+PNL6I+En3oTT/DeLN1CGkttUO6FZEbhEyDjLk73j
	D1SA/tSOvOJDoLW5hHXuEp40GYp4fmQ0z32q+WMs/9jYGlKna30VKdk8xkqqnWhTp6FFr1tq9vH
	Q893SeXRTQFAaLOc/S9t3O/iNGD7h5Tk=
X-Gm-Gg: AYBFou159liLYiKWuS/ZbYaf8nhvnTtnipELZiEorAofQHrgtLKBnO8khUy2H4xzK6r
	sk52Eh5BBHcRrrgmTYXLY7Mc5pL77WaKyV26B4EJngdmxAfPOliKH8OokEfmQdP2pIaQVmu8xaF
	r9p7e3WdZIg+Ie7Xqa4L4HfCHUahMPKWmHVxhJbAVilAMqxq8hqp6X8pRmdOjVO1tvfnbk0659r
	CL/OyPlWM8bYur+VUBEiBuGxtWLGH1PVSCA0rGY77jV2Xje/D3eWFTeqzQr+ucivvaYVKbgGcuO
	Trsf2N9mTCCjWl4wIexkwLXFnPWM79caCSSJ2g/QqPN9tUEVwJuuYjjDSjKbHLxQHfSSzRLHnxv
	BgDic6965EOQMLmcFva6F3PX0qqiaRhpMtoFhuVHgNyBLbQEgMU1S8YZCgX9jF4yF02mbIg==
X-Received: by 2002:a05:6402:1568:b0:6b3:b0b2:6e7 with SMTP id
 4fb4d7f45d1cf-6b442fe888amr3932701a12.18.1792949263178; Sun, 25 Oct 2026
 10:27:43 -0700 (PDT)
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
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <9fb7e77a862640007339df639d03e61db37b6f70.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CCJzzX1qKeX4AR-GViM4LJjKrfdj6iafVXUQZM-c2Su4A@mail.gmail.com>
In-Reply-To: <CALnO6CCJzzX1qKeX4AR-GViM4LJjKrfdj6iafVXUQZM-c2Su4A@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 25 Oct 2026 18:27:05 +0100
X-Gm-Features: AclHuK-ifQbWDDAtE3kpFP1JMzF-BH7mnqbcWLazv8oxmqwYhSk41CV9tJ6rTW8
Message-ID: <CAHwyqnUQSninG=3hcxZOXUUwEXGbA6AT7FfmL36gwa9wV3ub4g@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] fetch: infer branches to fetch from a refmap-only remote
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Configuring remote.<name>.refmap without remote.<name>.fetch used to
> > make a refspec-less "git fetch <name>" fail with "--refmap option is
> > only meaningful with command-line refspec(s)", since a refmap only
> > says where to put fetched refs, not what to fetch.
>
> This makes this commit sound like a fixup of [1/5], but I think it's
> actually one of the main goals of the series! Can we flip the
> justification around to say something like "we want to allow refmaps
> to do XYZ [=E2=80=A6] Incidentally, we also make sense of the case when r=
efmap
> is configured without fetch" ? That would make the purpose clearer to
> me, at least.

Good idea.

> > Make that case infer what to fetch: the local branches whose
> > @{upstream} is already on that remote. This lets a remote be
> > configured to fetch only the branches actually in use, without
> > listing them by hand in remote.<name>.fetch, and without needing to
> > touch the command line every time.
> >
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > ---
> >  Documentation/config/remote.adoc |   5 +-
> >  Documentation/fetch-options.adoc |   6 +-
> >  builtin/fetch.c                  |  75 +++++++++++++++----
> >  remote.c                         |  24 +++++++
> >  remote.h                         |   4 ++
> >  t/meson.build                    |   1 +
> >  t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
> >  7 files changed, 219 insertions(+), 15 deletions(-)
> >  create mode 100755 t/t5586-fetch-refmap.sh
> >
> > diff --git a/Documentation/config/remote.adoc b/Documentation/config/re=
mote.adoc
> > index 103eada406..7c52e443a5 100644
> > --- a/Documentation/config/remote.adoc
> > +++ b/Documentation/config/remote.adoc
> > @@ -36,7 +36,10 @@ remote.<name>.fetch::
> >  remote.<name>.refmap::
> >         The default value of the `--refmap` option for linkgit:git-fetc=
h[1].
> >         Used to map remote refs being fetched to remote-tracking refs t=
o
> > -       store. See the `--refmap` entry in linkgit:git-fetch[1].
> > +       store. If `remote.<name>.fetch` is not set either, a refspec-le=
ss
> > +       fetch infers what to fetch from local branches built on this
> > +       remote, instead of fetching every branch it has. See the
> > +       `--refmap` entry in linkgit:git-fetch[1].
> >
> >  remote.<name>.push::
> >         The default set of "refspec" for linkgit:git-push[1]. See
> > diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-opt=
ions.adoc
> > index c2101a7b39..90b9e13ac2 100644
> > --- a/Documentation/fetch-options.adoc
> > +++ b/Documentation/fetch-options.adoc
> > @@ -245,8 +245,10 @@ endif::git-pull[]
> >         command-line arguments. See section on "Configured Remote-track=
ing
> >         Branches" for details.
> >  +
> > -`remote.<name>.refmap` provides the default value for this option, the
> > -same way `remote.<name>.fetch` provides the default refspecs to fetch.
> > +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) bu=
t
> > +nothing to fetch is specified on the command line, nor is there a
> > +`remote.<name>.fetch`, branches from the remote that are used as the
>
> "remote-tracking branches" ??

Yes, the next version will say "remote-tracking branches from this
remote that are also configured as the @{upstream} of a local branch
are fetched".

> > +`@{upstream}` of our local branches are fetched.
>
> The clause here is complicated ':D I found "infer what to fetch from
> local branches built on this remote" to be a bit clearer, but we
> definitely still need to get to the point, which is that
> remote-tracking branches from this remote that are also configured as
> upstreams of local branches are fetched.
>
> Now, I wonder a bit: the doc says "when a refmap is active" we do that
> "fetch remote-tracking branches that are upstream of local branches"
> [all scoped to the current remote]---but it doesn't really say how the
> refmap affects that? I mean, I imagine it's used for mapping (duh),
> but I don't know if it also narrows the scope, or if the scope is
> deliberately all remote-tracking branches that meet the requirements,
> or=E2=80=A6?
>
> IOW, it seems to beg the question "why does the presence of a refmap
> control this if it has no effect on the set of selected branches," and
> I think the answer is partly "because we designed it that way" and
> possibly found in the mails leading up to this point, but we might
> want to try to connect the dots for folks? Idk.

I'll take a look at improving this part.

> >
> >  `-t`::
> >  `--tags`::
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 136a59154a..0fc1fb66d5 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -524,6 +524,8 @@ static struct ref *get_ref_map(struct remote *remot=
e,
> >          */
> >         struct refspec *effective_refmap =3D
> >                 refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
> > +       struct refspec inferred_rs;
> > +       int infer_from_refmap =3D 0;
> >
> >         /* opportunistically-updated references: */
> >         struct ref *orefs =3D NULL, **oref_tail =3D &orefs;
> > @@ -531,15 +533,32 @@ static struct ref *get_ref_map(struct remote *rem=
ote,
> >         struct hashmap existing_refs;
> >         int existing_refs_populated =3D 0;
> >
> > +       refspec_init_fetch(&inferred_rs, the_hash_algo);
> > +
> >         filter_prefetch_refspec(rs);
> >         if (remote)
> >                 filter_prefetch_refspec(&remote->fetch);
> >
> > +       if (!rs->nr && remote && !remote->fetch.nr &&
> > +           effective_refmap && effective_refmap->nr) {
> > +               struct string_list tracked =3D STRING_LIST_INIT_DUP;
> > +               struct string_list_item *item;
> > +
> > +               branches_tracking_remote(the_repository, remote, &track=
ed);
> > +               for_each_string_list_item(item, &tracked)
> > +                       refspec_append(&inferred_rs, item->string);
> > +               string_list_clear(&tracked, 0);
>
> Interesting choice of string_list again ;) do we need the sorting
> behavior? (In fact, since it could come from an "ordered" config,
> perhaps we should use that order?) A strvec seems more appropriate
> then=E2=80=A6

Agreed, the next version uses a strvec here too. Nothing is sorted
anymore: the branches come in refname order, and each branch's merge
entries in config order.

> > +
> > +               rs =3D &inferred_rs;
> > +               infer_from_refmap =3D 1;
> > +       }
> > +
> >         if (rs->nr) {
> >                 struct refspec *fetch_refspec;
> >
> >                 for (i =3D 0; i < rs->nr; i++) {
> > -                       get_fetch_map(remote_refs, &rs->items[i], &tail=
, 0);
> > +                       get_fetch_map(remote_refs, &rs->items[i], &tail=
,
> > +                                     infer_from_refmap);
> >                         if (rs->items[i].dst && rs->items[i].dst[0])
> >                                 *autotags =3D 1;
> >                 }
> > @@ -574,6 +593,8 @@ static struct ref *get_ref_map(struct remote *remot=
e,
> >
> >                 for (i =3D 0; i < fetch_refspec->nr; i++)
> >                         get_fetch_map(ref_map, &fetch_refspec->items[i]=
, &oref_tail, 1);
> > +       } else if (infer_from_refmap) {
> > +               /* Already fully handled above. */
> >         } else if (refmap.nr) {
> >                 die("--refmap option is only meaningful with command-li=
ne refspec(s)");
> >         } else {
> > @@ -669,6 +690,7 @@ static struct ref *get_ref_map(struct remote *remot=
e,
> >         if (existing_refs_populated)
> >                 hashmap_clear_and_free(&existing_refs, struct refname_h=
ash_entry, ent);
> >
> > +       refspec_clear(&inferred_rs);
> >         return ref_map;
> >  }
> >
> > @@ -1978,13 +2000,47 @@ static int do_fetch(struct transport *transport=
,
> >
> >         if (rs->nr) {
> >                 refspec_ref_prefixes(rs, &transport_ls_refs_options.ref=
_prefixes);
> > +       } else if (transport->remote->fetch.nr) {
> > +               struct string_list tracked =3D STRING_LIST_INIT_DUP;
> > +               struct string_list_item *item;
> > +
> > +               refspec_ref_prefixes(&transport->remote->fetch,
> > +                                    &transport_ls_refs_options.ref_pre=
fixes);
> > +               /*
> > +                * See remote.c's handling of remote.<name>.followRemot=
eHEAD
> > +                * for the analogous, still-unresolved case.
>
> Is this a "we haven't resolved what to do" case, or a "some remote (or
> something) hasn't resolved" case? I'm not sure what I should be
> looking at here.
>
> Oh, I see. It's a duplicate of comment and code from the
> else{effective_refmap->nr} block below. Hrm=E2=80=A6 probably it would be=
 nice
> not to duplicate that? I can't spot any differences between the code
> blocks.

Yes, good idea!


Harald

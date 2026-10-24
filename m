Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854569;
	b=ZjUc8vk2L0AsF92l6eYZapoY3BhoZghIQzDujKOhXJGaBl6Vvg8+3aIAz0xDzyp5QE2E
	 vrOIRUd3pRamE722veTw8Hbfwct6D+r8J6gvhHbLNVU02CFeOC1fYLFmEwmVY4i0BoWfD
	 5BF0bB/Jbg4PMfQQxArR6ej9mApmqNWChgPE2l9FXIJmppsHO5cdbeKTv9+azzDi1mOIJ
	 hzpHXuwJXFo79ox84BrKWKUxBByHm8jgtZouCrPTakq6L3q5ATXI6xSqIjM2oxHP3MKJs
	 +tK4OHVotkkBmi2DqQWo131JaBSJGCvPjG8+1HPPyQbXE8ELfNfwZZQPOgK/S+NjNNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zURLoLpRz81pOab989tghAV6kuMUnboXSrX6biyebWs=;
	b=N5fa472mMmTJO4YsniB3+hebLJjO3ZpY7K1FnTQutbA1s5TGnroqlU2mooK+IvO6ieK+
	 hf1ND3zzLKLaoft/GSS+ZZg92Q/AQd/g8lxcG6YX2F162daQXnnHYJQu2J08ahYo0Chfb
	 KSVL0ICOskKCsH5RzIxhqmdUq86I9Rra2GZ/e9qemGq58BOwvfyDtbfk4xiqWrwgLLgWt
	 cIGaDNg+ixWOzmb3pfIgQL3cXQNAVDFLC9pi3EL07Gy8zb8ly1lKHU6sJnPm+8eEz5l2s
	 TEoYOvOA1CZCS1O64MvfvTS8bKkaR/FWzpXYCxy23rsjKtJ6n75nMMP7XiEzHPIJgng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ep3tpDFD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E2606A321
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32E2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ep3tpDFD
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9d1114320so13011985ad.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854568; cv=none;
        d=google.com; s=arc-20260327;
        b=O6zr9DeVUeQRnHV3Hks39NT6S4KAf7sPTtPWbF9BmGdEjRzomWMGNxk8XZdPKSXX2v
         rX20618m0EEIPJdna5LalqMCimsbvKnZdFxN8s6WwxXh7qmojKAXwRZNhstUp65/kzEz
         OIYZ78X9dTQoTX197LduagaswvJGAF8KHPUoH1yE65Mq2p26xQJ3C5pPfR4fggW1zqI1
         rzmGAJo8uBdP/hNgEQaHT9Rnb8KBxIIXSyqo82W0SNrCpXyQScoj+uI295LHmI/Lzi4V
         L+KqhZ3UqGkObjqXCykgQyv5XOHViZJFIEI8Jn0NNk4nG/8u95zuyOSE+SZky4KWJHIt
         oAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zURLoLpRz81pOab989tghAV6kuMUnboXSrX6biyebWs=;
        fh=kV+AbbD2dx8Zvrt/D0Q7uj1KhZdY6IIWIpBTzKZxjpM=;
        b=FK5YhxPkdIqqzg6OHI18ZWtzNMRN6h5lEdTy/T/41UHScUIJ7hh9joE3OVE2+M8CAC
         pUAE/eEQ/pBdkjhMJr0pydPlYm2x5TdzgrGQYqXyzshIX2Gheeb45VerTKvwfmv0Evtn
         7IAJgEu+pcvOVOW6k/3o+yQyDSHYFQKHomcMZA4YjyanuBNQ6VxAIxig4KrWwsR7UyFG
         Iveog4Wj3a429yNOE1BpuNl8xmG24xURyNBxJHx1OFcXYiI40AHhs+P/TWrnZJXYIDWR
         AXcok9oeXY8PlKpv5YSXIjF1bx+Z3H4M5Un4MIq+XfoCjcEH4jP2wLlbhE3Hrjv/j4Jo
         7YaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854568; x=1793459368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zURLoLpRz81pOab989tghAV6kuMUnboXSrX6biyebWs=;
        b=Ep3tpDFDzG4waZ0xQVnAqDkTSfxJ4amxXavanb7xKVVTOwQbjPQolJlgGTph/ZStDD
         sFUeYTt4W0GxoqkH/VbNJBcH6aoI6MX7B3l7exl16FhEgO/U2mIv4GSXxBtHK/dldug4
         OL4ewsZPDHHb7LG/wtjd0tairVJDLvshEuVf4/Wdx07qHEzCVtN0+BtQzn8uS5ezby6D
         R22YiMDTZ4SjAGokvsXuDx3aaRuLJffjQhTXvPutSnUsGp85S6l43CWciadKUW6kTuxg
         6BxI8HS/c6cjo2XaCaTAxj1ZKzmvmU3kfKINrYmOyZKyZsIYsD+RSFVOJGJxkIw4XYRW
         FKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854568; x=1793459368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zURLoLpRz81pOab989tghAV6kuMUnboXSrX6biyebWs=;
        b=yZwuX1i+ukD9rQjQ+kLVdaCv/AqWZtgZPnq3oRhFXRNpZ/94QTQWLjSHlhtLEdEILE
         GcORa5uM7VW08kl4bxN38adWbTf+ZkVAM+9E5j2K7I2TDg6gxAoA4qkl/KRhrHnoocUf
         RUvHAjkb2T+dS8b8VETPK0xaQ4oeHFblCXMbAy+DUdDCSnQ54WVkhtlwuHJnWZ2Jc1TQ
         cnRtBw+bZdloMdcTnVwrSMoHm1DcZ6OI5wBMao8hxOx2lqz/rD2kOg986cfKsdqfznXR
         7Bm1FC3h0PuPeGVxXlO36sFQKvpzoNDZwpZuH1JOieFpLCiO13YDlehQfxNDwYtAKI36
         lSkw==
X-Gm-Message-State: AFq9FYIHPzIMbT2lCMO1CVypLWsD5idAVzaz4A+hQTVGcyEZMtwXGIMb
	XyDrNehd94rbxjCq/5FXzfjqvJzz/qUV/yPJGdyzPaFsVGJ+dVOMjmP8wc4zEJoQu3nCzQZfmG5
	9a/XFUAkKd3C6kVVD0SbCylsJBXQzwFg=
X-Gm-Gg: AYBFou2w4r9KWBSMoB/nGBEqbXlF1yNHxM3XM4QaglfBacZa06rXDCsC0BuZLgXFj3x
	sw8DDWCabcbgxBC+PCgdGiYkRpNR1eaQYxCETocHxVk2YRfP/ix6KJGm1Hs6Qj8M1OXhN5qwYBQ
	aheMh/nnAn2PObVqNr9KHMUHdv56l0HoIS6Qr095Rqk2S2e3PwIb1rIu1J2wIXaCNX02K48v+M6
	3+mrfOVv0lpfCcCxdhXQzOL+gJ13xqSJ+PsOXOt4VsEAokVBrQecX/Shxg7YZOtaF3mtj6zIhvx
	nl3z216JuTcg0gvE6o461LrjmlptMgTXbUDuQBAYmoHFL7RYJ2IO+6va1IbZLp3OAMbfLu8SIoP
	x68xnkAoNsG/xTXAc2tqYJYSPjYXY7PmgaIjWquehPeQU3PIlR+4DdFmTn4Xr3BpWBcoePyFvZl
	LWHiN84GzNHpQdz3Vj3pHocMgw4MipbP30vM+KzhMC4Tzm2k7eiq4Vc9iObIP9iVZ1bPGVtuior
	Q==
X-Received: by 2002:a17:902:ef4c:b0:2e9:5eee:e087 with SMTP id
 d9443c01a7336-2ea9c7bd84cmr19659475ad.43.1792854568027; Sat, 24 Oct 2026
 08:09:28 -0700 (PDT)
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
In-Reply-To: <9fb7e77a862640007339df639d03e61db37b6f70.1792503778.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:09:16 -0400
X-Gm-Features: AclHuK-RwT7iQofoOz7tXm4c6ng0fhQk0g-BP1LoXdY7EhfbEOGufKyzJJMeL90
Message-ID: <CALnO6CCJzzX1qKeX4AR-GViM4LJjKrfdj6iafVXUQZM-c2Su4A@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] fetch: infer branches to fetch from a refmap-only remote
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:43=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Configuring remote.<name>.refmap without remote.<name>.fetch used to
> make a refspec-less "git fetch <name>" fail with "--refmap option is
> only meaningful with command-line refspec(s)", since a refmap only
> says where to put fetched refs, not what to fetch.

This makes this commit sound like a fixup of [1/5], but I think it's
actually one of the main goals of the series! Can we flip the
justification around to say something like "we want to allow refmaps
to do XYZ [=E2=80=A6] Incidentally, we also make sense of the case when ref=
map
is configured without fetch" ? That would make the purpose clearer to
me, at least.

> Make that case infer what to fetch: the local branches whose
> @{upstream} is already on that remote. This lets a remote be
> configured to fetch only the branches actually in use, without
> listing them by hand in remote.<name>.fetch, and without needing to
> touch the command line every time.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/config/remote.adoc |   5 +-
>  Documentation/fetch-options.adoc |   6 +-
>  builtin/fetch.c                  |  75 +++++++++++++++----
>  remote.c                         |  24 +++++++
>  remote.h                         |   4 ++
>  t/meson.build                    |   1 +
>  t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
>  7 files changed, 219 insertions(+), 15 deletions(-)
>  create mode 100755 t/t5586-fetch-refmap.sh
>
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remo=
te.adoc
> index 103eada406..7c52e443a5 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -36,7 +36,10 @@ remote.<name>.fetch::
>  remote.<name>.refmap::
>         The default value of the `--refmap` option for linkgit:git-fetch[=
1].
>         Used to map remote refs being fetched to remote-tracking refs to
> -       store. See the `--refmap` entry in linkgit:git-fetch[1].
> +       store. If `remote.<name>.fetch` is not set either, a refspec-less
> +       fetch infers what to fetch from local branches built on this
> +       remote, instead of fetching every branch it has. See the
> +       `--refmap` entry in linkgit:git-fetch[1].
>
>  remote.<name>.push::
>         The default set of "refspec" for linkgit:git-push[1]. See
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-optio=
ns.adoc
> index c2101a7b39..90b9e13ac2 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -245,8 +245,10 @@ endif::git-pull[]
>         command-line arguments. See section on "Configured Remote-trackin=
g
>         Branches" for details.
>  +
> -`remote.<name>.refmap` provides the default value for this option, the
> -same way `remote.<name>.fetch` provides the default refspecs to fetch.
> +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
> +nothing to fetch is specified on the command line, nor is there a
> +`remote.<name>.fetch`, branches from the remote that are used as the

"remote-tracking branches" ??

> +`@{upstream}` of our local branches are fetched.

The clause here is complicated ':D I found "infer what to fetch from
local branches built on this remote" to be a bit clearer, but we
definitely still need to get to the point, which is that
remote-tracking branches from this remote that are also configured as
upstreams of local branches are fetched.

Now, I wonder a bit: the doc says "when a refmap is active" we do that
"fetch remote-tracking branches that are upstream of local branches"
[all scoped to the current remote]---but it doesn't really say how the
refmap affects that? I mean, I imagine it's used for mapping (duh),
but I don't know if it also narrows the scope, or if the scope is
deliberately all remote-tracking branches that meet the requirements,
or=E2=80=A6?

IOW, it seems to beg the question "why does the presence of a refmap
control this if it has no effect on the set of selected branches," and
I think the answer is partly "because we designed it that way" and
possibly found in the mails leading up to this point, but we might
want to try to connect the dots for folks? Idk.

>
>  `-t`::
>  `--tags`::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 136a59154a..0fc1fb66d5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -524,6 +524,8 @@ static struct ref *get_ref_map(struct remote *remote,
>          */
>         struct refspec *effective_refmap =3D
>                 refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
> +       struct refspec inferred_rs;
> +       int infer_from_refmap =3D 0;
>
>         /* opportunistically-updated references: */
>         struct ref *orefs =3D NULL, **oref_tail =3D &orefs;
> @@ -531,15 +533,32 @@ static struct ref *get_ref_map(struct remote *remot=
e,
>         struct hashmap existing_refs;
>         int existing_refs_populated =3D 0;
>
> +       refspec_init_fetch(&inferred_rs, the_hash_algo);
> +
>         filter_prefetch_refspec(rs);
>         if (remote)
>                 filter_prefetch_refspec(&remote->fetch);
>
> +       if (!rs->nr && remote && !remote->fetch.nr &&
> +           effective_refmap && effective_refmap->nr) {
> +               struct string_list tracked =3D STRING_LIST_INIT_DUP;
> +               struct string_list_item *item;
> +
> +               branches_tracking_remote(the_repository, remote, &tracked=
);
> +               for_each_string_list_item(item, &tracked)
> +                       refspec_append(&inferred_rs, item->string);
> +               string_list_clear(&tracked, 0);

Interesting choice of string_list again ;) do we need the sorting
behavior? (In fact, since it could come from an "ordered" config,
perhaps we should use that order?) A strvec seems more appropriate
then=E2=80=A6

> +
> +               rs =3D &inferred_rs;
> +               infer_from_refmap =3D 1;
> +       }
> +
>         if (rs->nr) {
>                 struct refspec *fetch_refspec;
>
>                 for (i =3D 0; i < rs->nr; i++) {
> -                       get_fetch_map(remote_refs, &rs->items[i], &tail, =
0);
> +                       get_fetch_map(remote_refs, &rs->items[i], &tail,
> +                                     infer_from_refmap);
>                         if (rs->items[i].dst && rs->items[i].dst[0])
>                                 *autotags =3D 1;
>                 }
> @@ -574,6 +593,8 @@ static struct ref *get_ref_map(struct remote *remote,
>
>                 for (i =3D 0; i < fetch_refspec->nr; i++)
>                         get_fetch_map(ref_map, &fetch_refspec->items[i], =
&oref_tail, 1);
> +       } else if (infer_from_refmap) {
> +               /* Already fully handled above. */
>         } else if (refmap.nr) {
>                 die("--refmap option is only meaningful with command-line=
 refspec(s)");
>         } else {
> @@ -669,6 +690,7 @@ static struct ref *get_ref_map(struct remote *remote,
>         if (existing_refs_populated)
>                 hashmap_clear_and_free(&existing_refs, struct refname_has=
h_entry, ent);
>
> +       refspec_clear(&inferred_rs);
>         return ref_map;
>  }
>
> @@ -1978,13 +2000,47 @@ static int do_fetch(struct transport *transport,
>
>         if (rs->nr) {
>                 refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_p=
refixes);
> +       } else if (transport->remote->fetch.nr) {
> +               struct string_list tracked =3D STRING_LIST_INIT_DUP;
> +               struct string_list_item *item;
> +
> +               refspec_ref_prefixes(&transport->remote->fetch,
> +                                    &transport_ls_refs_options.ref_prefi=
xes);
> +               /*
> +                * See remote.c's handling of remote.<name>.followRemoteH=
EAD
> +                * for the analogous, still-unresolved case.

Is this a "we haven't resolved what to do" case, or a "some remote (or
something) hasn't resolved" case? I'm not sure what I should be
looking at here.

Oh, I see. It's a duplicate of comment and code from the
else{effective_refmap->nr} block below. Hrm=E2=80=A6 probably it would be n=
ice
not to duplicate that? I can't spot any differences between the code
blocks.

> +                */
> +               if (transport->remote->follow_remote_head)
> +                       follow_remote_head =3D transport->remote->follow_=
remote_head;
> +               else if (config->follow_remote_head_seen)
> +                       follow_remote_head =3D get_follow_remote_head(con=
fig->follow_remote_head_raw);
> +               else
> +                       follow_remote_head =3D BUILTIN_FOLLOW_REMOTE_HEAD=
_DFLT;
> +
> +               /*
> +                * The configured refspec may not cover the current
> +                * branch's upstream (e.g. a narrowed -t refspec), so
> +                * make sure we can still fetch it regardless.
> +                */
> +               collect_upstream_from_remote(the_repository, &tracked,
> +                                             transport->remote, NULL);
> +               for_each_string_list_item(item, &tracked)
> +                       strvec_push(&transport_ls_refs_options.ref_prefix=
es,
> +                                   item->string);
> +               string_list_clear(&tracked, 0);
>         } else {
> +               /*
> +                * The --refmap command line option, if given, takes
> +                * precedence over remote.<name>.refmap.
> +                */
> +               struct refspec *effective_refmap =3D refmap.nr ? &refmap =
:
> +                       &transport->remote->refmap;
>                 struct string_list tracked =3D STRING_LIST_INIT_DUP;
>                 struct string_list_item *item;
>
> -               if (transport->remote->fetch.nr) {
> -                       refspec_ref_prefixes(&transport->remote->fetch,
> -                                            &transport_ls_refs_options.r=
ef_prefixes);
> +               if (effective_refmap->nr) {
> +                       branches_tracking_remote(the_repository,
> +                                                 transport->remote, &tra=
cked);
>                         /*
>                          * See remote.c's handling of remote.<name>.follo=
wRemoteHEAD
>                          * for the analogous, still-unresolved case.
> @@ -1995,15 +2051,10 @@ static int do_fetch(struct transport *transport,
>                                 follow_remote_head =3D get_follow_remote_=
head(config->follow_remote_head_raw);
>                         else
>                                 follow_remote_head =3D BUILTIN_FOLLOW_REM=
OTE_HEAD_DFLT;
> +               } else {
> +                       collect_upstream_from_remote(the_repository, &tra=
cked,
> +                                                     transport->remote, =
NULL);
>                 }
> -
> -               /*
> -                * The configured refspec may not cover the current
> -                * branch's upstream (e.g. a narrowed -t refspec), so
> -                * make sure we can still fetch it regardless.
> -                */
> -               collect_upstream_from_remote(the_repository, &tracked,
> -                                             transport->remote, NULL);
>                 for_each_string_list_item(item, &tracked)
>                         strvec_push(&transport_ls_refs_options.ref_prefix=
es,
>                                     item->string);
> diff --git a/remote.c b/remote.c
> index 965e42ff52..6467496a0f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1906,6 +1906,30 @@ void collect_upstream_from_remote(struct repositor=
y *repo,
>                 string_list_insert(tracked, branch->merge[i]->src);
>  }
>
> +struct branches_tracking_remote_cb_data {
> +       struct repository *repo;
> +       struct remote *remote;
> +       struct string_list *tracked;
> +};
> +
> +static int add_if_tracking_remote(const struct reference *ref, void *cb_=
data)
> +{
> +       struct branches_tracking_remote_cb_data *data =3D cb_data;
> +
> +       collect_upstream_from_remote(data->repo, data->tracked, data->rem=
ote,
> +                                     ref->name);
> +       return 0;
> +}
> +
> +void branches_tracking_remote(struct repository *repo, struct remote *re=
mote,
> +                              struct string_list *tracked)
> +{
> +       struct branches_tracking_remote_cb_data data =3D { repo, remote, =
tracked };
> +
> +       refs_for_each_branch_ref(get_main_ref_store(repo),
> +                                 add_if_tracking_remote, &data);
> +}
> +
>  __attribute__((format (printf,2,3)))
>  static char *error_buf(struct strbuf *err, const char *fmt, ...)
>  {
> diff --git a/remote.h b/remote.h
> index 7c86c529b6..62265346d3 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -368,6 +368,10 @@ void collect_upstream_from_remote(struct repository =
*repo,
>                                    struct remote *remote,
>                                    const char *refname);
>
> +/* fills tracked with the refname of every local branch's upstream on re=
mote */
> +void branches_tracking_remote(struct repository *repo, struct remote *re=
mote,
> +                              struct string_list *tracked);
> +
>  /* list of the remote in a group as configured */
>  struct remote_group_data {
>         const char *name;

I stopped reading here, but it made a bit of sense up to this point. I
wonder if the remote.h comment on the new function could be more
clear, but :shrug:

--=20
D. Ben Knoble

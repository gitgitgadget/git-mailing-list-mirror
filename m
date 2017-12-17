Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933721F428
	for <e@80x24.org>; Sun, 17 Dec 2017 10:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdLQKUX (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 05:20:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45574 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdLQKUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 05:20:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id m25so8034151pgv.12
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VFcxw8nfSJOwEFOVU6REs/jBZ6xdFe6fbOwXMOhAdZI=;
        b=DPpx7O8kM+dltgmEmfxd57r2pL+dy48sgdJ4mGmaiNQcdjAzVk1f0s+6xnVN+p+ise
         +vHcom8bKP13roi7OVfflJwZi7Ob2kANV2X9j3u4Am+CeK/MlPfNZpYHvkhurzFQ/vwL
         0DWsjyQ94JHKQ9l4cKBI1EhFns0gcidfa+UY0DDV7akUuOii/jJpG5R+ZniPJyDDM35G
         RyHsnXb+IonsCXSj1eGE1HOzjw7L2eMTceJQRevxzdWz7NmD/MYaPSWxxx+1EeZ0M5vm
         apcASCI3waicaqTGOSPCD/qx/DJuTJtZAMV+sErdrGrBoMyKzDBSuiXeA3go5bD69kLT
         jXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VFcxw8nfSJOwEFOVU6REs/jBZ6xdFe6fbOwXMOhAdZI=;
        b=EeKHM6Q5mhEthOcvyqBg/zGaIRQ8iyZk9XDGMhodtjbJ4DtF4rcUdXTRk9Q3ONUTqA
         YbPEx+ucUZMT5Szk6EYrrRdp97zw+6t/wHz93vZTAe8sPefgiP/v94DyDsYdj3ibORId
         wDEJDj90Ebo8sDyaSpODvP6/tqSb/RVfnTlFqnjxcq0tcb6jo2KRG2So9rrguI+LT+xq
         IfiTHHCIIAahiRqGKRvIF0xmku7Pw4jWI30GA2Ybi3qpoR3317+e/j+Zqd+qAGLQ61OE
         FnfDAQC6nLx1DkLkHD0DLY6K7oWWEwO+UtofvV0mkAzs47G7qsuWWaRL3CPVNexxqIlv
         rbMA==
X-Gm-Message-State: AKGB3mJW5vyW3NXNSm3xRCWaOFgQZKsQ8diduDUsPoGRbNPtOeigw2x1
        2m8BtUXCFgynhQ+UdqEA64oUDSVeBzAVtBNV70E=
X-Google-Smtp-Source: ACJfBovCzfz/Fou4TUZ/fXs7jv7Y/1xqk9DYDQxIYqrvsFo3Gl9olhYrsYPGYwCIINIcNTWLMVkCAquPJmiZd7xXOlM=
X-Received: by 10.101.65.129 with SMTP id a1mr16903750pgq.203.1513506020728;
 Sun, 17 Dec 2017 02:20:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.179.136 with HTTP; Sun, 17 Dec 2017 02:20:20 -0800 (PST)
In-Reply-To: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 Dec 2017 11:20:20 +0100
Message-ID: <CAN0heSom46uJMmf2ST5PBqUYv7=9xG=J0ndEv5A=vT3EQCWzSQ@mail.gmail.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 December 2017 at 13:12, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> prepare_revision_walk() allows callers to take ownership of the array of
> pending objects by setting the rev_info flag "leak_pending" and copying
> the object_array "pending".  They use it to clear commit marks after
> setup is done.  This interface is brittle enough that it requires
> extensive comments.
>
> Provide an easier way by adding a function that can hand over the array
> to a caller-supplied output parameter and converting all users of the
> flag "leak_pending" to call prepare_revision_walk_extended() instead.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  Documentation/technical/api-revision-walking.txt |  6 ++++++
>  bisect.c                                         | 17 +++++------------
>  builtin/checkout.c                               |  9 +--------
>  bundle.c                                         |  9 +--------
>  revision.c                                       | 10 +++++++++-
>  revision.h                                       | 14 ++------------
>  6 files changed, 24 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/technical/api-revision-walking.txt b/Documenta=
tion/technical/api-revision-walking.txt
> index 55b878ade8..9dc573d2ec 100644
> --- a/Documentation/technical/api-revision-walking.txt
> +++ b/Documentation/technical/api-revision-walking.txt
> @@ -50,6 +50,12 @@ function.
>         returns any error (non-zero return code) and if it does not, you =
can
>         start using get_revision() to do the iteration.
>
> +`prepare_revision_walk_extended`::
> +
> +       Like prepare_revision_walk(), but allows callers to take ownershi=
p
> +       of the array of pending objects by passing an object_array pointe=
r
> +       as the second parameter; passing NULL clears the array.

This might make someone wonder what the difference between passing NULL
and using `prepare_revision_walk()` is. Perhaps: "passing NULL clears
the array, just as prepare_revision_walk() would." Possibly only matters
once we gain more parameters, and maybe not even then...

The name of your new function ("..._extended") doesn't describe the
nature of the extended behavior and made me wonder if it was too
generic. But that genericness might be a good thing. When/If we need to
tweak the behavior along some other axis, we can add a third parameter
to ..._extended and pass NULL/0 as appropriate. The simple cases will
stay simple and we won't gain lots of functions with minor differences.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e1e157d205..1f04f5d5e5 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -796,14 +796,7 @@ static void orphaned_commit_warning(struct commit *o=
ld, struct commit *new)
>         add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
>
>         /* Save pending objects, so they can be cleaned up later. */
> -       refs =3D revs.pending;
> -       revs.leak_pending =3D 1;
> -
> -       /*
> -        * prepare_revision_walk (together with .leak_pending =3D 1) make=
s us
> -        * the sole owner of the list of pending objects.
> -        */
> -       if (prepare_revision_walk(&revs))
> +       if (prepare_revision_walk_extended(&revs, &refs))
>                 die(_("internal error in revision walk"));
>         if (!(old->object.flags & UNINTERESTING))
>                 suggest_reattach(old, &revs);
> diff --git a/bundle.c b/bundle.c
> index 93290962c9..6af6e38c40 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -158,14 +158,7 @@ int verify_bundle(struct bundle_header *header, int =
verbose)
>         setup_revisions(2, argv, &revs, NULL);
>
>         /* Save pending objects, so they can be cleaned up later. */
> -       refs =3D revs.pending;
> -       revs.leak_pending =3D 1;
> -
> -       /*
> -        * prepare_revision_walk (together with .leak_pending =3D 1) make=
s us
> -        * the sole owner of the list of pending objects.
> -        */
> -       if (prepare_revision_walk(&revs))
> +       if (prepare_revision_walk_extended(&revs, &refs))
>                 die(_("revision walk setup failed"));
>
>         i =3D req_nr;

This copy-paste coding that you get rid of here can be attributed to me.
I obviously like your cleaned-up version much better.

> diff --git a/revision.h b/revision.h
> index 54761200ad..5d4b475334 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -150,18 +150,6 @@ struct rev_info {
>                         date_mode_explicit:1,
>                         preserve_subject:1;
>         unsigned int    disable_stdin:1;
> -       /*
> -        * Set `leak_pending` to prevent `prepare_revision_walk()` from c=
learing
> -        * the array of pending objects (`pending`). It will still forget=
 about
> -        * the array and its entries, so they really are leaked. This can=
 be
> -        * useful if the `struct object_array` `pending` is copied before
> -        * calling `prepare_revision_walk()`. By setting `leak_pending`, =
you
> -        * effectively claim ownership of the old array, so you should mo=
st
> -        * likely call `object_array_clear(&pending_copy)` once you are d=
one.
> -        * Observe that this is about ownership of the array and its entr=
ies,
> -        * not the commits referenced by those entries.
> -        */
> -       unsigned int    leak_pending:1;
>         /* --show-linear-break */
>         unsigned int    track_linear:1,
>                         track_first_time:1,

The commit message doesn't mention that you drop `leak_pending`, but
maybe that's obvious enough since you convert all users.

Thanks for tidying up,
Martin

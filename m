Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E541F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeISWFU (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:05:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38295 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbeISWFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:05:20 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so8517535ite.3
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LbdxiR/UibOGJSly5TYqDMV5okUc7zh7gBAheZXVXlU=;
        b=L0RGXHT4SCdqCZfS9jEqMl5BBob4aq+rQ5nCDqVsmWLG5MVrEU0RwJuxVBlu8x/Px8
         bjPqu9mjebnzwKqb9c3B6D18knNteb7dL+sz+yLpI3J0GswL5T7XTKOnZNqS4PW4+CgT
         /FezNHmVA/lMmQpWHpsX+XK2PjlDsXCPFoqRQ/Ue2LOMOsuE6h6pb0QaCBeGmk7eX211
         anE/nN7h2UEL54kcFVDinivtdFx7h6gdRrinZvjbROEMk+WSazuZJwsCyiERe4HbTNMg
         2eLNH5J1WvaS4R9u+PqVVe5fkrCPaaKTs8XxD8peDue3HB2mqMg2YjhrYQa2Bp0i/eES
         jaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LbdxiR/UibOGJSly5TYqDMV5okUc7zh7gBAheZXVXlU=;
        b=kCYeUtJUYexzKsGoitl9nAzO9UdepYwyWgjxFSNj6DUKNRBYe1EJbmCP7mj8jHE+Mg
         UKer/DI/fpEdDwO21vaZC+cfdzna/WX+668eCYeWJqRfroqqgA/7PLMZl80UJ+21sB0h
         XAxoSQKvub4ekmKAmk0EB1xGdS4Un5EPZmyA414ttniF3aVEQtS3WALaMRsjZOLBBfPv
         CK/xQC2vrOssR0MiIeljp+VJccPlFq5+38Q1ja9pcY+XLOijqnlPZTqzf7rGpJuutNQV
         GJ6vjAiRADm9UWI6beTTDGWmQ4GitNbypFHa1tYaReAwriLiwhPViwlZoZ5rbJ9mlNdi
         +jaQ==
X-Gm-Message-State: APzg51DYqW3Okuvcw95fiflrcvJQwPJDJsbtMWaHJz06zIef8Yk+DV1Z
        QL1D9S2/hd2bdIzbwSNPkChTLratRANVhycvNoU=
X-Google-Smtp-Source: ANB0Vdas/SsWaVeUlACbCGW33vW3EHLLK8h8UdXHpybtpZvYoyzeaeJWCBEDveJQP/23n/ycbaDBkqoT1CRvNZlC/CA=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr22053370itg.91.1537374400492;
 Wed, 19 Sep 2018 09:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141016.27930-1-avarab@gmail.com>
In-Reply-To: <20180919141016.27930-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Sep 2018 18:26:14 +0200
Message-ID: <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com>
Subject: Re: [PATCH] reflog expire: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 4:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Before this change the "git reflog expire" command didn't report any
> progress.

I love these progress additions you've been pushing lately :)

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 3acef5a0ab..d3075ee75a 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -10,6 +10,7 @@
>  #include "diff.h"
>  #include "revision.h"
>  #include "reachable.h"
> +#include "progress.h"
>
>  /* NEEDSWORK: switch to using parse_options */
>  static const char reflog_expire_usage[] =3D
> @@ -225,14 +226,20 @@ static void mark_reachable(struct expire_reflog_pol=
icy_cb *cb)
>         struct commit_list *pending;
>         timestamp_t expire_limit =3D cb->mark_limit;
>         struct commit_list *leftover =3D NULL;
> +       struct progress *progress =3D NULL;
> +       int i =3D 0;
>
>         for (pending =3D cb->mark_list; pending; pending =3D pending->nex=
t)
>                 pending->item->object.flags &=3D ~REACHABLE;
>
>         pending =3D cb->mark_list;
> +       progress =3D start_delayed_progress(
> +               _("Marking unreachable commits in reflog for expiry"), 0)=
;

Maybe just "Searching expired reflog entries" or something like that.
It's not technically as accurate, but I think it's easier to
understand by by new people.

Do we have --quiet option or something that needs to completely
suppress this progress thing?

>         while (pending) {
>                 struct commit_list *parent;
>                 struct commit *commit =3D pop_commit(&pending);
> +
> +               display_progress(progress, ++i);

maybe rename it to commit_count or something and leave "i" for
temporary/short lived usage.

>                 if (commit->object.flags & REACHABLE)
>                         continue;
>                 if (parse_commit(commit))
> @@ -253,6 +260,7 @@ static void mark_reachable(struct expire_reflog_polic=
y_cb *cb)
>                 }
>         }
>         cb->mark_list =3D leftover;
> +       stop_progress(&progress);
>  }
>
>  static int unreachable(struct expire_reflog_policy_cb *cb, struct commit=
 *commit, struct object_id *oid)
> --
> 2.19.0.444.g18242da7ef
>
--=20
Duy

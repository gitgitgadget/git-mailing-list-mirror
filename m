Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8459C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE372611CA
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhJDPBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhJDPBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 11:01:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D64C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:59:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bd28so65790495edb.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zfxhp1wIuT2OJfjD1ticSdwO4ysNbJPY/uQisom+pbg=;
        b=AQGpm7ECAGnhFzvfhYslypWF72CNWWDS0SlexE68Z9jn0OcIy6ZwMxjhmVGbiK9vad
         +BUx3Py3iF12+lUvG3CUvZ2HsCy9ODteLI8IiQXmZ1IEaFcLSXStik4uOKXdV03sxJN1
         /Y0ltQtIvDvcDiVAR/fsmg/EAUPO7YKwbDDlp8H6S0MPrqcxrp0onPCRrMUy6qjRHkpS
         HGhfh11tTc2VVzCKIkpd1W2ifELLrrfupu/amU9lEEUn76WhgheRGIsGRzA/MSlakyQ1
         0BvCewT/iyMpuCAUMrejdZs37jhPLZxUxEZh6VDAVwssrZfD0Qvp4AGylxpnT0109t83
         Tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zfxhp1wIuT2OJfjD1ticSdwO4ysNbJPY/uQisom+pbg=;
        b=THGj8gwt5TBDOpcySA4xSA0D8JihKUrX3iMoZwePjMC3BqDWnLXXUbNJbILPzBWEEH
         V/0wY4pQnfaYbeODJs3he0ukPmefnbc0Ov8Gp9NSnw61phYByLN5tQuw3HAKY6qMSGP/
         c4/nBR1vndX9lofEgglw6U7MRL8nSitjdxo9F11RUlXhsF+7KVAgkSV0sZCLa0+K48Kn
         m9ad043YdFZZOuMh9Bllsif4WxgixKHT3MtDdMbPgd87gxmGuL4DvEmPBMp1Q6OtS2+5
         xJ1cYnJCnC+wUgeWO3v72MNU/Umd0ZwUwrEML2uw8DlFEYwX3LfAiCAJ/2Ny2sPSPnEL
         leSA==
X-Gm-Message-State: AOAM531WOICFy4BkFJmpSOVYYFSNxqlV2Ja4ltSG9Du/dZU3h3c4CndO
        kIYH3Ocp4+iqAdCp64Kgj+m4Nm9bkwn48tY/JbmIM0jddNRI9g==
X-Google-Smtp-Source: ABdhPJym2maoTZI5XmrKaAstd/POCL5JYPwd3U7c0QePpm5OwHd5osjy+UCvToz3EGR4ATNDYz/3SwiLSkRbsjgp5lo=
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr18706865edd.62.1633359469644;
 Mon, 04 Oct 2021 07:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com> <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com> <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com> <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com> <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
 <87k0ivpzfx.fsf@evledraar.gmail.com> <CABPp-BFE_5zPCZY8adJSQchdQzxq3uH-oma-S=_Sw0OUXx03OQ@mail.gmail.com>
 <8735pgop57.fsf@evledraar.gmail.com>
In-Reply-To: <8735pgop57.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 07:57:38 -0700
Message-ID: <CABPp-BHgot=CPNyK_xNfog_SqsNPNoCGfiSb-gZoS2sn_741dQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to unpack_trees_options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 7:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Mon, Oct 04 2021, Elijah Newren wrote:
>
> > On Sat, Oct 2, 2021 at 2:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> On Fri, Oct 01 2021, Elijah Newren wrote:
> >>
> > ...
> >> > So maybe I'll submit some patches on top that rip these direct membe=
rs
> >> > out of of unpack_trees_options and push them inside some opaque
> >> > struct.
> >>
> >> Sure, that sounds good. I only had a mild objection to doing it in a w=
ay
> >> where you'll need that sort of code I removed in the linked commit in
> >> prep_exclude() because you were trying not to expose that at any cost,
> >> including via some *_INIT macro. I.e. if it's private we can just name
> >> it "priv_*" or have a :
> >>
> >>     struct dont_touch_this {
> >>         struct dir_struct dir;
> >>     };
> >>
> >> Which are both ways of /messaging/ that it's private, and since the
> >> target audience is just the rest of the git.git codebase I think that
> >> ultimately something that 1) sends the right message 2) makes accident=
s
> >> pretty much impossible suffices. I.e. you don't accidentally introduce=
 a
> >> new API user accessing a field called "->priv_*" or
> >> "->private_*". Someone will review those patches...
> >
> > An internal struct with all the members meant to be internal-only
> > provides nearly all the advantages that I was going for with the
> > opaque struct, while also being a smaller change than what I was
> > thinking of doing.  I like that idea; thanks for the suggestion.
>
> Yeah, just to provide an explicit example something like the below. It
> compiles to the same assembly (at least under -O3, didn't exhaustively
> try other optimization levels).
>
> I'm rather "meh" on it v.s. just prefixing the relevant member names
> with "priv_" or "private_", but it results in the same semantics &
> machine code, so it's effectively just a way of doing the labeling for
> human consumption.
>
> diff --git a/dir.c b/dir.c
> index 39fce3bcba7..a714640e782 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1533,12 +1533,12 @@ static void prep_exclude(struct dir_struct *dir,
>          * which originate from directories not in the prefix of the
>          * path being checked.
>          */
> -       while ((stk =3D dir->exclude_stack) !=3D NULL) {
> +       while ((stk =3D dir->private.exclude_stack) !=3D NULL) {
>                 if (stk->baselen <=3D baselen &&
>                     !strncmp(dir->basebuf.buf, base, stk->baselen))
>                         break;
> -               pl =3D &group->pl[dir->exclude_stack->exclude_ix];
> -               dir->exclude_stack =3D stk->prev;
> +               pl =3D &group->pl[dir->private.exclude_stack->exclude_ix]=
;
> +               dir->private.exclude_stack =3D stk->prev;
>                 dir->pattern =3D NULL;
>                 free((char *)pl->src); /* see strbuf_detach() below */
>                 clear_pattern_list(pl);
> @@ -1584,7 +1584,7 @@ static void prep_exclude(struct dir_struct *dir,
>                                                  base + current,
>                                                  cp - base - current);
>                 }
> -               stk->prev =3D dir->exclude_stack;
> +               stk->prev =3D dir->private.exclude_stack;
>                 stk->baselen =3D cp - base;
>                 stk->exclude_ix =3D group->nr;
>                 stk->ucd =3D untracked;
> @@ -1605,7 +1605,7 @@ static void prep_exclude(struct dir_struct *dir,
>                             dir->pattern->flags & PATTERN_FLAG_NEGATIVE)
>                                 dir->pattern =3D NULL;
>                         if (dir->pattern) {
> -                               dir->exclude_stack =3D stk;
> +                               dir->private.exclude_stack =3D stk;
>                                 return;
>                         }
>                 }
> @@ -1662,7 +1662,7 @@ static void prep_exclude(struct dir_struct *dir,
>                         invalidate_gitignore(dir->untracked, untracked);
>                         oidcpy(&untracked->exclude_oid, &oid_stat.oid);
>                 }
> -               dir->exclude_stack =3D stk;
> +               dir->private.exclude_stack =3D stk;
>                 current =3D stk->baselen;
>         }
>         strbuf_setlen(&dir->basebuf, baselen);
> @@ -3302,7 +3302,7 @@ void dir_clear(struct dir_struct *dir)
>         free(dir->ignored);
>         free(dir->entries);
>
> -       stk =3D dir->exclude_stack;
> +       stk =3D dir->private.exclude_stack;
>         while (stk) {
>                 struct exclude_stack *prev =3D stk->prev;
>                 free(stk);
> diff --git a/dir.h b/dir.h
> index 83f46c0fb4c..d30d294308d 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -209,6 +209,11 @@ struct untracked_cache {
>   * record the paths discovered. A single `struct dir_struct` is used reg=
ardless
>   * of whether or not the traversal recursively descends into subdirector=
ies.
>   */
> +
> +struct dir_struct_private {
> +       struct exclude_stack *exclude_stack;
> +};
> +
>  struct dir_struct {
>
>         /* The number of members in `entries[]` array. */
> @@ -327,7 +332,7 @@ struct dir_struct {
>          * (sub)directory in the traversal. Exclude points to the
>          * matching exclude struct if the directory is excluded.
>          */
> -       struct exclude_stack *exclude_stack;
> +       struct dir_struct_private private;
>         struct path_pattern *pattern;
>         struct strbuf basebuf;

Yeah, that doesn't help much at all, and I'd argue even makes things
worse, because you're just looking at a single member.  This subtly
implies that all the other private variables are public API.  The
dir.h portion of the patch should look more like this:

$ git diff -w dir.h
diff --git a/dir.h b/dir.h
index 83f46c0fb4..93a9f02688 100644
--- a/dir.h
+++ b/dir.h
@@ -214,14 +214,9 @@ struct dir_struct {
        /* The number of members in `entries[]` array. */
        int nr;

-       /* Internal use; keeps track of allocation of `entries[]` array.*/
-       int alloc;
-
        /* The number of members in `ignored[]` array. */
        int ignored_nr;

-       int ignored_alloc;
-
        /* bit-field of options */
        enum {

@@ -301,11 +296,19 @@ struct dir_struct {
         */
        const char *exclude_per_dir;

+       struct dir_struct_internal {
+               /* Keeps track of allocation of `entries[]` array.*/
+               int alloc;
+
+               /* Keeps track of allocation of `ignored[]` array. */
+               int ignored_alloc;
+
                /*
                 * We maintain three groups of exclude pattern lists:
                 *
                 * EXC_CMDL lists patterns explicitly given on the command =
line.
-        * EXC_DIRS lists patterns obtained from per-directory ignore files=
.
+                * EXC_DIRS lists patterns obtained from per-directory igno=
re
+                *          files.
                 * EXC_FILE lists patterns from fallback ignore files, e.g.
                 *   - .git/info/exclude
                 *   - core.excludesfile
@@ -340,6 +343,7 @@ struct dir_struct {
                /* Stats about the traversal */
                unsigned visited_paths;
                unsigned visited_directories;
+       } internal;
 };

 #define DIR_INIT { 0 }


The above change would make it clear that there are 12 variables meant
for use only within dir.c that external callers should not be
initializing or reading for output after the fact -- and only 6 that
are part of the public API that they need worry about.  It also makes
it easier for folks messing with dir.c to know which parts are just
internal state management, which I think would have made it easier to
understand the weird basebuf/exclude_stack stuff in prep_exclude()
that you nicely tracked down.  But overall, I'm really most happy
about the part of this patch that lets external callers realize they
only need to worry about 6 out of 18 fields and that they can ignore
the rest.

unpack_trees_options should have something similar done with it, and
maybe some others.

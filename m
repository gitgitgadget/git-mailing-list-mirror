Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F74C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FB560232
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhHBNgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhHBNeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:34:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BAC061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:34:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z7so19430603iog.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KCUy5kUyR6XUFZdjQIoqlhFOmDu+WDjOVv1h3PnpNfM=;
        b=WfZRfwCpt3Su6V7nzo08uFn35RTYEzjbfS0yorHjSQ0p9/aFBc04RLlWDJRP7cmzwi
         gqy0uTgiD/Xhg774y+JNbsGO57W70BMTXS86TMpMnd2i6cwho8l24M34RAOB6xMxJWVW
         6PPOwCmLMvQS3VzaKr0RSejH22kwCsy9e5wHU4EdY6sOPzeUPd0B3zaDi6F9RT6oE4qj
         4F2o8sMMlV6y4s1M7v7qoeLN08+Cm2XF1wk8RXePaouYAWShC72mfiUvtt/iTT77sQkQ
         E4RNyY8T1f+70ZHu+4if/+RzaaG+N8PtJDWqK7Yy5ZA3tYCHT0IXr/jZbcx+kynyZHRI
         lrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KCUy5kUyR6XUFZdjQIoqlhFOmDu+WDjOVv1h3PnpNfM=;
        b=pTKJqtgMZRIUlUQHvfyxFhci/STOcQEoDuYgOBM6rwloQRVRjn+fAxkFNoS8P7dKA/
         nAPzKZ4tl0s5qbmSrsFfKo+fkwv6fhwpr4mz42KGrN7BsStuMQR9xBvY6JS2C8K6Gl3f
         DH6L0OLmMkf2eIoTiirKBNB5/t5o7SdT4EgJQAixTMLJmpecs0OjTQi8Dmd794efeaLu
         TjX8i2dgE71hxnqW/12sRv3gUiMHe/+EowzlOY/iKe5saGQ8aKZHdjmX30giBJDwYBD+
         KtYmIR5JUZZYgTRNqqdW6diz46hfIjh5By0I/idgUsykpdQbizzwrcQ878hM4fdZVZYp
         YB0g==
X-Gm-Message-State: AOAM533UFpR3yBavTWWzO0yX/y8ptGYcKc2bYCOqCyBjiu6whXSK6+tA
        Gv6JFnlCp1K1KYBoOGQlpvkv8D/BWliTq0zqVXg=
X-Google-Smtp-Source: ABdhPJySOC03oQuIgNp4DKmS+JRGdaP0vJ10XA8PLeYDIIKovtFDBIbw60ZmD+rzlbOlTuy3rfV6OwDajqFKuAu64Ao=
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr1866783jaj.10.1627911244715;
 Mon, 02 Aug 2021 06:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <0d0a55bd9c4094450749fa20a30d0d11203768d6.1627714878.git.gitgitgadget@gmail.com>
 <273d1864-422e-f31f-13ef-20cfe4871947@gmail.com>
In-Reply-To: <273d1864-422e-f31f-13ef-20cfe4871947@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 2 Aug 2021 21:34:46 +0800
Message-ID: <CAOLTT8S=v41p_uZQ4u0LBnHkRp3pMpVK0Pt5mykzbfX9ReTC7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     phillip.wood@dunelm.org.uk
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=881=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:10=E5=86=99=E9=81=93=EF=BC=
=9A
>
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 12f093121d9..5983f37d531 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -84,6 +84,7 @@ struct rebase_options {
> >               REBASE_FORCE =3D 1<<3,
> >               REBASE_INTERACTIVE_EXPLICIT =3D 1<<4,
> >       } flags;
> > +     int delete_cherry_pick_head;
> >       struct strvec git_am_opts;
> >       const char *action;
> >       int signoff;
> > @@ -152,6 +153,7 @@ static struct replay_opts get_replay_opts(const str=
uct rebase_options *opts)
> >               oidcpy(&replay.squash_onto, opts->squash_onto);
> >               replay.have_squash_onto =3D 1;
> >       }
> > +     replay.delete_cherry_pick_head =3D opts->delete_cherry_pick_head;
>
> I think we could just have
>         replay.delete_cherry_pick_head =3D 1;
> and not add a new member to rebase_options as we always want this set

Maybe you are right.

> > -static void print_advice(struct repository *r, int show_hint,
> > -                      struct replay_opts *opts)
> > +static void print_advice(struct replay_opts *opts, int show_hint)
> >   {
> >       char *msg =3D getenv("GIT_CHERRY_PICK_HELP");
> >
> >       if (msg) {
> > -             fprintf(stderr, "%s\n", msg);
> > -             /*
> > -              * A conflict has occurred but the porcelain
> > -              * (typically rebase --interactive) wants to take care
> > -              * of the commit itself so remove CHERRY_PICK_HEAD
> > -              */
> > -             refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_H=
EAD",
> > -                             NULL, 0);
> > -             return;
> > -     }
> > -
> > -     if (show_hint) {
> > +             advise("%s\n", msg);
>
> This is a change in behavior as the advice will now be prefixed with
> "hint: ". I think that is probably an improvement so long as it does not
> make the lines too long when the advice is printed.
>

Yeah, maybe I should mention this in commit messages.

>
> I think it would be useful to add a test for the new cherry-pick option
> that is added in this patch. Overall this patch is looking pretty good
> it just needs a few small changes, thanks for working on it.
>

Make sence.

> Best Wishes
>
> Phillip

Thanks.
--
ZheNing Hu

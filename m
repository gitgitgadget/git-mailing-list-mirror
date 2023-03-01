Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F6FC7EE31
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 09:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCAJbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 04:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 04:31:45 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B5C39BBD
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 01:31:44 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5384ff97993so350589977b3.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 01:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGhWbw57cnn2PqjCKi1Qh9zhQt8NEJ+NnpQ6itCwWgE=;
        b=SZB91Zb9ou6RiwQJc39xS5jh/YiLkFHlERKoI70O54NxBAi1/dkqUaZfduH1pL4NQP
         vQxQJkczR/q6I9C05DMyriC4SiZ8ZbK8WrtJBGQA4AbZpQSxcGW/sWO18MfDGRiaIIDi
         XEZAXN+DhuxttNd9G/U0zk0Tb/OxZiRK6U3ba4l8IO441n09ToRKohnxz1pqPKcOblgQ
         ZZlK79923IOtLnhPanyv1TTlmkp1uycatLu/UqLljoRV/ixNvonSDvhLAo/pmBF/Nr4j
         aF+AFwq8kB3BmDWfXWXse5rd0KUHzI8NppVknw+MI9FiCamtwdrFiaPE2I1glYXKrPgq
         dbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGhWbw57cnn2PqjCKi1Qh9zhQt8NEJ+NnpQ6itCwWgE=;
        b=AdQgvkSvQ0Fv9YJewQ/1gIG0uU+W+lsbEDYbEKlKK3przRyWC/7i1CqLchZVvjkHef
         SmJATyfr8j1oQNCPXzxgGULcl4L2FH886ImxcYbj3W3+EMdxkaSTkNreAXoa1xKBfAfi
         l3Actd9K+gJ6xt1Czj36M3wkqmfa66t8Jzl70NQmuWv7mRK461HBbX3ewBDsZpy7wgdI
         hOFNLNzPx4d69oChOW+/in6OONqA+ROiR7EVP6YnUk2IWu806nqvTdHDFe2GTajVMC6c
         pX9yt28oxys1bdK9WK44iACL2dUlKltybxobrUqH/M5anH431wQkdRl/zsFXhwKXnmiK
         bcoA==
X-Gm-Message-State: AO0yUKU4zoWoV2UQZe+YhSnUDdQpv3aUJsIWyZT/i3MeSCM4b85aBl6c
        T36t6olIS86iL4sklpogltfei675uQDnQvtupD4CH0N4GXsSSw==
X-Google-Smtp-Source: AK7set/ZgJtTFFTUIxuvb8Z5GtHKx7/h6Z4L6tEFJ2V5Xqx9FPtwLsjWxq74VYRQl5hIevr0aVu2SaB9ltGtLTf++9c=
X-Received: by 2002:a05:6902:90:b0:ac9:cb97:bd0e with SMTP id
 h16-20020a056902009000b00ac9cb97bd0emr109568ybs.5.1677663104195; Wed, 01 Mar
 2023 01:31:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
 <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com> <857d2435caf6211cd5a1baa6c9d77311ce7ba745.1677463022.git.gitgitgadget@gmail.com>
 <xmqqlekjt7lx.fsf@gitster.g>
In-Reply-To: <xmqqlekjt7lx.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 1 Mar 2023 17:31:33 +0800
Message-ID: <CAOLTT8S3SFbJccDjkUGpjxehbrOiCswamjzy0WQhEb285BBMbQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] receive-pack: fix funny ref error messsage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:07=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When the user deletes the remote one level branch through
> > "git push origin -d refs/foo", remote will return an error:
> > "refusing to create funny ref 'refs/foo' remotely", here we
> > are not creating "refs/foo" instead wants to delete it, so a
> > better error description here would be: "refusing to update
> > funny ref 'refs/foo' remotely".
>
> OK, update() works on each ref affected, not just the ones that are
> updated, but also created and deleted.  The updated wording may
> probably be better.
>
>
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  builtin/receive-pack.c | 2 +-
> >  t/t5516-fetch-push.sh  | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > ...
> > +test_expect_success 'push with onelevel ref' '
> > +     mk_test testrepo heads/main &&
> > +     test_must_fail git push testrepo HEAD:refs/onelevel
> > +'
> > +
>
> I am not sure what relevance this new test has to the proposed
> update to the message, though.
>

Ah, I should have incorporated this part of the test into another
patch test.

> Thanks.

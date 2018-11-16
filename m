Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CD11F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeKQFYe (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:24:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50179 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFYe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:24:34 -0500
Received: by mail-it1-f195.google.com with SMTP id k206-v6so36368688ite.0
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPMuQ/xhEmms+5L6+9MCw8+gPXoGDOUNpCANN8erLAg=;
        b=Y/DjFowgczJ4iI1qUGEBP2QV0IjlU123v96IWZuaKJH6P5lmldFv8vUkfdsEjs9H2k
         QP276oDOqrXNfaoP8aUTOgmzHXOBPHO83xKLOcvi40ch+cP7+EG0GedRt36pNmfIK8IG
         IgOwVQFEI+qvAniWwcLkZx7CJAtjXRVDEUV6AUF8TgxeereV4iljy/rAxS59/ESnujgL
         cnF3Cy2kDtR5rfinZSmVDduI4GmNXdfn4a36vnAr2V26gOXO3jGzgYl5KAB6fq6EjVoU
         PIYtPZQ2fW0JV9t42ouK2M//qFGCpfDudp71CD9yU/8ZCY5clsxxcG8//8Jo+kwesTDD
         fQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPMuQ/xhEmms+5L6+9MCw8+gPXoGDOUNpCANN8erLAg=;
        b=dmur0U0H6spYftoMiS3lz+UBKwvRb3y6QTHzobN1QYsgQMUrOMJPParJbeQB0R4mE8
         EvkE4R6lXQA+vbYOp63AYoNSsAQaAyRI1z9lzgkgnfPdImb2hqdXsNX/aRchE17xsHic
         dJh+8fHNRn1JvktZFH3q8GmWQ0IGYz1DatM6fvJErPyT39Q9Ektletw35MMlImKeZmU9
         tq7bfNFgeuA7NuF6ExsgaZ6oNzN8TlvykU8+ZOaumS3F2SxBdsJi7FR29/iRWGtc7t8W
         5DKp/PxLesbztjHHcdYsjmjZCmVcQiS3uGJ5UkChTuKoqXe+7fMSQnPRHnmLwnaVahkY
         Enyw==
X-Gm-Message-State: AGRZ1gK1P8L96ys27hcB94U5cTUw22oGkF5bTBsumjFz8rZf2hyvGxWY
        i7+6X6+akCiWOIeEc6JzCZwfdCbDRul0WyEkfNU=
X-Google-Smtp-Source: AJdET5eD3l/uaM/gvZ8QPEFvlrKgFi3idX0sVrIiW/aDkyhhJ4a+nuKGEeu1HiAHVpqbv2lnIrUUVq0YbltdCN388gI=
X-Received: by 2002:a02:3b08:: with SMTP id c8-v6mr10517791jaa.93.1542395455545;
 Fri, 16 Nov 2018 11:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <CACsJy8Cdk8YQWJM1HAFYWB6qJpepNQoj86yrTqF9Rg3oN0TeUA@mail.gmail.com>
In-Reply-To: <CACsJy8Cdk8YQWJM1HAFYWB6qJpepNQoj86yrTqF9Rg3oN0TeUA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Nov 2018 20:10:44 +0100
Message-ID: <CAP8UFD2Y4dC4GfjgPDtR3gyrG_3hOvn-bRHMDNVSutaCF49i8g@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 7:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 6:31 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> > diff --git a/read-cache.c b/read-cache.c
> > index 8c924506dd..ea80600bff 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -3165,7 +3165,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
> >                 struct tempfile *temp;
> >                 int saved_errno;
> >
> > -               temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> > +               /* Same permissions as the main .git/index file */
>
> If the permission is already correct from the beginning (of this temp
> file), should df801f3f9f be reverted since we don't need to adjust
> permission anymore?

df801f3f9f (read-cache: use shared perms when writing shared index,
2017-06-25) was fixing the bug that permissions of the shared index
file did not take into account the shared permissions (which are about
core.sharedRepository; "shared" has a different meaning in "shared
index file" and in "shared permissions").

This fix only changes permissions before the shared permissions are
taken into account (so before adjust_shared_perm() is called).

> Or does $GIT_DIR/index go through the same adjust_shared_perm() anyway
> in the end, which means df801f3f9f must stay?

Yeah, $GIT_DIR/index goes through adjust_shared_perm() too because
create_tempfile() calls adjust_shared_perm(). So indeed df801f3f9f
must stay.

> If so, perhaps clarify
> that in the commit message.

There is already the following about df801f3f9f:

---
A bug related to this was spotted, fixed and tested for in df801f3f9f
("read-cache: use shared perms when writing shared index", 2017-06-25)
and 3ee83f48e5 ("t1700: make sure split-index respects
core.sharedrepository", 2017-06-25).

However, as noted in those commits we'd still create the file as 0600,
and would just re-chmod it depending on the setting of
core.sharedRepository.
---

So I would think that df801f3f9f should perhaps have explained that
create_tempfile() calls adjust_shared_perm(), but I don't think that
it is very relevant in this commit message. We are already talking
about df801f3f9f which should be enough to explain the issue
df801f3f9f fixed, and I think we should not need to explain in more
details why df801f3f9f did a good job. It's not as if we are reverting
it. We are just complementing it with another fix related to what
happens before adjust_shared_perm() is called.

I think rewording the comment a bit might help though, for example maybe:

/* Same initial permissions as the main .git/index file */

instead of:

/* Same permissions as the main .git/index file */

Thanks,
Christian.

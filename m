Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C308D1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeFITsW (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 15:48:22 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46492 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbeFITsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 15:48:22 -0400
Received: by mail-ua0-f193.google.com with SMTP id e8-v6so11060775uam.13
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=094iEeensvGPRUOd/BPuGYBnzqDnClu6y0fsdD8n5SI=;
        b=tObp8TkVnujjfTOTDa+f+1ET22Ihdz3guvt6iZfOVvA7sBcW94T2l7xioQH5Hwih6y
         Z90tvgc33OS7AL/A771F+2pMRwxAkqrdaVYQ1oTJjzaFlNhxstICxgVOYHKq8pWHUqj5
         6Yc6AIG3wzU3JlNVAZ2gNGKdMVLW4baCXVQ2wnpx5HLuZ5pBJUCbOBYPBJ/90z45p+Vv
         3pP+smpE2oySSpuurVF8rlFBTqMNn/HByGkSMgNluI4IFROc2PaAPbBKr0F/Rx9+35hS
         64KIdW4VUKektZ9O+q2XWGaG0ZM4mC1fAkKFbK+u2JeLiCqclLlfWX3WH73EEcXEOutg
         EAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=094iEeensvGPRUOd/BPuGYBnzqDnClu6y0fsdD8n5SI=;
        b=M0yuiuoHLvhWaQjGNRGuBIWQMnQyIAzvmAaWSnUpbLQRsxJbR3BCIlYtGteqT68K+/
         kPhtM/Fsu9fNafsoUyMzgcGG7YRVlKOYtcOIpsCNkGKI/aLnMynZC9Tj6AVqnRPGBS+0
         iJqAYjpEdXS6SQAsmpXjT3PhOqpienPbEk9XFPOdJhk6BatTx4Enlc7JQb8zKeusxLgZ
         WWe6XEbDpyuVTnxBvBVdwrz2XEemQPmgZUJTh8R7YU7eve0GQmAv9HifEgrAOodWKrXZ
         sSWdQknV1CHLrQm3d19nBmT4qKEhrb1wphUjqfj8cmOAb5m/lC7kvJXXYZ8waeRTuuJ5
         6qSw==
X-Gm-Message-State: APt69E3FTzBxa2zlVAvKCl+6WryZE7J2c5D7l8E7aGEpCXzhgSBcK2rJ
        6lsgZFIDgWl+3QroDrg5dgBZqx3IgVdOaHq8qzw=
X-Google-Smtp-Source: ADUXVKLjZlOWYeI7w45oYH1Kobjnbh4crsCPH/PQ7/Oa4AfHCLnK4A+VxjApmbJttH6NG8mPIlabp2OQIvLAgqKy4O0=
X-Received: by 2002:ab0:5e83:: with SMTP id y3-v6mr7607700uag.112.1528573701128;
 Sat, 09 Jun 2018 12:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 12:48:20 -0700 (PDT)
In-Reply-To: <CACsJy8DoU_qkghnNWKPy9+z=Lktg6jSbBFk6xEUFwAUos4Gu5A@mail.gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com> <20180606170243.4169-1-pclouds@gmail.com>
 <20180606170243.4169-12-pclouds@gmail.com> <CABPp-BGn8mz5tPrVk6fX3JKcaSuz4_XQSsSmvEMT_H5i4mF2Lg@mail.gmail.com>
 <CACsJy8DoU_qkghnNWKPy9+z=Lktg6jSbBFk6xEUFwAUos4Gu5A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 12:48:20 -0700
Message-ID: <CABPp-BGhS1_4dh=sMb56qaunQXkX=hu4foPV49Np-P8eZeCR5w@mail.gmail.com>
Subject: Re: [PATCH v4 17/23] read-cache.c: remove an implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 11:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 9, 2018 at 8:10 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Wed, Jun 6, 2018 at 10:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>> > diff --git a/merge-recursive.c b/merge-recursive.c
>> > index b404ebac7c..4f054d6dbb 100644
>> > --- a/merge-recursive.c
>> > +++ b/merge-recursive.c
>> > @@ -315,7 +315,7 @@ static int add_cacheinfo(struct merge_options *o,
>> >         struct cache_entry *ce;
>> >         int ret;
>> >
>> > -       ce =3D make_cache_entry(mode, oid ? oid->hash : null_sha1, pat=
h, stage, 0);
>> > +       ce =3D make_index_entry(&the_index, mode, oid ? oid->hash : nu=
ll_sha1, path, stage, 0);
>> >         if (!ce)
>> >                 return err(o, _("add_cacheinfo failed for path '%s'; m=
erge aborting."), path);
>>
>> There's also a refresh_cache_entry() call about ten lines after this;
>> since you converted all other make_cache_entry() and
>> refresh_cache_entry() calls in this patch, I'm curious if that one was
>> left out for a reason or was just an oversight.
>
> Ah I didn't mean to convert or kill refresh_cache_entry(), not outside
> read-cache.c. I rely on NO_THE_INDEX_COMPATIBILITY_MACROS to catch
> *cache* functions and if we set it in this file, we're going to have a
> lot more work to do and plenty of the_index will show up.
>
>> There are also a lot of add_cache_entry() calls in this function.  I'm
>> guessing we should either convert all of those too, or just change
>> back this particular make_index_entry to make_cache_entry() as it was;
>> it seems weird to have a mix of explicit the_index and implicit
>> the_index usages in the same function.
>
> Yes some files still have the mix of the_index and *cache*(). This one
> and apply.c come to mind. There's more work to do to kill all
> the_index outside builtin/

Yeah, there's also low-level common files like sha1-file.c or
ll-merge.c which now have &the_index in them (or more references to
it).  Clearly those need to be propagated up, but as you say, there's
more work to do.  Your patch series just moves things in the right
direction.

>> If we convert them all,
>> perhaps we should consider having merge_options store the index we're
>> working on?  If you want to punt this until later or leave it for me
>> while I make all my ongoing merge-recursive changes, that's fine.
>> Just thought I'd point it out.
>
> Right you're updating merge-recursive.c, I'd love it if you could
> define NO_THE_INDEX_COMPATIBILITY_MACROS here. Yes merge_options
> sounds like a good place to tell merge-recursive where to get a struct
> index_state.

Sure, I can tackle that.

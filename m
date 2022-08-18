Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76BC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 06:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiHRGgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 02:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiHRGgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 02:36:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E582D38
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:36:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a4so478417qto.10
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kd+xmmFdyOEUq8JEiGW6qMTBHB4umdIl6aOR5avIVqo=;
        b=gfvb2nMtkD+zLx0H3CC65PoE95o0d67QaGvtokM0xN9++lh/I2ZtiScnn/kLTkOwre
         pnb5fNzLlDRHXGaIuDh1aj2PgTteCtposi2c0lfMcK1GIceuPgfQaXoThAkXRMUbu5TX
         ASUuhpp5nJddqljZ8YRNo6VwcpsD0T05t+bbnxD2aJrVQokIEq3vzpEIzLI4iDXvHt5+
         8FP1Hzn1DWGXOehkCiq4Av5Z45lEDkcr+779KpYAwR1yqkvJsLlHcFU13WEPeS5kMwLe
         Ko8nP87+pJGBtts/L+TuvA2gakZRS1+6sbEjLF2i7mgqVmHraHdvAJS8ZByMns5hzLee
         gWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kd+xmmFdyOEUq8JEiGW6qMTBHB4umdIl6aOR5avIVqo=;
        b=voDw7o59eVRxiIsA/O+JufID6yvLzFZQALKM7yXpc0bz60HcBorDRvmzJPkqWmJXjs
         xh5ezSIVnqlwEnnqAVLhqxtRkgoxecJ64ndIsE1IPExWASZsL8g0bUadNmV//szezd/N
         7nDARh5n979deh+zzqdtwaG7ZwXWq4f9H6bkykW2gtwyrZSliSOLCdNR5FqtHWctdnw9
         ZULZ/3tfOyQ4vMpck5cJd49zgOh4CLt4t/zpJpm0p9mLgg0eJ4QYnlFGwK4DAotkc9w9
         bJb8mPfS/+ialjm9nlab+UlnUgnz7ejSem/asfNWy4hlDIdnVBcNtwfPvv9Gk1SElcl9
         M05Q==
X-Gm-Message-State: ACgBeo1dmhndykxlv7lYW7JPu8vPvU6H0ePAaxXzgdLBkOKHZNoA4Fk8
        Vn6Q4mbch8BVgDlzXuWxljgb/vK4Mq5/iXxaSow=
X-Google-Smtp-Source: AA6agR5SlErYcia7QMEeRGj/98dIMj8sga0yQT5PPpCVmTpY903HzlceGcf07EHtgowz59/CRoJChNCz5TbytvpW41Y=
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id
 n6-20020a05622a040600b0034307ae4fe9mr1403794qtx.541.1660804606211; Wed, 17
 Aug 2022 23:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
 <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com> <340c0f46f74acd641945fceba5ab5feac011ae60.1660718028.git.gitgitgadget@gmail.com>
 <xmqqedxetuhg.fsf@gitster.g>
In-Reply-To: <xmqqedxetuhg.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Aug 2022 23:36:35 -0700
Message-ID: <CABPp-BEwvnMxXze64mxMJjp32N=RYet_7nkG2is=qWqy_=zwig@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge-ort: add comment to avoid surprise with new
 sub_flag variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 4057523a40 ("submodule merge: update conflict error message",
> > 2022-08-04) added a sub_flag variable that is used to store a value from
> > enum conflict_and_info_types, but initializes it with an invalid value
> > of -1.  The code may never set it to a valid value, and use the invalid
> > one.  This can be surprising when reading over the code at first, but it
> > was intentional.  Add a comment making it clear that it is okay to be
> > using an invalid value, due to how it is used later.
>
> The current code uses -1 as the "suggest the default course of
> action", so -1 is very much a "valid value" from the viewpoint of
> the code that suggests how to resolve.  It indeed is an invalid
> value from the viewpoint of those who maintain conflict_and_info_types
> enum.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 67159fc6ef9..0a935a8135f 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -1886,7 +1886,7 @@ cleanup:
> >               const char *abbrev;
> >
> >               util = xmalloc(sizeof(*util));
> > -             util->flag = sub_flag;
> > +             util->flag = sub_flag; /* May still be -1 */
> >               util->abbrev = NULL;
> >               if (!sub_not_initialized) {
> >                       abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
>
> This new comment may be a slight improvement, but a valid value of
> sub_flag is used only to signal the situation where the code does
> not know what to suggest, which feels backwards for longer-term code
> evolution.  Presumably, we would use the util->flag field to store
> which of the known cases we know what to suggest as we know better.
>
> I wonder if we should initialize the variable to the most generic
> CONFLICT_SUBMODULE_FAILED_TO_MERGE instead of -1.  The value would
> mean "use the default suggestion", and the two known unworkable
> values (not-initialized and history-not-available) are currently
> handled according to what these two values mean.  We may later add
> more specialization based on other CONFLICT_SUBMODULE_* values.

I like that; I'll make the switch.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9EDC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhLHSjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhLHSjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:39:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C4C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:36:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so11623777edd.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haLjPotMzYBE49m6SrYn7XRUbsI76owoX/MsYxILIDk=;
        b=kUkQbSmwrVgxQtrSb0l2B7URiN9xAhW79/Y5L66PV1BgYfZUO+VsYve+8rFLcFZOgK
         Bj18meh5JuHe2EHXZmTK974Q3TEuEhaf60E+MbXGr7pyLJ9h99AzovDVGXHFmmqJ7YkA
         WcTarsJBrVhEohhWql35CAkO0WkTAU8WHY3ZbLvHfIS1bQ45ZDZHSz6pwoNK3VVuFGii
         7kPLgoOlRUFl125fVe9ESoYkZgW7I2aQc12aJEejf0AfiX/+0/inJ30MoDAgV7OSfQ3g
         VWPh6FtM3/kTJrbbBJ9fGoRWnXMKrrnDnAh9CIV+faoaren14fNJ1jYjg2gWg0ZgFvnM
         3SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haLjPotMzYBE49m6SrYn7XRUbsI76owoX/MsYxILIDk=;
        b=5qXu0kk/KsYMIvi1ZWZM8Ywtcg9/EobVHI+nGwtWwhqn4Nv0mgjjKD3gNLj2qav+uv
         GJPxGpFIxxqKWI12mABzZS1T9yrCRfh4eqeu422GIGDa5WpYAvWAnrlXorRSBnLo5uGG
         XRXTpIJk4gVD7BVcQji0neriMhhYyB2jzOc8PXsEl2wb/SHtHMpKHG4iSIXIhex7YSOG
         4UetAqQrqZ2CXo6UDIrReJZ8fLkri0euePxfkMOhx4lVn4NvRv1FVDkhxC5sfIC/+k74
         mBGoHwfsyl6cTOcX+7S+ukSNA7UinHlKphgPoWkC7p/EbTxS9tq570O7T6kLA4O6YJXV
         7iqw==
X-Gm-Message-State: AOAM5306CxCuCEuAdJ91BUizdTWbYQ3wbPr4tv6ErAGtLBUyjSDTetbf
        z7T80jRmZ0plsJZFy9xjQsfNnWRWzHHMv+bXg3U=
X-Google-Smtp-Source: ABdhPJzVCOlDrRRt0GUdZ/G+vaDdBb8fO1OQEb14ep+URsmNCg9UiTY4OhzYp9hkpRku2brsrjMT1wOsYtNqe33ibds=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr9398391ejc.443.1638988581228;
 Wed, 08 Dec 2021 10:36:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com> <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com> <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
In-Reply-To: <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 10:36:09 -0800
Message-ID: <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 10:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/8/2021 12:04 PM, Elijah Newren wrote:
> > On Wed, Dec 8, 2021 at 7:14 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> >> Taking your idea and applying it to 'ls-files' (without --stage to
> >> avoid OIDs which would change depending on the hash algorithm), the
> >> start of the test looks like this:
> >>
> >> test_expect_success 'ls-files' '
> >>         init_repos &&
> >>
> >>         # Behavior agrees by default. Sparse index is expanded.
> >>         test_all_match git ls-files &&
> >>
> >>         # With --sparse, the sparse index data changes behavior.
> >>         git -C sparse-index ls-files --stage >out &&
> >>         git -C sparse-index ls-files --stage --sparse >sparse &&
> >>
> >>         cat >expect <<-\EOF &&
> >>          e
> >>          folder1-
> >>          folder1.x
> >>         -folder1/0/0/0
> >>         -folder1/0/1
> >>         -folder1/a
> >>         +folder1/
> >>          folder10
> >>         -folder2/0/0/0
> >>         -folder2/0/1
> >>         -folder2/a
> >>         +folder2/
> >>          g
> >>         -x/a
> >>         +x/
> >>          z
> >>         EOF
> >>
> >>         diff -u out sparse | tail -n 16 >actual &&
> >>         test_cmp expect actual
> >> '
> >
> > This actually looks quite nice, though the magic '16' is kind of
> > annoying.  Could we get rid of that -- perhaps using something to rip
> > out the diff header, or using comm instead?
>
> What I really want is "remove the first two lines of this file"

Is `tail -n +3` portable?  Looks like we have five uses of tail -n +N
in the testsuite, so it should be okay to use.

> but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
> magic number?

That works too.

> > Also, perhaps 'dense' rather than 'out'?
>
> Sounds good.
>
> Thanks,
> -Stolee

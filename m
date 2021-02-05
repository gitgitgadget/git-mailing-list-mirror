Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9B7C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAD664E05
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhBER07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 12:26:59 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:46327 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhBERPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 12:15:19 -0500
Received: by mail-ej1-f47.google.com with SMTP id w2so13450919ejk.13
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lFTtdk9FyVpAkp6mcPIM8zfPA0T+1uBFKdEHJTb5zw=;
        b=UAXYBJbxudeLMettpjf4bYwMH1tox4W5KbcTPKWEceqfkdpR3VnNuGCBe72NDG+Onm
         8Gw81gRy1//cl8Max31lP2fllYY7q8PIpF/usthWv0FT6CiPJmdtI5mt3jXy5smXLGQ9
         P30ti5uoYYrMoVsTnhZmeUx21bzFk9mpwZILP2cq93FYe90+X98oCa/9XHVztTFxoE/y
         EMLPzgk0YMNEWQHlK1XYSiuMHeRHG8MpwO09/qFgrPXGcGlXEMgc0dXqNN466Xyc7nCf
         rjA3N/9bdGgTWgmycIXlv9sQyYs7e7fYGBg4raWx7q9uD/DO5iSYKJ3GrFqBOPhHHugn
         3zUQ==
X-Gm-Message-State: AOAM530JtNta3SRqfIx2w7pudOYGQCmtIZwzAUrUB/Viqt87hMPfxJvg
        KuhhPzxuHE9ttBUWUguW6SErip8UHkzH+yQbJvo=
X-Google-Smtp-Source: ABdhPJw7FMyVtUOrk8bBjpWDLQycKW5WE83rQHyMz+2lRYVFS5Zj+6NSe2fUX2z1o3CezNdcQL1LsG9JF6NIze5XrkI=
X-Received: by 2002:a17:907:98c3:: with SMTP id kd3mr5369927ejc.482.1612551420268;
 Fri, 05 Feb 2021 10:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
 <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
 <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com> <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com>
In-Reply-To: <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 13:56:48 -0500
Message-ID: <CAPig+cR44eisWjbcsSiTyHqVKeqPKXMnc=-9BEjK5MFxPUBFkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 5, 2021 at 1:25 PM Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Feb 5, 2021 at 10:42 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > On Fri, 5 Feb 2021 at 13:00, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > These changes are still worthwhile and can easily be done
> > > incrementally atop what is already in next, I would think.
> >
> > I agree, these fixes are required. So, I am not sure but now to do these
> > fixup shall I send another patch cleaning this patch series(v4) and rebase the
> > patch on the 'next' branch ? Is it the right way ?
>
> Yeah, I think you can send each of the above 3 changes in a different
> patch on top of the 'next' branch. That would create a new 3 patch
> long series, which you should give a new name and not consider v5 of
> the previous patch series.

Yes, whatever issues from my reviews seem worth fixing atop the
existing v4 can be included in this new patch series. (I think there
may have been a few things beyond the three listed in the v5 cover
letter, but I didn't bother doing a full audit of my review emails, so
I could be wrong.) As Christian said, just make it a new series,
though be sure to build it atop your v4 rather than building it atop
"next". (The problem with building atop "next" is that your series
then gets held hostage by _every_ series already in "next", which
makes it nearly impossible for your series to graduate to "master"
since it can't graduate until every other existing series in "next"
graduates to "master".) The one other important thing is to mention in
the cover letter that your new series is built atop "cm/rebase-i",
which lets Junio know where to place the new series when he picks it
up (and also lets reviewers know where to apply it if they want to
test it themselves).

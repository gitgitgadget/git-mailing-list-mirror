Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C93C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 20:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiDHUgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDHUgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C31FA72
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 13:34:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a11so11529401qtb.12
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ft6wh0N9L6KGWI6do47zZrLzNLLJFnidCCl4C6C9ER0=;
        b=cz44fveCqYxcqQ3sjxJIFu9FTvCvX8Jrn0bbXB0zyu4PnCqjzZmanBDlxQkfMeaXAg
         OWgiTSZXTRWM3kh8F0clSlcXNcd5dd5shIgrL1Xg1jMJngZM1hMMw//sh/u84RFxRENU
         A/VcanCmE5hjzm/WIH0UhuyTOocvRAVcaoeqybMo6gb5zi2LG1GyQya5HveXBWmn3k7H
         L3dBl+qa6R/0wrSO9+xsOfbiFuOtb8BiX06okHniqfjdhEN6307GO5FZsmSCTEeBccpi
         3PZ0MV9sXmXrfsykZOTESjIVaiicn+Sk3NwvKlj+gshcrTRCPv1xh3C+/0bWzTgSm1mw
         WEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ft6wh0N9L6KGWI6do47zZrLzNLLJFnidCCl4C6C9ER0=;
        b=3heWoaI/Wjsd4fsAVnbEbVl+FkyhJQg8gXvoTeXjvFG4DdTxS2cW8Sen+QwBbwBpju
         BeSPseyYH4dBmTXuAbkAqQIsU23V9zKpWahgXXolyYihrmWH3TVTmCilEYZit05Gys8f
         5vwpNz9k643WW/enDKrfcXgQZ5k1yScPlJ11WQAFmSZG/ME18UKp7GJudQloQy2wPEXW
         m+RJbxidJVZ9c9YSHpoeJCVufqUGWS4KZWCh4MHJ8LC06oByqqlTmAeA4WfaI+bglSwq
         kSVRzpiWOhZUyCKQ4eL8HAJetD9SL59OcFIe7qrV816rNZukubDNmpPZhNIFik2q0AQn
         MICw==
X-Gm-Message-State: AOAM530fLpVkGAPO8q+G67oCSrqZwYnM+9+1xVwxOHrHaf5fJobcW0pk
        BB/nCx/cqWKONfbcVyUVG7M9Zg==
X-Google-Smtp-Source: ABdhPJz4l7knYlHn8+DyAGUw863ZIASgYJlFuzbP7wlhX75ASGRul59LDBx/sWTacJM7S/uEojYKRg==
X-Received: by 2002:a05:622a:82:b0:2e1:d61d:81ec with SMTP id o2-20020a05622a008200b002e1d61d81ecmr17530567qtw.674.1649450052938;
        Fri, 08 Apr 2022 13:34:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020a370503000000b0067b03f03589sm14195960qkf.53.2022.04.08.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:34:12 -0700 (PDT)
Date:   Fri, 8 Apr 2022 16:34:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <YlCcQw6FuWufLe74@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
 <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <Yk21JvirO6FyQ3Va@nand.local>
 <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
 <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 07, 2022 at 09:16:44AM +0200, Christian Couder wrote:
> > > That said, if we do end up splitting the bitmaps GSoC project in two,
> > > when would we need to do it by?
> >
> > To the best of my knowledge, Google does not require the proposal ideas to
> > be laid out by organization before the proposal deadline (which is April 19).
> > This gives the flexibility for mentors and GSoC contributors to collaborate
> > and come up with a project ideas that are not present in the initial ideas
> > list and write proposals for them.
>
> I agree with this, but please keep in mind that in
> https://git.github.io/General-Application-Information/ we ask
> applicants to "Discuss their project by posting drafts of their
> application on the mailing-list long before the deadline." So
> splitting the bitmap project should be done soon, so that applicants
> have time to prepare and discuss their proposals based on the splitted
> project.

I've thought a little bit more about this, and I think we should leave
the project in one piece (i.e., avoid splitting it up).

My thinking is roughly that of the sub-projects listed:

  - investigate replacing EWAH with Roaring+Run
  - add a "table of contents" to the .bitmap file
  - append-only bitmap generation
  - amorphous / larger related projects

...the first two both require serious (re-)consideration of the .bitmap
format, and I don't think it's possible to split that up among multiple
GSoC projects.

The "append-only" project is interesting, but probably not large enough
for a GSoC student to occupy their time with completely. I think the
last bullet point has the opposite problem, which is that there is _too_
much to do there, and that it isn't well defined enough.

So we _could_ split the two projects up, having one work on any
preliminary format changes, and the other stay busy with a smaller
bitmap project, but I have significant concerns about that setup being
successful.

Instead, let's keep the project as-is, and have the accepted student
focus on one of the first two bullet points, taking into account that
we'll first want to spend some time thinking about whether or not the
current .bitmap format is appropriate given the proposed changes.

Thanks,
Taylor

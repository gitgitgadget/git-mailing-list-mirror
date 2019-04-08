Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBE820248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDHG6n (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:58:43 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37323 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHG6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:58:43 -0400
Received: by mail-ed1-f52.google.com with SMTP id l20so3121685edv.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRkpiIS10M5bdrhaFwdQP3QD7ZsHFMIiAe5JACLYWuc=;
        b=G4NaK0drS1FT7HaXvndkthLCZgS0ubNoZmvDPW2bXwYUM+R7jBNapKRIfOMYmI6m4Z
         +KTMOyVFBix2K4TMmtG/zjteGfVMB3irnglWGXoNSBRraJuGK44euAW616n0YfJbDQBY
         UnurOUc8Ek/uDDyvhFdgRaTkyuv+PC9vnYgCNtA3DBHd+gChzU5DPnOH950FQ/d3K1Qm
         pM7i5h84s67ycYcUI1dp5xIoyiLlhuzdpT1GXyqHKdeaVDTPdHH56gdmw+u96ApWECfB
         xTN/uAJ4q3+7eozifZHR2M8WjWZelM6bAZAEarg+qKU6x8QCz0PfNpKI8EBxKkFii0V4
         4SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRkpiIS10M5bdrhaFwdQP3QD7ZsHFMIiAe5JACLYWuc=;
        b=avcck0qpix25++gY+mj5Mc8m63oUIM6NuuzxU6olvcRi+A/BcYhALGf9FijxSdiUIx
         F5g6JEsurm528HIpgyX6IViQFH996iPqXbgM47ySFH5JgV5T7aSs2+JCAZ9U8V3/RkY0
         9f3ERmiKUEAxd254ZGvyCvn++Chj15kYnIIMgwyQfqlkvNyfhcW+mYpcGBgMnD5LdhLB
         ktDBb3AoUS8O4YLqWZFPjoQborQNwtF3BPGSFqyX/vjPd/oE2DW3hJxCXILv+Nlglejq
         CMrPOtBpxVjgPLUZXtOhG4MsV6kqvIJRbGiP+DePCUCGleNuaaGHb/j5t1RH/BYtBOyM
         D8Lg==
X-Gm-Message-State: APjAAAWpvmmWoyF0SROKUoyfEywDsrMUnYiXBMDyiMnKBEAluQuowuHa
        +7WfWCL2VjknnI+yT/B7ixokaRBTAZQtN2LqRkg=
X-Google-Smtp-Source: APXvYqxFzK9+NashTeX/FMf8w0lQVCbZVDjz6kCANkAnAXoflVkcpzKGOJp0KlZvYB5Etz1r6yYchSXC5oTzyc/PEr8=
X-Received: by 2002:aa7:d819:: with SMTP id v25mr15596839edq.70.1554706721663;
 Sun, 07 Apr 2019 23:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com> <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com>
In-Reply-To: <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 08:58:30 +0200
Message-ID: <CAP8UFD3qRTUv0H3Bw=6MJ0qhF15sj6O0LSV_WCymqoWxVJ6YBQ@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 5:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 8:23 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > > Git has a very optimized mechanism to compactly store
> > > > objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> > > > created by[3]:
> > > >
> > > > 1. listing objects;
> > > > 2. sorting the list with some good heuristics;
> > > > 3. traversing the list with a sliding window to find similar objects in
> > > > the window, in order to do delta decomposing;
> > > > 4. compress the objects with zlib and write them to the packfile.
> > > >
> > > > What we are calling pack access code in this document, is the set of
> > > > functions responsible for retrieving the objects stored at the
> > > > packfiles. This process consists, roughly speaking, in three parts:
> > > >
> > > > 1. Locate and read the blob from packfile, using the index file;
> > > > 2. If the blob is a delta, locate and read the base object to apply the
> > > > delta on top of it;
> > > > 3. Once the full content is read, decompress it (using zlib inflate).
> > > >
> > > > Note: There is a delta cache for the second step so that if another
> > > > delta depends on the same base object, it is already in memory. This
> > > > cache is global; also, the sliding windows, are global per packfile.
> > >
> > > Yeah, but the sliding windows are used only when creating pack files,
> > > not when reading them, right?
> >
> > These windows are actually for reading. We used to just mmap the whole
> > pack file in the early days but that was impossible for 4+ GB packs on
> > 32-bit platforms, which was one of the reasons, I think, that sliding
> > windows were added, to map just the parts we want to read.
>
> To clarify (I think I see why you mentioned pack creation now), there
> are actually two window concepts. core.packedGitWindowSize is about
> reading pack files. pack.window is for generating pack files. The
> second window should already be thread-safe since we do all the
> heuristics to find best base object candidates in threads.

Yeah, it is not very clear in the proposal which windows it is talking
about as I think a window is first mentioned when describing the steps
to create a packfile in:

"3. traversing the list with a sliding window to find similar objects
in the window, in order to do delta decomposing;"

Also the proposal plans to "Protect packfile.c read-and-write global
variables ..." which made me wonder if it was also about improving
thread safety when generating pack files.

Thanks for clarifying!

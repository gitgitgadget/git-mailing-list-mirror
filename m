Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B061720248
	for <e@80x24.org>; Mon,  8 Apr 2019 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHDcv (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 23:32:51 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33994 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDHDcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 23:32:50 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so16039359itc.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 20:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gubkYg5MYFDcTXpd6ZiudK6Xy6OeaIvH9NzIZC/wbAo=;
        b=iH2JynIr3BK5ar8I8d8P56db/aKdzrWKhqICkeXoYQHY8s9Z48buB+vcpzaRJJKI2R
         XEAMf92Q2xE6uoAokFDmBSBkAAyjEUDeBbpVRNEbzWIYWpBbLSkPnZM+p2NwY6QuwGwa
         cfTmrmoNH6iSOyjU3Kc/4nopBlghd5uTYxPFIBBsT6WItiDnl/uSHWoaLW89IQyFteLM
         3FQnADRklsn2agls0+L2BM2kFGjXdB6zbasmK9OiPpnQoH6Rr6bWnLm+lKY2Q5pO/7R7
         5wGlKmHKlfiOZN9yAohmn7UXMmu77Beg366upREcehv2QbVe1DQC+H56XoO9yrPHikCx
         YW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gubkYg5MYFDcTXpd6ZiudK6Xy6OeaIvH9NzIZC/wbAo=;
        b=djYWqz1Z5ZEEO+lHPIfnsNwE5v+KT0LUysvzwIYJyw2mdt41NdT45CDvZrHa4rS60C
         04GOANr4/Mr8xC1gge+C9GuQp9paLNhnBbnHldFIdXxbyg50DDDrzyT6KR8ZT2DBkCuv
         YPC6Dt/b4ogunNodbXJVtGoslaiGrmL4fBy8xDQoaQ8vjXwXyKLahxcJGNwCAkGNbSBO
         tj+R3DE2NuKYr88OCjdcXf+BHdjyvZG16rQhogZrdf8gPOjrBvHlLKQPBCPrRJ95cVXh
         9tt9bwflRnxEUZkYVWKIs80K9ojVtgeK7piFoUC51NMTJ0N5lJjYkvwGUKmYaWDWqOBL
         dvfQ==
X-Gm-Message-State: APjAAAUDL5/S8dfmleWppc4vCYdbm4lpAAStQc5BpCEFSO57UruKe1y/
        k9yKahXlBuvFLLzqSV3rNMzbwS7s0XnP/yUhy3mFGStk
X-Google-Smtp-Source: APXvYqyxGSQKSPDFFzgrSxxD7E/J3NDSxSclqZQvN2LRtPYP7PQQA+FuKIKdZ8bn1AYAOQ42Jq0UhZM1++QppdvBf+4=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr11002975ith.72.1554694369752;
 Sun, 07 Apr 2019 20:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com> <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
In-Reply-To: <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 10:32:22 +0700
Message-ID: <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Christian Couder <christian.couder@gmail.com>
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

On Mon, Apr 8, 2019 at 8:23 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > > Git has a very optimized mechanism to compactly store
> > > objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> > > created by[3]:
> > >
> > > 1. listing objects;
> > > 2. sorting the list with some good heuristics;
> > > 3. traversing the list with a sliding window to find similar objects in
> > > the window, in order to do delta decomposing;
> > > 4. compress the objects with zlib and write them to the packfile.
> > >
> > > What we are calling pack access code in this document, is the set of
> > > functions responsible for retrieving the objects stored at the
> > > packfiles. This process consists, roughly speaking, in three parts:
> > >
> > > 1. Locate and read the blob from packfile, using the index file;
> > > 2. If the blob is a delta, locate and read the base object to apply the
> > > delta on top of it;
> > > 3. Once the full content is read, decompress it (using zlib inflate).
> > >
> > > Note: There is a delta cache for the second step so that if another
> > > delta depends on the same base object, it is already in memory. This
> > > cache is global; also, the sliding windows, are global per packfile.
> >
> > Yeah, but the sliding windows are used only when creating pack files,
> > not when reading them, right?
>
> These windows are actually for reading. We used to just mmap the whole
> pack file in the early days but that was impossible for 4+ GB packs on
> 32-bit platforms, which was one of the reasons, I think, that sliding
> windows were added, to map just the parts we want to read.

To clarify (I think I see why you mentioned pack creation now), there
are actually two window concepts. core.packedGitWindowSize is about
reading pack files. pack.window is for generating pack files. The
second window should already be thread-safe since we do all the
heuristics to find best base object candidates in threads.
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E6520305
	for <e@80x24.org>; Mon,  8 Apr 2019 15:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDHP6P (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 11:58:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40432 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHP6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 11:58:14 -0400
Received: by mail-it1-f193.google.com with SMTP id k64so21815375itb.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZkHMKjVrEHvqwy4TTDXGtkcUZ3pUxtdFNhzNVKENxk=;
        b=pOJEJMkwoK1bUxjhV1eG6UimUToM8yyjb3hwAKbAv6zKA1vdikKksitwutR3wIqeN8
         //bwKC+HKEKsWFwVN9XqPs0SbTJPyQTRz0+fu7DoIkQPnFrnGO2Ml2qY0HCStp34/is9
         a3G3oMzB3lq8n4arVGUNmCARzDcFml+nVVQl1ZbE0Ib3jRSiNPQTHL/9l0XSPK2mX6kL
         EXBiLP2UWjqGzBTWQZISBo+whBAZBKYs+J4SE0i0viZPFtCP3F3FlbiWwd7HB47Bbmfk
         zx9ebD9S7lnwgUiPddIug3Odi9VBOwZUXWaPwc4wQgnlL9IG5M+h3wkaxrKwGnKOH3yz
         ycUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZkHMKjVrEHvqwy4TTDXGtkcUZ3pUxtdFNhzNVKENxk=;
        b=ugrsm8jHFvN27MRlIo+LT/+nSd3YHRKcHnuahuKoqXTNwHtzPaDDKdMQ2ap6Xm/GY4
         aa98nCg7BdTg3YHhmpRU5poE5g9vyRWlo0lbMDScvKtaUPB3NeBVRzPRAMgOuDgn9r/+
         3wclezuyfsACUgSbo5xSsjsTUxVOme0l6AJLX/EM7eWHF3s8bOo9yovVlmVXWvLAr+2o
         Ih0I7CfJbxUej4RXLOWvlFZQJKvQuhHLxhB2QESsk9MINM9YSpCIHtVnY1wyTSahnDut
         wLutevoYqBK+2Huk8Z7KCuAce7KKOWsXlmsGvoazbHV1RHy2sBfd7O7lhFhPD3jAztfu
         OXcg==
X-Gm-Message-State: APjAAAWJSh2QxPAlNJA/cKJlzxQeatwtaAp7SwmX6gepA2ksO/OE3p/J
        BcP5E33zKn0Qw7iEW9I0yazssKvnJOq/fkOZDQg44g==
X-Google-Smtp-Source: APXvYqwPLe4GmdUs2cXcEMYSA4yymOQCx7ne4fJnXYXsaNamC9PQ+Xd75FPek1oBWb1XEAxMpMfknTjqRYy6jjnd2Zo=
X-Received: by 2002:a24:7294:: with SMTP id x142mr21423502itc.7.1554739093784;
 Mon, 08 Apr 2019 08:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com> <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com>
In-Reply-To: <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Apr 2019 12:58:02 -0300
Message-ID: <CAHd-oW6Cmn4TsR9GfwD0H8niwh-cyaXU-V8GK70j6bLT94_VkQ@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
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

On Mon, Apr 8, 2019 at 12:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
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

I was indeed confusing this two concepts, thanks for clarifying it! I
took a quick look around the usage of core.packedGitWindowSize arround
the code (at packfile.c) and it seems to be already thread-safe (I may
be wrong thought).

> --
> Duy

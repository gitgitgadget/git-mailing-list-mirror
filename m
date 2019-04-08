Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C2820248
	for <e@80x24.org>; Mon,  8 Apr 2019 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDHQDX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 12:03:23 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:40522 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDHQDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 12:03:23 -0400
Received: by mail-it1-f179.google.com with SMTP id k64so21849224itb.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlD5oAhlVJeRCZ9x9WcMWM5UaqmmjDb1sY2kJ4iPAjw=;
        b=Fe0IoTLd+5JhFaaHcz625k0hDOBiffz2MwPZ2sNeV6VVcXVkNzgXKbFU3wT6yu9oqd
         LwqkHM6wyhns5OFVxfwMy+E44t168pLq0s+te5EjT2p8ECuQpz439wmuPj8IA5XP8xcY
         xosaBi6CUctZ/t8mjGdd/y/QkLlfdLIDMMCfk9M7svs2AdHzHBrdAIyf2wRYzuIc5LVB
         1bajaPhFpnCCqvo0bqn+uowlQhvbwu3cw6K79PSUK0YwFGmelXhq/lGYGZBVBPnJ14At
         aHi6KobnklPnoXp+mxSMufkStz3FmSbAnc+QXHf+7snd9NN/rXH4MZ649Ma005tb5m2a
         UCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlD5oAhlVJeRCZ9x9WcMWM5UaqmmjDb1sY2kJ4iPAjw=;
        b=M+NgNAp33ZutQ/uKxO+/SZcWoFOntsxzZ1NH3vcWhHWJXtbCI5RQZoDH34qLKYGyDh
         NbamV+pmm7/cPb6uE8jNKt4552eCcTrZxpCjvJtYYnAJTzjNhllN8BmEG0ERcm3pX3dM
         0bcK8vRDpF3xrMxRmwM16CB3l+hRznWn2ZCWk0uISYU63DT5WlO62G5KUe2m9mpaW3eV
         KoRjisQ8yaiOZn/I0FsoFr56VJgM1/QmeOGuUNDBnn/Hk91jmwKmp/4QYphKzOpgkXoz
         o8KIFwgqjmuK8G9xKsjC6xYADDfPYl0tbWsbf0J1/RmoGjq9AedqNkNSHEVygASBNRbs
         riFw==
X-Gm-Message-State: APjAAAU8+tyVrNWXhVLrDxmdFbDrReJPzfHgTkg6mmMVfu3jKZolPwSX
        48jJH96TFapmbnYbkyXFBOqGST6iwsXJA4nilbPgHA==
X-Google-Smtp-Source: APXvYqx5sK4wF9zj0eAUhazi89rl6TSHFQhz7b/89mz9Hf9I/fhT5eYOskkFgVfaaWw/rQb6ZvCiQ8f51f9dlUxfiS8=
X-Received: by 2002:a24:7608:: with SMTP id z8mr22894516itb.116.1554739402426;
 Mon, 08 Apr 2019 09:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
 <CACsJy8AWHfcx=aLChWB_pN9dsVEj0Kq31zHmVnN1iVjXxyZVLg@mail.gmail.com> <CAP8UFD3qRTUv0H3Bw=6MJ0qhF15sj6O0LSV_WCymqoWxVJ6YBQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3qRTUv0H3Bw=6MJ0qhF15sj6O0LSV_WCymqoWxVJ6YBQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Apr 2019 13:03:11 -0300
Message-ID: <CAHd-oW4EAiY_FuoyBrHs2B=6NBo2_6grcq+_JiSJuA_-xTQp6w@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 3:58 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 5:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Apr 8, 2019 at 8:23 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
> > > <christian.couder@gmail.com> wrote:
> > > > > Git has a very optimized mechanism to compactly store
> > > > > objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> > > > > created by[3]:
> > > > >
> > > > > 1. listing objects;
> > > > > 2. sorting the list with some good heuristics;
> > > > > 3. traversing the list with a sliding window to find similar objects in
> > > > > the window, in order to do delta decomposing;
> > > > > 4. compress the objects with zlib and write them to the packfile.
> > > > >
> > > > > What we are calling pack access code in this document, is the set of
> > > > > functions responsible for retrieving the objects stored at the
> > > > > packfiles. This process consists, roughly speaking, in three parts:
> > > > >
> > > > > 1. Locate and read the blob from packfile, using the index file;
> > > > > 2. If the blob is a delta, locate and read the base object to apply the
> > > > > delta on top of it;
> > > > > 3. Once the full content is read, decompress it (using zlib inflate).
> > > > >
> > > > > Note: There is a delta cache for the second step so that if another
> > > > > delta depends on the same base object, it is already in memory. This
> > > > > cache is global; also, the sliding windows, are global per packfile.
> > > >
> > > > Yeah, but the sliding windows are used only when creating pack files,
> > > > not when reading them, right?
> > >
> > > These windows are actually for reading. We used to just mmap the whole
> > > pack file in the early days but that was impossible for 4+ GB packs on
> > > 32-bit platforms, which was one of the reasons, I think, that sliding
> > > windows were added, to map just the parts we want to read.
> >
> > To clarify (I think I see why you mentioned pack creation now), there
> > are actually two window concepts. core.packedGitWindowSize is about
> > reading pack files. pack.window is for generating pack files. The
> > second window should already be thread-safe since we do all the
> > heuristics to find best base object candidates in threads.
>
> Yeah, it is not very clear in the proposal which windows it is talking
> about as I think a window is first mentioned when describing the steps
> to create a packfile in:
>
> "3. traversing the list with a sliding window to find similar objects
> in the window, in order to do delta decomposing;"
>
> Also the proposal plans to "Protect packfile.c read-and-write global
> variables ..." which made me wonder if it was also about improving
> thread safety when generating pack files.

Sorry, it is indeed unclear. The idea here was to say that variables
which are both read and updated in code that must be thread-safe
should be protected. I will refactor this, thanks.

Oh, also I'm targeting just packfile reading. The explanation on how
packfiles are created was written just as a contextualization. But
perhaps it leaded to some confusion on the proposal's objective.
Thanks for this feedback too.

> Thanks for clarifying!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A46620248
	for <e@80x24.org>; Mon,  8 Apr 2019 17:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDHREv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 13:04:51 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52842 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDHREv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 13:04:51 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so274276itf.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ//Lu8zjkVswpDUiuks8tRio7ApHWFS47pqtURqs2g=;
        b=iagZzS+s7PGGdbql38zvZGIVqMH0au2pmg7oZ/RWkM9mMJlFl+PPiQnmSdcT1hGYsg
         znkNTJQbHYPB10PsjgDGIRPIdfgLk6rwVBUc6aGPCZaIEdXLOawA7uZnuZ8wzFQoo9Nn
         qF19n/qVRG6Ko5A/XKKL3DJAW83CFAS7v0KcAjMAV2ypLV+ZLFVpnI6p2BoGGM3ca7mV
         YQHYmYXCptqA5205eYe2PGmJp3cP6sjyFUwYigITdjbaj8v7S8uEkT3QwZUmgy7xqF3i
         hQ9bAD2Yl8jA5PgeaoIGlS6M0+JV37bPn6lM7IL1AbkgbkisPm+6rHjSuojLlRpIPMwq
         sSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ//Lu8zjkVswpDUiuks8tRio7ApHWFS47pqtURqs2g=;
        b=IIu6TRGqT87xGCstENiUKU+oPjurprbFndF3YZQGMZsekUMqRQdouYc2eL0q618vev
         8dKs1wqViJgwdvG7IUOgATPWS1Tf7lFT2AtgL3RevmvfExUt4DfZGufBvj/RK6p9i/IW
         1nZbYIIgLIPpXCpXgkkOj5a85o67sFzYG04Mz5Uge50Rj/u/VZWwjkjjpxifxjk0cdBZ
         580dio65W2WXRVz+zV2AJkCsThwEUZr1g/zJWTjzk+J6BCOe4QC1diVGW+90FeGYVNd/
         8D1L+ZHvXx7o4WhbhvrOi/uhiscNJTw3lJUbAUM192GgiMe09EH3xqNu77HLBKL/sxQB
         gAGg==
X-Gm-Message-State: APjAAAXrxDdFT4ulbwlwLS42dBZZXPjF0gQueb/xcWDIejOatmjeYfTf
        4EbV63MxboJ0Fx8uX6hbg3gLAwT0VTSCoU/K8ctWQg==
X-Google-Smtp-Source: APXvYqygaGw4PVgKjoHp2/U9OpFUwtNJ6CNOeJbrECpPzv3Q5932Z62si5xwuW6YuBArypc80XC6xB5IyT1KEEZDeJ0=
X-Received: by 2002:a02:c955:: with SMTP id u21mr21655877jao.105.1554743090381;
 Mon, 08 Apr 2019 10:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com> <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org>
In-Reply-To: <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 8 Apr 2019 14:04:39 -0300
Message-ID: <CAHd-oW5PFmj4u2YB-1TcHWNxkokfCEsUq_zB=Rx2Vmdk5Z9eMw@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
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

On Mon, Apr 8, 2019 at 6:26 AM Philip Oakley <philipoakley@iee.org> wrote:
>
> On 08/04/2019 02:23, Duy Nguyen wrote:
> > On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >>> Git has a very optimized mechanism to compactly store
> >>> objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> >>> created by[3]:
> >>>
> >>> 1. listing objects;
> >>> 2. sorting the list with some good heuristics;
> >>> 3. traversing the list with a sliding window to find similar objects in
> >>> the window, in order to do delta decomposing;
> >>> 4. compress the objects with zlib and write them to the packfile.
> >>>
> >>> What we are calling pack access code in this document, is the set of
> >>> functions responsible for retrieving the objects stored at the
> >>> packfiles. This process consists, roughly speaking, in three parts:
> >>>
> >>> 1. Locate and read the blob from packfile, using the index file;
> >>> 2. If the blob is a delta, locate and read the base object to apply the
> >>> delta on top of it;
> >>> 3. Once the full content is read, decompress it (using zlib inflate).
> >>>
> >>> Note: There is a delta cache for the second step so that if another
> >>> delta depends on the same base object, it is already in memory. This
> >>> cache is global; also, the sliding windows, are global per packfile.
> >> Yeah, but the sliding windows are used only when creating pack files,
> >> not when reading them, right?
> > These windows are actually for reading. We used to just mmap the whole
> > pack file in the early days but that was impossible for 4+ GB packs on
> > 32-bit platforms, which was one of the reasons, I think, that sliding
> > windows were added, to map just the parts we want to read.
>
> Another "32-bit problem" should also be expressly considered during the
> GSoC work because of the MS Windows definition of uInt / long to be only
> 32 bits, leading to much of the Git code failing on the Git for Windows
> port and on the Git LFS (for Windows) for packs and files greater than
> 4Gb. https://github.com/git-for-windows/git/issues/1063

Thanks for pointing it out. I didn't get it, thought, if your
suggestion was to also propose tackling this issue in this GSoC
project. Was it that? I read the link but it seems to be a kind of
unrelated problem from what I'm planing to do with the pack access
code (which is tread-safety). I may have understood this wrongly,
though. Please, let me know if that's the case :)

> Mainly it is just substitution of size_t for long, but there can be
> unexpected coercions when mixed data types get coerced down to a local
> 32-bit long. This is made worse by it being implementation defined, so
> one needs to be explicit about some casts up to pointer/memsized types.
> >>> # Points to work on
> >>>
> >>> * Investigate pack access call chains and look for non-thread-safe
> >>> operations on then.
> >>> * Protect packfile.c read-and-write global variables, such as
> >>> pack_open_windows, pack_open_fds and etc., using mutexes.
> >> Do you want to work on making both packfile reading and packfile
> >> writing thread safe? Or just packfile reading?
> > Packfile writing is probably already or pretty close to thread-safe
> > (at least the main writing code path in git-pack-objects; the
> > streaming blobs to a pack, i'm not so sure).
> --
> Philip

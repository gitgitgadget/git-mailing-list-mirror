Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC0B1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 05:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeGZGpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 02:45:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39819 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeGZGpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 02:45:53 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so1070225ita.4
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6JBPmeCT55jkAjxYQHsESo2rGPtuouOE3NZ2wGC39Y=;
        b=vBWjVrBIDcSXqwylPyudYKZ4s1aCfyOS2BlyS5zKIWtsbVINwPQK6ki/PbDXSN91ju
         /9yJnR9J2C/m4nKDZHGunN47T1C3CsZBVJmwhVhPj0a4omMYAAzXcKVCfzYymjKilfvx
         3lXNeLHZGeVNnbEcsZ486ESuypJKmnfHZ9dtZLOtZMaFqP4Nc0weUAcLn8me4Ogn+IS4
         n55z6mhoKzL1DxU5bzW1ny6/es1nl6HOdK3kXK/b/hktJK74N0zlyK7l903ijQi82pZj
         KmjUxl+qatzdkJkhDVPyUDhQBtpn006ePN7UuU0eBRYPc6RS98gAViSSyt7ZliV/u+gB
         NBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6JBPmeCT55jkAjxYQHsESo2rGPtuouOE3NZ2wGC39Y=;
        b=WyvNd24vf9IjSf0+/mE14NvzB+kQG6U5oM1Zqfp40m9Ct7+SeDT8cRZV3EN25Yidds
         Xe6oJmvLRlIj4E9g2xcFIaTKSLC9DPDCch+Dmh/+WbR++CaAkSbPnc/HhPwf79CvUckw
         vxUP9qkOylq3mjWh1iRptoyvmzc9+0YR3czrL7VGi0uSWt8jpCbwJH4qZiMovzRx6F0s
         0wpa/hGM3jFRMPU368tH2cVuOutsTva35aSpKajX5F2DMhgVatG2c3S/atUUcQme9/Nw
         jpam+5/1aCOts4YJEYvdP2+nQgjE/qm87wTcyvDeaVpmniDmzB8w0sM/0NH7CYXje6t5
         fAmQ==
X-Gm-Message-State: AOUpUlGYHS0DZKYIFSxx4EhxJjNKzWNhuWTG9xFs1wK9Jt2MK48G3dWI
        2IVCZlKKUI06xJLNPTs1zLCHJRbMqDRTc4JuRtw=
X-Google-Smtp-Source: AAOMgpcbRIVfRHKi8E3KTDWVQIiensFGa18Hm47ZmMAz3MreiVFNmfV7CNSf7ytGE9QxtQFcual8tMotuw8Qe1st3uQ=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr792359itf.78.1532583047159;
 Wed, 25 Jul 2018 22:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com> <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com> <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
In-Reply-To: <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Jul 2018 07:30:20 +0200
Message-ID: <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 10:56 PM Ben Peart <peartben@gmail.com> wrote:
> I'm still very new to this part of the code so am trying to figure out
> what you're suggesting.  I've read your description a few times and what
> I'm getting out of it is that with some additional checks (ie verify
> it's a twoway_merge, df_conflict_entry, not CE_CONFLICTED) that we
> should be able to skip the whole tree similar to how Peff demonstrated
> below without having to invalidate the cache tree to reflect modified
> on-disk files.  Is that correct or am I missing something?

And I didn't give you an easy time because I was not very clear in my
suggestion, I think. So let's start again. But first let's start with
a potentially more generic optimization using cache-tree that I
noticed just now.

You now know traverse_trees() is used to walk N trees and the index at
the same time. Cache tree is also used to quickly check if a big chunk
of the index matches some tree object. So what if we try to avoid tree
objects if possible (which reduces I/O, object inflation and tree
parsing cost)? Let's say we're walking two trees X and Y, then we
notice through cache-tree that X is the same in the index. Then
instead of walking the actual X, you could just get the same entry
from the index and make it "X". This way you only need to walk Y and
the index (until the shared tree ends of course). If Y happens to
match cache-tree too, all the better!

Let's get back to two-way merge. I suggest you read the two-way merge
in git-read-tree.txt. That table could give you a pretty good idea
what's going on. twoway_merge() will be given a tuple of three entries
(I, H, M) of the same path name, for every path. I think what we need
is determine the condition where the outcome is known in advance, so
that we can just skip walking the index for one directory. One of the
checks we could do quickly is I==M or I==H (using cache-tree) and H==M
(using tree hash).

The first obvious cases that we can optimize are

clean (H==M)
       ------
     14 yes                 exists   exists   keep index
     15 no                  exists   exists   keep index

In other words if we know H==M, there's no much we need to do since
we're keeping the index the same. But you don't really know how many
entries are in this directory where H==M. You would need cache-tree
for that, so in reality it's I==H==M.

The "clean" column is what fsmonitor comes in, though I'm not sure if
it's actually needed. I haven't checked how '-u' flag works.

There's two other cases that we can also optimize, though I think it's
less likely to happen:

        clean I==H  I==M (H!=M)
       ------------------
     18 yes   no    yes     exists   exists   keep index
     19 no    no    yes     exists   exists   keep index

Some other cases where I==H can benefit from the generic tree walk
optimization above since we can skip parsing H.
-- 
Duy

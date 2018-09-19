Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AB11F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbeISVv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:51:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38442 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbeISVv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 17:51:27 -0400
Received: by mail-io1-f67.google.com with SMTP id y3-v6so4956711ioc.5
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrO1YU0VvcoIoU1+ShjB7fT1lJcbPIIleIm4Yg+XHqw=;
        b=KXUx73WXXzAy5+amuLTUZia+y4MNWg32BYZH0+gxrPEtigeGTxGe7JrXcgF3LfIsCm
         SL6VQuQeutPmOOfcxFOaCEYwy0Y9VLMRY8EbqnxbuCPGHVF4oLH5vxlBehKh/LLlt3Ac
         i6rQd3ajw1OpudC5/FSb1OlVtuPLZUjesMNaPw7Tqg9XIq48ymeKcuXQNPU8iESO+rWn
         h4bQNeMGvejVyi1eyDryUM/+03VKJTtuL54w/nxgz0KrTwgyxWVMWUKU98AlPbKJtnTx
         PoGnAU6CuVX3RVhc99LE7tri3UZMzROI1vtvcGn2GnpDGsBR3vKnfKvbZo3h1KuIES5A
         ouIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrO1YU0VvcoIoU1+ShjB7fT1lJcbPIIleIm4Yg+XHqw=;
        b=sfw56EvvgYIF4wFAIERhna8VAi1ZXjoz0Y4i3gRZaLgo/9u6fYjxNvwDWcceZxvmo/
         qdFwhao44CGcSOJNdu0omMWC5HbqpM028i/G9U6kgy5jqYvtd9ictNDR9JmBHTOg06U2
         2je2MCDq0Aqpre0YOPcs/ethdUDjlKy/sZZ8Mr4PhQELsgpJJf4m8YfwtUEyIkArY9jg
         nOdfUUOsSRd1zawDeK0PMJ5sNrYoejzfKCrW2qkOjS+lIOx/i2/fkQMU1I3Lc3lIq7E2
         q7B6At3hgl/4XwBc//yniU6fd9PNvzmptUKCuAT6MqjLe3fSx2+WQseB3hSdUYTheggh
         KOTQ==
X-Gm-Message-State: APzg51C1T0TMIzEX6K0nis/MStvhXwZL53LnZ/wMgeMWEFvF1NSLp1uV
        qx9qCSFbCNwiB966MSX9fW9VYoM70XlteGsHOc8=
X-Google-Smtp-Source: ANB0VdZIWq6EqsMoPlln3W8pVyfSu3VcLO366mrHiq/E9zP7+xSu4OTQVdRxi7fpI+TnNWAPYVIKXTmFvvMOv3tFi3k=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr29772057iod.118.1537373570231;
 Wed, 19 Sep 2018 09:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com> <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net> <CA+P7+xqzN5M6VgQqCNAAsmwYRmnoSVsAvdES7aK2fKf9P-f4fg@mail.gmail.com>
 <20180918231903.GA30695@sigill.intra.peff.net>
In-Reply-To: <20180918231903.GA30695@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Sep 2018 18:12:23 +0200
Message-ID: <CACsJy8A3QCYY6QeJQYkbCKYh=7Q7pj=rer_OQHLGoAMqTNomNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 1:19 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 18, 2018 at 12:36:06PM -0700, Jacob Keller wrote:
>
> > > I like that, too. It's a little more costly just because it may involve
> > > object-db writes, but I think in most cases it would be fine. I almost
> > > always "git stash" away discarded changes these days instead of "git
> > > reset --hard", because it effectively provides this kind of log.
> >
> > Obviously we do eventually turn the index into a tree, which is used
> > by the commit. Would it be possible to simply somehow store these
> > trees, and have commands which blow the tree away simply instead, save
> > it? I'm not sure how costly that is.
>
> For an up-to-date index with the cache-tree extension, this should be
> pretty cheap.  Even for a partially-staged index, where we already have
> the blob in the object database, it should just incur the tree
> computation (and parts you didn't touch would hopefully have an
> up-to-date cache-tree).

Just FYI. I wanted to get at least pruning support in place before
posting another RFC. But right now I'm going without cache-tree.
Whenever a file is updated, the _blob_ hashes are recorded in the
index log (one line per update, same as reflog format) and the
description part of the line is the updated path.

This is simpler to do, and we can still reconstruct a tree/commit in
memory if we need to (but not whole tree snapshots; but I don't think
that would be very useful). But maybe cache-tree approach is better.
We will see.
-- 
Duy

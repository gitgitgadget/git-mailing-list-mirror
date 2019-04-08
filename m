Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1382F20305
	for <e@80x24.org>; Mon,  8 Apr 2019 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHLA7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 07:00:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43930 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHLA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 07:00:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so10121134oig.10
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUHommq83D2Q69UidU3idekkaRbIRbQ9ogGzXuyhb68=;
        b=PdOGIq+7wOV7+FJdZPz4IK8OHQW86TgjBUN4pJIEjRdVxvjC7C6sx4Iwral57KdpMS
         pHJnVT0W9vbpTwpcf5eiQ/DU6l+s2JsGgqUTDWuyhdVVGtUzkl264561XGjqCjAXLFM2
         3tHMFyqdjZLyD3f7jRAanJ7Hnm7ffFSWJp2O/Rss+bTanJHnPCKdNAidBIZWdeaGZvUV
         o68eoRxmG4wzzz0sCsh42KXV/kw3RCfCGDg0ECoa8jzLiF9+2U3GubdfRM8lJ8L3q0j5
         nvgA5vMf5ILfprzHPpXNVYHQP4mVo1PEfC4fGTFkliLlJj8ThAeCsVE/QsysKqgJuAXZ
         nItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUHommq83D2Q69UidU3idekkaRbIRbQ9ogGzXuyhb68=;
        b=H+x3CbS6l8N4hNG+6DfCsS2m4ba9hQDyyc9mumm9BNhX0XBpNO22+GzyYW/67VRPMV
         zfWK7rkDro3JV7Zw8EYftTr/ZEjYhdjbr6DDP01GqifVy0JuE/UFucJ+zFj4kLIFnBIA
         c4JnFY1ma+P0ONgSADmF5HX2uOSE8U+uuasb9xmvsrFuOAxgPWXIkm0IUvKEgnsAvRNB
         raLw5w1wmfbCa/4W7/k1g9jSrq/naT19u47Li/xZC/txzjqPDS2TObrRizkWLBN98Vhy
         1ypL7p32orc7PhzqpfqKUJOUcHgkKRoMKU4QzRyTQ/c0BK0ty/4k/WGZFwNg10pYZT1u
         pMYA==
X-Gm-Message-State: APjAAAU44B92HPFISybr527XW/VyXD9uNpDX8OnK0YqPl5W9tCV86Is4
        ZL/W/QyNzz0Ol3wxZcv859rkalaOiXpUp4lYtAs=
X-Google-Smtp-Source: APXvYqzik1uM2w3swOQhL75ociNbv907kXxWEcThhUoXrUHXGwv3Z9AOfumytLt/kZNAyHM+mhtzunkHncF0kUy9oK0=
X-Received: by 2002:aca:e58b:: with SMTP id c133mr15348046oih.119.1554721258363;
 Mon, 08 Apr 2019 04:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com> <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
 <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com>
In-Reply-To: <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Mon, 8 Apr 2019 16:30:46 +0530
Message-ID: <CAMknYENqH==YcAfU-B16Jytc4Pts4viNQn9deTFag++zZVb1+Q@mail.gmail.com>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 4:02 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> Sometimes when I don't understand what some code does, I look at "git
> log --patch". In this case, there a big explanation in ad3762042a
> (read-cache: fix directory/file conflict handling in
> read_index_unmerged(), 2018-07-31) that might help you.
>

i got my reason from the commit message,

"The _only_ reason we want to keep a previously unmerged entry in the
index at stage #0 is so that we don't forget the fact that we have
corresponding file in the work tree in order to be able to remove it
when the tree we are resetting to does not have the path."

and now that i got back to reading that comment, it makes sense.

for finding that commit message did you do something like this:
git log -L :repo_read_index_unmerged:read-cache.c

Thanks.

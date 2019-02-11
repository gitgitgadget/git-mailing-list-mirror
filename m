Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3491F453
	for <e@80x24.org>; Mon, 11 Feb 2019 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfBKFtA (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 00:49:00 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38948 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKFtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 00:49:00 -0500
Received: by mail-wm1-f53.google.com with SMTP id f16so14472567wmh.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9RpoJBPhjMGV1RPr2VgpZVbsg+JiPGLWDL363Kmk4A=;
        b=oKborwc+ePsc2sTuVRKz2xUuv5HD2/pVrQp17dA9CxccAoifQNTYM1EUyOEX0+9Qn7
         8ecBOQyxSskE5v5CdZb84it0rUTA7eMnehOxoPZ+Y7aINCv4nLCpGXI/bZup/syvBQAd
         TQbDLLy5QUwzahQH1kXAxXVeLOAvtE3tLvaO8dpc9v7Uo+TkXjDWTehoqVomLiIXGjOC
         T9i5c8gP+04ZJFDiv+P9DgMX0EBP692DyIJbCHmC2KUlk5cdWTnBUlvVDg0letunkPC5
         eO1w3YRgGIjR6X9jkSD5sHDJZo6VMI4NWWUrIgr1kixenaDyeIo8Lu12znE8g0KJx+0o
         WGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9RpoJBPhjMGV1RPr2VgpZVbsg+JiPGLWDL363Kmk4A=;
        b=CqjrZwuhrN0Sii86BgvVNjNquS0oe3TG/U4YXTlUCIJpEOO8+QZjs+fciIVLotRNqN
         hxYKtB5SQtaBIUmVh3hwYB37oopop472Gv6VHPlUJA/YndQOfYbChQtDUCY8ta+QphAo
         LNt30qwG7/bl8PA1qR2vUiqCf5GnJyKvgLZiHFKHRnTqO4Hz6GL5xYK/MvX9DKkqrDH4
         q6ynTMIFz+KpebZn+0XaGiXm1wuRVM1AIeRzt7U13L9/zsl1m3FtmtwFbXyk6Nfo5Vqw
         KvCRaDSR3S80GS+HDOOVeDsKb1Bg8G72YEAFOnQviqhKm3c7aTL6yyY6U/IVhgOWHd+G
         jHMg==
X-Gm-Message-State: AHQUAubUoDLpPXZxW2M+cu/W+jjT+vq4poIjshJUy2UJ1K6Co5RyaJfD
        uw9ItKntZNjp1AzMOpE77bZOYzZg0UAa5+VL9zI=
X-Google-Smtp-Source: AHgI3IapccUe2uTQNsY7ErxP4MjxX0YuMMoX4Am6ARtlE9tnZZECNPbhwJCbILjxIXtoolPlNAnnl2z7X3iMhCS5G8c=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr4237638wmc.109.1549864137632;
 Sun, 10 Feb 2019 21:48:57 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com>
In-Reply-To: <20190207213326.GF6085@hank.intra.tgummerer.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 11 Feb 2019 08:41:18 +0300
Message-ID: <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It would be nice to have a few more project ideas.

I am not sure I have additional ideas for 3-month project for the intern, but

> https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> projects:
>
> - Unify ref-filter formats with other --pretty formats (which is new)

I am ready to act as a mentor in this task, I know that part of
project good enough.
I have additional related task: We have a function called
oid_object_info, it allows to download meta-info of the file. It was
used in cat-file, and inspired by that example, I improved ref-filter,
so now ref-filter works faster with it. Moreover, I have found that
oid_object_info allows to get the contents of the file. It was useful
in ref-filter, and actually it could be also useful in cat-file, but
we still download the file differently in cat-file, and it looks
awkward. I need to make just one last move to finish my patch: it will
close the task about migrating cat-file formatting logic to
ref-filter. But cat-file still will not use general way to download
the file. So, the task is to get rid of additional file-reading logic.
I guess this task is much smaller than original one, but at least the
student will have chance to finish it in 3 months.
My patch is here: https://github.com/git/git/pull/568
But I hope you will also see it this week in the mailing list.
Proposed task is in TODO in the end of ref-filter file.

By the way, we had a letter from Google, it is said that our tasks are
sparsed. I am not sure I understand it correctly. Should I help the
project somehow to solve our issues?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC24E1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbcGLPqt (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:46:49 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36508 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbcGLPqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:46:48 -0400
Received: by mail-io0-f182.google.com with SMTP id b62so20191435iod.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 08:46:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N/bKOnC5Oa07MmO9SmG8z4ZrI58XNZu/z6QqpwtUXIU=;
        b=Tkulp0PdzKDhuHvyMJil9OkcNK+YUuCgBTEU2y+32QVHKo5IfmARfpBnGAi5DSH/wu
         ofD4EFsjXyUk/eCQJINJSmi0g8x0Cppn4EzaI928yfBMtKUFW0QobkEcyFFN9qT2aijg
         iAB23cDQQEaI8OIOvk7YPsY7pbldWvqdAR7jKqn/vLR4KOa168bx1mEJdIDi8/fD7/Q4
         TvytjhLX34FcG4utUwuGfFYtI/Kh5DQI55kpE1ZDqk+ANdB89EviHtb/Y3sPe/9+0nT+
         XmUqmDotrWikSlbdoRKCKdS0A7IiCzGO4qj3jdIpxz9xzH9oFOu+G2ZYxqCJVl8Gs3eL
         zr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N/bKOnC5Oa07MmO9SmG8z4ZrI58XNZu/z6QqpwtUXIU=;
        b=Ik4HAFESHK8fMT3j/rvXDnBU9dBnEpgmKIazln3lV50uIJqqAy7sdwjg8odf4V9qx1
         ogpftjgyq/+CmTI8dtmGlWZSCT5CJkmpwk7L/llMQPOX7N4A0IMGPMrS+9vMgBaEFChN
         0WGQG3PQLivdCHhmTqtdCdYS8X+wHv7FjZdjdo1SPLzry4sh+wIVIXQXdrTZnjYSSvoD
         +RQD9lErf2YvxD/BWvVNTWPgXb40WJ6AHb3ylge7+IxZQ0LLX5Tqb9gUg3dkkMCNkouM
         MJ/46QiHfRb17bWIMYnRCzOTWCGGs+R64ods6gMjkVVQH0d2MNcGcZPK258v3Ma9DQiK
         2NNA==
X-Gm-Message-State: ALyK8tIHFJa8/+e4FrC0ME5moO91oMTDn9ak30gaduq3Mb4NH6fT19j6HtORbR+2u1fE1pkBdf19fWDcG+8R6A==
X-Received: by 10.107.22.6 with SMTP id 6mr3603603iow.128.1468338402419; Tue,
 12 Jul 2016 08:46:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 08:46:12 -0700 (PDT)
In-Reply-To: <20160712152646.GF613@sigill.intra.peff.net>
References: <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 17:46:12 +0200
Message-ID: <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 5:26 PM, Jeff King <peff@peff.net> wrote:
> Likewise for other per-worktree items. If we used refs/MERGE_HEAD and
> refs/worktree/foo/MERGE_HEAD, then you could access them independently
> by using the fully qualified names.

I'm not opposed to letting one worktree see everything, but this move
makes it harder to write new scripts (or new builtin commands, even)
that works with both single and multiple worktrees because you refer
to one ref (in current worktree perspective) differently. If we kill
of the main worktree (i.e. git init always creates a linked worktree)
then it's less of a problem, but still a nuisance to write
refs/worktree/$CURRENT/<something> everywhere.

> The only downside I see is that the existing names are sometimes
> well-known. I wonder if we could simply add:
>
>   refs/worktree/<your-worktree>/%s
>
> to the dwim ref-lookup when a command is running in a worktree.
-- 
Duy

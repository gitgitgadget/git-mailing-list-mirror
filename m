Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABD22018E
	for <e@80x24.org>; Sun, 10 Jul 2016 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbcGJPCX (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 11:02:23 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34604 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbcGJPCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 11:02:22 -0400
Received: by mail-io0-f171.google.com with SMTP id q83so17926292iod.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 08:02:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9szK3+akA5jvp142JkKsetbqWc2nGnlNAGMUm0yQrrw=;
        b=wTz96bhQ3coz7Vp+wWecwEqCkq1yLWmfkKUiwS5PnImM9dg/I1eG55Ywl6s0pfBJL6
         KPPr83iBGvtCGXuR733LniRK/mf7W+BIkncwMSMQKwAHsx7EtK0hwzsMLlg9IWNBxLks
         yhT3Qgtbp/DMaiZ71T5peNSyjNRjGh/GzqwLGzpao9IHt0biIZdkGMhE4yQHyUJon72B
         5cW4DwjedDhlRhD5Dp+CJw0sI4oWJTiacmPGaR8XjZbmSGcaMwhrky6x327cbJo2jZHA
         9yOQcTc/HLf150I8kGWgqZp2rzPdrFzU6FHAKiLUXh9Zxfx+LUpQ3oXr4Q1sb7f0tYT2
         pB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9szK3+akA5jvp142JkKsetbqWc2nGnlNAGMUm0yQrrw=;
        b=b8aRIU6ORFOp40BJvevKoBUGu7ICzUyTmeksPgPOq0LgNTOFGatCx+vtQBr7qG5p0T
         5dCyBOV8DzGQOx3dX1p2SJ+2yVQ3HB+lkR3W3MnZATBcf4BoCChfUYEiVAyL0s/eLJF5
         aylh/+oDGQne694LPgjTgEHhPOIWHUAyPCsGXlU123umkODV42JJH223FXwBQm8CIvfg
         aXeKjDpGlUEnwryKPi8d/1KQk8y6hCueFfj09AyY5D/3trOBd9/DmYrlibBmCNNNv4hn
         3QcFE0XyR7BMFEeKZAyh0dxW8MPjEKQlQmn+wA3qq4yA2dxsIKvzoVUFx5/Byg9+jf8I
         ebzw==
X-Gm-Message-State: ALyK8tJWVuJlD4x8vvehduK0skC/u29YISKsUM1R2PzkU1N596RvFo/cck72PsT5jnP9KeiAs6lDsuyPpt81SQ==
X-Received: by 10.107.22.6 with SMTP id 6mr15980845iow.128.1468162941693; Sun,
 10 Jul 2016 08:02:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 10 Jul 2016 08:01:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607101602320.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 10 Jul 2016 17:01:52 +0200
Message-ID: <CACsJy8AFYWsi1_f-Hw1odN3gmbfqayXuoBHo+K3Fh4XBwMA0Vw@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 4:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> No, the point is, refs subsystem needs to know which refs is per-repo,
>> which is per-worktree. So far the rules are  "everything under refs,
>> except a few known exceptions, is per-repo" and "everything directly
>> under $GIT_DIR is per-worktree", which work fine. But if you allow to
>> move per-worktree to "refs" freely, then the "known exceptions" will
>> have to be updated every time a new per-worktree ref appears. It'll be
>> easier to modify the first rule as "everything under refs, except some
>> legacy exceptions and refs/worktree, is per-repo".
>
> Given the substantial pain and suffering I have due to per-worktree
> reflogs (and those are *just* HEAD's reflogs!),

I apologize for that. I clearly did not see all the consequences of my
simple-minded approach. Watch out for the shared config issue too if
you start to rely on multiple worktrees. It may take even longer time
to address than this one.

> it appears to me that per-worktree refs would be a particularly poor feature.
>
> I agree that HEAD needs to be per-worktree, but already the fact that the
> HEADs of the worktrees, along with their reflogs, are *not* visible to
> all other worktrees causes substantial trouble.
>
> In my mind, a much more natural design would have been to map
> transparently each worktree's HEAD to refs/worktree/<name>/HEAD *and keep
> those refs and reflogs visible across all worktrees*.

We will be able to see refs from all worktrees if we choose to. There
is no question about that. It's needed for full-repo operations, gc
included. Whether we expose all worktree namespaces via refs/worktree
(as a logical view, not storage one), remains to be seen. Michael's
new ref API may be flexible enough that we could do without. I'm not
sure yet.

> With that design, I would not have irretrievably lost reflogs to auto-gc
> nor dozens of hours trying to figure out how to have *any* auto-gc succeed
> again (because I need to reduce the horrible slowness incurred by too many
> loose objects). My interactive rebases would also not have started to
> print the auto-gc error after every friggin' pick.
-- 
Duy

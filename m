Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663922036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdKUViA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:38:00 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33164 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUVh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:37:59 -0500
Received: by mail-qk0-f194.google.com with SMTP id 78so14112365qkz.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 13:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DpRKy1apSrBeiHAkumrjgB2va9LalMv32OE6ce+BY0g=;
        b=X5mZqQ1VROmRIGVBj5rm4NPcb1zhP6MNa9lXOaMeWcGaYbDR8C6x5YnSIDOTvQeIea
         B8u1nwMegnA/jMwCwr70GUGDOFnkDJGE7pSbjQQuPJSkA9C/1WH7I+zSAV+niXR9UaBH
         Oky7qbI5abWYmgseh+8UrHRMpye2uF0Ua2xMNHQQLaY+QS0BRtqYnLJGNuOMQmVtJvmk
         LQW7wUGXS6r0gGkg/WRPzROXGaiN5FA20BR7kLdrm9f5z6cTkWNLSEld5xou2DG5gOeC
         S854okfallsn6i/CO7jVDPeFryoOYrl9ceSYwevspx8wtoUu/LzFaZzHoLh9y1I5rVvV
         JQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DpRKy1apSrBeiHAkumrjgB2va9LalMv32OE6ce+BY0g=;
        b=BLmsacrEhKlD0L3mz0Zh5IEF5Fau7ilW2FobNGH8YFr9/KK3iGSZTpWu5+JSSCeaO5
         sBWXOm3049QFBx4M1cV82BijNOUO2D3xVs5NRvloo6C8FyiH3X2iRi5lzG5YU8z+hwdx
         xR0NkBYtM/y5XlYSDNNTVNdoRpRBi9eTfVGOlCwdM5anLb8sIfW7HjQzEBUcPTbxlFN8
         9nNCJOI8HQel5RXn2E25Fkl90CbCpzcMhs7viIyEaEvF3nPI/cIoSO06RU1XfMedl0lK
         jqthcHgDqabQgrP6G36C4weKvhwabCiBDqmHBVgFyhGk3N8lw5Omcvm+xVR2GU2eCo1G
         QNlQ==
X-Gm-Message-State: AJaThX7VX6tGhU6MDQXglvGg5zeUfv76hPf2OFP33UHVHsHGp8a7Opc8
        i2/zW1rHpCmjB4+PlI3g/B3mxcshFt/2cUpZfS1JWw==
X-Google-Smtp-Source: AGs4zMaz4e3SPrUa7q65XcSmBObvkh4tVd2wAfvtckFk4TpLe+2G/XY3Usg3nYQ7ztA/HhRp2g6J3g/3oLY/WE2PqDc=
X-Received: by 10.55.97.209 with SMTP id v200mr30334772qkb.71.1511300279103;
 Tue, 21 Nov 2017 13:37:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 13:37:58 -0800 (PST)
In-Reply-To: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 16:37:58 -0500
X-Google-Sender-Auth: mzWJEDrWv8uJJ6j-3lrKhUGYmlo
Message-ID: <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:09 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> The new feature to 'remove' worktree was handy to remove specific
> worktrees. It didn't cover one particular case of removal. Specifically,
> if there is an "entry" (a directory in <main_worktree>/.git/worktrees)
> for a worktree but the worktree repository itself does not exist then
> it means that the "entry" is stale and it could just be removed.
>
> So, in case there's a "worktree entry" but not "worktree direectory"
> then just remove the 'stale' entry.

Let me see if I understand. Sometimes you know that you've deleted the
worktree directory, in which case 'git worktree prune' is the obvious
choice. However, there may be cases when you've forgotten that you
deleted the worktree directory (or it got deleted some other way), yet
it still shows up in "git worktree list" output with no indication
that it has been deleted (though, ideally, it should tell you so[1]).
In this case, you see a worktree that you know you no longer want, so
you invoke "git worktree remove" but that errors out because the
actual directory is already gone. This patch make the operation
succeed, despite the missing directory. Is that correct?

[1]: Excerpt from:
https://public-inbox.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/

Other information which would be nice to display for each worktree
[by the 'list' command] (possibly controlled by a --verbose flag):

   * the checked out branch or detached head
   * whether it is locked
        - the lock reason (if available)
        - and whether the worktree is currently accessible
    * whether it can be pruned
        - and the prune reason if so

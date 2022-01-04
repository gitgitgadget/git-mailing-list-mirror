Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B3C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 16:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiADQb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 11:31:26 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:45912 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADQbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 11:31:25 -0500
Received: by mail-il1-f171.google.com with SMTP id g5so28682334ilj.12
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 08:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9529Ic9zLgcpTAFtr128rtBasI1W1op5X1AM8efQDw=;
        b=B/VRIzSV/aOoSpmhj79p1ELq81sEOVJF16lXoSqvubvxj1iRUjMI5/vM39yveIFyHs
         kdGANw2pO6jCxbAilRnl3COQrTiN4CPKqq/n5hF1f+lJimLuOrYzqE3sSj3OzvjYU4mh
         horwYXqpawnKcsRwqHRIAGA5SrmNDv/FfUDRYsUM50Mor47PeC+D3flF5bcFFIKRk5hp
         /oMxB1RRSL7GdRpW/VJbYLRrqS+cxvj7hblrU0R9s0jeWia6qCMacOsDOVhIxcBybelt
         nSIsAQwnaHrGUXSBj0UWvs9spgp+tpsohxsXSlN0fokUJqey+R9yhzkMn84RYyUNTgim
         SYTw==
X-Gm-Message-State: AOAM533ezUn4gRT1bpjFU+GURydaNNymH8MtCUTU5j2U5BLX97SSr+bN
        oADlzySADwHLKta25qhxjblJy9jYqMbjlv7DNQo=
X-Google-Smtp-Source: ABdhPJwtGnfoT0FzFeYO8My762Jcql11bbrAdeblfxZhoMOAtNIczl9ccSw12utEX+FF3TKPSpae7Fol4U25H5eABko=
X-Received: by 2002:a05:6e02:156c:: with SMTP id k12mr21994798ilu.94.1641313884426;
 Tue, 04 Jan 2022 08:31:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CA+JQ7M_tOu5ahQSPZk5Be10rY_NDOmqLWj9b1On=KW8Rq2mk2w@mail.gmail.com> <CA+kUOakd0HaPk7PGh+4L6753KnsVaykczy31=5vrG91iJkcOfw@mail.gmail.com>
In-Reply-To: <CA+kUOakd0HaPk7PGh+4L6753KnsVaykczy31=5vrG91iJkcOfw@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 4 Jan 2022 17:30:48 +0100
Message-ID: <CA+JQ7M-1_sGSX31Fij4XwFcrBVFPrLFJCC-GdeDrEeGoPYEP_w@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 3:48 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> Investigating with `git bisect`, the change in behaviour seems to have
> been introduced in 1ff21c05ba ("config: store "git -c" variables using
> more robust format", 2021-01-12).
If that's the case it should be present since v2.31.0

I can't replicate in git version 2.34.1.windows.1
But that's MinGW based so if you don't see it in cygwin it's not a big surprise

On Tue, Jan 4, 2022 at 5:16 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> but it looks like the issue occurs when using `-c` to set a config
> option regardless of the option being set.)
:(

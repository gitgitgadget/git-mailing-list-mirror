Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0961F406
	for <e@80x24.org>; Wed, 10 Jan 2018 00:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeAJAjZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 19:39:25 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:44625 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbeAJAjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 19:39:23 -0500
Received: by mail-vk0-f53.google.com with SMTP id p144so10555018vke.11
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xl1kUO/gOqcwPGLMTm1CCA2x5e7swetqPGEEPyQtqHE=;
        b=XvwrdHlllAFU3/AOocu1qfr8+Fb0cvjogPlObsOikXLTHut01W4+X5NjIG3q7X9Cqx
         /6CLppO1LGqpL9grL7OmoLl+ReADhqu4qCLbr1kzux8b+0EDHxA4DxIIrkS79tb82+vD
         3n7gbSP66+O9KJE3HrsLGmL8Bn4Px2gJiEV3Dy4W+hNFl5xtGBuJZWMJtUGgupH7bM/S
         QIxW71dFmBrSIdsbMXhaOZgPVhDmtHEx5J7/YOMi3G0l0ObnnnG3eyTo0QPyvcyYUewz
         unc9Sk/cSFdqaKveDa3iljqBC+uD+mrO1xpcXBfBzSvBKktJXziyjozk2seUzGE2EvuY
         E0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xl1kUO/gOqcwPGLMTm1CCA2x5e7swetqPGEEPyQtqHE=;
        b=f4TpR08uyJ1esqFa4i9aPj0OO0AmRDJlKGx9zpt8sz3QULZcwkZ1I53B1PYX/r3PpT
         AeviOa3NSqGop9E/ePZI2dxd/SNPy0uiksj045HyWxHBZ7O8xaLFDwTD/uo0aQz6WdjM
         WHF59LyRcadAV84oHi1TeJoj33S07IakP8eX5zLd0NnyuhKVxGRmShFZG/dmQAaVw0xV
         YGjRWGEeZb97oouPzsdA/itDmenpW3EuwZTG8zdUrMNIMAdcpgTn2p1ySb2SwkY7IU9G
         q78lGm8eWQEOHjZaW+rdXgr21uGp6w1TkpaPu76J3oWXAvgT+Ass7GgEumoUU2+UWbqX
         QZDw==
X-Gm-Message-State: AKwxytdD5bgLZEiVxNHR1ubDatkVpB0iWGr1ME0uIKcsuEiK7HFF5wHE
        COXMNNxSwmbV4oY2H8YHAGnsBy0oa1T6kDjHP6g=
X-Google-Smtp-Source: ACJfBou8Ym9KWzCp9W/l9+JYIrin6AhXMIKDrezplXnZ/tS0Rs3pW4l+NkThUJODmMKwkcDZbfw/U9cOHnUN67TkXQU=
X-Received: by 10.31.154.86 with SMTP id c83mr15406902vke.60.1515544761911;
 Tue, 09 Jan 2018 16:39:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.11.153 with HTTP; Tue, 9 Jan 2018 16:39:20 -0800 (PST)
In-Reply-To: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
References: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 9 Jan 2018 16:39:20 -0800
Message-ID: <CAKdAkRTK=0Kafc-nhvJTu+9m-pp=BV3Oc-gu6ssjZZQm95pC_Q@mail.gmail.com>
Subject: Re: prepare-commit-msg hook no longer run for cherry-pick?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Jan 5, 2018 at 10:48 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi,
>
> I had prepare-commit-msg hook that would scrub "Patchwork-ID: NNNN" tags
> form commit messages and would update input mailing list patchwork to
> mark corresponding patches as "accepted" when I cherry pick form
> WIP/review queue into branches that I publish, but that recently stopped
> working if I do a simple cherry-pick.

This seems like a regression, at least for my use case. Unfortunately
my mail seems to get lost in the mailing list noise... Please let me
know if this is indeed broken or I need to adjust my workflow.

Thanks!

> If I specify that I want to edit
> the message, then the hook is executed:
>
> dtor@dtor-ws:~/kernel/master (for-linus)$ GIT_TRACE=2 git cherry-pick ff162c1554efe951ba6c7a19a228fc76a91fe1ed
> 10:43:12.832426 git.c:344               trace: built-in: git 'cherry-pick' 'ff162c1554efe951ba6c7a19a228fc76a91fe1ed'
> [for-linus 48bc600a3659] Input: raydium_i2c_ts - include hardware version in firmware name
> Author: Jeffrey Lin <jeffrey.lin@rad-ic.com>
> Date: Thu Jan 4 21:35:23 2018 -0800
> 1 file changed, 12 insertions(+), 2 deletions(-)
> dtor@dtor-ws:~/kernel/master (for-linus)$ gti reset --hard HEAD^
> HEAD is now at 02a0d9216d4d Input: xen-kbdfront - do not advertise multi-touch pressure support
> dtor@dtor-ws:~/kernel/master (for-linus)$ GIT_TRACE=2 git cherry-pick -e ff162c1554efe951ba6c7a19a228fc76a91fe1ed
> 10:43:24.433162 git.c:344               trace: built-in: git 'cherry-pick' '-e' 'ff162c1554efe951ba6c7a19a228fc76a91fe1ed'
> 10:43:24.782355 run-command.c:627       trace: run_command: 'commit' '-n' '-e'
> 10:43:24.786460 git.c:344               trace: built-in: git 'commit' '-n' '-e'
> 10:43:25.082164 run-command.c:627       trace: run_command: '.git/hooks/prepare-commit-msg' '.git/COMMIT_EDITMSG' 'merge'
> hint: Waiting for your editor to close the file...
> 10:43:31.491551 run-command.c:627       trace: run_command: 'vim' '/usr/local/goo gle/home/dtor/kernel/master/.git/COMMIT_EDITMSG'
> [for-linus 039c57df0ec8] Input: raydium_i2c_ts - include hardware version in firmware name
> Author: Jeffrey Lin <jeffrey.lin@rad-ic.com>
> Date: Thu Jan 4 21:35:23 2018 -0800
> 1 file changed, 12 insertions(+), 2 deletions(-)
> dtor@dtor-ws:~/kernel/master (for-linus)$
>
> Also note that the argument to the hook is "merge" whereas I think it
> used to be "cherry-pick" earlier.
>
> Is this behavior intentional? dpkg reports version as 2.16.0~rc0+next.
>
> Thanks!
>
> --
> Dmitry

-- 
Dmitry

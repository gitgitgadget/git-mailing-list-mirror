Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF481F453
	for <e@80x24.org>; Mon, 18 Feb 2019 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBRKKO (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 05:10:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38380 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfBRKKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 05:10:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id 2so18534053qtb.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StnD77cRKCQBKckf9XKyK5CmWudyA/Ay13Rg2Rq7afs=;
        b=qjYZMGg3mVHLCjaWve6aJQ43kJsxc/7QzEiHanmI9lZtcN7t30knlCN4Tf20bk4ZIh
         zWvuDH+FXCGsLGiox6a9Pf96C5TAJq23fEy6SK/JmzsHypjL8zzDCO9vuGOL30Q3ThnZ
         SNVZBZ7znuKZpnXzDsS9S9cSGHK0Ej1G0NkmD6CVDuFntZACk84ISZKIPie4cqZTwIwF
         c2P1kwX+q64XVA7ErEcwEl2Kfwkp3vO2uu6ZQW62gX01nMaEL42Gxhdp7WwHbxunuRlJ
         3l/HZoRTE4Byv6q7KLQ7fuw15bbct4JbSobKHOH+OVhvJOQPfRYqxnlgSB5FoIceoWiX
         ewXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StnD77cRKCQBKckf9XKyK5CmWudyA/Ay13Rg2Rq7afs=;
        b=iXMiZCZOzspXi7F+1fZi5ofGaV7fkf2zMAAmNuFzJ4hvPk5P8vg40XLRoYjo1/TN9P
         FosJkG0WhHt1JmUvpH82PYS+paovXZnn3pcOG2+7ZzgkUfu//7Vs5jjZcRpZP81xlNVv
         gHa7LyR6xv5urvP5bMl1p7EAXYqUANGQdVV2BKP+HmzY42/sS+cDRtHuTmxq32P+P2k/
         8jU6Dd9QFaTuNATI752ZnlDEgD+Wn0Ep9oQZKLdhAQqtxBRZbAs743ehEHCKxzzo90jQ
         TqC8d5xWb4t8Jl+0uxtQH8F9BrScgmz9ZLRcl1PAHUybGoGD99uaHv4Xq9xzXcewK+B4
         6VXw==
X-Gm-Message-State: AHQUAua41nipnPb6n83q6TmPKYK+onR6jJKvREG35Dgad5EGW7IsA3sH
        bFH7XAmuTugf3d14bENlR9xGXZiR2+XCIROUjiE=
X-Google-Smtp-Source: AHgI3IZB/6uMzFN9VFIzn+1S/yMQuf7VZB7xiuiNzitYILrl7dpDk3PxDPECdVHLwfpBK0U8qUEEmxxfyaf0S5l2QcU=
X-Received: by 2002:ac8:2190:: with SMTP id 16mr18127665qty.365.1550484613916;
 Mon, 18 Feb 2019 02:10:13 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <20190201220420.36216-2-nbelakovski@gmail.com>
 <CAPig+cSfw=dun__contMMiHrdsZPPN68U4UzfBGz4Yt8DwO7mQ@mail.gmail.com>
 <CAC05386a+FZP8hGawYsfZrmA--JuZBqi_aop7202JQnJEfKyJg@mail.gmail.com> <xmqqsgx3v2sy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgx3v2sy.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Mon, 18 Feb 2019 19:09:43 +0900
Message-ID: <CAC05384mbqpq5QZJiXvVoKZyCx21ATM5TcKscnuKdbR0wi5o=w@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] ref-filter: add worktreepath atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, it sounded like we didn't like the ":" extender from another
conversation on this thread. Do you think this patch should move back
in that direction?

On Tue, Feb 5, 2019 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nickolai Belakovski <nbelakovski@gmail.com> writes:
>
> > There's been a little back and forth on it, but my understanding is
> > that using the colon separator bypasses the caching mechanism in the
> > atoms, so every instance of "worktree:path" in a format string would
> > require a lookup.
>
> Would that be a problem, though?  You now have a singleton hashmap
> that is a file-scope global not tied to any particular atom, so...?

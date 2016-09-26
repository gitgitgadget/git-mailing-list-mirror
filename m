Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A761F935
	for <e@80x24.org>; Mon, 26 Sep 2016 07:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761003AbcIZHNf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 03:13:35 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38864 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757067AbcIZHNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 03:13:34 -0400
Received: by mail-wm0-f44.google.com with SMTP id l132so132472462wmf.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IBd+ecCoKnNe7QHykvOZELXFBd5ZG3rM3N0LGzK/Y4Q=;
        b=KHJsoQHO93BI5Nc27k+8F/lOyD3R0l8Dsa9VJtFWFky2xH3vfhX0+5Zv+EFmkv0826
         jFCwIGGS8NxrdKGZrMXVyDqTV6JzZd9bLulhLIvc20m+ky4E2dFYA1YA+LiziXWtlM05
         iojS/BUXCP1B7RbHVG6sCOKgiAjNOm2pKYGjBU815yf0RP/05/ih69Xwg5CqOLr5Uy1e
         u+HmhmFqyFLTJsNQWA8Zgk0HCcEjxpfaaPTG1rnvdu+VspmiAFxnAKyHHwoDgsTB5vWv
         NX7wviEPOcZi8Ki/eY3HEXPnCvzSaJegxacdB5wFHxb+rQ7Djahre62azqNfnpGOkj4D
         2SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IBd+ecCoKnNe7QHykvOZELXFBd5ZG3rM3N0LGzK/Y4Q=;
        b=JTsdCsipoiCM3ziJPjf6EmCqiqHS64Kb9WUbQ1osvY2IdRTJl56T9M7nBKZcJ0x554
         TWzPkOwgRVoQyauEmfxEZnHDxeUuxU3+WBHkKmetFZLLUOQSTltgOegEsLOC7lh6R8aH
         jtnpyEbdLZ3bWAhRPJNiSVnu26av4qPFlpYDf466Bl4uhAzhOQt69XauBonLST/LKDUK
         7lce05/7eNr5vyLOFE2q/SNMo11yGP+RNGQ1xK6/YxCeHxsT4pOLhNKWUlZjIjRQ8VBM
         raCrtL7KoTw4VIRnw1LK5ae2i7vSyxyeFyC8kK2/4lFhGL9Xp76TqCPidUtkuG8ZVms0
         /6zQ==
X-Gm-Message-State: AA6/9RkRkPgT0Oxq+hYHF4EW87zHVi9AalrMz/+GE572gAfZt6bejr6n2+sYHDoiCLXtZSajJ424CC6g1eJj8Q==
X-Received: by 10.28.22.138 with SMTP id 132mr11986037wmw.7.1474874012652;
 Mon, 26 Sep 2016 00:13:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Mon, 26 Sep 2016 00:13:32 -0700 (PDT)
In-Reply-To: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Sep 2016 09:13:32 +0200
Message-ID: <CAP8UFD3UDm_CT2_4YYeQ+-gdC2kJPp7v0k5hZOB4oALUzR-JPg@mail.gmail.com>
Subject: Re: Changing the default for "core.abbrev"?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 3:39 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The kernel, these days, is at roughly 5 million objects, and while the
> seven hex digits are still often enough for uniqueness (and git will
> always add digits *until* it is unique), it's long been at the point
> where I tell people to do
>
>     git config --global core.abbrev 12
>
> because even though git will extend the seven hex digits until the
> object name is unique, that only reflects the *current* situation in
> the repository. With 5 million objects and a very healthy growth rate,
> a 7-8 hex digit number that is unique today is not necessarily unique
> a month or two from now, and then it gets annoying when a commit
> message has a short git ID that is no longer unique when you go back
> and try to figure out what went wrong in that commit.

AEvar sent a patch recently
(https://public-inbox.org/git/20160921114428.28664-3-avarab@gmail.com/)
to have gitweb link to "git describe"'d commits in log messages, and
this makes me wonder if it woudn't be better for the kernel to also
use the output of a command like `git describe --verylong` or `git
describe --long=12` instead of a regular git ID in commit messages.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD20211B4
	for <e@80x24.org>; Thu,  6 Dec 2018 18:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFSj7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:39:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35536 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeLFSj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:39:58 -0500
Received: by mail-io1-f68.google.com with SMTP id n9so197837ioo.2
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4j0H3LMhDfmQrjMPMySrEH4U6VgaTOjyGEmL/FBh64=;
        b=Ho5q6bQo/Z8MshwZ/6Q+GndjY/7tGjef53EFCmN+dKAZbOhCEuYKgl7Waj+bx8bwps
         dSJ0lza0Ay/XBJp2+EW2M5llW1yFtLpV/bonFdcTHjdkr1iUFrtZMxcUGsz6ynYqBm7j
         NAdfGIRVp9FYC2y7Hqn+p1HrVWUaKC0Le/NRmxU98J9+872ay8h5JJxro7vkqb5feOal
         Tz9iZIv7DIuFvV66svtE5qDYcrtwuAX53Ba1C2wQHQJrpmW1rHYp2fMfzyzWMLuB8/dJ
         9In0sn8L7kSXYAIWziAOYe/G49UVGvnGaTKRSqkkT/AcFbGvgA3sqybaof/1wbFM2BXP
         whwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4j0H3LMhDfmQrjMPMySrEH4U6VgaTOjyGEmL/FBh64=;
        b=tbwqXfXPLrJ4bs/TbitZU11k24h6/oX4A1bQMahILsZlk9yBL0+So5QL+E5LVppS6G
         fkQ7P70xhpIM8bmz5TyNGc69IGtq7dpeV+Vq59/5u9gJcGeGvRbLCUN9joMEI50S6JJ8
         81BH+0+7k10mXpvwRM0iiebLHbwcFaRPfvpQzmmuClFcF98u+LU0V4yJYwRl6goHLEDU
         xHlRSEqEDs/NL4VGEQOxURxpW4bBIrOAPHldMKFD82Q21mZhrTiveaRPwNzJJJY51s//
         514jvZd+TsEEmO2V/4A/ECzPvgv5Gc/w6VVlOTnuF/JCVjpm9hZ2ru3223OcEKuoPNxh
         JWXw==
X-Gm-Message-State: AA+aEWYdcFIh3rHR+WqTLRKARiOTIi92oAJm4OQQvTFryzn/vZ2Oko5e
        pv5O/fWiA0DFhGI84YWiiYqTubrvzCyf7W1Sci0=
X-Google-Smtp-Source: AFSGD/X6800JMGwgbvn6wSXPbuxN2IJzsZtTd2ci2AKppll69kBTDkbAJMTMWtLsDu1zgusIDn8S+fmKbakkcUpdqtY=
X-Received: by 2002:a6b:6f15:: with SMTP id k21mr13111714ioc.236.1544121596866;
 Thu, 06 Dec 2018 10:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com> <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
 <87pnurzvr6.fsf@evledraar.gmail.com> <CACsJy8Ck7CZ7JWaN6ark=wrAngywJJh76y-FvJ87gE2ckVS8pg@mail.gmail.com>
 <f6aad4a2-8cb4-acc2-af9b-9c9c82059b89@hibox.tv> <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
In-Reply-To: <CA+P7+xri1=peNpEiZCE802HwCXhojyp2BDvOR+6BBSoRtsZyzA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 6 Dec 2018 19:39:30 +0100
Message-ID: <CACsJy8BJanw33m9ei3TFL+kt1OH3htUwemhSE=goUh=6py3+xg@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     per.lundberg@hibox.tv,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 1:56 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> Personally, I would rather err on the side which requires the least
> interaction from users to avoid silently clobbering an ignored file.
>
> Either Duy's solution with a sort of "untracked" reflog, or the
> garbage/trashable notion.

The "untracked reflog" is partially functional now [1] if you want to
have a look. I'm not going to post the series until post-2.20, but if
you do look, I suggest the first patch that lays out the design and a
plumbing command to manage it. Basically you'll do

    git backup-log --id=worktree log <some-path>

then pick up the version you like with "git backup-log cat" and do
whatever you want with it. High level UI is not there and will be a
topic of discussion.

The precious/trashable/garbage notion can be used to suppress making backups.

[1] https://gitlab.com/pclouds/git/commits/backup-log
-- 
Duy

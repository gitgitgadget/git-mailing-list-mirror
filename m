Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30AD820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 13:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLLN1L (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 08:27:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43612 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLN1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 08:27:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so20377910qtj.10
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 05:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaUALVhVOd8qBZuj+1MnzHrarUNMEVx2Mdd+zRGtHBE=;
        b=MwhYI0xUFxdPg8YMgz+d6JJnS8G/eiieudzXwCNI69BoyUxPkPvtIeh5SS98YYs0tW
         Iotz7TA8ORQDlS5xQsg4CBHQmu1h1CIe+kPnsyX8aOAv9yrRCJgq9kXUuj2a0gZJWBTn
         Hv6q1x/z+9KpU3Yl+an+7xf/kSOvBMahjEkwj9PWnRZDvD7CgxqD0yXO8JLGe6gFnyTE
         /2+yzyHo2qeol//S1cKkqkH2ciA09jkTcPQ+ITw+kVLayin2kHMl8YtVRAerhSjRQo8a
         SqO3ML1gjQvnr6Fp5y9puyFUwu5tclKRtoPi4jgx2J0n8ORF3rkGUvGA5SXAQx0j45PO
         2qBQ==
X-Gm-Message-State: AA+aEWZl3zGHSf01XdXE4yKgung6wRim+VYudvAB92+HmAXdF7UWX4p5
        qAnYTVWVbl030KNu9K+DsMg7lDuKzi7l6OMrA5Y=
X-Google-Smtp-Source: AFSGD/Wr8Rd3r2zg3Jmmav7nWAxGd0K6/f/prL/FUZGKz49JIfyRjXTQWktIvRmpa5z+xHnp5GjPI2MXvlYcwBSFftM=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr19505231qtc.236.1544621229841;
 Wed, 12 Dec 2018 05:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-2-t.gummerer@gmail.com>
 <CACsJy8AgbU9YyMHXdp=bkMncBO_Mu0FOQ4kSRkgacHzTJ0DrdA@mail.gmail.com> <20181211215019.GO4883@hank.intra.tgummerer.com>
In-Reply-To: <20181211215019.GO4883@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Dec 2018 08:26:58 -0500
Message-ID: <CAPig+cQ0pPiB01KOWsC7a3mHdJz6LtAJjtf8=MWF+34NFdVb1g@mail.gmail.com>
Subject: Re: [PATCH 1/8] move worktree tests to t24*
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 4:50 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 12/10, Duy Nguyen wrote:
> > On Sun, Dec 9, 2018 at 9:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > Move the worktree tests to t24* to adhere to that guideline. We're
> > > going to make use of the free'd up numbers in a subsequent commit.
> >
> > Heh.. I did the same thing (in my unsent switch-branch/restore-files
> > series) and even used the same 24xx range :D You probably want to move
> > t2028 and t2029 too (not sure if they have landed on 'master')
>
> [...] good to know someone
> thought the same way.  I started this work before t2028 and t2029
> landed on master, so I failed to notice them.

The thought of renumbering the test script came up as early as
2015-06-30. See the last bullet point of [1], for instance.

[1]: https://public-inbox.org/git/1435640202-95945-1-git-send-email-sunshine@sunshineco.com/

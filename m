Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B0C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B360161408
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhD1IAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:00:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55112 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1IAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 04:00:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B45CC1F5AE;
        Wed, 28 Apr 2021 07:59:27 +0000 (UTC)
Date:   Wed, 28 Apr 2021 07:59:27 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210428075927.GC13114@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> I have tooling to automatically generate the proper range for
> range-diffs in cover letters, but that tooling requires some sort of
> manual timestamp, which means I need to go search for my previous series
> to find the date and generate the range diff, or if I'm in a rush, I
> just have to omit it.  This can take some time, having to guess what I
> named the cover letter the last time and search for it in a mailbox with
> a 6-digit quantity of mails[0].
> 
> In general, I have trouble keeping track of the patch mails I've sent.
> I do definitely need to refer to them later, but I don't generally keep
> them around on my system since they tend to duplicate my repository, so
> I end up needing to find them in my mailbox, which as mentioned, is
> slow and error prone.

Along the lines of what Ted said about Fcc, I've always Bcc-ed
myself on every message I send to verify deliverability and
check/train my spam filter.

What search tool do you use?  mairix can handle the 6-digit
quantity of the git list fairly well.  The following finds all
threads with "sandals" in From/To/Cc:

	mairix -t a:sandals d:YYYYMMDD-YYYYMMDD

and dumps it to whatever Maildir/mbox/IMAP "mfolder" you've
configured.  (prefixes in public-inbox such as "a:", "d:" and
"s:" are stolen from mairix; though mairix ranges use "-" and
public-inbox uses ".." due to Xapian).


I've also heard good things about notmuch, but I archive old
mail to gzipped mboxrd right now[1], and that only supports
Maildir...  I learned to use Xapian by reading code in notmuch.



[1] Fwiw, I'm also working on an AGPL Perl5 storage+search CLI
    that scales to 7/8-digit mail collections.  It's not ready
    for prime-time, yet, but getting there...  (Assuming it
    doesn't set my SSD on fire, first :x)

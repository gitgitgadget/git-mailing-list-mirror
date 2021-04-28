Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD7C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EC9613F8
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhD1HWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:22:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33014 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhD1HWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:22:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 86E471F5AE;
        Wed, 28 Apr 2021 07:21:38 +0000 (UTC)
Date:   Wed, 28 Apr 2021 07:21:38 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210428072138.GB13114@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
 <20210419025754.GA26065@dcvr>
 <87o8e82b4p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8e82b4p.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Apr 19 2021, Eric Wong wrote:
> > Son Luong Ngoc <sluongng@gmail.com> wrote:
> >> [...]
> >> 3. Isssue with archive:
> >> 
> >> - I don't find the ML archive trivial for new comers.  It took me a bit
> >>   of time to realize: 'Oh if I scroll to bottom and find the "Thread 
> >>   overview" then I can navigate a mailing thread a lot easier'.
> >
> > (I'm the maintainer of public-inbox, the archival software you
> > seem to be referring to).
> >
> > I'm not sure how to make "Thread overview" easier to find
> > without cluttering the display near the top.  Maybe I'll try
> > aria labels in the Subject: link...
> 
> I'd say the bare-bones style of it is probably jarring to most users
> today. I had to check if the site even had any CSS at all.
> 
> I.e. I think a more intuitive UI to users today would probably be some
> collapsible side-bar on the left of the screen, which would have a
> threaded view. The "Archives are clonable" would probably belong in some
> "help" tab in such a UI.

The plan is to support read-only JMAP, so it's a stable API that
users can build their own displays on top of (of course, NNTP
and IMAP support already exists).

I can't make drastic UI changes such as a sidebar without
breaking things for users who like the current UI.  I only know
about GNOME3 and Digg because they made drastic UI changes that
angered their existing userbase.

The current UI is designed to for a terminal with w3m|lynx since
it's the lowest common denominator.  Graphics drivers/stacks
seem to be most frequently broken thing on GNU/Linux systems, so
it's important users can find patches/configs/help easily with a
text-only browser in order to get graphics working.

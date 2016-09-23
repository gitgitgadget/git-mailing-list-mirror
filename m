Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27621F935
	for <e@80x24.org>; Fri, 23 Sep 2016 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759007AbcIWKke (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 06:40:34 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:52364 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758987AbcIWKkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 06:40:31 -0400
Received: from [10.1.1.70] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id B4DA0300B32;
        Fri, 23 Sep 2016 12:40:28 +0200 (CEST)
To:     sbeller@google.com (Stefan Beller), me@ikke.info (Kevin Daudt)
Cc:     anatoly.borodin@gmail.com (Anatoly Borodin),
        git@vger.kernel.org (git@vger.kernel.org),
        jrnieder@gmail.com (Jonathan Nieder)
In-Reply-To: <CAGZ79kYoFH0dbQwvL_2JOtd8aybH8MKCtzy+p_88+QykVTGUtg@mail.gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Fri, 23 Sep 2016 12:40:29 +0200
Message-ID: <1mu0zrn.cs3kf31kttpjkM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.11.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:

> On Thu, Sep 22, 2016 at 12:48 PM, Kevin Daudt <me@ikke.info> wrote:
> > On Thu, Sep 22, 2016 at 07:33:11PM +0000, Anatoly Borodin wrote:
> >> Hi Stefan,
> >>
> >> this section was added to the manual in the commit
> >> cddb42d2c58a9de9b2b5ef68817778e7afaace3e by "Jonathan Nieder"
> >> <jrnieder@gmail.com> 6 years ago. Maybe he remembers better?
> >>
> >
> > Just to make it clear, this section explicitly talks about 'bugs' with
> > preserve-merges and interactive rebase.  Without the --preserve-merges
> > option, those operations works as expected.
> >
> > The reason, as that section explains, is that it's not possible to store
> > the merge structure in the flat todo list. I assume this means git
> > internally remembers where the merge commit was, and then restores it
> > while rebasing.
> >
> > Changing the order, or dropping commits might then give unexpected
> > results.
> >
> 
> The commit message may help as well:
> 
>     rebase -i -p: document shortcomings
> 
>     The rebase --preserve-merges facility presents a list of commits
>     in its instruction sheet and uses a separate table to keep
>     track of their parents.  Unfortunately, in practice this means
>     that with -p after most attempts to rearrange patches, some
>     commits have the "wrong" parent and the resulting history is
>     rarely what the caller expected.
> 
>     Yes, it would be nice to fix that.  But first, add a warning to the
>     manual to help the uninitiated understand what is going on.

Thanks, but all of this still talks about the issues in very generic
terms ("most attempts to rearrange patches"). I'm interested in more
details as to exactly what kind of attempts do or don't work. In
particular, I'm interested in fixup/squash commands (without reordering
anything else), or dropping (non-merge) commits.

I could of course experiment with these and try to find out myself, but
I was hoping someone would just know the answer off the top of their
head, saving me some time.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

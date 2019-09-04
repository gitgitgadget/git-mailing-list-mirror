Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372C01F461
	for <e@80x24.org>; Wed,  4 Sep 2019 22:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfIDWs0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:48:26 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40677 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIDWs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:48:26 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5C39340003;
        Wed,  4 Sep 2019 22:48:23 +0000 (UTC)
Date:   Thu, 5 Sep 2019 04:18:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
Message-ID: <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 10:43PM, Bert Wesarg wrote:
[snip]
> > > fixed width to avoid creating too wide commit messages. Though 
> > > this was
> > > only enforced in the GUI. Now we also check the commit message at commit
> > > time for long lines and ask the author for confirmation if it exceeds the
> > > configured line length.
> >
> > Hmm, more confirmation dialogs tend to mean more annoyance for users,
> > especially considering that the line length limit is a
> > project-specific _policy_ (so this has the potential to annoy a lot of
> > people), and also because there often are legitimate reasons for
> > exceeding the limit (such as pasting in URLs).
> 
> these people did not saw the entered text anyway. they would have
> needed to change the option (default to 75 characters) to see what
> they have typed. which could have been garbage to begin with.

Not true in my experience. Sure, no scrollbar appears, but the view of 
the textbox still scrolls when I type in a long line. I can go back to 
seeing the start of the line by moving with the arrow keys.

The point being, you _can_ see what you typed. Do you not get this 
behaviour in Windows (or whatever platform you use)? Maybe that is a 
Tcl/Tk problem?

> > As an alternative to a confirmation dialog, how about instead adding 
> > a
> > _warning_ message (perhaps with red text) on the window itself
> > alongside to the commit message field (below or above it or
> > something)? Is that something that could be triggered by a text widget
> > callback?

I'll chime in with what I think would be a great solution: auto word 
wrapping. This way, the users can set the text width, and not have to 
worry about manually formatting it. Long "words" like URLs would still 
get to be on one line, and we avoid showing annoying dialogs.

-- 
Regards,
Pratyush Yadav

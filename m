Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9989C20248
	for <e@80x24.org>; Thu,  4 Apr 2019 08:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDDIUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 04:20:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56454 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfDDIUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 04:20:53 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hBxc8-0007jb-7G; Thu, 04 Apr 2019 17:20:48 +0900
Date:   Thu, 4 Apr 2019 17:20:48 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        David Kastrup <dak@gnu.org>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190404082048.bocecevbaqfgfmsu@glandium.org>
References: <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net>
 <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
 <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
 <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
 <20190312100237.GA20471@ash>
 <CACsJy8C=1dj-1T=5dt92LK5_Ario_YL2hkQWpi2dkhXyYY=_Hw@mail.gmail.com>
 <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com>
 <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 09:56:35AM +0200, Christian Couder wrote:
> Hi,
> 
> On Thu, Apr 4, 2019 at 3:15 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I've been studying the codebase and looking for older emails in the ML
> > that discussed what I want to propose as my GSoC project. In
> > particular, I found a thread about slow git commands on chromium, so I
> > reached them out at chromium's ML to ask if it's still an issue. I got
> > the following answer:
> >
> > On Wed, Apr 3, 2019 at 1:41 PM Erik Chen <erikchen@chromium.org> wrote:
> > > Yes, this is absolutely still a problem for Chrome. I filed some bugs for common operations that are slow for Chrome: git blame [1], git stash [2], git status [3]
> > > On Linux, blame is the only operation that is really problematic. On macOS and Windows ... it's hard to find a git operation that isn't slow. :(
> 
> Nice investigation. About git status I wonder though if they have
> tried the possible optimizations, like untracked cache or
> core.fsmonitor.

Note that one known issue on macOS specifically on large repos is that
the number of files explodes the inode cache in the kernel, and lstat
becomes slow.

e.g. https://groups.google.com/a/chromium.org/forum/#!topic/chromium-dev/p9U4jqz8kxo

Mike

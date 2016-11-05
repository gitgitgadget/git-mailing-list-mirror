Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CAD2021E
	for <e@80x24.org>; Sat,  5 Nov 2016 11:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbcKELI4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 07:08:56 -0400
Received: from ozlabs.org ([103.22.144.67]:35017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcKELI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 07:08:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3t9wtq1rzKz9vDx; Sat,  5 Nov 2016 22:08:51 +1100 (AEDT)
Date:   Sat, 5 Nov 2016 22:08:45 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Markus Hitter <mah@jump-ing.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk: avoid obscene memory consumption
Message-ID: <20161105110845.GA4039@fergus.ozlabs.ibm.com>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
 <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 03:45:09PM -0700, Stefan Beller wrote:
> On Fri, Nov 4, 2016 at 12:49 PM, Markus Hitter <mah@jump-ing.de> wrote:
> >
> > Hello all,
> 
> +cc Paul Mackeras, who maintains gitk.

Thanks.

> >
> > after Gitk brought my shabby development machine (Core2Duo, 4 GB RAM, Ubuntu 16.10, no swap to save the SSD) to its knees once more than I'm comfortable with, I decided to investigate this issue.
> >
> > Result of this investigation is, my Git repo has a commit with a diff of some 365'000 lines and Gitk tries to display all of them, consuming more than 1.5 GB of memory.
> >
> > The solution is to cut off diffs at 50'000 lines for the display. This consumes about 350 MB RAM, still a lot. These first 50'000 lines are shown, followed by a copyable message on how to view the full diff on the command line. Diffs shorter than this limit are displayed as before.

That sounds reasonable.

> 
> Bikeshedding: I'd argue to even lower the number to 5-10k lines.

I could go with 10k.

> 
> >
> > To test the waters whether such a change is welcome, here's the patch as I currently use it. If this patch makes sense I'll happily apply change requests and bring it more in line with Git's patch submission expectations.
> 
> I have never contributed to gitk myself,
> which is hosted at git://ozlabs.org/~paulus/gitk
> though I'd expect these guide lines would roughly apply:
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Paul.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA01C1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeDVUI2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:08:28 -0400
Received: from ikke.info ([178.21.113.177]:43882 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753438AbeDVUI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:08:28 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2018 16:08:27 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 201B74400C6; Sun, 22 Apr 2018 21:59:24 +0200 (CEST)
Date:   Sun, 22 Apr 2018 21:59:24 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Andrew Wolfe <andrew@schemaczar.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Git enhancement request - checkout (clone) set modified dates to
 commit date
Message-ID: <20180422195923.GA10082@alpha>
References: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
 <20180422180912.GK14631@genre.crustytoothpaste.net>
 <1FCE6958-FC75-4A9B-88A3-05AE991815E4@schemaczar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FCE6958-FC75-4A9B-88A3-05AE991815E4@schemaczar.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 03:01:10PM -0400, Andrew Wolfe wrote:
> Hi Brian,
> 
> Not completely sure what you're saying.  If the files on master are
> not changed, the changed files' commit timestamps will be older than
> the branch commit timestamps.
> 
> However, if I check out master after committing to a branch, the
> modifications will necessarily disappear because they haven't been
> committed to master.  Instead, under my proposal, each will get the
> timestamp of its prior commit.
> 

Say I build the project while on a certain branch. Then I checkout a
different branch and build again. You would expect that the targets of
every source file that have changed are rebuilt.

When you would restore the timestamp back to the commit timestamp, the
timestamp will be older then the target, and make will not rebuild it,
leaving you with outdated build targets.

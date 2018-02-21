Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3FEB1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeBUVJ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:09:58 -0500
Received: from accordion.employees.org ([198.137.202.74]:19289 "EHLO
        accordion.employees.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeBUVJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:09:46 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Feb 2018 16:09:46 EST
Received: by accordion.employees.org (Postfix, from userid 1736)
        id A83EC2D51A4; Wed, 21 Feb 2018 21:03:39 +0000 (UTC)
Date:   Wed, 21 Feb 2018 21:03:39 +0000
From:   Derek Fawcus <dfawcus+lists-git@employees.org>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180221210339.GA43094@accordion.employees.org>
Mail-Followup-To: Peter Backes <rtc@helen.PLASMA.Xg8.DE>,
        git@vger.kernel.org
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 10:22:36PM +0100, Peter Backes wrote:
> 
> It is pretty annoying that git cannot, even if I know what I am doing, 
> and explicitly want it to, preserve the modification time.

The use case I've come across where it would be of value is for code
archeology, either importing a bunch of tar files, or importing a
repo from some other VCS.

There preserving the mod times can be useful when one is subsequently
figuring out what changed, and the scope of the 'commits' is too big
(i.e. the granularity of the tar files themselves).

e.g. initial commits are done on tar boundaries, but one may try to
figure out individual changes from a ChangeLog file.  I've done this
a couple of times, but to date it has required keeping the untarred
trees around (or a timestamp list file from each tree), in addition
to the git repro in to which one is then synthesizing smaller commits.

DF

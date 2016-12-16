Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82EC1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 15:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761964AbcLPPm3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 16 Dec 2016 10:42:29 -0500
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:60759 "EHLO
        mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761961AbcLPPm2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Dec 2016 10:42:28 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Dec 2016 10:42:28 EST
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta.aluminati.local (Postfix) with ESMTP id A1095C0431;
        Fri, 16 Dec 2016 15:22:55 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 9A62320F0C;
        Fri, 16 Dec 2016 15:22:55 +0000 (GMT)
X-Quarantine-ID: <wuqYAYapzpxW>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wuqYAYapzpxW; Fri, 16 Dec 2016 15:22:52 +0000 (GMT)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id EA05061E2C;
        Fri, 16 Dec 2016 15:22:50 +0000 (GMT)
Date:   Fri, 16 Dec 2016 15:22:27 +0000
From:   John Keeping <john@keeping.me.uk>
To:     Larry Minton <larry.minton@autodesk.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Is there a way to have local changes in a branch 'bake' while
 working in different branches?
Message-ID: <20161216152227.GA1783@john.keeping.me.uk>
References: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 08:14:58PM +0000, Larry Minton wrote:
> My question:
> 
> Let's say I have a code change that I want to 'bake' for a while
> locally, just to make sure some edge case doesn't pop up while I am
> working on other things.  Is there any practical way of doing that?  I
> could constantly merge that 'bake me' branch into other branches as I
> work on them and then remove those changes from the branches before
> sending them out for code review, but sooner or later pretty much
> guaranteed to screw that up....

I wrote a tool [1] a while ago to manage integration branches so I use a
personal integration branch to pull together various in-progress
branches.

It means you can keep each topic in its own branch but work/test on top
of a unified branch by running:

	git integration --rebuild my-integration-branch

whenever you change one of the topic branches.

I also use the instruction sheet to keep track of abandoned topics that
I might want to go back to but which are currently in a broken state,
you can see an example of that in my CGit integration branch [2].


[1] http://johnkeeping.github.io/git-integration/
[2] https://github.com/johnkeeping/cgit/blob/d01ce31ed3dfa9b05ef971464da2af5b9d6f2756/GIT-INTEGRATION-INSN

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: More merge-recursive woes
Date: Wed, 13 Dec 2006 15:34:10 -0500
Message-ID: <20061213203410.GB32568@spearce.org>
References: <20061213073639.GA9289@spearce.org> <Pine.LNX.4.63.0612131526180.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 20:34:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612131526180.3635@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34231>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guanx-0008Vg-OJ for gcvg-git@gmane.org; Wed, 13 Dec
 2006 21:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750728AbWLMUeO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWLMUeO
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 15:34:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59563 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750728AbWLMUeN (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 15:34:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Guanj-0007Qk-NM; Wed, 13 Dec 2006 15:34:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 22C9A20FB6E; Wed, 13 Dec 2006 15:34:10 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 13 Dec 2006, Shawn Pearce wrote:
> 
> > Bug #1: If one branch renames a file which existed in the merge base, 
> > when we merge that change into a different branch the old version of the 
> > file is not deleted from the working directory.  The attached test 
> > script shows this ("BAD: A still exists in working directory").
> 
> You miss a ":" at the end of the test script, BTW.
>
> This bug is fixed by your patch, which makes remove_file() update the 
> working directory in the last stage.

Yes; and if you noticed this message got hung up in the email
system while I found the bug, fixed the bug, and replied to your
correction of the fix.  And I also fixed the test script along
the way.  Silly email systems holding messages.  *sigh*
 
> > Bug #2: In that horrible repository that I have where I ran into the
> > empty tree missing bug I now have a pair of commits which when merged
> > together cause git-merge-recursive to go into an infinite loop,
> > or least burn CPU for hours on end without doing squat.  I have
> > not been able to get enough data to even write a good analysis
> > of it yet.  I'll try to do that this week, as I cannot share the
> > repository itself.  It just happens to be two new commits along
> > the same two branches however.  :-(
> 
> Could you please send me the rev-list output for this test case?

I'm actually going to go back in later tonight to try and figure
this one out.  Whatever data I get I'll be sure to include the
rev-list --parents output from this case as well; unless I can
craft a really small test case which causes the same infinite loop.

-- 

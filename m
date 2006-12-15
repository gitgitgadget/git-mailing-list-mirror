X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 19:42:25 -0500
Message-ID: <20061215004225.GJ26202@spearce.org>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com> <20061214194636.GO1747@spearce.org> <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de> <20061214232936.GH26202@spearce.org> <Pine.LNX.4.63.0612150105450.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:42:42 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612150105450.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34457>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv19o-0001c8-3c for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932163AbWLOAmd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWLOAmd
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:42:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45392 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932163AbWLOAmc (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:42:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv19V-0003f6-98; Thu, 14 Dec 2006 19:42:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2C6C420FB65; Thu, 14 Dec 2006 19:42:26 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 14 Dec 2006, Shawn Pearce wrote:
> 
> > I'm OK with a small increase in packfile size as a result of slightly 
> > less optimal delta base selection on the really large binary files due 
> > to something like the above, but 10x is insane.
> 
> Not if it is a server having to do all the work. Along with all the work 
> for all other clients. When you do a fetch, you really should be nice to 
> the serving side.

Yes, that's true.

But I fail to see what that has to do with the part you quoted above.
A 1% increase in transfer bandwidth may be better for a server if
it halves the CPU usage or disk IO usage if the server has more
bandwidth than those available; likewise a 1% decrease in transfer
bandwidth may be better for a server if it has lots of CPU to spare
but very little network bandwidth available.

Since every server is different its not like we can tune for just
one of those cases and cross our fingers.

-- 

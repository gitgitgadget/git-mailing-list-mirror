X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bug in merge-recursive in virtual commit corner case
Date: Thu, 7 Dec 2006 14:24:01 -0500
Message-ID: <20061207192401.GB12143@spearce.org>
References: <20061207083531.GA22701@spearce.org> <Pine.LNX.4.63.0612071636030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:24:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612071636030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33609>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOqp-0005YL-Ew for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163221AbWLGTYI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163220AbWLGTYH
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:24:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34316 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937999AbWLGTYE (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:24:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsOqa-0003Jj-IU; Thu, 07 Dec 2006 14:23:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DF47220FB6E; Thu,  7 Dec 2006 14:24:01 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 7 Dec 2006, Shawn Pearce wrote:
> 
> > So I managed to create a fairly complex set of branches which are all
> > merged back against each other at various points in time.  Two of
> > them have 3 merge bases according to git-merge-base.  Tonight I
> > tried to merge them together, but received the following wonderful
> > error from git-merge-recursive:
> > 
> >   fatal: unable to read source tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> > 
> > For those in the know, that's the empty tree.  This particular 
> > repository does not have the empty tree anywhere in it, which is why we 
> > can't read the object: it doesn't exist, and shouldn't exist.
> 
> I think there is something else wrong. If you have three merge bases, I do 
> not see how you could get into that particular code path.

Arrgh.  I can redo the merge and try to debug it myself; maybe I
can at least get enough details about what's going on to create a
dummy repo which exhibits the same behavior.
 
> Any possibility for me to have a private look at your repo?

No, unfortunately for me (I wish I could let you debug this!).
Far too many legal issues are involved.  There is possible jail
time on my part for sharing any of the files in there...  ;-)

Although Junio mentioned he recently saw something like this in
git.git when he merged in your xdl_merge() code.  I wonder if its
the same issue.

-- 

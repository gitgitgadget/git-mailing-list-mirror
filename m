X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Stop telling users we are 'defaulting to local storage area'.
Date: Thu, 14 Dec 2006 21:25:43 -0500
Message-ID: <20061215022543.GL26202@spearce.org>
References: <20061214230902.GA26506@spearce.org> <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 02:25:54 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34462>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2lj-00036k-NM for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965038AbWLOCZt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWLOCZt
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:25:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49579 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965038AbWLOCZs (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:25:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv2lR-0007uN-Ap; Thu, 14 Dec 2006 21:25:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3F97620FB65; Thu, 14 Dec 2006 21:25:43 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
> > It also breaks from our normal behavior of not printing
> > anything if the command was successful.

> I really don't think this is a good rule.
> 
> NOte that I'm not against commands that are silent by default.  I really 
> think that git-add should remain silent on success by default when 
> successful.
> 
> But the rule of thumb should be about the importance of the action 
> performed by the command.
> But git-init-db is really important.  

A very reasonable argument, butchered for my evil quoting needs.  :-)

If we want to keep letting git-init-db output something, then
the output should be a lot more meaningful to the average English
speaking new Git user than "defaulting to local storage area".

E.g.:

  $ git init-db
  Initialized empty Git repository in .git/

would probably make a lot more sense to new and expert users alike.
I'm fine with the above form, I just think that the message we have
now could benefit from being sent to the land from which there is
no return, or be rewritten...

BTW, I almost also submitted a patch to remove the "Committing
initial tree ..." message in git-commit-tree, but thought twice about
it as committing an initial tree is sort of an important difference
from normal activity that we should highlight it somehow...

-- 

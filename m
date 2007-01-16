From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 16:22:19 -0500
Message-ID: <20070116212219.GA29434@spearce.org>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD383E.50105@midwinter.com> <eojf73$1f4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 22:23:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vmB-0006di-TH
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXAPVXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXAPVXS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:23:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53288 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXAPVXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:23:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6vl7-0001W3-Q2; Tue, 16 Jan 2007 16:22:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 216D220FBAE; Tue, 16 Jan 2007 16:22:19 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eojf73$1f4$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36968>

Jakub Narebski <jnareb@gmail.com> wrote:
> Steven Grimm wrote:
> > Okay, great, that is certainly an improvement over what I thought was 
> > happening. But it won't work if you had to manually resolve a conflict 
> > during the rebase, yes? In that case the diffs would presumably not match.
> 
> Then git-rerere would help, I think.

No, because rerere only helps to recall a prior conflict resolution.
Here Steven is talking about having rebase intelligently realize that
the upstream has accepted a patch, but did so by modifying it first.
There really isn't a solution to the problem.

pg tried to do this by applying several patches at once until
something matched.  If the upstream fixed a line like "a=b" to
be "a = b" then this would *never* match, and pg would abort.
StGIT runs the patches backwards.  A much smarter approach then
what pg tried to do, but again, "a = b" would never match.

-- 
Shawn.

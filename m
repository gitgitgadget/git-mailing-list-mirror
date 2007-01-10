From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 20:07:25 -0500
Message-ID: <20070110010725.GI30023@spearce.org>
References: <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org> <20070110003433.GH30023@spearce.org> <20070110010312.GA25265@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:07:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RwZ-0002bj-En
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXAJBHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXAJBHb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:07:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37906 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbXAJBHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:07:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4Rvx-0007ZF-Hk; Tue, 09 Jan 2007 20:07:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1F21120FBAE; Tue,  9 Jan 2007 20:07:26 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20070110010312.GA25265@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36458>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Tue, Jan 09, 2007 at 07:34:33PM -0500, Shawn O. Pearce wrote:
> > Unfortunately .git/logs/HEAD wouldn't be created by default as its
> > not under refs/heads or refs/remotes.  Though it could be made to be
> > on by default, in which case it would only log changes while HEAD
> > is detached.  If HEAD is attached to a branch then .git/logs/HEAD
> > wouldn't be appended to (or even created), while the branch's own
> > log is still appended to.
> 
> That would also provide all the needed "safety valve" on git checkout,
> wouldn't it?  Since you could always recover from
> 
> 	git checkout v1.4.0
> 	git commit -m -a 'some changes'
> 	git checkout 41.2.0
> 
> by looking back through the reflog for HEAD.

Yes.  Then that removes my desire for a safety check in reset,
(which Linus doesn't want) thereby making both of us happy.

-- 
Shawn.

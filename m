From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 20:40:00 -0500
Message-ID: <20070110014000.GA30765@spearce.org>
References: <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org> <20070110003433.GH30023@spearce.org> <Pine.LNX.4.64.0701092014390.4964@xanadu.home> <7vwt3vfzd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SRp-0001cw-7n
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbXAJBkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXAJBkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:40:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38930 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXAJBkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:40:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4SRU-0003Kc-So; Tue, 09 Jan 2007 20:39:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B3B820FBAE; Tue,  9 Jan 2007 20:40:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt3vfzd1.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36466>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> >> Unfortunately .git/logs/HEAD wouldn't be created by default as its
> >> not under refs/heads or refs/remotes.  Though it could be made to be
> >> on by default, in which case it would only log changes while HEAD
> >> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
> >> wouldn't be appended to (or even created), while the branch's own
> >> log is still appended to.
> >
> > Is this worth the trouble and complexity?  After all detached heads are 
> > not meant to be used for serious development.
> 
> I agree.

  git checkout v1.4.0
  # dang, need some local fix
  git commit -m tmpfix -a
  git reset --hard v1.2.0
  git reset --hard v1.3.0
  # dang, need that local again fix - where is it?

It ain't in ORIG_HEAD.  Its now only findable by
fsck-objects/lost-found.  But if you reflog a detached
HEAD its there as HEAD@{2}.

Maybe its not really worth it.  But it almost seems like it would
come free if we always use update-ref like we're supposed to...

-- 
Shawn.

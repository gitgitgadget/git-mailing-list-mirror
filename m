From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 11:03:15 -0400
Message-ID: <20060420150315.GB31198@spearce.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 17:03:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWagm-0007Jw-52
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 17:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDTPDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 11:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWDTPDV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 11:03:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5286 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750967AbWDTPDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 11:03:20 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWaga-0001Vc-OB; Thu, 20 Apr 2006 11:03:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0C7A320FBB4; Thu, 20 Apr 2006 11:03:16 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18975>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Thu, 20 Apr 2006, Shawn Pearce wrote:
> 
> > Apparently I have created a repository which v1.2.3 packs about 50%
> > smaller than 'next' does:
> > 
> >   v1.2.3 (tag):
> >    60M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> > 
> >   1.2.3.gf3a4 (an older 'next'):
> >   128M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> > 
> >   1.3.0.rc4.g8060 (a fairly recent 'next'):
> >   118M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> > 
> > Repeated packing with 1.3.0.rc4.g8060 doesn't seem to change the
> > size of the pack file, its pretty consistent at 118M.
> 
> First try "git repack -a -d f", where the "-f" is the magic one.
> 
> Without the -f, git repack will re-use old pack information, which is much 
> much faster, but not as space-efficient.
> 
> If that doesn't help, it might be time to look at the actual repo, but try 
> that first.

So with 1.3.0.g56c1 "git repack -a -d -f" did worse:

  Total 46391, written 46391 (delta 6649), reused 39742 (delta 0)
  129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

I just tried -f on v1.2.3 and it did slightly better then before:

  Total 46391, written 46391 (delta 6847), reused 38012 (delta 0)
   59M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

-- 
Shawn.

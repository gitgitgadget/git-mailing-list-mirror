From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Sat, 20 May 2006 21:01:29 -0400
Message-ID: <20060521010129.GB7179@spearce.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech> <20060519092136.GN22257@spearce.org> <Pine.LNX.4.64.0605192006400.6713@iabervon.org> <7vy7wxfs7v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605192116360.6713@iabervon.org> <Pine.LNX.4.64.0605191853570.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcKQ-0001hG-RR
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEUBBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEUBBj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:01:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:25806 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932294AbWEUBBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:01:38 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FhcJs-0004Cm-Px; Sat, 20 May 2006 21:01:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A357B212691; Sat, 20 May 2006 21:01:29 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605191853570.10823@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20416>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Fri, 19 May 2006, Daniel Barkalow wrote:
> > 
> > I guess I did forget that it sticks around. So you have to be doing 
> > something somewhat more complicated, like fetching the latest versions of 
> > multiple topic branches.
> 
> I actually don't think it's at all unlikely that I'd start using this.

Hey, if its useful.  :-) If its not then I'm doing something
wrong here...
 
[snip]
> I'm not entirely sure about the syntax, though. It ends up being pretty 
> command-line-unfriendly. The "gitk ORIG_HEAD.." thing is fairly easy to 
> type, but typing
> 
> 	gitk 'master@{2 hours ago}'..
> 
> on a Finnish keyboard (yeah, that's what I still use) is "interesting", 
> since all of '@', '{' and '}' are complex characters (AltGr + '2', AltGr + 
> '7' and AltGr + '0' respectively), and you have to remember the quoting.

Wow.  So what you are saying is writing any sort of C code must be
rather painful.  :-)

I received a suggestion of using ' (single quote) rather than {
as the quoting character.  I didn't make the quoting character
optional as I realized users were likely to forget they needed it
on date specs which contain ':', so I just made them required to
keep things consistent at all times.  Further {} won out over ''
as {} is also used with the ^ operator (e.g. v1.3.3^{tree}).

> Not that I see any obvious better syntax. Although allowing a shorthand 
> like "@2.hours.ago" for "current branch, at given date" might help a 
> bit, at least that wouldn't need quoting:
> 
> 	gitk @2.hours.ago..

The empty prefix for `HEAD` is simple.  The '.' part would need to
be fixed in approxidate() (and thus --since would also benefit).
Omitting the {} might be OK but see above...

-- 
Shawn.

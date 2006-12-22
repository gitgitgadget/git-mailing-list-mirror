From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Fri, 22 Dec 2006 00:21:56 -0500
Message-ID: <20061222052156.GA15548@spearce.org>
References: <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org> <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org> <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org> <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx> <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net> <87d56cirs8.wl%cworth@cworth.org> <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 06:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxcrD-0007DM-6n
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 06:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945947AbWLVFWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 00:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945948AbWLVFWG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 00:22:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945947AbWLVFWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 00:22:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gxcr0-0000ex-V8; Fri, 22 Dec 2006 00:21:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6004520FB65; Fri, 22 Dec 2006 00:21:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35131>

Junio C Hamano <junkio@cox.net> wrote:
> And it is not just limited to adding the contents of a path that
> happened to be told git for the first time.  Adding the contents
> of a path that was known to git also happens only when it is in
> a presentable good state.  So running "git diff" and not seeing
> what I added before is a GOOD THING.

Yes!

Sadly it has taken me 12 months of working with Git to get
comfortable enough with that concept.

Actually it clicked once I realized that 'update-index' was actually
creating the blobs in the ODB and not 'write-tree'.  Prior to that
"click" going off in my grey matter I always felt that Git screwed
up when I did:

	$ vi foo.c
	$ git update-index foo.c
	$ git diff
	# what the ? where are my changes?

I now make quite heavy use of the index even when hacking on code,
and not just during merges.  But I wasn't like that just 5 months
ago...

-- 
Shawn.

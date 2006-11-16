X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 23:26:39 -0500
Message-ID: <20061116042639.GA23026@thunk.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 04:26:57 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31558>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYpp-0004JF-BM for gcvg-git@gmane.org; Thu, 16 Nov
 2006 05:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161719AbWKPE0m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 23:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161720AbWKPE0m
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 23:26:42 -0500
Received: from THUNK.ORG ([69.25.196.29]:61064 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1161719AbWKPE0l (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 23:26:41 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GkYt4-0006fE-Ux; Wed, 15 Nov 2006 23:30:07 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GkYpj-0003XY-IJ; Wed, 15 Nov 2006
 23:26:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 12:40:43PM -0800, Linus Torvalds wrote:
> And yes, this is why you should NOT try to use the same naming as "hg", 
> for example. Last I saw, hg still didn't even have local branches, To 
> mercurial, repository == branch, and that's it. It was what I came from 
> too, and I used to argue for using git that way too. I've since seen the 
> error of my ways, and git is simply BETTER. 

Actually, that's not true.  Mercurial has local branches, just as git
does.  Some people choose not to *use* this particular feature, and
use the BK style repository == branch, but that's mainly because it's
conceptually easy for them, and a number of BK refugees are very
happily using Hg.  

It's probably because of the BK refugee population that after you do
an hg pull, it will warn you that you need to do an "hg update" in
order to merge the working directory up to the latest version that was
just pulled --- and this change was made precisely because Hg supports
local branches, and merging with the current branch isn't always the
right thing, unlike with BK.

> And the concept of local branches is exactly _why_ you have to have 
> separate "fetch" and "pull", but why you do _not_ need a separate "merge" 
> (because "pull ." does it for you).

It's just that the semantics are different, and many developers have
to use multiple DSCM's, depending on what project they happen to be
developing on.  So the reality is that there are people who have to
use bzr, git, and hg, all at the same time.  And while eventually
newbies will figure out and remember that "git pull ." == "merge", the
naming is simply confusing, that's all.  (What does "pull" have to do
with "merge"?  It's not at all obvious.)  

For somoene who uses git full-time, and to the exclusion of all other
systems, I'm sure it's not a problem at all.
	

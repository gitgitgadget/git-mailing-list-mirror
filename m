From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Tue, 24 Oct 2006 01:44:08 -0400
Message-ID: <20061024054408.GA9724@spearce.org>
References: <11616396262982-git-send-email-hjemli@gmail.com> <20061023215506.GB8344@spearce.org> <7vfydewqbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 07:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcF5D-0001TB-EF
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 07:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWJXFoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 01:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWJXFoM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 01:44:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34009 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752069AbWJXFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 01:44:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GcF57-0007Su-SG; Tue, 24 Oct 2006 01:44:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7D9F421269E; Tue, 24 Oct 2006 01:44:08 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfydewqbb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29925>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Lars Hjemli <hjemli@gmail.com> wrote:
> > [snip]
> >> ---
> >>  Makefile         |    3 +-
> >>  builtin-branch.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  builtin.h        |    1 +
> >>  git-branch.sh    |  131 --------------------------------
> >>  git.c            |    1 +
> >>  5 files changed, 221 insertions(+), 132 deletions(-)
> > [snip]
> >> diff --git a/git-branch.sh b/git-branch.sh
> >> deleted file mode 100755
> >> index 4379a07..0000000
> >> --- a/git-branch.sh
> >> +++ /dev/null
> >> @@ -1,131 +0,0 @@
> > [snip 131 lines]
> >
> > Aside from compatability with non-Git tools...
> >
> > Wouldn't it make more sense to just include the full SHA1 of the
> > file we are deleting rather than the entire 131 line negative diff?
> 
> How would you do "git apply -R" on something like that?

Uh, you have the full SHA1 in the index line.  So you just have to
reattach that blob to the named path...  pretty simple actually.

Of course this is yet another code path in apply and as Petr pointed
out on this same thread its nice to know what you are deleting so
you can compare it to what else is changing in the same patch... so
this suggestion of mine is probably just a waste of bytes.

-- 
Shawn.

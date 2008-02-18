From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
Date: Mon, 18 Feb 2008 11:33:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181132050.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site> <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site> <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org> <alpine.LSU.1.00.0802171816150.30505@racer.site> <alpine.LSU.1.00.0802171906590.30505@racer.site>
 <7vy79ir79u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:34:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4GV-0001ae-Cm
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915AbYBRLd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757798AbYBRLd4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:33:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:41157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754108AbYBRLdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:33:55 -0500
Received: (qmail invoked by alias); 18 Feb 2008 11:33:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 18 Feb 2008 12:33:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tiz5x9h9tT+gIwXrob6tzMp99ijXrruSa6aW2VV
	/9nx1EBf5X3E3I
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy79ir79u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74266>

Hi,

On Mon, 18 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When a merge conflicts, there are often less than three common lines 
> > between two conflicting regions.
> >
> > Since a conflict takes up as many lines as are conflicting, plus three 
> > lines for the commit markers, the output will be shorter (and thus, 
> > simpler) in this case, if the common lines will be merged into the 
> > conflicting regions.
> >
> > This patch merges up to three common lines into the conflicts.
> 
> I can give immediate positive feedback to this.
> 
> When I rebuilt "next" last night, I considered rebasing its constituent 
> branches while I was at it (I ended up not doing that as I felt it was 
> too much).
> 
> The tip of js/reflog-delete used to be at cb97cc9.  Rebasing this on top 
> of any recent master will give you unreadable conflicts in 
> t/t1410-reflog.sh, but with these two patches (but the second one does 
> not have chance to kick in for this particular case) the result is quite 
> obvious and much cleaner.

Great!

Note that the _ALNUM stuff was meant more for discussion, as it only is 
activated for merge-file, not for merge-recursive or blame or all the 
other (indirect) users of xdl_merge().

I am a bit hesitant on activating it, since merging is pretty important, 
after all, and if I break things with it...

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 20:46:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707062044210.4093@racer.site>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
 <Pine.LNX.4.64.0707052320090.14638@iabervon.org> <Pine.LNX.4.64.0707061340350.4093@racer.site>
 <Pine.LNX.4.64.0707061440050.14638@iabervon.org> <Pine.LNX.4.64.0707061958540.4093@racer.site>
 <Pine.LNX.4.64.0707061514090.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:53:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6tsD-0002dy-L8
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 21:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbXGFTxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759940AbXGFTxq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 15:53:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:38281 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757739AbXGFTxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 15:53:45 -0400
Received: (qmail invoked by alias); 06 Jul 2007 19:53:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 06 Jul 2007 21:53:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iy1Rbktnizw1/LXNMAYMqk4vXesuax6atBeSmX1
	jgDbo+zkbWgUH6
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707061514090.6977@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51784>

Hi,

On Fri, 6 Jul 2007, Daniel Barkalow wrote:

> On Fri, 6 Jul 2007, Johannes Schindelin wrote:
> 
> > On Fri, 6 Jul 2007, Daniel Barkalow wrote:
> > 
> > > On Fri, 6 Jul 2007, Johannes Schindelin wrote:
> > > 
> > > > Related, but not identical, is the problem illustrated in 
> > > > http://thread.gmane.org/gmane.comp.version-control.git/49888
> > > > 
> > > > IMHO there is a bug. IIUC git push first looks for common ref 
> > > > names on the local and remote side (yes, refs/remotes are excluded 
> > > > since v1.5.3-rc0~9, but the underlying problem is still there). 
> > > > Then it pushes them. But here, something seems to have gone wrong: 
> > > > refs/remotes/origin/HEAD is a symref. And the corresponding ref is 
> > > > updated. Should git-push not just _not_ update symrefs?
> > > 
> > > I believe this actually have nothing to do with git-push; it's 
> > > actually git-receive-pack and maybe git-send-pack. Probably 
> > > git-receive-pack shouldn't list symrefs at all, or should somehow 
> > > report them as links so that they can be compared as links. The only 
> > > refs that git-push itself updates are tracking refs on the local 
> > > side for refs on the remote side which were updated. In the report, 
> > > the reporter had (obviously) not configured any local tracking refs 
> > > for the remote's tracking refs.
> > 
> > Sorry, I think I did not make myself clear. The updates refs were 
> > _local_ refs. And they _were_ symrefs.
> 
> No, no local refs were updated. This would have given the message "Also 
> local refs/remotes/origin/HEAD", which wasn't there. What was updated 
> was tracking refs on the remote (which were created as local tracking 
> refs when somebody was running git commands local to the repository 
> which, for the failing command, was remote). The logic for updating 
> local refs on a push was not used at all in this case, according to the 
> output in the message you linked to.

Okay, I misunderstood, then.

Sorry for the noise,
Dscho

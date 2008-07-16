From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 01:05:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807170100320.4318@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJG4P-0001pW-Dp
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 01:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239AbYGPXEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759210AbYGPXEm
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 19:04:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:55488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759155AbYGPXEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 19:04:42 -0400
Received: (qmail invoked by alias); 16 Jul 2008 23:04:40 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp065) with SMTP; 17 Jul 2008 01:04:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HrZdZB37HlR5aFSmvuWOLUwjFsn9eJflJLG5KFD
	pXSdegw2g3pRdJ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88779>

Hi,

On Wed, 16 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Am I the only one who deems teaching plumbing to users ("I like it raw!  
> > So I teach it the same way!") harmful?
> 
> I think that justification is harmful.
> 
> More productive way to think about it is to identify cases where we 
> _need_ to go down to combination of the plumbing commands in our daily 
> workflow, with today's command set.  That would give us a good 
> indication that some Porcelain may need to be enhanced.
> 
> An example. I find myself running "git read-tree -m -u $another_state" 
> while redoing a series inside a "rebase -i" session to move commit 
> boundaries.  There may need an insn that says "use that tree" instead of 
> "edit" and running "read-tree -m -u" by hand.  This does not bother me 
> too much, but there probably are other examples.
> 
> Another example.  I often run "git ls-files -u" while looking at which 
> paths are conflicting.  ls-files is classified as plumbing, but it does 
> not bother me as much as having to see the staged long object names in 
> this output.  Other people, however, might find it yucky, and we might 
> want "git merge --unmerged" or something that lists the paths (and only 
> paths, no stage information) that still have conflicts.

I agree that if you know Git internals -- and you and me do -- it comes in 
_right_ handy to know the 100+ commands with many options by heart.

However, my point was about telling users, especially new ones.

For example, I would _never_ suggest the following workflow to a n00b 
because it would be confusing:

	$ tar xvf <xyz>
	<try to compile>
	<fix a compile error>
	<fix other things>
	<oh, I could contribute the fixes!>
	$ git init
	$ git remote add -f origin <url>
	$ git read-tree <that-tag>
	$ git status
	$ git add -p
	$ git commit -s
	<repeat until there are no changes left>
	$ git rebase -i origin/master
	$ git format-patch -n origin/master

Even if this is something I did at least a handfull times myself.

Ciao,
Dscho

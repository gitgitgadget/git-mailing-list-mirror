From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 16:00:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101558290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0608100634j4f82d486nd8ba6dd3ac85b0e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 16:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBB5W-00026Q-3y
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 16:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWHJOAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 10:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWHJOAi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 10:00:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:7082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161250AbWHJOAh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 10:00:37 -0400
Received: (qmail invoked by alias); 10 Aug 2006 14:00:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 10 Aug 2006 16:00:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608100634j4f82d486nd8ba6dd3ac85b0e7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25184>

Hi,

On Thu, 10 Aug 2006, Alex Riesen wrote:

> On 8/10/06, Junio C Hamano <junkio@cox.net> wrote:
> >   - A new merge strategy, merge-recur, which is a rewrite of
> >     merge-recursive in C, by Johannes and Alex.
> 
> It still has problems devouring that monster merge I have (~20k entries,
> with around 40 changed in the other branch, around 100 revs ago. Big
> binary files involved. Renames and copies).
> Perfomance is nowhere near usable: ~20min on Windows/3GHz/2Gb,
> ~4Min on Linux/1.4GHz/384Mb ;) I agree that Linux is much more bearable
> but 4Min is still too much (especially comparing to that "stupid" resolve).
> 
> I noticed that it spends a lot of time finding renames (diffcore_std,
> in particular).

My next plans -- after making sure that merge-recursive is accurate 
(enough) -- was to use oprofile to find the expensive spots.

> Why doesn't it take that much time for "diff-tree -M -r base head1" +
> "diff-tree -M -r base head2", I wonder...? (~30 sek, for that windows box).

Could it be that it has many common ancestors? You have to do the rename 
handling twice for each merge...

> Sorry, I can't provide the tree. I suppose Mozilla tree can be compared
> to that thing, when it becomes available. Linux kernel is no good for
> reproducing this problem: it's too clean and compact.

The beauty of Open Source: since everyone can see your mess, you tend to 
be tidier...

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit: merge, stat
Date: Tue, 14 Aug 2007 10:22:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708141013540.25989@racer.site>
References: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de>
 <Pine.LNX.4.64.0708131743360.25989@racer.site> <7vzm0vfbw0.fsf@assigned-by-dhcp.cox.net>
 <AAF0E632-AC7D-49E0-A332-96F78EABB1F6@zib.de> <7vfy2nf67h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 11:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKscr-0000xr-B4
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 11:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756967AbXHNJXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 05:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756940AbXHNJXH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 05:23:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:58034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756891AbXHNJXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 05:23:00 -0400
Received: (qmail invoked by alias); 14 Aug 2007 09:22:58 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 14 Aug 2007 11:22:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5llVAeTT5mrQFtdwWzKhG39GQMvz9WdnHHGYFIp
	VfeDYe3ctg43Pj
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy2nf67h.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55820>

Hi,

On Mon, 13 Aug 2007, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> >> Wait a minute.
> >>
> >> What does the above "After a 'git merge'" exactly mean?  After a
> >> successful automerge that made a commit, of stopped in the
> >> middle because of conflicts?  I am getting an impression that
> >> Steffen is talking about the former, but if that is the case,
> >> somebody is seriously confused.
> >
> > Yes. I'm talking about a successful merge that made a commit.
> >
> >> When "merge-recursive" with a 3-way file level merge in core
> >> writes the result out to the work tree, it uses a cache entry
> >> that is stat clean (see merge-recursive.c::make_cache_entry(),
> >> refresh option is passed and it calls refresh_cache_entry() to
> >> obtain the cached stat bits).  The traditional "read-tree -m -u"
> >> followed by merge-one-file of course runs "git update-index"
> >> inside merge-one-file script and cleanly merged paths should be
> >> stat clean after a merge.
> >
> > Well, they are not with msysgit. At least not all, or not always.
> > I'm not completely sure about the details, but the problem
> > happens frequently, near to always.
> 
> Johannes, is this something you want me to look at?  I do not
> know how much read-cache.c and other low level routines of
> Windows version deviated from the mainline.

I am reasonably sure that we did not deviate that much in lstat(). And in 
stat() we do not deviate at all; this is provided by mscrt.dll.

Steffen, could you come up with a test script showing the behaviour you 
described?  Then we could test where the problem comes from.

Ciao,
Dscho

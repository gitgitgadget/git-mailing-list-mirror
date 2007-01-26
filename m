From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 10:48:06 +0100
Organization: eudaptics software gmbh
Message-ID: <45B9CE56.D16DFC81@eudaptics.com>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
		<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
		<45B9B80E.E2534F97@eudaptics.com>
		<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
		<45B9C836.728F31EC@eudaptics.com> <7vzm86yw0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:46:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANfX-0000X5-Ek
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbXAZJqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbXAZJqs
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:46:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:16972 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161012AbXAZJqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:46:48 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 263966D9; Fri, 26 Jan 2007 10:46:47 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37827>

Junio C Hamano wrote:
> 
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > Here's my stance on it. Grafts should be a local matter. And they alter
> > the world view, with a pronounciation on *view*. That's why I proposed
> > that only log familiy of commands obey them[*]. And probably rev-list so
> > that gitk et.al. have a way to obey them. And also the ref parser (so
> > that master~20 is what it looks it is). Everything else should disregard
> > grafts: repack, prune, fetch, <transfer>-pack, push etc. No nasty side
> > effects anymore.
> 
> I said you are not agreeing, but I should have said you are not
> understanding.

Oh, I think I understand very well. It may just be that I cannot express
myself that well ;)

I propose that grafts are only about *view*, not database integrity.

There are no tools that manipulate grafts, that would stop the user to
make some blunder; the user has to edit the file *manually*. It is
wrong, wrong, wrong to let such a file dictate database integrity.

> grafts can bring otherwise disconnected commits into the
> altered history, so if you want your log to honor grafts, your
> prune and repack need to be aware of them lest you would not
> lose them.

Sure, if I connect my linux repo with a graft to the historical BK tree,
then toss the ref that pointed to the historical tree, then git prune:
- then currently it won't prune the historical tree
- but under my proposal it would. Silly me. Why did I remove that ref?

-- Hannes

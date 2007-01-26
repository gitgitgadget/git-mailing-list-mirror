From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 01:31:17 -0800
Message-ID: <7vzm86yw0q.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
	<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
	<45B9B80E.E2534F97@eudaptics.com>
	<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
	<45B9C836.728F31EC@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANQY-0001PM-Pi
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbXAZJbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965618AbXAZJbT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:31:19 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64612 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXAZJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:31:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126093118.XWOB19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 04:31:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FlWL1W01R1kojtg0000000; Fri, 26 Jan 2007 04:30:20 -0500
In-Reply-To: <45B9C836.728F31EC@eudaptics.com> (Johannes Sixt's message of
	"Fri, 26 Jan 2007 10:21:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37823>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Here's my stance on it. Grafts should be a local matter. And they alter
> the world view, with a pronounciation on *view*. That's why I proposed
> that only log familiy of commands obey them[*]. And probably rev-list so
> that gitk et.al. have a way to obey them. And also the ref parser (so
> that master~20 is what it looks it is). Everything else should disregard
> grafts: repack, prune, fetch, <transfer>-pack, push etc. No nasty side
> effects anymore.

I said you are not agreeing, but I should have said you are not
understanding.

grafts can bring otherwise disconnected commits into the
altered history, so if you want your log to honor grafts, your
prune and repack need to be aware of them lest you would not
lose them.

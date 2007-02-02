From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 01 Feb 2007 17:11:09 -0800
Message-ID: <7v64alnz2q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	<7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	<20070201215242.GA1775@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCmxP-0006Mo-70
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423051AbXBBBLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423052AbXBBBLM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:11:12 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:47574 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423051AbXBBBLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:11:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202011110.UYKH4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 20:11:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JRB91W00n1kojtg0000000; Thu, 01 Feb 2007 20:11:10 -0500
In-Reply-To: <20070201215242.GA1775@thunk.org> (Theodore Tso's message of
	"Thu, 1 Feb 2007 16:52:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38441>

Theodore Tso <tytso@mit.edu> writes:

> On Thu, Feb 01, 2007 at 01:08:41AM -0800, Junio C Hamano wrote:
>>     [git.git]$ git checkout master
>>     You are not on any branch and switching to branch 'master'
>>     may lose your changes.  At this point, you can do one of two things:
>>      (1) Decide it is Ok and say 'git checkout -f master';
>>      (2) Start a new branch from the current commit, by saying
>>          'git checkout -b <branch-name>'.
>>     Leaving your HEAD detached; not switching to branch 'master'.
>
> How hard would it be to simply simply set a flag once git has entered
> a detached HEAD state, and clear the flag if any git operation has
> modified the repository at all.  If the flag is still set, then
> obviously the repository hasn't changed and so there are no changes
> that could be lost.

Didn't I already point out that you can have a precious
information while on the detached HEAD without making any
commit, and that is the reason why we do not use the
reachability crud from refs when deciding to issue the message?

From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 12:12:45 -0800
Message-ID: <7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
References: <17885.60477.53356.123095@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKJF-0004A1-MK
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXBVUMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXBVUMr
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:12:47 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40690 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbXBVUMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:12:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222201246.IDUH2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:12:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SkCl1W0031kojtg0000000; Thu, 22 Feb 2007 15:12:45 -0500
In-Reply-To: <17885.60477.53356.123095@lisa.zopyra.com> (Bill Lear's message
	of "Thu, 22 Feb 2007 13:17:17 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40378>

Bill Lear <rael@zopyra.com> writes:

> Git "indexing" of commits has a way to "go back":
>
> % git diff HEAD~3
>
> Can I say "all the way back", or "all the way back - 1" somehow?

Sorry, there is no such shorthand, but you could obviously say:

	$ git rev-list --parents HEAD | grep -v ' '

A way to find the root commit seems to be one of the things
people new to git want at least once, once they start futzing
with the tool.  But I suspect that is only because they need
that information to see how the tool works (say "what different
output would I get out of 'git show $commit' for root and other
commits?"), and not because they need that information for any
real life use.

Really, what useful purpose does it serve for you to find out
the root commit, OTHER THAN being able to say "the development
history of this project starts at this commit"?

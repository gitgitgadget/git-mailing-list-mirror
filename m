From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 15:47:37 -0500
Message-ID: <20070222204737.GC18622@fieldses.org>
References: <17885.60477.53356.123095@lisa.zopyra.com> <7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKqn-000135-EC
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXBVUrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXBVUrd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:47:33 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50248 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbXBVUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:47:33 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HKKqn-0007ox-PQ; Thu, 22 Feb 2007 15:47:37 -0500
Content-Disposition: inline
In-Reply-To: <7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40385>

On Thu, Feb 22, 2007 at 12:12:45PM -0800, Junio C Hamano wrote:
> Sorry, there is no such shorthand, but you could obviously say:
> 
> 	$ git rev-list --parents HEAD | grep -v ' '
> 
> A way to find the root commit seems to be one of the things
> people new to git want at least once, once they start futzing
> with the tool.  But I suspect that is only because they need
> that information to see how the tool works (say "what different
> output would I get out of 'git show $commit' for root and other
> commits?"), and not because they need that information for any
> real life use.
> 
> Really, what useful purpose does it serve for you to find out
> the root commit, OTHER THAN being able to say "the development
> history of this project starts at this commit"?

I occasionally want to reference commits not relative to "all the way
back" but to "all the way back on this branch".  So, e.g., what's the
next-to-last commit before "topic" meets up with "origin"?

I can do something like

	git rev-list origin..topic | tail -2 | head -1

but in practice it's faster just to fire up gitk origin.. and
cut-n-paste object id's.

--b.

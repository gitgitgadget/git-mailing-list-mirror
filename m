From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking
	branches
Date: Wed, 7 May 2008 22:25:04 -0400
Message-ID: <20080508022504.GA931@pe.Belkin>
References: <20080508013956.GA24956@midwinter.com> <20080508015806.GA759@pe.Belkin> <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 04:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtvpp-0003SX-8q
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 04:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712AbYEHCZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 22:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbYEHCZK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 22:25:10 -0400
Received: from eastrmmtao106.cox.net ([68.230.240.48]:56082 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbYEHCZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 22:25:07 -0400
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080508022505.ZAPO15722.eastrmmtao106.cox.net@eastrmimpo03.cox.net>;
          Wed, 7 May 2008 22:25:05 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo03.cox.net with bizsmtp
	id NqR41Z00Z0epFYL02qR5kL; Wed, 07 May 2008 22:25:05 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1Jtvoe-0000Fg-Rb; Wed, 07 May 2008 22:25:04 -0400
Content-Disposition: inline
In-Reply-To: <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81501>

On Wed, May 07, 2008 at 07:08:50PM -0700, Steven Grimm wrote:
> On May 7, 2008, at 6:58 PM, Chris Shoemaker wrote:
>> Second, what will happen when different developers have svn URLs with
>> different schemes, e.g. http vs. svn+ssh?
>
> That will cause the commit messages to be different, which means you won't 
> have the same commit hashes, so this pretty much won't be useful. (You'd 
> end up fetching the remote repo's entire svn history if you tried to do git 
> fetch.)

Yes, indeed.  But git fetching even the entire svn history is probably
often faster than git-svn fetching even one commit!  I guess the
question is really, if I replace my remote tracking branch with
someone else's remote tracking branch, and it invalidates old map
entries, what breaks?  Note, that even a slight difference in
svn.authorsfile would have the same effect.

> The assumption here is that you have exactly the same revision history in 
> your tracking branches as the repo you're fetching from.

In that case, it would be helpful to enumerate exactly how two
developers can ensure that they are creating the same revision
history.  At the very least, svn URL scheme and svnauthors file have
to be the same.

-chris

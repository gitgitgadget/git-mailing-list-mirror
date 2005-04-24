From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 13:25:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241305370.30848-100000@iabervon.org>
References: <20050424160514.GI1507@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 19:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPkn9-0000uI-Ng
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVDXRZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 13:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVDXRZu
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 13:25:50 -0400
Received: from iabervon.org ([66.92.72.58]:19972 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262308AbVDXRZk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 13:25:40 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPkrP-0003W6-00; Sun, 24 Apr 2005 13:25:35 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050424160514.GI1507@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 24, 2005 at 05:47:54PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > Hi,
> 
> Hi,
> > How can I seek back to the most recent state of the dir?
> 
> git seek, without any arguments.
> 
> Perhaps we should prohibit absence of arguments and add 'unseek'?

Have both; I think that it ought to accept anything where it's obvious
what the user means.

> Actually, this _would_ work:
> 
> 	git init ../mygitdir/.git
> 
> Then, you would need to git pull to get the latest changes.

It's worth pointing out that the reason for this (and why the rsync
version below didn't work) is that the conventional URLs are for .git
directories, not the directories that contain them: .../cogito/cogito.git
mirrors a cogito/.git directory. Or, phrasing it the other way, when it's
public, it's cogito.git; if it's in a working directory, it gets hidden by
making it just .git.

> git fork seconddeveloper ../mygitdir

Doesn't that have to be from the first one to the second one (rather than
the other way)?

> Git does not record renames, and neither does Cogito (for now).

And, in general, future history-browsing tools will work based on clever
analysis of the files, not explicit information in the database. They
ought to recognize when some content disappears from one place and
something very similar appears elsewhere, regardless of whether it is a
complete file or not.

I'm fairly certain that the most common rename-type events are moving code
within a file, not renaming files, and these would be a major pain to get
people to explicitly mark.

> > 4) fork, seek, tag, and track are a little mysterious to me. I can guess at what
> > these things do in general, but the specifics are confusing, and the README is a
> > little vague.
> 
> Try head git*.sh. ;-)

Which is to say, there are useful comments at the beginnings of the
scripts. I.e., you really want "head `which gitfork.sh`"

	-Daniel
*This .sig left intentionally blank*


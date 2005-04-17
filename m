From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 09:36:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:30:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCfg-0001Rc-CX
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDQQeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDQQeb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:34:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:58561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261355AbVDQQeU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:34:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HGYCs4000578
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 09:34:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HGYBod025592;
	Sun, 17 Apr 2005 09:34:11 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417162448.A13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
>
> On Sat, Apr 16, 2005 at 04:01:45PM -0700, Linus Torvalds wrote:
> > So I re-created the dang thing (hey, it takes just a few minutes), and
> > pushed it out, and there's now an archive on kernel.org in my public
> > "personal" directory called "linux-2.6.git". I'll continue the tradition
> > of naming git-archive directories as "*.git", since that really ends up
> > being the ".git" directory for the checked-out thing.
> 
> We need to work out how we're going to manage to get our git changes to
> you.  At the moment, I've very little idea how to do that.  Ideas?

To me, merging is my highest priority. I suspect that once I have a tree 
from you (or anybody else) that I actually _test_ merging with, I'll be 
motivated as hell to make sure that my plumbing actually works. 

After all, it's not just you who want to have to avoid the pain of 
merging: it's definitely in my own best interests to make merging as 
easy as possible. You're _the_ most obvious initial candidate, because 
your merges almost never have any conflicts at all, even on a file level 
(much less within a file).

> However, I've made a start to generate the necessary emails.  How about
> this format?
> 
> I'm not keen on the tree, parent, author and committer objects appearing
> in this - they appear to clutter it up.  What're your thoughts?

Indeed. I'd almost drop the whole header except for the "author" line. 

Oh, and you need a separator between commits, right now your 
"Signed-off-by:" line ends up butting up with the header of the next 
commit ;)

> I'd rather not have the FQDN of the machine where the commit happened
> appearing in the logs.

That's fine. Out short-logs have always tried to have just the real name 
in them, and I do want an email-like thing for tracking the developer, but 
yes, if you remove the email, that's fine. It should be easy enough to do 
with a simple

	sed 's/<.*>//'

or similar.

And if you replace "author" with "From:" and do the date conversion, it
might look more natural.

		Linus

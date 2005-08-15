From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Sun, 14 Aug 2005 17:46:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org>
References: <46a038f905081417241f9598cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 02:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4T7d-00064y-4g
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 02:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVHOAqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 20:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVHOAqe
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 20:46:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932615AbVHOAqe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 20:46:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7F0kVjA008845
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Aug 2005 17:46:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7F0kURV024883;
	Sun, 14 Aug 2005 17:46:31 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081417241f9598cc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 15 Aug 2005, Martin Langhoff wrote:
>
> After having done a cvs import of Moodle using git-cvsimport-script
> all the cvs branches show up as heads. How do I switch heads within a
> checkout? cogito doesn't seem to be able to, and I'm unsure on how to
> do it with git.

Just do

	git checkout branch-name

to switch between them.

One thing that "git cvsimport" does not know to do is to show when a
branch was merged back into the HEAD. That would be a very interesting
thing to see, but I don't think there's any way to get that information
out of CVS (so you'd have to basically make an educated guess by looking
at the changes).

So in a cvsimport, you'll never see a merge back to the head, even if one 
technically took place. 

> And I am confused about the difference between heads and branches.

Confusion of naming.

branches and heads are the same thing in git. However, largely due to 
historical reasons, I encouraged "one tree pre branch", and then you had 
"external branches" which were totally separate repositories.

Now, we're stuck with both the "internal branches" (heads) and "external
branches" (other repositories) _both_ being confusingly called "branch", 
and then to make it more confusing, sometimes you'll see people say 
"head" to make clear that it's a branch internal to one repo.

> In any case, should the cvsimport turn cvs branches into git branches
> instead of heads? Is there are way to turn a head into a proper
> branch?

They are "proper branches", and sorry about the confusion. A head is a 
branch.

			Linus

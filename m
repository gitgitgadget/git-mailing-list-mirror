From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can git be stopped from inserting conflict markers during a
 merge?
Date: Sat, 8 Mar 2008 12:51:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803081242040.5896@woody.linux-foundation.org>
References: <loom.20080308T174918-559@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: William Tanksley <wtanksleyjr+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 21:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY61m-0001lD-7K
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYCHUvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYCHUvo
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:51:44 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbYCHUvn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 15:51:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m28KqBWU015558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Mar 2008 12:52:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m28Kpef6001076;
	Sat, 8 Mar 2008 12:51:40 -0800
In-Reply-To: <loom.20080308T174918-559@post.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76584>



On Sat, 8 Mar 2008, William Tanksley wrote:
>
> I started using Mercurial a while ago, and I'd like to move up to git (for a
> number of reasons). The one thing that's stopping me is that (having recently
> escaped subversion and cvs) I'm now used to NOT having to worry about conflict
> markers being shoved into files. To put it simply, I really like how Mercurial
> does that one thing.

Can you describe what "that one thing" is?

> So, given the git is probably the ultimate in configurability, what do I need to
> do to make it not insert merge markers?

Do you want to just have both (with the base version, all three?) versions 
of the file in your directory?

That's actually conceptually what you have with git, even though what git 
does is to keep the different untouched versions in the index. So with 
git, you actually have *four* different versions of a file when you have a 
conflict:

 - the working tree one (which has the conflict markers, because that's 
   traditional)
 - and index stages 1 (base) 2 (ours) and 3 (theirs)

which is why when you do

	git diff

on an unmerged file, you actually get something much more powerful than 
just the conflict entries - you get a git multi-version diff. It's 
*really* convenient when you get used to it, but I you actually seem to be 
wanting something much simpler.

			Linus

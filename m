From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Switching between branches
Date: Thu, 21 Apr 2005 09:31:23 +0200
Message-ID: <20050421073123.GD31910@pasky.ji.cz>
References: <1114047759.20044.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 09:28:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOW64-0006pK-Gs
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 09:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVDUHbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVDUHbq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 03:31:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33768 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261435AbVDUHba (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 03:31:30 -0400
Received: (qmail 7490 invoked by uid 2001); 21 Apr 2005 07:31:23 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1114047759.20044.22.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 03:42:39AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello!

Hello,

> Perhaps it's a naive question, but how do I switch between branches?  I
> mean an equivalent of "svn switch" or "cvs update -r branch" that would
> reuse the existing working directory.

you can't. There was 'git update' (and intermediate never-committed 'git
switch'), but I decided not to support it for now, since I don't have
any compelling usage case for it. Do

	git fork my-linus ~/my-linus linus

and you will get a local clone of Linus' branch in ~/my-linus, tracking
and everything.

> Then I tried "git merge -b pasky linus" - this actually changed the
> files to the linus branch, but it didn't remove files specific to
> git-pasky.  Also, I'm surprised that I had to specify "-b pasky", as if
> the currently checked out branch is unknown.

Since git merge's purpose is to _merge_, not _switch_, so it picks the
common ancestor by default; another disadvantage is that this happens on
top of your local tree, but your history will record it as a merge which
shares both linus and my history, which isn't quite right. What is
peculiar, though, is that it didn't remove the files specific to
git-pasky.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

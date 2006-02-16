From: Petr Baudis <pasky@suse.cz>
Subject: Re: git faq : draft and rfc
Date: Thu, 16 Feb 2006 16:18:26 +0100
Message-ID: <20060216151826.GS31278@pasky.or.cz>
References: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 16:18:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9ksx-0002aB-6t
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 16:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWBPPRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWBPPRc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 10:17:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32410 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932544AbWBPPRb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 10:17:31 -0500
Received: (qmail 9946 invoked by uid 2001); 16 Feb 2006 16:18:26 +0100
To: Thomas Riboulet <riboulet@gmail.com>
Content-Disposition: inline
In-Reply-To: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16305>

Dear diary, on Thu, Feb 16, 2006 at 01:36:20AM CET, I got a letter
where Thomas Riboulet <riboulet@gmail.com> said that...
> . Git commit is dying telling me "fatal : empty ident <user@myhost>
> not allowed", what's wrong ?
> Make sure your Full Name is not empty in chsh or the 5th field of your
> user line in /etc/passwd isn't empty. If you @myhost is empty make sure
> your hostname is correctly set.

Please also mention GIT_AUTHOR_NAME; chsh may be frequently unavailable.

> . What's the difference between fetch and pull ?
> Fetch : download objects and a head from another repository.
> Pull : pull and merge from another repository.
> See man git-fetch and git-pull for more.

This could do with a little more elaboration as well. Nice inspiration
might be <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>.

> . Can I tell git to ignore files ?
> Yes. Put the files path in the repository in the .git/info/exclude file.

Or .gitignore in the tree itself. .git/info/exclude is only for your
particular checkout while .gitignore is what matters for all and
everyone's checkouts of the project.

> . What can I use to setup a public repository ?
> A ssh server, an http server, or the git-daemon.
> See the tutorial for more details.

Well this is about how to make it available, not how to use it.

The repository should be set up by cg-admin-setuprepo or git-init-db
--shared and normally does not have a working tree attached. You can
fetch from such a repository either over:

	* the GIT protocol (you need to run git-daemon)
	* SSH (you can set up a git-use-only account using git-shell)
	* rsync (has important disadvantages but it is currently the
	  fastest way to do the initial checkout)
	* or the HTTP protocol (any reasonable webhosting will do, but
	  you need to run git-update-server-info after each repository
	  update; if you used cg-admin-setuprepo to set it up, this
	  will be done automatically, otherwise you may enable it in
	  the post-update hook - see .git/hooks/post-update).

You can push to such a repository over:

	* SSH
	* HTTP DAV (you will need to specially configure your HTTP
	  server for this)

Obviously, you can also fetch/push from/to a repository locally if it
is available in the local filesystem structure.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams

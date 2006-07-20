From: Petr Baudis <pasky@suse.cz>
Subject: Re: initializing remote clone but files already there
Date: Thu, 20 Jul 2006 23:32:45 +0200
Message-ID: <20060720213245.GM13776@pasky.or.cz>
References: <f36b08ee0607201241t6160b1eqb4f0b255b02499a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 20 23:33:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3g8Z-0008Ln-R9
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 23:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWGTVcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWGTVcs
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 17:32:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53709 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030381AbWGTVcr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 17:32:47 -0400
Received: (qmail 22587 invoked by uid 2001); 20 Jul 2006 23:32:45 +0200
To: Yakov Lerner <iler.ml@gmail.com>
Content-Disposition: inline
In-Reply-To: <f36b08ee0607201241t6160b1eqb4f0b255b02499a7@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24038>

Dear diary, on Thu, Jul 20, 2006 at 09:41:48PM CEST, I got a letter
where Yakov Lerner <iler.ml@gmail.com> said that...
> There are two machines with slow ssh access. The
> both have copy of same filetree that was synchronized
> previously vi rsync. How do I put both trees under git control
> as if they were clone on one other *but* (1) without creating
> branches and (2) without copying files over (files are already
> there) ?

Put one tree under the git control and examine the initial commit in
detail (cg-log -v or git show --pretty=fuller or whatever). Now you want
to perform the initial commit in the other tree with exactly the same
metadata; log message should be easy, to carry over all the times and
stuff, you need to set GIT_AUTHOR_{NAME,EMAIL,DATE} and
GIT_COMMITTER_<dtto> based on the other initial commit details. That
should result in a same commit id. Then you need to just set up remote
branch origin just like you would set up any other remote branch.

Good luck,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam

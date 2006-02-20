From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svnimport -- http/dav authentication notes
Date: Mon, 20 Feb 2006 11:22:25 -0800
Message-ID: <20060220192225.GB18085@hand.yhbt.net>
References: <46a038f90602192324v7193f154od4ff6952a68c799d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:22:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGcA-0007EH-7A
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 20:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWBTTW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWBTTW1
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 14:22:27 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14780 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750889AbWBTTW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 14:22:26 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 4A70A2DC03A; Mon, 20 Feb 2006 11:22:25 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90602192324v7193f154od4ff6952a68c799d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16499>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> After a lot of trial and error against a server I don't control (so I
> can't log things on) I've managed to use svn-import on it and it
> mostly seems to work. Kind of. It's slowly grinding through the
> commits.
> 
> To make it short, I seem to be doing well with:
> 
>    git-svnimport -t tags -T trunk -b branches -o svntrunk -v
>          'http://martin%40catalyst.net.nz:password@nameless.server.org/svn/someproject'
> 
> The repo has LDAP authentication, and the username is my email
> address, so I guessed that url-encoding would work, and it did.

Logging in with the svn command-line client (svn ls <url>) be enough to
cache auth information for the SVN library (and therefore svnimport)?
Unless you've disabled it in your config, of course...

> svnimport is a bit of a mistery actually. I often know if it's really
> doing the import or the files are going to be there but empty. SVN is
> so flexible in its "everything is a directory" way of thinking that if
> I mess up -t or -b I get the commits alright... but no files.
> 
> Strange world, svn ;-)

Hear, hear.  I always had to reread the manpage or look here for
examples on how to use it.  And then echo !! > .git/info/svnimport-cmd
after I was done using it so I wouldn't have to remember which command
switches I used.

Then I decided to write git-svn :>

-- 
Eric Wong

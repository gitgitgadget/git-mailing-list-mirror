From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 13:31:29 -0700
Message-ID: <20070324203129.GA25571@muzzle>
References: <20070322224829.GA7048@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCtj-0001Az-OB
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 21:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbXCXUbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 16:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbXCXUbd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 16:31:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44319 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbXCXUbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 16:31:31 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CC8DC2DC01A;
	Sat, 24 Mar 2007 13:31:29 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Mar 2007 13:31:29 -0700
Content-Disposition: inline
In-Reply-To: <20070322224829.GA7048@c3sl.ufpr.br>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43017>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> wrote:
> Hello,
> 
> I'm going to apply for the Git / Subversion Interoperability project.
> 
> I saw that there is no mentor yet assigned for the "job". So i'm sending this
> mail to get some help to start the project by submiting to GSOC and begin to
> work :)

I work on git-svn and I can certainly help you in some ways.  However
I'm uncomfortable committing myself to this because of time constraints;
so I won't be signing up as a mentor.  Sorry.

> My idea on this project is to create:
> 1.  git-svnserver

I'm not familiar with the internals of the SVN protocol, and my work
with git-svn has sufficiently frightened me away from wanting to
investigate further :).

I also suggest you write a HTTP/DAV-based server/plugin/cgi instead of
relying on the SVN protocol.  In my experience svnserve itself is quite
finnicky.

> 2.  write a backend for Subversion

One key difference between git and Subversion is the design emphasis on
data structures versus design emphasis on code/APIs.  Subversion
certainly tries to keep their APIs stable (and for the most part seem
successful), but their publically available storage backends are
definitely lacking.

I'm not sure this part of the project is going to help git very much
unless it speeds up the libification effort.

> And make it easy to work with SSH using those "common" flags in
> authorized_keys like:
> command="svnserve -t -r /home/svn --tunnel-user=bruno" ssh-dss bla bla
> 
> And as an idea i would like to make the same funcionality to git, as it is
> not as easy today to do something like above :)

One reason to work on your project is to help SVN users who have no idea
what UNIX, ssh, and tunneling are.  This is also why I recommend working
on the HTTP/DAV protocol instead.

-- 
Eric Wong

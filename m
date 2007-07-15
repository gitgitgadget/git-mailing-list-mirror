From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 17:21:01 +0200
Message-ID: <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org>
References: <20070713214630.GB7106@genesis.frugalware.org>
 <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
 <20070715104712.GF2568@steel.home>
 <20070715105450.GD7106@genesis.frugalware.org>
 <20070715135057.GI2568@steel.home>
 <20070715135453.GE7106@genesis.frugalware.org>
 <20070715140244.GF999MdfPADPa@greensroom.kotnet.org>
 <20070715142624.GF7106@genesis.frugalware.org>
 <20070715144835.GI999MdfPADPa@greensroom.kotnet.org>
 <20070715150540.GH7106@genesis.frugalware.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 17:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA5uX-0000CS-JQ
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 17:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933AbXGOPVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 11:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758345AbXGOPVG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 11:21:06 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:39564 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758360AbXGOPVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 11:21:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL800HOQ7Z1O0@psmtp09.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 17:21:02 +0200 (MEST)
Received: (qmail 20161 invoked by uid 500); Sun, 15 Jul 2007 15:21:01 +0000
In-reply-to: <20070715150540.GH7106@genesis.frugalware.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52565>

On Sun, Jul 15, 2007 at 05:05:40PM +0200, VMiklos wrote:
> Hello,
> 
> Na Sun, Jul 15, 2007 at 04:48:35PM +0200, Sven Verdoolaege <skimo@kotnet.org> pisal(a):
> > Isn't that what "git submodule update" does ?
> 
> i can't get it to work, but here is a log:
> 

> vmiklos@vmobile:~/git/test$ ls
> vmiklos@vmobile:~/git/test$ mkdir server
> vmiklos@vmobile:~/git/test$ cd server
> vmiklos@vmobile:~/git/test/server$ mkdir main
> vmiklos@vmobile:~/git/test/server$ cd main
> vmiklos@vmobile:~/git/test/server/main$ git init
> Initialized empty Git repository in .git/
> vmiklos@vmobile:~/git/test/server/main$ echo "foo" > main.c
> vmiklos@vmobile:~/git/test/server/main$ git add main.c
> vmiklos@vmobile:~/git/test/server/main$ git commit -m "import main"
> Created initial commit 1ceae8f: import main
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 main.c
> vmiklos@vmobile:~/git/test/server/main$ cd ..
> vmiklos@vmobile:~/git/test/server$ mkdir libfoo
> vmiklos@vmobile:~/git/test/server$ cd libfoo
> vmiklos@vmobile:~/git/test/server/libfoo$ git init
> Initialized empty Git repository in .git/
> vmiklos@vmobile:~/git/test/server/libfoo$ echo "foo" > libfoo.c
> vmiklos@vmobile:~/git/test/server/libfoo$ git add libfoo.c
> vmiklos@vmobile:~/git/test/server/libfoo$ git commit -m "import libfoo"
> Created initial commit 5979d36: import libfoo
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 libfoo.c
> vmiklos@vmobile:~/git/test/server/libfoo$ cd ../..
> vmiklos@vmobile:~/git/test$ mkdir client
> vmiklos@vmobile:~/git/test$ cd client
> vmiklos@vmobile:~/git/test/client$ git clone ../server/main
> Initialized empty Git repository in /home/vmiklos/git/test/client/main/.git/
> remote: Generating pack...
> Done counting 3 objects.
> Deltifying 3 objects...
>  100% (3/3) done
> Total 3 remote: (delta 0), reused 0 (delta 0)
> Indexing 3 objects...
>  100% (3/3) done
> 
> vmiklos@vmobile:~/git/test/client$ cd main
> vmiklos@vmobile:~/git/test/client/main$ ls
> main.c
> vmiklos@vmobile:~/git/test/client/main$ git submodule add ../../server/libfoo/ libfoo

Here you add a submodule in the copy of the superproject in client.

> Initialized empty Git repository in /home/vmiklos/git/test/client/main/libfoo/.git/
> remote: Generating pack...
> remote: Done counting 3 objects.
> remote: Deltifying 3 objects...
>  100% (3/3) done
> Total 3 (delta 0), reused 0 (delta 0)
> Indexing 3 objects...
>  100% (3/3) done
> 
> vmiklos@vmobile:~/git/test/client/main$ git submodule init
> Submodule 'libfoo' (/home/vmiklos/git/test/server/libfoo/.git) registered for path 'libfoo'
> vmiklos@vmobile:~/git/test/client/main$ git commit -a -m "registered libfoo submodule"
> Created commit 2c65310: registered libfoo submodule
>  2 files changed, 4 insertions(+), 0 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 160000 libfoo
> vmiklos@vmobile:~/git/test/client/main$ cd ../../server/main
> vmiklos@vmobile:~/git/test/server/main$ echo bar >> main.c
> vmiklos@vmobile:~/git/test/server/main$ git add git commit -m "bar in main"
> vmiklos@vmobile:~/git/test/server/main$ git add main.c
> vmiklos@vmobile:~/git/test/server/main$ git commit -m "bar in main"
> Created commit 1c26399: bar in main
>  1 files changed, 1 insertions(+), 0 deletions(-)
> vmiklos@vmobile:~/git/test/server/main$ cd ../libfoo
> vmiklos@vmobile:~/git/test/server/libfoo$ echo bar >> libfoo.c
> vmiklos@vmobile:~/git/test/server/libfoo$ git add libfoo.c
> vmiklos@vmobile:~/git/test/server/libfoo$ git commit -m "bar in libfoo"
> Created commit 07ceadb: bar in libfoo
>  1 files changed, 1 insertions(+), 0 deletions(-)
> vmiklos@vmobile:~/git/test/server/libfoo$ cd ../../client/main
> vmiklos@vmobile:~/git/test/client/main$ git submodule update
> 
> at the end of it, git submodule update does not pull anything, while
> there are changes both in the main and in the libfoo repo, too

The last time you told the superproject about any changes
in the subprojects was when you added the subproject (in client),
so as far as the superproject is concerned nothing happened
in any submodule.  The submodules don't even exist in server.

skimo

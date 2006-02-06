From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: problem with gitweb I don't understand
Date: Mon, 6 Feb 2006 21:35:27 +0000
Message-ID: <200602062135.27652.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Feb 06 22:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6E15-0005p1-Bl
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 22:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBFVfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 16:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWBFVfS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 16:35:18 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:51404
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932178AbWBFVfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 16:35:16 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F6E0x-00058G-Nz
	for git@vger.kernel.org; Mon, 06 Feb 2006 21:35:15 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15663>

I am running with a (slightly) modified version of gitweb.  The only 
modifications are to allow it to pick up my site header and footer.

I have just added a new project "txpg.git" to the directory where all my git 
projects are stored for public display.  This was some old code that I 
packaged up into a repository.  There are two disconnected branches - "orig" 
which contains the initial check-in of the original code I started with, and 
"master" which is also an initial check-in but of the result after some 
incomplete hacking.  HEAD is a symlink I made manually to point to master.

I have been able to clone this (via git:// protocol) add a tag, and then with 
a post-update hook in the repository successfully generate a tarball of the 
code using git-tar-tree when pushing a tag using ssh.  So I am pretty 
confident I have a real repository

But gitweb is not displaying it (see http://www.chandlerfamily.org.uk/git).

However if I do http://www.chandlerfamily.org.uk/git/?p=txpg.git;a=summary

the error message I get is "403 Forbidden - No such project."  whereas if I 
had used any random characters for the project I would have got "403 
Forbidden - No such directory"

Looking at the gitweb code, all I can see is the non-existance of the HEAD 
file as causing this error.  but it is definately there as seen from the 
following output.

alan@roo git$ find . -name HEAD
./txpg.git/HEAD
./gitweb.git/HEAD
./border.git/HEAD
./blog.git/HEAD
./famtree.git/HEAD
./akcmoney.git/HEAD
alan@roo git$ pwd
/var/lib/git
alan@roo git$ ls -l akcmoney.git/HEAD
lrwxrwxrwx  1 alan git 17 Jan 29 19:14 akcmoney.git/HEAD -> refs/heads/master
alan@roo git$ ls -l txpg.git/HEAD
lrwxrwxrwx  1 alan git 17 Feb  6 19:48 txpg.git/HEAD -> refs/heads/master

So I am stumped as to what could be wrong.

Anyone any ideas.






-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

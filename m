From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Error on new installation
Date: Sun, 31 Aug 2008 00:47:50 +0100
Message-ID: <200808310047.50560.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 02:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZate-0006FX-UM
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 02:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYHaAdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 20:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbYHaAdR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 20:33:17 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:38120 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754807AbYHaAdQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 20:33:16 -0400
X-Greylist: delayed 2744 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2008 20:33:16 EDT
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1KZaAF-0001xn-7p
	for git@vger.kernel.org; Sun, 31 Aug 2008 00:47:31 +0100
Received: from [77.101.57.129] (helo=home.chandlerfamily.org.uk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1KZaAE-0002BB-Pe
	for git@vger.kernel.org; Sun, 31 Aug 2008 00:47:30 +0100
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1KZaAE-0006fi-Hd
	for git@vger.kernel.org; Sun, 31 Aug 2008 00:47:30 +0100
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-SA-Exim-Connect-IP: 192.168.0.21
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on home.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94446>

I have been a long time user of git for little home jobs.  My version of 
git (except in the very early days) been obtained as a standard debian 
binary package.

I have been developing some software on my home machine for a web site I 
run at a hosting company.  I have a "site" branch for the version that 
is configured for running at the site, but up until now I have been 
manually transfering the files to the site I thought I had updated in 
the last commit.

I have now realised that if I stick a git repository on this hosting 
computer where my web site application has to be, I could git push my 
site branch to it on update and then use a post receive hook there to 
checkout the newly received version - thus automatically keeping the 
right files in sync.

Unfortunately this hosting company does not have git installed, so I 
downloaded the tar.gz version of 1.6.0, unpacked it and from inside the 
new directory did a make install.  

This appears to have put key programs in ~/bin and the remainer in 
~/libexec/git-core

As a first test, I went into the directory where one of my applications 
resides and did

git init
git add .
git commit

I then tried to clone back this repository with the following results

(NOTE mb is stanza in my ~/.ssh/config file which fully defines 
host/username/identity etc for my server at the hosting company)

alan@kanger:~/dev$ git 
clone --upload-pack=/home/melindas/bin/git-upload-pack 
ssh://mb/home/melindas/public_html/football/
Initialized empty Git repository in /home/alan/dev/football/.git/
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: fatal: exec pack-objects failed.
remote: aborting due to possible repository corruption on the remote 
side.
fatal: early EOF
fatal: index-pack failed
alan@kanger:~/dev$


the question is - why does git-pack-objects die.  I presume the 
repository is not corrupt, it has been newly created.  Does it rely on 
some other programs on the host that might not be there?


-- 
Alan Chandler
http://www.chandlerfamily.org.uk

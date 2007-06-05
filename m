From: "Matt Seitz" <seitz@neopathnetworks.com>
Subject: How to remove invalid remote repository
Date: Tue, 5 Jun 2007 14:41:04 -0500
Message-ID: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 21:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvf86-0001X3-Te
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762827AbXFETzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 15:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763001AbXFETzj
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 15:55:39 -0400
Received: from iss04.interliant.com ([207.113.241.148]:33753 "EHLO
	iss04.interliant.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762827AbXFETzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 15:55:38 -0400
X-Greylist: delayed 870 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2007 15:55:38 EDT
Received: from EX-008.mail.navisite.com (ex-008.interliant.com [207.113.240.188])
	by iss04.interliant.com (8.10.2/8.10.2) with ESMTP id l55Jf6503585
	for <git@vger.kernel.org>; Tue, 5 Jun 2007 14:41:06 -0500 (CDT)
Received: from EX-401.mail.navisite.com ([172.16.1.235]) by EX-008.mail.navisite.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 5 Jun 2007 14:41:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to remove invalid remote repository
Thread-Index: AcenqXQZQNEiuB7jTluN5823+I1Y7g==
X-OriginalArrivalTime: 05 Jun 2007 19:41:05.0529 (UTC) FILETIME=[74DCD690:01C7A7A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49222>

I mistakenly entered the wrong directory name for "git remote add" (I
entered the working tree directory name instead of the ".git" directory
name). 

So "git fetch" fails with:

fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

Cannot get the repository state from origin

So, I tried removing the remote tracking branches:

git branch -d -r root-etc/master

But that failed with:

error: remote branch 'root-etc/master' not found.


So I then tried recreating the remote reference:

git remote add root-etc /root/git/etc/.git
But that failed with:

remote root-etc already exists

So, how can I remove the incorrect remote repository reference and
replace it with a correct one?

[root@demo5 etc]# git config -l
core.repositoryformatversion=0

core.filemode=true

core.bare=false

core.logallrefupdates=true

gui.geometry=811x591+781+0 107 172

remote.root-etc.url=/root/git/etc

remote.root-etc.fetch=+refs/heads/*:refs/remotes/root-etc/*

[root@demo5 etc]# git version

git version 1.5.0.7

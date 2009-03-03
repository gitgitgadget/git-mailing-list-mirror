From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 03 Mar 2009 15:28:08 +0100
Message-ID: <49AD3E78.1050706@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 15:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeVmm-00046Q-8t
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 15:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbZCCOi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbZCCOi0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 09:38:26 -0500
Received: from fep50.mail.dk ([80.160.77.103]:51066 "EHLO fep50.mail.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbZCCOiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 09:38:25 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 09:38:25 EST
Received: from fep47.mail.dk ([195.41.46.230]) by fep50.mail.dk
          (InterMail vM.7.09.02.00 201-2219-117-20090203) with ESMTP
          id <20090303142810.XQBT9250.fep50.mail.dk@fep47.mail.dk>
          for <git@vger.kernel.org>; Tue, 3 Mar 2009 15:28:10 +0100
Received: from [172.22.216.222] (really [77.233.248.193]) by fep47.mail.dk
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20090303142810.PGDR1185.fep47.mail.dk@[172.22.216.222]>
          for <git@vger.kernel.org>; Tue, 3 Mar 2009 15:28:10 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Authentication-Info: Submitted using SMTP AUTH at fep47.mail.dk from [77.233.248.193] at Tue, 3 Mar 2009 15:28:10 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112077>

Commits where only the indentation of 'foo' is changed are not shown=20
with "git log -Sfoo". Is there any way to force showing them along with=
=20
other changes involving foo? (E.g. for python, indentation matters!)

Why doesn't the second commit show up in the following?

$ git init

# Create text containing 'line' without whitespace
$ echo 'line' > text
$ git add text
$ git commit -m "first" text

# Here, I add one space of indentation in front of 'line'
$ echo ' line' > text
$ git commit -m "second" text

# git log -Sline shows only the first commit, not the second,
# where the indentation changed.
$ git log -Sline
commit c4481e4b38bb521d91583e5c5a3b2b98f08b7ec0
Author: pvm <pvm@change_me.dk>
Date:   Tue Mar 3 14:45:38 2009 +0100

     first

# But clearly, the second commit *also* has changes
# containing 'line':
$ git log -p HEAD~..HEAD
commit 6cb883409aa9ccda00d7720ee9bf4fa59918c5fd
Author: pvm <pvm@change_me.dk>
Date:   Tue Mar 3 14:45:39 2009 +0100

     second

diff --git a/text b/text
index a999a0c..d650980 100644
--- a/text
+++ b/text
@@ -1 +1 @@
-line
+ line

I would like to see both "first" and "second" somehow - can I do that?

--=20
Peter Valdemar M=F8rch
http://www.morch.com

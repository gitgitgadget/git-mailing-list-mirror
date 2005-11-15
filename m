From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: A case for tailor
Date: Tue, 15 Nov 2005 19:48:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511151931001.1157@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-675411281-1132080489=:1157"
X-From: git-owner@vger.kernel.org Tue Nov 15 19:49:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5qo-000334-OW
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVKOSsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVKOSsL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:48:11 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42137 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964969AbVKOSsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:48:11 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 0F2D313F7B5
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:48:10 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id D7FBEB51E5
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:48:09 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id B9084B51D2
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:48:09 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id A895413F7B5
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:48:09 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11930>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-675411281-1132080489=:1157
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I was trying to import a project into git, the upstream of which is=20
managed by Subversion. There has been a flurry of enhancements to=20
git-svnimport, so I thought I=B4d give it a try.

Short version: it did not work.

Longer version: depending on the argument to "-T", it stopped right away,=
=20
or it stopped after about 60 commits. Right at the beginning, a lot of=20
warnings told me about some files not being where they were expected.

Possible explanation: at some early stage, the trunk was named "trunk",=20
but somehow (don=B4t ask me how, I am a fan of git, not svn) renamed to=20
"head".

Well, could also be cygwin, which I am stuck with in my office.=20

BTW, I noticed that the manpage tells me that "-t" should be used to=20
specify the trunk, but the program (and it=B4s usage message) disagree.

Enter tailor. It is a program written in python, which is meant to conver=
t=20
repositories between different SCM formats. It was mentioned some time ag=
o=20
on this list, supports svn import and git export, so I thought I=B4d give=
=20
that a try.

Short version: it worked.

Longer version: I had to fix a little bug which made git ignore the=20
author_date (only to find that this had been fixed in the current devel=20
version of tailor), had to make sure .git/info existed, and I added a=20
dirty workaround to git so that empty commits would not lead to a=20
screeching halt of the conversion.

Comparing the speeds, I=B4d also say that they are comparable, maybe=20
git-svnimport is just a tad faster (until it fscks up).

I am right now trying to convert tailor=B4s repository (since I don=B4t l=
ike=20
to keep it in the darcs (pun intended) format). However there is still a=20
little problem with darcs, which is probably a problem with the operating=
=20
system.

Just wanted to let people know...

Ciao,
Dscho

---1148973799-675411281-1132080489=:1157--

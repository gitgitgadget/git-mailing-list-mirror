From: =?iso-8859-1?q?Bj=F6rn_Hendriks?= <bjoern01@nurfuerspam.de>
Subject: Generate version file by hooks
Date: Tue, 17 Mar 2009 16:26:00 +0100
Message-ID: <200903171626.01102.bjoern01@nurfuerspam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 16:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbCc-00082L-4t
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbZCQP0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbZCQP0H
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:26:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:33721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751915AbZCQP0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 11:26:06 -0400
Received: (qmail invoked by alias); 17 Mar 2009 15:26:02 -0000
Received: from malvasia.ibr.cs.tu-bs.de (EHLO malvasia.ibr.cs.tu-bs.de) [134.169.34.62]
  by mail.gmx.net (mp068) with SMTP; 17 Mar 2009 16:26:02 +0100
X-Authenticated: #1618055
X-Provags-ID: V01U2FsdGVkX1882ycz8fs83zBrp75RSpwVuqyECPg3zbywCqH2Za
	/UoH8neQdtsi2M
User-Agent: KMail/1.9.10
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113480>


Hello,

I'd like to put the SHA1 of the current commit into a source file so th=
at my=20
program can further process it -- put it into a log file for example.

My idea is to write a script which reads the SHA1 of the current commit=
 with=20
the call

git log -1 --pretty=3Dformat:"%H"

(git-describe is not suitable for me) and then generates the wanted sou=
rce=20
file.  To avoid accidentally committing that file I will put its name=20
into .git/info/exclude.

I already put the call to my experimental generator script into the hoo=
ks=20
post-checkout and post-commit, so it will be called if I do a commit or=
 a=20
checkout of another branch.

My problem is, that my script won't be called if I do a git-pull, a git=
-reset=20
or a git-merge without conflicts resulting in workfiles of a new commit=
=2E =20
Maybe there are more git calls which change the current commit I haven'=
t=20
thought of yet?

So my question: How to make git call my script automatically in all cas=
es=20
where git changes the currently checked out commit?

Maybe there are different solutions to put the current SHA1 into a sour=
ce=20
file?

Of course I know that it's still possible to change the working files w=
ithout=20
git's notice resulting in an inconsistent commit SHA1.  But before doin=
g any=20
test runs I normally check with git-status that all files are in a comm=
itted=20
state but that won't reveal if my generated version file is not up to d=
ate.

I use git version 1.5.4.3 and would like to stick to it for some reason=
 if=20
possible.

Thanks for your help
Bj=F6rn

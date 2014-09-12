From: Giulio Cesare Solaroli <giulio.cesare@solaroli.it>
Subject: Issue with 'git diff' and non ascii characters
Date: Fri, 12 Sep 2014 08:53:49 +0200
Message-ID: <5DEE05EE-B302-44D1-9B1D-0B475EF4E96B@solaroli.it>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 09:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSL3g-0004bR-2N
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 09:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbaILHOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2014 03:14:12 -0400
Received: from aibo.runbox.com ([91.220.196.211]:48031 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbaILHOL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 03:14:11 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 03:14:11 EDT
Received: from [10.9.9.207] (helo=mailfront03.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <giulio.cesare@solaroli.it>)
	id 1XSKk0-0007gz-C2
	for git@vger.kernel.org; Fri, 12 Sep 2014 08:53:56 +0200
Received: from [2.228.126.19] (helo=homer.curadomain.local)
	by mailfront03.runbox.com with esmtpsa  (uid:777319 )  (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	id 1XSKjw-0005SU-O8
	for git@vger.kernel.org; Fri, 12 Sep 2014 08:53:52 +0200
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256902>

Hello,

I have spotted a problem using 'git diff' when non ascii characters are=
 involved.
Not sure if the problem is due to the name of the file, or its content.

Cheers,

Giulio Cesare

Steps to reproduce the problem:

$ sw_vers
ProductName:	Mac OS X
ProductVersion:	10.9.4
BuildVersion:	13E28
$ git --version
git version 1.8.5.2 (Apple Git-48)
$ mkdir test
$ cd test
$ echo prova > t=E8st.md
$ git init
Initialized empty Git repository in /private/tmp/test/.git/
$ git add *
$ git commit -m "first commit"
[master (root-commit) ebbe2a3] first commit
 1 file changed, 1 insertion(+)
 create mode 100644 "t\303\250st.md"
$ echo prov=E0 > t=E8st.md=20
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working direct=
ory)

	modified:   "t\303\250st.md"

no changes added to commit (use "git add" and/or "git commit -a")
$ git diff t=E8st.md=20
$=20

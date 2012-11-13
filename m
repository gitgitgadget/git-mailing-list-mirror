From: Peter Vereshagin <peter@vereshagin.org>
Subject: checkout from neighbour branch  undeletes a path?
Date: Tue, 13 Nov 2012 19:23:41 +0400
Organization: '
Message-ID: <20121113152341.GC6561@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 16:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYITx-0003gb-Va
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab2KMPck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:32:40 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:63600 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab2KMPcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:32:39 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2012 10:32:39 EST
Received: from localhost (bolobolo2.torservers.net [96.47.226.21])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 19BCF5B4F
	for <git@vger.kernel.org>; Tue, 13 Nov 2012 19:24:02 +0400 (MSK)
Content-Disposition: inline
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209616>

Hello.

Am wondering if 'checkout branch path' undeletes the files? For the example
below I'd like the 'file00.txt' to be deleted and never checked out from the
previous branch... How can I do that?

  $ git init                                                                                             
  Initialized empty Git repository in /tmp/repo00/.git/
  $ mkdir pathdir
  $ echo test00 > pathdir/file00.txt
  $ git add pathdir
  $ git commit -am 'added file00.txt'
  [master (root-commit) d4f7c70] added file00.txt
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 pathdir/file00.txt
  $ git branch -m master branch00
  $ git branch branch01
  $ rm pathdir/file00.txt
  $ echo test01 > pathdir/file01.txt
  $ git add pathdir
  $ git status
  $ git commit -am 'added file01.txt; removed file00.txt'
  [branch00 c3e78ff] added file01.txt; removed file00.txt
   2 files changed, 1 insertions(+), 1 deletions(-)
   delete mode 100644 pathdir/file00.txt
   create mode 100644 pathdir/file01.txt
  $ git checkout branch01
  Switched to branch 'branch01'
  $ rm -r pathdir
  $ git checkout branch00 pathdir
  $ find pathdir/
  pathdir/
  pathdir/file00.txt
  pathdir/file01.txt
  $

I know about 'merge' and it's not the what I need:  to import only the
particular subdirectory from the previous branch.

Thank you.

--
Peter Vereshagin <peter@vereshagin.org> (http://vereshagin.org) pgp: A0E26627

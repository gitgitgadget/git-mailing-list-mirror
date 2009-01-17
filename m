From: Damon LaCrosse <arid@inbox.ru>
Subject: Possible git bug
Date: Sat, 17 Jan 2009 14:52:57 +0100
Organization: Julian Assange Memorial Society
Message-ID: <87zlhqca4m.fsf@inbox.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 15:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOCHs-0004X8-FO
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 15:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbZAQOfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757611AbZAQOfL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 09:35:11 -0500
Received: from main.gmane.org ([80.91.229.2]:40365 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbZAQOfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 09:35:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LOCGM-0002kF-SL
	for git@vger.kernel.org; Sat, 17 Jan 2009 14:35:03 +0000
Received: from 213-140-6-115.ip.fastwebnet.it ([213.140.6.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 14:35:02 +0000
Received: from arid by 213-140-6-115.ip.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 14:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 213-140-6-115.ip.fastwebnet.it
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:utPqbd68690lra0lc7P/dE7RnqM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106053>

--=-=-=

HiQ,

any chances the attached patch reveals a git bug?

Cheers,


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=git-bug.patch

diff -Nru old/git-bug.sh new/git-bug.sh
--- old/git-bug.sh	1970-01-01 01:00:00.000000000 +0100
+++ new/git-bug.sh	2008-09-16 09:52:18.000000000 +0200
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+mkdir bug
+cd bug
+git init-db
+
+echo one > file1
+git add file1
+echo "Bug Test Example" | git commit --all -F -
+
+git checkout -b branch
+echo two >> file1
+echo "Branch modification" | git commit --all -F -
+
+git checkout master
+git mv file1 file2
+
+echo "Master rename" | git commit --all -F -
+
+echo three >> file2
+
+echo "Master modification" | git commit --all -F -
+
+git merge -s recursive branch

--=-=-=--

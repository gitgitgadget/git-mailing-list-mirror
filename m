From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH(amend)] Really run "git-clean -n" in test
Date: Sun, 06 May 2007 15:08:44 -0400
Message-ID: <463E27BC.5060604@uwaterloo.ca>
References: <463E19C4.8010601@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 21:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkm6M-0006gu-EM
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbXEFTIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbXEFTIy
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:08:54 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:65110 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755094AbXEFTIx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 15:08:53 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46J8o9O026265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 15:08:50 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <463E19C4.8010601@uwaterloo.ca>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 15:08:51 -0400 (EDT)
X-Miltered: at mailchk-m03 with ID 463E27C2.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: f0d21e04-ffa3-4100-b01f-bde2bbf42433
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46363>

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---

Whoops.

 t/t7300-clean.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 1fb3850..1ada8da 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -125,14 +125,15 @@ test_expect_success \
 
 test_expect_failure \
     'clean.requireForce' \
-    "mkdir -p build docs &&
-    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-    git-config clean.requireForce true &&
+    "git-config clean.requireForce true &&
     git-clean"
 
 test_expect_success \
     'clean.requireForce and -n' \
-    "test -f Makefile &&
+    "mkdir -p build docs &&
+    touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+    git-clean -n &&
+    test -f Makefile &&
     test -f README &&
     test -f src/part1.c &&
     test -f src/part2.c &&

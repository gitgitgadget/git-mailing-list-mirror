From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 03/11] Change remote tracking to remote-tracking in non-trivial places
Date: Sat, 30 Oct 2010 06:10:11 +0200
Message-ID: <1288411819-24462-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 30 06:11:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC2mU-00026r-Rz
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab0J3EKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 00:10:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50030 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab0J3EKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 00:10:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9U3tr4h011955
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 30 Oct 2010 05:55:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2mA-0007ph-1s; Sat, 30 Oct 2010 06:10:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2m9-0006Oi-W8; Sat, 30 Oct 2010 06:10:41 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 30 Oct 2010 05:55:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9U3tr4h011955
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289015757.41138@Q7V4IOMmgGxabYW/IXKtUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160377>

To complement the straightforward perl application in previous patch,
this adds a few manual changes.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-gc.txt      |    6 +++---
 Documentation/gittutorial.txt |    4 ++--
 t/t5400-send-pack.sh          |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 315f07e..801aede 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -89,7 +89,7 @@ are not part of the current project most users will want to expire
 them sooner.  This option defaults to '30 days'.
 
 The above two configuration variables can be given to a pattern.  For
-example, this sets non-default expiry values only to remote tracking
+example, this sets non-default expiry values only to remote-tracking
 branches:
 
 ------------
@@ -128,8 +128,8 @@ Notes
 
 'git gc' tries very hard to be safe about the garbage it collects. In
 particular, it will keep not only objects referenced by your current set
-of branches and tags, but also objects referenced by the index, remote
-tracking branches, refs saved by 'git filter-branch' in
+of branches and tags, but also objects referenced by the index,
+remote-tracking branches, refs saved by 'git filter-branch' in
 refs/original/, or reflogs (which may reference commits in branches
 that were later amended or rewound).
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index f1f4086..0982f74 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -402,8 +402,8 @@ could merge the changes into her master branch:
 alice$ git merge bob/master
 -------------------------------------
 
-This `merge` can also be done by 'pulling from her own remote
-tracking branch', like this:
+This `merge` can also be done by 'pulling from her own remote-tracking
+branch', like this:
 
 -------------------------------------
 alice$ git pull . remotes/bob/master
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 5bcf0b8..b0b2684 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -129,7 +129,7 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
-test_expect_success 'push --all excludes remote tracking hierarchy' '
+test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
 	    cd parent &&
-- 
1.7.3.2.183.g2e7b0

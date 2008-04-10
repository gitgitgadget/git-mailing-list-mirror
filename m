From: Adam Golebiowski <adamg@pld-linux.org>
Subject: [PATCH] Kill bashizm in t/t3200-branch.sh and t/t7201-co.sh.
Date: Thu, 10 Apr 2008 09:25:00 +0200
Message-ID: <20080410072500.GA10188@mysza.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 10 09:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrcG-0007Hj-Cc
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbYDJHxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYDJHxz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:53:55 -0400
Received: from [212.244.191.134] ([212.244.191.134]:3952 "EHLO
	mx.biomerieux.pl" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbYDJHxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:53:54 -0400
X-Greylist: delayed 1718 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Apr 2008 03:53:53 EDT
Received: from chello084010124137.chello.pl ([84.10.124.137]:30711 helo=biomerieux.pl)
	by mx.biomerieux.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <adamg@biomerieux.pl>)
	id 1JjrC3-0006Xs-CG; Thu, 10 Apr 2008 09:27:38 +0200
Received: from adamg by biomerieux.pl with local (Exim 4.69)
	(envelope-from <adamg@biomerieux.pl>)
	id 1Jjr9Y-0002eV-Hx; Thu, 10 Apr 2008 09:25:00 +0200
Content-Disposition: inline
X-Operating-System: Linux ook 2.6.22.18_desktop-1
X-Location: Zielonka/Poland 52.3000N, 21.1670E
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "mx", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	postmaster@localhost for details.
	Content preview:  On systems with /bin/sh being different than /bin/bash, make
	test fails due to some bash-specific constructs. This patch makes it possible
	to run the test-suite systems with on /bin/sh pointing to /bin/ksh. [...]
	Content analysis details:   (-1.4 points, 5.1 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
X-Scan-Signature: fba11a8b052d99e40baa9361b2c3d74d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79190>

On systems with /bin/sh being different than /bin/bash, make test fails due
to some bash-specific constructs. This patch makes it possible to run the
test-suite systems with on /bin/sh pointing to /bin/ksh.

Signed-off-by: Adam Golebiowski <adamg@pld-linux.org>
---
 t/t3200-branch.sh |    2 +-
 t/t7201-co.sh     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cb5f7a4..e8ff82f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -200,7 +200,7 @@ test_expect_success \
 
 test_expect_success \
     'branch from non-branch HEAD w/--track causes failure' \
-    '!(git branch --track my10 HEAD^)'
+    '! git branch --track my10 HEAD^'
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 3111baa..51a9928 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -335,6 +335,6 @@ test_expect_success \
     git checkout -b delete-me master &&
     rm .git/refs/heads/delete-me &&
     test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
-    !(git checkout --track -b track)'
+    ! git checkout --track -b track'
 
 test_done
-- 
1.5.4.5


-- 
 http://www.mysza.eu.org/ | Everybody needs someone sure, someone true,
   PLD Linux developer    | Everybody needs some solid rock, I know I do.

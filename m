From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] contrib: update packinfo.pl to not use dashed commands
Date: Fri, 17 Oct 2008 21:41:18 -0500
Message-ID: <1224297678-8818-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 04:44:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr1no-0007fH-S5
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 04:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYJRClY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 22:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYJRClY
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 22:41:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:16939 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbYJRClX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 22:41:23 -0400
Received: by wx-out-0506.google.com with SMTP id h27so366426wxd.4
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2qNxooAk2nY75DCk4EjKaKfWxYtiaD38/vV2XUC2tE8=;
        b=vIkvNT9RX2tp0kfdL1gKfc60rBBEU9thzL66s1kZJtH46F9JD6rWHZGjG9RlbR4UHx
         mdxEPe0dXsP+R/IDmZV6D39b5BZUQB7KvS2JAClxRcZ1J9JLNU1vQR2ldHCyckLZqjAe
         f65p6XhtcCc+h55AJ0VasgS5GjPtxkSBmVOrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TWe4kz1vz+3cHvBGy+HU56bY7Z14vn+Lcl2k/M3nYohhRO7lR/m0LAGtgwEJhAm2yT
         xdGTidVrT/PTCG7rtaRQayFA/LIqweUGFVd36r/M9OB5ni4kRMWJAc7UdzOK51H7pGKO
         +UYA5r1mz2QGFw2cPSmSNGJTnqdW8EwAgzKBc=
Received: by 10.65.200.8 with SMTP id c8mr1991158qbq.90.1224297681261;
        Fri, 17 Oct 2008 19:41:21 -0700 (PDT)
Received: from localhost (adsl-76-197-197-221.dsl.chcgil.sbcglobal.net [76.197.197.221])
        by mx.google.com with ESMTPS id k29sm2837364qba.7.2008.10.17.19.41.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 19:41:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98516>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 contrib/stats/packinfo.pl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index f4a7b62..be188c0 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -1,9 +1,9 @@
 #!/usr/bin/perl
 #
 # This tool will print vaguely pretty information about a pack.  It
-# expects the output of "git-verify-pack -v" as input on stdin.
+# expects the output of "git verify-pack -v" as input on stdin.
 #
-# $ git-verify-pack -v | packinfo.pl
+# $ git verify-pack -v | packinfo.pl
 #
 # This prints some full-pack statistics; currently "all sizes", "all
 # path sizes", "tree sizes", "tree path sizes", and "depths".
@@ -20,7 +20,7 @@
 #
 # When run as:
 #
-# $ git-verify-pack -v | packinfo.pl -tree
+# $ git verify-pack -v | packinfo.pl -tree
 #
 # the trees of objects are output along with the stats.  This looks
 # like:
@@ -43,7 +43,7 @@
 #
 # When run as:
 #
-# $ git-verify-pack -v | packinfo.pl -tree -filenames
+# $ git verify-pack -v | packinfo.pl -tree -filenames
 #
 # it adds filenames to the tree.  Getting this information is slow:
 #
@@ -58,7 +58,7 @@
 #
 # When run as:
 #
-# $ git-verify-pack -v | packinfo.pl -dump
+# $ git verify-pack -v | packinfo.pl -dump
 #
 # it prints out "sha1 size pathsize depth" for each sha1 in lexical
 # order.
@@ -106,7 +106,7 @@ while (<STDIN>) {
 }
 
 if ($filenames && ($tree || $dump)) {
-    open(NAMES, "git-name-rev --all|");
+    open(NAMES, "git name-rev --all|");
     while (<NAMES>) {
         if (/^(\S+)\s+(.*)$/) {
             my ($sha1, $name) = ($1, $2);
@@ -117,7 +117,7 @@ if ($filenames && ($tree || $dump)) {
 
     for my $commit (@commits) {
         my $name = $names{$commit};
-        open(TREE, "git-ls-tree -t -r $commit|");
+        open(TREE, "git ls-tree -t -r $commit|");
         print STDERR "Plumbing tree $name\n";
         while (<TREE>) {
             if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
-- 
1.6.0.2

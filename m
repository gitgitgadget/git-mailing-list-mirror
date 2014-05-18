From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 08/33] Added more test cases for "guilt new": empty patches.
Date: Sun, 18 May 2014 23:59:44 +0200
Message-ID: <1400450409-30998-9-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Cp-0001Jt-SX
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbaERWFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:05:13 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:56514 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaERWFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:05:12 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3510246lab.31
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ucL0eIIAEwoKHpAuyzaryFitYdC1UW05YYWswllA4sI=;
        b=UBW1aSb29uoiSZyS7t7tgl12DNjs8kH+sLU5dZiwU6KDd8hwaEjAw6TwTnWC0Ybmmn
         URpMDM17wNA78zfxDc9uBGZ+4W4LtLRzxGGobuP1QPgkWyhxVC0ouUGWq14Fpxktduxi
         nnxg0P0jNKjyaEAbeZlQcPViIA2Ea40LY+WMgx17smQWFJi2tKF7UAjKuIG28Vjcy3X+
         ReB+1ri46WzSYfLD8eYUFhNLPkCKs7Is9brM87mtnRLPkVtKquZZAvDDtaV2u2Ewoo5e
         FDq+ugckkUW6eRybe4XIj6IJzH//G4Bc5SA5hlyt96m2C4rP04s9qQfKqeTatlrUT57I
         N45A==
X-Gm-Message-State: ALoCoQkE+CC/TfxMd3fTrdbrAqzXHwyL02fmu+yxLoO22gpNM7PsLHPn16HV7Ubs5NcrOkfvVZ6R
X-Received: by 10.152.87.176 with SMTP id az16mr13412894lab.43.1400450710509;
        Sun, 18 May 2014 15:05:10 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.05.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:05:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249523>

Test that empty patches are handled correctly, both with and without
the guilt.diffstat configuration option.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-020.out | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-020.sh  |  60 ++++++++++++
 2 files changed, 329 insertions(+)

diff --git a/regression/t-020.out b/regression/t-020.out
index af45734..42433dc 100644
--- a/regression/t-020.out
+++ b/regression/t-020.out
@@ -1128,3 +1128,272 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
 f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
 f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
 f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% guilt new empty.patch
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty.patch
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.patch
+f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
+r c7a139f532a43c3c8b0e068cac04f8f6af0f94e1  .git/refs/patches/master/empty.patch
+% git log -p
+commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch empty.patch
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% git config guilt.diffstat true
+% guilt refresh
+Patch empty.patch refreshed
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty.patch
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty.patch
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.patch~
+f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
+r c7a139f532a43c3c8b0e068cac04f8f6af0f94e1  .git/refs/patches/master/empty.patch
+% git log -p
+commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch empty.patch
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% git config guilt.diffstat false
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty.patch
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ad87a0bdb8cf0a57cfc384633edabbb9c2bfa1b  .git/patches/master/empty.patch
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/empty.patch~
+f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
+r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/empty.patch
+% git log -p
+commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
+Author: Per Cederqvist <ceder@lysator.liu.se>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    Fix a bug.
+    
+    This commit fixes a serious bug.
+    
+    FIXME:
+        - add a test case
+        - track down the bug
+        - actually fix it
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% git config guilt.diffstat true
+% guilt refresh
+Patch empty.patch refreshed
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty.patch
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 0803c721968056410df61400bb239380d033b9d5  .git/patches/master/empty.patch
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ad87a0bdb8cf0a57cfc384633edabbb9c2bfa1b  .git/patches/master/empty.patch~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
+f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
+r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/empty.patch
+% git log -p
+commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
+Author: Per Cederqvist <ceder@lysator.liu.se>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    Fix a bug.
+    
+    This commit fixes a serious bug.
+    
+    FIXME:
+        - add a test case
+        - track down the bug
+        - actually fix it
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% git config guilt.diffstat false
+% guilt refresh
+Patch empty.patch refreshed
+% guilt pop
+All patches popped.
+% guilt push
+Applying patch..empty.patch
+Patch applied.
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 0803c721968056410df61400bb239380d033b9d5  .git/patches/master/empty.patch~
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7ad87a0bdb8cf0a57cfc384633edabbb9c2bfa1b  .git/patches/master/empty.patch
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
+f e90b964f01cbef60bbe00c38c55d9ea86618a66a  .git/patches/master/status
+r 8ed27228b117c0c88abf3d586bcc43c68e975cea  .git/refs/patches/master/empty.patch
+% git log -p
+commit 8ed27228b117c0c88abf3d586bcc43c68e975cea
+Author: Per Cederqvist <ceder@lysator.liu.se>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    Fix a bug.
+    
+    This commit fixes a serious bug.
+    
+    FIXME:
+        - add a test case
+        - track down the bug
+        - actually fix it
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
+% guilt delete empty.patch
+Cannot delete an applied patch
+% guilt pop -a
+All patches popped.
+% guilt delete -f empty.patch
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 0803c721968056410df61400bb239380d033b9d5  .git/patches/master/empty.patch~
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f da39a3ee5e6b4b0d3255bfef95601890afd80709  .git/patches/master/status
+% git log -p
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+    
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
diff --git a/regression/t-020.sh b/regression/t-020.sh
index cdd08ba..c165884 100755
--- a/regression/t-020.sh
+++ b/regression/t-020.sh
@@ -5,6 +5,13 @@
 
 source "$REG_DIR/scaffold"
 
+function fixup_time_info
+{
+	cmd guilt pop
+	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
+	cmd guilt push
+}
+
 cmd setup_repo
 
 #
@@ -69,6 +76,59 @@ done
 
 cmd list_files
 
+# push an empty patch with no commit message
+cmd guilt new empty.patch
+fixup_time_info empty.patch
+cmd list_files
+cmd git log -p
+
+# Ensure we can push the empty patch even when guilt.diffstat is true.
+cmd git config guilt.diffstat true
+cmd guilt refresh
+fixup_time_info empty.patch
+cmd list_files
+cmd git log -p
+cmd git config guilt.diffstat false
+
+# Let the patch have a commit message, but no data.
+cat > .git/patches/master/empty.patch <<EOF
+Fix a bug.
+
+From: Per Cederqvist <ceder@lysator.liu.se>
+
+This commit fixes a serious bug.
+
+FIXME:
+    - add a test case
+    - track down the bug
+    - actually fix it
+EOF
+
+fixup_time_info empty.patch
+cmd list_files
+cmd git log -p
+
+# And once more, with an empty diffstat.
+
+cmd git config guilt.diffstat true
+cmd guilt refresh
+fixup_time_info empty.patch
+cmd list_files
+cmd git log -p
+
+# Restore the diffstat setting and remove the empty patch.
+cmd git config guilt.diffstat false
+cmd guilt refresh
+fixup_time_info empty.patch
+cmd list_files
+cmd git log -p
+# (Cannot delete an applied patch)
+shouldfail guilt delete empty.patch
+cmd guilt pop -a
+cmd guilt delete -f empty.patch
+cmd list_files
+cmd git log -p
+
 # FIXME:
 #   --all
 #   -a
-- 
1.8.3.1

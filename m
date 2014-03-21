From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 08/28] Added more test cases for "guilt new": empty patches.
Date: Fri, 21 Mar 2014 08:31:46 +0100
Message-ID: <1395387126-13681-9-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyN-0003fs-4U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759643AbaCUHd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:28 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:56049 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbaCUHdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:12 -0400
Received: by mail-la0-f44.google.com with SMTP id hr13so1409870lab.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLZ1P2FIfQVGemunsiBoJgFNbggh22sEGIfpsyR6Owo=;
        b=jkMpVm3Bm5iHolBb4/g3smc9Fq9qRJgDxzuSv3rZ0NNCfCYBcRjI53MHwrmBj6PbYI
         rBeVfRmp35Hxq9/0HVEyUQ3jeYp9f18td2TfIc42sw/pxsafOEafV7y7B9OiHnHr0hSD
         SqSNYFckSUtjBnOzbcXXtTYH/qhWALcq2zV8mkKTt4P+IkLqwsPc1Yj6/E5Za4rlHCuP
         FQpxfy4kV6SB0ecam5u/qUA7b/WqIYuj4bmJZk0ObHOsJXsAJPM+qj8FYGBDo+yxwOaO
         EvEk18e6YHYv25vJ7HK3Fhmb4YGDITDGaYv+n3VLbDEcxZe7n1jaZte/sWvv4Zu4yEpq
         jypw==
X-Gm-Message-State: ALoCoQn2EDb7pnKtN46pD5vgEFGD/XNipTxnv0+8Y3hMo5W1xNZL/JUfmh9ePS+tvDFi3D6uZsK9
X-Received: by 10.153.7.200 with SMTP id de8mr32867017lad.19.1395387190974;
        Fri, 21 Mar 2014 00:33:10 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244665>

Test that empty patches are handled correctly, both with and without
the guilt.diffstat configuration option.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-020.out | 250 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-020.sh  |  60 +++++++++++++
 2 files changed, 310 insertions(+)

diff --git a/regression/t-020.out b/regression/t-020.out
index af45734..7e07efa 100644
--- a/regression/t-020.out
+++ b/regression/t-020.out
@@ -1128,3 +1128,253 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
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
+---
+
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
+f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty.patch~
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+f d15a1d2d34493f790c78ddacb8815b0b9536ee2b  .git/patches/master/series
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
+f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty.patch~
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
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 7d261b8caad0f161c21daf5de65eeb521ff8c067  .git/patches/master/empty.patch~
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
index cdd08ba..906aec6 100755
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
+cat .git/patches/master/empty.patch <<EOF
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

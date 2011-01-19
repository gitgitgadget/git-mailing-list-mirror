From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] tests: cosmetic improvements to the repo-setup test
Date: Wed, 19 Jan 2011 06:38:22 -0600
Message-ID: <20110119123822.GB23222@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 13:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfXJD-0002MY-0x
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 13:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1ASMii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 07:38:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42396 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab1ASMih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 07:38:37 -0500
Received: by qwa26 with SMTP id 26so782193qwa.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kBIY7GL/D/q38e1fWW5ItpMBC8WhEaDBc4uhop1YAHY=;
        b=qE3brdTh17Ks9wca29eRBNoRnHb6yjZ2YQca95BP1eIniUjHCuKJRU3k7FfFnREW/F
         bxM62jlmKHnslojgSs9a6EXji0f6f06W31yNsW/lCgolG2nrUGcPwQs13CIaMQ6VMFvd
         x2Zd2FqpntVqyWERbsO3rtzUYiN6AHpwQykIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cWT2R3RaBxXlxNGYiljXQzJx8udKBfYgK9WF+EOBCxJTYNVXijzS+IjHkz/UVYPU+G
         6fF4YXqtJ/s0yuKNdzezBjKdXZscGOLOpKKmW+IHYepsPSR0M9Lc+zxk7j8y/TKZbfHU
         gmjH2Akz0JPiSKZWefxeLx/Ql42Nb7dhu0+Rw=
Received: by 10.229.246.196 with SMTP id lz4mr596298qcb.39.1295440714178;
        Wed, 19 Jan 2011 04:38:34 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id g32sm4680189qck.22.2011.01.19.04.38.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 04:38:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119123732.GA23222@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165264>

Give an overview in "sh t1510-repo-setup.sh --help" output.
Waste some vertical and horizontal space for clearer code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1510-repo-setup.sh |   94 ++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e9c451c..f42f206 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1,53 +1,59 @@
 #!/bin/sh
 
-test_description='Tests of cwd/prefix/worktree/gitdir setup in all cases'
+test_description="Tests of cwd/prefix/worktree/gitdir setup in all cases
 
+A few rules for repo setup:
+
+1. GIT_DIR is relative to user's cwd. --git-dir is equivalent to
+   GIT_DIR.
+
+2. .git file is relative to parent directory. .git file is basically
+   symlink in disguise. The directory where .git file points to will
+   become new git_dir.
+
+3. core.worktree is relative to git_dir.
+
+4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
+   equivalent to GIT_WORK_TREE.
+
+5. GIT_WORK_TREE/core.worktree is only effective if GIT_DIR is set
+   Uneffective worktree settings should be warned.
+
+6. Effective GIT_WORK_TREE overrides core.worktree and core.bare
+
+7. Effective core.worktree conflicts with core.bare
+
+8. If GIT_DIR is set but neither worktree nor bare setting is given,
+   original cwd becomes worktree.
+
+9. If .git discovery is done inside a repo, the repo becomes a bare
+   repo. .git discovery is performed if GIT_DIR is not set.
+
+10. If no worktree is available, cwd remains unchanged, prefix is
+    NULL.
+
+11. When user's cwd is outside worktree, cwd remains unchanged,
+    prefix is NULL.
+"
 . ./test-lib.sh
 
-#
-# A few rules for repo setup:
-#
-# 1. GIT_DIR is relative to user's cwd. --git-dir is equivalent to
-#    GIT_DIR.
-#
-# 2. .git file is relative to parent directory. .git file is basically
-#    symlink in disguise. The directory where .git file points to will
-#    become new git_dir.
-#
-# 3. core.worktree is relative to git_dir.
-#
-# 4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
-#    equivalent to GIT_WORK_TREE.
-#
-# 5. GIT_WORK_TREE/core.worktree is only effective if GIT_DIR is set
-#    Uneffective worktree settings should be warned.
-#
-# 6. Effective GIT_WORK_TREE overrides core.worktree and core.bare
-#
-# 7. Effective core.worktree conflicts with core.bare
-#
-# 8. If GIT_DIR is set but neither worktree nor bare setting is given,
-#    original cwd becomes worktree.
-#
-# 9. If .git discovery is done inside a repo, the repo becomes a bare
-#    repo. .git discovery is performed if GIT_DIR is not set.
-#
-# 10. If no worktree is available, cwd remains unchanged, prefix is
-#     NULL.
-#
-# 11. When user's cwd is outside worktree, cwd remains unchanged,
-#     prefix is NULL.
-#
-
-test_repo() {
+test_repo () {
 	(
-	cd "$1" &&
-	if test -n "$2"; then GIT_DIR="$2" && export GIT_DIR; fi &&
-	if test -n "$3"; then GIT_WORK_TREE="$3" && export GIT_WORK_TREE; fi &&
-	rm -f trace &&
-	GIT_TRACE="`pwd`/trace" git symbolic-ref HEAD >/dev/null &&
-	grep '^setup: ' trace >result &&
-	test_cmp expected result
+		cd "$1" &&
+		if test -n "$2"
+		then
+			GIT_DIR="$2" &&
+			export GIT_DIR
+		fi &&
+		if test -n "$3"
+		then
+			GIT_WORK_TREE="$3" &&
+			export GIT_WORK_TREE
+		fi &&
+		rm -f trace &&
+		GIT_TRACE="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
+		grep '^setup: ' trace >result &&
+		test_cmp expected result
 	)
 }
 
-- 
1.7.4.rc2

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD3D1F991
	for <e@80x24.org>; Sat,  5 Aug 2017 06:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdHEGua (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 02:50:30 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38232 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHEGu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 02:50:29 -0400
Received: by mail-pg0-f48.google.com with SMTP id l64so15689556pge.5
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=+rrMKzZCYytLvyeNoxnW/jq17h7xzHfPY3rbWmuw0Q0=;
        b=tED/AsYpaXfNNOlR2k178lbdhkJ5wlvI0/s8gQluul4k185vBLRy6gddwuSnfdIDiy
         AZ/KZe5VBGCDlg26sR7tXIkiYT9a2YXjzETBL70dt+xXh7Jm9rqDYVvN8hHPAI16ERVi
         qBnute0GDu0sdNPlv6lSh8JHRk3eMQU5dr1mBPbhwhLrv4ibiBa1qZlsJo6145C4//Ze
         3OvM+r5jZ8QBii7R9WYNEXO8DfkCPd4OHYvndnca/aZ/nFhKiY4Q+1PDeP/BxPHpfaRR
         VnM/gdYXL2kBNDdAgRkSteolIxEXK5kGAFRgXV5Bf1EoQPWB/6EtvYazkBtct651gtPh
         LzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+rrMKzZCYytLvyeNoxnW/jq17h7xzHfPY3rbWmuw0Q0=;
        b=OCSwYTvYB5T94LAaM1BRENoR2q65AgUU0LdaL1q4ETN9hfalkupRDFp70HOsmYC/hQ
         f0vf8ZELKWi13+9eBk0grP3Th7xkTVjtBOXIykY8hhBDam2iaccnTg7BEYkB7jtKioAA
         s6sGwQgks+l2UYtkAdbzdxg/q3XyP7um68lMHCatxyUapzd/eiM2FdYWS58DGc0YUe1j
         t/1kVx1/fjPEj/0x8IQkMri/Xf2R51EzyUPuMOUvIYx/YwiTw94g0oCQKbZ10TaiyOdD
         O1H9SsEFucjR/++gPc+RFDd+KoR/vFhvPi0SFL2cjwZnccdl88ZwRyTBt4B7oZ5vYljM
         lvpg==
X-Gm-Message-State: AIVw113XUyRDwULYe5WWyZcGZqSGlwolBgExlzsiNsXZat+uK9PiWdI4
        Z2wV6BJET3prKxlLbFvqaw==
X-Received: by 10.99.126.85 with SMTP id o21mr4715766pgn.262.1501915828664;
        Fri, 04 Aug 2017 23:50:28 -0700 (PDT)
Received: from localhost ([2601:647:5100:4a0:8a6:e1ff:fe64:a87d])
        by smtp.gmail.com with ESMTPSA id e67sm2333897pfd.122.2017.08.04.23.50.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Aug 2017 23:50:28 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     git@vger.kernel.org
Subject: [PATCH] Drop some dashes from built-in invocations in scripts
Date:   Fri,  4 Aug 2017 23:49:05 -0700
Message-Id: <20170805064905.5948-1-mforney@mforney.org>
X-Mailer: git-send-email 2.13.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way, they still work even if the built-in symlinks aren't
installed.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
It looks like there was an effort to do this a number of years ago (through
`make remove-dashes`). These are just a few I noticed were still left in the
.sh scripts.

 git-merge-octopus.sh  | 2 +-
 git-merge-one-file.sh | 8 ++++----
 git-merge-resolve.sh  | 2 +-
 git-stash.sh          | 2 +-
 git-submodule.sh      | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index bcf0d92ec..6c390d6c2 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -100,7 +100,7 @@ do
 	if test $? -ne 0
 	then
 		gettextln "Simple merge did not work, trying automatic merge."
-		git-merge-index -o git-merge-one-file -a ||
+		git merge-index -o git-merge-one-file -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
 	fi
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 424b034e3..9879c5939 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -115,16 +115,16 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	src1=$(git-unpack-file $2)
-	src2=$(git-unpack-file $3)
+	src1=$(git unpack-file $2)
+	src2=$(git unpack-file $3)
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
-		orig=$(git-unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
+		orig=$(git unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
 		;;
 	*)
 		echo "Auto-merging $4"
-		orig=$(git-unpack-file $1)
+		orig=$(git unpack-file $1)
 		;;
 	esac
 
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index c9da747fc..343fe7bcc 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -45,7 +45,7 @@ then
 	exit 0
 else
 	echo "Simple merge failed, trying Automatic merge."
-	if git-merge-index -o git-merge-one-file -a
+	if git merge-index -o git-merge-one-file -a
 	then
 		exit 0
 	else
diff --git a/git-stash.sh b/git-stash.sh
index 9b6c2da7b..9aa09c3a3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -573,7 +573,7 @@ apply_stash () {
 
 	if test -n "$u_tree"
 	then
-		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
+		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
 		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
 		rm -f "$TMPindex" ||
 		die "$(gettext "Could not restore untracked files from stash entry")"
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760ee..ffa2d6648 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -864,7 +864,7 @@ cmd_summary() {
 				test $status != A && test $ignore_config = all && continue
 			fi
 			# Also show added or modified modules which are checked out
-			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
+			GIT_DIR="$sm_path/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
 			printf '%s\n' "$sm_path"
 		done
 	)
@@ -898,11 +898,11 @@ cmd_summary() {
 		missing_dst=
 
 		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
 		missing_src=t
 
 		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
+		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
 		missing_dst=t
 
 		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
-- 
2.13.3


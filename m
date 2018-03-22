Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495F41F404
	for <e@80x24.org>; Thu, 22 Mar 2018 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeCVUDd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 16:03:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33642 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeCVUDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 16:03:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id c11-v6so6012448plo.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGQWhULYn8ke6RhQomx05prqj6AaHouctM+LzkClNlo=;
        b=TlqxTdnJk8XUotjw902GkEe8MInr/EzNfkFg/HzaGeXTdcJc82BseDnCx1eRM7AyvT
         X/uGMGe/CZF1vjV0CtVQ8zGVpV+8ZCzZeCN2k+ZoZl6nXxDO539l6bcvDvmI1toMIRhR
         lt6LPmYtFa6+8WbfAqPbZF7Upfe7CesKcCYkQ+fyOSJBCPhPzFcu/TrH5Q3W5tJwy+l4
         dNScN4U2NRlzDSV8/jQJ0/9ufsDIAntM7Lx8mZoEDmRPk9deKJrkgNAiBO6WW/j3Hs/V
         7t0f840cDcTcSuCx2vlYd4pR1pV//2Gq8O5Jmy0YROy6HzEn4eVxKvpnBXmAgwmFTL26
         uOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGQWhULYn8ke6RhQomx05prqj6AaHouctM+LzkClNlo=;
        b=D2c7cJANj9Egi74d+BHQifKQR6F5388ySXRUa2PAonEOAcfEtmD7l5fZHaD/+OAmSz
         AAywKvj4f5dJjVLOlrBHACfp/S1tIGmr4Xg/ei4T9LN///FdaPEfzjY4cq5DwbIH0+JQ
         /PAFCT1t9CurdENZQvnZH0tINbADRmGCD56VbVgzBTdBmcM+lhS3jT3zCbbehQxCMVQj
         NwP88eaBsZHuJqiiC80sXkxFmPen7aDJRJ017JkBuCK7TiHCXzS8X/7YU6ncOnkRUViS
         y1SiwYfjVn1uX5EFxaLelDArgGb6T9S4VVEzGuzoV02H1M7bQzk5mi30Z7iAXyeRszl2
         VbHA==
X-Gm-Message-State: AElRT7H9Hk/+V1fDeZ2JUuaEDwna8fHFcOtpcdSFMrf0EpdwRI7qNGdm
        XBl1QBN6dISyleEZC4ymecaMXCIKU2o=
X-Google-Smtp-Source: AG47ELtzdduMDzcmCPQjfG795wgaF3Cs4h0C1tlQJKoxw5OuRDoBndZ8PVbK5Cbdbke1yMSTpSaK3w==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12-v6mr26580619plr.313.1521749010823;
        Thu, 22 Mar 2018 13:03:30 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id x5sm13532170pfm.49.2018.03.22.13.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 13:03:29 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v3.1 2/9 2/2] rebase-interactive: Do not automatically run code
Date:   Thu, 22 Mar 2018 13:03:24 -0700
Message-Id: <7ce3cfef9ff3ab97ac8292fae94a0024a1d85505.1521748846.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
References: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At Junio's suggestion have git-rebase--am and git-rebase--merge work the
same way as git-rebase--interactive. This makes the code more consistent.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--am.sh          | 17 ++++++-----------
 git-rebase--interactive.sh |  8 +++++++-
 git-rebase--merge.sh       | 17 ++++++-----------
 git-rebase.sh              | 13 ++++---------
 4 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index be3f06892..47dc69ed9 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,17 +4,14 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
+# The whole contents of this file is loaded by dot-sourcing it from
+# inside another shell function, hence no shebang on the first line
+# and then the caller invokes git_rebase__am.
 #
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
+# Previously this file was sourced and it called itself to get this
+# was to get around a bug in older (9.x) versions of FreeBSD.
 git_rebase__am () {
-
+echo "git_rebase_am:+" 1>&5
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" \
@@ -105,5 +102,3 @@ fi
 move_to_original_branch
 
 }
-# ... and then we call the whole thing.
-git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 213d75f43..48f358333 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,8 +740,14 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
+# The whole contents of this file is loaded by dot-sourcing it from
+# inside another shell function, hence no shebang on the first line
+# and then the caller invokes git_rebase__interactive.
+#
+# Previously this file was sourced and it called itself to get this
+# was to get around a bug in older (9.x) versions of FreeBSD.
 git_rebase__interactive () {
-
+echo "git_rebase_interactive:+" 1>&5
 case "$action" in
 continue)
 	if test ! -d "$rewritten"
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index ceb715453..71de80788 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -104,17 +104,14 @@ finish_rb_merge () {
 	say All done.
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
+# The whole contents of this file is loaded by dot-sourcing it from
+# inside another shell function, hence no shebang on the first line
+# and then the caller invokes git_rebase__merge.
 #
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
+# Previously this file was sourced and it called itself to get this
+# was to get around a bug in older (9.x) versions of FreeBSD.
 git_rebase__merge () {
-
+echo "git_rebase_merge:+" 1>&5
 case "$action" in
 continue)
 	read_state
@@ -171,5 +168,3 @@ done
 finish_rb_merge
 
 }
-# ... and then we call the whole thing.
-git_rebase__merge
diff --git a/git-rebase.sh b/git-rebase.sh
index c4ec7c21b..4595a316a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -196,15 +196,10 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	if test "$type" = interactive
-	then
-		. git-rebase--interactive
-		git_rebase__interactive
-		ret=$?
-	else
-		. git-rebase--$type
-		ret=$?
-	fi
+	# Source the code and invoke it
+	. git-rebase--$type
+	git_rebase__$type
+	ret=$?
 	if test $ret -eq 0
 	then
 		finish_rebase
-- 
2.16.2


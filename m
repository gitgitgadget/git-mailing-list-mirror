Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3EE20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbdK0RVj (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:21:39 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40673 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932281AbdK0RVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:21:36 -0500
Received: by mail-pl0-f68.google.com with SMTP id 62so8860317plc.7
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZvmBPM04Yh3kItw+qE6TSLKNnd7B/Amgi+/u3qulaQ=;
        b=fyrWjPhoukG2bULAvC/aiYNddnU2+wK/hiDdCdmI5uAKP6bmuH3pd1RBLpvQOThDmq
         KDsW2eBh2w0/zi62ROWoUWP/cm8NYjimFhWKup/0aoNIbrb+1nRY10T4shZD8EmJxZ2G
         fW8SKVMk54l50m6YUM/w4d+DOnWJEFclr38i0qxnM/z2ygpy4DhP0zETczgWL72S1VcD
         LGxCm+MnYm5vb/Sr6hbzhY1E7b3+RWaGogxPqXNS+LWzIhu6HLTmipbIR6vEJDeFzDPt
         So9caWWyxovFbVlr80nhpD5rNEs46JmGrgdr5SiPFejX94HtxwXv9COvN4JrIAoiWFOF
         8zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZvmBPM04Yh3kItw+qE6TSLKNnd7B/Amgi+/u3qulaQ=;
        b=DR5aEeC4gplYt1QJlOqW9MRVBSjl+WqUii+DZd8iDpjr0aGs2LaoeEc4aUvguU0BNf
         Jtibooyj9gvskelax5HFN/A/YaV2ZAAZOszcG51sY9zJPHqHTa2JiwjVzH4mnyNeF7v1
         P+tF4MNMeJbi/Yjhb34lR5mlSDc3f8DA3XZZQAcP75ISV9zWUO+5q2x9Zupi4UYGerTq
         9iNnBkiIp8gb3U2UlPXP6IyeczGBZwbzI+VCUrmkV+AsuE1Xdkhcn7a6XJ0/pkODvnYZ
         B4cGSXxDGtFV+sJzfkhBddN0LwnmOuF1WQ7tyt68lGU/dKpdqEQBDuiPutzKKa3qJbLs
         /mng==
X-Gm-Message-State: AJaThX7DmlVa3RCYGtJJGqFoXLWbDPgfURMMKHLO9F2uYwkLnXEvZOEv
        FXYZiaMpqmfwhqeplYAZd5b8hhmC
X-Google-Smtp-Source: AGs4zMaASpw7SHatLTfhS2poypvpTbvGiSBdTMt3yFxOct2CJ0tX4mPGBOOdbiwketmow8hQDu6ZiQ==
X-Received: by 10.159.194.138 with SMTP id y10mr39273866pln.85.1511803296041;
        Mon, 27 Nov 2017 09:21:36 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id o88sm49573712pfj.175.2017.11.27.09.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:21:35 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 1/3] rebase: use a more appropriate variable name
Date:   Mon, 27 Nov 2017 22:51:02 +0530
Message-Id: <20171127172104.5796-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
 <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable name "branch_name" used to indicate the <branch> parameter
in "git rebase <upstream> <branch>" is misleading as it seems to indicate
that it holds only a "branch name" although at times it might actually hold
any valid <ref> (branch/commit).

So, use a more suitable name for that variable.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6344e8d5e..a675cf691 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -518,36 +518,40 @@ case "$onto_name" in
 esac
 
 # If the branch to rebase is given, that is the branch we will rebase
-# $branch_name -- branch being rebased, or HEAD (already detached)
+# $branch_or_commit -- branch/commit being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
 # $head_name -- refs/heads/<that-branch> or "detached HEAD"
 switch_to=
 case "$#" in
 1)
 	# Is it "rebase other $branchname" or "rebase other $commit"?
-	branch_name="$1"
+	branch_or_commit="$1"
 	switch_to="$1"
 
-	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+	# Is it a local branch?
+	if git show-ref --verify --quiet -- "refs/heads/$branch_or_commit" &&
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$branch_or_commit")
 	then
-		head_name="refs/heads/$1"
-	elif orig_head=$(git rev-parse -q --verify "$1")
+		head_name="refs/heads/$branch_or_commit"
+
+	# If not is it a valid ref (branch or commit)?
+	elif orig_head=$(git rev-parse -q --verify "$branch_or_commit")
 	then
 		head_name="detached HEAD"
+
 	else
-		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
+		die "$(eval_gettext "fatal: no such branch/commit: \$branch_or_commit")"
 	fi
 	;;
 0)
 	# Do not need to switch branches, we are already on it.
-	if branch_name=$(git symbolic-ref -q HEAD)
+	if branch_or_commit=$(git symbolic-ref -q HEAD)
 	then
-		head_name=$branch_name
-		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
+		head_name=$branch_or_commit
+		branch_or_commit=$(expr "z$branch_or_commit" : 'zrefs/heads/\(.*\)')
 	else
 		head_name="detached HEAD"
-		branch_name=HEAD ;# detached
+		branch_or_commit="HEAD"
 	fi
 	orig_head=$(git rev-parse --verify HEAD) || exit
 	;;
@@ -598,11 +602,11 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		say "$(eval_gettext "Current branch \$branch_or_commit is up to date.")"
 		finish_rebase
 		exit 0
 	else
-		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		say "$(eval_gettext "Current branch \$branch_or_commit is up to date, rebase forced.")"
 	fi
 fi
 
@@ -632,7 +636,7 @@ git update-ref ORIG_HEAD $orig_head
 # we just fast-forwarded.
 if test "$mb" = "$orig_head"
 then
-	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
+	say "$(eval_gettext "Fast-forwarded \$branch_or_commit to \$onto_name.")"
 	move_to_original_branch
 	finish_rebase
 	exit 0
-- 
2.15.0.345.gf926f18f3


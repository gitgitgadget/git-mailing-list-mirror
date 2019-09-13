Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8E31F463
	for <e@80x24.org>; Fri, 13 Sep 2019 06:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfIMGCf (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 02:02:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMGCe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 02:02:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id x2so1318253wmj.2
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 23:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyuCDH4YuHQuGDaAQOd3F8tG6NatOU4kU4wkjNawodw=;
        b=N/aTRUOPvwE/ojZLAi1Yntojo9mrQTWvVipRkwdwPrbItPPlbmFa/k18Sy6fhn0bPQ
         aUG3Mj2EJOsZjiKvKx+3/fk28xlOs7nA+bAaFPNP92Kj31qdfNy7RgwBKKV80UZayEZQ
         A0MR6CKmD9EjRUuqHs+kGUARslbeeA/zjZDzVA7EFFp/OrB+4pMmlKZ9ZocYrJulXPvw
         zCORf9PO78S2negH1Zbp6S2mQxkJOXajz9Rnau1Dk3bTILLOvvaEHBNrk+QmFvNJzmTX
         0tEIdoJytrwWtldAxYKSsYrKbYCtlkzFN1waneRepZJYaJtwzy/e0w3ZxSBKNV0YTycM
         pwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyuCDH4YuHQuGDaAQOd3F8tG6NatOU4kU4wkjNawodw=;
        b=FTei89d9EITF9FmsfbOoBJIklJtqBz55is8HdZaJXkKLxd/VxOXn9pNw+DAKE3na6z
         v7/EBGttGBZYmY0h5OXHWq9DsezQ+CyA18y2UJsdUpUQVRHWUCrHaq4ZiW6Eu6TGbXeJ
         aKuA4MsM+Kj8cUMprP4Tx1c7+4inbLJvY2s8HGOJbNOyvZ93lnjQK202E68krx4syF0f
         P70oiw2a9LyJDeDkHADmgQX8xRRJNoE8xRWw4LVzxH2tqBFNZFNi7jj/d4ZBGemF2wAE
         uFWaC5x2OSTyOcNZRLtRxjJR8Fm1yCCuBh214dY6IOMXqRWOuVWR1V+7Rev2bINZHoWZ
         elGg==
X-Gm-Message-State: APjAAAUxRv73/0WcQpVmMj47GYf7srK6srYYqD4LXGKLQj0TB+Zwt3yy
        2+U9kk6wXXWy/8vg7ndEQA==
X-Google-Smtp-Source: APXvYqzUcdwxiku0c1QZsLwe57hNdz429kcDWmYQDon8ZiMy4vDKKCqrfsA/+6tDvyfkW4A9m+iIGA==
X-Received: by 2002:a1c:cbcc:: with SMTP id b195mr1973446wmg.80.1568354551892;
        Thu, 12 Sep 2019 23:02:31 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id y186sm1273326wmd.26.2019.09.12.23.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 23:02:31 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH] git-gui: convert new/amend commit radiobutton to checketton
Date:   Fri, 13 Sep 2019 08:02:30 +0200
Message-Id: <a2026a3d310f90b70a191e2c24106d600195d2b1.1568354429.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
In-Reply-To: <b3f1cd2b-7462-89fd-ff2d-9e53da286027@iee.email>
References: <b3f1cd2b-7462-89fd-ff2d-9e53da286027@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its a bi-state anyway and also saves one line in the menu.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh          | 36 +++++++++---------------------------
 lib/checkout_op.tcl |  6 +++---
 lib/commit.tcl      |  4 ++--
 lib/index.tcl       |  8 ++++----
 4 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..80a07d5 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1341,6 +1341,7 @@ set HEAD {}
 set PARENT {}
 set MERGE_HEAD [list]
 set commit_type {}
+set commit_type_is_amend 0
 set empty_tree {}
 set current_branch {}
 set is_detached 0
@@ -1348,7 +1349,6 @@ set current_diff_path {}
 set is_3way_diff 0
 set is_submodule_diff 0
 set is_conflict_diff 0
-set selected_commit_type new
 set diff_empty_count 0
 
 set nullid "0000000000000000000000000000000000000000"
@@ -1435,7 +1435,7 @@ proc PARENT {} {
 }
 
 proc force_amend {} {
-	global selected_commit_type
+	global commit_type_is_amend
 	global HEAD PARENT MERGE_HEAD commit_type
 
 	repository_state newType newHEAD newMERGE_HEAD
@@ -1444,7 +1444,7 @@ proc force_amend {} {
 	set MERGE_HEAD $newMERGE_HEAD
 	set commit_type $newType
 
-	set selected_commit_type amend
+	set commit_type_is_amend 1
 	do_select_commit_type
 }
 
@@ -2828,19 +2828,10 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
 	if {![is_enabled nocommit]} {
-		.mbar.commit add radiobutton \
-			-label [mc "New Commit"] \
-			-command do_select_commit_type \
-			-variable selected_commit_type \
-			-value new
-		lappend disable_on_lock \
-			[list .mbar.commit entryconf [.mbar.commit index last] -state]
-
-		.mbar.commit add radiobutton \
+		.mbar.commit add checkbutton \
 			-label [mc "Amend Last Commit"] \
-			-command do_select_commit_type \
-			-variable selected_commit_type \
-			-value amend
+			-variable commit_type_is_amend \
+			-command do_select_commit_type
 		lappend disable_on_lock \
 			[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
@@ -3313,18 +3304,10 @@ set ui_comm .vpane.lower.commarea.buffer.frame.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
 
 if {![is_enabled nocommit]} {
-	${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
-		-text [mc "New Commit"] \
-		-command do_select_commit_type \
-		-variable selected_commit_type \
-		-value new
-	lappend disable_on_lock \
-		[list .vpane.lower.commarea.buffer.header.new conf -state]
-	${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
+	${NS}::checkbutton .vpane.lower.commarea.buffer.header.amend \
 		-text [mc "Amend Last Commit"] \
-		-command do_select_commit_type \
-		-variable selected_commit_type \
-		-value amend
+		-variable commit_type_is_amend \
+		-command do_select_commit_type
 	lappend disable_on_lock \
 		[list .vpane.lower.commarea.buffer.header.amend conf -state]
 }
@@ -3349,7 +3332,6 @@ pack $ui_coml -side left -fill x
 
 if {![is_enabled nocommit]} {
 	pack .vpane.lower.commarea.buffer.header.amend -side right
-	pack .vpane.lower.commarea.buffer.header.new -side right
 }
 
 textframe .vpane.lower.commarea.buffer.frame
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 9e7412c..a522829 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -389,7 +389,7 @@ $err
 }
 
 method _after_readtree {} {
-	global selected_commit_type commit_type HEAD MERGE_HEAD PARENT
+	global commit_type HEAD MERGE_HEAD PARENT
 	global current_branch is_detached
 	global ui_comm
 
@@ -490,12 +490,12 @@ method _update_repo_state {} {
 	#    amend mode our file lists are accurate and we can avoid
 	#    the rescan.
 	#
-	global selected_commit_type commit_type HEAD MERGE_HEAD PARENT
+	global commit_type_is_amend commit_type HEAD MERGE_HEAD PARENT
 	global ui_comm
 
 	unlock_index
 	set name [_name $this]
-	set selected_commit_type new
+	set commit_type_is_amend 0
 	if {[string match amend* $commit_type]} {
 		$ui_comm delete 0.0 end
 		$ui_comm edit reset
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 83620b7..384f18f 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -327,7 +327,7 @@ proc commit_writetree {curHEAD msg_p} {
 proc commit_committree {fd_wt curHEAD msg_p} {
 	global HEAD PARENT MERGE_HEAD commit_type commit_author
 	global current_branch
-	global ui_comm selected_commit_type
+	global ui_comm commit_type_is_amend
 	global file_states selected_paths rescan_active
 	global repo_config
 	global env
@@ -461,8 +461,8 @@ A rescan will be automatically started now.
 
 	# -- Update in memory status
 	#
-	set selected_commit_type new
 	set commit_type normal
+	set commit_type_is_amend 0
 	set HEAD $cmt_id
 	set PARENT $cmt_id
 	set MERGE_HEAD [list]
diff --git a/lib/index.tcl b/lib/index.tcl
index b588db1..e07b7a3 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -466,19 +466,19 @@ proc do_revert_selection {} {
 }
 
 proc do_select_commit_type {} {
-	global commit_type selected_commit_type
+	global commit_type commit_type_is_amend
 
-	if {$selected_commit_type eq {new}
+	if {$commit_type_is_amend == 0
 		&& [string match amend* $commit_type]} {
 		create_new_commit
-	} elseif {$selected_commit_type eq {amend}
+	} elseif {$commit_type_is_amend == 1
 		&& ![string match amend* $commit_type]} {
 		load_last_commit
 
 		# The amend request was rejected...
 		#
 		if {![string match amend* $commit_type]} {
-			set selected_commit_type new
+			set commit_type_is_amend 0
 		}
 	}
 }
-- 
2.21.0.789.ga095d9d866


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7934A1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfILToZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:44:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34654 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILToZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:44:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so190152wmc.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8veRIwQGRcFqztwPisQG4rzz7bfXIhiQZaUzawuY/BM=;
        b=o7mcOcqbIr78022aCZ6mZbNwuMFP1lchcWxZ4uUSY9Q1z24suvSIB8YANj5Vv73usc
         G2SjwaFzc+gTB+F4A64W32G7UYPtYpsDB9UF+uJJa/VTtSi+6VEwETLeQ8UmmnsXbQzy
         ULNzMqniiVN7fgmIc3q99tmLciERXqJAx192fI/5jz2cY2oEBvN94Fgma9ydxa7vcKuJ
         SI9zqrkpkQfMbf+9kkkaIsgE4ksahmuHG+CVTBIr+finxpnukVeoKmdLz6Z684upXFzC
         xNtpOK44m9lfM4aPmNZdS/DLR5DQb0XUsXi7CeRfg1fFkpGHULb3N2Cs3GfpcDN6SkvO
         ZkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8veRIwQGRcFqztwPisQG4rzz7bfXIhiQZaUzawuY/BM=;
        b=ULNg1LDkqK2kh597IumZ/1XpCKL6W8aHs8Ni45XAblCTSnBY6VFCJhcoShlo9Q2s7+
         U4Vd+QrAoRuVz1xdkBSlVv1ftmO9Fa3F6xVf0nIMsd/W1GER2EN/1zJODWjPJjp36C3b
         Xot2nAflFtfRKuO2QxZk2SndQxgQeaabXIboOisMjUfH6L+ymV4EhUHC7sCfJIWYUIez
         viUWdnAkMlCbHbp0yG+AlIUpzRg68Um7ua24oSW9Wuv3ErZ61lzW0T3dZB8xYvhJcaxZ
         XsZeISxECpnm3ALnrbjSabB+B2QF/VKGDRqPDDuGzlE2thQLL91ACO1InC/P0+sI2/z/
         NJkA==
X-Gm-Message-State: APjAAAVc+0HpXHXjHhRAcPUvifGspoNb0QcHsfzFVXx3iBOqFlbAwvuP
        fzI7ZXgHlMF4jfXFTk+uog==
X-Google-Smtp-Source: APXvYqzmqp8hF6d9xdsKxPojHeXx7fTK6eysbEGPhwc7+ObyOETa6fjfgwuDBh9NCC7JED/71tpDWg==
X-Received: by 2002:a1c:c013:: with SMTP id q19mr188749wmf.87.1568317460686;
        Thu, 12 Sep 2019 12:44:20 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id d28sm31172707wrb.95.2019.09.12.12.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 12:44:20 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] git-gui: convert new/amend commit radiobutton to checketton
Date:   Thu, 12 Sep 2019 21:44:19 +0200
Message-Id: <41ebf78fbe8af587c739c08aa6f20cf76c602775.1568317431.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its a bi-state anyway and also safes one line in the menu.

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


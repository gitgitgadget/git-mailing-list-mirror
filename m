Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D701F461
	for <e@80x24.org>; Thu,  5 Sep 2019 20:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfIEUJ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 16:09:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35134 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfIEUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 16:09:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so4540734wmj.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqcP9ZW8r5WXm6ChgEYeEPCjkwQthWfDkkA7xAuCBtQ=;
        b=Z6/UWsSbZe+GOT/bUIcmFqAZsqdpX9FXJ9rJjXQ4dMa1LP+9VDsXqIZFXEl3KGovFs
         5MuuBn8M5DHDI5hhnkGozR+zthhs3iuIMpQWe4ZrhWUeZBLMP8EhGvLxXEgJIZsDknHk
         CmFphD6rSvp2wRVw4xzfMfaGzV4xlQhtdILYP0GuKiG5aty5NYiy/AMw+bUQG5yRTWcV
         Yx2TWcZkHU2s04ZbpCNbJFBt2pYt7EZ41VRXlQGp2iC/CzxqfwrgrD2HwYwZpcDPI5YX
         +35VHAzZoDpWyJfDUZJe1suKerSWz3yrYwiPB2cpz8ocUWWOgkj+btQshSdoKrb1lnK0
         6BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqcP9ZW8r5WXm6ChgEYeEPCjkwQthWfDkkA7xAuCBtQ=;
        b=jRYKO7jXez7h0dLZYAcg5U88k9Z4cFZ+NQqOwT6tmj4dnVTJ1MQ6IjtFFB3T3IolaB
         xzkxEK0YJjuplQ9zxspjAq6Bfpz4AZIdhfuph+p4ouxKAJO1K/n/Q7c0lj3nLPp4Yidy
         gCyaSM6nkeIhXuXcpM/LVGpxoQi3d31AmCY5PFtzQtq4LUwFMsfgk/LvDyXIdTc++tbj
         EUp2mAF3uX9KRt594IyYoCSMYhOPQkfmVM6kMzr9reM4Wf3bNSce9fldTkNAuZeLreS4
         0DtM75ecQ5XlNYdzVoek2MKydXxK6k1NeRUAuPxGW0Nw2Wxka/oGBHGklk2klbeTxSj3
         4BRw==
X-Gm-Message-State: APjAAAUPsHynPzjma9Hy1TP6EzIkcEZneZDlCvtg0145w62DWSwzjtcb
        oSrRJwT6rZkyhpRGZj1Yuw==
X-Google-Smtp-Source: APXvYqxuj5Ma9LrOTfJL0JL9MEZ23ZiYvRc/IjWw7t10mL47IK0+4yDio/OlUf6BwuGSDrIfrvi9oA==
X-Received: by 2002:a05:600c:20c2:: with SMTP id y2mr4607621wmm.68.1567714194999;
        Thu, 05 Sep 2019 13:09:54 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:dd24:86d0:1477:aa12])
        by smtp.gmail.com with ESMTPSA id f66sm5132099wmg.2.2019.09.05.13.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 13:09:54 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/2] git-gui: convert new/amend commit radiobutton to checketton
Date:   Thu,  5 Sep 2019 22:09:52 +0200
Message-Id: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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


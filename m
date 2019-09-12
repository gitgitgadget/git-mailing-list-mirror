Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0453C1F464
	for <e@80x24.org>; Thu, 12 Sep 2019 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfILSlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:41:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38083 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfILSlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:41:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so20178504lfh.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZ3rfG3YJ5D7TyfVjWYV9qPPtx2XA8MJENkyP4xS6Vw=;
        b=G1GxNITcA9uuU4hwI8KdAlP/L94VTMXaP1epzFgkuxhlkEh7wgluovuZjk03mocf+D
         F/9ux+zkjwi2ysJf83/q2AYvrhDuRY5Yqmlua20DYKfZEyPZ1DH6HHzdS2Vg5lWYUg1C
         QBtGhgQNyJPY2pj2toNWIzKDqQ8pu0LWVefXXmbYuaFWkPOxLWlo56FFrDVOJUnOlwFt
         NQVnnlxJMddYv40ly+/Hh8XXy9mx9B8SoeNowUnJb4MqPQ+z5+hXQolkHRDp27aWmuax
         9q2HS6diBxbKLy+dfdDDSi5v++gblSgSJphJV6sFYCLS5aUJEC0L2hS+rJBH7Ipgj287
         qdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZ3rfG3YJ5D7TyfVjWYV9qPPtx2XA8MJENkyP4xS6Vw=;
        b=i1WeR9/1COSHxuSZVYKUbkX3eoxstjovL0mq4lywBhWOnFMNDo1XLw+qtQJ42ZX9tM
         DCeKtnisTrWOSfSsnsV2akuTCTSdHjOJKtlKVXD4aiJLyHlD0K22gqQm+moVZDzFA2l7
         njJiQFvBlFg3BJCJh0sugbPMn+PUySgmwnN44UUTcqYQmdB2xApuknyGuwYpm4/X5ciZ
         g42UR/oT8uYtMaE7Wesq185M9p5v7PVjK1Y7VF9xXieQn6OynrvuRhGERLSnv8peuZAB
         FnercZt0T+4RU94NlgOijumcclylcrPRRIRcm0HfTwWs2MjBlz+Yl6C6CLXreiJQdlJI
         LBtw==
X-Gm-Message-State: APjAAAWx6r0dBYpTpSJLN0Dt/Otc6gM4GVTu+AfnF8lHfOudMLaeESqD
        WVA2iy4VyqbXIBhucYd87i8=
X-Google-Smtp-Source: APXvYqzshmCFX2om1UfRKoS2JiWjka5OncJANUqOIL4JlBihPgi/uNkvVkmUM40DVd9BSZtXa5hlfQ==
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr6333974lfm.170.1568313695517;
        Thu, 12 Sep 2019 11:41:35 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id v26sm616054lfg.27.2019.09.12.11.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 11:41:35 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3] git-gui: add hotkey to toggle "Amend Last Commit"
Date:   Thu, 12 Sep 2019 20:41:00 +0200
Message-Id: <20190912184100.8212-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
References: <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
a hotkey.

With this patch, the user may toggle between the two options with
CTRL/CMD+e.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..ebe267f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1445,7 +1445,7 @@ proc force_amend {} {
 	set commit_type $newType
 
 	set selected_commit_type amend
-	do_select_commit_type
+	ui_select_commit_type
 }
 
 proc rescan {after {honor_trustmtime 1}} {
@@ -2640,6 +2640,16 @@ proc show_less_context {} {
 	}
 }
 
+proc toggle_commit_type {} {
+	global selected_commit_type
+	if {[string match amend* $selected_commit_type]} {
+		set selected_commit_type new
+	} else {
+		set selected_commit_type amend
+	}
+	ui_select_commit_type
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -2824,13 +2834,31 @@ proc commit_btn_caption {} {
 	}
 }
 
+proc ui_select_commit_type {} {
+	global selected_commit_type
+	global ui_commit_type_commit ui_commit_type_amend
+
+	do_select_commit_type
+	if {$selected_commit_type eq {new}} {
+		.mbar.commit entryconf [mc "New Commit"] \
+			-accelerator {}
+		.mbar.commit entryconf [mc "Amend Last Commit"] \
+			-accelerator $::M1T-E
+	} elseif {$selected_commit_type eq {amend}} {
+		.mbar.commit entryconf [mc "New Commit"] \
+			-accelerator $::M1T-E
+		.mbar.commit entryconf [mc "Amend Last Commit"] \
+			-accelerator {}
+	}
+}
+
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
 	if {![is_enabled nocommit]} {
 		.mbar.commit add radiobutton \
 			-label [mc "New Commit"] \
-			-command do_select_commit_type \
+			-command ui_select_commit_type \
 			-variable selected_commit_type \
 			-value new
 		lappend disable_on_lock \
@@ -2838,7 +2866,8 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 		.mbar.commit add radiobutton \
 			-label [mc "Amend Last Commit"] \
-			-command do_select_commit_type \
+			-accelerator $M1T-E \
+			-command ui_select_commit_type \
 			-variable selected_commit_type \
 			-value amend
 		lappend disable_on_lock \
@@ -3315,14 +3344,14 @@ set ui_coml .vpane.lower.commarea.buffer.header.l
 if {![is_enabled nocommit]} {
 	${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
 		-text [mc "New Commit"] \
-		-command do_select_commit_type \
+		-command ui_select_commit_type \
 		-variable selected_commit_type \
 		-value new
 	lappend disable_on_lock \
 		[list .vpane.lower.commarea.buffer.header.new conf -state]
 	${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
 		-text [mc "Amend Last Commit"] \
-		-command do_select_commit_type \
+		-command ui_select_commit_type \
 		-variable selected_commit_type \
 		-value amend
 	lappend disable_on_lock \
@@ -3837,6 +3866,8 @@ bind .   <$M1B-Key-j> do_revert_selection
 bind .   <$M1B-Key-J> do_revert_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
+bind .   <$M1B-Key-e> toggle_commit_type
+bind .   <$M1B-Key-E> toggle_commit_type
 bind .   <$M1B-Key-minus> {show_less_context;break}
 bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
 bind .   <$M1B-Key-equal> {show_more_context;break}
-- 
2.21.0.windows.1


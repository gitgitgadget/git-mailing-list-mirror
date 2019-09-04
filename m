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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF541F461
	for <e@80x24.org>; Wed,  4 Sep 2019 14:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfIDObk (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 10:31:40 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40087 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIDObk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 10:31:40 -0400
Received: by mail-lj1-f178.google.com with SMTP id 7so10306126ljw.7
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmjPKJ3tFe90xC6TS2UtXu+1RBnF6ib6UhzXNx7Fnlo=;
        b=vVLVBnILzTw0WrsQPNVbg3vXse6E1U3vsWOmZbAPTerKCkhKKHY9JoUvjsA6Ijkw08
         9xQ2HhMrFI7LQtG6SczmK95xImwKooDpjJfXu2cQhzqTGVwVlVcrP8u6R96+uWadXPpV
         58Rf5jEZFA7kiXDTYgk+8ZNIpWapV7heHWKU+3fDJ0sUBd5x5ExzLoZk8LxpneMsGOof
         Qh12gmlgYEoUeKNp0ivNVwvRDuWyx+98/tK/kRU8FVqrVRT9NWwnBzTpq8j83R3cMlOt
         FDO7k+dmaEoykOfNAAoLzO4D8UDN3cm3c5Er/u+D2EGvC6ZcG5tUDFzlThCeMTfc5SQh
         jeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmjPKJ3tFe90xC6TS2UtXu+1RBnF6ib6UhzXNx7Fnlo=;
        b=F3CiMTyNdHmRhtW2z6GIdlXADhefH3LFWHUldPajV/Kuq+DjsFzCAjUTPysp9Pa0eo
         2qwPUZqycFacS8r8E663biWrjtth1yKJ3eQxHtW7sheF2LjEqMPz+15LSILXS3N6fOeU
         wBebsWmb+3cFuWZeuriiCrSDkgPmPqF3YGEF+dUF6/fzC3j3SPBDPFJa6SuAafzWBnaP
         U2FFppp6aAeeer3LbQC5FOyGoCiH67QEBF3z7OhJXp+ixdKyNG0Lgp849QmhMbxL0KqU
         dYCo8n7aVDIfCb1b0tP7loXZfN6GCrtIcf4kvbsV45OYIkvhyzq2SdnJr2msit8sbyRK
         VMTQ==
X-Gm-Message-State: APjAAAXLZ7SD32sFPugVg71PWQMuiIIBJcWQzuMx9lQ3UXeB45aiGX4x
        kIwxKCKTYxlrj+GyjfrNRUujZAeicMvADw==
X-Google-Smtp-Source: APXvYqxgJxDJqQC0gNZ7hByebMTAxfrEmNf4j1ufr7Ju92uqVjTSTrEesjI3gXrC8Df+9Imdvr2S4A==
X-Received: by 2002:a2e:8113:: with SMTP id d19mr1740858ljg.140.1567607497748;
        Wed, 04 Sep 2019 07:31:37 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id l15sm1749452lfh.48.2019.09.04.07.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 07:31:37 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com, Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH v5] git-gui: Add hotkeys to set widget focus
Date:   Wed,  4 Sep 2019 16:30:55 +0200
Message-Id: <20190904143055.11400-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user cannot change focus between the list of files, the diff view and
the commit message widgets without using the mouse (clicking either of
the four widgets).

With this patch, the user may set ui focus to the previously selected path
in either the "Unstaged Changes" or "Staged Changes" widgets, using
ALT+1 or ALT+2.

The user may also set the ui focus to the diff view widget with
ALT+3, or to the commit message widget with ALT+4.

This enables the user to select/unselect files, view the diff and create a
commit in git-gui using keyboard-only.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..5dae8da 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2495,7 +2495,7 @@ proc force_first_diff {after} {
 
 proc toggle_or_diff {mode w args} {
 	global file_states file_lists current_diff_path ui_index ui_workdir
-	global last_clicked selected_paths
+	global last_clicked selected_paths file_lists_last_clicked
 
 	if {$mode eq "click"} {
 		foreach {x y} $args break
@@ -2527,6 +2527,8 @@ proc toggle_or_diff {mode w args} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
+	set file_lists_last_clicked($w) $path
+
 	# Determine the state of the file
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
@@ -2640,6 +2642,26 @@ proc show_less_context {} {
 	}
 }
 
+proc focus_widget {widget} {
+	global file_lists last_clicked selected_paths
+	global file_lists_last_clicked
+
+	if {[llength $file_lists($widget)] > 0} {
+		set path $file_lists_last_clicked($widget)
+		set index [lsearch -sorted -exact $file_lists($widget) $path]
+		if {$index < 0} {
+			set index 0
+			set path [lindex $file_lists($widget) $index]
+		}
+
+		focus $widget
+		set last_clicked [list $widget [expr $index + 1]]
+		array unset selected_paths
+		set selected_paths($path) 1
+		show_diff $path $widget
+	}
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -3852,6 +3874,14 @@ foreach i [list $ui_index $ui_workdir] {
 }
 unset i
 
+bind .   <Alt-Key-1> {focus_widget $::ui_workdir}
+bind .   <Alt-Key-2> {focus_widget $::ui_index}
+bind .   <Alt-Key-3> {focus $::ui_diff}
+bind .   <Alt-Key-4> {focus $::ui_comm}
+
+set file_lists_last_clicked($ui_index) {}
+set file_lists_last_clicked($ui_workdir) {}
+
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-- 
2.21.0.windows.1


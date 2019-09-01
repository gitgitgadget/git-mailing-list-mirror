Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F2C1F461
	for <e@80x24.org>; Sun,  1 Sep 2019 19:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfIATg5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 15:36:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38920 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfIATg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 15:36:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so8910427lfk.6
        for <git@vger.kernel.org>; Sun, 01 Sep 2019 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IB0l9RsDXo8KD0Lw9WGbvkFuZr5QAUu+uJoVZRjgLYg=;
        b=NWv0Te24YDPnYQT88UEDkBWEZlq7QHm2y1u5Z7pudFZqhKUtwIRpAgd7dkG1o4GlZ5
         EXQ1F+VHzLOP5k8WkUr8HqKoaNuIHNMuIsHzkKDuEFSoGdSXY8vGuI4BwiStDNMZhd8O
         vGykbK6TSBSlSOJGna9DDINXj4qzCUg44uH3wOQH5rXXJBRdtRWhqIalydSrPlWaCffe
         d+j4L3zpy/x2xedxfg0t+qxBvoIy7ZyDrR8M+s0dPGlpeOy24A/j/AMD4sXgwQeZoeBG
         NEQfdhZuEu0wFP4yWHelrNH937bAM58uxg1e8qoKQfyxNHTsSMCzmf8wv0e9O8HwQcbL
         Wxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IB0l9RsDXo8KD0Lw9WGbvkFuZr5QAUu+uJoVZRjgLYg=;
        b=H567sMiESvpG0BwEwtyt8nY/AClaaELy7u6zDO8As3ZjYIPOWAW3M6H4qIpUXHqUWu
         /6KkQrz4bjrQ168ynE7IfYZGZw5wTEWzcZqgHBwDi5xADKpnjudLrU+7cGqTIzw9mhqA
         jT5nmQDo0t5nwE8sDZHH56VLP3BF5xLpwI+UcH59vM6j6rvaI2MEFIzF5hDT/tvofdSe
         IyV65+4fjR8Q/vBhSbM3iyYR86cKQCcaZ5ZBRBMHvtuN+020TN9O424+hqGlnCtI6uzg
         3gGcejFhxeHw4TixuXbunB+LFZHng87Htb/HMyeRrIYCdZu/5I5Qz7XkMgOuFyk2Fkd1
         KlPQ==
X-Gm-Message-State: APjAAAVVvDrYkbW+DzL67+t1SabohaR/8mhu/SpSlXWtGYJZP4cHMP1s
        8oLPOBq6p1m9xb2vdTgqwiCXdPgefh35aQ==
X-Google-Smtp-Source: APXvYqyFd+vbJsr8AEHcAQN7SZs0JxuDlPEt6HHG9EFVMFSQCj0ErVJ2vjPhJtKR9UwXSwn7zFxTYA==
X-Received: by 2002:ac2:48af:: with SMTP id u15mr7902544lfg.75.1567366615666;
        Sun, 01 Sep 2019 12:36:55 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id k13sm46070ljc.96.2019.09.01.12.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 12:36:55 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     me@yadavpratyush.com, git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
Date:   Sun,  1 Sep 2019 21:36:52 +0200
Message-Id: <20190901193652.21086-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.23.0.37.g745f681289
In-Reply-To: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
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
CTRL/CMD+1 or CTRL/CMD+2.

The user may also set the ui focus to the diff view widget with
CTRL/CMD+3, or to the commit message widget with CTRL/CMD+4.

This enables the user to select/unselect files, view the diff and create a
commit in git-gui using keyboard-only.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui.sh | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..ce620f1 100755
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
 
+	set file_lists_last_clicked($w) $lno
+
 	# Determine the state of the file
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
@@ -2640,6 +2642,29 @@ proc show_less_context {} {
 	}
 }
 
+proc select_path_in {widget} {
+	global file_lists last_clicked selected_paths ui_workdir
+	global file_lists_last_clicked
+
+	set _list_length [llength $file_lists($widget)]
+	if {$_list_length > 0} {
+
+		set _index $file_lists_last_clicked($widget)
+		if {$_index eq {}} {
+			set _index 1
+		} elseif {$_index > $_list_length} {
+			set _index $_list_length
+		}
+
+		focus $widget
+		set last_clicked [list $widget $_index]
+		set path [lindex $file_lists($widget) [expr $_index - 1]]
+		array unset selected_paths
+		set selected_paths($path) 1
+		show_diff $path $widget
+	}
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -3852,6 +3877,14 @@ foreach i [list $ui_index $ui_workdir] {
 }
 unset i
 
+bind . <$M1B-Key-1> {select_path_in $::ui_workdir}
+bind . <$M1B-Key-2> {select_path_in $::ui_index}
+bind . <$M1B-Key-3> {focus $::ui_diff}
+bind . <$M1B-Key-4> {focus $::ui_comm}
+
+set file_lists_last_clicked($ui_index) {}
+set file_lists_last_clicked($ui_workdir) {}
+
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-- 
2.23.0.37.g745f681289


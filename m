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
	by dcvr.yhbt.net (Postfix) with ESMTP id CABF71F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfICSHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:07:39 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:44340 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfICSHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:07:38 -0400
Received: by mail-lj1-f178.google.com with SMTP id u14so10428693ljj.11
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85b7yCfKNZZN7XH93GCKo6O4ySVpVP3Woa5oki0hxiA=;
        b=i1/dWF49VO7QQk15aeqta2/K8s5ytnkBnsVHzOYjPiVlsfHx3Kg8gvsAwer7xAIQPq
         mrOJ1GtnQMsxzVRbW02OogftkukMqZXVIi/SgzpsmSBYVH3pN7tMoo1T1l+kWNECUxTO
         6Go16CTFJ2pPsp2U5Ehx8KibrHh+9yKzQvxkm/igV3+fEZwv1v9z2vgcAyVG5d2XcC7Z
         o/Y0zl7L4OnxFZSWGJHue3eVgUVC8Yjpa9Brgpe4zm9VawWhc77Zp0cZt9ety7h3Zx9y
         0kP1vxiQr+e6IWPnZs1qk+PhSMFyYiPXOLene58IGV385lGwVBkzTMW5k8Ch0GoMaqnP
         ySBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85b7yCfKNZZN7XH93GCKo6O4ySVpVP3Woa5oki0hxiA=;
        b=YsFkH6clg1qZDE8cMmW1vkT24xsR8DmLqW5TYvSE1hA85Q1iuPx0Zrcp2ccHiYYQcx
         iT/HwytZTqIWBHQ6CQVo0VHIrz9htvDPAUN20reOnBLnyadgA+ywYs/MP1/O5olM0exH
         4rmEKVGn4UO33qxKuJRHop0TbLfCAQIiNNJqVsScqVpxvmwQaow1tKI3HgmWnbe20pI9
         pWyOO3OX8FFtHym9yOgVDBHI6Z2mFJAFhr+1rMpK7tvf4rOEHgqirDsQiuUm951HLGjU
         +K6JXjLBA8jBNKXpYfOEuvpMZ8DZXvXx1mfYwY/K9daaQeeic2LZG1/FjiXXIXuExJ8B
         Qojg==
X-Gm-Message-State: APjAAAUGdzz/5N3LY/rUCngV3pDcjmxyrTAJSJ1gwli0hvIAxb/rsiNS
        2EnQkwRbZrPKTTxoz8XoN6EPnuCPa4SWWQ==
X-Google-Smtp-Source: APXvYqwpZw8/uCxv6ZHoW+UGL3FaNg1CA+919w+ohB6kh972EgAKkcRWcXJmFipVGyXiKs+nccqkfg==
X-Received: by 2002:a2e:80c2:: with SMTP id r2mr20824871ljg.44.1567534056801;
        Tue, 03 Sep 2019 11:07:36 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id p10sm2493025lji.71.2019.09.03.11.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:07:36 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com, Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH v4] git-gui: Add hotkeys to set widget focus
Date:   Tue,  3 Sep 2019 20:07:04 +0200
Message-Id: <20190903180704.11812-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190903144536.8935-1-me@yadavpratyush.com>
References: <20190903144536.8935-1-me@yadavpratyush.com>
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
 git-gui.sh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..3a2df2f 100755
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
@@ -2640,6 +2642,27 @@ proc show_less_context {} {
 	}
 }
 
+proc select_path_in {widget} {
+	global file_lists last_clicked selected_paths
+	global file_lists_last_clicked
+
+	set _list_length [llength $file_lists($widget)]
+	if {$_list_length > 0} {
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
@@ -3852,6 +3875,14 @@ foreach i [list $ui_index $ui_workdir] {
 }
 unset i
 
+bind . <Alt-Key-1> {select_path_in $::ui_workdir}
+bind . <Alt-Key-2> {select_path_in $::ui_index}
+bind . <Alt-Key-3> {focus $::ui_diff}
+bind . <Alt-Key-4> {focus $::ui_comm}
+
+set file_lists_last_clicked($ui_index) {}
+set file_lists_last_clicked($ui_workdir) {}
+
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-- 
2.21.0.windows.1


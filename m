Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8321F461
	for <e@80x24.org>; Sat, 31 Aug 2019 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfHaMXb (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 08:23:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34223 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHaMXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 08:23:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so8870851ljh.1
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpvmuA2XY6+UHdDOeZEa0QhoCnyIUrEDR4G5NPvZbuE=;
        b=LbE/Lmvzko8sdQ8NBTcBdZJskFxkSglx1QbQdtJeiV76VAwid/xbUww2bfDMNbRQru
         uQcCLBbYJjyTb0boEvEAjKpOMvI8YbZxJoRLKyZeW0D7QKQTswdoft0nU0hY54H5hOx0
         e9T5b0+rsM6yjPE6n8d+VYZ+3A5Z4cH/fVIgy7r39r4V14mCYbIXVbRRnCAiBRt0QPSn
         imkzHXTVY+jlInUdFErn3RipmNaePInHPzJ3TXTvtmiFL4bSMaB3UNMgTJodXCm4YSF+
         vdXpR3rAbsFuCk4AQRzI8+ULizmrrWNw1TpH0BpJeKsx7YA9TfE5kFFlt58pjNugSM5D
         V20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpvmuA2XY6+UHdDOeZEa0QhoCnyIUrEDR4G5NPvZbuE=;
        b=tJWre7uNJXyq203gjAapPjfFKu7GSM8UZeQt4paVzxj5yI4+nGV9RyhKQrYRQxOA7r
         cZB6e1BMz3/2mBx4xxIGnenyQ4QPq3CtaTQAZKlQw39EStkN32gstG5sQ/bcnO7EX6l/
         CvvfuOryGlKUW26pUiETm/yvYGXvKEXZiMFsIntJR4/g60Y6X7ggTcswx91/nO4oKIu/
         VxnrvTj2CGEYdQSHX+B6sO2ADQBtHsb4yzsipTa/fbXgMpDj7wu0IKeI7SgrurCR9vOL
         sKFdgFWnCuWFQp+0/htnJBnsUeN+dJgcy89WXfD1vo14ylG1aBLIjWCr86PComR1SGe2
         IgLQ==
X-Gm-Message-State: APjAAAUZ2AexLsBQ5M+WgNJRwbGS95jHOh+qrHGZ7DXjqpqQ3iXQyBd+
        7ffhx1ChRZ0hdNf2ZCiKBORaZlCSy+A=
X-Google-Smtp-Source: APXvYqwx242wBbuz+GoespLs6+T5+kp0z5SQSeIXaLXN5l/0bZ2kppixbF1JVDnhZqFoKrMdE0VWlg==
X-Received: by 2002:a2e:7a0c:: with SMTP id v12mr4604180ljc.26.1567254208918;
        Sat, 31 Aug 2019 05:23:28 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id o8sm1351578ljc.49.2019.08.31.05.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 05:23:28 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] git-gui: Add hotkeys to set widget focus
Date:   Sat, 31 Aug 2019 14:23:26 +0200
Message-Id: <20190831122326.9071-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.23.0.37.g745f681289
In-Reply-To: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user cannot change focus between the list of files, the diff view and
the commit message widgets without using the mouse (clicking either of
the four widgets ).

Hotkeys CTRL/CMD+number (1-4) now focuses a previously selected path from
either the "Unstaged Changes" or "Staged Changes", the diff view or the
commit message dialog widgets, respectively. This enables the user to
select/unselect files, view the diff and create a commit in git-gui
using keyboard-only.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui/git-gui.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 6de74ce639..cbd0b69804 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2494,7 +2494,7 @@ proc force_first_diff {after} {
 
 proc toggle_or_diff {mode w args} {
 	global file_states file_lists current_diff_path ui_index ui_workdir
-	global last_clicked selected_paths
+	global last_clicked selected_paths file_lists_last_clicked
 
 	if {$mode eq "click"} {
 		foreach {x y} $args break
@@ -2551,6 +2551,8 @@ proc toggle_or_diff {mode w args} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
+	set file_lists_last_clicked($w) $lno
+
 	# Determine the state of the file
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
@@ -2664,6 +2666,51 @@ proc show_less_context {} {
 	}
 }
 
+proc select_first_path {w} {
+	global file_lists last_clicked selected_paths ui_workdir
+	global file_lists_last_clicked
+
+	set _list_length [llength $file_lists($w)]
+
+	if {$_list_length > 0} {
+
+		set _index $file_lists_last_clicked($w)
+
+		if {$_index eq {}} {
+			set _index 1
+		} elseif {$_index > $_list_length} {
+			set _index $_list_length
+		}
+
+		focus $w
+		set last_clicked [list $w $_index]
+		set path [lindex $file_lists($w) [expr $_index - 1]]
+		array unset selected_paths
+		set selected_paths($path) 1
+		show_diff $path $w
+	}
+}
+
+proc select_first_unstaged_changes_path {} {
+	global ui_workdir
+	select_first_path $ui_workdir
+}
+
+proc select_first_staged_changes_path {} {
+	global ui_index
+	select_first_path $ui_index
+}
+
+proc focus_diff {} {
+	global ui_diff
+	focus $ui_diff
+}
+
+proc focus_commit_message {} {
+	global ui_comm
+	focus $ui_comm
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -3877,6 +3924,14 @@ foreach i [list $ui_index $ui_workdir] {
 }
 unset i
 
+bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
+bind . <$M1B-Key-2> {select_first_staged_changes_path}
+bind . <$M1B-Key-3> {focus_diff}
+bind . <$M1B-Key-4> {focus_commit_message}
+
+set file_lists_last_clicked($ui_index) {}
+set file_lists_last_clicked($ui_workdir) {}
+
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-- 
2.23.0.37.g745f681289


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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8FA1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfIZPaB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:30:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40438 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfIZPaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:30:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so2636628ljw.7
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pzpaAmLo7wfWZwVYZjt0sKDlbYoywYjW9agT4Xs/uJA=;
        b=LIKGz3Lh8VLE0dojYNVYjwRLZ2rT0QHp0ltmWHprKL5pekxnUEUkMdqVT3bpvgkK+Q
         fiZm3EiFBFYdM/mEqjq0AoiYc0GzJrQoFhTxUbikuAHQrNGHyKutJ/scxoHnl1mRKUYY
         vGqPUKIDtcX6xrHYbXctdFOyfR42O/2bszCt0guwZcNxkwoPvO/0LD5vSL7BxNOG+2Gs
         Gr9f4DEUooe6SYkVdO3yH5RcCF5zDMHzD3W3pcDuT6XrP+z9DFc0GBxlNB9Iobuhfnj3
         J4AWaAzBcUDTy6duWx5+McFn1zta6hkzH7prH7lOHgjpCM+OTlQtK41v21T8F0475l1e
         UU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pzpaAmLo7wfWZwVYZjt0sKDlbYoywYjW9agT4Xs/uJA=;
        b=YM69DI+3eIQ9spm+Lm56t6+P+4pH8Jac3L/Z00W2P+ta7oYNb5Rdsu7P27eQ0UK51q
         aqrZUQB/KQtqSMtaaW2izgdXwf76kOqOWd4QRdeUzS+hyV+7NqbIQuDYckQqnnEglubC
         0CCQC0eNBRvEfDTouNNXz0KV5R3GyNrkTvBXDMvTQ0UjkDzxUY3QTRE6SfHSZkmHcorb
         MFng1e9/gK4X68kGFjykcJmzv9Zd+VBszm+2vfEMBEQ2wlScXg7jUydNxqO4QsrMYNvR
         F7GscRQQJhy2IEtixRy8Cg/mCrkFf6oB3o3y8B3TfLRLPaDEoA5tqGRw7JrexyIAMPYr
         +Jhg==
X-Gm-Message-State: APjAAAWmLk2/m/ybX5D87xBDeku1ebs525EB5AcWO/zX0dXg4Y2Jks3e
        vagk5V90rVvB9khmUKKhDDFqYUXs
X-Google-Smtp-Source: APXvYqyjY7dHsXCyf9Wv4bqnlz71S7unfB11FTF/krR0UOzF2GRsanLDKQiAd/SQQP8mzFKzSyCWcw==
X-Received: by 2002:a2e:9584:: with SMTP id w4mr3078627ljh.145.1569511796735;
        Thu, 26 Sep 2019 08:29:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i128sm563526lji.49.2019.09.26.08.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:29:56 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:29:56 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 15:29:50 GMT
Message-Id: <58972068a230c996951e26d795e26cf66459c497.1569511793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.git.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
From:   "Heiko Voigt via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] git-gui: provide question helper for retry fallback on
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heiko Voigt <hvoigt@hvoigt.net>

Make use of the new environment variable GIT_ASK_YESNO to support the
recently implemented fallback in case unlink, rename or rmdir fail for
files in use on Windows. The added dialog will present a yes/no question
to the the user which will currently be used by the windows compat layer
to let the user retry a failed file operation.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile          |  2 ++
 git-gui--askyesno | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh        |  3 +++
 3 files changed, 56 insertions(+)
 create mode 100755 git-gui--askyesno

diff --git a/Makefile b/Makefile
index fe30be38dc..85633b73df 100644
--- a/Makefile
+++ b/Makefile
@@ -291,6 +291,7 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(INSTALL_X0)git-gui--askyesno $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
@@ -309,6 +310,7 @@ uninstall:
 	$(QUIET)$(CLEAN_DST) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui $(REMOVE_F1)
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askpass $(REMOVE_F1)
+	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui--askyesno $(REMOVE_F1)
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/$p $(REMOVE_F1) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(REMOVE_F0)'$(DESTDIR_SQ)$(gitexecdir_SQ)'/git-gui.tcl $(REMOVE_F1)
diff --git a/git-gui--askyesno b/git-gui--askyesno
new file mode 100755
index 0000000000..cf9c990d09
--- /dev/null
+++ b/git-gui--askyesno
@@ -0,0 +1,51 @@
+#!/bin/sh
+# Tcl ignores the next line -*- tcl -*- \
+exec wish "$0" -- "$@"
+
+# This is an implementation of a simple yes no dialog
+# which is injected into the git commandline by git gui
+# in case a yesno question needs to be answered.
+
+set NS {}
+set use_ttk [package vsatisfies [package provide Tk] 8.5]
+if {$use_ttk} {
+	set NS ttk
+}
+
+if {$argc < 1} {
+	puts stderr "Usage: $argv0 <question>"
+	exit 1
+} else {
+	set prompt [join $argv " "]
+}
+
+${NS}::frame .t
+${NS}::label .t.m -text $prompt -justify center -width 400px
+.t.m configure -wraplength 400px
+pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
+pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
+
+${NS}::frame .b
+${NS}::frame .b.left -width 200
+${NS}::button .b.yes -text Yes -command yes
+${NS}::button .b.no  -text No  -command no
+
+
+pack .b.left -side left -expand 1 -fill x
+pack .b.yes -side left -expand 1
+pack .b.no -side right -expand 1 -ipadx 5
+pack .b -side bottom -fill x -ipadx 20 -ipady 15
+
+bind . <Key-Return> {exit 0}
+bind . <Key-Escape> {exit 1}
+
+proc no {} {
+	exit 1
+}
+
+proc yes {} {
+	exit 0
+}
+
+wm title . "Question?"
+tk::PlaceWindow .
diff --git a/git-gui.sh b/git-gui.sh
index f9b323abff..76d8139b8d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1248,6 +1248,9 @@ set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
 if {![info exists env(SSH_ASKPASS)]} {
 	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
 }
+if {![info exists env(GIT_ASK_YESNO)]} {
+	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
+}
 
 ######################################################################
 ##
-- 
gitgitgadget


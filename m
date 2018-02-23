Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482341F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBWKWt (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:22:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51188 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWKWs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:22:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id k87so3703157wmi.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KIJDR35KuPCv99Xfx6Mfkid+/dhlsFqRk+irRV21bPw=;
        b=CjXtx384oO7MUJXuDZxAOe+xp5wD0gF6Y4HM1xmOaOO47G/meGvI348LjjrbW2nA8+
         bZ7QWH18NjYASXMY3XbAQ7mKs7RwMlebfdcUCIehvtWh0meQOZRdGcAfkjzj99Cw9h8o
         LRZ6FaFKdxkSiQSwyFGq77HM+zhjDeJj5m91NkxTn/3B32UmEIHWLX75bOOT3TrGGBTC
         K6YvYK5Zx8DEr24ZJoAPDKKqDUZnQA+S72DoSRcyfY9OlDoiv9eMPmWXdWRd2EP/He11
         DmCNcdEKQ/etQRoRfn0yjFS9bBX5qwxrmuovO53f17KvdLzNHEFOu3WQB39TMN5rmso8
         k8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KIJDR35KuPCv99Xfx6Mfkid+/dhlsFqRk+irRV21bPw=;
        b=dU7dHaUJUSHRbJjD1BvAaQfTN1veIQVS3tyDZCFJnbxFyoyUncbKJQ3eVJoxvYay5e
         8+TPp3AVuozx2tVL2vE8OttKZcMBtB68jtRua8eC9j7X5CbOLGmQOejmbdvwHnldZk35
         lf6s9PwZRR6KmvplWWV78UZZbSQW+/mqNwWtT7noGY8CB0KLfWhAbo1oc1f+5GyGZiRA
         5v0KrvSB4yQ5E8A678HCi4vVClBJ5imxDAPGUUpKHC3Ny/CAbl1hy5ZxzjU1/FfZyGUd
         XTICLwSiSS5xWjjPnJnV6DwV3B+rTffY17G4WNS68b4Lbnwh1Vm2cZSxu908JfJjOZI6
         olAQ==
X-Gm-Message-State: APf1xPDidCaYqBxYdCub1pW8U6Th6bcVLNixW487TABblAmexWlEcU9r
        ji6wt70/ihq6/EFrJoegmJu0zc1HySQ=
X-Google-Smtp-Source: AH8x227HiIRplMCjiXAXMqr+O4NwnyF6rw/55TylaUS+YcXihSOkd1NK/Y7xZQq2Loa/GgLi101lJQ==
X-Received: by 10.80.217.69 with SMTP id u5mr2096654edj.273.1519381366809;
        Fri, 23 Feb 2018 02:22:46 -0800 (PST)
Received: from birger-Dell-T1700.hials.no ([2001:700:1200:5104:2d3a:6187:6675:5f1f])
        by smtp.gmail.com with ESMTPSA id o6sm1763976edj.65.2018.02.23.02.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 02:22:46 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
To:     git@vger.kernel.org
Cc:     patthoyts@users.sourceforge.net,
        Birger Skogeng Pedersen <birgersp@gmail.com>
Subject: [PATCH] git-gui: Add hotkeys to change focus between ui widgets
Date:   Fri, 23 Feb 2018 11:22:42 +0100
Message-Id: <20180223102242.5850-1-birgersp@gmail.com>
X-Mailer: git-send-email 2.16.2.266.g75bb9601e
In-Reply-To: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
References: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user cannot change focus between the list of files, the diff view
and the commit message widgets without using the mouse (clicking either of
the four widgets ).

Hotkeys CTRL/CMD+number (1-4) now focuses the first file of either the
"Unstaged Changes" or "Staged Changes", the diff view or the
commit message dialog widgets, respectively. This enables the user to
select/unselect files, view the diff and create a commit in git-gui
using keyboard-only.

Signed-off-by: Birger Skogeng Pedersen <birgersp@gmail.com>
---
 git-gui/git-gui.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 91c00e648..bdbe166f7 100755

(First timere here, any feedback is highly appreciated)

--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2664,6 +2664,35 @@ proc show_less_context {} {
 	}
 }
 
+proc select_first_path {w} {
+	global file_lists last_clicked selected_paths
+	if {[llength $file_lists($w)] > 0} {
+		focus $w
+		set last_clicked [list $w 1]
+		show_diff [lindex $file_lists($w) 0] $w
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
@@ -3876,6 +3905,11 @@ foreach i [list $ui_index $ui_workdir] {
 }
 unset i
 
+bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
+bind . <$M1B-Key-2> {select_first_staged_changes_path}
+bind . <$M1B-Key-3> {focus_diff}
+bind . <$M1B-Key-4> {focus_commit_message}
+
 set file_lists($ui_index) [list]
 set file_lists($ui_workdir) [list]
 
-- 
2.16.2.266.g75bb9601e


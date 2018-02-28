Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0856E1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 12:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeB1MLE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 07:11:04 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51507 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeB1MK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 07:10:58 -0500
Received: by mail-wm0-f67.google.com with SMTP id h21so4567718wmd.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 04:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q35kZS6zJlPPhYHVC2txjLZmNmhhtJZPz5xuKOyjZWg=;
        b=gfogL9Lzck1Xxog6P2DWzcBdwEQpjk5aggdnsjzxwm7q/61OJ1Le3fO9HwZj6EAVxO
         SgJEM7A55kYP4g0xhPsRm1KvfwHSmvRYFpvwQUq52rsb4XgK0GU5gReoih3Cc+XpaLVt
         1FIGJxnoEIyQUGtvBNhrqz0RGPx4d6d/glm760Fd8S8upuB6Q7GgC0ELRtGatzRuRGmM
         JzPd4c9YaJjMIeLu3yZQOw4RgN1ylVfierH9f+ZIeWfcb539w56+A29V2uJlGLv6nCK0
         qQZFLS7k9AcNsPuEQfkLedyp00BYk/8+iAA53NKHq6x6vLQ3cR91dtBNPdpEZiLVLQC+
         6Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Q35kZS6zJlPPhYHVC2txjLZmNmhhtJZPz5xuKOyjZWg=;
        b=RKT7mPXUgdb+17VJmHvy1QCmhG/r4rl3++cKX9JomH8V1jZ6iOHQgs5BwYZTmg8dL2
         fdpp6Qu5e5xla80fdR7bKTnKMJTXCOIvd6TbNN6mrYcqu6IB65hcM/Ya6az7Ye0dY42F
         rVL/XXDXYzhMY4ia6sd/Ev23yh40if91MyGFK2YwE9KzK5+TiLPx7eeRP0z8vfBapC7f
         yWBj81fpOkUKxuYjvFLioBVuO6WJMQYSu98Hb+aVs7scrDEGfonszb19PMYI2h4vNKAr
         rfc/P8rfKhdy9h7TzkzeoxP+qkrm7zy/tGMERmmnW/nW7PcvH0dwr25abCZ4n70iSpZZ
         slTA==
X-Gm-Message-State: APf1xPAoZ9QInSLnGH44Tg2Ft0rvDx4mId1jAYGTzWnJhYsMnnJ9AAii
        cRH4+fCDXRs3U3zOR0HI6mkGuzej
X-Google-Smtp-Source: AH8x226L4abBSGzUTA7XUfVbewnDbLB/kxzWqiJhyTCJsqOZsP9yLzEnGd3Ct77QiEYaxlePj5scZw==
X-Received: by 10.80.153.221 with SMTP id n29mr23443324edb.303.1519819857117;
        Wed, 28 Feb 2018 04:10:57 -0800 (PST)
Received: from birger-Dell-T1700.hials.no ([2001:700:1200:5104:cdf6:208f:9062:c587])
        by smtp.gmail.com with ESMTPSA id x44sm1704876ede.7.2018.02.28.04.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 04:10:56 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birgersp@gmail.com>
Subject: [PATCH] git-gui: Add hotkeys to change focus between ui widgets
Date:   Wed, 28 Feb 2018 13:10:52 +0100
Message-Id: <20180228121052.10642-1-birgersp@gmail.com>
X-Mailer: git-send-email 2.16.2.268.g7f9c27f2f
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
 git-gui/git-gui.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 91c00e648..f96c0a6b8 100755

(This is my first patch ever, any feedback is highly appreciated)

--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2664,6 +2664,38 @@ proc show_less_context {} {
 	}
 }
 
+proc select_first_path {w} {
+	global file_lists last_clicked selected_paths
+	if {[llength $file_lists($w)] > 0} {
+		focus $w
+		set last_clicked [list $w 1]
+		set path [lindex $file_lists($w) 0]
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
@@ -3876,6 +3908,11 @@ foreach i [list $ui_index $ui_workdir] {
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
2.16.2.268.g7f9c27f2f


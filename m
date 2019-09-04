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
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A641F461
	for <e@80x24.org>; Wed,  4 Sep 2019 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfIDSZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 14:25:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38411 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbfIDSAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id h3so13704153ljb.5
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkmT1g2ddwA6H7N3/G0nunoFdX69aU2dvvV4JhjUHZY=;
        b=NZ3A5rRyonkl9kOaq0Ca80rpnt2/VbYCBmMm7WChdw5d+salNst2VtCPEI5ty+F/oi
         WSoegL+X0K1JwkRnVkt1qa2xifExJV/IgzUuW2Hdq+uNlgMUUBna2avpOxXJMSugPZce
         uq8XyxpwVBSO1SSHKL+5FMhcprHHwLIp/ur86bGKPtMEdDettUMstUEg3yZeCwdGevc0
         THxrH4i4krlnsSJ+10ZqxyFep/QGuHxwMpF5KBX6O0WhDockcQ/N3PC+aHoDcC7oA+v1
         0SfqEPzQV2pgNfsKWKLyobiB1IhxHg+FsJLvG27b8zPZv3y1WGZkR+31gqQ0j5TUp3I1
         MR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkmT1g2ddwA6H7N3/G0nunoFdX69aU2dvvV4JhjUHZY=;
        b=cQOQlZrZ8oy26GsAkB5k1ma/N5MNo84dTEQR/FMHNh+4p6zKzmcOfs8rNr0Gu5p3U3
         i/QmxGnH9BGh1CihEmfcztiKmUAna8uuTjb5CHXpLYIJ1yNqPMnrDkRY3S6QOrFOFXcM
         EAUvINCIlBqwei0c0ZDOiRfrEns3Cyid5hoa5aOgYGJCFGDAbum+LsxmlHQd6Uin+FIC
         lcOVdLOvxn07/3v1D3nFfM3nwTrXwvRb9OVy3/lR62zRQAjutJDZrcW7Btjh2Pj0nJzA
         FpKqSStyioBzqtxx1tCICCbfYFjnnrSVOJjUuvSfQ5QGaiPi9rmJ/q8Sj7IsLrS4hNqv
         eP6w==
X-Gm-Message-State: APjAAAV3IisGHh9JeJmbjtDmX63wrhDemqNS4w0bL9Qsd3fuk9KmObCh
        TXj3dU2/6sI+gxccKZ+dy6GCQbz0gNwFzQ==
X-Google-Smtp-Source: APXvYqx41Bki8YZX9Qiiz6N3EDX+ANf2tXW9O8laNiOM2UihtEsIH6Q3r2/KQSNHNR99eC+0UaIdcg==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr23918279lji.64.1567620028060;
        Wed, 04 Sep 2019 11:00:28 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id q25sm3662429lfc.79.2019.09.04.11.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 11:00:27 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2] git-gui: add hotkey to toggle "Amend Last Commit" radio selector
Date:   Wed,  4 Sep 2019 19:59:43 +0200
Message-Id: <20190904175943.11924-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190904173642.2hkrqm5klatw33w7@yadavpratyush.com>
References: <20190904173642.2hkrqm5klatw33w7@yadavpratyush.com>
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
 git-gui.sh | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..47c5db0 100755
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
@@ -3843,6 +3872,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
 bind .   <$M1B-Key-plus> {show_more_context;break}
 bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
+bind .   <$M1B-Key-e> toggle_commit_type
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
 	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
-- 
2.21.0.windows.1


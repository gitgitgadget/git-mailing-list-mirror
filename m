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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E541F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfJGRME (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:12:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36339 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfJGRME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:12:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so14534658ljj.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WObAbON63INOhvb0KSPGarG+8NnBs52X+iOiDcU5zHE=;
        b=KROwgNQFlf1CZGSNIrGFTNdFmLe6DadkD7QFwi4UupzJxNy1ODTxx6OmVR3w8O9GdL
         CRNeQjWGGfja71f7URkOaPaiby0g+bCIqmUxD1D4DZT0NO8gkWWnP5hGyHxo4F5CeS0t
         xJAPR9nbAf6jpSt5Sq0IZiQ9abG/BYWNVJyLbj7UTBhpqHyBkV1zBk7cqI6XMkyzf7Or
         5Oofsmm+i+P9fdmXAzEscaYIX4yAlK82vql2kTi89QcgXL4sUY6hgoy2ui5foRyAGIMe
         IhVoAHIk6h4Ysc+vNGwUNqlzV+gRt66jsguSmxP86x3n3rMhRbShSE+HSGrxjFGKe4N5
         qy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WObAbON63INOhvb0KSPGarG+8NnBs52X+iOiDcU5zHE=;
        b=fUOsygnRD4i3D5LGLXB1NcoNcPUFhV538P87qExWoDrTrHYYE0KJWUJCfHvSvBJ9NB
         FRzrU6BLfiAra1MdBLbjdtiz37El/me/wM7/Saq5pOL2pX0ou3KgK08pika4vSYu0psq
         B7imsnVvs4qFT9IUlxbHgLDS7X+EuxNLIC0FZ3H0IEFlzWUkwGRwLN0eD3Pt8kv61NnC
         vbtCP3RLS/LMT8iU1WDPYLkxF5NJNNhKtAmLTtCm/iHNHrpMQgqW/v/bP7ERjjK/crgt
         WzGlBqgZYE8isrq43I6sYJuYS+fl9aM9yneEiy8CdsEpxfKc0Nq79XuKzNIW4/+mPeLJ
         pTnw==
X-Gm-Message-State: APjAAAWYtrYizbUBw0DMVt6azjPSv8shWNvPcNmes2v/COY26WF1BZdP
        RNnD4EUI1ay+a5xV+2ym1BQrrVHe7yA=
X-Google-Smtp-Source: APXvYqwzin5Z/ZZC96yeAq/qLkic5G7RW2HKmP+cXjf4u0DX3mpMrmeeNwOa0qU5M3a+KU1LFexXOw==
X-Received: by 2002:a2e:654a:: with SMTP id z71mr19570207ljb.37.1570468321921;
        Mon, 07 Oct 2019 10:12:01 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id n17sm3209477ljc.44.2019.10.07.10.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:12:00 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH 2/2] git-gui: select staged on ui_comm focus
Date:   Mon,  7 Oct 2019 19:11:45 +0200
Message-Id: <20191007171145.1259-2-birger.sp@gmail.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20191007171145.1259-1-birger.sp@gmail.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user focuses the Commit Message widget (to write a message), the
diff view may be blank.

With this patch a staged file is automatically selected when the Commit
Message widget is focused, if no other file is selected (i.e. diff view
is blank).

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index b7f4d1e..70b846a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2700,6 +2700,15 @@ proc toggle_commit_type {} {
 	do_select_commit_type
 }
 
+proc check_diff_selected {} {
+	global current_diff_path file_lists
+	# If no diff path selected, select a staged file
+	if {$current_diff_path eq {}
+		&& [llength $file_lists($::ui_index)] > 0} {
+		select_path_in_widget $::ui_index
+	}
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -3437,6 +3446,8 @@ pack .vpane.lower.commarea.buffer.header -side top -fill x
 pack .vpane.lower.commarea.buffer.frame -side left -fill y
 pack .vpane.lower.commarea.buffer -side left -fill y
 
+bind $ui_comm <FocusIn> {check_diff_selected}
+
 # -- Commit Message Buffer Context Menu
 #
 set ctxm .vpane.lower.commarea.buffer.ctxm
-- 
2.23.0.windows.1


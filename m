Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DC71F609
	for <e@80x24.org>; Mon,  3 Jun 2019 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfFCPDU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 11:03:20 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:39199 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCPDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 11:03:20 -0400
Received: by mail-it1-f169.google.com with SMTP id j204so21733426ite.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am5fMoMY2/n+60R+RhyN8o5CnnrnegKHRNelzl+pLNg=;
        b=DZoniAvAQ0BLUl9qycr/zkai5w/jJBFCzRCewdXMsJ48z/a1NVqM77xkvDeNOYIP/J
         9MslmoXLNGp/kUfjbJ4M2lP/VbRtKMgaFA/C78mFRE9aEPhik86yae5o8aHEg1tXWflo
         HlEaRAlaISc0Bm9Qtsf1s3EgBMKu+GHYkHARNrM8wZom5+UeUxL4EeZak95bZkhUlO/q
         DdtTrxpVKkjVzk2j5qwFZETp4OJQPpHUQvHVCwtrjwfvLcEr8mSzNcfLZ2ptOHzkoYLM
         VqTgEQX+T+JrRy+iPOxGsd9iTzsgmmh9rbFajv8fxMlaN1LZv0j6wszR3gKKcc6f0YMZ
         pIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am5fMoMY2/n+60R+RhyN8o5CnnrnegKHRNelzl+pLNg=;
        b=bziz6cf3aWV91Zxl+/tFTEK4nqEBbu/jxR6+MA4n3rDyeBb/F2nfR6F7dHg+2M1rxT
         HRmtWfbP6SDCqj9jV1t19BrRdM/e4SX9cA5dqeYjLrRtiIKdpWUlXzdpj/JdKcxoQKTk
         BNvguRplw5+3vtuXEX8brX0zbYNLPU7xxKQIkZ5oRCBwNNiTyyrlqG2zO5ZqcSZhS+40
         gxD22aDE03PfjBy7CkpUjJFGpW6hldYl4WXANcM4wEgWEChiIIwJNnRsmV/SQVxeqOBE
         OcuX54aOX29+FOiX79ED9VCp2Xm9VBiTbBhNiL03v/xs6Lqcrr/8L43/9vDHRb00hpN3
         MAqw==
X-Gm-Message-State: APjAAAXkKvzT8H8muelIu/P3nnLKf25UiJugMyL5maT1gkXPGFIW8leR
        vqUqgT98wcAiz5zr5KJzE1VGyquJ
X-Google-Smtp-Source: APXvYqwNW4B3+rfA7TKsP1faa6QnWjBB3buZbiYPuQsTbWNOmQaZ324fQAA0q6LgQzFyC3LvMXjYgw==
X-Received: by 2002:a02:aa0d:: with SMTP id r13mr11546784jam.129.1559574199313;
        Mon, 03 Jun 2019 08:03:19 -0700 (PDT)
Received: from 6R6G182.tor.bagroup.com (sslvpn.bagroup.com. [72.0.207.162])
        by smtp.gmail.com with ESMTPSA id k139sm62912itb.0.2019.06.03.08.03.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:03:18 -0700 (PDT)
From:   Wen Bei Li <wenbei123@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] mergetools: add support for VS Code
Date:   Mon,  3 Jun 2019 11:03:15 -0400
Message-Id: <20190603150315.16032-1-wenbei123@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach difftool and mergetool about VS Code.
---
 git-mergetool--lib.sh | 2 +-
 mergetools/code       | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 mergetools/code

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..59512ae673 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -283,7 +283,7 @@ list_merge_tool_candidates () {
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
-		tools="$tools smerge"
+		tools="$tools smerge code"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/code b/mergetools/code
new file mode 100644
index 0000000000..566a0d9d63
--- /dev/null
+++ b/mergetools/code
@@ -0,0 +1,7 @@
+diff_cmd () {
+	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	"$merge_tool_path" --wait "$MERGED"
+}
-- 
2.21.0.windows.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CE01F406
	for <e@80x24.org>; Fri, 22 Dec 2017 14:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbdLVOAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 09:00:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35720 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdLVOAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 09:00:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id f9so21946077wmh.0
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8t/eU5kj8p6MNl4tYlSsBqH4eDzqc1LIWiE3u0Tvic=;
        b=mBo1LCON4fyl3BEhWwwksBupubo5WeRJKj5OjU9FcyqxDlwcNZ4flUP4K4BZUV+TdD
         YVSxtQcuvferKHs2nU3GaYeo7iEnKg9ozRgR7Km5vReGUVTFp7aw7Vx2r1X+CR7FNd8x
         p4htuv+Wd4y38qTktQBrXczvYi3RBsUATAedWmvuN9lk4CqhlkejIrCDK9BIPihonYtc
         oR6Sr/mZTQjJTCOBiiIsej4jLawOtcmU/aL7vJBh3ZcxGaLVvS0oli74VBKZZ3RgBBY/
         cWnIo2SE5MwVLd8gyHOr/STkUP40/xxtvwn4V4cHFcvQtlxC5kTa0//ewe9Df8pw0uNq
         KGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8t/eU5kj8p6MNl4tYlSsBqH4eDzqc1LIWiE3u0Tvic=;
        b=eZcgDAidumHyXj6dIV5H825xfKhNiTXKple9uwegORWmmryqdflzURjdq0IsLFgJ6L
         XNx5YKpNJijqFOwO3HoUd9HVgU5wLN3nJs4kpW1hOwANLUzuyAIfUCsbPmxbL8XPQtuq
         p10gXbZJbERwDsYeQXUksrToTj0oMpvpv27QA8U8Qi6mr0a063E6FUPuC7+JPQnqP9ed
         WxhFDwiPRQjLOY3CgTMbM03NBiMxDFCdRZ472ykMMNiBuQO3u90ygzujycydpVuxsvw7
         GvnkGeH9PizTNpICbOyaGeDvjClCAdCaCnvwqeq0pIU/tOiZEthk2ZGl6De8QGarG1gD
         Svzg==
X-Gm-Message-State: AKGB3mLVFzX6dPrH6Rigy5bkBNJ+/iN2UTy6WhKzREVr/sEcR7rlIZXG
        MFFBPDc3Cip9FtM1BwH5gs0pVi4j
X-Google-Smtp-Source: ACJfBosfcjEZCtBK4TgCeCWeb8+OJ/R16ZGrJQOb+zdDPNF+r/50poNcPuazsPuDNkTlzC5ly4btCA==
X-Received: by 10.80.192.5 with SMTP id r5mr15316473edb.138.1513951242344;
        Fri, 22 Dec 2017 06:00:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a52sm21056749eda.92.2017.12.22.06.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 06:00:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] status: add a failing test showing a core.untrackedCache bug
Date:   Fri, 22 Dec 2017 14:00:32 +0000
Message-Id: <20171222140032.21180-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The untracked cache gets confused when a directory is swapped out for
a symlink to another directory. Whatever files are inside the target
of the symlink will be incorrectly shown as untracked. This issue does
not happen if the symlink links to another file, only if it links to
another directory.

A stand-alone testcase for copying into a terminal:

    (
        rm -rf /tmp/testrepo &&
        git init /tmp/testrepo &&
        cd /tmp/testrepo &&
        mkdir x y &&
        touch x/a y/b &&
        git add x/a y/b &&
        git commit -msnap &&
        git rm -rf y &&
        ln -s x y &&
        git add y &&
        git commit -msnap2 &&
        git checkout HEAD~ &&
        git status &&
        git checkout master &&
        sleep 1 &&
        git status &&
        git status
    )

This will incorrectly show y/a as an untracked file. Both the "git
status" call right before "git checkout master" and the "sleep 1"
after the "checkout master" are needed to reproduce this, presumably
due to the untracked cache tracking on the basis of cached whole
seconds from stat(2).

When git gets into this state, a workaround to fix it is to issue a
one-off:

    git -c core.untrackedCache=false status

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index e5fb892f95..7cf1e2c091 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -22,6 +22,12 @@ avoid_racy() {
 	sleep 1
 }
 
+status_is_clean() {
+	>../status.expect &&
+	git status --porcelain >../status.actual &&
+	test_cmp ../status.expect ../status.actual
+}
+
 test_lazy_prereq UNTRACKED_CACHE '
 	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
@@ -683,4 +689,43 @@ test_expect_success 'untracked cache survives a commit' '
 	test_cmp ../before ../after
 '
 
+test_expect_success 'teardown worktree' '
+    cd ..
+'
+
+test_expect_success 'setup worktree for symlink test' '
+	git init worktree-symlink &&
+	cd worktree-symlink &&
+	git config core.untrackedCache true &&
+	mkdir one two &&
+	touch one/file two/file &&
+	git add one/file two/file &&
+	git commit -m"first commit" &&
+	git rm -rf one &&
+	ln -s two one &&
+	git add one &&
+	git commit -m"second commit"
+'
+
+test_expect_failure '"status" after symlink replacement should be clean with UC=true' '
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	status_is_clean
+'
+
+test_expect_success '"status" after symlink replacement should be clean with UC=false' '
+	git config core.untrackedCache false &&
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	status_is_clean
+'
+
 test_done
-- 
2.15.1.424.g9478a66081


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113F720248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCMMYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:54 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51701 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCMMYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:52 -0400
Received: by mail-wm1-f54.google.com with SMTP id n19so1794950wmi.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ht2D8qpQoet5EokUb35Bv0cOYBunUfgtq/iY5D8ZCo=;
        b=cYRq1e8b5/0m8RvxqmOxvqosf59qdPNSn/n/mfYMgXHyaKQ3UXSKQbCOo4yFgMe2My
         gCmDs0DpZFZPKkUjggNfe+SmH0TkA0k7n0cVG8fTzT7qb3ltMgM32j1jHZdZknpjTJzJ
         YLjFl7oDZniXp2r6qkOkRZtmTlPCh6swp2zmNDyhyNQdX6Y80zbpPx+M6AsKkllkwMIs
         6OH8RJg4d0ibdhCzLFMK1WjJNtlILC7BDbgf/IttZqZKAotyixvxMPql3mzoUIrK5lk8
         ctmeg8Kx2BhbY1yt9e5PbxLo+EJ3AAj9KNt/VnoE73RJ6jBCD3IFTM3s4oV8mpNdAzwt
         Vs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ht2D8qpQoet5EokUb35Bv0cOYBunUfgtq/iY5D8ZCo=;
        b=L123xJGIu/YhCL9P2k337kjgFiJTwIHOsDR449cCiGsvguRaRijTJSP3YLUBS+M4ak
         VLqIgPGsbx0JSeZTFw/6TojxWJZEAK2Pz8VenfdQPE2nfxrDBS2qXmsc+tShWihVNYjK
         tCFpUubKoIPhUkCuNpIohoOevsHP7xLAGFmhXT5CCa+5xuWBkAj6sLFzG7kOGOlwa4Ve
         u2vOrCAM/DzRQzOSIS2xSayLm5JF264xbgu2Og0B4MkGE1ScY/i0L4rXp5u0KniggbGe
         K5DTIiZRlTB+1VA41r4/r3LKmw4gJT53ZPAJ8w0LGnur1uvHfhp6qs5UydSvSy6ZWbDO
         nOFA==
X-Gm-Message-State: APjAAAUlVg32ueKcLQVjAg209pwBQ090tRHFAMC6l6hrfjo3viHL/n6R
        kUusUuu0yvSmKgtOHi5gS0hrRWHY
X-Google-Smtp-Source: APXvYqwvYBO0IORcbl7IPQDYWxuaYytKRGFGjHXig59hxv4ol14Db6mGzUdbZxUz/L7J9n4yj61img==
X-Received: by 2002:a1c:eb19:: with SMTP id j25mr1961352wmh.123.1552479889297;
        Wed, 13 Mar 2019 05:24:49 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/11] git p4 test: use 'test_atexit' to kill p4d and the watchdog process
Date:   Wed, 13 Mar 2019 13:24:15 +0100
Message-Id: <20190313122419.2210-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Use 'test_atexit' to run cleanup commands to stop 'p4d' at the end of
the test script or upon interrupt or failure, as it is shorter,
simpler, and more robust than registering such cleanup commands in the
trap on EXIT in the test scripts.

Note that one of the test scripts, 't9801-git-p4-branch.sh', stops and
then re-starts 'p4d' twice in the middle of the script; take care that
the cleanup functions to stop 'p4d' are only registered once.

Note also that 'git p4' tests invoke different functions in the trap
on EXIT ('cleanup') and in the last test before 'test_done'
('kill_p4d').  Register both of these functions with 'test_atexit' for
now, and a a later patch in this series will then clean up the
redundancy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-p4.sh                            | 10 +++++++++-
 t/t9800-git-p4-basic.sh                    |  4 ----
 t/t9801-git-p4-branch.sh                   |  4 ----
 t/t9802-git-p4-filetype.sh                 |  4 ----
 t/t9803-git-p4-shell-metachars.sh          |  4 ----
 t/t9804-git-p4-label.sh                    |  4 ----
 t/t9805-git-p4-skip-submit-edit.sh         |  4 ----
 t/t9806-git-p4-options.sh                  |  5 -----
 t/t9807-git-p4-submit.sh                   |  4 ----
 t/t9808-git-p4-chdir.sh                    |  4 ----
 t/t9809-git-p4-client-view.sh              |  4 ----
 t/t9810-git-p4-rcs.sh                      |  4 ----
 t/t9811-git-p4-label-import.sh             |  5 -----
 t/t9812-git-p4-wildcards.sh                |  4 ----
 t/t9813-git-p4-preserve-users.sh           |  4 ----
 t/t9814-git-p4-rename.sh                   |  4 ----
 t/t9815-git-p4-submit-fail.sh              |  4 ----
 t/t9816-git-p4-locked.sh                   |  4 ----
 t/t9817-git-p4-exclude.sh                  |  4 ----
 t/t9818-git-p4-block.sh                    |  4 ----
 t/t9819-git-p4-case-folding.sh             |  4 ----
 t/t9820-git-p4-editor-handling.sh          |  4 ----
 t/t9821-git-p4-path-variations.sh          |  4 ----
 t/t9822-git-p4-path-encoding.sh            |  4 ----
 t/t9823-git-p4-mock-lfs.sh                 |  4 ----
 t/t9824-git-p4-git-lfs.sh                  |  4 ----
 t/t9825-git-p4-handle-utf16-without-bom.sh |  4 ----
 t/t9826-git-p4-keep-empty-commits.sh       |  4 ----
 t/t9827-git-p4-change-filetype.sh          |  4 ----
 t/t9828-git-p4-map-user.sh                 |  4 ----
 t/t9829-git-p4-jobs.sh                     |  4 ----
 t/t9830-git-p4-symlink-dir.sh              |  4 ----
 t/t9831-git-p4-triggers.sh                 |  4 ----
 t/t9832-unshelve.sh                        |  3 ---
 t/t9833-errors.sh                          |  5 -----
 35 files changed, 9 insertions(+), 139 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b3be3ba011..958e33b77e 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -74,7 +74,6 @@ cleanup () {
 		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
 	fi
 }
-trap cleanup EXIT
 
 # git p4 submit generates a temp file, which will
 # not get cleaned up if the submission fails.  Don't
@@ -82,7 +81,16 @@ trap cleanup EXIT
 TMPDIR="$TRASH_DIRECTORY"
 export TMPDIR
 
+registered_stop_p4d_atexit_handler=
 start_p4d () {
+	# One of the test scripts stops and then re-starts p4d.
+	# Don't register and then run the same atexit handlers several times.
+	if test -z "$registered_stop_p4d_atexit_handler"
+	then
+		test_atexit 'kill_p4d; cleanup'
+		registered_stop_p4d_atexit_handler=AlreadyDone
+	fi
+
 	mkdir -p "$db" "$cli" "$git" &&
 	rm -f "$pidfile" &&
 	(
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 729cd25770..5856563068 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -326,8 +326,4 @@ test_expect_success 'submit from worktree' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 6a86d6996b..50013132c8 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -610,8 +610,4 @@ test_expect_success 'Update a file in git side and submit to P4 using client vie
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 9978352d78..94edebe272 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -333,8 +333,4 @@ test_expect_success SYMLINKS 'empty symlink target' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index d5c3675100..2913277013 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -105,8 +105,4 @@ test_expect_success 'branch with shell char' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index e30f80e617..3236457106 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -108,8 +108,4 @@ test_expect_failure 'two labels on the same changelist' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 5fbf904dc8..90ef647db7 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -98,8 +98,4 @@ test_expect_success 'no config, edited' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 3f5291b857..4e794a01bf 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -300,9 +300,4 @@ test_expect_success 'use --git-dir option and GIT_DIR' '
 	test_path_is_file "$git"/cli_file2.t
 '
 
-
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 850d979119..eaaae414a1 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -593,8 +593,4 @@ test_expect_success 'update a shelve involving moved and copied files' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 11d2b5102c..58a9b3b71e 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -83,8 +83,4 @@ test_expect_success SYMLINKS 'p4 client root symlink should stay symbolic' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 897b3c3034..3cff1fce1b 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -836,8 +836,4 @@ test_expect_success 'quotes on both sides' '
 	git_verify "cdir 1/file11" "cdir 1/file12"
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index cc53debe19..57b533dc6f 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -360,8 +360,4 @@ test_expect_failure 'Add keywords in git which do not match the default p4 value
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 602b0a5d5c..b70e81c3cd 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -259,9 +259,4 @@ test_expect_success 'importing labels with missing revisions' '
 	)
 '
 
-
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 0206771fbb..254a7c2446 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -211,8 +211,4 @@ test_expect_success 'wildcard files requiring keyword scrub' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 783c6ad165..fd018c87a8 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -138,8 +138,4 @@ test_expect_success 'not preserving user with mixed authorship' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 60baa06e27..468767cbf4 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -242,8 +242,4 @@ test_expect_success P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW \
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index eaf03a6563..9779dc0d11 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -422,8 +422,4 @@ test_expect_success 'cleanup chmod after submit cancel' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index d048bd33fa..932841003c 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -138,8 +138,4 @@ test_expect_failure 'move with lock taken' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index aac568eadf..96d25f0c02 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -64,8 +64,4 @@ test_expect_success 'clone, then sync with exclude' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index ce7cb22ad3..0db7ab9918 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -146,8 +146,4 @@ test_expect_success 'Clone repo with self-sizing block size' '
 	test_line_count \> 10 log
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index d808c008c1..600ce1e0b0 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -53,8 +53,4 @@ test_expect_failure 'Clone UC repo with lc name' '
 	test_must_fail git p4 clone //depot/uc/...
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index 3c22f74bd4..fa1bba1dd9 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -31,8 +31,4 @@ test_expect_success 'EDITOR with options' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
index 81e46acfa8..ef80f1690b 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -193,8 +193,4 @@ test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index c78477c19b..1bf7635016 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -67,8 +67,4 @@ test_expect_success 'Delete iso8859-1 encoded paths and clone' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
index 1f2dc369bf..88b76dc4d6 100755
--- a/t/t9823-git-p4-mock-lfs.sh
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -185,8 +185,4 @@ test_expect_success 'Run git p4 submit in repo configured with large file system
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index ed80ca858c..a28dbbdd56 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -287,8 +287,4 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index 1551845dc1..f049ff8229 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -43,8 +43,4 @@ test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
 	git p4 clone --dest="$git" //depot
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index fa8b9daf1f..fd64afe064 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -127,8 +127,4 @@ test_expect_success 'Clone repo subdir with all history' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
index 7433998f47..d3670bd7a2 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -59,8 +59,4 @@ test_expect_success SYMLINKS 'change symbolic link to file' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
index e20395c89f..ca6c2942bd 100755
--- a/t/t9828-git-p4-map-user.sh
+++ b/t/t9828-git-p4-map-user.sh
@@ -54,8 +54,4 @@ test_expect_success 'Clone repo root path with all history' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
index 971aeeea1f..88cfb1fcd3 100755
--- a/t/t9829-git-p4-jobs.sh
+++ b/t/t9829-git-p4-jobs.sh
@@ -92,8 +92,4 @@ test_expect_success 'check log message of changelist with more jobs' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 2ad1b0810d..3fb6960c18 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -36,8 +36,4 @@ test_expect_success 'symlinked directory' '
 
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index be44c9751a..d743ca33ee 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -96,8 +96,4 @@ test_expect_success 'submit description with extra info lines from verbose p4 ch
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 41c09f11f4..1286a5b824 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -174,8 +174,5 @@ test_expect_success 'unshelve specifying the origin' '
 		test_path_is_file file_to_shelve
 	)
 '
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
 
 test_done
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index 47b312e1c9..e22369ccdf 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -45,9 +45,4 @@ test_expect_success 'ticket logged out' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
-
 test_done
-- 
2.21.0.499.g4d310c7a8e.dirty


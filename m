Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD5020195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbcGLWjX (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34076 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbcGLWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so1913081pfb.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6/HJN+HGkzoMxGfN2tAwfA6JMvmoRCVnMm5F9LBNJI=;
        b=U6k5OTWWaUuFs4C06v2FwbE6+S9wd83E5WWDLQhD876aX7LO0F3NhcPkLyS6GLaWRm
         pE9ReJ4NeJ9J8xCkszASpQql7S/Lz34VpwhhG6N66R8dZQWc0nqdZvlCN8zeFRTLXdus
         EJcRfsW/j79OzP72a014u14Idr2MGWMxO4nh9Q9VLQB7yq7OSEi3+pZ6hv5nJ2Gj/fkF
         7tIGQxB0NmTtPlDupYWotZasFjir9dmmYDUnxJZgp4Q0cWvAzbtz7cHO20yWp5qsIFJ8
         qJcFMqWZRT4MZ4ncGhS3jqb6F3dIphaTQWfUWp8WNBFuG11M20f/5AHp7n7Yrx3hvSRU
         Sn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6/HJN+HGkzoMxGfN2tAwfA6JMvmoRCVnMm5F9LBNJI=;
        b=EvOgN8PYAANRL3+gax913GXBOi5maMTDlltp23iOXCB8nq5/F8kFbNLELhEHjnzaZL
         xjfBpCQuC4SFXqqqdGgqFjEyU4XyQFEdvJ4ErmZdJjwzbtDwDWcUKdVnzwRfNhCv0gjN
         msBTetyzL0VT0pqBcrXQC0qiU/LtJ12OlaAf+OCX+1uU4TPiyhAn53APcTgDQI/Dcs6z
         cdWA8hvxeYpJ6ZKf+klepSPDaRiYow0faL91+74qmfHCgcd7Gh5kaYBiu2/6of2HdlQF
         R3rHDKB3xJ5Oh8jEPVnaNMjupdJNFJ1CeQqEk8/XU7uL2SopZTb9mt10DPerLC9pC+Tw
         bSIA==
X-Gm-Message-State: ALyK8tIW+MutK11RRRLw9xE6iwCtWWYxlwVtOvtvmlM81k5D6+xFfpXG//IiPUUdgORL8g==
X-Received: by 10.98.13.206 with SMTP id 75mr49539057pfn.161.1468363141399;
        Tue, 12 Jul 2016 15:39:01 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:38:59 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 0/9] Resend of gitster/pb/bisect
Date:	Wed, 13 Jul 2016 04:05:29 +0530
Message-Id: <20160712223538.28508-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

A small mistake got unnoticed by me which Lars recently pointed out.
The naming convention is "git_path_<name_of_file>" and underscore
instead of spaces.

Thanks!

The interdiff is:
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c2f3cee..88a1df8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -7,7 +7,7 @@
 #include "argv-array.h"
 #include "run-command.h"
 
-static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
@@ -100,7 +100,7 @@ static int write_terms(const char *bad, const char *good)
 	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
 		return -1;
 
-	fp = fopen(git_path_bisect_write_terms(), "w");
+	fp = fopen(git_path_bisect_terms(), "w");
 	if (!fp)
 		return error_errno(_("could not open the file BISECT_TERMS"));
 
@@ -134,7 +134,7 @@ static int bisect_clean_state(void)
 	remove_path(git_path_bisect_log());
 	remove_path(git_path_bisect_names());
 	remove_path(git_path_bisect_run());
-	remove_path(git_path_bisect_write_terms());
+	remove_path(git_path_bisect_terms());
 	/* Cleanup head-name if it got left by an old version of git-bisect */
 	remove_path(git_path_head_name());
 	/*


Pranit Bauva (9):
  bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
  bisect: rewrite `check_term_format` shell function in C
  bisect--helper: `write_terms` shell function in C
  bisect--helper: `bisect_clean_state` shell function in C
  t6030: explicitly test for bisection cleanup
  wrapper: move is_empty_file() and rename it as
    is_empty_or_missing_file()
  bisect--helper: `bisect_reset` shell function in C
  bisect--helper: `is_expected_rev` & `check_expected_revs` shell
    function in C
  bisect--helper: `bisect_write` shell function in C

 builtin/am.c                |  20 +--
 builtin/bisect--helper.c    | 310 +++++++++++++++++++++++++++++++++++++++++++-
 cache.h                     |   3 +
 git-bisect.sh               | 146 +++------------------
 t/t6030-bisect-porcelain.sh |  17 +++
 wrapper.c                   |  13 ++
 6 files changed, 355 insertions(+), 154 deletions(-)

-- 
2.9.0


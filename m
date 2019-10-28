Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00AF1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfJ1Qza (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 12:55:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Qz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 12:55:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so10670905wro.7
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WQ8pEDbDPbVMCGcWPU5uqvcppNEi1Zbdskk3RWslJo=;
        b=qRCvVBC/8nJHqlWUib9ZdS5z2IUijUTijtEDY9JkHAidROK+uQO+jEuvSAKtKhS8gv
         1I67YgO45M3Rk+SycRLlsPiEj6hrD4U6YtFyni4gGh7MjPyBGkK5Y5RxI+VLsULs74+X
         z1UQI0Kxtm9mYaWKvr1mH9Ds80J+EX8go1vND5Wk9vH4ImBuky9Rn9kPfMEstH/u23wz
         q/B7ZLtU0QfVLl2Xg5a5P5l91Ft9mFvM1pXByPMbOnLHAVi5r/KByx4iU+842vQ0moqY
         SeNkHvCQVd04zLcSsRjwmXCMoZGbV1DEjJytbdpWuiNXjhMfV5ZynauCbEiMRn3FA+Up
         ZrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WQ8pEDbDPbVMCGcWPU5uqvcppNEi1Zbdskk3RWslJo=;
        b=JFj4e8POpumZqDrUyiRfMVeqIifyEqBcoRjZ8owUQg065drZXqeIs9zjL0GgbrJkLU
         rwwp0KbFDMiJIiw/4s22jjOhlV9J7il9CMcbktDrcEcXMdMzisoQIu1QokBLTawFFXPS
         QAhwAVj8G26ymuxLQepGadIosuQSdwcS452lWlditaKCcWFWLVLL+M+eYF59rtO5PNxl
         72Y5GPNlXqFLm0iK4KxqdmtWaiDcp4Vp2FOxtEfpWNcWAPsTwvZfQtKQmjvJF91OQ4j3
         FSXfxZyVErQyokM01kucSBtUUyQ6RZJSEttnwJY0cfyv2HMgHuEYh0JpEx/3h4zI5Z3M
         8Ykg==
X-Gm-Message-State: APjAAAVqca7KPooWrT0QF4sF8eA7KXM9gDhTRBC+Yhmi9d5L68p5hpoY
        bi+5oewLn5aDVnV+Fsll9D8DeAPm
X-Google-Smtp-Source: APXvYqzLrpnSjcCb4OlFnfFEufzLpWhXYDeGZKb+JjhWNJYU8QJRB3JlIniFXMoboa/z8ty1LTX00Q==
X-Received: by 2002:adf:d183:: with SMTP id v3mr11274065wrc.316.1572281727397;
        Mon, 28 Oct 2019 09:55:27 -0700 (PDT)
Received: from localhost.localdomain ([139.47.116.205])
        by smtp.gmail.com with ESMTPSA id u68sm188923wmu.12.2019.10.28.09.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 09:55:26 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] clone: rename static function `dir_exists()`.
Date:   Mon, 28 Oct 2019 17:55:23 +0100
Message-Id: <20191028165523.84333-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/clone.c has a static function dir_exists() that
checks if a given path exists on the filesystem.  It returns
true (and it is correct for it to return true) when the
given path exists as a non-directory (e.g. a regular file).

This is confusing.  What the caller wants to check, and what
this function wants to return, is if the path exists, so
rename it to path_exists().

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..b24f04cf33 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -899,7 +899,7 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
-static int dir_exists(const char *path)
+static int path_exists(const char *path)
 {
 	struct stat sb;
 	return !stat(path, &sb);
@@ -981,7 +981,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 	strip_trailing_slashes(dir);
 
-	dest_exists = dir_exists(dir);
+	dest_exists = path_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
@@ -992,7 +992,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		work_tree = NULL;
 	else {
 		work_tree = getenv("GIT_WORK_TREE");
-		if (work_tree && dir_exists(work_tree))
+		if (work_tree && path_exists(work_tree))
 			die(_("working tree '%s' already exists."), work_tree);
 	}
 
@@ -1020,7 +1020,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (real_git_dir) {
-		if (dir_exists(real_git_dir))
+		if (path_exists(real_git_dir))
 			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
 		junk_git_dir = real_git_dir;
 	} else {
-- 
2.21.0 (Apple Git-122)


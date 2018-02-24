Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5E71F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeBXDfJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:35:09 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39054 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeBXDfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:35:08 -0500
Received: by mail-pg0-f68.google.com with SMTP id w17so4090703pgv.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKeoFbP6Bnz2PLgBTOkUyorA6wP+JU4+wKIB/j3gF2o=;
        b=B3INeZ8CotBoCcJhmgGEjf+s+I9kWlgu1ltbOUVAYqAV/ub4MWTEY74v7vvFBIT4zd
         D7FWS67BkqiprzcH930FbBKjLCBXd8gPvaGHerN9QtyOk/9XzN4h9OXu122KueW5gPXE
         JxTGER3whWj+0G8394Vis6EIdG6klQuTaabLJrXBEAT5mG31kdFLX4VxRzoNzU0saHuY
         rjtKyKXQCpteB3TMe5dpqdkaTPx/QDqrxEia+5oeNAVquz5yBB/dxXS9teWEPaZIreMy
         XvGZKeZTuB1aBGT1GJjDNzwxi5MwZUxSrazr2TLQiO5bdMqfkgqUXurQeF6+wM2OYPE3
         QjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKeoFbP6Bnz2PLgBTOkUyorA6wP+JU4+wKIB/j3gF2o=;
        b=AXFEEYiphaTEUVPLEnNjuLArOU/94BS+osmk8qk4fz1c/SCKuLiF1rKhJ/cbG9HsSQ
         OT33SxLLxhOzygCs8WJFn2rSMmqlsx09IlDrmzALu6WLy8W7zR+9PLbgRoZwjXYQzL5j
         OtIVSW+sXUbCBzPRXMM3KRkIHozV9x52PZ1sSfzVaBfcsxVhP4+n+lFheazlllOmkNep
         obqsmywe9hgEdaXk3jhA3X0XAn4zmgNdG4YLiaIi5Vuh7n49G1CjTPZmlu8cEoJZla9N
         GbJdeL3PysctP+19Diinjvy8+YapzxcLqaGlWcrGPQhOvx0etSxqIRNWn5DDx1T5LA3Q
         cZhw==
X-Gm-Message-State: APf1xPB4OolxqlRYUeEOPOyB6AU/yhDJBDWc6iZCc4wcEtfY0Mb2t1mW
        bazjvDIt9FRpQcdpKQMUgQOuIg==
X-Google-Smtp-Source: AH8x226ew91+RHm/eofa2hADP/qKBG/xluBNGCYh3ilLaBVNm4uy0NKsL0c6kCh2PH8HxKgcmf7SOQ==
X-Received: by 10.99.116.69 with SMTP id e5mr3107728pgn.437.1519443307833;
        Fri, 23 Feb 2018 19:35:07 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 66sm7365298pfh.96.2018.02.23.19.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 19:35:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 10:35:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/5] Revert "repository: pre-initialize hash algo pointer"
Date:   Sat, 24 Feb 2018 10:34:29 +0700
Message-Id: <20180224033429.9656-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224033429.9656-1-pclouds@gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit e26f7f19b6c7485f04234946a59ab8f4fd21d6d1. The root
problem, git clone not setting up the_hash_algo, has been fixed in the
previous patch.

Since this is a dangerous move and could potentially break stuff after
release (and leads to workaround like the reverted commit), the
workaround technically remains, but is hidden behind a new environment
variable GIT_HASH_FIXUP. This should let the users continue to use git
while we fix the problem. This variable can be deleted after one or two
releases.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 common-main.c                    | 10 ++++++++++
 repository.c                     |  2 +-
 t/helper/test-dump-split-index.c |  2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/common-main.c b/common-main.c
index 6a689007e7..fbfa98c3b8 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "repository.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -40,5 +41,14 @@ int main(int argc, const char **argv)
 
 	restore_sigpipe_to_default();
 
+	/*
+	 * Temporary recovery measure while hashing code is being
+	 * refactored. This variable should be gone after everybody
+	 * has used the_hash_algo in one or two releases and nobody
+	 * complains anything.
+	 */
+	if (getenv("GIT_HASH_FIXUP"))
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	return cmd_main(argc, argv);
 }
diff --git a/repository.c b/repository.c
index 4ffbe9bc94..0d715f4fdb 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
 };
 struct repository *the_repository = &the_repo;
 
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index e44430b699..b759fe3fc1 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -12,6 +12,8 @@ int cmd_main(int ac, const char **av)
 	struct split_index *si;
 	int i;
 
+	setup_git_directory();
+
 	do_read_index(&the_index, av[1], 1);
 	printf("own %s\n", sha1_to_hex(the_index.sha1));
 	si = the_index.split_index;
-- 
2.16.1.435.g8f24da2e1a


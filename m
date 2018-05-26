Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5C61F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbeEZNzv (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37057 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031747AbeEZNzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so21440813wmb.2
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPf40o6fQ+8UHhnpzYp8EAwpgf3yaWt/CuMZZwP5In0=;
        b=VcGjJM6Bqbu2t+oX+QExk/kvZfL7yJOSusDAzTAB33iosDUjCtXzR0lydqOvWQVeV6
         FXj3bGodamVWZO8sfXurIMGrLGFCnZEwrH67SmKphr+LrwfjrXRCaNTOZCccMxczgt30
         bifDXqAVYlaPLe2SNyzVdFLD//HZZQUThCSbbBvzm81Icj7cBG8cQkHiVmPq5WptsaiE
         CNKQ35+ixWO05lcU1mpBQEJfBWLiCZGUYm0KpaRCXmhA9H/ULT4uAlNP49IRtc4MaNgC
         jmD+/G9vvoy482K7PIytQ5OxLuK4Pr1kdWoujEkOTwRa3hoSRNeOH0RC1bng20G9e+Av
         54PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPf40o6fQ+8UHhnpzYp8EAwpgf3yaWt/CuMZZwP5In0=;
        b=asACCnw/+BNdRiziQiMxcPRfHnAcQ8zdt5tYeg0IBXJx1DOA7T964aQgMc11LNiDQ9
         fMV53m17mpA7BSRzx/dlPm2PN+ZUCqHkeT63XzKkspsPCAKLd5odN7+SeHPOUFm9aJVf
         8ASQrU5SansljaSpDUHYcmImnP7JhDWo4WFjU0J4PIhPqB9QNexkTULgPGFDF5oOHJiJ
         W5lfU74PHEzL2CSYopt+4zOXzq7ZDQuFbPgxVGqR80m9/aEcjxMtshDBgmfZdmvwcpfa
         bg2ewTustzzQH3I84YjZX3T4+BxC/RJThs+7L+KxUgK885CusSGibLppdF94K2FTvgY+
         KdQQ==
X-Gm-Message-State: ALKqPwcLrAyF7RmQZKYl8r3c5fS7tLX1OZrRKQu/qHHe6Ed7w+Lnv4zw
        BwktFLHLVUifeG8D5zXfSio=
X-Google-Smtp-Source: AB8JxZrF/fokejwMP7S0aNzMeu6GToK5X+7WsTuDctbzGKJha/ZiDT2xvaK6gnp/JFbLkEMy3cxzBQ==
X-Received: by 2002:a2e:9158:: with SMTP id q24-v6mr4235743ljg.73.1527342946933;
        Sat, 26 May 2018 06:55:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/11] am: move advice.amWorkDir parsing back to advice.c
Date:   Sat, 26 May 2018 15:55:27 +0200
Message-Id: <20180526135531.4516-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only benefit from this move (apart from cleaner code) is that
advice.amWorkDir should now show up in `git help --config`. There
should be no regression since advice config is always read by the
git_default_config().

While at there, use advise() like other code. We now get "hint: "
prefix and the output is stderr instead of stdout (which is also the
reason for the test update because stderr is checked in a following
test and the extra advice can fail it).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 advice.c              | 2 ++
 advice.h              | 1 +
 builtin/am.c          | 6 +-----
 t/t4254-am-corrupt.sh | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 2aca11f45e..52aa85bdfd 100644
--- a/advice.c
+++ b/advice.c
@@ -17,6 +17,7 @@ int advice_implicit_identity = 1;
 int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
+int advice_amworkdir = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
@@ -68,6 +69,7 @@ static struct {
 	{ "detachedHead", &advice_detached_head },
 	{ "setupStreamFailure", &advice_set_upstream_failure },
 	{ "objectNameWarning", &advice_object_name_warning },
+	{ "amWorkDir", &advice_amworkdir },
 	{ "rmHints", &advice_rm_hints },
 	{ "addEmbeddedRepo", &advice_add_embedded_repo },
 	{ "ignoredHook", &advice_ignored_hook },
diff --git a/advice.h b/advice.h
index 9f5064e82a..7e9377864f 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
+extern int advice_amworkdir;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
diff --git a/builtin/am.c b/builtin/am.c
index aa989e7390..735d016525 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1827,15 +1827,11 @@ static void am_run(struct am_state *state, int resume)
 		}
 
 		if (apply_status) {
-			int advice_amworkdir = 1;
-
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
-
 			if (advice_amworkdir)
-				printf_ln(_("Use 'git am --show-current-patch' to see the failed patch"));
+				advise(_("Use 'git am --show-current-patch' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 168739c721..fd3bdbfe2c 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 #   fatal: unable to write file '(null)' mode 100644: Bad address
 # Also, it had the unwanted side-effect of deleting f.
 test_expect_success 'try to apply corrupted patch' '
-	test_must_fail git am bad-patch.diff 2>actual
+	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual
 '
 
 test_expect_success 'compare diagnostic; ensure file is still here' '
-- 
2.17.0.705.g3525833791


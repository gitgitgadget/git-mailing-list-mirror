Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B80B20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfC3LWt (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfC3LWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so2262490pfo.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=l7iVkOTAzeZmrsPhIbk3BID0EKFgV/JPwQ762zx6CbyPvTLPGSfyoQ31NJdOpD60BV
         b4moDK9PZ0qO32zeVS9XTd9SD2arSl75uK2Nlg0ZnKkfiY7zsNcDuxhQHBfPdLTcFzmm
         fvfazPbR1tSUHwqyuQu0k6vycd0vFL9Fe4T7alFA7xbltLQLp83CVBGuhfsJ+BJrRJv+
         qzyf0tZQn6OE0EMW1HEs7OczIo83NcJRB60SGxC+Xe10aTolhoWf07EAOtaQXZ2oRpko
         WqMwGt9rN2YvPUT36wa/RV+sNMlySKDth8FqJyySRkLTfsCmSThj6yQNvTzNML6BmrMf
         LWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMiXl1MxKUOko0eG2ftuaNwMJYbmJV8Dmae7pks8mVA=;
        b=kTUNn3QbLZenhtAjuQPAkf7F9ZMNvha1w/l2C+X/DsX/uIg3p8FuPg8qUjtPLEKJLy
         0HmD0mAOn2+GqkkrBjyXoQ55SU47JwoXgo/ZIfFOurkwgsnfibydZD2oDMcNuei9mvor
         aC3G7YGm4ouahN28EkF/AEdjdl1D45xTNIcca96S2oFlddSUFfQ1C/vU89bHDqaklrXO
         P9Zp5bkBxAgY+Kj2QdqNiNGtiWdLQYznmHZmy96PVxmzj2vfOoBppA5YZEGq/69JApmE
         SrS+baQoZnPWA8HVKrXtwFGmQecofBR27jppxIOM+ziP9qE/9m3/aEqIuTwV7JVrkA16
         gRfA==
X-Gm-Message-State: APjAAAVF9csBtPb6E6c4GfVovQ8rv+mie59CUPYjlnj7AjSP8ZsrYwXi
        TKWQM6KxLfajOcHjMLE1R7B0heCb
X-Google-Smtp-Source: APXvYqwQ9JXmRD0kp4WmAoAdecgmpMsS7PRMwz0Ipcaxd5co2jePGTNx79lMq2zn+0bvM2IZsURjGg==
X-Received: by 2002:a65:63c2:: with SMTP id n2mr14683848pgv.439.1553944968405;
        Sat, 30 Mar 2019 04:22:48 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id p3sm10637975pfp.136.2019.03.30.04.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/31] submodule-config.c: use repo_get_oid for reading .gitmodules
Date:   Sat, 30 Mar 2019 18:19:24 +0700
Message-Id: <20190330111927.18645-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 76e9bdc437 (submodule: support reading .gitmodules when it's not
in the working tree - 2018-10-25), every time you do

    git grep --recurse-submodules

you are likely to see one warning line per submodule (unless all those
submodules also have submodules). On a superproject with plenty of
submodules (I've seen one with 67) this is really annoying.

The warning was there because we could not resolve extended SHA-1
syntax on a submodule. We can now. Make use of the new API and get rid
of the warning.

It would be even better if config_with_options() supports multiple
repositories too. But one step at a time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule-config.c                 | 20 +++++++-------------
 t/t7814-grep-recurse-submodules.sh |  6 +-----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 66653e86b9..4264ee216f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -625,23 +625,16 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
+		char *oidstr = NULL;
 
 		file = repo_worktree_path(repo, GITMODULES_FILE);
 		if (file_exists(file)) {
 			config_source.file = file;
-		} else if (repo->submodule_prefix) {
-			/*
-			 * When get_oid and config_with_options, used below,
-			 * become able to work on a specific repository, this
-			 * warning branch can be removed.
-			 */
-			warning("nested submodules without %s in the working tree are not supported yet",
-				GITMODULES_FILE);
-			goto out;
-		} else if (get_oid(GITMODULES_INDEX, &oid) >= 0) {
-			config_source.blob = GITMODULES_INDEX;
-		} else if (get_oid(GITMODULES_HEAD, &oid) >= 0) {
-			config_source.blob = GITMODULES_HEAD;
+		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
+			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
+			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
@@ -649,6 +642,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		config_with_options(fn, data, &config_source, &opts);
 
 out:
+		free(oidstr);
 		free(file);
 	}
 }
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index fa475d52fa..134a694516 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -380,11 +380,7 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	fi
 '
 
-# Recursing down into nested submodules which do not have .gitmodules in their
-# working tree does not work yet. This is because config_from_gitmodules()
-# uses get_oid() and the latter is still not able to get objects from an
-# arbitrary repository (the nested submodule, in this case).
-test_expect_failure 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
+test_expect_success 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
 	test_when_finished "git -C submodule checkout .gitmodules" &&
 	rm submodule/.gitmodules &&
 	git grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-- 
2.21.0.479.g47ac719cd3


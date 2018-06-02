Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3107E1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeFBEdS (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37428 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeFBEdG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id r2-v6so17592984lff.4
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h02GFbSBP5wfpPi56nlFILyoxq1IhnuLEKyG2JSOreo=;
        b=ZRHSsD+NFZK0YUCWst3FU+nBxFv+tJrlYnuy7QNvB7KiBff7XPu67dNEyq7q0UG8hq
         oI2/WUmRWHTjxFdV1Xj0sLbVPRoKdbuJXs6uTnYT8qPkjaWIcnrYZrPhW59ruekALwJZ
         FAfhYih2ccb8S8Gb4cv+4eqqDvUMdaGC6Gxrd8/c4Y9Skk+zcAy5mtXpoDrPTzLMVamM
         FwrABuPemok75sBNMsiTXmHnu6mZpV3+euCZLLzpnwLgADRmnCu6eCnwr2xzYflyIVqi
         75/buAEEOl7HynhlM6rexMVL9GnLHUgppGNW7AP47ehAHgAgwUGeaClgo5lmfJUSBL82
         zk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h02GFbSBP5wfpPi56nlFILyoxq1IhnuLEKyG2JSOreo=;
        b=qibOuxY7zfOMX3PpTUH3S/gUC7ktxfhwwcbEDV83vIh+qvdtUWPTyP9QSiR3B335eN
         NChM8LfcIpY9TYTRKMiov6u9w3i/WZ6rer2m/CuI+Z9+JDVw2/vQQjlkzutUJDAbGWWg
         awZcO/gXGwqO14SbpvQ95GMaxPBUGtCUOY9zuU5iJHEcLyI3carKfYhWTher4HKYw5on
         gqwQQ59QbS0H8G2EdNFcGwAf/isCVxUh90Eij8ge/HMKtuRapaRAhdgwP++lRjIkAIqQ
         7SlnIzS+gmEqSRalQ52t+SyufIu0ZMOEyZ5WQnTrYlI4Uvt9XPDdAmEvyrdPF4Y/s4fH
         kv1w==
X-Gm-Message-State: ALKqPwfCg4EQ8BuJ7N2XaYCHX6+Q1px8v+SjBDG1neBVsezgNF/YNmm9
        mnygBV63lVCUlT/EXloTCy7Y7A==
X-Google-Smtp-Source: ADUXVKLMQzv5/29t0nfo+JpymZyPN37fHuKcUEXvtmx4DKf5IzZ7WdxgB/jPFqYiT/0021SY4tk8Gw==
X-Received: by 2002:a19:dd0b:: with SMTP id u11-v6mr8374750lfg.100.1527913984961;
        Fri, 01 Jun 2018 21:33:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/22] object.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:33 +0200
Message-Id: <20180602043241.9941-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object.c        | 10 +++++-----
 t/t1450-fsck.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index f7f4de3aaf..c20ea782f1 100644
--- a/object.c
+++ b/object.c
@@ -51,7 +51,7 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	if (gentle)
 		return -1;
 
-	die("invalid object type \"%s\"", str);
+	die(_("invalid object type \"%s\""), str);
 }
 
 /*
@@ -167,7 +167,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error("object %s is a %s, not a %s",
+			error(_("object %s is a %s, not a %s"),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
@@ -226,7 +226,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			obj = &tag->object;
 		}
 	} else {
-		warning("object %s has unknown type id %d", oid_to_hex(oid), type);
+		warning(_("object %s has unknown type id %d"), oid_to_hex(oid), type);
 		obj = NULL;
 	}
 	return obj;
@@ -259,7 +259,7 @@ struct object *parse_object(const struct object_id *oid)
 	    (!obj && has_object_file(oid) &&
 	     oid_object_info(the_repository, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
-			error("sha1 mismatch %s", oid_to_hex(oid));
+			error(_("sha1 mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(oid), NULL, 0);
@@ -270,7 +270,7 @@ struct object *parse_object(const struct object_id *oid)
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-			error("sha1 mismatch %s", oid_to_hex(repl));
+			error(_("sha1 mismatch %s"), oid_to_hex(repl));
 			return NULL;
 		}
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 91fd71444d..7b7602ddb4 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -372,7 +372,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
 	cat out &&
-	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+	test_i18ngrep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
 test_expect_success 'force fsck to ignore double author' '
-- 
2.18.0.rc0.309.g77c7720784


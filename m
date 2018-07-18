Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079C11F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbeGRQvk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46687 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so3846751lfc.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmedCYDPpluLH4/6uP6w1s+O3sdrKPVFTmlj/W+i8pE=;
        b=hIRUAkqJW1epM0ZEsBtMhskdbTjXXboN8jGVbx7vdtHXEDl8h76sDcSnEPba7DGtIO
         jE83lrpouSPYhPvaaWpImN5q15/sH/PwgSLjetk8zA3bGFGHAJc2Y/zxUGh7BLlR5LfW
         U+HgBz0mXWyZKhcNr2OpleWrWo+tEAFqYsmu5QOLRDxjA9r4RbXDCiBQBP1GBQ1ke8yq
         BGrZb9JlKwXvW9jELq6kohQDnKfBoFv65070/ufA/V5g4lUcvah8qKshCtHmedGazhIN
         DHNV+8+dhBRvEsjI5OAKyBgukTN8nt2enAotyo7qLUoLPRaiEcmiVA6LnM61Qt+Uqbd4
         DZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmedCYDPpluLH4/6uP6w1s+O3sdrKPVFTmlj/W+i8pE=;
        b=CG0szqAZTFzUgFjIPfsaSx7hFFEnlgX/hYoei0KZmmYPXJuxKFLYvR2nSXkRCvOKBs
         lK1fHN0HAQML4bcbv5tDKpRKZpprGXxhn8uYQrJJ7uNcPsaoaYZrPK+8EPlX+DUsSlHw
         A64OflNTqorZrRnAcaH4gJW+iwloxBtxeQF8smUDfdQ1bEwTwt6Pdf7/LGzxCQA8ESuX
         7uVsitDm52obc+I7/myOvznkt7mE5j/KziGO4elJmQVN0YMsWQ+EqryE28Wzs5CNO9MI
         cC2pL8NZ0ya32GfVYGYUFCkB8SKa/zNtBCrhSfa6KtWNQaGAIbd5avCoonGJqOd+jiRJ
         0nOw==
X-Gm-Message-State: AOUpUlGwINlh0S1BM9GIDcgdC2ZqcBdAp7wiBMyuocaHAYQSbidH8+L5
        vLAGwk3eYF4wInYYz6XdNfannQ==
X-Google-Smtp-Source: AAOMgpc+Mbma2NsHRen1RVlt9XtJ4fQjBsc4WzMtSRBWv8zc6Yjmf7KwsWu5guU3iG7qij9F5rJVZQ==
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr4629464lfj.111.1531930382033;
        Wed, 18 Jul 2018 09:13:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 15/23] object.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:53 +0200
Message-Id: <20180718161101.19765-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
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
index 10d167825e..477e686da7 100644
--- a/object.c
+++ b/object.c
@@ -49,7 +49,7 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	if (gentle)
 		return -1;
 
-	die("invalid object type \"%s\"", str);
+	die(_("invalid object type \"%s\""), str);
 }
 
 /*
@@ -169,7 +169,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error("object %s is a %s, not a %s",
+			error(_("object %s is a %s, not a %s"),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
@@ -229,7 +229,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			obj = &tag->object;
 		}
 	} else {
-		warning("object %s has unknown type id %d", oid_to_hex(oid), type);
+		warning(_("object %s has unknown type id %d"), oid_to_hex(oid), type);
 		obj = NULL;
 	}
 	return obj;
@@ -262,7 +262,7 @@ struct object *parse_object(const struct object_id *oid)
 	    (!obj && has_object_file(oid) &&
 	     oid_object_info(the_repository, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
-			error("sha1 mismatch %s", oid_to_hex(oid));
+			error(_("sha1 mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(oid), NULL, 0);
@@ -273,7 +273,7 @@ struct object *parse_object(const struct object_id *oid)
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
2.18.0.rc2.476.g39500d3211


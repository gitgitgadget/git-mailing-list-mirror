Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281FC1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935051AbeF3JJB (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35736 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934688AbeF3JIn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id i125-v6so9056508lji.2
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmedCYDPpluLH4/6uP6w1s+O3sdrKPVFTmlj/W+i8pE=;
        b=d0FFcfWoflgB2mZoFm3WF7Jm+lyReEU8Jd4ezfiG1+tH9CjgT/4X567CTSUoxd4ZZ1
         lviw7EpoOpcGdQ6G3S8YVCQZkeca5AAVYEg5iSmBfHq8TlrC8kOdHP+APc7CzFm3Q29H
         d4fn+NYBsTZllho48SE/7wALIZBM58ihIvas2PEH1Lrcj6Z3u53MCdsRqNuuBdlvmzlH
         Qh2jIx7ZxlrCyAxfdImxCmKyLYgIuhJHxPRDGDAsiKcBgBmyfyi76QAeSpKT7RNJje08
         q12oRcKEKUJImi+4hn+AcP+RXj09muInaN8b6dz5vci5j4ykaANnDs0LmD2RN3vo87cJ
         EvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmedCYDPpluLH4/6uP6w1s+O3sdrKPVFTmlj/W+i8pE=;
        b=HQs7oThCvGrIGg0Y4x98HKOkVzHMIDTXYHnlbQJ2KuF7/6qkuM4qS43NHcMFc2613w
         zx7eBA2oit/W4ZztbCntK9LoVOzG5qo/f8RtcdKiaQzTSo/BwTHuq5kh0jGq/pUvAlco
         sWYZkt3xFkZd3UdEyPYWqT7r7PC/mzstfit9Qxb54OUIp12CDlThlAUY96Z+j+zGtRwu
         TPJag+dmdqZLMMWtqx+Wn2NXdzfSbusn/cNI4nuN1nLwDH1tU26lwROKoK5LM+cio74H
         6LVCmxTWJ7o+oEA3WDcvxB3sHUsxTJTCEqJgYcFWAe5+UlYfukv76TF26kFoeuPw1Fy8
         sNpA==
X-Gm-Message-State: APt69E1TYnNRj6vX1K1SYX6sSvZT2PSr4D+GX8zS4UwKPHjhSAuot9jS
        hXJYLYwa8jHd3k1K4gbJ1o7NHw==
X-Google-Smtp-Source: ADUXVKIXbMrW+Z4vJAFojEYFXQoYijc4eIdomLsWxIHNhN5Cc8wUMlhJMphsNJIcoZOl+jWmFJuOCQ==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr11762588ljf.79.1530349721619;
        Sat, 30 Jun 2018 02:08:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/23] object.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:10 +0200
Message-Id: <20180630090818.28937-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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


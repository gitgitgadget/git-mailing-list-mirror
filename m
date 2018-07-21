Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77681F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeGUImB (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36137 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeGUImB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so3235768lfa.3
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAkQlyA3S7wSZi6Mbyx9745js7LsVYSGCwEpFrS0WB0=;
        b=P8AJECS9Pz4JOIxp1Ih6yeHza+wZfekZq7N7mBGasdWlAv0705e+ptPAN43A9jKVXc
         IIcPgGVQU4QFlQCLAeTcDwtUd4wg/IMyXvEi7TaYL8Z2RvxNUiuxrhlFgvsqxlrDzsJx
         zXKjbpdQ2XgtS5CwDloExrkum1ZmezP9EtTtqZes9czt1QgK/n7cORyAXQry4cWZPm69
         234qvDQQlCABaBiwL5M1D4wp8LhKU3E7Bj8Q9Lc0MqpRZCO29X4HL/Dy9lQK+OJmsoz5
         stSN+vJetofON3Buqxij4r3rTyX+etbktYADLHWYcHldtT4pU3ZwmNInofokJj/AlnTp
         p6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAkQlyA3S7wSZi6Mbyx9745js7LsVYSGCwEpFrS0WB0=;
        b=L5CI2tx0DGQBVg27BfrJyPNXBLDXo8W6Fx6ETPUxWxEQlaSm+IfbihBOyuoy3pCw95
         ENGXYqkZArBsyGfdPsWuW/OH8gO2SDS8S2VXoS5sEXBTe3eP7FxO9unKpCI8/xALF/qe
         hkMciMIwONrxsvKOvIiY6lhod1ZyiQ0toCYYVr1WSAn7qnlSz/wVr9q1mbX7N//vgO4P
         1Xhqta/z0QM3aLOhQDEMpkQeYFaEaa9lsfVF5JrHjpj92WZCaJD3XNME+xMr3rS6B5dd
         k6O70pJDpOmYBU0etmZ5l7N4fbw/jwCjzxCRMcDncHENQG89p3sHL4n1bAapVF8V8q0c
         Pf3w==
X-Gm-Message-State: AOUpUlGUmLTlssLBXeaaur1PLYhjKjSQwUF0mqRfpueldbBlEBb3qF1U
        kYRvaMh89/c7p9HlSYOOlM0=
X-Google-Smtp-Source: AAOMgpcn6P4tsHO9BLJhf5IFlCIgZLyy+AiUNJwlGDaB1ZSfkzoAj9kvWkzkLk+ju9WdELUH2W7YKw==
X-Received: by 2002:a19:eac1:: with SMTP id y62-v6mr3137705lfi.138.1532159411812;
        Sat, 21 Jul 2018 00:50:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 15/23] object.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:33 +0200
Message-Id: <20180721074941.14632-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
2.18.0.656.gda699b98b3


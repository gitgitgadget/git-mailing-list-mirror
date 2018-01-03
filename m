Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17141F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeACQgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42861 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeACQf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id b141so3677172wme.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zQPaNCFOa90rLEhQezp+n8GwrDBNVZhrkuCoHO5P4m4=;
        b=FFT0DHXJ5iV9gxP7fLROnt6bG5ZccGDj8imcLoWdCfaXqmnKfkN83Erl5JBmirEyyC
         prWlfh5VYzEw816WxRnB4naGccJK2u9eM0/G2vDKxWs+uT0dEJ/0pvRk7+ZwhHUx+5Z4
         cVD4UoTa+V6sUleVEN7RIB9XyvyoyNM9L3Qt4Pq4OuofucFXRBJ2lh8/r+pvihcWO9D1
         N0EU0kFjZ07cKl4jxauEU3HbUTj6VPgIZfbfhOvBMTrn/5lddDUcO9kNxA3FF77n5tYC
         g4od3qdjCj7inxn3xZr5nbCNcVociwCFeBjyrRKDJQrM7065jH5wJVLEwC5ouQTWLI1r
         k6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zQPaNCFOa90rLEhQezp+n8GwrDBNVZhrkuCoHO5P4m4=;
        b=hA5u5tvUOb4H3pTuO4DgQUTbYL6k8cCGahP/tWrxzPYRIGL9hWkIGzo2cjGibjBa0v
         MxDdfOiEQNkgTjcjP4Tv2xs6c/pUsWb1/E5D4Xachw0Db0WdFGPbImv6W2/jRg4fJvH9
         HhmdQLol3OQ8jDsNohqRjOkf1VvJaUC7NfappLivddXOUY3/fcQtbvuigGnprepFopKP
         xMoxBmpgyJpS9lDMHaaqudIx5Wy9SA5sDPANheizW+ZjC8lH6M3BORtoahpVlZtXGlc2
         XDP/WnY94JUetHvSPKHIWrtQ+jPPwW0725zFFYaG2/8Qy07KodaoNWRfwV/v4+yvPqzA
         kKnQ==
X-Gm-Message-State: AKGB3mL5UcdbzkUxBbVHmSyo0LSoDiV/CdDZxrkOtAo32+vo+72PPRZ1
        hs3opiHaghjeD0zdeJlpw3oR7BId
X-Google-Smtp-Source: ACJfBouFjsk4+KCIkbiYubMPvK+yIQO3SYTj4bQyWOsUQ7FDmjZ4AlcJBVaYKkgoCzz3aKbP1UzX4A==
X-Received: by 10.28.19.195 with SMTP id 186mr1820558wmt.20.1514997325462;
        Wed, 03 Jan 2018 08:35:25 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 39/40] external-odb: use 'odb=magic' attribute to mark odb blobs
Date:   Wed,  3 Jan 2018 17:34:02 +0100
Message-Id: <20180103163403.11303-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To tell which blobs should be sent to the "magic" external odb,
let's require that the blobs be marked using the 'odb=magic'
attribute.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c                         | 25 ++++++++++++++++++++++---
 external-odb.h                         |  3 ++-
 sha1_file.c                            | 20 +++++++++++++++-----
 t/t0400-external-odb.sh                |  3 +++
 t/t0410-transfer-e-odb.sh              |  3 +++
 t/t0420-transfer-http-e-odb.sh         |  3 +++
 t/t0470-read-object-http-e-odb.sh      |  3 +++
 t/t0480-read-object-have-http-e-odb.sh |  3 +++
 8 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 50c1cec50b..e3a05e24e3 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -2,6 +2,7 @@
 #include "external-odb.h"
 #include "odb-helper.h"
 #include "config.h"
+#include "attr.h"
 
 static struct odb_helper *helpers;
 static struct odb_helper **helpers_tail = &helpers;
@@ -165,19 +166,37 @@ int external_odb_get_object(const unsigned char *sha1)
 	return external_odb_do_get_object(sha1);
 }
 
+static int has_odb_attrs(struct odb_helper *o, const char *path)
+{
+	static struct attr_check *check;
+
+	if (!check)
+		check = attr_check_initl("odb", NULL);
+
+	if (!git_check_attr(path, check)) {
+		const char *value = check->items[0].value;
+		return value ? !strcmp(o->name, value) : 0;
+	}
+	return 0;
+}
+
 int external_odb_put_object(const void *buf, size_t len,
-			    const char *type, unsigned char *sha1)
+			    const char *type, unsigned char *sha1,
+			    const char *path)
 {
 	struct odb_helper *o;
 
 	external_odb_init();
 
 	/* For now accept only blobs */
-	if (strcmp(type, "blob"))
+	if (!path || strcmp(type, "blob"))
 		return 1;
 
 	for (o = helpers; o; o = o->next) {
-		int r = odb_helper_put_object(o, buf, len, type, sha1);
+		int r;
+		if (!has_odb_attrs(o, path))
+			continue;
+		r = odb_helper_put_object(o, buf, len, type, sha1);
 		if (r <= 0)
 			return r;
 	}
diff --git a/external-odb.h b/external-odb.h
index 26bb931685..5a8936f417 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -7,6 +7,7 @@ extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
 extern int external_odb_put_object(const void *buf, size_t len,
-				   const char *type, unsigned char *sha1);
+				   const char *type, unsigned char *sha1,
+				   const char *path);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/sha1_file.c b/sha1_file.c
index 300029459f..d3f395e967 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1696,7 +1696,9 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
+static int write_sha1_file_with_path(const void *buf, unsigned long len,
+				     const char *type, unsigned char *sha1,
+				     const char *path)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
@@ -1705,13 +1707,19 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (!external_odb_put_object(buf, len, type, sha1))
+	if (!external_odb_put_object(buf, len, type, sha1, path))
 		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
 
+int write_sha1_file(const void *buf, unsigned long len,
+		    const char *type, unsigned char *sha1)
+{
+	return write_sha1_file_with_path(buf, len, type, sha1, NULL);
+}
+
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
 			     struct object_id *oid, unsigned flags)
 {
@@ -1832,7 +1840,8 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), oid->hash);
+		ret = write_sha1_file_with_path(buf, size, typename(type),
+						oid->hash, path);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), oid->hash);
 	if (re_allocated)
@@ -1854,8 +1863,9 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 				 get_safe_crlf(flags));
 
 	if (write_object)
-		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				      oid->hash);
+		ret = write_sha1_file_with_path(sbuf.buf, sbuf.len,
+						typename(OBJ_BLOB),
+						oid->hash, path);
 	else
 		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
 				     oid->hash);
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index f924de870f..944b7bb28f 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -71,6 +71,9 @@ test_expect_success 'helper can add objects to alt repo' '
 
 test_expect_success 'commit adds objects to alt repo' '
 	test_config odb.magic.scriptCommand "$HELPER" &&
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit three &&
 	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
 	content=$(git -C alt-repo show "$hash3") &&
diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
index 065ec7d759..fd3e37918c 100755
--- a/t/t0410-transfer-e-odb.sh
+++ b/t/t0410-transfer-e-odb.sh
@@ -111,6 +111,9 @@ test_expect_success 'setup other repo and its alternate repo' '
 '
 
 test_expect_success 'new blobs are put in first object store' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	content=$(cd alt-repo1 && git show "$hash1") &&
diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index f84fe950ec..d307af0457 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -94,6 +94,9 @@ test_expect_success 'can delete uploaded files' '
 FILES_DIR="httpd/www/files"
 
 test_expect_success 'new blobs are transfered to the http server' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	echo "$hash1-4-blob" >expected &&
diff --git a/t/t0470-read-object-http-e-odb.sh b/t/t0470-read-object-http-e-odb.sh
index 774528c04f..d814a43d59 100755
--- a/t/t0470-read-object-http-e-odb.sh
+++ b/t/t0470-read-object-http-e-odb.sh
@@ -62,6 +62,9 @@ test_expect_success 'can delete uploaded files' '
 FILES_DIR="httpd/www/files"
 
 test_expect_success 'new blobs are transfered to the http server' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	echo "$hash1-4-blob" >expected &&
diff --git a/t/t0480-read-object-have-http-e-odb.sh b/t/t0480-read-object-have-http-e-odb.sh
index 056a40f2bb..fe1fac5ef3 100755
--- a/t/t0480-read-object-have-http-e-odb.sh
+++ b/t/t0480-read-object-have-http-e-odb.sh
@@ -62,6 +62,9 @@ test_expect_success 'can delete uploaded files' '
 FILES_DIR="httpd/www/files"
 
 test_expect_success 'new blobs are transfered to the http server' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	echo "$hash1-4-blob" >expected &&
-- 
2.16.0.rc0.16.g82191dbc6c.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9237F20A26
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdIPIIi (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38301 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdIPIIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id x17so4481480wmd.5
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=78nWHQ8fl31AMAFgyvcPjynpi+ZSbgAMk4q7E+PZ42k=;
        b=HpbQWu7gX4wSWkJjcDlpulm/xLnOlY3R6pBHRnWCk2uVCXjMa5wjNVFDMK96yqa1D+
         b6aRjxeNY+g2KfJzw2beK+AvsiEg8x3C+8uXIsB1i7lSvSJV0QnnfxtWS5bzX5Rfo/MG
         BHSXrbPjNR12N9cEuiaD11KY6U3QOPSlqGGkY7qAWKTVYQ3KrsrmPGc7G8UJNfQDQJaU
         CywhK8nEOaAiH6odmjjyEna/z5g0fcQsINa2jCdWFr8t7XHppQZG6ExVmwQeVgnDg1p3
         8PPgdvXITF4COnPVokwZreFaEppYAaktpYNovcxYPx2iwXYFUVsd+KJ+Yi3cW48dX7LJ
         6PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=78nWHQ8fl31AMAFgyvcPjynpi+ZSbgAMk4q7E+PZ42k=;
        b=WktGUsNhQtfgOTfNzYNGqhJBpu6RessUnFpl27GEBlJIpgBnbURjdUM9ZLyVDHyBGE
         BDaLzN84LIuWQI0JiGOlkiEHIR2tfv9Z2PoP8zug/0Z8yRJBxC9naa9PHWTy7dSJYJUf
         SxzY32QfnEEx3vTZbv3+Oikrq5uJ3XY6c8YVDzommyQWm2RRr/cm/1eYGcFVMtuBquSZ
         lSaCY+npJATxOidwESOXvJmcfq6nz7J14d/NOfDLprpUKJFgQ2/iUwtL/6yz1PodzB7F
         n+UH9J3uH19Aswn7fxyyrZl49OlxtGtDmbZUlEAbSoPPAiFI7a4PEfdd7u+bpKB0EEow
         iJyQ==
X-Gm-Message-State: AHPjjUg0cH+D7modDWXb/vGlVgIctdc+pyqc3/TIzqImLLba/i9siVER
        ob4WQxBw3bVDg+ZpK196E1ucJw==
X-Google-Smtp-Source: AOwi7QBE4HnMpJ66NLv6zN2NI516He1I1IoVSPkO8KxYhDFsl2BbhUWOtAGS2MZOvk8lg40qENdpww==
X-Received: by 10.28.152.8 with SMTP id a8mr3538067wme.131.1505549310435;
        Sat, 16 Sep 2017 01:08:30 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:29 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 33/40] external-odb: use 'odb=magic' attribute to mark odb blobs
Date:   Sat, 16 Sep 2017 10:07:24 +0200
Message-Id: <20170916080731.13925-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To tell which blobs should be sent to the "magic" external odb,
let's require that the blobs be marked using the 'odb=magic'
attribute.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c                         | 22 ++++++++++++++++++++--
 external-odb.h                         |  3 ++-
 sha1_file.c                            | 20 +++++++++++++++-----
 t/t0400-external-odb.sh                |  3 +++
 t/t0410-transfer-e-odb.sh              |  3 +++
 t/t0420-transfer-http-e-odb.sh         |  3 +++
 t/t0470-read-object-http-e-odb.sh      |  3 +++
 t/t0480-read-object-have-http-e-odb.sh |  3 +++
 8 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 084cd32e0b..e103514a46 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "external-odb.h"
 #include "odb-helper.h"
+#include "attr.h"
 
 static struct odb_helper *helpers;
 static struct odb_helper **helpers_tail = &helpers;
@@ -155,8 +156,23 @@ int external_odb_get_object(const unsigned char *sha1)
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
 
@@ -164,12 +180,14 @@ int external_odb_put_object(const void *buf, size_t len,
 		return 1;
 
 	/* For now accept only blobs */
-	if (strcmp(type, "blob"))
+	if (!path || strcmp(type, "blob"))
 		return 1;
 
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
+		if (!has_odb_attrs(o, path))
+			continue;
 		int r = odb_helper_put_object(o, buf, len, type, sha1);
 		if (r <= 0)
 			return r;
diff --git a/external-odb.h b/external-odb.h
index 1fda08c0fb..93a3b35a04 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -6,6 +6,7 @@ extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
 extern int external_odb_put_object(const void *buf, size_t len,
-				   const char *type, unsigned char *sha1);
+				   const char *type, unsigned char *sha1,
+				   const char *path);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/sha1_file.c b/sha1_file.c
index c5b6d89b97..24fbc28eab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1631,7 +1631,9 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
+static int write_sha1_file_with_path(const void *buf, unsigned long len,
+				     const char *type, unsigned char *sha1,
+				     const char *path)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
@@ -1640,13 +1642,19 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
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
+	write_sha1_file_with_path(buf, len, type, sha1, NULL);
+}
+
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
 			     struct object_id *oid, unsigned flags)
 {
@@ -1767,7 +1775,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file_with_path(buf, size, typename(type),
+						sha1, path);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), sha1);
 	if (re_allocated)
@@ -1789,8 +1798,9 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
 
 	if (write_object)
-		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				      sha1);
+		ret = write_sha1_file_with_path(sbuf.buf, sbuf.len,
+						typename(OBJ_BLOB),
+						sha1, path);
 	else
 		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
 				     sha1);
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 03df030461..492c772076 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -73,6 +73,9 @@ test_expect_success 'helper can add objects to alt repo' '
 
 test_expect_success 'commit adds objects to alt repo' '
 	test_config odb.magic.scriptCommand "$HELPER" &&
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit three &&
 	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
 	content=$(cd alt-repo && git show "$hash3") &&
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
2.14.1.576.g3f707d88cd


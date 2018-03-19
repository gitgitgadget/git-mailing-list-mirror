Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB92D1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbeCSNdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38520 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755565AbeCSNc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id l16so6369003wmh.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qayd8cSdcvZBsIcfAOyJkxU7vUC3jin8s3SUnYnbRrE=;
        b=FoUl4Y99mNjbhVCkWY184vuKJL2MtWblwmfU6kaOI1sB3czHUqvMJUxfCASjJwi5K4
         arzFH2Qw9gvwfopoz/Wklc1FMhEWZb2hn+fUbTDnP9JtDK1gD2nX/7jFCpRW+DWmaPzo
         pX1CsxmKQSG1qC1a2/S29LnWddSIQuh+/da7BuhjkXRa69E3WNv3LWiihQd9yviNBtn6
         kNwO0BJn1quNZkWqe2lDJtPk1yj5sW7NbJDHoDn2i3Q+sGKhU1w5BBER4P8p5xvECivm
         UEEOyTVX6C3SvCY0jphRquTk4wbsSslwe1ZGuNsmsvWCgaXYlD9bpjumNhJ9p6vN/Kt8
         1CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qayd8cSdcvZBsIcfAOyJkxU7vUC3jin8s3SUnYnbRrE=;
        b=Tjokzq7h5bVXNcoKMqqBtvNThbqsfdxeTJzAQhKlXDxxzpu54ilZe60R1Ou+q+MT3X
         dPY22NUuOgdjujS6UXg7WbPTDfn7loFDuSvwAaUXabakL8YM5tUGFb7YoyKJzPIQHDZp
         HXQ4UxMcvoTtVg8r1chtMNjZoiykpRFsDKPrcAgP1hJ97doYL6W23LhmFTMABRzaCVVh
         cYUhM7JuJHWI4d0dpNOWsu4zEaW2Usx0prUYpREYDFIhP+MgJZjyKAE3xIVMRTQRim4K
         rIHiWs+8NIUTALR4NWr28HNvv8/MU0IleeQoTtE7WnWoVlEBrR0Ah+mxNIfFQP+9lcKY
         umhA==
X-Gm-Message-State: AElRT7E8bR1TQeV8cRre5vXfGPGrcdMQ+YXjvxdntdS7O/4LNuyi/D+c
        0VHNeldhGKtKlhX7rxGkrr3rpLDi
X-Google-Smtp-Source: AG47ELvz2m7B4TemimadgTF6v8tO7LOkGkNU4n0BtBmaJJW7ht5fEgrXPv/6gi7BTcalnrBw+ef86Q==
X-Received: by 10.28.185.208 with SMTP id j199mr9247585wmf.9.1521466376548;
        Mon, 19 Mar 2018 06:32:56 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:55 -0700 (PDT)
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
Subject: [PATCH v2 35/36] external-odb: use 'odb=magic' attribute to mark odb blobs
Date:   Mon, 19 Mar 2018 14:31:46 +0100
Message-Id: <20180319133147.15413-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 sha1_file.c                            | 20 ++++++++++++++------
 t/t0500-external-odb.sh                |  3 +++
 t/t0510-transfer-e-odb.sh              |  3 +++
 t/t0520-transfer-http-e-odb.sh         |  3 +++
 t/t0570-read-object-http-e-odb.sh      |  3 +++
 t/t0580-read-object-have-http-e-odb.sh |  3 +++
 8 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 5e5871c933..af2fc4a120 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -2,6 +2,7 @@
 #include "external-odb.h"
 #include "odb-helper.h"
 #include "config.h"
+#include "attr.h"
 
 static struct odb_helper *helpers;
 static struct odb_helper **helpers_tail = &helpers;
@@ -211,19 +212,37 @@ int external_odb_get_object(const unsigned char *sha1)
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
index 60da8ed3d4..a7f4d7eec0 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -19,6 +19,7 @@ extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
 extern int external_odb_get_many_direct(const struct oid_array *to_get);
 extern int external_odb_put_object(const void *buf, size_t len,
-				   const char *type, unsigned char *sha1);
+				   const char *type, unsigned char *sha1,
+				   const char *path);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/sha1_file.c b/sha1_file.c
index 9ccdae35bc..b8e5af3cb8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1708,8 +1708,9 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
-int write_object_file(const void *buf, unsigned long len, const char *type,
-		      struct object_id *oid)
+static int write_object_file_with_path(const void *buf, unsigned long len,
+				       const char *type, struct object_id *oid,
+				       const char *path)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
@@ -1718,13 +1719,19 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
-	if (!external_odb_put_object(buf, len, type, oid->hash))
+	if (!external_odb_put_object(buf, len, type, oid->hash, path))
 		return 0;
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		return 0;
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
+int write_object_file(const void *buf, unsigned long len,
+		      const char *type, struct object_id *oid)
+{
+	return write_object_file_with_path(buf, len, type, oid, NULL);
+}
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
@@ -1846,7 +1853,8 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_object_file(buf, size, type_name(type), oid);
+		ret = write_object_file_with_path(buf, size, type_name(type),
+						  oid, path);
 	else
 		ret = hash_object_file(buf, size, type_name(type), oid);
 	if (re_allocated)
@@ -1868,8 +1876,8 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 				 get_conv_flags(flags));
 
 	if (write_object)
-		ret = write_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
-					oid);
+		ret = write_object_file_with_path(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
+						  oid, path);
 	else
 		ret = hash_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
 				       oid);
diff --git a/t/t0500-external-odb.sh b/t/t0500-external-odb.sh
index f924de870f..944b7bb28f 100755
--- a/t/t0500-external-odb.sh
+++ b/t/t0500-external-odb.sh
@@ -71,6 +71,9 @@ test_expect_success 'helper can add objects to alt repo' '
 
 test_expect_success 'commit adds objects to alt repo' '
 	test_config odb.magic.scriptCommand "$HELPER" &&
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit three &&
 	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
 	content=$(git -C alt-repo show "$hash3") &&
diff --git a/t/t0510-transfer-e-odb.sh b/t/t0510-transfer-e-odb.sh
index 065ec7d759..fd3e37918c 100755
--- a/t/t0510-transfer-e-odb.sh
+++ b/t/t0510-transfer-e-odb.sh
@@ -111,6 +111,9 @@ test_expect_success 'setup other repo and its alternate repo' '
 '
 
 test_expect_success 'new blobs are put in first object store' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	content=$(cd alt-repo1 && git show "$hash1") &&
diff --git a/t/t0520-transfer-http-e-odb.sh b/t/t0520-transfer-http-e-odb.sh
index f84fe950ec..d307af0457 100755
--- a/t/t0520-transfer-http-e-odb.sh
+++ b/t/t0520-transfer-http-e-odb.sh
@@ -94,6 +94,9 @@ test_expect_success 'can delete uploaded files' '
 FILES_DIR="httpd/www/files"
 
 test_expect_success 'new blobs are transfered to the http server' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	echo "$hash1-4-blob" >expected &&
diff --git a/t/t0570-read-object-http-e-odb.sh b/t/t0570-read-object-http-e-odb.sh
index 1b2205e273..56980b700a 100755
--- a/t/t0570-read-object-http-e-odb.sh
+++ b/t/t0570-read-object-http-e-odb.sh
@@ -62,6 +62,9 @@ test_expect_success 'can delete uploaded files' '
 FILES_DIR="httpd/www/files"
 
 test_expect_success 'new blobs are transfered to the http server' '
+	echo "* odb=magic" >.gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git add .gitattributes &&
+	GIT_NO_EXTERNAL_ODB=1 git commit -m "Add .gitattributes" &&
 	test_commit one &&
 	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
 	echo "$hash1-4-blob" >expected &&
diff --git a/t/t0580-read-object-have-http-e-odb.sh b/t/t0580-read-object-have-http-e-odb.sh
index 9cbfb18d28..fea0205e2e 100755
--- a/t/t0580-read-object-have-http-e-odb.sh
+++ b/t/t0580-read-object-have-http-e-odb.sh
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
2.17.0.rc0.37.g8f476fabe9


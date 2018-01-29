Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB80F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeA2Whq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:46 -0500
Received: from mail-io0-f202.google.com ([209.85.223.202]:49918 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeA2Who (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:44 -0500
Received: by mail-io0-f202.google.com with SMTP id 62so9414642iow.16
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=tVIVkf01LfLG/O6wnx4Usmd9I2r3KlUtFvd4sgBbd4w=;
        b=kIjojauhlSH2wzNWb0Ws68ctOwwo7UIJhZc9604xFcolPUwv1fL/P2TcyS1YxUsYZV
         ozNjoCFpBBEUIqzvJrN8/imEkVzEZwfeDjgtDXKJd+2EMGW6wcbuhLXCsFNgymeek1HU
         p276mYgfuoJh8Va7aU77bPTfx1fljUp+mtDo36wHpZvTlcnMk4TpNfEMD4R8aFV9cvv0
         v7ujOBJ/b5G4d2MEkiNOOsQQSp0y5ElhNXLWKzh18m9thtTqYVcsskSjgxvUT3O1pUo+
         jTsXdXhaD+n2UFdo6HjWZLPExYD2kKUuFTqxovABpVWhSc72uDwnx6rWCozk9NvYw8oG
         huhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=tVIVkf01LfLG/O6wnx4Usmd9I2r3KlUtFvd4sgBbd4w=;
        b=Y6kqNew1iO/hZGehW25i/3o2mWFDkEdLGbCNVNEALh5z33nKG0Nu+j5ULHyafxyHiq
         Vzb7clkdgZOLzu0Ma+slae4G0DSrvm64vIWZZ+l4Df0yubdvRILKfe06EFO2gKKO9Zef
         3jQ87U9rN/AnkxOBlIkDKCsPk7c6b28NhsOUnDU5o3+truEomgLuM6xNjA4yEfULSqwj
         yDhTTSV0PmKhXCGITOkWKhqKD0pB0s1jxJlp7l7CWF5j5ffG9WkRYKZhhSIpX37YArBy
         n7ZyAP+Z2QRtbG51WRskUTnHX8jPcwLRF/UYDKO2w5vFXamA4yYsurSPvThxV/mtw0Xl
         q46g==
X-Gm-Message-State: AKwxytd1ZtAlRW5GnaazQ3f58O2rU0LhSOSvLjDiwtJt9jWmWopCrkol
        zMS6o4H9CauQeg7y0spGx1Gw7b6qk9b6Aw4s/B7rz4RaaVpmBesbDkeUiRfECGGufLWYMcJcCV1
        8Jmr2nmg07ksRK0cXYjDbEkh18qA7qG0oGY36QtKGqTcfaPTPfNoM41vTzQ==
X-Google-Smtp-Source: AH8x225/+lmRH+JVqmKg23WqSNlH3Sy10mDjtQXe82Yqxwa3G53eeGCDeWNyLWSy8lczKzjhcAfSAp3W2/Y=
MIME-Version: 1.0
X-Received: by 10.36.123.150 with SMTP id q144mr8783599itc.17.1517265463202;
 Mon, 29 Jan 2018 14:37:43 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:52 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-2-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 01/37] object_info: change member name from 'typename' to 'type_name'
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/cat-file.c |  2 +-
 cache.h            |  2 +-
 packfile.c         |  6 +++---
 sha1_file.c        | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75..d06c66c77 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -76,7 +76,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		oi.typename = &sb;
+		oi.type_name = &sb;
 		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
diff --git a/cache.h b/cache.h
index d8b975a57..69b5a3bf8 100644
--- a/cache.h
+++ b/cache.h
@@ -1744,7 +1744,7 @@ struct object_info {
 	unsigned long *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
-	struct strbuf *typename;
+	struct strbuf *type_name;
 	void **contentp;
 
 	/* Response */
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab1..6657a0a49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1350,16 +1350,16 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (oi->typep || oi->typename) {
+	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
 		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
 					     curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
-		if (oi->typename) {
+		if (oi->type_name) {
 			const char *tn = typename(ptot);
 			if (tn)
-				strbuf_addstr(oi->typename, tn);
+				strbuf_addstr(oi->type_name, tn);
 		}
 		if (ptot < 0) {
 			type = OBJ_BAD;
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac65..2c03458ea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1087,8 +1087,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	}
 
 	type = type_from_string_gently(type_buf, type_len, 1);
-	if (oi->typename)
-		strbuf_add(oi->typename, type_buf, type_len);
+	if (oi->type_name)
+		strbuf_add(oi->type_name, type_buf, type_len);
 	/*
 	 * Set type to 0 if its an unknown object and
 	 * we're obtaining the type using '--allow-unknown-type'
@@ -1158,7 +1158,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
+	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -1239,8 +1239,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 				*(oi->disk_sizep) = 0;
 			if (oi->delta_base_sha1)
 				hashclr(oi->delta_base_sha1);
-			if (oi->typename)
-				strbuf_addstr(oi->typename, typename(co->type));
+			if (oi->type_name)
+				strbuf_addstr(oi->type_name, typename(co->type));
 			if (oi->contentp)
 				*oi->contentp = xmemdupz(co->buf, co->size);
 			oi->whence = OI_CACHED;
-- 
2.16.0.rc1.238.g530d649a79-goog


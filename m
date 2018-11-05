Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B2A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbeKFEmg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40967 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so9123855ljb.8
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8tpCmTH50ipi2EfeBZ41WO2deLa9Z+Au3gmo8LY5gA=;
        b=T43HFKRjxhWJ4N5WfGzyAB4EXW+IQljfVGJqWMGpYtSxyVbRXuDzz9fL+d05QwnlK1
         z9Ll8gQ8euMnDydAhQaoN1EbIL+ao++13d9cGvPUm2UUJc6H9uSn1vwugw6hB1c9+CvG
         1koq94t0K7czPRaqOKIB5Yq9y/BH1Wd4bd4bSNvtYLgavClUYjxKYQ57+aFvNA9Ex74m
         jMwkzcbn/+zM6dYUIOQBWYHyv/mEoZ/C4gm4a1a9erSKdlzKnrq1fb+hOGtyUtFhNBuZ
         umKd/8farsskkh8MVhh/xQ9QHqhatv7fiGyff2R3siBJyHkC3aV4Xx2LGmy9F+hgvg2v
         T2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8tpCmTH50ipi2EfeBZ41WO2deLa9Z+Au3gmo8LY5gA=;
        b=ieckt9SivVE9LdOnijpqwhaZ0mKIPJKGPnAAqzb91kr3Nk1B4tWI6CnbXt3tGFBbu9
         9Dqtl4/7xraqVT7kNHztjwHv1GTm6+1MRCqSAr1tHdAE/vvF82xZ117ORFZntUHSI9h3
         kBlxWICRZBPOLWbQnSDVWMZYGlVVHTM3oxyht2MM/BpKfsENkjzx55UjK8754bV7/X20
         OiZSTz2pFw7JsuIyntEWI1t6urXxtPCzAjcztOzX0Wacyv4Ng6CJ56WGXHi1IzCJCEi7
         FVzECkFiLKw051PCSEBL4xaFfw2eTvTScKlRQN2+poECQI8L6o2v/v1mNtVLZ7cybc6b
         cYBQ==
X-Gm-Message-State: AGRZ1gJpL8gfN3dA754wQjltPFFv8oiQZRLvplP19oDU9p70dd5L1KxB
        euAMYA7Ru4YlILeM1ETvbQ2v8pLc
X-Google-Smtp-Source: AJdET5c4Z0gZ5fh5eog63+7Hvbnh3ivT2eyIZba3q8icBFiIUYoZypEo8M8SaorRhXWTT52DpYJQxw==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr14857082ljg.150.1541445685081;
        Mon, 05 Nov 2018 11:21:25 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 15/16] fsck: reduce word legos to help i18n
Date:   Mon,  5 Nov 2018 20:20:58 +0100
Message-Id: <20181105192059.20303-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These messages will be marked for translation later. Reduce word legos
and give translators almost full phrases. describe_object() is updated
so that it can be called from printf() twice.

While at there, remove \n from the strings to reduce a bit of work
from translators.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c | 62 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..504f47d7a4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -52,16 +52,24 @@ static int name_objects;
 
 static const char *describe_object(struct object *obj)
 {
-	static struct strbuf buf = STRBUF_INIT;
-	char *name = name_objects ?
-		lookup_decoration(fsck_walk_options.object_names, obj) : NULL;
+	static struct strbuf bufs[4] = {
+		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+	static int b = 0;
+	struct strbuf *buf;
+	char *name = NULL;
 
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, oid_to_hex(&obj->oid));
+	if (name_objects)
+		name = lookup_decoration(fsck_walk_options.object_names, obj);
+
+	buf = bufs + b;
+	b = (b + 1) % ARRAY_SIZE(bufs);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, oid_to_hex(&obj->oid));
 	if (name)
-		strbuf_addf(&buf, " (%s)", name);
+		strbuf_addf(buf, " (%s)", name);
 
-	return buf.buf;
+	return buf->buf;
 }
 
 static const char *printable_type(struct object *obj)
@@ -105,25 +113,26 @@ static int fsck_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void objreport(struct object *obj, const char *msg_type,
-			const char *err)
-{
-	fprintf(stderr, "%s in %s %s: %s\n",
-		msg_type, printable_type(obj), describe_object(obj), err);
-}
-
 static int objerror(struct object *obj, const char *err)
 {
 	errors_found |= ERROR_OBJECT;
-	objreport(obj, "error", err);
+	fprintf_ln(stderr, "error in %s %s: %s",
+		   printable_type(obj), describe_object(obj), err);
 	return -1;
 }
 
 static int fsck_error_func(struct fsck_options *o,
 	struct object *obj, int type, const char *message)
 {
-	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
-	return (type == FSCK_WARN) ? 0 : 1;
+	if (type == FSCK_WARN) {
+		fprintf_ln(stderr, "warning in %s %s: %s",
+			   printable_type(obj), describe_object(obj), message);
+		return 0;
+	}
+
+	fprintf_ln(stderr, "error in %s %s: %s",
+		   printable_type(obj), describe_object(obj), message);
+	return 1;
 }
 
 static struct object_array pending;
@@ -165,10 +174,12 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
-			printf("broken link from %7s %s\n",
-				 printable_type(parent), describe_object(parent));
-			printf("              to %7s %s\n",
-				 printable_type(obj), describe_object(obj));
+			printf_ln("broken link from %7s %s\n"
+				  "              to %7s %s",
+				  printable_type(parent),
+				  describe_object(parent),
+				  printable_type(obj),
+				  describe_object(obj));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -371,10 +382,11 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 		struct tag *tag = (struct tag *) obj;
 
 		if (show_tags && tag->tagged) {
-			printf("tagged %s %s", printable_type(tag->tagged),
-				describe_object(tag->tagged));
-			printf(" (%s) in %s\n", tag->tag,
-				describe_object(&tag->object));
+			printf_ln("tagged %s %s (%s) in %s",
+				  printable_type(tag->tagged),
+				  describe_object(tag->tagged),
+				  tag->tag,
+				  describe_object(&tag->object));
 		}
 	}
 
-- 
2.19.1.1005.gac84295441


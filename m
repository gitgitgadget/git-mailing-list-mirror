Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993011F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeKJPaA (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:30:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37919 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPaA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so2830993lfg.5
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BljdnMmPMUHe3lzkqluX++UkUGp0c3YQLgHM/DHuBt0=;
        b=E8AfB+nk4e1ldRBakEXntGYTCQYOJGioubZvlqPPMObGlzN8/Kso4ePrqYpWJ7JkSY
         1P5RdKK1NT1Vf/Vje/4DVgGjiyd70cKj7BzY+bPFFCkafgzMLvfXKWKAc7V7a6MccQi8
         itKeI3YI/jlrTIN2yi7TOZ/hArE3cSH8oVckB0mK7yxhWkH9KcrWtqjV8kFMCUOGeF+d
         cGsRpp0O35aRMOZWl9PcRCe6efjiVcPWv9nqPK0klkoCFeBbmiQ8n7bzs7Mg91cNMyI3
         yHPZ6CmYKp1jtzl3G3Sk9DZR0Boxy1+I8j93yYTV7OUiDe9NxyQE+rUnnuWKjbOFMSm6
         FgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BljdnMmPMUHe3lzkqluX++UkUGp0c3YQLgHM/DHuBt0=;
        b=rLhh93wb9xtNbLiIw/mRE2ki5FIIZtYQC3Mo7q9ozA2fNiKkCF99mXwMu+dS6MbKWI
         cdJjGue6AUdrkxVFsverWj1wJXZ+AdGi3MwIraP9cs+t7DtNGnOiyMFQUMwJnrjppDn9
         ntx4Ds35uHh5bdolc7Ga+2GH/zBHBsEeN7KXZyd4e0/4WW0L9UbmTo5akM0FaVJJelVs
         cTf5Id2Qtw4H4z+0kMZvOgHMhjV23qVKnyvyaBMCf2K9MSx7liewx5QgKbV+FtLNSPtV
         U5XKZp/dGbDDxPdNaZqeGOxMqXawYQOGOqrroRUqwAHohmkZKLhBcLC/kUI2ctAzmvAR
         pEjQ==
X-Gm-Message-State: AGRZ1gJSpJTklpWJWF6B+bFSZdtKgMBhtQciqlfOTgFjGnHaGuVDMwop
        EpyjJm26SfO5iFyT4+ucZhw=
X-Google-Smtp-Source: AJdET5et812WCGVPXUTdL7Xs3ue0taUrV7J+DO8r7BABqacfT5VjIo7od7uk4sQKasYiZ45kXctdbg==
X-Received: by 2002:a19:3809:: with SMTP id f9mr6516122lfa.148.1541826999124;
        Fri, 09 Nov 2018 21:16:39 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:38 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 15/16] fsck: reduce word legos to help i18n
Date:   Sat, 10 Nov 2018 06:16:14 +0100
Message-Id: <20181110051615.8641-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
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
 builtin/fsck.c | 65 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..1feb6142f4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -52,16 +52,24 @@ static int name_objects;
 
 static const char *describe_object(struct object *obj)
 {
-	static struct strbuf buf = STRBUF_INIT;
-	char *name = name_objects ?
-		lookup_decoration(fsck_walk_options.object_names, obj) : NULL;
+	static struct strbuf bufs[] = {
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
@@ -105,25 +113,29 @@ static int fsck_config(const char *var, const char *value, void *cb)
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
+	switch (type) {
+	case FSCK_WARN:
+		fprintf_ln(stderr, "warning in %s %s: %s",
+			   printable_type(obj), describe_object(obj), message);
+		return 0;
+	case FSCK_ERROR:
+		fprintf_ln(stderr, "error in %s %s: %s",
+			   printable_type(obj), describe_object(obj), message);
+		return 1;
+	default:
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback", type);
+	}
 }
 
 static struct object_array pending;
@@ -165,10 +177,12 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 
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
@@ -371,10 +385,11 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
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
2.19.1.1231.g84aef82467


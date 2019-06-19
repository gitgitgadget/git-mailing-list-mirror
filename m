Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315561F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFSJ7Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so9426684pff.9
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDt20+hF1qPNA9jcKvPTyrjKGPqKOXcyZCN4lRI/Hb8=;
        b=NHLjkrxlLz1xGGRaP8Mnl1V6tu5LeAX80G7d+YcdEHAUPSM/To+u5oODjBWtuUw5fy
         +B5ORjDPoG/tdAe817IArbyngWY0pQ7yDKX4y1ibCbPiiFkqK9ApjT64Agcmk2VFGy2H
         7FtqCE0+brt1IQ+D54sf61/x9nMSC4wE/EBXI2l2STAr6JZnz34W6BPY1tvQJXywJH5W
         6Zx3lfXMLxIQ0FYTOaTYMbGbxRI5cKqswbcRpvIiM7dQkt9JC9coaXTqLeUNBWjmn9Np
         olAh54fxS4p6YUE/tJA4IY+BdR2XLnMMG0dHgJng9am7MftLdep29BdhMmLt/rqey/gm
         AGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDt20+hF1qPNA9jcKvPTyrjKGPqKOXcyZCN4lRI/Hb8=;
        b=WH+YcYHMuDX7bE7f7/lWZPsQ5OSRC+E4drGFzdf6gpzuIxnlTz1Ips8O/3ee2EnNbf
         fW5ApHNNfW1LnQoLfmq92jmEnj+2LzVuQgo62QrsPYnscdHYKzh3UUsxHbAAU7WCzrmz
         SkpXrfo+I5CJOAR9yFJCncaw/h+r5pgyJYYVHn4ODQV6esAIaWzx9LCqYI3SiRD4oxlW
         bV39vFVS2lsIgULsPDH0t2bSri8oQssTegvYeobbnS9u3z5lzHSrgxV7DeOyMCSGENX3
         5AVn9rqaPsx69CpOOvsSGygbTRxYse4WJjUmuusm1CL/lqfEGaA4dyE1UAOQ6BqvW28P
         0prQ==
X-Gm-Message-State: APjAAAVipksL1Rlx1ria7+M9ZTEmhkxHGrkQm4Vt2UTdGpB8aYaFVMns
        UI2KC73uhwW4giq7Ug+VL92amAtp
X-Google-Smtp-Source: APXvYqzZDfPBbXSQQq7pNPIMH4Rnmyykl3rK4PmkB0yZY7TyEqLXKMa8efExrz0wtziuuJN2LQsP9Q==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr10391202pjb.115.1560938355171;
        Wed, 19 Jun 2019 02:59:15 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id a15sm3981099pgw.3.2019.06.19.02.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/8] split-index.c: dump "link" extension as json
Date:   Wed, 19 Jun 2019 16:58:52 +0700
Message-Id: <20190619095858.30124-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 json-writer.c | 14 ++++++++++++++
 json-writer.h |  2 ++
 split-index.c | 13 ++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/json-writer.c b/json-writer.c
index 281bc50b39..70403580ca 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "ewah/ewok.h"
 #include "json-writer.h"
 
 void jw_init(struct json_writer *jw)
@@ -218,6 +219,19 @@ void jw_object_stat_data(struct json_writer *jw, const char *name,
 	jw_end(jw);
 }
 
+static void dump_ewah_one(size_t pos, void *jw)
+{
+	jw_array_intmax(jw, pos);
+}
+
+void jw_object_ewah(struct json_writer *jw, const char *key,
+		    struct ewah_bitmap *ewah)
+{
+	jw_object_inline_begin_array(jw, key);
+	ewah_each_bit(ewah, dump_ewah_one, jw);
+	jw_end(jw);
+}
+
 static void increase_indent(struct strbuf *sb,
 			    const struct json_writer *jw,
 			    int indent)
diff --git a/json-writer.h b/json-writer.h
index 38f9c9bf68..3c173647d3 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -85,6 +85,8 @@ void jw_object_bool(struct json_writer *jw, const char *key, int value);
 void jw_object_null(struct json_writer *jw, const char *key);
 void jw_object_stat_data(struct json_writer *jw, const char *key,
 			 const struct stat_data *sd);
+void jw_object_ewah(struct json_writer *jw, const char *key,
+		    struct ewah_bitmap *ewah);
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
diff --git a/split-index.c b/split-index.c
index e6154e4ea9..d7b4420c92 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "json-writer.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
@@ -16,6 +17,7 @@ int read_link_extension(struct index_state *istate,
 {
 	const unsigned char *data = data_;
 	struct split_index *si;
+	unsigned long original_sz = sz;
 	int ret;
 
 	if (sz < the_hash_algo->rawsz)
@@ -25,7 +27,7 @@ int read_link_extension(struct index_state *istate,
 	data += the_hash_algo->rawsz;
 	sz -= the_hash_algo->rawsz;
 	if (!sz)
-		return 0;
+		goto done;
 	si->delete_bitmap = ewah_new();
 	ret = ewah_read_mmap(si->delete_bitmap, data, sz);
 	if (ret < 0)
@@ -38,6 +40,15 @@ int read_link_extension(struct index_state *istate,
 		return error("corrupt replace bitmap in link extension");
 	if (ret != sz)
 		return error("garbage at the end of link extension");
+done:
+	if (istate->jw) {
+		jw_object_inline_begin_object(istate->jw, "split-index");
+		jw_object_string(istate->jw, "oid", oid_to_hex(&si->base_oid));
+		jw_object_ewah(istate->jw, "delete-bitmap", si->delete_bitmap);
+		jw_object_ewah(istate->jw, "replace-bitmap", si->replace_bitmap);
+		jw_object_intmax(istate->jw, "ext-size", original_sz);
+		jw_end(istate->jw);
+	}
 	return 0;
 }
 
-- 
2.22.0.rc0.322.g2b0371e29a


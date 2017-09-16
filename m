Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F3720A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdIPII1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36014 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdIPII0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id r136so4499109wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T1TJymogVo3e3SdToA8x0lNMdhq/ynCk3NTPNRp35Ys=;
        b=ByADdrGEiAdWetnWA85e+uyUEiqLaPnZFbJtstup122qlIGhUO+dvjmAmwG25JyrCG
         ssVGUNX7z9S8aTLe+5qTLiCC2l9MU3FywbL3nE/DAltjeM75YyN9lggvMo8vKcLsCqne
         0c9Oa6nTn6NWnc8R0qhCFew1ZJbKGXl02thOCnpvhWeTh+BEImy3uw87tmagLL/fCe/B
         rk6Kl+0ttrKbq9dnno9+CA6yej2hWI7UKkk0uVk/a1Baw0m2NYyEBIzkCxUm0C3+8mum
         Rrzp89GdUwekBsbs0noSCzH3nN60yjRB5sfiA4XzKiecKLIo2AfniWheR46Z+wLcgop1
         UorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T1TJymogVo3e3SdToA8x0lNMdhq/ynCk3NTPNRp35Ys=;
        b=naQXMjr9CMuA8PBMXqYQutlQdkRjfO5B6twGcYN8j/S/YKe1twJK3DUarKi9zOszme
         rCbQwIkAWIbMAWfH2zTEHAkCr7eJISZWw3yj8A16YZqt2+oJZB6xF7oOoq0cg5I1n5N4
         Zkx1Q0zIq/sSQMxwezSX4+rPShnOrL7UUmK2BqMsZIOI0ZxejUsLfOxInfZmLroSgSOO
         jy70iwkpXUHFrK3oIYiOsbHoMTITFziKT7mnp/Jgi+mCCIoMOG1d8w2/m7c1fXlkRfEP
         r5efFZU8UZwLrsqK9ZYdSMScQv8kHPXqOuy0tyrzQBK92jRJ4yv9hFTlIdnkB+9zMKih
         um9Q==
X-Gm-Message-State: AHPjjUjtwZldhqZOkLFLgvrDPQch4m4PANt5MId2tsmk5nJlkMaiD6pK
        P+CW0yn+tHOn59PRdIRlgLHTlg==
X-Google-Smtp-Source: AOwi7QBnaJY7N00BVJZtvLFul9jLqZ4g2WWUSUWzX01xQXEJr5UehGi0ZxLu4Izt5iH+Qmx+L+yUeA==
X-Received: by 10.28.186.135 with SMTP id k129mr4935079wmf.100.1505549304569;
        Sat, 16 Sep 2017 01:08:24 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:23 -0700 (PDT)
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
Subject: [PATCH v6 29/40] odb-helper: add put_object_process()
Date:   Sat, 16 Sep 2017 10:07:20 +0200
Message-Id: <20170916080731.13925-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the infrastructure to send objects to a sub-process
handling the communication with an external odb.

For now we only handle sending raw blobs using the 'put_raw_obj'
instruction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 3148bcfa15..356f6172d8 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -433,6 +433,58 @@ static int get_object_process(struct odb_helper *o, const unsigned char *sha1, i
 					  o->cmd, cur_cap);
 }
 
+static int send_put_packets(struct object_process *entry,
+			    const unsigned char *sha1,
+			    const void *buf,
+			    size_t len,
+			    struct strbuf *status)
+{
+	struct child_process *process = &entry->subprocess.process;
+	int err = packet_write_fmt_gently(process->in, "command=put_raw_obj\n");
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "size=%"PRIuMAX"\n", len);
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "kind=blob\n");
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
+
+	err = write_packetized_from_buf(buf, len, process->in);
+	if (err)
+		return err;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int put_object_process(struct odb_helper *o,
+			      const void *buf, size_t len,
+			      const char *type, unsigned char *sha1)
+{
+	int err;
+	struct object_process *entry;
+	struct strbuf status = STRBUF_INIT;
+
+	entry = launch_object_process(o, ODB_HELPER_CAP_PUT_RAW_OBJ);
+	if (!entry)
+		return -1;
+
+	err = send_put_packets(entry, sha1, buf, len, &status);
+
+	return check_object_process_error(err, status.buf, entry, o->cmd,
+					  ODB_HELPER_CAP_PUT_RAW_OBJ);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -904,9 +956,9 @@ int odb_helper_get_object(struct odb_helper *o,
 	return res;
 }
 
-int odb_helper_put_object(struct odb_helper *o,
-			  const void *buf, size_t len,
-			  const char *type, unsigned char *sha1)
+static int put_raw_object_script(struct odb_helper *o,
+				 const void *buf, size_t len,
+				 const char *type, unsigned char *sha1)
 {
 	struct odb_helper_cmd cmd;
 
@@ -932,3 +984,20 @@ int odb_helper_put_object(struct odb_helper *o,
 	odb_helper_finish(o, &cmd);
 	return 0;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	if (o->script_mode)
+		res = put_raw_object_script(o, buf, len, type, sha1);
+	else
+		res = put_object_process(o, buf, len, type, sha1);
+
+	trace_performance_since(start, "odb_helper_put_object");
+
+	return res;
+}
-- 
2.14.1.576.g3f707d88cd


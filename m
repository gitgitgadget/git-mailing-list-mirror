Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C3420A28
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdIPIId (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33868 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdIPIIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so4521953wma.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Uaw5PE53xy1gRrSCpkCGvwVJWwaidomnEqgPSWpQIM=;
        b=RiCR+MtelUPYaCbMsesX4TGIGhn9675ygIIcQWWP8CP0LIOsgc8PFoPkLOq2ZQToks
         uoP8PAD6v+5vmbck5LX4VdxvsHbizhNI+WaWAi3DlhkY3VR+JePA0a42fYoBrlWxUtjL
         2FW7s2V0RoEXJTC+6iB/EnETtoBViDlqurrHO7+yXEs1+LYSSxA8g94K3TGhdNgOqam2
         /eGdSC+l+nLD7XcADOSAV1EhqWx1dN5JFuTanP60VuzrUiENcHwYcwd+eDoFozDyMJnD
         sZVpql92xHCJmg46XR9xTNakyrleo6wHAjgfMmrvuYIAFEG5mqKsnGp8hr4J10ilez0y
         ClSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Uaw5PE53xy1gRrSCpkCGvwVJWwaidomnEqgPSWpQIM=;
        b=d3mu8PE0Gy4FTFikVdt4rrsYMRnUfkyYSB9TXqtPTJ3oen3kcHjQQGBuEBqBdEHLfl
         kotdB7siphAyUPg7Ph7RKooOPcs1hjd7K2dgeYX9+x5r36IqURJrKZdO0ky9JqiQWuOp
         unorOabvT8gqOJt4aD7fdQhJqLlPHJJluMUt7GRrmYFySp2QrPW4kHZAP6tlT3lNPFWp
         ptdSMAC75tntDAu5BqMufd/isCvrZr06oaGn7aFM/6kbwNVTjVe+jPT42Cf1PDirJ2G4
         hPF1OrKyrwA/9hQ5zUXs2ICPkJ6hzJlf3rPKUccd3it86dewOidgFlGr93TVxdtkhetl
         eHIA==
X-Gm-Message-State: AHPjjUh8/V6CTEX34hUizIl7Ui9KbOc3qZMbqdgqC3M3sJzp9qfnahtG
        7Jd9cSXE4cHzZYuEoCmM1wFOvw==
X-Google-Smtp-Source: AOwi7QBz4zCCC5tVb4FyHlqlNF6WRSfJmQeX79qUzrQfNzqZM7T6Ak5QnpyER1lN6BC1j0KyzpwxvQ==
X-Received: by 10.28.92.73 with SMTP id q70mr4759804wmb.150.1505549307433;
        Sat, 16 Sep 2017 01:08:27 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:26 -0700 (PDT)
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
Subject: [PATCH v6 31/40] odb-helper: add have_object_process()
Date:   Sat, 16 Sep 2017 10:07:22 +0200
Message-Id: <20170916080731.13925-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the infrastructure to handle 'have' instructions in
process mode.

The answer from the helper sub-process should be like the
output in script mode, that is lines like this:

sha1 SPACE size SPACE type NEWLINE

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index 356f6172d8..7433a4bfc6 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -634,6 +634,71 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int send_have_packets(struct odb_helper *o,
+			     struct object_process *entry,
+			     struct strbuf *status)
+{
+	char *line;
+	int packet_len;
+	int total_got = 0;
+	struct child_process *process = &entry->subprocess.process;
+	int err = packet_write_fmt_gently(process->in, "command=have\n");
+
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+		char *p = buf;
+		int more;
+
+		packet_len = packet_read(process->out, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		total_got += packet_len;
+
+		/* 'have' packets should end with '\n' or '\0' */
+		do {
+			char *eol = strchrnul(p, '\n');
+			more = (*eol == '\n');
+			*eol = '\0';
+			if (add_have_entry(o, p))
+				break;
+			p = eol + 1;
+		} while (more && *p);
+	}
+
+	if (packet_len < 0)
+		return packet_len;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int have_object_process(struct odb_helper *o)
+{
+	int err;
+	struct object_process *entry;
+	struct strbuf status = STRBUF_INIT;
+
+	entry = launch_object_process(o, ODB_HELPER_CAP_HAVE);
+	if (!entry)
+		return -1;
+
+	err = send_have_packets(o, entry, &status);
+
+	return check_object_process_error(err, status.buf, entry, o->cmd,
+					  ODB_HELPER_CAP_HAVE);
+}
+
 static void have_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
@@ -655,12 +720,20 @@ static void have_object_script(struct odb_helper *o)
 
 static void odb_helper_load_have(struct odb_helper *o)
 {
+	uint64_t start;
+
 	if (o->have_valid)
 		return;
 	o->have_valid = 1;
 
+	start = getnanotime();
+
 	if (o->script_mode)
 		have_object_script(o);
+	else
+		have_object_process(o);
+
+	trace_performance_since(start, "odb_helper_load_have");
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
-- 
2.14.1.576.g3f707d88cd


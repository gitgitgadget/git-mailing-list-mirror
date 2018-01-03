Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356F51F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeACQf2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:28 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32818 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeACQfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:24 -0500
Received: by mail-wr0-f195.google.com with SMTP id v21so2154501wrc.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hPINiVlpB2JdlkJCWKYZM8Sc8DWuliColb1Vf9zFMA=;
        b=iSgm3cJ8xzOzKIgoqt2pqQ9pG11EyZHjfkltd9bryT8ApOSN0x1ZgPiNJJ/itkAYBv
         dkCZy7pAlCXYCah+hyIbaCURfdGEAJaDKZedVapZkFnZrgg78K5DoRJ4t25AwMzzgE6p
         67Uiar9WcEu+AmD9vaghYE3DAK2pqXWXt1VlAe/wVIJjckDSYaC3B2Vpaal5ehM0yhg5
         CnKr4X7jF9avvbUm5HXg5m6QTqyahwH2fXg74hzWsLNe+xAC5xSxQKvEfPJ8gjrzVif/
         GRJ8+DV77LZLpiyooDQcPWYppaFOfz6Y88oDCIV/VwgE5ei1BGWvWJXQ0qEt7K4sG/v+
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8hPINiVlpB2JdlkJCWKYZM8Sc8DWuliColb1Vf9zFMA=;
        b=DmwwdK5awrMeHdMBLpA/7FIRWRTmhJpQ8gwyhJ2d6BDWFxb+Uou8CHilRiYP5tcvKd
         CVU2rx98VQyoGG/LN65eUClFu3wli2ZPBY2TpLwN19YxFpD7afhaTyRn/sznGYJt9wnT
         6x9fjd6iNUP3BUBplWJUm0U+xc64uFKiRA4p+3kdke7tmilo8Ylz+H6heJL6wUvxjam3
         YlDAwvAk7xrO2I6p25ABJGEoiwv1D3FIQuUio/jxE7i3zcgv2/Kxho5CCwccOxrpC5Hl
         YydBfuMv3xRzDKHNGEVY9HWyQKrs/5C14Gz1byouFpjWPW8pDfhFIWzlRtg/Tk6HTHNO
         77Kg==
X-Gm-Message-State: AKGB3mK247W0MlmVZMWjiX3utVYUdE0EvngFe3Jdt2nYsDz6V8MiDrjd
        SNyGYg5i9a5Pr/KgsUFqV6Gdiq32
X-Google-Smtp-Source: ACJfBov2cvuvRMv6RwRiLLK7T6LwjDyCkiSB579/9qGtxdn0yrxmM/yvi8X6i+rfuMUfxslBCn1Qwg==
X-Received: by 10.223.201.147 with SMTP id f19mr2034451wrh.198.1514997322703;
        Wed, 03 Jan 2018 08:35:22 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:22 -0800 (PST)
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
Subject: [PATCH 37/40] odb-helper: add have_object_process()
Date:   Wed,  3 Jan 2018 17:34:00 +0100
Message-Id: <20180103163403.11303-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
 odb-helper.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index d901f6d0bc..d8902a9541 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -635,6 +635,70 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
+static int send_have_packets(struct odb_helper *o,
+			     struct object_process *entry,
+			     struct strbuf *status)
+{
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
+	return check_object_process_error(err, status.buf, entry, o->dealer,
+					  ODB_HELPER_CAP_HAVE);
+}
+
 static void have_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
@@ -656,12 +720,20 @@ static void have_object_script(struct odb_helper *o)
 
 static void odb_helper_load_have(struct odb_helper *o)
 {
+	uint64_t start;
+
 	if (o->have_valid)
 		return;
 	o->have_valid = 1;
 
+	start = getnanotime();
+
 	if (o->type == ODB_HELPER_SCRIPT_CMD)
 		have_object_script(o);
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
+		have_object_process(o);
+
+	trace_performance_since(start, "odb_helper_load_have");
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
@@ -923,7 +995,7 @@ int odb_helper_get_direct(struct odb_helper *o,
 		fetch_object(o->dealer, sha1);
 	else if (o->type == ODB_HELPER_SCRIPT_CMD)
 		res = get_direct_script(o, sha1);
-	else
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
 		res = get_object_process(o, sha1, -1);
 
 	trace_performance_since(start, "odb_helper_get_direct");
@@ -993,7 +1065,7 @@ int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1)
 {
-	int res;
+	int res = 0;
 	uint64_t start = getnanotime();
 
 	if (o->type == ODB_HELPER_SCRIPT_CMD)
-- 
2.16.0.rc0.16.g82191dbc6c.dirty


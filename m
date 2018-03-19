Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB511F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeCSNdY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50207 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933370AbeCSNcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id f19so2598817wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=siyKP0JoSdQ/+GndyZdEaJ1cGF/8OZuJuiefhExPAU4=;
        b=eddxkcibVvhUTtqe22NUqEcA/U3WVnwthu3Oujp6TOLC2E1ZZi1z7v4ZdMLACqb7z+
         x948h2TxrWlYKI92vBbrBmxxvLJFxEEfDLqViQ7OGPWqV/h0Pf49MOWW7kQCn+Chyu7u
         khHGIG9AH9aBQcJ1qWJe8LBXkyYG6VGWaEVDMPX7QQF0ZDYhBbKj85C2FcllUCrI2o9z
         7fbqL+Ah2EOPH0TUOpv1yqeiOYLYACqy+hZ1w/jdmK7U0jNhzwtSNAVTDBmNm7rdt+RR
         eKeklZvIR5QsL0mRRmdcx5QWh8yD6EavMlxbchC8rSV9E41+PHcrJQ/vzNUXgfxonoMk
         UMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=siyKP0JoSdQ/+GndyZdEaJ1cGF/8OZuJuiefhExPAU4=;
        b=i6shSeD2RFSvHSjRcB+juOYQ1LtsR3QaVnMKXQVsmV6Arj7QYoJ4LtQANhIDaONFvx
         vYH7UK4g2YGQ9kZQa8Ydwyt7goe5giCyc7UWsH/C4SbpDo1RZWhLBL1xzAQIUWRVGyZh
         ixyAocaw/jxhfZjh+zxo4R6atw1RJkeszgYPubT31mNtCnKJ6ugnQNiQEScQaMWHxE+q
         p2JIIGilFd4yxYMlxkmvZB2bqkHvY/S4NKV+08YDjl9ocajtAQxbraS4vU4ZS7nT5rTe
         Wqgbka4pQcxwdk81oOWkT3xTMT+fRkuV/WoIzfA8VNS5+HdgnSbj04+H9umunZdIeSge
         7ZFg==
X-Gm-Message-State: AElRT7FUEjI/287SRGLU3lJ89dnWpucp7iL1Ggf7dIPZqj8+phU3iVTR
        kobpq1DA9vj9X0IREEJ8IQ9+jbvs
X-Google-Smtp-Source: AG47ELsRsBFO8lu0Room1G1Fm69vE7OqYEFL8T/LWPGwbjZ7bggti7qTrWlXnVAarM6YqOlRJAmIpQ==
X-Received: by 10.28.176.134 with SMTP id z128mr6465878wme.86.1521466374109;
        Mon, 19 Mar 2018 06:32:54 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:53 -0700 (PDT)
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
Subject: [PATCH v2 33/36] odb-helper: add have_object_process()
Date:   Mon, 19 Mar 2018 14:31:44 +0100
Message-Id: <20180319133147.15413-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 odb-helper.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index 83f8cce3b1..5ec21e9d1f 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -649,6 +649,70 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return oidcmp(&a->oid, &b->oid);
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
@@ -670,12 +734,20 @@ static void have_object_script(struct odb_helper *o)
 
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
@@ -937,7 +1009,7 @@ int odb_helper_get_direct(struct odb_helper *o,
 		fetch_object(o->dealer, sha1);
 	else if (o->type == ODB_HELPER_SCRIPT_CMD)
 		res = get_direct_script(o, sha1);
-	else
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
 		res = get_object_process(o, sha1, -1);
 
 	trace_performance_since(start, "odb_helper_get_direct");
-- 
2.17.0.rc0.37.g8f476fabe9


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5AE1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeACQfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:31 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39808 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeACQfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id o101so2144379wrb.6
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4+AMDWUCYTiaB+wtLK5AX8NHXbjexpSUt1PoaX5lTs=;
        b=GekYBIm3kSgp7X4lrbM5sESJuBV4NgO7cnqn5s1d3tBrMBLFm6fwc7iO8uG6KsGIHG
         lHhoi71zdGfyzpJih6quOElSH1V2iMFykGWMU7aEJz4q0DDfm2Dh5fdJ5u+g1s5wwf9F
         40IxWOf3YHhhpnnNhZ3sUvmj73QbNq2JOrFzVYPmkIApK71y2MkhOMAYnw2RsWXmsFoa
         JMh4UdpywczisRaONbjkMrfDGMZQAKv3uf1/mkdnU0vS0TO454qzmIrGULvPwlrRLT6Y
         lXWibITgcvdbmKd49r+IJM1KlzDTCNidH6ehMg8WwWLZ3uckDSgQ0UHQefRUaDQ6mBA2
         MUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4+AMDWUCYTiaB+wtLK5AX8NHXbjexpSUt1PoaX5lTs=;
        b=crlQLSZtaaebw9k/ghWrmC8oqeGUVvRlai6W+VsI1v4h1apQ6KkzVZ7MZzhop2r/gT
         bMeGmyI+Oawy9u6eazI6/BsqwBxn4Mg8gmbUWRm/9rLayH/L0dY2zHWBRnurFFhxE90R
         8Uf0g5AMFYsvpR4KyXXk+KVpOD0fnSdzgH86vgp/+plfjspqpoiBzdXDKlfAh0MoeMCW
         EncksA1pZXeyUQWa0PhUvaIIbyVEpqUq9mcelQQEUoO1AqfP3AfAv4ySVmeb93mZE0UF
         MNzdarPnhfrGsBvU0ICHBNRKgVeBnyea17Fxue0dMOIlH6Kb/NOBosdrV911Qqv0UQ47
         wG8w==
X-Gm-Message-State: AKGB3mJZFRRwcxhyxuc1oG4H28syAOXluXiOt2BFyuhHbqd5cf9OjvSW
        +VXpk0VCq2Y4HD05JRDGk/bbWdZj
X-Google-Smtp-Source: ACJfBovQPTAPMFZG5hjFOuXxsAOhtxuBaoMhhLW7kc46YLizjcx0PNoIZmthnFa4If64sBkpetMB9Q==
X-Received: by 10.223.133.143 with SMTP id 15mr2085634wrt.266.1514997319915;
        Wed, 03 Jan 2018 08:35:19 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:19 -0800 (PST)
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
Subject: [PATCH 35/40] odb-helper: add put_object_process()
Date:   Wed,  3 Jan 2018 17:33:58 +0100
Message-Id: <20180103163403.11303-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
index a67dfddca0..d901f6d0bc 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -434,6 +434,58 @@ static int get_object_process(struct odb_helper *o, const unsigned char *sha1, i
 					  o->dealer, cur_cap);
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
+	return check_object_process_error(err, status.buf, entry, o->dealer,
+					  ODB_HELPER_CAP_PUT_RAW_OBJ);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -908,9 +960,9 @@ int odb_helper_get_object(struct odb_helper *o,
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
 
@@ -936,3 +988,20 @@ int odb_helper_put_object(struct odb_helper *o,
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
+	if (o->type == ODB_HELPER_SCRIPT_CMD)
+		res = put_raw_object_script(o, buf, len, type, sha1);
+	else if (o->type == ODB_HELPER_SUBPROCESS_CMD)
+		res = put_object_process(o, buf, len, type, sha1);
+
+	trace_performance_since(start, "odb_helper_put_object");
+
+	return res;
+}
-- 
2.16.0.rc0.16.g82191dbc6c.dirty


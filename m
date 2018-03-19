Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9BF1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeCSNd5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45401 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933301AbeCSNcx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id h2so18574704wre.12
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DBH31gSuyQFDOS40bNyHsRVBTcedcax/KvBPAeAmaqQ=;
        b=ag+ZbXdv7xr0JR6JP4vvuQ7tYc3gygyRQWPQ0SwdCBB4cMTB/0QWZNk4Hkn5fnpU+7
         KLUkabfWJazrXqM8fzobHddXVGbvsfsBPImv/0q7WIjk229WkL8FV2xe/bMzzNw8oRGu
         1yMN+zxLu3/TShUbKSdgCvooU3NHHFg5AvZAALvCMUdKuACdIgmeJ4QSS7ANxEzIWjkZ
         Kwet6mi1MQBmOlQhkKQFdFrEC0Tqb6l7pP8YuXtL6peoloW+e3KxndR+VtveXGDejuxV
         7Hzo1sUDwQt0ypJbje0g7skZKjRgkCGGw80JbzY3ux8vmrbfHDMSNjd3/ca6+kKOhyL0
         9YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DBH31gSuyQFDOS40bNyHsRVBTcedcax/KvBPAeAmaqQ=;
        b=j3u6RD4I5SSEFds2xYV0T6mMVdovvw+EVAtCY2oH1kcyL5l93Crp890vnq1YF6CEJ6
         /2DpntLk+2TKdVgB23amtrdPbMYLgBKEmQZlqSo60hyLws4oXW4vCC5w1LxV4JfPQodD
         jRValnWb63XGBLyD6XFvodz/EDLJP6/06NilMheSPkTy3GtZEz4lRSjbZ7r8o7s8HUSe
         E+UovsW6zSQmi2CK5tepEoluAY8uOcEaA0V38MPknHQPAS5k7uzvlcurQDd4DVWoayOc
         mGnchUPHKalZ2sd6nixIVS2sfiDx3/j+lx24B3vniF1YUfa8qGMyoBAikZKGFfKjh48N
         vA5A==
X-Gm-Message-State: AElRT7GiMvU090mQbA2BJgoEoJnJcQn79lsnX70nhAubJLL56sB2BEd3
        Gv1fvQz+a8dp5LQDJX+4c7I2TyR/
X-Google-Smtp-Source: AG47ELvPoaH92gUodtqdAT6imZc8UtVJJNG1yRRLWMR79jRibgsU0ZkU4j1gmyo4periM2ZnlYOhNg==
X-Received: by 10.223.131.37 with SMTP id 34mr9845020wrd.169.1521466371597;
        Mon, 19 Mar 2018 06:32:51 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:50 -0700 (PDT)
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
Subject: [PATCH v2 31/36] odb-helper: add put_object_process()
Date:   Mon, 19 Mar 2018 14:31:42 +0100
Message-Id: <20180319133147.15413-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 odb-helper.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index cad3d1005c..83f8cce3b1 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -442,6 +442,58 @@ static int get_object_process(struct odb_helper *o, const unsigned char *sha1, i
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
@@ -938,15 +990,12 @@ int odb_helper_get_object(struct odb_helper *o,
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
 
-	if (o->type != ODB_HELPER_SCRIPT_CMD)
-		return 1;
-
 	if (odb_helper_start(o, &cmd, 1, "put_raw_obj %s %"PRIuMAX" %s",
 			     sha1_to_hex(sha1), (uintmax_t)len, type) < 0)
 		return -1;
@@ -969,3 +1018,20 @@ int odb_helper_put_object(struct odb_helper *o,
 	odb_helper_finish(o, &cmd);
 	return 0;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	int res = 1;
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
2.17.0.rc0.37.g8f476fabe9


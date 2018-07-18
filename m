Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986051F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeGRQvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36886 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbeGRQvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:42 -0400
Received: by mail-lf0-f66.google.com with SMTP id j8-v6so3862981lfb.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGvI0yEjkgFRvQVjuKFqhYpAqmBo++2hlRfWqrK0/yE=;
        b=RnzyL0B2a+mP/ETGirjw99Qu99xW9bkfBzxHH7DZlNBo/gMXIFVdyPpIGTGy9b/d93
         awJ3yo4vIT2ZDsqi/G5wLtTGZIgMVNcZQmSJYsqWkR7OAnX+je1VFJHBSU1vDIEIslpa
         iDyWb/p4oMsE5iMS+VAqifY0E3eu8Xmm3mtSsWlxJiVhmJdHm+kNQaPEls6lv0lcG2Wz
         23vcLq1ZApQSCEmIxoVUqN0koDPmZidmn14oPEDA6j5C2/FjrMFz4c4GCk7xdqx1O6Kg
         jzNMXQo8fkgIglo3I+hRCtTujYXu/PNd262P+EQMaJn+b1pf9WuqlAvDn0F6LGKmPfrv
         W5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGvI0yEjkgFRvQVjuKFqhYpAqmBo++2hlRfWqrK0/yE=;
        b=Irfl+WU4uWk2mfrybxgsa1bxFLUTxKNZac89kTyORfCs4cY6bQjHvED409bw4BA0qA
         HSyeZ6YCr+dXcGIL/cQeuYVm/iRf8O1JNOCXUrPHIVWa2qTa/Qnmu9BxozaKJsb6Lr4x
         CRYBH5wJ9cJ+vbRQ22mZps0/MeLTFrEhDBOG+rjeHFV2XY8cCcvOigGDuoFc9afi2Wsj
         HaZsETKN6/gmcX1m2iJHrPuAJawdKRCK8FGgpSmRDk/pyQ6d3wK5fZZZE+BXnPHziVx3
         E5f6AtkG+zmGTWjSNzydnbMCHxd0AYUy1EUWulRSeyhBzuRxCiD6u6iDb9VM8Em3IF5g
         x8vQ==
X-Gm-Message-State: AOUpUlFvGueRbv2QS2u19fWW3FEbTI+i3441f7KVXPPiYCoa68xjSrpJ
        3kdvj4gMM0Y1Pn7hvTSGr8J7CA==
X-Google-Smtp-Source: AAOMgpf6Of7BAblOfMjQs9/smsgTUyUQx8eq5LXBF1CwAmPn2SJ5nklrs8YrzwZ7FJZ0KP2za51RQA==
X-Received: by 2002:a19:4b90:: with SMTP id y138-v6mr4293587lfa.118.1531930383499;
        Wed, 18 Jul 2018 09:13:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/23] pkt-line.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:54 +0200
Message-Id: <20180718161101.19765-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pkt-line.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 941e41dfc1..04d10bbd03 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -101,7 +101,7 @@ int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
 	if (write_in_full(fd, "0000", 4) < 0)
-		return error("flush packet write failed");
+		return error(_("flush packet write failed"));
 	return 0;
 }
 
@@ -139,7 +139,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	n = out->len - orig_len;
 
 	if (n > LARGE_PACKET_MAX)
-		die("protocol error: impossibly long line");
+		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&out->buf[orig_len], n);
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
@@ -155,9 +155,9 @@ static int packet_write_fmt_1(int fd, int gently,
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		if (!gently) {
 			check_pipe(errno);
-			die_errno("packet write with format failed");
+			die_errno(_("packet write with format failed"));
 		}
-		return error("packet write with format failed");
+		return error(_("packet write with format failed"));
 	}
 
 	return 0;
@@ -189,21 +189,21 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	size_t packet_size;
 
 	if (size > sizeof(packet_write_buffer) - 4)
-		return error("packet write failed - data exceeds max packet size");
+		return error(_("packet write failed - data exceeds max packet size"));
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
 	set_packet_header(packet_write_buffer, packet_size);
 	memcpy(packet_write_buffer + 4, buf, size);
 	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
-		return error("packet write failed");
+		return error(_("packet write failed"));
 	return 0;
 }
 
 void packet_write(int fd_out, const char *buf, size_t size)
 {
 	if (packet_write_gently(fd_out, buf, size))
-		die_errno("packet write failed");
+		die_errno(_("packet write failed"));
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
@@ -225,7 +225,7 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
 	n = buf->len - orig_len;
 
 	if (n > LARGE_PACKET_MAX)
-		die("protocol error: impossibly long line");
+		die(_("protocol error: impossibly long line"));
 
 	set_packet_header(&buf->buf[orig_len], n);
 	packet_trace(data, len, 1);
@@ -288,7 +288,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	} else {
 		ret = read_in_full(fd, dst, size);
 		if (ret < 0)
-			die_errno("read error");
+			die_errno(_("read error"));
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
@@ -296,7 +296,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
-		die("the remote end hung up unexpectedly");
+		die(_("the remote end hung up unexpectedly"));
 	}
 
 	return ret;
@@ -324,7 +324,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
-		die("protocol error: bad line length character: %.4s", linelen);
+		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
 		*pktlen = 0;
@@ -334,12 +334,12 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len < 4) {
-		die("protocol error: bad line length %d", len);
+		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
 	if ((unsigned)len >= size)
-		die("protocol error: bad line length %d", len);
+		die(_("protocol error: bad line length %d"), len);
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
-- 
2.18.0.rc2.476.g39500d3211


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123091F62E
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935079AbeF3JJE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41175 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934711AbeF3JIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id a17-v6so5937775ljd.8
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGvI0yEjkgFRvQVjuKFqhYpAqmBo++2hlRfWqrK0/yE=;
        b=ZgcQEkKsOHqQ3YpwaMQlvawuPfx2ypW89siA1ZPMex6OQpMfs0tUt2o1+pzKRY1iog
         GRJYZgcyuhHLPXUE58Puh3QqKS8ttlA7A/p7ytT1kf1nHpymPSl3N4mdVpI/lK0JJoD1
         bD5DgHX9afSijcxXj4UOzsrkufkLMAC6xNaiiKMJoVheHb6qhY3bBwXAzNYRKr2T8iPU
         bBFO88OujROoddz7S5R/MinC3nQI2bpGfQDeniJy8r2Le1I2XCW0U/BziMvwe3ZJhgzk
         Zy6OmfCNyUG4dcxKb0ke/mm9ETGIi06/IbMnj7pjbnXcDdyTAB/kHyjMNH7ePjFQ8xfi
         d5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGvI0yEjkgFRvQVjuKFqhYpAqmBo++2hlRfWqrK0/yE=;
        b=YwfTDyVze29tS9nPoIUo8DraEgpCHL1QkMx4ga6TjRXTsZeunYJ6+pn6R1JKIKGekq
         0kD+ogz2N8KTzKF44sgRL+P7+eciNVmT2N9EeuNexd2uZdc4TSgrWDSLOd0tPcp5/QNm
         MJuW6Mxp1I+4BMhVM/ScB/bMQsUHrLwBT3lrRgJwtrS7qBQtwVHwOx6qnIqN0ad7EspA
         pEkbMy285lFCs/bnbSi4/Lkf35QH5ZSQwSXulvQIE4FYHlQY3/xXLr4oRtmLvd3dByRV
         zGhlfqA0Zt13R4svgRsV/es1VK+10zTw8UmlYbzbTUCrR1B/a2LnFQy11M/KCkMFXkjI
         Bg1Q==
X-Gm-Message-State: APt69E0Ulfdy5ReTPjq/BJU9BuMqcVpuDmDXCtn2637Ki2STWUqBS/1i
        9hCxROR7Knm5cInFh8P9nDdLwg==
X-Google-Smtp-Source: AAOMgpdBhg8OzgOfGNVEyZmsVyAboeMCa9wFpmMy6Kv2i6a0w6bI3M4vKm1Dlt2loHVoFMkApFOYNg==
X-Received: by 2002:a2e:82ce:: with SMTP id n14-v6mr11759710ljh.34.1530349722821;
        Sat, 30 Jun 2018 02:08:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/23] pkt-line.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:11 +0200
Message-Id: <20180630090818.28937-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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


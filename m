Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF221F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbeGUImE (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40870 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGUImD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so3237468lfd.7
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/42h6Ppz943e+cg7QUkfLUTgpEpexFsGidhuqRX+wjM=;
        b=HZczAgdZVEI3IE82OS0amc+td+vpjnGPzUumBM+C7ifEd8Euv6I9jHc2BTQ6vImrhV
         dcBZCZjXA9Qe2+vvugXGu4GEX/egv8CsRJeLriVC+X0ev/S3ZSOO6DC+tBwVp/d8TrM6
         5jKS7KmsEpOcImw6EGhCJa4QfwyDajZgyfHf/Ygs1LqcR0crRuUtj5I/sM5xOPI3C0hC
         EY++Fb3ClrkPWfEUW/D9khL1ju9pIgIcB0dFmhp1Mqmnm9cJ8Plhlgs98MId1K+xJchQ
         rf37hTNbNAg02aja/+1uDYuQ5lz37EqE/9dcPL/dJtBIZVNJ2Ae2/eUlMpKmx68royrc
         NqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/42h6Ppz943e+cg7QUkfLUTgpEpexFsGidhuqRX+wjM=;
        b=Rr+pA1zco1tM1P4lFI6wC7+9IxWMcMIaZeLS1ShC3N6Sa58d9U8hNmJ+WkhRavbXWm
         3tUAoqSvA+xPhKEIvX67gYHC6c3HCrEYx0wf8EviE87VIZn+7k4CACO6nY4s1AxwDW/D
         LfPi88pgODCL4/WrtWGUJjYrG9Uohhwsn9rBEP69iQwuXsCNar9A1bMFW4SScl9ue1xd
         tusYlVDwzUUvTFIrlwfZzHc4F0yH1XM35dU2U8LHprXi1OBnf844lNmRviXeSQej5wVy
         KaAGCNxoilAer8Iq9n7FTb4g0re49BmXey3RMV26kud7M0sjjbbCbxHtMargGi6VLw9L
         5/QA==
X-Gm-Message-State: AOUpUlFMjDYR5O7BMXlz6vLBQurgn1uZ15CftB1LVVdTKZ6/iuUuZC+F
        urL1AcTM9Ilm0WS2Dgn22GUQw+cF
X-Google-Smtp-Source: AAOMgpcRhDHXsw7kebSiZg6M2rB5iFEXZQIcpI2viK91Q4BMiMdLCS1OPJxnM1L22b8j40dZIJrF3g==
X-Received: by 2002:a19:4d0a:: with SMTP id a10-v6mr2872221lfb.5.1532159412719;
        Sat, 21 Jul 2018 00:50:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 16/23] pkt-line.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:34 +0200
Message-Id: <20180721074941.14632-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
2.18.0.656.gda699b98b3


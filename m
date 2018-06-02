Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEB41F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeFBEd5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37429 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeFBEdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id r2-v6so17593019lff.4
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1e2IEq/i4Hd2PjSMTbDBEMsiFUokJzB0b+L2U/btOD8=;
        b=sjXMJyMv9MVK4PP2AmZQNoxtGM9RYovOiy4a5xTobSc1+I1TdWgLgdFgmPsoh/SIuy
         mR909wcTPFBAvi/lNEme5k56XR3Eyfe1bwh6Xk86jgn2N39NdSt+C/DTwrq1ftTeP2bC
         FjMmVKYKl/gCpWjGMfqYa/9ApDTy5xBzFWszlEbgKrAxSjjUD2kJ3eyVyVLlQUk270er
         nBUxOnTCJ4pFKH98ItzXQ9lbtqx+N1ZRRgsjzSuryDhyJVL9f+RwXfRc/Op8WJbD1t1k
         XhYUnDKbgP6gqX3gOgqc0Gnm103x6DWj/b1IVmanJjLD/xx55zaPyQjTAI6nnxPB3tk8
         e5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1e2IEq/i4Hd2PjSMTbDBEMsiFUokJzB0b+L2U/btOD8=;
        b=pY1jcw9rkw3xl3Hr1aTiXB84A3oqVU5QpzyY5wrC3g0H+3LtS6mfhj4B50oQS96Lde
         IBZ1EXw4ZMvhQzTBD0+imU+1OZix2pkLvVgyVsg+xzsaQHebdwOQ1GRn3OzUjl5KWTrU
         9P16nwxcmX3YUxJEJDgfjtF28sA7dl9pRvHKHNRdcN9OT+9mBsz4gFLNbSuVDpp2gx3U
         GwMcOXx48W9ZQ52NV58GuZKehth9Cs6FLvkZcz7q5pIdKsYxbp9tPg/YzElyhwcwxaUv
         8i/2s+i9AyIbmUAcFyiV9fy91+kCBSIFbTYrRVdO9hywXnFsd/czsxXB+LRJGcvTATIv
         zkHw==
X-Gm-Message-State: ALKqPweEAl4U8CU1MgCc3f/s83d55kyRDubrevdz5pm39qYeMZ2+Sy87
        Z2GkupIy15iTksgsp+PAk7/djw==
X-Google-Smtp-Source: ADUXVKKkoRb9tCbV5Ds1Z5G39GiGue1g+M3lqKQiUVfVWZywxqXdory9Vok/w1t22kdxQOGUDIaTgA==
X-Received: by 2002:a19:9a10:: with SMTP id c16-v6mr8504662lfe.60.1527913986114;
        Fri, 01 Jun 2018 21:33:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/22] pkt-line.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:34 +0200
Message-Id: <20180602043241.9941-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
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
index a593c08aad..04d10bbd03 100644
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
 
-		die("The remote end hung up unexpectedly");
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
2.18.0.rc0.309.g77c7720784


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA701F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbfAOTkl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:40:41 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40463 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTkl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:40:41 -0500
Received: by mail-yw1-f73.google.com with SMTP id l69so1806302ywb.7
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EwbOjoo5qDViTzaUrgYNroFFJtTiHj8Nw8EQazlPCSY=;
        b=MijtXrULbyMfzXFoorjhneXmKk5zdSAl5tT+pagBZOcrdoTDkHrQEiqQACoj/ltCbo
         kM3urYCMWkF2ZGhZJrEcG70DPuM8pzaKBcoGR+LEb/hft71YOcEakRVvtiVJ32m0pxQt
         mwruRyALYuRf3rM44ppIGn25tNI02SWz8nYzf+f0Kuo6CZiBLKb7KoFe1uC/kqPoQxhl
         gwr8ZipX6kMrVAM/qiwQa9UVCqS7Lw/aIJsh8qmuSEZeiD8a2cRf3dFeiu3Ziok9xy1M
         I25pLYIKJhG6/Qbq/P91pATeENRMPNpAps0k92D8Un68xpl1CnqLPAQO/k8+xqO5x4gR
         5Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EwbOjoo5qDViTzaUrgYNroFFJtTiHj8Nw8EQazlPCSY=;
        b=JxpBGbFQIb2Zs6n2x4JtfD/Ity9qqzUAejxNiWAyXW48m+G4BgRrrL7T3ZGCJZxcK2
         +ODHmzX+KWiNSxrZDUnDAQbHQmgGF7mrQ4L1aXzgjfKImRxJ2jZD1bnIZqOlXQqX2TjM
         SYH1io8gKn8JI2tY4UiBeZPG54poF5xhm8ojBNtMdPOKOVhG3Ys6/TP/q+CCESUTNUDF
         vUviGtvowmKIVltcLId85Kw1Q0LZlKGk35xCoeEXIHoLCktSm9xRX1QOspm1yFVbmnDu
         vvoAzYP/FK+esaYc3uoScQiea2w8twDL4ujeHfROSzEyGGtTUTUv37/r06bz0zb10lIp
         joDA==
X-Gm-Message-State: AJcUuke16IqXe3hnyCMk/Wy6rfrmz2zCcSbauFctuY7lLfGJCTMRg6P1
        r6nD9mLZsLiwvk8F19oLBNwN1E1w+OVEKfDcXYGihFagSgVkwFv+Ds9J97hdt2Qef8wK99O0kIZ
        xrRp3QgM0dRSis2T+mY9dMtDXexTCW3uJon28mrFRtwFlU3hQR2dzGPG4Jwrosf0KbFuL1kToD4
        Qu
X-Google-Smtp-Source: ALg8bN6ioT57LoL6EYh4q2w+T9+cGw/5AjPiGDxxgcVRLCSHbIO2uUBH2iptjFE7l1VWyIVGJnYNqiAcxvvzL6BI23mz
X-Received: by 2002:a25:af4e:: with SMTP id c14mr2143305ybj.28.1547581240278;
 Tue, 15 Jan 2019 11:40:40 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:40:28 -0800
In-Reply-To: <cover.1547581039.git.jonathantanmy@google.com>
Message-Id: <5aa5d047c828a0db10544c706dd595f09db3215d.1547581039.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547581039.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will teach struct packet_reader a new field that, if
set, instructs it to interpret read data as multiplexed. This will
create a dependency from pkt-line to sideband.

To avoid a circular dependency, split recv_sideband() into 2 parts: the
reading loop (left in recv_sideband()) and the processing of the
contents (in demultiplex_sideband()), and move the former into pkt-line.
This reverses the direction of dependency: sideband no longer depends on
pkt-line, and pkt-line now depends on sideband.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pkt-line.c |  22 ++++++++
 pkt-line.h |  16 ++++++
 sideband.c | 156 +++++++++++++++++++++++++----------------------------
 sideband.h |  14 ++++-
 4 files changed, 124 insertions(+), 84 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 9d3e402d41..5feb73ebec 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -439,6 +439,28 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 	return sb_out->len - orig_len;
 }
 
+int recv_sideband(const char *me, int in_stream, int out)
+{
+	char buf[LARGE_PACKET_MAX + 1];
+	int retval = 0;
+	int len;
+
+	while (1) {
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
+		retval = demultiplex_sideband(me, buf, len);
+		switch (retval) {
+		case SIDEBAND_PRIMARY:
+			write_or_die(out, buf + 1, len - 1);
+			break;
+		case SIDEBAND_PROGRESS:
+			/* already written by demultiplex_sideband() */
+			break;
+		default: /* errors: message already written */
+			return retval;
+		}
+	}
+}
+
 /* Packet Reader Functions */
 void packet_reader_init(struct packet_reader *reader, int fd,
 			char *src_buffer, size_t src_len,
diff --git a/pkt-line.h b/pkt-line.h
index 023ad2951d..a8e92a4b63 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "sideband.h"
 
 /*
  * Write a packetized stream, where each line is preceded by
@@ -120,6 +121,21 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
  */
 ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
 
+/*
+ * Receive multiplexed output stream over git native protocol.
+ * in_stream is the input stream from the remote, which carries data
+ * in pkt_line format with band designator.  Demultiplex it into out
+ * and err and return error appropriately.  Band #1 carries the
+ * primary payload.  Things coming over band #2 is not necessarily
+ * error; they are usually informative message on the standard error
+ * stream, aka "verbose").  A message over band #3 is a signal that
+ * the remote died unexpectedly.  A flush() concludes the stream.
+ *
+ * Returns SIDEBAND_FLUSH upon a normal conclusion, and SIDEBAND_PROTOCOL_ERROR
+ * or SIDEBAND_REMOTE_ERROR if an error occurred.
+ */
+int recv_sideband(const char *me, int in_stream, int out);
+
 struct packet_reader {
 	/* source file descriptor */
 	int fd;
diff --git a/sideband.c b/sideband.c
index 368647acf8..dce22d20b1 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
-#include "pkt-line.h"
 #include "sideband.h"
 #include "help.h"
 
@@ -109,103 +108,94 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 }
 
 
-/*
- * Receive multiplexed output stream over git native protocol.
- * in_stream is the input stream from the remote, which carries data
- * in pkt_line format with band designator.  Demultiplex it into out
- * and err and return error appropriately.  Band #1 carries the
- * primary payload.  Things coming over band #2 is not necessarily
- * error; they are usually informative message on the standard error
- * stream, aka "verbose").  A message over band #3 is a signal that
- * the remote died unexpectedly.  A flush() concludes the stream.
- */
-
 #define DISPLAY_PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int recv_sideband(const char *me, int in_stream, int out)
+int demultiplex_sideband(const char *me, char *buf, int len)
 {
-	const char *suffix;
-	char buf[LARGE_PACKET_MAX + 1];
+	static const char *suffix;
 	struct strbuf outbuf = STRBUF_INIT;
 	int retval = 0;
+	const char *b, *brk;
+	int band;
+
+	if (!suffix) {
+		if (isatty(2) && !is_terminal_dumb())
+			suffix = ANSI_SUFFIX;
+		else
+			suffix = DUMB_SUFFIX;
+	}
 
-	if (isatty(2) && !is_terminal_dumb())
-		suffix = ANSI_SUFFIX;
-	else
-		suffix = DUMB_SUFFIX;
+	if (len == 0) {
+		retval = SIDEBAND_FLUSH;
+		goto cleanup;
+	}
+	if (len < 1) {
+		strbuf_addf(&outbuf,
+			    "%s%s: protocol error: no band designator",
+			    outbuf.len ? "\n" : "", me);
+		retval = SIDEBAND_PROTOCOL_ERROR;
+		goto cleanup;
+	}
+	band = buf[0] & 0xff;
+	buf[len] = '\0';
+	len--;
+	switch (band) {
+	case 3:
+		strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+			    DISPLAY_PREFIX);
+		maybe_colorize_sideband(&outbuf, buf + 1, len);
+
+		retval = SIDEBAND_REMOTE_ERROR;
+		break;
+	case 2:
+		b = buf + 1;
 
-	while (!retval) {
-		const char *b, *brk;
-		int band, len;
-		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		if (len == 0)
-			break;
-		if (len < 1) {
-			strbuf_addf(&outbuf,
-				    "%s%s: protocol error: no band designator",
-				    outbuf.len ? "\n" : "", me);
-			retval = SIDEBAND_PROTOCOL_ERROR;
-			break;
-		}
-		band = buf[0] & 0xff;
-		buf[len] = '\0';
-		len--;
-		switch (band) {
-		case 3:
-			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX);
-			maybe_colorize_sideband(&outbuf, buf + 1, len);
-
-			retval = SIDEBAND_REMOTE_ERROR;
-			break;
-		case 2:
-			b = buf + 1;
-
-			/*
-			 * Append a suffix to each nonempty line to clear the
-			 * end of the screen line.
-			 *
-			 * The output is accumulated in a buffer and
-			 * each line is printed to stderr using
-			 * write(2) to ensure inter-process atomicity.
-			 */
-			while ((brk = strpbrk(b, "\n\r"))) {
-				int linelen = brk - b;
-
-				if (!outbuf.len)
-					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
-				if (linelen > 0) {
-					maybe_colorize_sideband(&outbuf, b, linelen);
-					strbuf_addstr(&outbuf, suffix);
-				}
-
-				strbuf_addch(&outbuf, *brk);
-				xwrite(2, outbuf.buf, outbuf.len);
-				strbuf_reset(&outbuf);
-
-				b = brk + 1;
+		/*
+		 * Append a suffix to each nonempty line to clear the
+		 * end of the screen line.
+		 *
+		 * The output is accumulated in a buffer and
+		 * each line is printed to stderr using
+		 * write(2) to ensure inter-process atomicity.
+		 */
+		while ((brk = strpbrk(b, "\n\r"))) {
+			int linelen = brk - b;
+
+			if (!outbuf.len)
+				strbuf_addstr(&outbuf, DISPLAY_PREFIX);
+			if (linelen > 0) {
+				maybe_colorize_sideband(&outbuf, b, linelen);
+				strbuf_addstr(&outbuf, suffix);
 			}
 
-			if (*b) {
-				strbuf_addstr(&outbuf, outbuf.len ?
-					    "" : DISPLAY_PREFIX);
-				maybe_colorize_sideband(&outbuf, b, strlen(b));
-			}
-			break;
-		case 1:
-			write_or_die(out, buf + 1, len);
-			break;
-		default:
-			strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
-				    outbuf.len ? "\n" : "", me, band);
-			retval = SIDEBAND_PROTOCOL_ERROR;
-			break;
+			strbuf_addch(&outbuf, *brk);
+			xwrite(2, outbuf.buf, outbuf.len);
+			strbuf_reset(&outbuf);
+
+			b = brk + 1;
+		}
+
+		if (*b) {
+			strbuf_addstr(&outbuf, outbuf.len ?
+				    "" : DISPLAY_PREFIX);
+			maybe_colorize_sideband(&outbuf, b, strlen(b));
 		}
+		retval = SIDEBAND_PROGRESS;
+		break;
+	case 1:
+		retval = SIDEBAND_PRIMARY;
+		break;
+	default:
+		strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
+			    outbuf.len ? "\n" : "", me, band);
+		retval = SIDEBAND_PROTOCOL_ERROR;
+		break;
 	}
 
+cleanup:
 	if (outbuf.len) {
 		strbuf_addch(&outbuf, '\n');
 		xwrite(2, outbuf.buf, outbuf.len);
diff --git a/sideband.h b/sideband.h
index 7a8146f161..7244971231 100644
--- a/sideband.h
+++ b/sideband.h
@@ -3,8 +3,20 @@
 
 #define SIDEBAND_PROTOCOL_ERROR -2
 #define SIDEBAND_REMOTE_ERROR -1
+#define SIDEBAND_FLUSH 0
+#define SIDEBAND_PRIMARY 1
+#define SIDEBAND_PROGRESS 2
+
+/*
+ * Inspects a multiplexed packet read from the remote and returns which
+ * sideband it is for.
+ *
+ * If SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS,
+ * also prints a message (or the formatted contents of the notice in the case
+ * of SIDEBAND_PROGRESS) to stderr.
+ */
+int demultiplex_sideband(const char *me, char *buf, int len);
 
-int recv_sideband(const char *me, int in_stream, int out);
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
-- 
2.19.0.271.gfe8321ec05.dirty


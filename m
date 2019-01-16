Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62021F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfAPT21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:28:27 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36022 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbfAPT21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:28:27 -0500
Received: by mail-vs1-f73.google.com with SMTP id r133so3177270vsc.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=emSsA6+gXaQI4sDm6nTtOEvDON6WrazAVIAG/1x/3uM=;
        b=vEitrxD9eWwmJlkwv+AnKwZp+cXQsOMCtDaMe0lvwNEGgF3Wn2qWVox31GPSos0Jw9
         5+Qz1u1TrSgj6Pcr35cH7fBpQX/b+pPH7387jTRU/K/2OHt45kNSzJoeJXztMQJCx9TX
         nz+cmijdA7eMfqqtjDK3VdkYXSOZCro28Z7H6G75rUhBf2LRs8t8PmOi9vgbCrQwExMW
         DG3h7hUbqAcXkOra+T6Chq9tjRJ1cgSFBC9LCn8oMcdw5TvWLQFG9pvKr8KBvVM6RPjl
         kJ+iq4ll37GsMs8c0bsto3rYyftBstJWsGBmeXvSFoAgtExV45nRikyBY0ne6Jj1BksE
         kgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=emSsA6+gXaQI4sDm6nTtOEvDON6WrazAVIAG/1x/3uM=;
        b=NJYvkPNO5xPlwRmi8XDKHrzHvIK8dFQZMfOxhIg6vaxnYAc7r0VVF6Sf3cR19swqlO
         SMEVwyPdXsSBpx8yzFUUzB3XMA8bncGFPkDc8yFdKIlGJwR065YIv6GTE6m4CGxTwPIz
         FINF0lWHtTKh64e6Wj+Lx5SnCcYgc070Orba2HBv2uVsUlZoERVmrE/qWUlgBgh3L+OG
         xMtS3XxWyFSvUxevCArCWhM1eO9FPCbGbfrC8XAfpD6zKIIJOJfGfDh5Vj7ctEBPSxr4
         peiOuS8JpBIqEBgU8TM6IgFiLgmJf2fd1bzUT1m8i8v250uLyK/BLM1bL4zt4Fd6tBuc
         zWLA==
X-Gm-Message-State: AJcUukfS4AomEiZbl3NUTxp1F41rpbFKpc6ThwvXbDT9Qx5nolhB8oec
        CE3Wa0blIxKoulF6zTF7H2fTLoSL2sKSSDQQcM16aFyVAA1WcGpHHunECArL7w3CxXU5YrrLdeh
        ZnfMctMLPrOQyfgbgbXHGRLaFS8RyxKIC+1OYHvZkj168NhL+sS/snxADd3Xh4rdpiAtFzU4lEC
        WE
X-Google-Smtp-Source: ALg8bN7yJ7LpPag/Iwt91uxz5WtFqLevnVAfuAWTjjqaTfAbkPC+0llJzheOeKfUJd4PY9VE+o5/l3KUtP7AhJ+WsrRf
X-Received: by 2002:ab0:c0d:: with SMTP id a13mr6491255uak.19.1547666904931;
 Wed, 16 Jan 2019 11:28:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:28:13 -0800
In-Reply-To: <cover.1547666330.git.jonathantanmy@google.com>
Message-Id: <1a8f645c19fffd2ecd53c5c15be48a1e436729ba.1547666330.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547666330.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v3 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        szeder.dev@gmail.com
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c |  23 +++++++
 pkt-line.h |  16 +++++
 sideband.c | 173 +++++++++++++++++++++++++----------------------------
 sideband.h |  24 +++++++-
 4 files changed, 141 insertions(+), 95 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 9d3e402d41..321ff632a5 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -439,6 +439,29 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 	return sb_out->len - orig_len;
 }
 
+int recv_sideband(const char *me, int in_stream, int out)
+{
+	char buf[LARGE_PACKET_MAX + 1];
+	int len;
+	struct strbuf scratch = STRBUF_INIT;
+	enum sideband_type sideband_type;
+
+	while (1) {
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
+				  0);
+		if (!demultiplex_sideband(me, buf, len, &scratch,
+					  &sideband_type))
+			continue;
+		switch (sideband_type) {
+		case SIDEBAND_PRIMARY:
+			write_or_die(out, buf + 1, len - 1);
+			break;
+		default: /* errors: message already written */
+			return sideband_type;
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
index 368647acf8..e89d677626 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
-#include "pkt-line.h"
 #include "sideband.h"
 #include "help.h"
 
@@ -109,109 +108,99 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
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
+int demultiplex_sideband(const char *me, char *buf, int len,
+			 struct strbuf *scratch,
+			 enum sideband_type *sideband_type)
 {
-	const char *suffix;
-	char buf[LARGE_PACKET_MAX + 1];
-	struct strbuf outbuf = STRBUF_INIT;
-	int retval = 0;
-
-	if (isatty(2) && !is_terminal_dumb())
-		suffix = ANSI_SUFFIX;
-	else
-		suffix = DUMB_SUFFIX;
-
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
-			}
+	static const char *suffix;
+	const char *b, *brk;
+	int band;
+
+	if (!suffix) {
+		if (isatty(2) && !is_terminal_dumb())
+			suffix = ANSI_SUFFIX;
+		else
+			suffix = DUMB_SUFFIX;
+	}
 
-			if (*b) {
-				strbuf_addstr(&outbuf, outbuf.len ?
-					    "" : DISPLAY_PREFIX);
-				maybe_colorize_sideband(&outbuf, b, strlen(b));
+	if (len == 0) {
+		*sideband_type = SIDEBAND_FLUSH;
+		goto cleanup;
+	}
+	if (len < 1) {
+		strbuf_addf(scratch,
+			    "%s%s: protocol error: no band designator",
+			    scratch->len ? "\n" : "", me);
+		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
+		goto cleanup;
+	}
+	band = buf[0] & 0xff;
+	buf[len] = '\0';
+	len--;
+	switch (band) {
+	case 3:
+		strbuf_addf(scratch, "%s%s", scratch->len ? "\n" : "",
+			    DISPLAY_PREFIX);
+		maybe_colorize_sideband(scratch, buf + 1, len);
+
+		*sideband_type = SIDEBAND_REMOTE_ERROR;
+		break;
+	case 2:
+		b = buf + 1;
+
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
+			if (!scratch->len)
+				strbuf_addstr(scratch, DISPLAY_PREFIX);
+			if (linelen > 0) {
+				maybe_colorize_sideband(scratch, b, linelen);
+				strbuf_addstr(scratch, suffix);
 			}
-			break;
-		case 1:
-			write_or_die(out, buf + 1, len);
-			break;
-		default:
-			strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
-				    outbuf.len ? "\n" : "", me, band);
-			retval = SIDEBAND_PROTOCOL_ERROR;
-			break;
+
+			strbuf_addch(scratch, *brk);
+			xwrite(2, scratch->buf, scratch->len);
+			strbuf_reset(scratch);
+
+			b = brk + 1;
+		}
+
+		if (*b) {
+			strbuf_addstr(scratch, scratch->len ?
+				    "" : DISPLAY_PREFIX);
+			maybe_colorize_sideband(scratch, b, strlen(b));
 		}
+		return 0;
+	case 1:
+		*sideband_type = SIDEBAND_PRIMARY;
+		break;
+	default:
+		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
+			    scratch->len ? "\n" : "", me, band);
+		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
+		break;
 	}
 
-	if (outbuf.len) {
-		strbuf_addch(&outbuf, '\n');
-		xwrite(2, outbuf.buf, outbuf.len);
+cleanup:
+	if (scratch->len) {
+		strbuf_addch(scratch, '\n');
+		xwrite(2, scratch->buf, scratch->len);
 	}
-	strbuf_release(&outbuf);
-	return retval;
+	strbuf_release(scratch);
+	return 1;
 }
 
 /*
diff --git a/sideband.h b/sideband.h
index 7a8146f161..2c4f021645 100644
--- a/sideband.h
+++ b/sideband.h
@@ -1,10 +1,28 @@
 #ifndef SIDEBAND_H
 #define SIDEBAND_H
 
-#define SIDEBAND_PROTOCOL_ERROR -2
-#define SIDEBAND_REMOTE_ERROR -1
+enum sideband_type {
+	SIDEBAND_PROTOCOL_ERROR = -2,
+	SIDEBAND_REMOTE_ERROR = -1,
+	SIDEBAND_FLUSH = 0,
+	SIDEBAND_PRIMARY = 1
+};
+
+/*
+ * Inspects a multiplexed packet read from the remote. If this packet is a
+ * progress packet and thus should not be processed by the caller, returns 0.
+ * Otherwise, returns 1, releases scratch, and sets sideband_type.
+ *
+ * If this packet is SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or a
+ * progress packet, also prints a message to stderr.
+ *
+ * scratch must be a struct strbuf allocated by the caller. It is used to store
+ * progress messages split across multiple packets.
+ */
+int demultiplex_sideband(const char *me, char *buf, int len,
+			 struct strbuf *scratch,
+			 enum sideband_type *sideband_type);
 
-int recv_sideband(const char *me, int in_stream, int out);
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
-- 
2.19.0.271.gfe8321ec05.dirty


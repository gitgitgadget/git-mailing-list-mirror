Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027C21F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbfAOTkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:40:36 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54411 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:40:36 -0500
Received: by mail-qk1-f202.google.com with SMTP id y27so3177851qkj.21
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yuO1zN7Y4xaBgBDFg92CZxHp2fWecrExCt3MD2YxnMM=;
        b=EEdcpEU4kQ5/R1hg2LA7GoOB6JXNJTGYf+uFz82Py5+KoHhOmtHdfxR9GY7gAio1r7
         gh37d95huE3eV7l2Eh2KQUwM/pqSIBQCOzh5pbK09KPu1XaXtEKOSxF9cppccEvJuxpe
         HeBt7pG5PZ23SUWp59+8BBHquF2i8SVFw6PzHYsbMq6Fc4eqn0ho5NippIO6/x7AARej
         stIwSLBkRF3G1kSMxPGQukayKulC5nH5UzGAw2AwKhyiKBdt8Ox3NA5B6U7gCEaQq8Le
         MnXq9PURHIKEuTwqo3W39yw3VMlaHHaFsqIOAIRsI7PvwHKnevJt+Rz7NQbneKj1PM+A
         ZrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yuO1zN7Y4xaBgBDFg92CZxHp2fWecrExCt3MD2YxnMM=;
        b=bNYpnU+rJFB19vtFB4xiZ1MY0SeCVuutnYdG/tzDg5x8uKFork6J94i4VHhtelBJ8J
         gswpLNu8PKYAScMLkPCfvouqvRm/uZsboGQbNjDzVn5Ov0VELnekSbHDcwpvprwXCMno
         rPeS7TLTH7VWAGc46pJqWd4VkHyhvSpsRN7a6fJ7X64iy0VKOPQw+DCEXTpKNxd+V8L6
         zZ/Zs/rxpMbR/W/+fhmJb2EAAvw5Jgk86rU42qEgF0OcC9SMy4L/Bt3DJ4Zn+QzLtJZZ
         YAzi/wJazGgOlKeRUak+vhXVysMqPmxPhgCaCLRly/YZ5CUU9BYywPe8EYk6pxG314YK
         D7Mg==
X-Gm-Message-State: AJcUukerwhIxwEvfQbaJwIhUrsP/VE/vu7sQUVaV5X7pUjQyAUIED0z2
        oAEU7oGHvweX8DEJt2dU/+Hwg270PJeuv4GIcqBx7dSJSQvJ0yrqTIXFn0pUGXnrlcf0pMFyWNz
        mGgkm/4HrvUoIjAY4u1ZrvKjL6D6kEJvcz7K4p9SDUX6NXHOs2Ce5jbq1fjrhm59ZciP8+rVWqa
        8E
X-Google-Smtp-Source: ALg8bN7zhBf2CQqfH8o+64rUxaBHqQm7rUpBBftEaEn7c6ocaqbpMmhyANADczmcP2u8YPeGGrydXLAc9s9iyKj0xogL
X-Received: by 2002:a37:717:: with SMTP id 23mr2909050qkh.1.1547581234927;
 Tue, 15 Jan 2019 11:40:34 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:40:26 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <cover.1547581039.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like v1, this is on origin/ms/packet-err-check.

Thanks, Junio, for your reviews.

Jonathan Tan (4):
  pkt-line: introduce struct packet_writer
  sideband: reverse its dependency on pkt-line
  {fetch,upload}-pack: sideband v2 fetch response
  tests: define GIT_TEST_SIDEBAND_ALL

 Documentation/technical/protocol-v2.txt |  10 ++
 fetch-pack.c                            |  13 +-
 pkt-line.c                              | 121 +++++++++++++++---
 pkt-line.h                              |  34 +++++
 sideband.c                              | 161 ++++++++++++------------
 sideband.h                              |  14 ++-
 t/README                                |   5 +
 t/lib-httpd/apache.conf                 |   1 +
 t/t5537-fetch-shallow.sh                |   3 +-
 t/t5701-git-serve.sh                    |   2 +-
 t/t5702-protocol-v2.sh                  |   4 +-
 upload-pack.c                           | 131 +++++++++++--------
 12 files changed, 343 insertions(+), 156 deletions(-)

Interdiff against v1:
diff --git a/pkt-line.c b/pkt-line.c
index 71b17e6b93..69162f3990 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -447,16 +447,16 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		retval = diagnose_sideband(me, buf, len, 0);
+		retval = demultiplex_sideband(me, buf, len, 0);
 		switch (retval) {
-			case SIDEBAND_PRIMARY:
-				write_or_die(out, buf + 1, len - 1);
-				break;
-			case SIDEBAND_PROGRESS:
-				/* already written by diagnose_sideband() */
-				break;
-			default: /* flush or error */
-				return retval;
+		case SIDEBAND_PRIMARY:
+			write_or_die(out, buf + 1, len - 1);
+			break;
+		case SIDEBAND_PROGRESS:
+			/* already written by demultiplex_sideband() */
+			break;
+		default: /* errors: message already written */
+			return retval;
 		}
 	}
 }
@@ -474,6 +474,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer = packet_buffer;
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
+	reader->me = "git";
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
@@ -483,6 +484,10 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 		return reader->status;
 	}
 
+	/*
+	 * Consume all progress and keepalive packets until a primary payload
+	 * packet is received
+	 */
 	while (1) {
 		int retval;
 		reader->status = packet_read_with_status(reader->fd,
@@ -494,29 +499,31 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 							 reader->options);
 		if (!reader->use_sideband)
 			break;
-		retval = diagnose_sideband(reader->me, reader->buffer,
-					   reader->pktlen, 1);
+		retval = demultiplex_sideband(reader->me, reader->buffer,
+					      reader->pktlen, 1);
 		switch (retval) {
-			case SIDEBAND_PROTOCOL_ERROR:
-			case SIDEBAND_REMOTE_ERROR:
-				BUG("should have died in diagnose_sideband");
-			case SIDEBAND_FLUSH:
-				goto nonprogress;
-			case SIDEBAND_PRIMARY:
-				if (reader->pktlen != 1)
-					goto nonprogress;
-				/*
-				 * Since pktlen is 1, this is a keepalive
-				 * packet. Wait for the next one.
-				 */
-				break;
-			default: /* SIDEBAND_PROGRESS */
-				;
+		case SIDEBAND_PROTOCOL_ERROR:
+		case SIDEBAND_REMOTE_ERROR:
+			BUG("should have died in diagnose_sideband");
+		case SIDEBAND_FLUSH:
+			goto nonprogress_received;
+		case SIDEBAND_PRIMARY:
+			if (reader->pktlen != 1)
+				goto nonprogress_received;
+			/*
+			 * Since the packet contains nothing but the sideband
+			 * designator, this is a keepalive packet. Wait for the
+			 * next one.
+			 */
+			break;
+		default: /* SIDEBAND_PROGRESS */
+			;
 		}
 	}
 
-nonprogress:
+nonprogress_received:
 	if (reader->status == PACKET_READ_NORMAL)
+		/* Skip the sideband designator if sideband is used */
 		reader->line = reader->use_sideband ?
 			reader->buffer + 1 : reader->buffer;
 	else
@@ -549,7 +556,7 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
 
 	va_start(args, fmt);
 	packet_write_fmt_1(writer->dest_fd, 0,
-			   writer->use_sideband ? "\1" : "", fmt, args);
+			   writer->use_sideband ? "\001" : "", fmt, args);
 	va_end(args);
 }
 
@@ -559,7 +566,7 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
 
 	va_start(args, fmt);
 	packet_write_fmt_1(writer->dest_fd, 0,
-			   writer->use_sideband ? "\3" : "ERR ", fmt, args);
+			   writer->use_sideband ? "\003" : "ERR ", fmt, args);
 	va_end(args);
 }
 
diff --git a/sideband.c b/sideband.c
index cbeab380ae..9d3051e3fe 100644
--- a/sideband.c
+++ b/sideband.c
@@ -113,7 +113,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int diagnose_sideband(const char *me, char *buf, int len, int die_on_error)
+int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
 {
 	static const char *suffix;
 	struct strbuf outbuf = STRBUF_INIT;
diff --git a/sideband.h b/sideband.h
index 3786670694..f75c4fde2a 100644
--- a/sideband.h
+++ b/sideband.h
@@ -8,15 +8,14 @@
 #define SIDEBAND_PROGRESS 2
 
 /*
- * buf and len should be the result of reading a line from a remote sending
- * multiplexed data.
+ * Inspects a multiplexed packet read from the remote and returns which
+ * sideband it is for.
  *
- * Determines the nature of the result and returns it. If
- * SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS, also
- * prints a message (or the formatted contents of the notice in the case of
- * SIDEBAND_PROGRESS) to stderr.
+ * If SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS,
+ * also prints a message (or the formatted contents of the notice in the case
+ * of SIDEBAND_PROGRESS) to stderr.
  */
-int diagnose_sideband(const char *me, char *buf, int len, int die_on_error);
+int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error);
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
-- 
2.19.0.271.gfe8321ec05.dirty


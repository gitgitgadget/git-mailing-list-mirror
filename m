Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937D81F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBUUYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:24:46 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:52391 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUUYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:24:46 -0500
Received: by mail-yw1-f74.google.com with SMTP id t9so15962225ywe.19
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+uCZZ9OEWlPlPARYwLGwOQ9DdPn25kQgh7roaZ9/v24=;
        b=nVk85uTp1K/9HFLrd2XOJL7erUHycZO1uPS9ixyKEjzEvxBHMQlqfOSAbrUoAFLQnp
         29Lk+J87fD/ekIzsteZL/bJM5gxuy6UXfCOsO77Ut5lj48oCKXFpY/r+usr5DLWASms8
         60KiYREispbMCbWMQjVaO4A6gfKDg+0AhcLsk6XUmHFjDUhYlMKLf782W/bLmobZvoB2
         JgSbupcJkFfanuxeb+4WWHVSTTYsi+GVmLtvxNIn6eXT76AAHcOzkXGc17EDnDGwEnZc
         AbHzRxbtlUjJ4P2MIlQ3kULBcAr5xP/XJKn2ntGEhXCdJUFjCvdjVf4Ht4MA5wRHXyMH
         oegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+uCZZ9OEWlPlPARYwLGwOQ9DdPn25kQgh7roaZ9/v24=;
        b=kyI4Fa/c3ejc3zCwoLZi4/ZzAvwVjr8jt8A4UQrxP+S8A7GzXBnNd7+PoljAhbC+5d
         v/x7iC+05rSbiW8RJkyqVIVMDIcIT5W7w4DXuF4Zhj/TEG+rqWktECu9yMJbhh5UVwkg
         dvTex5JTLBIVV+hSsuyYBa79SjbDCnccXr5O7u4QfU1Di/yAAbzWInQSmj9Ku9lFM9iX
         p+eiXuwlSqZigTgbKnZXx5BCMLKvtWdGNbJyJrUg/Z/EeEeTwlhwKbM3YKh/rlRkVceV
         1/a98/GaH8ha+w/SQGk3kyCLUhR2fHqybW0qk3IJRiKfCDTgOUCZU+q+hY9pYzUuxj1l
         wDEA==
X-Gm-Message-State: AHQUAua7Gw1tpAL2g5PlaqIxqPiSiED5O/FmRtL9HcC2+M21+bsbB7/z
        ots6UNzvGAQ26lmyNa65fOArAZN5wsbEb9psJoUGY1onthNiqACF38pqiWUOXdjO9pJyODZRi2M
        rNQGX5s0LR5pZfhCB5V1eXSHw0bf5gK9X62q+EMUyz7SPpb3q5sEOB3PD7JK9QuPZLHyfdGwZpd
        jw
X-Google-Smtp-Source: AHgI3IYGYWoB4XfH/8ntp0YD7QovnTe3nVqjXaatXVUylLcugGjeGLxZ4InF0LwndftfU00XDtaWwJPdFchFCz8c83G8
X-Received: by 2002:a25:2705:: with SMTP id n5mr173597ybn.57.1550780684915;
 Thu, 21 Feb 2019 12:24:44 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:24:36 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <cover.1550780213.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 0/5] Protocol v2 fix: http and auth
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio and Peff for their reviews.

The main changes are the name and comments around the stop_reading part.
I have renamed it to flush_read_but_not_sent and have added a lot of
comments - I tried to err on the side of overcommenting here, since it
is rather complicated.

Other changes:
 - used test_seq instead of seq
 - used fast_import instead of test_commit 1500 times
 - in patch 4, the BUG statement now reads "...larger than
   LARGE_PACKET_DATA_MAX; the corresponding BUG in patch 5 is
   LARGE_PACKET_MAX (this means that the total diff does not change, and
   is thus not visible in the interdiff below)

I discovered a slight issue in which the full http.postBuffer is not
used, because Git immediately switches to chunked mode if the buffer
cannot contain a maximally sized pkt-line (without first reading the
pkt-line to see if it fits). This means that I could replace "test-seq 1
1500" with "test-seq 1 2" and the test would still pass, but I'm still
using 1500 in this patch set so that the test will pass if we ever
decide to use the http.postBuffer slightly more efficiently.

Jonathan Tan (5):
  remote-curl: reduce scope of rpc_state.argv
  remote-curl: reduce scope of rpc_state.stdin_preamble
  remote-curl: reduce scope of rpc_state.result
  remote-curl: refactor reading into rpc_state's buf
  remote-curl: use post_rpc() for protocol v2 also

 pkt-line.c             |   2 +-
 pkt-line.h             |   1 +
 remote-curl.c          | 362 +++++++++++++++++++----------------------
 t/t5702-protocol-v2.sh |  33 +++-
 4 files changed, 199 insertions(+), 199 deletions(-)

Interdiff against v1:
diff --git a/remote-curl.c b/remote-curl.c
index 2394a00650..8c03c78fc6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -526,10 +526,13 @@ struct rpc_state {
 	unsigned write_line_lengths : 1;
 
 	/*
-	 * rpc_out uses this to keep track of whether it should continue
-	 * reading to populate the current request. Initialize to 0.
+	 * Used by rpc_out; initialize to 0. This is true if a flush has been
+	 * read, but the corresponding line length (if write_line_lengths is
+	 * true) and EOF have not been sent to libcurl. Since each flush marks
+	 * the end of a request, each flush must be completely sent before any
+	 * further reading occurs.
 	 */
-	unsigned stop_reading : 1;
+	unsigned flush_read_but_not_sent : 1;
 };
 
 /*
@@ -600,26 +603,34 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 		rpc->initial_buffer = 0;
 		rpc->len = 0;
 		rpc->pos = 0;
-		if (!rpc->stop_reading) {
+		if (!rpc->flush_read_but_not_sent) {
 			if (!rpc_read_from_out(rpc, 0, &avail, &status))
 				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
 			if (status == PACKET_READ_FLUSH)
-				/*
-				 * We are done reading for this request, but we
-				 * still need to send this line out (if
-				 * rpc->write_line_lengths is true) so do not
-				 * return yet.
-				 */
-				rpc->stop_reading = 1;
+				rpc->flush_read_but_not_sent = 1;
 		}
+		/*
+		 * If flush_read_but_not_sent is true, we have already read one
+		 * full request but have not fully sent it + EOF, which is why
+		 * we need to refrain from reading.
+		 */
 	}
-	if (!avail && rpc->stop_reading) {
+	if (rpc->flush_read_but_not_sent) {
+		if (!avail) {
+			/*
+			 * The line length either does not need to be sent at
+			 * all or has already been completely sent. Now we can
+			 * return 0, indicating EOF, meaning that the flush has
+			 * been fully sent.
+			 */
+			rpc->flush_read_but_not_sent = 0;
+			return 0;
+		}
 		/*
-		 * "return 0" will notify Curl that this RPC request is done,
-		 * so reset stop_reading back to 0 for the next request.
+		 * If avail is non-zerp, the line length for the flush still
+		 * hasn't been fully sent. Proceed with sending the line
+		 * length.
 		 */
-		rpc->stop_reading = 0;
-		return 0;
 	}
 
 	if (max < avail)
@@ -1290,7 +1301,7 @@ static int stateless_connect(const char *service_name)
 	rpc.gzip_request = 1;
 	rpc.initial_buffer = 0;
 	rpc.write_line_lengths = 1;
-	rpc.stop_reading = 0;
+	rpc.flush_read_but_not_sent = 0;
 
 	/*
 	 * Dump the capability listing that we got from the server earlier
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 61acf99d80..e112b6086c 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -552,10 +552,17 @@ test_expect_success 'clone big repository with http:// using protocol v2' '
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/big" &&
 	# Ensure that the list of wants is greater than http.postbuffer below
-	for i in $(seq 1 1500)
+	for i in $(test_seq 1 1500)
 	do
-		test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/big" "commit$i"
-	done &&
+		# do not use here-doc, because it requires a process
+		# per loop iteration
+		echo "commit refs/heads/too-many-refs-$i" &&
+		echo "committer git <git@example.com> $i +0000" &&
+		echo "data 0" &&
+		echo "M 644 inline bla.txt" &&
+		echo "data 4" &&
+		echo "bla"
+	done | git -C "$HTTPD_DOCUMENT_ROOT_PATH/big" fast-import &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git \
 		-c protocol.version=2 -c http.postbuffer=65536 \
-- 
2.19.0.271.gfe8321ec05.dirty


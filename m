Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7487F1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeAXLO2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:28 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49012 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933205AbeAXLOZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:25 -0500
X-AuditID: 1207440f-ab7ff70000000ab0-17-5a686a8fe3cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EE.D9.02736.09A686A5; Wed, 24 Jan 2018 06:14:24 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi5004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:21 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] struct snapshot: store `start` rather than `header_len`
Date:   Wed, 24 Jan 2018 12:14:11 +0100
Message-Id: <2adb70b238a5f7f65f19344007e1743cc96644b8.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqDshKyPK4P40PYuuK91MFg29V5gt
        +pd3sVkc7JzJanF7xXxmix8tPcwObB5/339g8vjwMc6j78gaRo9nvXsYPS5eUvb4vEkugC2K
        yyYlNSezLLVI3y6BK+PU7LPMBSf1K15fmc3UwLhUtYuRk0NCwETi2bWHzF2MXBxCAjuYJB78
        2McG4Vxikph65TgrSBWbgK7Eop5mJhBbREBNYmLbIRaQImaB04wSu/YvYwFJCAv4SPyftJ4R
        xGYRUJVoOXaIDcTmFYiSuPi3kQVinbzE+wX3wWo4BRwkundcAqsRErCX6L52COgMDqC4hcTl
        RVogppCAucSdfzwTGPkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJ
        Pf4djF3rZQ4xCnAwKvHw3rBIjxJiTSwrrsw9xCjJwaQkypsflBElxJeUn1KZkVicEV9UmpNa
        fIhRgoNZSYQ3jxWonDclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJqvBwSFwd0nv
        BkYplrz8vFQlCd6zmUALBItS01Mr0jJzShBKmTg4QRbxAC26A1LDW1yQmFucmQ6RP8Woy3Hj
        xes2ZiGwQVLivBUgRQIgRRmleXBzYKnkFaM40IvCvItBqniAaQhu0iugJUxAS27UpIIsKUlE
        SEk1MHK6CS9hmzi/a9+eBMGEsFn78qwPZ9lpptkbzoq1dNu4+kjvHdO7ki/PL9tVz+HAc9e4
        8dqdQx28/9P3u7uIvRdQOb4yX+VnUWZ0ynYl5UjWnR/74loMTVWb793qzdK5mn4vo9Npx7Z3
        Rm/WdsZ+X/lrpUzohDdM5h3NzLnls0V9Uw0Py3/RUmIpzkg01GIuKk4EACqbBpgAAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store a pointer to the start of the actual references within the
`packed-refs` contents rather than storing the length of the header.
This is more convenient for most users of this field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 64 ++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 023243fd5f..b872267f02 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -68,17 +68,21 @@ struct snapshot {
 	int mmapped;
 
 	/*
-	 * The contents of the `packed-refs` file. If the file was
-	 * already sorted, this points at the mmapped contents of the
-	 * file. If not, this points at heap-allocated memory
-	 * containing the contents, sorted. If there were no contents
-	 * (e.g., because the file didn't exist), `buf` and `eof` are
-	 * both NULL.
+	 * The contents of the `packed-refs` file:
+	 *
+	 * - buf -- a pointer to the start of the memory
+	 * - start -- a pointer to the first byte of actual references
+         *   (i.e., after the header line, if one is present)
+	 * - eof -- a pointer just past the end of the reference
+         *   contents
+	 *
+	 * If the `packed-refs` file was already sorted, `buf` points
+	 * at the mmapped contents of the file. If not, it points at
+	 * heap-allocated memory containing the contents, sorted. If
+	 * there were no contents (e.g., because the file didn't
+	 * exist), `buf`, `start`, and `eof` are all NULL.
 	 */
-	char *buf, *eof;
-
-	/* The size of the header line, if any; otherwise, 0: */
-	size_t header_len;
+	char *buf, *start, *eof;
 
 	/*
 	 * What is the peeled state of the `packed-refs` file that
@@ -169,8 +173,7 @@ static void clear_snapshot_buffer(struct snapshot *snapshot)
 	} else {
 		free(snapshot->buf);
 	}
-	snapshot->buf = snapshot->eof = NULL;
-	snapshot->header_len = 0;
+	snapshot->buf = snapshot->start = snapshot->eof = NULL;
 }
 
 /*
@@ -319,13 +322,14 @@ static void sort_snapshot(struct snapshot *snapshot)
 	size_t len, i;
 	char *new_buffer, *dst;
 
-	pos = snapshot->buf + snapshot->header_len;
+	pos = snapshot->start;
 	eof = snapshot->eof;
-	len = eof - pos;
 
-	if (!len)
+	if (pos == eof)
 		return;
 
+	len = eof - pos;
+
 	/*
 	 * Initialize records based on a crude estimate of the number
 	 * of references in the file (we'll grow it below if needed):
@@ -391,9 +395,8 @@ static void sort_snapshot(struct snapshot *snapshot)
 	 * place:
 	 */
 	clear_snapshot_buffer(snapshot);
-	snapshot->buf = new_buffer;
+	snapshot->buf = snapshot->start = new_buffer;
 	snapshot->eof = new_buffer + len;
-	snapshot->header_len = 0;
 
 cleanup:
 	free(records);
@@ -442,14 +445,14 @@ static const char *find_end_of_record(const char *p, const char *end)
  */
 static void verify_buffer_safe(struct snapshot *snapshot)
 {
-	const char *buf = snapshot->buf + snapshot->header_len;
+	const char *start = snapshot->start;
 	const char *eof = snapshot->eof;
 	const char *last_line;
 
-	if (buf == eof)
+	if (start == eof)
 		return;
 
-	last_line = find_start_of_record(buf, eof - 1);
+	last_line = find_start_of_record(start, eof - 1);
 	if (*(eof - 1) != '\n' || eof - last_line < GIT_SHA1_HEXSZ + 2)
 		die_invalid_line(snapshot->refs->path,
 				 last_line, eof - last_line);
@@ -495,18 +498,19 @@ static int load_contents(struct snapshot *snapshot)
 		bytes_read = read_in_full(fd, snapshot->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
 			die_errno("couldn't read %s", snapshot->refs->path);
-		snapshot->eof = snapshot->buf + size;
 		snapshot->mmapped = 0;
 		break;
 	case MMAP_TEMPORARY:
 	case MMAP_OK:
 		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		snapshot->eof = snapshot->buf + size;
 		snapshot->mmapped = 1;
 		break;
 	}
 	close(fd);
 
+	snapshot->start = snapshot->buf;
+	snapshot->eof = snapshot->buf + size;
+
 	return 1;
 }
 
@@ -539,7 +543,7 @@ static const char *find_reference_location(struct snapshot *snapshot,
 	 * preceding records all have reference names that come
 	 * *before* `refname`.
 	 */
-	const char *lo = snapshot->buf + snapshot->header_len;
+	const char *lo = snapshot->start;
 
 	/*
 	 * A pointer to a the first character of a record whose
@@ -617,8 +621,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 	/* If the file has a header line, process it: */
 	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
 		struct strbuf tmp = STRBUF_INIT;
-		char *p;
-		const char *eol;
+		char *p, *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(snapshot->buf, '\n',
@@ -647,7 +650,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
-		snapshot->header_len = eol + 1 - snapshot->buf;
+		snapshot->start = eol + 1;
 
 		string_list_clear(&traits, 0);
 		strbuf_release(&tmp);
@@ -671,13 +674,12 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 		 * We don't want to leave the file mmapped, so we are
 		 * forced to make a copy now:
 		 */
-		size_t size = snapshot->eof -
-			(snapshot->buf + snapshot->header_len);
+		size_t size = snapshot->eof - snapshot->start;
 		char *buf_copy = xmalloc(size);
 
-		memcpy(buf_copy, snapshot->buf + snapshot->header_len, size);
+		memcpy(buf_copy, snapshot->start, size);
 		clear_snapshot_buffer(snapshot);
-		snapshot->buf = buf_copy;
+		snapshot->buf = snapshot->start = buf_copy;
 		snapshot->eof = buf_copy + size;
 	}
 
@@ -937,7 +939,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	if (prefix && *prefix)
 		start = find_reference_location(snapshot, prefix, 0);
 	else
-		start = snapshot->buf + snapshot->header_len;
+		start = snapshot->start;
 
 	iter->pos = start;
 	iter->eof = snapshot->eof;
-- 
2.14.2


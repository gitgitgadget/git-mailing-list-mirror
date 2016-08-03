Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC411F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbcHCWIk (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:08:40 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49703 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755000AbcHCWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:08:37 -0400
X-AuditID: 12074413-aa3ff70000000955-cf-57a2698e2e43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 56.B0.02389.E8962A75; Wed,  3 Aug 2016 18:00:46 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSY023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:44 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/8] xdl_change_compact(): rename some local variables for clarity
Date:	Thu,  4 Aug 2016 00:00:29 +0200
Message-Id: <ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqNuXuSjc4O0MfYuuK91MFg29V5gt
	di/uZ7ZYcXUOs8XtFfOZLX609DBbbN7czuLA7vH3/Qcmj52z7rJ7LNhU6vGsdw+jx8VLyh6f
	N8kFsEVx2aSk5mSWpRbp2yVwZfQ09jMXnNeoaJ3yhbGBcYtsFyMnh4SAicSEa5+Zuxi5OIQE
	tjJK/N9zggXCOc4kcfLlKjaQKjYBXYlFPc1MILaIgLjE2+Mz2UGKmAX6mSR+dHQxdjFycAgL
	BElsucoDUsMioCqxdMIsdhCbVyBKomX6OhaIbXISl6c/AJvJKWAhcXXSbLCZQgLmEm87drFO
	YORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkrIR3MO46KXeIUYCD
	UYmHd4PkonAh1sSy4srcQ4ySHExKorw5qUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrz3UoBy
	vCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3osZQI2CRanpqRVpmTkl
	CGkmDk6Q4TxAw1+A1PAWFyTmFmemQ+RPMSpKifNapAMlBEASGaV5cL2wuH/FKA70ijCvHUg7
	DzBlwHW/AhrMBDT4hMECkMEliQgpqQZGrqcmJsX+Grttpyj1yPxJ/lXwZu3ZQt21pj8m/ojf
	cvRB93WeNX9fdPlo25dkX/Mvf/v4fE4fX3fOAV6Rjj9P5cuvv9r7L26e/5LwQwLVSY2FLTIW
	77057v09tXKZ3xujJUHx2ydO12Q9f+ur5Y0v/qVFZ+d3FP1bsHmW88nnsSmv08yZ//3hVmIp
	zkg01GIuKk4EADzgW6jWAgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

* ix -> i
* ixo -> io
* ixs -> start
* grpsiz -> groupsize

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Thankfully, we don't have to limit indentifers to six characters, so
start naming things more understandably.

 xdiff/xdiffi.c | 66 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b3c6848..ff7fc42 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -414,7 +414,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 }
 
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
-	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
+	long i, io, start, ixref, groupsize, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
 	unsigned int blank_lines;
 	xrecord_t **recs = xdf->recs;
@@ -424,7 +424,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	 * change groups for a consistent and pretty diff output. This also
 	 * helps in finding joinable change groups and reduce the diff size.
 	 */
-	for (ix = ixo = 0;;) {
+	for (i = io = 0;;) {
 		/*
 		 * Find the first changed line in the to-be-compacted file.
 		 * We need to keep track of both indexes, so if we find a
@@ -434,22 +434,22 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * not need index bounding since the array is prepared with
 		 * a zero at position -1 and N.
 		 */
-		for (; ix < nrec && !rchg[ix]; ix++)
-			while (rchgo[ixo++]);
-		if (ix == nrec)
+		for (; i < nrec && !rchg[i]; i++)
+			while (rchgo[io++]);
+		if (i == nrec)
 			break;
 
 		/*
 		 * Record the start of a changed-group in the to-be-compacted file
 		 * and find the end of it, on both to-be-compacted and other file
-		 * indexes (ix and ixo).
+		 * indexes (i and io).
 		 */
-		ixs = ix;
-		for (ix++; rchg[ix]; ix++);
-		for (; rchgo[ixo]; ixo++);
+		start = i;
+		for (i++; rchg[i]; i++);
+		for (; rchgo[io]; io++);
 
 		do {
-			grpsiz = ix - ixs;
+			groupsize = i - start;
 			blank_lines = 0;
 
 			/*
@@ -457,9 +457,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
-				rchg[--ixs] = 1;
-				rchg[--ix] = 0;
+			while (start > 0 && recs_match(recs, start - 1, i - 1, flags)) {
+				rchg[--start] = 1;
+				rchg[--i] = 0;
 
 				/*
 				 * This change might have joined two change groups,
@@ -467,8 +467,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				 * the start index accordingly (and so the other-file
 				 * end-of-group index).
 				 */
-				for (; rchg[ixs - 1]; ixs--);
-				while (rchgo[--ixo]);
+				for (; rchg[start - 1]; start--);
+				while (rchgo[--io]);
 			}
 
 			/*
@@ -477,18 +477,18 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * change record before the end-of-group index in the other
 			 * file is set).
 			 */
-			ixref = rchgo[ixo - 1] ? ix: nrec;
+			ixref = rchgo[io - 1] ? i : nrec;
 
 			/*
 			 * If the first line of the current change group, is equal to
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
-				blank_lines += is_blank_line(recs, ix, flags);
+			while (i < nrec && recs_match(recs, start, i, flags)) {
+				blank_lines += is_blank_line(recs, i, flags);
 
-				rchg[ixs++] = 0;
-				rchg[ix++] = 1;
+				rchg[start++] = 0;
+				rchg[i++] = 1;
 
 				/*
 				 * This change might have joined two change groups,
@@ -498,20 +498,20 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				 * index in case we are shifting together with a
 				 * corresponding group of changes in the other file.
 				 */
-				for (; rchg[ix]; ix++);
-				while (rchgo[++ixo])
-					ixref = ix;
+				for (; rchg[i]; i++);
+				while (rchgo[++io])
+					ixref = i;
 			}
-		} while (grpsiz != ix - ixs);
+		} while (groupsize != i - start);
 
 		/*
 		 * Try to move back the possibly merged group of changes, to match
 		 * the recorded position in the other file.
 		 */
-		while (ixref < ix) {
-			rchg[--ixs] = 1;
-			rchg[--ix] = 0;
-			while (rchgo[--ixo]);
+		while (ixref < i) {
+			rchg[--start] = 1;
+			rchg[--i] = 0;
+			while (rchgo[--io]);
 		}
 
 		/*
@@ -523,11 +523,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * in the earlier loop, we need to shift it back only if at all.
 		 */
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
-			while (ixs > 0 &&
-			       !is_blank_line(recs, ix - 1, flags) &&
-			       recs_match(recs, ixs - 1, ix - 1, flags)) {
-				rchg[--ixs] = 1;
-				rchg[--ix] = 0;
+			while (start > 0 &&
+			       !is_blank_line(recs, i - 1, flags) &&
+			       recs_match(recs, start - 1, i - 1, flags)) {
+				rchg[--start] = 1;
+				rchg[--i] = 0;
 			}
 		}
 	}
-- 
2.8.1


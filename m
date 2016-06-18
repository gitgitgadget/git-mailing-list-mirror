Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F165420179
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbcFREPc (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51396 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbcFREPa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:30 -0400
X-AuditID: 1207440c-c53ff70000000b85-93-5764cae19f42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 13.69.02949.1EAC4675; Sat, 18 Jun 2016 00:15:29 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJd029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:28 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/13] do_for_each_ref(): move docstring to the header file
Date:	Sat, 18 Jun 2016 06:15:08 +0200
Message-Id: <b509036e91fcdce43a8e42108117a5daa1a499da.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPvwVEq4wdIlehbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M6YeOs9a8Fr/orPL6YxNjB+4uli
	5OSQEDCRmP1xN2MXIxeHkMBWRokPB5+xQjgnmSSaVj9gAaliE9CVWNTTzARiiwhESDS8agHr
	YBaYwyRx+2EnM0hCWMBPYumDz4wgNouAqsTu3mtgzbwCURJ/F29ihFgnJ3F5+gM2EJtTwEJi
	wZZ9QEM5gLaZS+xdbDiBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJN
	jJCg49nB+G2dzCFGAQ5GJR7eAPuUcCHWxLLiytxDjJIcTEqivFcqgUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeLecAMrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4
	l54EahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUB8MTAKQFI8QHufgLTzFhck
	5gJFIVpPMSpKifM+A0kIgCQySvPgxsJSyStGcaAvhXnXgVTxANMQXPcroMFMQIM15yWDDC5J
	REhJNTB2angwXDiV4+3y+uLdrmWvf1w41HUnUM5p1acf29pL+wOkd22NeLBG5odJyaWLh74K
	NrUcZhFqOLp7zoqsWQc2mwoHrlynH55xbpFgvd/B0sJrm8J93q2fdM06vWX+mzAVn+qK/RvX
	O0jWOeYI7+yNF5yw0v3u0jdpjP/kr+5Z7iAecfLJokZmJZbijERDLeai4kQAaIFVEAADAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  9 ---------
 refs/refs-internal.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bbf96ad..8fa897b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1878,15 +1878,6 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	return retval;
 }
 
-/*
- * Call fn for each reference in the specified ref_cache for which the
- * refname begins with base.  If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration.  If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
- */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1bb3d87..b4dd545 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -249,7 +249,15 @@ int rename_ref_available(const char *oldname, const char *newname);
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 /*
- * The common backend for the for_each_*ref* functions
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base. If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration. If fn ever returns a non-zero
+ * value, stop the iteration and return that value; otherwise, return
+ * 0.
+ *
+ * This is the common backend for the for_each_*ref* functions.
  */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
-- 
2.8.1


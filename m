Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4057320179
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbcFREPl (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64356 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239AbcFREPk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:40 -0400
X-AuditID: 12074411-e3fff70000000955-8c-5764caebe86c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 07.9A.02389.BEAC4675; Sat, 18 Jun 2016 00:15:39 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJi029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:37 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/13] entry_resolves_to_object(): rename function from ref_resolves_to_object()
Date:	Sat, 18 Jun 2016 06:15:13 +0200
Message-Id: <97f6e114a1c7efa96c915b4e3d99326bd62c1609.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqPv6VEq4wdt5ihbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M7Yu1K1oJG7on/yfaYGxk8cXYyc
	HBICJhK3dy9i62Lk4hAS2MoosfV3MxtIQkjgJJPEtadgRWwCuhKLepqZQGwRgQiJhlctjCAN
	zAJzmCRuP+xkBkkICyRLvNr2nB3EZhFQlZj6fTYriM0rECVx9McnRohtchKXpz8AW8ApYCGx
	YMs+oKEcQMvMJfYuNpzAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukm
	RkjACe5gnHFS7hCjAAejEg9vgH1KuBBrYllxZe4hRkkOJiVR3iuVQCG+pPyUyozE4oz4otKc
	1OJDjBIczEoivFtOAOV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	FieBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB4R9fDIwAkBQP0F59kHbe4oLE
	XKAoROspRkUpcd4FIAcJgCQySvPgxsLSyCtGcaAvhXnXgbTzAFMQXPcroMFMQIM15yWDDC5J
	REhJNTAGW5WuluOqe7ep291a7+bkCcK6x9f4Bl+ae0PYMoFjydZHG2y/9M+oDpy5MrReuzay
	mNWF4+ryt5ZrLXmP6d40VCnaNsf1xSKjwEz+jgevuGKLplVYbOYpSrjPV62s0FyfJjI1f6HN
	1MxS/0WTOX2DtPdVXWLQYsiV/KvaPU2r+YeqZTtvnRJLcUaioRZzUXEiAKu3izP+AgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Free up the old name for a more general purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b563a7e..c24a78e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -517,7 +517,7 @@ static void sort_ref_dir(struct ref_dir *dir)
  * an object in the database.  Emit a warning if the referred-to
  * object does not exist.
  */
-static int ref_resolves_to_object(struct ref_entry *entry)
+static int entry_resolves_to_object(struct ref_entry *entry)
 {
 	if (entry->flag & REF_ISBROKEN)
 		return 0;
@@ -563,7 +563,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-	      !ref_resolves_to_object(entry))
+	      !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Store the old value, in case this is a recursive call: */
@@ -2228,7 +2228,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
+	if ((entry->flag & REF_ISSYMREF) || !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Add a packed ref cache entry equivalent to the loose entry. */
-- 
2.8.1


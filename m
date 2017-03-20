Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A152095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755820AbdCTQho (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:37:44 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60962 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754417AbdCTQd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:58 -0400
X-AuditID: 12074414-807ff70000002bfd-1b-58d0046a1088
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 91.96.11261.A6400D85; Mon, 20 Mar 2017 12:33:46 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9H010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:44 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/20] Rename `find_ref()` to `find_ref_entry()`
Date:   Mon, 20 Mar 2017 17:33:12 +0100
Message-Id: <816a7eb8b6abf671c1184d7120a0a01344fe17b1.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqJvFciHC4NUUXYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MB4tOsRas4K14v9+1gXECdxcjJ4eEgInE2Scv2boYuTiEBHYwSWxb
        dYYVwjnFJDH98yI2kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCjxglrs6/yw6SEBZwkPj+6AOQ
        zcHBIqAq0T7DCyTMKxAlcWbfHxaIbfISu9ousoLYnAIWEl/uN4LFhQTMJToX9LJPYORZwMiw
        ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkmER2MB45KXeIUYCDUYmHd8WV
        8xFCrIllxZW5hxglOZiURHmf3gYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGtegmU401JrKxK
        LcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk9Xg4BC4u6R3A6MUS15+XqqSBO8ChgsRQoJF
        qempFWmZOSUIpUwcnCCLeIAWzQGp4S0uSMwtzkyHyJ9iVJQS5y1gBEoIgCQySvPgemFJ4BWj
        ONBbwrx5/4Hu5AEmELjuV0CDmYAGL7txBmRwSSJCSqqBUaT9q+ijRWJ8R24zaUp8vvnkbsXR
        VPuPTntDPnYmskfclLyR+bv4uCxLYNXUK5dlre+XbHlf/vWwOYv6u/5vHlzxmx7PclR8PuXl
        wndVXIy69x7vWvb90HfHLSpf357bsmdJifxM8Uef9MV/65qzRq1ZIGt5xrK4TbeXoyTc7uif
        BlF3m5kx65VYijMSDbWYi4oTAboH9L3dAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d579cbdac..6768c8c86b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -385,7 +385,7 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
  * and recursing into subdirectories as necessary.  If the name is not
  * found or it corresponds to a directory entry, return NULL.
  */
-static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 {
 	int entry_index;
 	struct ref_entry *entry;
@@ -1227,7 +1227,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 					const char *refname)
 {
-	return find_ref(get_packed_refs(refs), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -2171,7 +2171,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
 		    entry->name, oid_to_hex(&entry->u.value.oid));
-	packed_entry = find_ref(cb->packed_refs, entry->name);
+	packed_entry = find_ref_entry(cb->packed_refs, entry->name);
 	if (packed_entry) {
 		/* Overwrite existing packed entry with info from loose entry */
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-- 
2.11.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A256820401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbdFWHDT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:03:19 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59222 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754640AbdFWHCV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:21 -0400
X-AuditID: 12074412-b97ff70000000fed-3e-594cbcf9f91e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.9F.04077.9FCBC495; Fri, 23 Jun 2017 03:02:17 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5t001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/29] add_packed_ref(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:28 +0200
Message-Id: <4e255bb5bb34fe45aee4967723f853b6bb6d0838.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPtzj0+kwfuvKhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGX0LnzCUjBBoOLYrBMsDYxreLsY
        OTkkBEwklu04xdrFyMUhJLCDSWLelxYWCOcUk8ThrXtZQKrYBHQlFvU0M4HYIgJqEhPbDoEV
        MQtMYpZ4e20hUIKDQ1ggUGLebUMQk0VAVaLheQqIySsQJbHziybELnmJXW0XWUFsTgELiZ6J
        y9lBbCEBc4lVv1ezTmDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMj
        JOCEdjCuPyl3iFGAg1GJhzfhrHekEGtiWXFl7iFGSQ4mJVFezUifSCG+pPyUyozE4oz4otKc
        1OJDjBIczEoivDqrgHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8
        BruBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGe2wGGV5ckJhbnJkOkT/FqCglzmu7CyghAJLIKM2D
        64UlhFeM4kCvCPMmgqzgASYTuO5XQIOZgAbPWAM2uCQRISXVwLiFYTKjW6sS359ts6ZYLrtV
        b7PVe562bYLduoPsbz6bZGswhllVN3q7sEZ0hOzlv79SOOegu6V48Ebm69d2O1jxffPuNpMQ
        38/+b+FMs1Nad9UCpy8R1rq8LP3hnqj1q60d2u+XFzMkGV0rO2mwPXWSQe4kIYviI2tYv9m8
        +eeR0t+fu7q3VYmlOCPRUIu5qDgRAHBFPGDjAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc5c0de84e..4943207098 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -438,19 +438,19 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
  * (see lock_packed_refs()). To actually write the packed-refs file,
  * call commit_packed_refs().
  */
-static void add_packed_ref(struct files_ref_store *refs,
+static void add_packed_ref(struct packed_ref_store *refs,
 			   const char *refname, const struct object_id *oid)
 {
 	struct ref_dir *packed_refs;
 	struct ref_entry *packed_entry;
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed refs not locked");
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	packed_refs = get_packed_refs(refs->packed_ref_store);
+	packed_refs = get_packed_refs(refs);
 	packed_entry = find_ref_entry(packed_refs, refname);
 	if (packed_entry) {
 		/* Overwrite the existing entry: */
@@ -1579,7 +1579,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * we don't copy the peeled status, because we want it
 		 * to be re-peeled.
 		 */
-		add_packed_ref(refs, iter->refname, iter->oid);
+		add_packed_ref(refs->packed_ref_store, iter->refname, iter->oid);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((flags & PACK_REFS_PRUNE)) {
@@ -3210,7 +3210,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_oid(&update->new_oid))
-			add_packed_ref(refs, update->refname,
+			add_packed_ref(refs->packed_ref_store, update->refname,
 				       &update->new_oid);
 	}
 
-- 
2.11.0


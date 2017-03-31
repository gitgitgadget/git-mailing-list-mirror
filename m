Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197481FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbdCaOME (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:04 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50442 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933244AbdCaOMA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:00 -0400
X-AuditID: 1207440c-abdff70000002e8f-b9-58de63aeaceb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D2.D9.11919.FA36ED85; Fri, 31 Mar 2017 10:11:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBu010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:57 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/20] get_loose_ref_dir(): function renamed from get_loose_refs()
Date:   Fri, 31 Mar 2017 16:11:13 +0200
Message-Id: <7e0466b41ae2f3c74a83319e456ccf36e86e970d.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqLs++V6EwapuYYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG3ZebGAvWclU83vKKrYHxCkcXIyeHhICJ
        xPlDaxi7GLk4hAR2MElsm72VDcI5ySQx78ZJFpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAm+Y
        JA5s+QVWJCwQKnF28wxmEJtFQFVi14czjCA2r0CUxN6F91kh1slL7Gq7CGZzClhIrJt5iB3E
        FhIwl1iwdgLbBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCgo1n
        B+O3dTKHGAU4GJV4eE9434sQYk0sK67MPcQoycGkJMrrGw4U4kvKT6nMSCzOiC8qzUktPsQo
        wcGsJMLLFAeU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8FYkATUK
        FqWmp1akZeaUIKSZODhBhvMADU8BqeEtLkjMLc5Mh8ifYlSUEudlBUkIgCQySvPgemHJ4BWj
        ONArwrxeIFU8wEQC1/0KaDAT0GCLr3dBBpckIqSkGhid/kscuWdSusqVXYYtvOG+V7VoZ9EK
        hntnntwWCnPJ/rCFX5pTq+OcjoUP90Ql8YrQzREpzNWhJc+r9h1ddymA5brLmV/GS5vCjySp
        2ZzlES3f7Ttd5FpfxJTcg2app5q0tLfFP7PK3zBRczprSabFMnuXtYwZ7arGK/4v2diwwIJJ
        ScNPXomlOCPRUIu5qDgRAJFYB9DhAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new name is more analogous to `get_packed_ref_dir()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ff5df6b46..0a16f6196c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -525,7 +525,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
+static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -1113,7 +1113,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * date with what is on disk, and re-reads it if not.
 	 */
 
-	loose_dir = get_loose_refs(refs);
+	loose_dir = get_loose_ref_dir(refs);
 
 	if (prefix && *prefix)
 		loose_dir = find_containing_dir(loose_dir, prefix, 0);
@@ -1584,7 +1584,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(refs),
+	do_for_each_entry_in_dir(get_loose_ref_dir(refs),
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs(refs))
-- 
2.11.0


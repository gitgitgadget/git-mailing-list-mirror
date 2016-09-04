Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FF31F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbcIDQKY (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56073 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754037AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 1207440e-dafff70000000931-0d-57cc472314a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 18.0B.02353.3274CC75; Sun,  4 Sep 2016 12:09:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5T026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/38] get_packed_ref(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:13 +0200
Message-Id: <9745c19acb6fc673bfa09c4fec4f8f5833a02429.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKvsfibc4OVldYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGdfWP2Qp2CpU8fHweZYGxld8XYyc
        HBICJhIt0zqZuhi5OIQEtjJK7Pm6jBXCOckkcfXWNCaQKjYBXYlFPc1gtoiAmsTEtkMsIEXM
        IEWzJs5kB0kIC3hJHP98F6yIRUBVon/HN7A4r0CUxNNnbewQ6+QkLm37wgxicwpYSJzZPRfI
        5gDaZi7R/iJ7AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghIce3
        g7F9vcwhRgEORiUeXgvtM+FCrIllxZW5hxglOZiURHlnHTwZLsSXlJ9SmZFYnBFfVJqTWnyI
        UYKDWUmEV9sFqJw3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF73RWo
        UbAoNT21Ii0zpwQhzcTBCTKcB2j4TZAa3uKCxNzizHSI/ClGRSlx3pcgCQGQREZpHlwvLCW8
        YhQHekWYV9ENqIoHmE7gul8BDWYCGrxu92mQwSWJCCmpBsbS/z35+YJbczOlNDd4Lj2vXtXc
        6vF188y7zjJBS74bqd6e46GTUHOfPe9XyOxDUb2/rny0P2ly/kt4g8aU7YeXRfsnK7KEu+zb
        /+abuAZr/GHVQvmWutPRWx0dK/UevIpbFvfX4aP0omCnRBcxlgfW+9k3xWjPZ+WX+lgkZOp6
        jo9BNTIoWYmlOCPRUIu5qDgRALNtpJnkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c544de8..2fc8ec9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1403,11 +1403,9 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
  */
-static struct ref_entry *get_packed_ref(const char *refname)
+static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
+					const char *refname)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "get_packed_ref");
-
 	return find_ref(get_packed_refs(refs), refname);
 }
 
@@ -1418,13 +1416,16 @@ static int resolve_missing_loose_ref(const char *refname,
 				     unsigned char *sha1,
 				     unsigned int *flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "resolve_missing_loose_ref");
+
 	struct ref_entry *entry;
 
 	/*
 	 * The loose reference file does not exist; check for a packed
 	 * reference.
 	 */
-	entry = get_packed_ref(refname);
+	entry = get_packed_ref(refs, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
 		*flags |= REF_ISPACKED;
@@ -1836,6 +1837,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 
 int peel_ref(const char *refname, unsigned char *sha1)
 {
+	struct files_ref_store *refs = get_files_ref_store(NULL, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -1860,7 +1862,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED) {
-		struct ref_entry *r = get_packed_ref(refname);
+		struct ref_entry *r = get_packed_ref(refs, refname);
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
@@ -2469,7 +2471,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refname->string)) {
+		if (get_packed_ref(refs, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
-- 
2.9.3


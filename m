Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3755E20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdFOOsN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57525 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752540AbdFOOsL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:11 -0400
X-AuditID: 12074413-d93ff7000000742e-eb-59429e2ac483
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 59.83.29742.A2E92495; Thu, 15 Jun 2017 10:48:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR7014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:08 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/28] get_packed_ref(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:18 +0200
Message-Id: <ff3d5b9fa4bbced88b91a19f93a39c56dd8f2989.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKs1zynSYONcTou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJOz3zDUrCKv+LG3JfMDYzHeboY
        OTkkBEwkmtacZe5i5OIQEtjBJDFr8V5WCOckk8Tl6TdZQKrYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVCCg0NYwE/iSasaSA2LgKrE4WlfGUFsXoEoieXtBxghtslL7Gq7yApicwpY
        SMz+so4ZpFVIwFzi2HKNCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaU
        bmKEhJzwDsZdJ+UOMQpwMCrx8J6odYoUYk0sK67MPcQoycGkJMrLLwcU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMI7dQ5QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEk
        wWs8F6hRsCg1PbUiLTOnBCHNxMEJMpwHaPhfsOHFBYm5xZnpEPlTjIpS4rweIAkBkERGaR5c
        LywlvGIUB3pFmDcKZAUPMJ3Adb8CGswENDjoggPI4JJEhJRUA6OPgUNSvG66SJf2RPMZy4zl
        a0Vn7V3t4Cq7uvPmpimePZMnsPwxDmGatcc18U2jnil7ld5SO74neZ8eiYkznNqvI71CmjMp
        8r/9wrU3Oiu+bmROYqlTjU/3Efnw8qp9e8ZC5atVs+4G/fp+g1W4RlSw56ewgmNhrPj5GM47
        tyephCemvo//qMRSnJFoqMVcVJwIAGZU8wPkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a08d3fbadf..2b9d93d3b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -602,10 +602,10 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
  */
-static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
+static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 					const char *refname)
 {
-	return find_ref_entry(get_packed_refs(refs->packed_ref_store), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -621,7 +621,7 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	 * The loose reference file does not exist; check for a packed
 	 * reference.
 	 */
-	entry = get_packed_ref(refs, refname);
+	entry = get_packed_ref(refs->packed_ref_store, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
 		*flags |= REF_ISPACKED;
@@ -1044,7 +1044,9 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED) {
-		struct ref_entry *r = get_packed_ref(refs, refname);
+		struct ref_entry *r =
+			get_packed_ref(refs->packed_ref_store, refname);
+
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
@@ -1631,7 +1633,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refs, refname->string)) {
+		if (get_packed_ref(refs->packed_ref_store, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
-- 
2.11.0


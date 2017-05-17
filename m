Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB450201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbdEQMG4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55932 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753657AbdEQMGn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:43 -0400
X-AuditID: 1207440d-dcfff70000000e33-90-591c3ccbac46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 50.3B.03635.BCC3C195; Wed, 17 May 2017 08:06:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pgC000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/23] create_ref_entry(): remove `check_name` option
Date:   Wed, 17 May 2017 14:05:44 +0200
Message-Id: <53ee004172d117a1ffc19e36fe1001a2ef62eac5.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqHvWRibSoP2pmMXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSvj5NsnbAWnJCtm353O3MB4VaSLkZNDQsBE
        YkPjT8YuRi4OIYEdTBLTJu9nhXBOMElcnbmEEaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwGMm
        ib/LullAEsICrhK3fn8Ds1kEVCU27r0I1sArECVxYfNUNoh18hK72i6ygticAhYS998/Yu9i
        5ADaZi6x/XrlBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCQo13
        B+P/dTKHGAU4GJV4eC04pCOFWBPLiitzDzFKcjApifLufwAU4kvKT6nMSCzOiC8qzUktPsQo
        wcGsJMJ701QmUog3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMErCYwp
        IcGi1PTUirTMnBKENBMHJ8hwHqDhxiA1vMUFibnFmekQ+VOMilLivAesgRICIImM0jy4Xlgq
        eMUoDvSKMO9zkCoeYBqB634FNJgJaHAzyEe8xSWJCCmpBsbQt0tCHBdrfuYz3VW4qG6i8imL
        nyr6GsI3jm5ZeT/m2Q9TdwYP3e6yryzmvBuYxW6umJPIURahqfP2UHroZDchlu55ZvMW7q6a
        GNuROYf1iPcfkeIb505tmP2xwp1hh1TaowefVvwVe9W0M98ogOXtO0b+BL7MUywW26bNrK2Y
        K/ldhrdXpF6JpTgj0VCLuag4EQC4FsGN4AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only one caller was using it, so move the check to that caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 ++++++++----
 refs/ref-cache.c     |  6 +-----
 refs/ref-cache.h     |  3 +--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d3716c3a6f..c36194be02 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -304,7 +304,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 				hashclr(sha1);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
-			last = create_ref_entry(refname, sha1, flag, 0);
+			last = create_ref_entry(refname, sha1, flag);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -428,8 +428,12 @@ static void add_packed_ref(struct files_ref_store *refs,
 
 	if (!is_lock_file_locked(&refs->packlock))
 		die("internal error: packed refs not locked");
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		die("Reference has invalid format: '%s'", refname);
+
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
-		      create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+		      create_ref_entry(refname, sha1, REF_ISPACKED));
 }
 
 /*
@@ -506,7 +510,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 0));
+					 create_ref_entry(refname.buf, sha1, flag));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 		strbuf_setlen(&path, path_baselen);
@@ -1554,7 +1558,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 			oidcpy(&packed_entry->u.value.oid, iter->oid);
 		} else {
 			packed_entry = create_ref_entry(iter->refname, iter->oid->hash,
-							REF_ISPACKED, 0);
+							REF_ISPACKED);
 			add_ref_entry(packed_refs, packed_entry);
 		}
 		oidclr(&packed_entry->u.value.peeled);
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 6059362f1d..ab76b34e30 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -32,14 +32,10 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
-				   const unsigned char *sha1, int flag,
-				   int check_name)
+				   const unsigned char *sha1, int flag)
 {
 	struct ref_entry *ref;
 
-	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		die("Reference has invalid format: '%s'", refname);
 	FLEX_ALLOC_STR(ref, name, refname);
 	hashcpy(ref->u.value.oid.hash, sha1);
 	oidclr(&ref->u.value.peeled);
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 83e6c2dd2a..9a1ceeb7a5 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -185,8 +185,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   int incomplete);
 
 struct ref_entry *create_ref_entry(const char *refname,
-				   const unsigned char *sha1, int flag,
-				   int check_name);
+				   const unsigned char *sha1, int flag);
 
 /*
  * Return a pointer to a new `ref_cache`. Its top-level starts out
-- 
2.11.0


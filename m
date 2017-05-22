Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0928A2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934736AbdEVOTN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:13 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934731AbdEVOTE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:19:04 -0400
X-AuditID: 1207440d-de7ff70000000e33-0a-5922f3576042
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DB.B8.03635.753F2295; Mon, 22 May 2017 10:19:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24W023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:19:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/25] create_ref_entry(): remove `check_name` option
Date:   Mon, 22 May 2017 16:17:53 +0200
Message-Id: <e7bf8155babba7da1f5c860c3136396972d53c96.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqBv+WSnS4M0lOYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxrnpU5kKDkhW
        /Hs4nbmB8YxIFyMnh4SAicT1HWuZuxi5OIQEdjBJbJm7gB3COcUkMfvsDCaQKjYBXYlFPc1g
        toiAmsTEtkMsIEXMAhuYJd5MXw2WEBbwkFj2ei4ziM0ioCpxsuk2G4jNKxAlsW37XCaIdfIS
        u9ousoLYnAIWEr9nHQCLCwmYS/T+W80ygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
        I73czBK91JTSTYyQUOTdwfh/ncwhRgEORiUeXo3HSpFCrIllxZW5hxglOZiURHmPvgEK8SXl
        p1RmJBZnxBeV5qQWH2KU4GBWEuHVvguU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0t
        SC2CycpwcChJ8E7+BNQoWJSanlqRlplTgpBm4uAEGc4DNHzNB5DhxQWJucWZ6RD5U4yKUuK8
        BiDNAiCJjNI8uF5YqnjFKA70ijBvIUgVDzDNwHW/AhrMBDTY+pk8yOCSRISUVAOjwJc5Ks5C
        mj6/5tzRXvL/cOntfzyyHi7i4QvOGi364+TexCawaJLn7Jt/j68X7P4/MV7SYNXf71tUk+v2
        37u85t7WLVXK/XKHLheczrn46dymN4vtqi7d1AhmP5synVep0H93xtu23d3PzVe1/F+wP+ep
        /8+JOlIehziW8Vl/nXduyueYtf5T5ymxFGckGmoxFxUnAgD08rJv8AIAAA==
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
index 5de36fc335..d8b3f73147 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -291,7 +291,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 				oidclr(&oid);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
-			last = create_ref_entry(refname, &oid, flag, 0);
+			last = create_ref_entry(refname, &oid, flag);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -415,8 +415,12 @@ static void add_packed_ref(struct files_ref_store *refs,
 
 	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		die("BUG: packed refs not locked");
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		die("Reference has invalid format: '%s'", refname);
+
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
-		      create_ref_entry(refname, oid, REF_ISPACKED, 1));
+		      create_ref_entry(refname, oid, REF_ISPACKED));
 }
 
 /*
@@ -493,7 +497,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, &oid, flag, 0));
+					 create_ref_entry(refname.buf, &oid, flag));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 		strbuf_setlen(&path, path_baselen);
@@ -1541,7 +1545,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 			oidcpy(&packed_entry->u.value.oid, iter->oid);
 		} else {
 			packed_entry = create_ref_entry(iter->refname, iter->oid,
-							REF_ISPACKED, 0);
+							REF_ISPACKED);
 			add_ref_entry(packed_refs, packed_entry);
 		}
 		oidclr(&packed_entry->u.value.peeled);
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 6b11d9cd12..ec97f3a38a 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -32,14 +32,10 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
-				   const struct object_id *oid, int flag,
-				   int check_name)
+				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
 
-	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		die("Reference has invalid format: '%s'", refname);
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
 	oidclr(&ref->u.value.peeled);
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index fbfee7ce79..794f000fd3 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -185,8 +185,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   int incomplete);
 
 struct ref_entry *create_ref_entry(const char *refname,
-				   const struct object_id *oid, int flag,
-				   int check_name);
+				   const struct object_id *oid, int flag);
 
 /*
  * Return a pointer to a new `ref_cache`. Its top-level starts out
-- 
2.11.0


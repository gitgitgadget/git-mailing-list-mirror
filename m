Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0560520A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755051AbdDPGmo (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:44 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50267 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754941AbdDPGmj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:39 -0400
X-AuditID: 1207440f-129ff70000003517-a3-58f3125a121f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.A8.13591.A5213F85; Sun, 16 Apr 2017 02:42:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN7025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:32 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/20] ref-cache: rename `add_ref()` to `add_ref_entry()`
Date:   Sun, 16 Apr 2017 08:41:28 +0200
Message-Id: <063bb27145b88901683ff2fd4b96a1f037277317.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBsn9DnCYMo2Zou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG73vCBXv4Kl7d6mJsYPzJ3cXIySEhYCIx
        /epR9i5GLg4hgR1MEh1frzNDOCeYJJp3/2YFqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCzwmEni
        77JuFpCEsICPxJ7d58CKWARUJY48+gFm8wpESTw/coYRYp28xK62i2BDOQUsJKbc3QDWKyRg
        LrH9+FXmCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhBr/Dsau
        9TKHGAU4GJV4eC38P0UIsSaWFVfmHmKU5GBSEuWV+Q8U4kvKT6nMSCzOiC8qzUktPsQowcGs
        JMKbzPI5Qog3JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCarwcEhcHdJ7wZGKZa8
        /LxUJQneaEGgIYJFqempFWmZOSUIpUwcnCCLeIAWbRUAWVRckJhbnJkOkT/FqCglzvuNHygh
        AJLIKM2D64WliFeM4kBvCfMyg6zgAaYXuO5XQIOZgAYzTP4AMrgkESEl1cComvnHrJdnmX1o
        8DlLkyu+x8ov6N8tdvu5YfEWfhsX+8aAmN0GCotW3FtdHJh/2/Py3qciV5f23xQyLVuw6wf/
        YQ/nJavO/fjxUFHootn8GJZVSzK+LvNZF91w7c/ZibbVMxR2+Bbt1U233ybfFhkm9M0vcOPl
        N4d1bq2KLOvRXBN4QF0p/eo0JZbijERDLeai4kQAyZsrJewCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cf1c18cffb..05029d43b8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -455,7 +455,7 @@ static int remove_entry(struct ref_dir *dir, const char *refname)
  * subdirectories as necessary.  dir must represent the top-level
  * directory.  Return 0 on success.
  */
-static int add_ref(struct ref_dir *dir, struct ref_entry *ref)
+static int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
 {
 	dir = find_containing_dir(dir, ref->name, 1);
 	if (!dir)
@@ -993,7 +993,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
-			add_ref(dir, last);
+			add_ref_entry(dir, last);
 			continue;
 		}
 		if (last &&
@@ -1115,7 +1115,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
-	add_ref(get_packed_ref_dir(packed_ref_cache),
+	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
@@ -2176,7 +2176,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	} else {
 		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
 						REF_ISPACKED | REF_KNOWS_PEELED, 0);
-		add_ref(cb->packed_refs, packed_entry);
+		add_ref_entry(cb->packed_refs, packed_entry);
 	}
 	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
 
-- 
2.11.0


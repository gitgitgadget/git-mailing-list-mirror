Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C922095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755616AbdCTQiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:38:05 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47831 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755531AbdCTQdr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:47 -0400
X-AuditID: 1207440c-aa5ff70000002e8f-ef-58d00468df82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 19.FC.11919.86400D85; Mon, 20 Mar 2017 12:33:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9G010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:43 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/20] Rename `add_ref()` to `add_ref_entry()`
Date:   Mon, 20 Mar 2017 17:33:11 +0100
Message-Id: <4bb20343fc050a2d99cecda125cc9207e57215f7.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqJvJciHC4MMHNouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MZy9aWAv28FXM3KrYwPiTu4uRk0NCwETi98p/LF2MXBxCAjuYJCY9
        uM8KkhASOMUkcWlKIIjNJqArsainmQnEFhFQk5jYdgisgVngEaPE1fl32UESwgJ2Ep2z25lB
        bBYBVYlpc5+D2bwCURJPP+xnhdgmL7Gr7SKYzSlgIfHlfiMLxDJzic4FvewTGHkWMDKsYpRL
        zCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAgJJp4djN/WyRxiFOBgVOLhXXHlfIQQ
        a2JZcWXuIUZJDiYlUd6nt4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHirXgLleFMSK6tSi/Jh
        UtIcLErivKpL1P2EBNITS1KzU1MLUotgshocHAJ3l/RuYJRiycvPS1WS4E37CzREsCg1PbUi
        LTOnBKGUiYMTZBEP0KIQkBre4oLE3OLMdIj8KUZFKXFeV5CEAEgiozQPrheWBF4xigO9Jcwb
        DFLFA0wgcN2vgAYzAQ1eduMMyOCSRISUVAMjJ+vXPSaskb+Fzntv1Prp2Lt6SvEK42+uH+9V
        P/7pYpHF1P7JlDX0zcZHZ40bJuf+fajxcOUx5cKpLEd8PB/vidyf8W1qVfj0V+tr1r426zvx
        98olyfg9TvxC+3Tq7I7x6O7V1CyRF80yqw/cvON3sdRco4/sf9IWn72bFVAmPrvgBeMjNb7p
        SizFGYmGWsxFxYkAbUfabt0CAAA=
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
index cad56efb04..4d579cbdac 100644
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
@@ -994,7 +994,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
-			add_ref(dir, last);
+			add_ref_entry(dir, last);
 			continue;
 		}
 		if (last &&
@@ -1116,7 +1116,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
-	add_ref(get_packed_ref_dir(packed_ref_cache),
+	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
@@ -2179,7 +2179,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	} else {
 		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
 						REF_ISPACKED | REF_KNOWS_PEELED, 0);
-		add_ref(cb->packed_refs, packed_entry);
+		add_ref_entry(cb->packed_refs, packed_entry);
 	}
 	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
 
-- 
2.11.0


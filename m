Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AB320958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755635AbdCTQeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:11 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60962 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755582AbdCTQeF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:05 -0400
X-AuditID: 12074414-807ff70000002bfd-1f-58d0046c39e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 72.96.11261.C6400D85; Mon, 20 Mar 2017 12:33:48 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9I010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/20] Rename `remove_entry()` to `remove_entry_from_dir()`
Date:   Mon, 20 Mar 2017 17:33:13 +0100
Message-Id: <45956d0aeb61dbe14fe59326564c5078b8ed67cc.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqJvDciHC4Mw2IYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MrUsPsBe0c1Y8W/yTuYFxD3sXIweHhICJxMtTSV2MXBxCAjuYJE7t
        O8II4Zxiklg++z2Qw8nBJqArsainmQnEFhFQk5jYdogFpIhZ4BGjxNX5d9lBEsIC3hJbe7eB
        NbAIqEpcbd0AFucViJI4sOchWFxCQF5iV9tFVhCbU8BC4sv9RhYQW0jAXKJzQS/7BEaeBYwM
        qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCwklkB+ORk3KHGAU4GJV4eFdc
        OR8hxJpYVlyZe4hRkoNJSZT36W2gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeqpdAOd6UxMqq
        1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkNDg6Bu0t6NzBKseTl56UqSfAuYLgQISRY
        lJqeWpGWmVOCUMrEwQmyiAdo0RyQGt7igsTc4sx0iPwpRl2OXz3H3jAJgQ2SEuctYAQqEgAp
        yijNg5sDSw+vGMWBXhTmzfsPdDMPMLXATXoFtIQJaMmyG2dAlpQkIqSkGhjrth9UCV20VOmC
        k8uEKhPz+FcvepxSlxl95Xw89aRNSmHFLd9NDtXdYRtkOcJni6nHN7s+stftUbyZsiTArLbl
        awvL48zNy/gXn30qk2Cx6GI2b998me3en1euNp5SW2r96kO4oIjJmr/fA5darNo6bdP3zZe+
        9DLo1qq6HXGJ/h8poqzm1KrEUpyRaKjFXFScCACA5J1l6gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6768c8c86b..b4c11afadf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -413,7 +413,7 @@ static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname
  * empty by the removal.  dir must represent the top-level directory
  * and must already be complete.
  */
-static int remove_entry(struct ref_dir *dir, const char *refname)
+static int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
 {
 	int refname_len = strlen(refname);
 	int entry_index;
@@ -2338,7 +2338,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
-		if (remove_entry(packed, refname->string) != -1)
+		if (remove_entry_from_dir(packed, refname->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
-- 
2.11.0


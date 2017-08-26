Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2C220285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbdHZI2s (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:48 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60466 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754548AbdHZI2o (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:44 -0400
X-AuditID: 1207440c-7e5ff7000000143e-a0-59a1313a6536
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 12.4A.05182.A3131A95; Sat, 26 Aug 2017 04:28:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHis004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/12] load_subtree(): declare some variables to be `size_t`
Date:   Sat, 26 Aug 2017 10:28:12 +0200
Message-Id: <03eba8f14c048d276249bcb64bd9d97f5c2e55f9.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqGtluDDS4OA8K4uuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVMfvfRuaC7VwVR3bMZWlgnM/RxcjJISFgIvFw/iYWEFtIYAeTxPzVuV2MXED2KSaJZY8b
        GEESbAK6Eot6mplAbBEBNYmJbYdYQIqYBZYzSnS8PQ+WEBbwkZjbOJUNxGYRUJW4desJWJxX
        IEri3YudjBDb5CV2tV1kBbE5BSwkbmz9zAax2Vyi7+cilgmMPAsYGVYxyiXmlObq5iZm5hSn
        JusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQOzw7Gb+tkDjEKcDAq8fBGFC6IFGJNLCuuzD3EKMnB
        pCTK66CxMFKILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO8KJaAcb0piZVVqUT5MSpqDRUmcV3WJ
        up+QQHpiSWp2ampBahFMVoaDQ0mCt0MfqFGwKDU9tSItM6cEIc3EwQkynAdoeAZIDW9xQWJu
        cWY6RP4Uo6KUOK8DSEIAJJFRmgfXC4vsV4ziQK8I88oZAFXxAJMCXPcroMFMQIMVBcEGlyQi
        pKQaGJdOuhx37uTVV1ohDDGLCyWOPylSl/Q22BK70VbRMsF7yvbSzdsX8TDdyu5xFci889br
        r8vVEzrTayr+fLgRlMMvbfPhmGjwzabisn3WXdyKZy3c85548//jlNKP+Hc/mpktfdmvWKup
        559+1woxMlv/Mu1r0xIHBYFX4c06OzW/yd35FVmuocRSnJFoqMVcVJwIAFIurf/HAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* `prefix_len`
* `path_len`
* `i`

It's good hygiene.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index d5409b55e3..7f5bfa19c7 100644
--- a/notes.c
+++ b/notes.c
@@ -406,7 +406,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n)
 {
 	struct object_id object_oid;
-	unsigned int prefix_len;
+	size_t prefix_len;
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -422,7 +422,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
 		struct leaf_node *l;
-		int path_len = strlen(entry.path);
+		size_t path_len = strlen(entry.path);
 
 		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
@@ -486,7 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		{
 			struct strbuf non_note_path = STRBUF_INIT;
 			const char *q = oid_to_hex(&subtree->key_oid);
-			int i;
+			size_t i;
 			for (i = 0; i < prefix_len; i++) {
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, *q++);
-- 
2.11.0


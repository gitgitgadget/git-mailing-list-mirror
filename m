Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7245C20285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbdHZI2k (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48904 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754316AbdHZI2g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:36 -0400
X-AuditID: 1207440d-86bff70000000f42-88-59a1313343f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.8D.03906.33131A95; Sat, 26 Aug 2017 04:28:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHio004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/12] get_oid_hex_segment(): return 0 on success
Date:   Sat, 26 Aug 2017 10:28:08 +0200
Message-Id: <1a421226c8f7cb3cb7609cb4bd06ed009430a543.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqGtsuDDS4PYhTYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV0bL4NUvBYeGKhj0yDYzT+LsYOTkkBEwkjkw4xdTFyMUhJLCDSWLl0z2MEM4pJonbH/6z
        g1SxCehKLOppZgKxRQTUJCa2HWIBKWIWWM4o0fH2PFhCWMBRYubL26wgNouAqsTkbX1gNq9A
        lMT3s+dZINbJS+xquwgW5xSwkLix9TMbiC0kYC7R93MRywRGngWMDKsY5RJzSnN1cxMzc4pT
        k3WLkxPz8lKLdI30cjNL9FJTSjcxQgKHdwfj/3UyhxgFOBiVeHg3FC+IFGJNLCuuzD3EKMnB
        pCTK66CxMFKILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO8KJaAcb0piZVVqUT5MSpqDRUmcV22J
        up+QQHpiSWp2ampBahFMVoaDQ0mC948+UKNgUWp6akVaZk4JQpqJgxNkOA/Q8AyQGt7igsTc
        4sx0iPwpRkUpcd5ZBkAJAZBERmkeXC8ssl8xigO9IswrB1LFA0wKcN2vgAYzAQ1WFAQbXJKI
        kJJqYEyddqHjSHH6ZJNfjGzGG5q2x25fuC/oe1aWu9LLXywSc6ycj+2QPc7l1nR3aZJA/PUp
        POpnrd5VuM3UYp8ouXFFgtWpKVv2GtlUqvC67QqX+XeSTVRngeTXwztWS51fMK90T/K7xZ+Z
        sw5xMabYiHitNli0Zt0io3ZPU3XOipfxa59G6XT4+ymxFGckGmoxFxUnAgC9GsLCxwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nobody cares about the return value of get_oid_hex_segment() except to
check whether it failed. So just return 0 on success.

And while we're updating its docstring, update it for some argument
renaming that happened a while ago.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/notes.c b/notes.c
index 46ab15b83a..6ce71bfedb 100644
--- a/notes.c
+++ b/notes.c
@@ -338,11 +338,10 @@ static void note_tree_free(struct int_node *tree)
  * Convert a partial SHA1 hex string to the corresponding partial SHA1 value.
  * - hex      - Partial SHA1 segment in ASCII hex format
  * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
- * - sha1     - Partial SHA1 value is written here
- * - sha1_len - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
- * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format)).
- * Otherwise, returns number of bytes written to sha1 (i.e. hex_len / 2).
- * Pads sha1 with NULs up to sha1_len (not included in returned length).
+ * - oid      - Partial SHA1 value is written here
+ * - oid_len  - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
+ * Return 0 on success or -1 on error (invalid arguments or input not
+ * in hex format). Pad oid with NULs up to oid_len.
  */
 static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
 		unsigned char *oid, unsigned int oid_len)
@@ -359,7 +358,7 @@ static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
 	}
 	for (; i < oid_len; i++)
 		*oid++ = 0;
-	return len;
+	return 0;
 }
 
 static int non_note_cmp(const struct non_note *a, const struct non_note *b)
@@ -444,7 +443,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 
 			if (get_oid_hex_segment(entry.path, path_len,
 						object_oid.hash + prefix_len,
-						GIT_SHA1_RAWSZ - prefix_len) < 0)
+						GIT_SHA1_RAWSZ - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_NOTE;
@@ -461,7 +460,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 
 			if (get_oid_hex_segment(entry.path, 2,
 						object_oid.hash + prefix_len,
-						GIT_SHA1_RAWSZ - prefix_len) < 0)
+						GIT_SHA1_RAWSZ - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_SUBTREE;
-- 
2.11.0


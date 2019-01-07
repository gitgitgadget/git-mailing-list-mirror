Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED39E1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAGIdy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:33:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:56308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:33:54 -0500
Received: (qmail 1112 invoked by uid 109); 7 Jan 2019 08:33:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:33:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 684 invoked by uid 111); 7 Jan 2019 08:33:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:33:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:33:52 -0500
Date:   Mon, 7 Jan 2019 03:33:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 01/11] sha1-file: fix outdated sha1 comment references
Message-ID: <20190107083352.GA29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 17e65451e3 (sha1_file: convert check_sha1_signature to struct
object_id, 2018-03-12) switched to using the name "oid", but forgot to
update the variable name in the comment.

Likewise, b4f5aca40e (sha1_file: convert read_sha1_file to struct
object_id, 2018-03-12) dropped the name read_sha1_file(), but missed a
comment which mentions it.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index c3c6e50704..e86bb28320 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -124,7 +124,7 @@ const char *empty_blob_oid_hex(void)
 
 /*
  * This is meant to hold a *small* number of objects that you would
- * want read_sha1_file() to be able to return, but yet you do not want
+ * want read_object_file() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
  * application).
  */
@@ -798,8 +798,8 @@ void *xmmap(void *start, size_t length,
 
 /*
  * With an in-core object data in "map", rehash it to make sure the
- * object name actually matches "sha1" to detect object corruption.
- * With "map" == NULL, try reading the object named with "sha1" using
+ * object name actually matches "oid" to detect object corruption.
+ * With "map" == NULL, try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(const struct object_id *oid, void *map,
-- 
2.20.1.470.g640a3e2614


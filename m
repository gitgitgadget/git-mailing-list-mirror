Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE3C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C62073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgC3OEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:04:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:55640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727191AbgC3OEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:04:12 -0400
Received: (qmail 15186 invoked by uid 109); 30 Mar 2020 14:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18778 invoked by uid 111); 30 Mar 2020 14:14:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:14:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:04:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] ref-filter: stop referring to "sha1 array"
Message-ID: <20200330140411.GF2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment refers to the "sha1s in the given sha1 array". But this became
an oid_array along with everywhere else in 910650d2f8 (Rename sha1_array
to oid_array, 2017-03-31). Plus there's an extra line of leftover
editing cruft we can drop.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b1812cb69a..35776838f4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1976,10 +1976,9 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 }
 
 /*
- * Given a ref (sha1, refname), check if the ref belongs to the array
- * of sha1s. If the given ref is a tag, check if the given tag points
- * at one of the sha1s in the given sha1 array.
- * the given sha1_array.
+ * Given a ref (oid, refname), check if the ref belongs to the array
+ * of oids. If the given ref is a tag, check if the given tag points
+ * at one of the oids in the given oid array.
  * NEEDSWORK:
  * 1. Only a single level of inderection is obtained, we might want to
  * change this to account for multiple levels (e.g. annotated tags
-- 
2.26.0.597.g7e08ed78ff


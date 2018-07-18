Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B5D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeGRVY1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:24:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:51740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729281AbeGRVY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:24:27 -0400
Received: (qmail 18244 invoked by uid 109); 18 Jul 2018 20:44:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 20:44:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3450 invoked by uid 111); 18 Jul 2018 20:44:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 16:44:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 16:44:49 -0400
Date:   Wed, 18 Jul 2018 16:44:49 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] check_replace_refs: fix outdated comment
Message-ID: <20180718204449.GA31816@sigill.intra.peff.net>
References: <20180718204424.GA1483@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718204424.GA1483@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit afc711b8e1 (rename read_replace_refs to
check_replace_refs, 2014-02-18) added a comment mentioning
that check_replace_refs is set in two ways:

  - from user intent via --no-replace-objects, etc

  - after seeing there are no replace refs to respect

Since c3c36d7de2 (replace-object: check_replace_refs is safe
in multi repo environment, 2018-04-11) the second is no
longer true. Let's drop that part of the comment.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d..6365fd6c0f 100644
--- a/cache.h
+++ b/cache.h
@@ -804,9 +804,7 @@ void reset_shared_repository(void);
  * Do replace refs need to be checked this run?  This variable is
  * initialized to true unless --no-replace-object is used or
  * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
- * commands that do not want replace references to be active.  As an
- * optimization it is also set to false if replace references have
- * been sought but there were none.
+ * commands that do not want replace references to be active.
  */
 extern int check_replace_refs;
 extern char *git_replace_ref_base;
-- 
2.18.0.433.gb9621797ee


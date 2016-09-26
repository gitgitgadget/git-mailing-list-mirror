Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E2A209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034391AbcIZMAS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:48032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034371AbcIZMAR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:17 -0400
Received: (qmail 18646 invoked by uid 109); 26 Sep 2016 12:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:16 +0000
Received: (qmail 4382 invoked by uid 111); 26 Sep 2016 12:00:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:14 -0400
Date:   Mon, 26 Sep 2016 08:00:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 07/10] get_short_sha1: mark ambiguity error for translation
Message-ID: <20160926120014.6gvp22awmrkjgmoc@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a human-readable message, and there's no reason it
should not be translated. While we're at it, let's drop the
period from the end, which is not our usual style.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 549ef3f..d4c7e26 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -351,7 +351,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	status = finish_object_disambiguation(&ds, sha1);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %s is ambiguous.", ds.hex_pfx);
+		return error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
 	return status;
 }
 
-- 
2.10.0.492.g14f803f


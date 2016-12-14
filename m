Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA571FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755977AbcLNO07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:26:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:56390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbcLNO06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:26:58 -0500
Received: (qmail 31220 invoked by uid 109); 14 Dec 2016 14:26:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 14:26:57 +0000
Received: (qmail 25296 invoked by uid 111); 14 Dec 2016 14:27:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 09:27:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 09:26:55 -0500
Date:   Wed, 14 Dec 2016 09:26:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 1/4] Makefile: reformat FIND_SOURCE_FILES
Message-ID: <20161214142655.boepotpgwgrdnldz@sigill.intra.peff.net>
References: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214142533.svktxk63eiwaaeor@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we add to this in future commits, the formatting is going
to make it harder and harder to read. Let's write it more as
we would in a shell script, putting each logical block on
its own line.

Signed-off-by: Jeff King <peff@peff.net>
---
Just to make the other patches easier to read; no behavior change
intended.

I was tempted to actually pull this out into its own
find-source-files.sh script. I don't know if that is
preferable or not; it certainly makes the "make tags"
output less ugly.

 Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f53fcc90d..f42b1953d 100644
--- a/Makefile
+++ b/Makefile
@@ -2149,9 +2149,12 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
-FIND_SOURCE_FILES = ( git ls-files '*.[hcS]' 2>/dev/null || \
-			$(FIND) . \( -name .git -type d -prune \) \
-				-o \( -name '*.[hcS]' -type f -print \) )
+FIND_SOURCE_FILES = ( \
+	git ls-files '*.[hcS]' 2>/dev/null || \
+	$(FIND) . \
+		\( -name .git -type d -prune \) \
+		-o \( -name '*.[hcS]' -type f -print \) \
+	)
 
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
-- 
2.11.0.341.g202cd3142


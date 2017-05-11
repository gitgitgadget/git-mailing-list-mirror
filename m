Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C0A1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755036AbdEKJLK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:11:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49243 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755018AbdEKJLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:11:09 -0400
Received: (qmail 1265 invoked by uid 109); 11 May 2017 09:11:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:11:08 +0000
Received: (qmail 10177 invoked by uid 111); 11 May 2017 09:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:11:06 -0400
Date:   Thu, 11 May 2017 05:11:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/4] docs/config: give a relative includeIf example
Message-ID: <20170511091106.cpk5emqtvp4cdeoi@sigill.intra.peff.net>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changes in the previous commit hopefully clarify that
the evaluation of an include "path" variable is the same no
matter if it's in a conditional section or not. But since
this question came up on the list, let's add an example that
makes it obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5a453ed3..929776954 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -187,6 +187,12 @@ Example
 	[includeIf "gitdir:~/to/group/"]
 		path = /path/to/foo.inc
 
+	; relative paths are always relative to the including
+	; file (if the condition is true); their location is not
+	; affected by the condition
+	[includeIf "gitdir:/path/to/group/"]
+		path = foo.inc
+
 Values
 ~~~~~~
 
-- 
2.13.0.447.g4d26bc97c


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9F71FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdEKJNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:13:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:49259 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdEKJNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:13:07 -0400
Received: (qmail 1440 invoked by uid 109); 11 May 2017 09:13:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:13:06 +0000
Received: (qmail 10233 invoked by uid 111); 11 May 2017 09:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:13:04 -0400
Date:   Thu, 11 May 2017 05:13:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 3/4] docs/config: avoid the term "expand" for includes
Message-ID: <20170511091304.ivauge72dncv65fs@sigill.intra.peff.net>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the word "expand" to refer to including the contents
of another config file isn't really accurate, since it's a
verbatim insertion. And it can cause confusion with the
expanding of the path itself via things like "~".

Let's clarify when we are referring to the contents versus
the filename, and use appropriate verbs in each case.

Signed-off-by: Jeff King <peff@peff.net>
---
I dropped the "& insert" from your suggestion, because I think it
clear in the context of the earlier "include by absolute path" (and I
think it reads better).

 Documentation/config.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 929776954..70f79ac39 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -90,8 +90,8 @@ You can include a config file from another by setting the special
 to be included. The variable takes a pathname as its value, and is
 subject to tilde expansion. These variables can be given multiple times.
 
-The included file is expanded immediately, as if its contents had been
-found at the location of the include directive. If the value of the
+The contents of the included file are inserted immediately, as if they
+had been found at the location of the include directive. If the value of the
 variable is a relative path, the path is considered to
 be relative to the configuration file in which the include directive
 was found.  See below for examples.
@@ -172,8 +172,8 @@ Example
 
 	[include]
 		path = /path/to/foo.inc ; include by absolute path
-		path = foo ; expand "foo" relative to the current file
-		path = ~/foo ; expand "foo" in your `$HOME` directory
+		path = foo ; find "foo" relative to the current file
+		path = ~/foo ; find "foo" in your `$HOME` directory
 
 	; include if $GIT_DIR is /path/to/foo/.git
 	[includeIf "gitdir:/path/to/foo/.git"]
-- 
2.13.0.447.g4d26bc97c


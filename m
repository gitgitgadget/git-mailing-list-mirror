Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2111FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbdEKJKv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:10:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:49242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753303AbdEKJKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:10:50 -0400
Received: (qmail 1251 invoked by uid 109); 11 May 2017 09:10:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:10:49 +0000
Received: (qmail 10170 invoked by uid 111); 11 May 2017 09:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:10:47 -0400
Date:   Thu, 11 May 2017 05:10:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/4] docs/config: clarify include/includeIf relationship
Message-ID: <20170511091047.2dw52pnriulhjky3@sigill.intra.peff.net>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "includeIf" directives behave exactly like include ones,
except they only kick in when the conditional is true. That
was mentioned in the "conditional" section, but let's make
it more clear for the whole "includes" section, since people
don't necessarily read the documentation top to bottom.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..d5a453ed3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -79,14 +79,20 @@ escape sequences) are invalid.
 Includes
 ~~~~~~~~
 
+The `include` and `includeIf` sections allow you include config
+directives from another source. These sections behave identically to
+each other with the exception that `includeIf` sections may be ignored
+if their condition does not evaluate to true; see "Conditional includes"
+below.
+
 You can include a config file from another by setting the special
-`include.path` variable to the name of the file to be included. The
-variable takes a pathname as its value, and is subject to tilde
-expansion. `include.path` can be given multiple times.
+`include.path` (or `includeIf.*.path`) variable to the name of the file
+to be included. The variable takes a pathname as its value, and is
+subject to tilde expansion. These variables can be given multiple times.
 
 The included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
-`include.path` variable is a relative path, the path is considered to
+variable is a relative path, the path is considered to
 be relative to the configuration file in which the include directive
 was found.  See below for examples.
 
@@ -95,8 +101,7 @@ Conditional includes
 
 You can include a config file from another conditionally by setting a
 `includeIf.<condition>.path` variable to the name of the file to be
-included. The variable's value is treated the same way as
-`include.path`. `includeIf.<condition>.path` can be given multiple times.
+included.
 
 The condition starts with a keyword followed by a colon and some data
 whose format and meaning depends on the keyword. Supported keywords
-- 
2.13.0.447.g4d26bc97c


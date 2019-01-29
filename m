Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630271F453
	for <e@80x24.org>; Tue, 29 Jan 2019 12:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfA2MlO (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:41:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:52920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727033AbfA2MlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 07:41:14 -0500
Received: (qmail 25206 invoked by uid 109); 29 Jan 2019 12:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 12:41:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6095 invoked by uid 111); 29 Jan 2019 12:41:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 07:41:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 07:41:12 -0500
Date:   Tue, 29 Jan 2019 07:41:12 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Lukashev <lukashev.s@ya.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 2/2] docs/config: clarify "text property" in core.eol
Message-ID: <20190129124112.GB21931@sigill.intra.peff.net>
References: <20190129124031.GA13084@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129124031.GA13084@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word "property" is vague here. Let's spell out that we mean the path
must be marked with the text attribute.

While we're here, let's make the paragraph a little easier to read by
de-emphasizing the "when core.autocrlf is false" bit. Putting it in the
first sentence obscures the main content, and many readers won't care
about autocrlf (i.e., anyone who is just following the gitattributes(7)
advice, which mainly discusses "text" and "core.eol").

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/core.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..7e9b6c8f4c 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -121,11 +121,14 @@ core.quotePath::
 
 core.eol::
 	Sets the line ending type to use in the working directory for
-	files that have the `text` property set when core.autocrlf is false.
+	files that are marked as text (either by having the `text`
+	attribute set, or by having `text=auto` and Git auto-detecting
+	the contents as text).
 	Alternatives are 'lf', 'crlf' and 'native', which uses the platform's
 	native line ending.  The default value is `native`.  See
 	linkgit:gitattributes[5] for more information on end-of-line
-	conversion.
+	conversion. Note that this value is ignored if `core.autocrlf`
+	is set to `true` or `input`.
 
 core.safecrlf::
 	If true, makes Git check if converting `CRLF` is reversible when
-- 
2.20.1.845.g57b86ca485

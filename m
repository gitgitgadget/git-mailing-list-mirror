Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18351F453
	for <e@80x24.org>; Tue, 29 Jan 2019 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfA2MlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:41:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:52912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727033AbfA2MlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 07:41:09 -0500
Received: (qmail 25152 invoked by uid 109); 29 Jan 2019 12:41:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 12:41:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6076 invoked by uid 111); 29 Jan 2019 12:41:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 07:41:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 07:41:07 -0500
Date:   Tue, 29 Jan 2019 07:41:07 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Lukashev <lukashev.s@ya.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 1/2] doc/gitattributes: clarify "autocrlf overrides eol"
Message-ID: <20190129124107.GA21931@sigill.intra.peff.net>
References: <20190129124031.GA13084@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129124031.GA13084@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only override core.eol with core.autocrlf when the latter is set to
something besides "false".  Let's make this more clear, and point the
reader to the git-config definitions, which discuss this in more detail.

Noticed-by: Sergey Lukashev <lukashev.s@ya.ru>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..ce383e97dc 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -124,7 +124,9 @@ text file is normalized, its line endings are converted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
 `core.eol` configuration variable for all text files.
-Note that `core.autocrlf` overrides `core.eol`
+Note that setting `core.autocrlf` to `true` or `input` overrides
+`core.eol` (see the definitions of those options in
+linkgit:git-config[1]).
 
 Set::
 
-- 
2.20.1.845.g57b86ca485


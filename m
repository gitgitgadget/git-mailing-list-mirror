Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDD120193
	for <e@80x24.org>; Sun, 30 Oct 2016 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756001AbcJ3Sqh (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 14:46:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36239 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754765AbcJ3Sqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 14:46:36 -0400
Received: (qmail 24799 invoked by uid 109); 30 Oct 2016 18:46:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 18:46:36 +0000
Received: (qmail 11938 invoked by uid 111); 30 Oct 2016 18:47:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 14:47:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Oct 2016 14:46:33 -0400
Date:   Sun, 30 Oct 2016 14:46:33 -0400
From:   Jeff King <peff@peff.net>
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Michael Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: [PATCH] doc: fix missing "::" in config list
Message-ID: <20161030184633.6lqdeefznpezhljd@sigill.intra.peff.net>
References: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
 <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2016 at 07:21:41PM +0200, Alexei Lozovsky wrote:

> > It would help especially when the commit message was written badly.
> >
> > Or it might be possible to customize just like "git log --format"?
> 
> It is possible to change the format globally via config option
> rebase.instructionFormat:
> 
>     $ git config rebase.instructionFormat "%an (%ad): %s"

I had totally forgotten we added this option. When I went to look at its
documentation, I found the formatting a bit funny. This should fix it.

-- >8 --
Subject: [PATCH] doc: fix missing "::" in config list

The rebase.instructionFormat option is missing its "::" to
tell AsciiDoc that it's a list entry. As a result, the
option name gets lumped into the description in one big
paragraph.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27069ac03..a0ab66aae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2450,7 +2450,7 @@ rebase.missingCommitsCheck::
 	command in the todo-list.
 	Defaults to "ignore".
 
-rebase.instructionFormat
+rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for
 	the instruction list during an interactive rebase.  The format will automatically
 	have the long commit hash prepended to the format.
-- 
2.10.2.870.g7471999


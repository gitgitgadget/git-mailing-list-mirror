Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D109AC05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBKCoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKCoP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:44:15 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8252E823
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:44:14 -0800 (PST)
Received: (qmail 21919 invoked by uid 109); 11 Feb 2023 02:44:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:44:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30579 invoked by uid 111); 11 Feb 2023 02:44:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:44:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:44:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/2] doc/ls-remote: cosmetic cleanups for examples
Message-ID: <Y+cA/b8QPc7/4+NU@coredump.intra.peff.net>
References: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are effectively three example commands and their output, but
they're smushed together with no extra whitespace. Let's add some blank
lines to make them more readable.

Likewise, the first example uses "./." to refer to the path of the
current repository, which is somewhat distracting. That may have been
necessary back in 2005 when it was added, but we can just say "." these
days.

Signed-off-by: Jeff King <peff@peff.net>
---
This isn't strictly necessary here, but seems worth doing. I had
intended it as preparation for adding another example in patch 2, but I
ended up thinking that the text change was sufficient.

 Documentation/git-ls-remote.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 492e573856..f17567945f 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -95,15 +95,17 @@ EXAMPLES
 --------
 
 ----
-$ git ls-remote --tags ./.
+$ git ls-remote --tags .
 d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
 f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
 7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
 c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
+
 $ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
+
 $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
 $ git ls-remote --tags korg v\*
 d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-- 
2.39.1.795.g4b3688ded9


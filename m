Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329CC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A314223C6
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="OdzH5rBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgJSVad (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:30:33 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:51780 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgJSVac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:30:32 -0400
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 8B534E381;
        Mon, 19 Oct 2020 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603143031;
        bh=7126HKzOVXoDhQeD6rcYiNiENzXxC8cujxFvFD/7yok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdzH5rBfHLJD5O5HyGxBA9ILxw1ZoZibZAM/KlPZ4++WnYE2cFc2tu8Yf6AN2MDmK
         Mc1rmfzpCW6xxn5jTlZZFBDHTbxhYhhvr0w3koKsxUxaN2KBeJhEZbiyR5eLyVq0eJ
         GxISSnots1VcxlFdOdv52Z0mkAuxlBkxBVXUcmGzsArsvpcOPziQIeLQUqGlwJpn9n
         1emqbL/BZ+qlxy9Bw6AZAfLQ4HUq7LJKMbpteg24+06sGtsXyHavLjbmsS50rIqmMP
         iQvolqWsVwjl4egR31S/wmhW8qQP8LKvtHwYC5NRbuCexFqLZbEl7QVkqHTHGmLV/I
         0nlenejSY6ZIw==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] Documentation: clarify and expand description of --signoff
Date:   Mon, 19 Oct 2020 14:25:42 -0700
Message-Id: <efec40f9432bfba531b4a6c9aed50d8f5e1aec13.1603142543.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603142543.git.bkuhn@sfconservancy.org>
References: <xmqqmu0it6ls.fsf@gitster.c.googlers.com> <cover.1603142543.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building on past documentation improvements in Commit
b2c150d3aa (Expand documentation describing --signoff, 2016-01-05),
further clarify that any project using Git may and often does set its
own policy.

However, leave intact reference to the Linux DCO, which Git also
uses.  It is reasonable for Git to advocate for its own Signed-off-by
methodology in its documentation, as long as the documentation
remains respectful that YMMV and other projects may well have very
different contributor representations tied to Signed-off-by.

Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-commit.txt    | 13 ++++++++-----
 Documentation/merge-options.txt | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..93bbae4ded 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -166,11 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	log message.  The meaning of a signoff depends on the project to which
+	you're committing.  For example, it may certify that the committer has
+	the rights to submit the work under the project's license or agrees to
+	some contributor representation, such as a Developer Certificate of
+	Origin.  (See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to understand
+	how the signoffs are used in that project.
 
 -n::
 --no-verify::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..29e6030131 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -80,11 +80,14 @@ actual commits being merged.
 --signoff::
 --no-signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	log message.  The meaning of a signoff depends on the project to which
+	you're committing.  For example, it may certify that the committer has
+	the rights to submit the work under the project's license or agrees to
+	some contributor representation, such as a Developer Certificate of
+	Origin.  (See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to understand
+	how the signoffs are used in that project.
 +
 With --no-signoff do not add a Signed-off-by line.
 
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter


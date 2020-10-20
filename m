Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35FCC43467
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75404222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="CiROmH9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbgJTBGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgJTBGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:06:20 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348EC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:06:20 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id B0ECCE384;
        Tue, 20 Oct 2020 01:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603155980;
        bh=JF+r4ZTklBhCjfvJD3/OhsE83nyqpGofvUTRI7RoGtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiROmH9pqA5Xrd+2mfcsGsqgk30FnuzZiTm7AmG5RuDbInYc2SJXKK7f6rfWjj76J
         esK+RVt9Lf5h+GglzApUftCAE0w7JV6A6ysdg/X1U8tFq9lK8T9FcARaETJhdMI/MX
         xVR+rad8elfCHisF2kRC28OwKBDN18b7gG+NbiUd/2cuGs0JnKv8QRPv4e9VxRaw8Q
         dfOBYmqe+L78tkPyzrp2A9NkAhsrIUv3bnkcMOeQReax8DG2ZP2TiKNlvdwVbpwPZN
         1hTPNXOT7m8TeoydgUNyUB/IQCC8fFPQ3W2CvsQbQ4jJ3lwlRn3URHFh76iMo2sX56
         3zig2Tmkj0yQQ==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/4] Documentation: clarify and expand description of --signoff
Date:   Mon, 19 Oct 2020 18:03:53 -0700
Message-Id: <418d15c53268f947e11dac2f22d1f8c3c8c60997.1603155607.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603155607.git.bkuhn@sfconservancy.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com> <cover.1603155607.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building on past documentation improvements in b2c150d3aa (Expand
documentation describing --signoff, 2016-01-05), further clarify
that any project using Git may and often does set its own policy.

However, leave intact reference to the Linux DCO, which Git also
uses.  It is reasonable for Git to advocate for its own Signed-off-by
methodology in its documentation, as long as the documentation
remains respectful that YMMV and other projects may well have very
different contributor representations tied to Signed-off-by.

Signed-off-by: Bradley M. Kuhn <bkuhn@sfconservancy.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/signoff-option.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index d1c6713774..fbff8dd5be 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -3,12 +3,16 @@ ifdef::git-commit[]
 endif::git-commit[]
 --signoff::
 --no-signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
+	Add a Signed-off-by trailer by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project
+	to which you're committing.  For example, it may certify that
+	the committer has the rights to submit the work under the
+	project's license or agrees to some contributor representation,
+	such as a Developer Certificate of Origin.
+	(See http://developercertificate.org for the one used by the
+	Linux kernel and Git projects.)  Consult the documentation or
+	leadership of the project to which you're contributing to
+	understand how the signoffs are used in that project.
 +
 The --no-signoff option can be used to countermand an earlier --signoff
 option on the command line.
-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter


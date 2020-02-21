Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03481C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C64208CD
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgBUC4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:56:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:49974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729413AbgBUC4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 21:56:38 -0500
Received: (qmail 14741 invoked by uid 109); 21 Feb 2020 02:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 02:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15305 invoked by uid 111); 21 Feb 2020 03:05:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Feb 2020 22:05:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Feb 2020 21:56:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>
Subject: [PATCH] run-command.h: fix mis-indented struct member
Message-ID: <20200221025637.GA1277517@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An accidental conversion of a tab to 4 spaces snuck into 4c4066d95d
(run-command: move doc to run-command.h, 2019-11-17), messing up the
alignment when you have the project-recommended 8-width tabstops. Let's
revert that line.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.h b/run-command.h
index 592d9dc035..0f3cc73ab6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -116,7 +116,7 @@ struct child_process {
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
 	unsigned no_stderr:1;
-    unsigned git_cmd:1; /* if this is to be git sub-command */
+	unsigned git_cmd:1; /* if this is to be git sub-command */
 
 	/**
 	 * If the program cannot be found, the functions return -1 and set
-- 
2.25.1.795.gf56f34c505

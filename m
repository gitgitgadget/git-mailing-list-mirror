Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6306DC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921EF206A2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="snLyCg1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHFSxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 14:53:06 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA4C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 11:53:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596739984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIXkZ7iZsZ0+KMZgAOqrwnzPZe7PFz66drZawc++OQg=;
        b=snLyCg1ddVqr+H4gpO/bL60A6lEtYpRiuG3GJHoWRckFtliSUBLKxJMKaEN1XF0Q9iwwmU
        a2MihveUBuZBq+gk/wHCR+uffrFsTiHZOeL7d1Zf+wH6HAba1o0sx5pJiK3jPTqW1YizRv
        YDt1L32bSenU1YjBoPaRmCk7yafxVf8=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Noam Soloveichik <inoamsol@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH] blame-options.txt: document --first-parent option
Date:   Thu,  6 Aug 2020 14:52:43 -0400
Message-Id: <20200806185243.27179-1-ray@ameretat.dev>
In-Reply-To: <xmqq1rkjljus.fsf@gitster.c.googlers.com>
References: <xmqq1rkjljus.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

blame/annotate have supported --first-parent since commit 95a4fb0eac
("blame: handle --first-parent"). This adds a blurb on that option to
the documentation.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 Documentation/blame-options.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 5d122db6e9..88750af7ae 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -36,6 +36,12 @@ include::line-range-format.txt[]
 	START.  `git blame --reverse START` is taken as `git blame
 	--reverse START..HEAD` for convenience.
 
+--first-parent::
+	Follow only the first parent commit upon seeing a merge
+	commit. This option can be used to determine when a line
+	was introduced to a particular integration branch, rather
+	than when it was introduced to the history overall.
+
 -p::
 --porcelain::
 	Show in a format designed for machine consumption.
-- 
2.28.0


Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D9C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE68B20729
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="XjZgQRYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHJLEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgHJLEb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 07:04:31 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883CC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 04:04:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597057468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zo4iWlBKBp3VPXvLfaG34BYI364W2ReIGdl4zt0owuk=;
        b=XjZgQRYNt7rf5exvY0tmCQFqusV/JuiZjNvRy2a+MeGJB0lPCVnrjrkNjAtp8cN0P0g4D7
        rLfMC6iE4R4BonUZnQmhrIfDeDByz1hXG4D4hDnKUYpFI5IYPO8J/6JZDbd9TNUQLqyeTn
        0dhRPRRKb7KzK+ZCorRyeFt15VrOD9k=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH] git-apply.txt: correct description of --cached
Date:   Mon, 10 Aug 2020 07:03:38 -0400
Message-Id: <20200810110338.52203-1-ray@ameretat.dev>
In-Reply-To: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
References: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The blurb for "--cached" says it implies "--index", but in reality
"--cached" and "--index" are distinct modes with different behavior.

Remove the sentence "This implies `--index`." to make the description
accurate.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 Documentation/git-apply.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b9aa39000f..373a9354b5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -72,7 +72,7 @@ OPTIONS
 --cached::
 	Apply a patch without touching the working tree. Instead take the
 	cached data, apply the patch, and store the result in the index
-	without using the working tree. This implies `--index`.
+	without using the working tree.
 
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
-- 
2.28.0.10.gc1c9059842


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E19E75434
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbjJCI2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjJCI2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:28:00 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF9B7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyJn+JFuAmnNdt8nzCFIwLmvxSkUqXcw/M6fV+/TJkM=;
        b=OwbLKuWNVSZpTSBAO0oG1HYGkqlcIhnmb5a95km9DA2kEtEPdcB0zuWlEip39w/k4cZwOJ
        SPXFA5P9RoKNmUbdT9tPxJeKLDfHht491gimMqzdVuejqpcEf6YZKCgpgKiVG//tRr2cvQ
        Lwc/f41lJ9PMQyhzz4Pbg4re5xcB1K5z3Nat4piV+4CbMto/InSoctKoA3aVBGYhGy5bd2
        Fu1oFNPk7IaXLA+vzxNOXoe+4fn38rOWc35rjNXZCcIrh7d0aFl+TdAoa40j4XcwobH/TP
        uuPlz9enWURm+WpbFOpE3FyXUjT28R75kKYN7SMBJ5nOf6ad9CfR8q6bYhcbdw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 43b165bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:21:10 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] git-jump: admit to passing merge mode args to ls-files
Date:   Tue,  3 Oct 2023 10:21:05 +0200
Message-ID: <20231003082107.3002173-3-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003082107.3002173-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's even an example of such usage in the README.

Fixes: 67ba13e5a4b2 ("git-jump: pass "merge" arguments to ls-files")
Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 contrib/git-jump/git-jump | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 40c4b0d11107..47e0c557e63f 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -9,7 +9,7 @@ The <mode> parameter is one of:
 
 diff: elements are diff hunks. Arguments are given to diff.
 
-merge: elements are merge conflicts. Arguments are ignored.
+merge: elements are merge conflicts. Arguments are given to ls-files -u.
 
 grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
-- 
2.42.0


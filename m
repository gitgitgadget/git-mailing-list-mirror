Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091FC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37FD6101C
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhKJJmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhKJJmg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 04:42:36 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD77C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 01:39:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t11so1564414qtw.3
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnbtR69PuXwiRxEdPh+RWuUIxiB8+vSJt9/Lk7pjSME=;
        b=iINKmb4k0ADAkTXYzE9T/bFlEzlmU4MMc+eZZQQv963JSiptGT4bi82YiUYOWkxGAo
         uNv5NLW0ZH+obW0565OLtTqgedAOOWSbTonU+DQaBO9jDUwgIQbo89nTWvcMtR6WSJua
         hVdOWVjGgA+RqFNO4QUB1ZW7OKrsJEAxdqcYT94jCRJ8KagPRhGKmW79G7/nRa2KwqXw
         BtX1OaboRfUnn3COxrR5A2kvczq1qkZsCygxHsmioLXmk0pcaHUTljdTAT8mmaH3ep7J
         /GXLb7Wef9hzmkFnRdtz9FtNPBKAPhdJJFeETuUd8j+DTL1XsSfkho6GPSA3MvSBHc79
         WBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnbtR69PuXwiRxEdPh+RWuUIxiB8+vSJt9/Lk7pjSME=;
        b=mPEMV2Fy9fliqBUUQ1zK61US9zu0/uIqBD43FNiaXe1L19UO/rvFyzaxqDG5HIsDIm
         k4JEV0wKaaaJyC5Ee0QuDe7qz3gmJoRQoYwFc92sLYPDdJin9DvNoftnGuWxYLv8lhJh
         j5Z2nfjgdkfrzhQPR6YjYgzsnwQVZxjMQwV9aDkOVMRWS0AgteSlmLgDM11pcDD7SA76
         4syNAOYQs/jiI9xPXITZIfCQIDq/4tIFoy85iv7Rk5HFutf5jI3pFaj2stLp+ZeJbvsC
         CL5nuqR4iDMUlg9VcdOUItUASCCMqxDr0DQ9mblk7SZBMyjr3UbZsGnmCiWYakDtTibe
         HqVg==
X-Gm-Message-State: AOAM532q/yGceGd1AmZAPQ43M+hRvrX6JKVq/Bi7j1pnFjS9Wo06YZal
        2aSCGCGb18Z492w0SfvMq4GRMA3l0/k=
X-Google-Smtp-Source: ABdhPJwkm4V/f4c2rDqc/isW8fbxHrTtLhHWsvF2Pe3VCBdY77+DY92UMksTC7OhQmUBdFNCm5VPOA==
X-Received: by 2002:a05:622a:ca:: with SMTP id p10mr5981118qtw.89.1636537187904;
        Wed, 10 Nov 2021 01:39:47 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j8sm4373209qko.85.2021.11.10.01.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 01:39:47 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, fs@gigacodes.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] RelNotes: mention known crasher when ssh signing with OpenSSH 8.7
Date:   Wed, 10 Nov 2021 01:39:12 -0800
Message-Id: <20211110093912.4382-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.349.g8f33748433
In-Reply-To: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
References: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed[1] earlier, make sure there are no surprises when ssh-keygen
crashes on some users of OpenSSH 8.7 that are trying ssh signing.

[1] https://lore.kernel.org/git/xmqqsfycs21q.fsf@gitster.g/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/RelNotes/2.34.0.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes/2.34.0.txt
index effab2ea4b..54dcc7240d 100644
--- a/Documentation/RelNotes/2.34.0.txt
+++ b/Documentation/RelNotes/2.34.0.txt
@@ -8,6 +8,9 @@ Backward compatibility notes
 
  * The "--preserve-merges" option of "git rebase" has been removed.
 
+ * The upcoming ssh signing feature is broken if used together with
+   OpenSSH 8.7, avoid using it if you cannot update to OpenSSH 8.8
+   (or stay at 8.6)
 
 UI, Workflows & Features
 
-- 
2.34.0.rc1.349.g8f33748433


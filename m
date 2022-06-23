Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF0C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiFWTbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiFWTbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:31:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5260F32
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 12:02:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b125so100958qkg.11
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TRfYRxJGycfLcDEMYak8wpmZ/YgHnMUk9p5RKcAkeSg=;
        b=r6mONcfJTkQH6+quuNldmXSLqLZVFrY1o2FknBUSAkuQua97p1SGb+keZ0J4/fOZby
         /k4A4BrIIHqFrWtnAgEtKcJdOjGY6GRdgnuRhF18aEDYtXoeHdm4r8wqjVw6mtAG5ye3
         q3y3r7qXskappyT8n3XE67XgtxV5tcbMR7x02BV9/pooodt+0oR//+eJNx2MxjL09ZUK
         MxQDyfRQh6Q5Iowsq9/rv9zYYHpuV89333eBjO7lUz45DFiOH6ed7bMkilt127twngcO
         4b9sUiCupMSuUF5hnH4mlCFB6oq4mV7+6lvghFtdtqh56R6DBELMhbBFAgkhrbqRSVv9
         4m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TRfYRxJGycfLcDEMYak8wpmZ/YgHnMUk9p5RKcAkeSg=;
        b=1IGDOOyl85QiOzHYLkp4F2wWhgFM1isb9QwalTE5xQDujV3oglF3ESrIMiQoFyj6MF
         PMtftTS0ITMmnl0fHWy878u6WEOP6ATogO0D5QrEj6xDxP2GIyIdz/YAEhHrndjr4KlE
         3YqNM0WQNo3/LpdHTLoadNXR4qGqcbJy8xDTv3l4IXegZJ3+n41RoXqG/P4Y+G1ccqiI
         iNruiDLhduAMAC06ujwHHEwCkllJEY2oH8pltcZtmIG/SbuJLMAMrzMZAREFh+OelVTb
         i3e/rjeBXQocLpkGL207QPDq1hAEzd1Skv4MhPZWB78vy2YDd7lNaYsnmQ0UsQNNKnOg
         v8bQ==
X-Gm-Message-State: AJIora9VyArKhhCirYnRLLOaZpOIQSV4PL8WWUZpbUBkt7sRvt7L6bYq
        li/NSeYEKZIueN5TO9btvEeBtMdxymx3Gx5V
X-Google-Smtp-Source: AGRyM1sf18rxZZsI/RtdkricQT+fO7GHK6xBO5gMwT/GTmomJ5eKMM43VmpOT8Se1GCsC61jsyTiBw==
X-Received: by 2002:ae9:ea16:0:b0:6ae:eb1f:38ab with SMTP id f22-20020ae9ea16000000b006aeeb1f38abmr4346310qkg.719.1656010923039;
        Thu, 23 Jun 2022 12:02:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b006a79aa0c8b1sm206445qkp.113.2022.06.23.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 12:02:02 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:02:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH] Documentation/config/transfer.txt: fix typo
Message-ID: <68c1c3648c51f6298eea4d58286b20e0c770a270.1656010900.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 7281c196b1 (transfer doc: move fetch.credentialsInUrl to
"transfer" config namespace, 2022-06-15) propagates a typo from
6dcbdc0d66 (remote: create fetch.credentialsInUrl config, 2022-06-06),
where "other" is misspelled as "oher". Fix the typo accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while skimming the new documentation for the upcoming 2.37
release.

 Documentation/config/transfer.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index b4475c0690..7ed917f5fc 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -20,7 +20,7 @@ exposure, e.g. because:
   in other ways, e.g. a backup process might copy the data to another
   system.
 * The git programs will pass the full URL to one another as arguments
-  on the command-line, meaning the credentials will be exposed to oher
+  on the command-line, meaning the credentials will be exposed to other
   users on OS's or systems that allow other users to see the full
   process list of other users. On linux the "hidepid" setting
   documented in procfs(5) allows for configuring this behavior.
--
2.35.1

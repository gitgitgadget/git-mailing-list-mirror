Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE20120986
	for <e@80x24.org>; Thu,  6 Oct 2016 08:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbcJFIte (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 04:49:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34725 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965610AbcJFItb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 04:49:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id b201so2387375wmb.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8IaCCQy0zF6xz6mvvuYqPASJNKcWsoIUWE6Q6e+jH0=;
        b=ksAXI3or9cFx6J0fBkCWQ/9o8EMm8aRwVkZdjRSKLr18+lJcU9k4s40Xf0Nbw4KQ6D
         RSfKcyqhXGLVrchQZWms02iHCHstgBsc3uFZzmUQeZetlTnEFd84MTYKyKGGgohcis4F
         TjNYx+49S+3c/2tOC/mi3Ft5YoarMD/oRsDjCDVM/aC9SuYP5dFQyOPKNzBdMBqS6AA7
         pNmDGKJ8UgkJJfrA/w23cM/YhHdz/pjRxTqo3fJs/whtr6T6xuObq89qWFfNv+spiQ3p
         bHHAa1adFaTgb+psggVZuEuKf0Ran4poATBqYHEF4P2zbbkmzxQO+Em/Hfa+7nDShR/E
         8dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8IaCCQy0zF6xz6mvvuYqPASJNKcWsoIUWE6Q6e+jH0=;
        b=FYu9RaCfUcsSSnTVmohcJEelehbEvYSDoBsMm+XNp1zp9QBdPgud8Qgt/UHouY1Yx3
         UFxuvSMbWMCrOuYQECDQzYqWZjyjXcJPMrMsvXZRU0nyIikEerwftHlpJVd+ZBvElQ2+
         oxpUZLH5Imnwc9ojO1lzX31MRqztn5eAPKVU1lmoz+jse/BjoKWpauAksqPortumEvX/
         4s6FRQHK7EsU0rxrBwMHklrvMcbXmtEY00ZvygyEumqJuenNPuHyTAllGdOr4ggvBxoV
         ipnxrqYaHbDXpL8tWzFhL4lzNj0ceomX8kXPKQp1aH1UoNCLo7Owrfe6R5DD3WG7wJXV
         3mLw==
X-Gm-Message-State: AA6/9RmTRSP1I2QdoVBgrax8n2Bmrrpkag/ygcAi4vv41W2nftjsMrPGPuH1/hp6qetSUA==
X-Received: by 10.28.175.204 with SMTP id y195mr3606457wme.92.1475743769342;
        Thu, 06 Oct 2016 01:49:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id jt8sm8889769wjc.33.2016.10.06.01.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 01:49:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] push: Re-include "push.default=tracking" in the documentation
Date:   Thu,  6 Oct 2016 08:49:05 +0000
Message-Id: <20161006084905.14944-1-avarab@gmail.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation for push.tracking=* to re-include a mention
of what "tracking" does.

The "tracking" option was renamed to "upstream" back in
53c4031 ("push.default: Rename 'tracking' to 'upstream'", 2011-02-16),
this section was then subsequently rewritten in 87a70e4 ("config doc:
rewrite push.default section", 2013-06-19) to remove any mention of
"tracking".

Maybe we should just warn or die nowadays if this option is in the
config, but I had some old config of mine use this option, I'd
forgotten that it was a synonym, and nothing in git's documentation
mentioned that.

That's bad, either we shouldn't support it at all, or we should
document what it does. This patch does the latter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 32f065c..f30d52a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2344,6 +2344,10 @@ push.default::
   pushing to the same repository you would normally pull from
   (i.e. central workflow).
 
+* `tracking` - Deprecated synonym for `upstream`, which we still
+  support for backwards compatibility with existing configuration
+  files.
+
 * `simple` - in centralized workflow, work like `upstream` with an
   added safety to refuse to push if the upstream branch's name is
   different from the local one.
-- 
2.9.3


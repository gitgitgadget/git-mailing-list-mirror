Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E431F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbdBCCuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:50:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35039 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCtV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so1169805wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DVTF3zH68doFNmc94RNIY/z8CsRmqD7dYQFPr+rqsc=;
        b=NWfEJeGgyMcve4NLzwkiLx62FZFQUabA+2JvXD1Z4trz1CedDFKHyCDsFn9pXC/5d8
         4YDDTymiiJm9CyZrZCxPye71vZsblvZncUSjST9Pyn9uHH+JxRHq+lhzQ7O0+Sg1kEvB
         gYbHBnMvssoj/XQfa/dl/wkYT1IbC0v2O2WhAAqNpZzaDk77JQNHl6E7MxjdUzLqNha4
         UOqRkHbtbpBYPoMowJ8CePrkGkkMohhq8ThQ3tRhXT5E4SZgf3q6b5rmLORMrXiXc5Je
         LJi2n49WVGabv4a7u3qCoHcF+7S08M1xG86GJRAJOTN/1CtnLaukJ1ZdJbSXx7QoLb3N
         BS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DVTF3zH68doFNmc94RNIY/z8CsRmqD7dYQFPr+rqsc=;
        b=heozP7Ju3BsKra4PuT2rj2JlKtuM3FZGALADGGnGCkk1Gkpl+yHBRJq083e+pnEVM7
         PJ4ReuNze1ZXhlEy30PRxwZjLuE2jYLhZP02lgs2zxtIgS/NEaChpiew5j/RilASUqVW
         yUOiq/TR9iyzJGMqsaO/0Av9AvqgrSiI2XdWzjrlCmdmtBhPTos9VmDpuemlHHTgplUr
         zgrLKndJU+wXhAADnwJc9j1VG2qEDE56alo5QtHy0kWydIzUmeTE43TkTbSfrioNazw9
         W9gJpK6dqQlHoIGYb6luAs5dhZ2W95i5ScfpQ09K8K5aQS66nYzDQfTpHvvkYlsy/N4Y
         N5/g==
X-Gm-Message-State: AMke39msYznbX63u9RRVLKDsLJkD9/dySpewOzvB7jqpsH7pO6juPoM+sFhiutLtNGGJKA==
X-Received: by 10.28.137.211 with SMTP id l202mr420412wmd.88.1486090154781;
        Thu, 02 Feb 2017 18:49:14 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 01/21] completion: improve __git_refs()'s in-code documentation
Date:   Fri,  3 Feb 2017 03:48:09 +0100
Message-Id: <20170203024829.8071-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That "first argument is passed to __gitdir()" statement in particular
is not really helpful, and after this series it won't be the case
anyway.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff80f..ee6fb2259 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,9 +332,11 @@ __git_tags ()
 	fi
 }
 
-# __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
-# presence of 2nd argument means use the guess heuristic employed
-# by checkout for tracking branches
+# Lists refs from the local (by default) or from a remote repository.
+# It accepts 0, 1 or 2 arguments:
+# 1: The remote to list refs from (optional; ignored, if set but empty).
+# 2: In addition to local refs, list unique branches from refs/remotes/ for
+#    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 __git_refs ()
 {
 	local i hash dir="$(__gitdir "${1-}")" track="${2-}"
-- 
2.11.0.555.g967c1bcb3


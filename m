Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259BC19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiHFS6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFS6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 14:58:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD25101D3
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 11:58:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m22-20020a0568301e7600b006369227f745so3948217otr.7
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IBcOn+G3YPul5GqyA5mRT74uDE24OIkzdy5/lIBky8o=;
        b=lBOD0yqXTPmrExnDV07L2qJn9EFaB3Cw1koKh/m9l2ZxHw3U9xdqaycQW1hVCK+QqR
         UeH4MfhICeuux777iLZBxN6gG5Axn20XbDGeS380wQ2xoMXdsUF8vSpPezt+dITYwtDd
         pVBnrsYS6ox7yeXfeTu1yZFzEEBaiypCXOR+dnDHTrjIwMW3Mjazo3g93UvJ/vO8XVIW
         nLNKcXD2J6wcHkzDToFHXmiiwDOZfOgu7XsVLHkvNE+qIYAKy8ShzP7MUhbUby+Fay3/
         pir/piEkxEMlx+1aA5nF47WW+T87J4/tOvhWjqjo/xHl9yPgJ6weAMj2lsWUXLFgGEtq
         9+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IBcOn+G3YPul5GqyA5mRT74uDE24OIkzdy5/lIBky8o=;
        b=saHH8GAFIqx3prfzlWZkXtJKjFaGTAKQS945z3K8MDdyCMlhUjv4IRE/kwNuAC7rsu
         v3YmWRJ5I9GRxRxu3dnkhBqfSZYWrEUfFsCMMlukh0Z7npuBwH4XKYMtLaIDH7+YikXX
         6v5WniBmCZfr0OysYBOKm96yx6niBkv8gUQmwD+f3rKrOMbwAkNd+LhSllaKnRrLQu/2
         jCk0LRqqYRmlG8P6wIn+4tVgVlZlAAo0JQQnmOg1IUdQL5PnaGCupiN2h58ZZtMBZs3e
         Rz/kEa4EjNghJsb/Zn95SuTnZNJZboHF2F6hfd3Y+DxxMWsiflNStpxQu3VwhQxbc0JL
         idGA==
X-Gm-Message-State: ACgBeo3E6owPKK+f3Ez4HW6j0BWQOhkX+RfrbVbH3VdqQ0Rgxr7Ru2NZ
        OWF0SDbFsDO+BUCmrsORRF4ylTs0CgY=
X-Google-Smtp-Source: AA6agR6Drp5SrPTdZbXui3xvJl5du3ifrnp2xFbdpBjRPt362ntug1GvOc+AgC5c5xyM/yyfbkgDRQ==
X-Received: by 2002:a9d:7d16:0:b0:61c:a56e:3239 with SMTP id v22-20020a9d7d16000000b0061ca56e3239mr4689267otn.150.1659812310819;
        Sat, 06 Aug 2022 11:58:30 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m34-20020a4a9525000000b00441c26f8fadsm1315569ooi.12.2022.08.06.11.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 11:58:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] mergetools: vimdiff: fix comment
Date:   Sat,  6 Aug 2022 13:58:29 -0500
Message-Id: <20220806185829.14080-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.377.g679aad9e82.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the variable is wrong, and it can be set to anything, like
1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..ea416adcaa 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,8 +29,8 @@
 ################################################################################
 
 debug_print () {
-	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
-	# to "true"
+	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF_DEBUG
+	# is set.
 
 	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
 	then
-- 
2.37.1.377.g679aad9e82.dirty


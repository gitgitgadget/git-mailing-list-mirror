Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D38C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 09:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353283AbiASJsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353278AbiASJsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1104C061786
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:48:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso5879743pjh.0
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvQ4uVSONiQeQrpLaoUL4jMOuEOoVTl06xuQNBCKbzo=;
        b=Sevdgg4hWGgFmShr13fZVlCKwi3n2VwberJc02f9JmFiqUzp7jLFHdrE2t2KNRTYHr
         tThU4mYaTtrmp94hhAF9DccIM7rANsZMhQwpsqfrqg4VN9VLEgVnrcg9zHXtBq4wa5vN
         fn8t9Dkyw9Yb1qBrO8bmhcU9DM3/CkjeHZwS1oK85HeFKvDTgFZwu6Qhx9GQ1mwJPoGN
         Ht1ytveb00MQmAI/FRdRFywcldlJdZiCarW1vpvSV2Sj07DGZ5pxnwHfgryDZHd7ygKx
         ZM9dF8eOjwEYzzrJZrKFx5u/8IEL6s3zTwgUHHU/Ro/eEwATiWB70iG5HKI8HvRdGWyf
         xkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvQ4uVSONiQeQrpLaoUL4jMOuEOoVTl06xuQNBCKbzo=;
        b=jtyLjJPlp77ImUZm7BCWN8i+H3Fb+F8wrhAhlD1fnEUNPN0f5aIjEld9iumokp3oLK
         4uT7OIhgiiK31HjFkkos8abShj5zeQD12TL+pmpgOUBaZeIrxhDSS8yxuEZCvPvvrUIv
         cVidUL9maPxGh+WLs46CJAmuWAE05PCvtps6Y0djRYP+/qIPMjJQZhgIUutj6TVpUbIK
         E+ufh8rkW5uMk93wSUv90ts057xUrLWKTh6Jiukglay4XGz0peb5PZWThLUPTLLV/tTM
         kZ38vsr3sqFUHsJJOg60Babuh1ahfm88PaqZV8qOTZ1Gse7OGps0c5zTFcxECZ7UDt0P
         mmNA==
X-Gm-Message-State: AOAM533MeH52EmsNAGeQCaiYUxdCLg1CDsqQe/Ed1yghppgLzjMpadnF
        AuJGvssLdsJOyPRZnjDRoKBQw/yumO0=
X-Google-Smtp-Source: ABdhPJy0Sbb3JqAyMka79Kzg+LOyUcgR6vwqmAHENyJqQrjJnRnRAgqrf5BY+e+I9fcpadKdxG9v6w==
X-Received: by 2002:a17:90a:5e0d:: with SMTP id w13mr3269659pjf.235.1642585685092;
        Wed, 19 Jan 2022 01:48:05 -0800 (PST)
Received: from ubuntu.mate (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id nn6sm5585041pjb.51.2022.01.19.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:48:04 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] sequencer: use proper sentence grammar in the first sentence of staged change advice
Date:   Wed, 19 Jan 2022 16:47:41 +0700
Message-Id: <20220119094740.16001-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use sentence case and terminate the first sentence with full stop.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6abd72160c..bb1576336f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -936,7 +936,7 @@ static const char *author_date_from_env_array(const struct strvec *env)
 }
 
 static const char staged_changes_advice[] =
-N_("you have staged changes in your working tree\n"
+N_("You have staged changes in your working tree.\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
 "\n"
 "  git commit --amend %s\n"

base-commit: df3c41adeb212432c53d93ce6ace5d5374dc6e11
-- 
An old man doll... just what I always wanted! - Clara


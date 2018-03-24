Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B92C1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeCXUiM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39611 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeCXUiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id p142-v6so22920551lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4US2AJUDmlmTzf46947BoEDKGQOSoMEuWKC/kXA3/v4=;
        b=rmAPaoJPLCUC1jEa0u0qGbpCslUBZ25iZR13dht58MD895Kv6k3kuzzZLF/eTX67Xd
         hr2Cg0yoYv0vawdckUwQZ8KWhNY6WmZJqutaWH/JiFkkUFXr3iaCWElPESNu1FBaY9G7
         X6p8pg4pRs9EZpajVRQFFoEfEzikHkXlbpMm4gxQhn8aFRx5VqOm/ACzxCzBCAN7tOz8
         YcUMOlbUNs8k4ky+/nsrocV5iiuw51TQ4PizzRknolb+/ubo8SHzEVVhK3F6HfowY1mO
         FBBlJeDdNmWW9MR0OafjrEbLRxXw5lOY+fRAeYY6MhZkmm/f4rcSoFGBuuGQXGsh1dF6
         BOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4US2AJUDmlmTzf46947BoEDKGQOSoMEuWKC/kXA3/v4=;
        b=CsR7YspkXIdKoBMNj/sYK1wLiSNmf34aoWb3uBCUbRb4kkSXCg+KO0op7ITVy5JErF
         23F+KOpe8JfVE01BipkYDLvWsmIZ/kGw56wGk37I4TmV77GRolAc72Yuvqhe3QV3cOHP
         +KfzzCJYM/ToLKAVlDr6n7QrQHEvNyIihtrOdj0k5m9xc4lTDTXP3Yc7xbFiODZBHL6A
         yY1k8G8ekZN7VxMs+FNOse8y+5D3FOtUSiyur8Ki0iF151DqBC87/T5HE30uscztjeJg
         CTq9EHumXLuF7sCqAGEdQPNDDJX7LKNOVnkofyqXj8ZWgsniptG+PZIkMFUzmxHqsPUB
         c5kA==
X-Gm-Message-State: AElRT7FWiT8xeDx1BbQjn3qtudVlFcCkZj2apw5xK8RAcpglYP/xFfMf
        Y2bRO8YBVqwCU4i655jFzws=
X-Google-Smtp-Source: AG47ELuAuwmQfQzM/j2qB+I4q1FN+dnZTMghms291oxBSmjHFjs4fdIdTCpNjJZsLBXthcyxFjZV0w==
X-Received: by 10.46.153.86 with SMTP id r22mr3249112ljj.104.1521923887886;
        Sat, 24 Mar 2018 13:38:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] completion: mention the oldest version we need to support
Date:   Sat, 24 Mar 2018 21:35:20 +0100
Message-Id: <20180324203525.24159-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more of a note for git-completion.bash contributors, not
users. The bash version is from MacOS [1]. Most Linux distros should
be 4.x at this point.

[1] https://public-inbox.org/git/%3CCAPig+cQXT1ov4MjzSzqiLBzr4wN1XcP7aSxMP+_dhtWtYwhDAA@mail.gmail.com%3E/

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7957f0a90..9bef457792 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -29,6 +29,8 @@
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
 #
+# Compatible with bash 3.2.57.
+#
 # You can set the following environment variables to influence the behavior of
 # the completion routines:
 #
-- 
2.17.0.rc0.348.gd5a49e0b6f


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BE020D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFAVly (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:41:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36651 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFAVlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id h4so5248406lfj.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0SnCcNemuEzWn0POqY84+CdjfORHq2g/f+vqbKZUG8=;
        b=arWbHWa8PqC81Eqrby75U0vzO7kT2ChODpvtxKsFHb6RHIdb869SzviZLdOM+ZJkKi
         0vFiss+in1RqPsVtCaT/fYl9q+wfdWEoBhP6AOmEHMDQ0bsMQNnm2EbKWRxyLhku7Lrw
         Wt9m9rkKK1T7L+40LydOQ0sn62b5Z2OAa7CJ68LmA5BrMOXqFOh1L1xl1ughzOlcha38
         6nDR6SVGJyEj6fq4ZYO0eokzMMUt5Fe2FZZ5reixyGcqoBZlaWnhBPmYWEJSpCZVA37b
         vN0E6CD8pPgwhO/Y9fEzDIJYbpwsUE/Svj7oBUkVwS9c62zJXpeScyJFW4ACWxnkG21W
         7izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y0SnCcNemuEzWn0POqY84+CdjfORHq2g/f+vqbKZUG8=;
        b=X2IxcJPXljUntCJQPqznQZDYlNXVt5bYFMB5eZ7HAf+/Gvqc+leXowrHASK8/SLFHT
         38Zd3cKTmrG938y1ypViHMq/wCsUnMn79zUovNvOImpjKxnDDpZcFZb5cc1J7yzbppv3
         2u17knFwNMW2XE12mvoctE5nhG2AKrRH28s49plhIUXbP5iQh7HWrYSv3xdJttI4Vkc4
         NGyNart6ozgXpTCxVZbdneArjdmNMhEon631Vk9gdyG2mStbZIBiLFD+81kT2GqG79CR
         kviYXUxxOmonXzS/PGZgCa41ui/EuKtgUN4nTkwSqvhyZZhYv48XYI4/IuyBLqyW3jIB
         6pTw==
X-Gm-Message-State: AODbwcCH9zglaQzh8YiQ/OhUk7zp9I8CGdfpdPd1hC9qRd/a+SC7I8sL
        tYUYYZFMcpWVo7Th0Ok=
X-Received: by 10.46.8.18 with SMTP id 18mr1247174lji.90.1496353308543;
        Thu, 01 Jun 2017 14:41:48 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:47 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/6] completion: Add git config am.threeWay completion
Date:   Sat, 27 May 2017 08:25:49 +0200
Message-Id: <20170527062552.13996-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index de9306173..3a630a230 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2344,6 +2344,7 @@ _git_config ()
 		advice.statusHints
 		alias.
 		am.keepcr
+		am.threeWay
 		apply.ignorewhitespace
 		apply.whitespace
 		branch.autosetupmerge
-- 
2.13.0


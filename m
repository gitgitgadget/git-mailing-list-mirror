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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6BC20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdFAVmG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:42:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33365 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAVmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:42:04 -0400
Received: by mail-lf0-f66.google.com with SMTP id u62so3030911lfg.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haItR+T8GJQz5a7bsjCCASDg0fnM5ZlXrS5EkOd+oUg=;
        b=DbxxIyO4OuGNoD6XKRBTJ8gg37wsO+VSbbJw4nPY+eDLjolWW8Lc388ybt8q1OuR0+
         MF0MPjgVxgyXOFfD/YP/Q7ReIZ5vWRwftcLF+lITB7hMMpWDffIjQSVDwDBm71j9k/rV
         75VY7+sdcMde8jqlT1LQX8UG1Zy2NW06Udl0nkKG5Ki0wMlUT5OumEBRqxf/uTwrzEQo
         VovC0KmnzMcrgg8ZxgllQLZRU7LwvCNw2kDEBpwWhcw2j2YTRoU0SOLigXSOrllPFmFk
         KHUHM3WioJ641Mny8uu8rA5vzqEmI24JviUy0j4RQsWYDzSeehp8joPQc/UEmSkjSpGn
         pdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=haItR+T8GJQz5a7bsjCCASDg0fnM5ZlXrS5EkOd+oUg=;
        b=VnOrVSpzlObdWr/RuO+sLgOUABnwKpwvpVDyKiKKrs8+e5UJy9PbEcaQKdzs5jE45j
         LIoID0FrwpHkEkldHelvFxJSBjiQfBp8ilk2QpYWJxBD2nqEvQbeTqV+8r1oE2fW99y6
         6+MXqvP/NE107d8lPBaE1RiMZDrlfmWbrs63LdazbFXXNQ/KoHwJc+xRwBuk7jlP9tXq
         h6nJVhw+NYoFiMKIbUzOeJ/aXRxTDuqUNGjCnzTDzAVI8eTf1pYD0Y+3traHUWox0xPh
         dFsMQB0YtsV8LERjAjbHEzVHSpe+HVJFNbx4nJuOevAo316FC7RmjyfTnJL5S0bZ5bGt
         ly7w==
X-Gm-Message-State: AODbwcAj+TOKVIIph+p+bQOQJGQ4SNKNX6o5M9ukl5VtnhV6Qiy8I44J
        duc9QAZf4f38T5Oza70=
X-Received: by 10.46.87.78 with SMTP id r14mr1265165ljd.114.1496353312134;
        Thu, 01 Jun 2017 14:41:52 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:51 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 6/6] completion: Add git config credentialCache.ignoreSIGHUP
Date:   Sat, 27 May 2017 08:25:52 +0200
Message-Id: <20170527062552.13996-7-rikard.falkeborn@gmail.com>
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
index 98f3e76ee..6de0dda6c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2455,6 +2455,7 @@ _git_config ()
 		credential.helper
 		credential.useHttpPath
 		credential.username
+		credentialCache.ignoreSIGHUP
 		diff.autorefreshindex
 		diff.external
 		diff.ignoreSubmodules
-- 
2.13.0


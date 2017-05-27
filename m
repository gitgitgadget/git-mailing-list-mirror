Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579A220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdFAVmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:42:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33355 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAVlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id u62so3030847lfg.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LmGp7xxgNZfxhXX9r6GenbWtwuqWJfoiFVVKF4mxp/k=;
        b=YUnJ1aJ7Y9qWGwpaiodfbMVQUOQl5zlaoqrWg0qvvhbMvycYT+s6P+/m+h6jbzofa/
         AoWh7e/t0+Qce5iCUB419v5w+b/AzSScnHl4Ie7d4D4sEyAA2Xpa9LHOtAw41Uo6SNzR
         hNyZip2rjK677pbFJMYJuk9oUh8WRPwtNgclznKOo9gTMaTYAi6cS2BXq1JvDOXuHAtL
         neFJYgWjDL+pQin8ng6W7kaYRYvcDnoVG0N+zC9H57IdEJqder50bBphr7kOiL3Fb4JD
         Z4u69nxnQDhHzu+VkTrb25eXItK+3yxPVzv0T/bU1WMBWZHCBftcVev2VN32Nef7InDI
         miPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LmGp7xxgNZfxhXX9r6GenbWtwuqWJfoiFVVKF4mxp/k=;
        b=p9doNYA/EfTQsI5Qtqdurp+krIPYiOgkzCx6GOlNrMJY/eJ0kxP0lfz7hx0RuDC5+B
         zyyOPdBei1rOgvRjalKuw0UzllwLthEVvtQcYxUvXHifVhFX0KIt6L9tzgIPHLXLeVTb
         H1ggcDMt08Dv3GaoIr8NX13npW1exFSanIQx9GkmJg2GrKm1UFHe5IblZEjfvF418nRN
         zJSSog+2skxZGuR00l0Gi+GduqcRXtSFWeMkf1Ap95FRDW8E8phJaH6oNxeOfZVbHokC
         pl/fSbcV6csuCf3NDMZWVU7Oqd+NCeLEKBQqwGehyGe0oWjNvod5GvsZV8k2c+8U2cBg
         cWJw==
X-Gm-Message-State: AODbwcAw+ifciel3OmawMgZtFZMiVKwBeWVrMQjfylewcRI8c0tpyvLv
        nvijNv6ibgSry9zdxNc=
X-Received: by 10.46.33.146 with SMTP id h18mr1177763lji.86.1496353311042;
        Thu, 01 Jun 2017 14:41:51 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:50 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/6] completion: Add git config credential completions
Date:   Sat, 27 May 2017 08:25:51 +0200
Message-Id: <20170527062552.13996-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing completions for git config credential:

* credential.helper
* credential.useHttpPath
* credential.username

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7efcb2a79..98f3e76ee 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2452,6 +2452,9 @@ _git_config ()
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
+		credential.helper
+		credential.useHttpPath
+		credential.username
 		diff.autorefreshindex
 		diff.external
 		diff.ignoreSubmodules
-- 
2.13.0


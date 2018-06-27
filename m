Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3A21F516
	for <e@80x24.org>; Thu, 28 Jun 2018 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeF1MxW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 08:53:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40569 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbeF1MxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 08:53:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so2728094plo.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=ocGAwDoWofVpG/ugAURKACDErWENa1b7zpp6DQfW5sY=;
        b=fofGKzfIPuCMNNr6M0zvu1od0c1NRJ29V0IF+1+7+xMmnuCkOGDO/bWhGY49EVhoDg
         Hpg/X0UVWmcVhTYg/wW81iqWRzfPwDs+SCfbMmeiVLz5+RvWtLRphybdZumBG3jaU9wn
         +4b7aknbofkXaP6yzyHBzzwdNvjAjEM8N8nLCsQnECG9WC77viu64zSGLK+VUUA3kUes
         C7WL8EdJnEjJs9C5zzYy+9NJicpKUIZqtdm5FWUtVJoN996oRE6T+QCuld42ba6ikNsU
         V/9PWaPfa5419HZs3lHBk0vGSaT2cif4dkZVDYpgnbfXJhF+m3j7DpTQZSaSEdJmic0t
         TwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=ocGAwDoWofVpG/ugAURKACDErWENa1b7zpp6DQfW5sY=;
        b=qrJ0vc9f5GH8mlBmI0OMBsgRhyBYjVcuO9hSsUBRtbDDk69D1Ro6Hcv6EdgvE0sLcZ
         E5dZaAmBG3ijKAi91d4Ggah5vJ9qPQFEIiZAjqsDBAqYqFX3wg7dspoNi8sDs2xO4Tea
         2W8NLMN9bOP8P2s6jutOKzVfmRQahHjNL/rre+LYG4E9fmlHoj1ASbtDlMS/w4abZMg2
         +D2lLo0EON0sqGV6d6vrZeXJrRYZpRoBpdBEmvLP6rv34NB0V+fDR5S9jsNMall+QAIX
         dwaJFQR9oY/Ap1+ywGbYYODmMXs4c0KAOIbkeoEgRbHRjgdlkbjB/aKE/VbqT5yqiffg
         MVag==
X-Gm-Message-State: APt69E3Aaho9eNNKpNBamV8MW4XYvim/z3EEVvliMxGLvT8Bll2e/kim
        nx33ZqPpqjjr+j1nq5fpkXI5hw==
X-Google-Smtp-Source: ADUXVKIJiZCaaj49xhgw2NNiCmuHzQuWyPMJnMmOHtmSt4kw+LeaHiFOboiwrPwENGVV8EFZoqgsQw==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr10442366pld.118.1530190399880;
        Thu, 28 Jun 2018 05:53:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id h189-v6sm9969732pfg.5.2018.06.28.05.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 05:53:19 -0700 (PDT)
Message-Id: <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.7.git.gitgitgadget@gmail.com>
References: <pull.7.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jun 2018 21:35:23 +0200
Subject: [PATCH 1/1] Makefile: fix the "built from commit" code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In ed32b788c06 (version --build-options: report commit, too, if
possible, 2017-12-15), we introduced code to let `git version
--build-options` report the current commit from which the binaries were
built, if any.

To prevent erroneous commits from being reported (e.g. when unpacking
Git's source code from a .tar.gz file into a subdirectory of a different
Git project, as e.g. git_osx_installer does), we painstakingly set
GIT_CEILING_DIRECTORIES when trying to determine the current commit.

Except that we got the quoting wrong, and that variable therefore does
not have the desired effect.

Let's fix that quoting, and while at it, also suppress the unhelpful
message

fatal: not a git repository (or any of the parent directories): .git

that gets printed to stderr if no current commit could be determined,
and might scare the occasional developer who simply tries to build Git
from scratch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0cb6590f2..c70f823a0 100644
--- a/Makefile
+++ b/Makefile
@@ -2021,8 +2021,9 @@ version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
 	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
-	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
-		git rev-parse -q --verify HEAD || :)"'
+	'-DGIT_BUILT_FROM_COMMIT="$(shell \
+		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
+		git rev-parse -q --verify HEAD 2>/dev/null)"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
-- 
gitgitgadget

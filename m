Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98152092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750751AbdAVW5x (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35479 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id d140so22157874wmd.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcPV1WmuUNuBTBeDD2qicFrFiL6Ku4fFVdEQ0emYqzc=;
        b=bfj7XIX5zAMvqcu3LG06oTxFpGWdFSP2Dr2KBVIUJvJq1C2UAvEfKLHaDpjVdaR4FX
         qpFPvOj5FEv48VENW4Nc32gHOfDT81/2cytQhhcLfucf1L/rKa7l175dCEsZZAZLDvTF
         5QV24NtIorhTlD44wg6FpsHi0Tl7NIpFPrzc99SzvbVDw3mVqfBZaiGQBRG94sAZ8JjU
         3joHL+Xbl9zMDmwiZC1wevUTeK9aKafFMC6Tp+0DNr2gmPw/H9psAQIu6QQUiaJ2J7tB
         zXsEJDUGjyVqCWlLkBZ6zxn4rR6TdHWoGT+sG6UttA2M9r7uaoV9qASHrEhcMGPjD9Ib
         Tdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcPV1WmuUNuBTBeDD2qicFrFiL6Ku4fFVdEQ0emYqzc=;
        b=CtWxBuHb4aVnqHjfbYlF7Q12oUmPy4Lg5Y7oPMISaQ4Hj691YzizoFvy/zGUdS2ngp
         PmgGcV8rNpEUuzJ6adAVGgo9ftYIr14Jr0evPcwLvAQxhKnvDZyCuwqlphnlIki9cxI7
         PdYobEhTX2fkEqsSuIGc71t+Lcz0fhcRpjKgbv7lmyY4q+w/HyAC4Ssd4cpbo6zK9aHh
         lbyqR9PH24gS5M2wVDwE5BVaA1Q87LLhi4g1ZljJaH5OmLfa8+hCZfIX14lq/CFomHzV
         6Wr394OW3sBLncvUQFswediBR9hBh994uNipSmVhSbdLdRZfodDNDYRAsX7lfwPdPdtv
         9fxQ==
X-Gm-Message-State: AIkVDXIvoBqWoHUIp9rMjIBrdgSS0+0+PLMNhduIt/o/0Fbut68RlUdIEnesasTgi4urJw==
X-Received: by 10.28.71.133 with SMTP id m5mr10743808wmi.132.1485125868708;
        Sun, 22 Jan 2017 14:57:48 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:47 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 2/7] completion: add subcommand completion for rerere
Date:   Sun, 22 Jan 2017 23:57:19 +0100
Message-Id: <20170122225724.19360-3-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Managing recorded resolutions requires command-line usage of git-rerere.
Added subcommand completion for rerere and path completion for its
subcommand forget.
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c54a557..8329f09 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2401,6 +2401,17 @@ _git_replace ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+_git_rerere ()
+{
+	local subcommands="clear forget diff remaining status gc"
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if test -z "$subcommand"
+	then
+		__gitcomp "$subcommands"
+		return
+	fi
+}
+
 _git_reset ()
 {
 	__git_has_doubledash && return
-- 
2.10.2


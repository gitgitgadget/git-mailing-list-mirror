Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31A11F453
	for <e@80x24.org>; Sat,  9 Feb 2019 05:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfBIFZS (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 00:25:18 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39712 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfBIFZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 00:25:18 -0500
Received: by mail-lj1-f170.google.com with SMTP id v12-v6so44513ljc.6
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 21:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0UY+A7EcLOLgkUAzXWNCIsRHvbRfdgLQ/ePqJ69PnQ=;
        b=YGBq2mu8l/ZQklbTH/Gg77YKrkKaJTfA4miGubUndreH2Bwlu4YH6ujzGvwm+reaQ5
         6rE4swYEGTXrURn/Cy2UL17nRdUKW7mtg5ErTuuzjfGYWcqdS8sWX9fcEkc4lr0Pl2BO
         QY1+rE+75wylYw93mQ38/uBQBz67n7ukVL0Oc+zkV2rI1l/ZBgPRAikY102/FNe0lbMR
         iphgE7++cDuuyetsVbIMx/symLA58GhI11CKXNGI9DeM2gHTS8/k2H+ILWEhZavOEeA2
         AwNveYZ6eM9WIrU0CnNZ/9d9yF/Z6yDHxQxUyBr7f6Ec9EeFHkpuTfi4kjLjlI+iXyNT
         Z7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0UY+A7EcLOLgkUAzXWNCIsRHvbRfdgLQ/ePqJ69PnQ=;
        b=OiaoxjFCfsOaHPJxv6dciGafn2AEnJn1FeXMSE6uma81RMGGWKgdh2FeJrmNyNtDAd
         R5qOoPKi0V6MledBao1AyFFztQEc7kgJOpegwuEQhr0mbGxtvmHAXkIbn3ZyPzuEEBZ3
         nXqPnbrOzEr694dgQm5AXft0PdLi0turgWT0hMtXn0XdBOMQ+Jxz+xHC5XqobaEYvu4O
         t8wemP73ben4Hqiu8uOnFcn/r1oZxjxH9kXu7RxP0D7H3npVYJfYj1A7koKOIJjw+Ubx
         +Exg4ndfQhSE3Pzg4MaU5zQm6LaejVEgIB++JLhqsSt70zUD9Rldi2g6Lj5a8MqZlHYf
         YdtQ==
X-Gm-Message-State: AHQUAuaZxROmoEC9vIZtB3r+ykHP8e8/z4SOk9lUvmsGvlaasrGaFumY
        E/nFrxQ9voh5hJxmrtWKPH6yst/p
X-Google-Smtp-Source: AHgI3IaZVmXPd1ixoWMZNW3BUF7Dab3Dmv4ti1/0+Ep6sZXzz5PcHQGIDJQp0jjboszUyCMcjZZ2uQ==
X-Received: by 2002:a2e:8256:: with SMTP id j22-v6mr15744035ljh.40.1549689916171;
        Fri, 08 Feb 2019 21:25:16 -0800 (PST)
Received: from localhost.localdomain (host-2-60-217-179.pppoe.omsknet.ru. [2.60.217.179])
        by smtp.gmail.com with ESMTPSA id 12-v6sm840323ljs.29.2019.02.08.21.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 21:25:15 -0800 (PST)
From:   Sergey Zolotarev <szolot4rev@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Zolotarev <szolot4rev@gmail.com>
Subject: [PATCH] Add support for 'git remote rm' in Bash completion script
Date:   Sat,  9 Feb 2019 11:24:34 +0600
Message-Id: <20190209052434.20616-1-szolot4rev@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..fa25d689e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2334,7 +2334,7 @@ _git_remote ()
 {
 	local subcommands="
 		add rename remove set-head set-branches
-		get-url set-url show prune update
+		get-url set-url show prune rm update
 		"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -2379,6 +2379,9 @@ _git_remote ()
 	prune,--*)
 		__gitcomp_builtin remote_prune
 		;;
+	rm,--*)
+		__gitcomp_builtin remote_rm
+		;;
 	*)
 		__gitcomp_nl "$(__git_remotes)"
 		;;
-- 
2.20.1.windows.1


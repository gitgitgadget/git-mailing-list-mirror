Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD0A1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBILF3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:29 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42392 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeBILF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:28 -0500
Received: by mail-pg0-f68.google.com with SMTP id m28so3399107pgc.9
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSnwBtSRpJZvrrl0hB7lCPgp71RaRs1u9sz14W+bc+o=;
        b=VcmAU5s6Is7Pjx+owJqYUUhhvpEANQdCaJIX1ukRIKb+OAWAn9EdUhgHOjq6dV4YV1
         /dWt3isV1CnOIlhko3kOUL02EaknMWWNMwxFC6tH3mHIbQDR34UwWkoRCCloYeySNPzH
         orDdF2bZzQQCSbe1ClBYsB9XQSc37JGJL4Wf8qXH2BYRE3lcy6JpRUPpgmCu2Fq1OQOd
         3VtM08nnHnJIiaBueRWQHo1bxKrB6kA5K61I51QTwn0KO3dbPrbmfY7t+dNkgdBPlPMi
         tge0yWgq/IHSL85GuqKpc1zwCQ7ZdkshapD38Z3hPDJN/g5Wi/wuUc9xzX7d6JqaCjEK
         XaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSnwBtSRpJZvrrl0hB7lCPgp71RaRs1u9sz14W+bc+o=;
        b=NS8bkii5aM3Rw9VrywcsMA7b6F4rLYmOo9+rm2loaLxKL4vZ+SO+270Qxb8uyI/UMM
         JC9Bc9JfvZCPyVf3SaLlkUIlu2dAGW3QDaSGDazkj85Q2P5pkmknLJtxcav1InTTxanF
         eIF2WnxA1CxUN7tT3+ZWtHiGVbweKDhNGnyvFGgSXkdeZ+IDwSJbBPEDNLngeQN472qO
         JzVq0PLgHDnKUbo3Zwov6JDG4DI1kiTVGgmjqD8IljKOZ7a3QczaAPHoh/nr48S6YjOl
         cJuOkfdyQsOtiC5N0RyFjYTtYuBFZfH6uZTx2827c+4BbhkTsXEVuQatx++6vKImYoMz
         dDMw==
X-Gm-Message-State: APf1xPB/LjyV9nStCIykquSvWSffnJplUQlZY/YGX9QjFtuDzNBfUfAU
        xhCWWOnHyOJYb9OqMjNmvJit6A==
X-Google-Smtp-Source: AH8x22638k/UC/PS6t1XQNOmfuMHp7TivZqNB1lPUMSSSU6ZUBaFpPOVPorUU5IdCg8XO/IynnN2Sw==
X-Received: by 10.98.33.199 with SMTP id o68mr2485863pfj.78.1518174328376;
        Fri, 09 Feb 2018 03:05:28 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 203sm5915346pfa.110.2018.02.09.03.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 32/42] completion: use __gitcomp_builtin in _git_remote
Date:   Fri,  9 Feb 2018 18:02:11 +0700
Message-Id: <20180209110221.27224-33-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d8d9e8f0de..6e600b7aa3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2612,7 +2612,7 @@ _git_remote ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--verbose"
+			__gitcomp_builtin remote
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -2623,33 +2623,33 @@ _git_remote ()
 
 	case "$subcommand,$cur" in
 	add,--*)
-		__gitcomp "--track --master --fetch --tags --no-tags --mirror="
+		__gitcomp_builtin remote_add "--no-tags"
 		;;
 	add,*)
 		;;
 	set-head,--*)
-		__gitcomp "--auto --delete"
+		__gitcomp_builtin remote_set-head
 		;;
 	set-branches,--*)
-		__gitcomp "--add"
+		__gitcomp_builtin remote_set-branches
 		;;
 	set-head,*|set-branches,*)
 		__git_complete_remote_or_refspec
 		;;
 	update,--*)
-		__gitcomp "--prune"
+		__gitcomp_builtin remote_update
 		;;
 	update,*)
 		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
-		__gitcomp "--push --add --delete"
+		__gitcomp_builtin remote_set-url
 		;;
 	get-url,--*)
-		__gitcomp "--push --all"
+		__gitcomp_builtin remote_get-url
 		;;
 	prune,--*)
-		__gitcomp "--dry-run"
+		__gitcomp_builtin remote_prune
 		;;
 	*)
 		__gitcomp_nl "$(__git_remotes)"
-- 
2.16.1.207.gedba492059


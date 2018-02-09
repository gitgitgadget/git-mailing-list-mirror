Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119D51F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBILGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:06:12 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36834 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeBILGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:06:11 -0500
Received: by mail-pl0-f68.google.com with SMTP id v3so1322132plg.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Awfd1ey3ryvQBOG/ys9eE3jQsp8oTxRvANtP134saUg=;
        b=PtJPWYnhPxcAKEw1SgU1eKoqZjjGbogDzDAkP9hgLO1ieA6yBOVqryEIABxx4wC0ZC
         YXi+KnpnWQfqBwaddQhoIbBjnLjq/W+Zq0sDeTZhH/L+3WuLQGafqkDnhfe/6R6K8ywd
         graNxLzP/lyYtxNpi97WW8/YGyr7l8QxjKN5uOJDKVsYLnIVoRgiIuBFNgh4u6Zw9RR1
         SlQWj6CeusYx8Fu41hM35fuyW2rWYEtS/A2rEO2CHG76vnjhAeRWN0WUbxvJpNuBu/YX
         rQ1549KU4fem3YUqViE7nO5nFG4IqUShV0eONcaVAMaPm+wwcaDUXG8yCtaBHlKZDF72
         OPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Awfd1ey3ryvQBOG/ys9eE3jQsp8oTxRvANtP134saUg=;
        b=o/2ILYdanZQi6/bmKAlGaL7hqQSws+K3RTkpup+b3019ImF0lGRgsSCcNFE0UkH+CX
         hLrAccGk1Z2t950eyfCggL1NcKC50ED/3dpCrmZst/ou4zycSPmT+JIyEYBGhS98/gm0
         kab/CP7QLypPQ8o3XYVZaNP8n/9ZEjyVJF6QNrMRKLCpW7nKcB+9loNJMA5KU2glm0mq
         ws2xLfS845KATSZyVJJmg9/JdJBh1whrxU7KHKBnSsfTHLIDZwzU9YB5lL+3+WAWmezE
         52z35pbeQrIYrfvXaEMT2LHEJpani1i+AhS0IwoBI8wuxOPexAagHqSKp4pIStU0AZqT
         61ww==
X-Gm-Message-State: APf1xPDVgHDl6BobPQn4aapPgojfxDQY7pOu7rrk2Gb5hWQZYErSlCYz
        4jERYmZ/OhtsyvPYolN6Z9T+EA==
X-Google-Smtp-Source: AH8x2251xDKDtCp5r/x7KmUEzEnROK9/bW/lRofA00wEEgR9jaHmqBb09Fy3vzIXeNExP7BA8LiLmg==
X-Received: by 2002:a17:902:b406:: with SMTP id x6-v6mr2272921plr.150.1518174370714;
        Fri, 09 Feb 2018 03:06:10 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f80sm5815310pff.81.2018.02.09.03.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:06:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:06:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 40/42] completion: use __gitcomp_builtin in _git_tag
Date:   Fri,  9 Feb 2018 18:02:19 +0700
Message-Id: <20180209110221.27224-41-pclouds@gmail.com>
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

The new completable options are:

--color
--format=
--ignore-case

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7724ce7808..e76b2f0356 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3002,11 +3002,7 @@ _git_tag ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--list --delete --verify --annotate --message --file
-			--sign --cleanup --local-user --force --column --sort=
-			--contains --no-contains --points-at --merged --no-merged --create-reflog
-			"
+		__gitcomp_builtin tag
 		;;
 	esac
 }
-- 
2.16.1.207.gedba492059


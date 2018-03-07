Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F621F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeCGBFm (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:05:42 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41988 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933236AbeCGBFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:05:41 -0500
Received: by mail-pf0-f195.google.com with SMTP id a16so267077pfn.9
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZPKI37cKtaTimcJ65L8T3EbkJoUU619+NP7iKmCTl8=;
        b=ZUTOlyY+ltGK1sX4p0X37PfLVJcBAEDgLAimyCE1lQkhlqcRakAvNunO9MhV6QKgKr
         8hQMm2GhpCS0kubIGwc8K6zSdFWA7HhkTtHn4Sgt0/+JV/YSnKoR9cud2E099tcVlVT7
         3J7V/TeQm5F/fMjg31GNDFsrixVD0er6Di7JFxIkBCgICdUWldu+3/9KoAnGPr8AM8oj
         vOhc5NJX8sVqA6rMu0nHgiaqldFJBU7B4bZYo1kYrz2IViJ265iMBe2QchOQI9NhBuII
         ZwO7QOf02SGNrFm4m7WJwCyyTo/RWDr9TRhdYRqWWW5yS8TG/0bgZ1cDqcomTX0CcVUV
         dt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZPKI37cKtaTimcJ65L8T3EbkJoUU619+NP7iKmCTl8=;
        b=h6jH6biOn9lgx6w2Zul/mc3dkFmoHmBCPTOOhDZvf4xTpkkeZDmxxUjD/OvismnCVI
         fs6NS8rgtmvFVXlw0LnlHLmYx25dvRHKSKQ5A0OrPbfeDFUl3jDG+vlemOJge8uSNk0L
         sW7UKgtoHdOgtHvSj6Z5rjFeGt/U1DPBNRO5UOweK5+TOOFusq9f5Cb4cKL7RsfUQiVX
         WbWazuSaYwgGvp73V9LIF+wWJzPpeRakdEquIvqSOkmlHJTx5cjO4PKkfCR2qXSH5w1L
         2e1638Hl6ITndQZ70ZyhBFfaPqPkHgLidP4QX6oCYEYQlL/YZLsdnIue8urOGi8keG7R
         99iQ==
X-Gm-Message-State: APf1xPBB8ejZrWgx/9agqB7Hm4q9+bEtsaaGXhLAl079tXf7p78TmHNQ
        VijcwaFUGYzrlApvnQzsvG8=
X-Google-Smtp-Source: AG47ELsAKe0P9TtpRe2Vn51GCxztf7zkBCtS2JfH1RXCJ0c3RTlQe6mk6hvFm6eekPDjImo+jEIwbQ==
X-Received: by 10.101.66.193 with SMTP id l1mr16462018pgp.57.1520384740957;
        Tue, 06 Mar 2018 17:05:40 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p10sm27664133pgd.28.2018.03.06.17.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 17:05:40 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        phillip.wood@talktalk.net
Subject: [PATCH v2 4/4] completion: more subcommands in _git_notes()
Date:   Wed,  7 Mar 2018 08:05:04 +0700
Message-Id: <20180307010504.9289-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.785.g429c04a1b9
In-Reply-To: <20180307010504.9289-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
 <20180307010504.9289-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two subcommands are added for completion: merge and get-ref. get-ref
is more like plumbing. But since it does not share the prefix with any
other subcommands, it won't slow anybody down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc3ec43b65..2e30950299 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1815,7 +1815,7 @@ _git_name_rev ()
 
 _git_notes ()
 {
-	local subcommands='add append copy edit list prune remove show'
+	local subcommands='add append copy edit get-ref list merge prune remove show'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	case "$subcommand,$cur" in
@@ -1838,7 +1838,7 @@ _git_notes ()
 	*,--*)
 		__gitcomp_builtin notes_$subcommand
 		;;
-	prune,*)
+	prune,*|get-ref,*)
 		# this command does not take a ref, do not complete it
 		;;
 	*)
-- 
2.16.2.785.g429c04a1b9


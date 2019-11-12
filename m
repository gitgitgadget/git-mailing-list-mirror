Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7381B1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKLAOP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:14:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfKLAOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:14:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so11943303pfq.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E1n2yjYXr9cj/AnXYn8LhEJNJ7AQBPgjUdDsBO1cy7Y=;
        b=nXA8UcftCd6//ZUTJmvscSvdCfvtrohE1Cwh7YXuMxRdtlgRiRXz2GHtX40PHmAO0V
         xx9Wqsup71fEv+MKRWrdnUBrjEQGbDUu0pnvXpz1hsyd9ZiARoU1+aPDDdTKKNriQVrL
         H8Uay+klB3nNlL3vRE9BqNqLnpVyp8kEiMRVdlkDtPczQMwzWEeXSB975S2998XDBvzb
         LcI4WBFcB/uF9AW9w4fTYPGgzf3m8uOXD6nW0m7tPzOIfZPvlpQgE6FNP3mGK8D8LGSF
         +AjTAZ/RdPdxxRC0/petWapSKQ3bENLrK3YaA3Vra5aGZJjktK6Vq5KhovEdmk/BodGT
         SMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E1n2yjYXr9cj/AnXYn8LhEJNJ7AQBPgjUdDsBO1cy7Y=;
        b=gmsEv1e8AU/bKIhNBgfFN4OpPMc/ZfUpouAXLpiRz4Pil5kViKR98qJ9NkfEHAyclm
         epAlS0tH7jUF+i+uuBBTB9l4S/taxHP6LuGqzovowOgPz4UqIC96BxJC3x5PLkYiExpw
         1zOdCtjvds6ABzgqNwYfp12aDJVSCq+fUh2meQaR13VC8sy2hYg5RbQAZeoxxXm/aT4l
         Zfn/5TKgLUo/Md6il5prgcgEe4Safx2S56WhuRWlWXE+D5sy6QFIYItEkvC0CAn/EQzQ
         5nc+johsK8G9OnbugnLYYR0gGj0S5nOQVtCbNuSCUJuxi0UveyARbDhNuj/MsjAlGtnZ
         A0Ug==
X-Gm-Message-State: APjAAAVN7DP0Dh1p2nu9c2BcazX2s0ZbZlyvbXLxkYCk95LcFKnJ6axx
        VAW6LjCiwOrsKJKyzCaq6db2lJ6g
X-Google-Smtp-Source: APXvYqxUrluzls1Jq5LcLmEjKDvN4k+zCYrUaiMWHA9YKVBa7HGuDjeWvpsSjoMjVsYVcM0qWx/3EA==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr2392458pjw.41.1573517654012;
        Mon, 11 Nov 2019 16:14:14 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id b21sm16532494pfd.74.2019.11.11.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:14:13 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:14:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 14/14] t5520: replace `! git` with `test_must_fail git`
Message-ID: <1bc7ad364f2e787147f0ac7205f207f9b232a3f7.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a Git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ef3dbc201a..602d996a33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -537,7 +537,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -572,7 +572,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.24.0.300.g722ba42680


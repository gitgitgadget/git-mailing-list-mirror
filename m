Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5935C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381117AbiAaRuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381116AbiAaRuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:50:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7AC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f17so27002581wrx.1
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JPToaO8woy9eeopM2Q06w8ZhVENg4clLhoYaQM8lIPM=;
        b=PI/8EVpylYi1gHzxa109iP3LZC/bLv6QlsSLbwr3BsgD7UIpDVotcqCbyRI3ZMBD9m
         iF+8CqTgQr3pZqJ/vYsumOVi6K6mgIeI/HhBxZnhjGYEQ6y3lCfxPHlu22PPUN6lolRu
         LfWuv4FZgGSdk2/hZT+iVVsus7/QNTPBhW1573BQbyqrNa2iyaisklcTaTbRlQiiCkge
         2GvwzartVYSdf3wbmHl7PBSAjk9DN+kn/OTz9XlhxPJQQsH65CoCBlMAI4eBba9c9kbF
         iG8PMAwdx4evY80/Hckjh4Z+/XEqiRhP8aQ+Ae+lMcYeFVPq6z1jS5EgbwPhgx5lvs2R
         4DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JPToaO8woy9eeopM2Q06w8ZhVENg4clLhoYaQM8lIPM=;
        b=ZexFn46QDaSGvxyyAADVb+Uk2fzGDp8wKgoAe9rUx6mzcSivVqwaL1PQUhM0NCQvP0
         TdYJNSVc3ZjnAyqUrnRioIsyrMtYCLcc6JRzvcbhnGzxyyLH7ZXGVoWw4ppc1oTTs0An
         FtCxWxN8IzTrzo70sh7KDx2doX5Z4M9jr6CfYWGTku0BUH52wMiAvzQ2hTr4fSYyKGUF
         +1IsMYywQtjJ9AjSKWbB9vSobWKOeTZetpXwdbbYJHPBcCE5gVs3nfCC9hgha6FDeiSU
         +sY3ntKZ8dPZYAbz6j/eBcScvgGm1bOR4bAQ8CvfGGW5SVGRbUAC6FSg8evBPT5n4iQ7
         gIVg==
X-Gm-Message-State: AOAM532zuXtcjpPJu8YaKsVWkuJUuMsvfjUdB+d5xzzemMhnIGcd+w+r
        1rgYz98WMjJhd3MPYsYnwv7mL44oMmg=
X-Google-Smtp-Source: ABdhPJy/EJj1twP+klVYX/DwG9fUcovfoEI+VOQ5qSnqQaR/KIGC5JielHSvd/CO1/q7RVHOQwAJVA==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr18112911wrw.168.1643651423219;
        Mon, 31 Jan 2022 09:50:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm14456819wrm.90.2022.01.31.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:50:22 -0800 (PST)
Message-Id: <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 17:50:19 +0000
Subject: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable backend doesn't support mere existence of reflogs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 62e5e9d1b0a..51f82916281 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -111,7 +111,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 	test_must_fail git reflog exists HEAD
 '
 
-test_expect_success 'create-reflog(HEAD)' '
+test_expect_success REFFILES 'create-reflog(HEAD)' '
 	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
-- 
gitgitgadget


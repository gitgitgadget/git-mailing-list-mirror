Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355E820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeLLSOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:14:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36687 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeLLSOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so8966083plo.3
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XOhtDN+4VhJqHAmRUzEfcJZ01qJbCNu/bPF03uC8Vd0=;
        b=PrKosAXdhcIduhrfSEdgPPmtvq+hDY33FfoL73JnMLD4hw503xqjznGlM9/HZLLqQP
         xNXdBG/t5nL7392eoWCX0G8vcUJFpdV3lN93IR7cdNs1JoHb/jgAp+c1YK1e6bWh4Ubm
         wy7k4OVRM+HMeKfEbEzxrrd10gBJXkTFCDU9zOnloJ0B9PwKl9JcruSYyka06LNYhPOf
         Bn9lnkWuKqfvGhdLxh6Y2rsbOi9S80MYYQDRjk3hdjv17WtFEaq3XJjKAXYULPnXUBBl
         x+gKKRe6bTsYhlRK7MIfLgNrN+kzDgsp8UPwkFDiTsB240LFkLFhbtZ7h4RECI/nM1qQ
         n8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XOhtDN+4VhJqHAmRUzEfcJZ01qJbCNu/bPF03uC8Vd0=;
        b=kjc6S32NWiKpycWcUg4SHryaAU94Q2Cgesnixpewv0EsyCa5Xus/GEoNggTCCDGSE7
         RZGD6IUJn9hcyi7JAhOziMhEKzc2M1YjIWk8rZ7vW6rN4hj9IYx0nziVLyj7lbcQ2DHh
         k7eJjt/6i1tUAygoEqMY5fmZNzBvPuCHan5hVbrT+2/DQEX6NzFAlOFrP8xpJ1s2wTUk
         UkrzgZ1TqMZV6fx9SZJvw7cKrURBUNevMsigYoHz6gByyOZHv740v7MOxHmOnuU9bzXH
         nGShAE0Qj9RlYcFaLszoi3ial8E8eqykzDnN7hxf2TpKiqitqoFOyt3X4+UfsVFm/IYX
         Fp3A==
X-Gm-Message-State: AA+aEWaKyTUfNWPy5adBvDQ5R+5FJxOsnIUQ6nXJ8dSJmgmUWJowMAdO
        U2awt2B28GoWHqsREqrqKZi8sJHy
X-Google-Smtp-Source: AFSGD/WEBcUvkohjiIUyNcS4rFaidGJn7sDFE5ks4gg0WtBZK51UAWESXid2OXeAlMGQZtwNQLbzvQ==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr20869632pls.90.1544638493679;
        Wed, 12 Dec 2018 10:14:53 -0800 (PST)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p7sm26365819pfa.22.2018.12.12.10.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:14:53 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:14:53 -0800 (PST)
X-Google-Original-Date: Wed, 12 Dec 2018 18:14:48 GMT
Message-Id: <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.98.v2.git.gitgitgadget@gmail.com>
References: <pull.98.git.gitgitgadget@gmail.com>
        <pull.98.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The new test_oid machinery in the test library requires reading
some information from t/oid-info/hash-info and t/oid-info/oid.
The shell logic that reads from these files is sensitive to CRLF
line endings, causing a problem when the test suite is run on a
Windows machine that converts LF to CRLF.

Exclude the files in this folder from this conversion.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index acf853e029..3738cea7eb 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -13,3 +13,4 @@
 /Documentation/gitk.txt conflict-marker-size=32
 /Documentation/user-manual.txt conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
+/t/oid-info/* eol=lf
-- 
gitgitgadget


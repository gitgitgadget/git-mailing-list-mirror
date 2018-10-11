Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428741F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeJKRJr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:09:47 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44603 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJKRJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:46 -0400
Received: by mail-ed1-f50.google.com with SMTP id z21-v6so7619986edb.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXGqzx2rjG5au64Z3tFWbHC9SWMPkM7kO7wZhtigs94=;
        b=ke2cNDJqAE/uCbC6LcbHRyosUDOMyC0jFFhrSLV3OIGA2SS6JlF6DCNhB41shUEQ32
         3FTXX4W3S0+idAXY4oC9N/7eqr00LNILtlkg9I/DoxgnODxagK5WUOQcJWBqzc1+wY3l
         6ppaOivID1npsGGe33RCFiYKY0K1DU5tNXJvCIAQ/cSzJTCz7JzBd4A6MieLR6ynoBop
         L2S6oWCDbFSYgsMZ45s0+J9qWDgCr0MMSOo4YER5vYXiHERT/LfxixiSSFyb4FufyVYr
         R4RnmgOfM6IFz+1rptzNeeOOhmAQBrezVspKar+fbPBzCKKyRIaUzLs9iTvpTvoNk7i0
         VRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXGqzx2rjG5au64Z3tFWbHC9SWMPkM7kO7wZhtigs94=;
        b=Aa0BHwE/uwumbinVR1cVmi5jqRbz09cNUoIuCaNKDflnk3BK4xMMno6xocvrWK3m/h
         b/Ew1D3qsmzDIDr+1iw3arkoA1S33DVc2py8W/O5pQP3jNjVDfMxTeQzuy7h277PvqWo
         XLHC5BJGu5tNoeUtB1UNawoZlVZH8gld7B5Q6R985XK+CCEprR0Q0qiqcFwmVPvFcVTo
         i0ELOBngVrnuqU9ouilWtcbWHJIxJfbNk9p2TcGfcBK11YDJQyw5ZTXLg00kdQTWodCh
         mkdGFiqYsUfIU3hkPutG0CeSx6ejbE0nAdIR2gQg8GSUkkFhRe+gQYJW5IuOM9m9wD/4
         1yYg==
X-Gm-Message-State: ABuFfoh0BLKcefVEuN+1A/btU80moAJQdWZfUO3aGRxHtRVKpjzAki4Q
        mf6cncZlmb6YuC5cw/g2fao=
X-Google-Smtp-Source: ACcGV62FbI9xSwBea5X4eGAm/wl8wJf7pzxr+bGi8IdJ5VQRiH2w69Skk0g2YJ1EfYd+h+/MUAWe1Q==
X-Received: by 2002:aa7:d34f:: with SMTP id m15-v6mr1668065edr.266.1539250996204;
        Thu, 11 Oct 2018 02:43:16 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7034721eda.18.2018.10.11.02.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:43:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/6] t1700-split-index: document why FSMONITOR is disabled in this test script
Date:   Thu, 11 Oct 2018 11:43:04 +0200
Message-Id: <20181011094309.18626-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181011094309.18626-1-szeder.dev@gmail.com>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
 <20181011094309.18626-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1700-split-index.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index be22398a85..822257ff7d 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,6 +6,9 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+# A couple of tests expect the index to have a specific checksum,
+# but the presence of the optional FSMN extension would interfere
+# with those checks, so disable it in this test script.
 sane_unset GIT_FSMONITOR_TEST
 
 test_expect_success 'enable split index' '
-- 
2.19.1.465.gaff195083f


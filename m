Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7DB1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfA0X1I (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:08 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:32846 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfA0X1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:07 -0500
Received: by mail-ed1-f43.google.com with SMTP id p6so11652777eds.0
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Smsl1dhl4ohZgrvGoo0qeTJuxC6Y18tYIdYty2ZmJE=;
        b=EK0VpLoiqVh5djnpRBDPIph7ykXwmXVS4Ei8E1Z53yTDyC+5QesdNzCoKzm6er9NRu
         ExhMOW7YRIEihMenE9fgWRA5h9KBWSve7OLKCMq5ti3RhsD1whutUIng7U1q8FpHYedJ
         rMdQbh9gtHIiX5XBU67IcUAcIGsjRfwoqFkP7D7igpnZTVLmf5weHIwYAPfkqZVisGUN
         y3XxVk5iW5pUcljmOKmwbggQjllFsN/QYUSWJhLlRXGqKq5fQoZFLBdphP1+JAmO/RNk
         cL19oa2vjNMPYPupiMqK3RcrTtivHx4nLzsfySfj/CX0ERST//BuVsv2EY5p9Y1aWgxN
         Aafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Smsl1dhl4ohZgrvGoo0qeTJuxC6Y18tYIdYty2ZmJE=;
        b=mwqTkrgOnYhQ31W1JrB7cSOrf27/SOPXARAPtRqT8d/F5ipadGlfQXJRXNPIxoAJjy
         noK11I/FWwl8m+yjydnDKca0gr2p8j1OQELurP+M2GKIH5H5zArxBMdB77vUfOEyitY/
         2mxnuxriIDfQg5dVAqpGaDqIWLKIIUIQe5utHT9kajpdSNMkyx927HENtUaPpWApTW4j
         Y/6f++OuC5RTHqEgWehO6eqHmDs6Ep1FYFQRnAvvdoRezlAr8pveSM+ZksfYxN3z17Wr
         hsF2gvwyRBO8Q2wXTSCb4okb4BtJroNubjD5+7lyhv8MGqy6YAglI4JArA9dB9TaChij
         nisA==
X-Gm-Message-State: AJcUukedKtVtBufJ/lvmtlvIhhtwSUd4CvQYBKZqTBGzL59LU4OIpfgC
        /QaJ/+gXvFArBpPStr+12ZLC0ko5
X-Google-Smtp-Source: ALg8bN4sF8ewNIwtbr5eG6fY0aeWhjKQ0fRinkDN3OCRVGXX4mZOKeJXhxgJ+DwxKRK/pElcPv4mdw==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr19308361edw.114.1548631625914;
        Sun, 27 Jan 2019 15:27:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm14022759edc.28.2019.01.27.15.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:05 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:05 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:46 GMT
Message-Id: <b39e16527da862c64e4338cf3e3fea00345f3a81.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 20/21] ci: speed up Windows phase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As Unix shell scripting comes at a hefty price on Windows, we have to
see where we can save some time to run the test suite.

Let's skip the chain linting and the bin-wrappers/ redirection on
Windows; this seems to shave of anywhere between 10-30% from the overall
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 5505776876..c2bc6c68b9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -127,6 +127,8 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	export MAKEFLAGS="--jobs=10"
+	test windows_nt != "$CI_OS_NAME" ||
+	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
 	exit 1
-- 
gitgitgadget


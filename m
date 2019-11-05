Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B111F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390943AbfKET0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:26:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44005 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbfKET0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:26:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so22841631wra.10
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 11:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=h4Ck8eo6scAiz08TNBl065UrnkqnC9mRISVmQN0v51Q=;
        b=DXTpyP/UKPVktaPA6chBfEBAJStjF3ARq0jHviJkzFb3eE/h8QQvQt0Gg8J9r8Y976
         tv4wEPTLYfQIIk/ZzzZFL/q8r2uvCLAORNtkYGUIZqvY9xAVz5uRN8mOC4MeHLrIO6Vb
         +tHj/61jYZWJ64ix9yAqNYjXk8GuSD536PaZpqMytG7cYG5OleWQav3k5V09amHhZ/dU
         3Ll6Bj1vM/Os2ku8t7Gfql+3f2oSkNGQ/NeNp2BpWoH9Z/piUeWK98Ltm3Yg1wGlTPKf
         2M4IErffnakOkiUdIQA5w5oyuRBNgUgL2SU5im8Q8m2hECShFSjPFupcN95KIr/KZFAu
         l0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h4Ck8eo6scAiz08TNBl065UrnkqnC9mRISVmQN0v51Q=;
        b=LerXsp8OmxUZl53PUFtEABPdtSSivz7RHhEKlmqbdeGhtkqwGo7xxVpE2P1u6TPmYx
         hGbtckk7vVbIVewdguCLRn8Guu+3SEsXKAxL2k1IT9kc2mCSQDFMG69+6nfHjmrA7nBF
         rnoc9KvxpKDWx5OFRWGNLyiY9pPASzlSWxG6ZJLsBD6PsoghiVau0KB+6d/CasKJx5p1
         v7feJIWAsdngcCdkmrDowIH0D/hs3wGvWRjxqDqsKqp93DUgeQSeB0F1Aonj7gbuqHLN
         Q4Elf4qr9f5wyZTfpMsy4X6TWKUQjL04rQU1+Nl0ephJPhSFQVOvnSuNojd4+tC8gX4F
         seXg==
X-Gm-Message-State: APjAAAX0Um/ezH5lSWuKkAWJE66W3Q13Bujr5h+P4x4VINR7fsTp4hYY
        Ao8QOToKt37RTjPMc2qTF1RrpaYP
X-Google-Smtp-Source: APXvYqyCmbdHj13ekKyj/QGNWJk0P9Pf0IxjmkkyD9xWDgVnXrDECy2IDwN8R92njwVL/dETCQmWFA==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr28071039wrw.395.1572981982159;
        Tue, 05 Nov 2019 11:26:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm14700756wrw.77.2019.11.05.11.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 11:26:21 -0800 (PST)
Message-Id: <pull.451.git.1572981981.gitgitgadget@gmail.com>
From:   "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 19:26:19 +0000
Subject: [PATCH 0/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

* matching common remote and local refs
* marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

Erik Chen (1):
  fetch: add trace2 instrumentation

 fetch-pack.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-451%2Ferikchen%2Ftest12-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-451/erikchen/test12-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/451
-- 
gitgitgadget

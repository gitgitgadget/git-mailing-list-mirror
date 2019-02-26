Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515C720248
	for <e@80x24.org>; Tue, 26 Feb 2019 13:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfBZNmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 08:42:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41543 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 08:42:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so10725735eds.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 05:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Py1OsqtHSblRvnJYy8r3lZ0O6nzsdrMkmA1/lpUpix8=;
        b=ElNaJAV15iRa6BAcSW8r3Vjjqeisnqg/scMqdplt+v2vKH5sLM5usqLfJpIcHuA6Dv
         14lRtJVoyBURjFv+slpOcFYrptNoTngTGy21Fr3+0MTrFyaauM9c+cZqG1RWjW/Wwnsk
         STVz0V3qYpz9RlOomHO+9U+908EqEvPtq3bdWZionP1Y6m9nzEAVBqbvrlBN6HQIy+NQ
         +vOQP72KzrfUzHBARe6mzFxlAAQKEY02cwmAJsdFkONmxoCeOQLoMgY3+90NMv3U/Cxu
         IRWV1M6W0wJFTJ9dRSkTDbKazySNv4SYCWQll+n+g58YgEnM5hU5xiIbv7B3l/5K3c8U
         EKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Py1OsqtHSblRvnJYy8r3lZ0O6nzsdrMkmA1/lpUpix8=;
        b=KBsYZCPHvIuKFCL9GcGnTZhjSpMHGIIisZPgoILa/dm11Pzed9oa0mpS0VuUjhCqsa
         tq4bOweeH2WaTaatp2rPuXTLu+7I8dxHMtjjfFfiUCJ0ZyoVdzE9m5LT0ebQqW2KGWrL
         0BgrPKCiZ5BO9J6JykMBIR7FN7p5dQruNMmrya5lhi8i72Y1dhBgiQ1gmvQNmT9qgU25
         GVsGRCu9tH6qebBI6d66kGaCOujG46ZBVmvyuDTd7VVNfNUhqfsCoGo/NyHPMqyDBhOs
         la9yR3CLmxGMcRDH+UdwqNKZt/hfsIOC++bGNsnWsGxkr/GBzWGpwMul4cpZ+8pveQRt
         E65A==
X-Gm-Message-State: AHQUAubYFZv5J5WkbuSNmFhjXv8IlaXQo1avGqTS44AkFfUwodzFmMLt
        ns721xTJGiSnVjYdxeQaQ5go0P5C
X-Google-Smtp-Source: AHgI3Ia88X27a5dCO1Pi30oQn9VhRMv+YFZuVWtRfp56ss843qifXhtp5bIlHuKyhTXI8Tr5bsMeKQ==
X-Received: by 2002:a50:9189:: with SMTP id g9mr19423571eda.32.1551188525824;
        Tue, 26 Feb 2019 05:42:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm3419566edy.80.2019.02.26.05.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 05:42:05 -0800 (PST)
Date:   Tue, 26 Feb 2019 05:42:05 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 13:42:03 GMT
Message-Id: <pull.152.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] [GSoC][PATCH] tests: replace test -(d|f) with test_path_is_(dir|file)
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

Previously we were using test -(d|f) to verify the presencee of a
directory/file, but we already have helper functions, viz, test_path_is_dir
and test_path_is_file with same functionality. This patch will replace test
-(d|f) calls in t3600-rm.sh.

Rohit Ashiwal (1):
  tests: replace `test -(d|f)` with test_path_is_(dir|file)

 t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-152%2Fr1walz%2Frefactor-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-152/r1walz/refactor-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/152
-- 
gitgitgadget

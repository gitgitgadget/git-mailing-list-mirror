Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4441F463
	for <e@80x24.org>; Wed, 25 Sep 2019 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633761AbfIYCEq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 22:04:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38709 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbfIYCEq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 22:04:46 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so9506425iom.5
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnZZvmY6fY2/NSaMV4bCDa17Q8npDbBpmOa8GU/uwmU=;
        b=pgIN361lm1EIVyvDcstCSEXFMOwYNXweA5XCpnBXnOCkj5j+TB6zwO7Rv2ltsTtzW9
         sWTspHEk9iRuitsJscTn50B9CZ8isUuS7cAQ/nbJPwEd5QtHhxGY9IQf1w8vxl2Zc6VR
         Yl17UALIGgp9A1OCrSbpP+PUdBe9q+18upKljAImyUBXrpuMCvkJ+RRcPqxG/KKAeL5e
         EMS1JkVf39Ev7auObTXxDM9y19Sfg8VmnZ+W0wFRPkW07HHyFS9RNeLdHY5fpw/8ArMX
         2JJZipKJxlX3ixjGrgqP2vzvhEB2dM/KtDlwqRNRosVqltDedUfwtF5fdRYGHHnGiD+u
         hD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnZZvmY6fY2/NSaMV4bCDa17Q8npDbBpmOa8GU/uwmU=;
        b=LRymli2ngBgyefz3t9cqPKM+R/i9xsdPK6DuBHJfrilHJYZP7t8kvcbowYMvibxtjY
         TheuzKpLqJI+9kw59kkU93HsD53FVED3nyB6EH5FFHxWS/CgiJDYGDCchRBMluuS0IOc
         W/zvguUIJxjbDtUoN76o+IjLhg/dYgcKSJqwUI5a2eU2szlq1RKANIrAIAh72SxtsOJD
         s9KUXx3k8j+XAeCSmm3K+39jB+pKgGDeDCRrU7CApv6LrWZR2iJ7Vii+M5S4aq8new0V
         iOdhFWgbBI3I/ryXmnL/KLIe3JmCWrxhi1fcLk/++6API6iJtk2+efoyVJX/yE2x6DqA
         b3EQ==
X-Gm-Message-State: APjAAAXB5wxHDR7UIGfxM38GgjDRxOYSvKShnEjLVGtkLBgwCBoZLdLB
        5x2sOh7C1p322Y+QMbkIKm8zMVg+bWY=
X-Google-Smtp-Source: APXvYqwJt6rpKYv4NezCN63aRiLke6SHXGxQyAphZqpr1DhioO0h0+s/h6qy2e5+/+g/M/sp9LWjrg==
X-Received: by 2002:a6b:8bd4:: with SMTP id n203mr7754038iod.133.1569377085155;
        Tue, 24 Sep 2019 19:04:45 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id u11sm5341777iof.22.2019.09.24.19.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 19:04:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 0/3] scan-build fixes
Date:   Tue, 24 Sep 2019 20:01:55 -0600
Message-Id: <20190925020158.751492-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches fix a few problems identified by scan-build [1]. None of
them affect behavior, but they do make the code easier to follow and
ensure that the compiler is able to optimize it to the fullest.

-Alex

[1] https://clang-analyzer.llvm.org/scan-build.html

Alex Henrie (3):
  commit-graph: remove a duplicate assignment
  diffcore-break: use a goto instead of a redundant if statement
  wrapper: use a loop instead of repetitive statements

 commit-graph.c   |  1 -
 diffcore-break.c | 15 +++++++--------
 wrapper.c        | 11 +++++------
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.23.0


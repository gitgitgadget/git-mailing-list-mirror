Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102411F42D
	for <e@80x24.org>; Wed, 18 Apr 2018 16:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRQbx (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 12:31:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45839 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeDRQbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 12:31:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id k9-v6so1425642pll.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e8ipbfAsIl2WN5dGMntZ+BqGovacfK7XdsYMyQzN8Mk=;
        b=nvq94fZYZFs6FtRtvOB/P41dg2emefUJe7SPsUXiiHDZKyXKsyz7r3Ga2B9D1kYaKF
         awsLr9ieFu2JmL/GypS4y7dtYirX4T/y1iLKDg1fWVqQ8CXP/7dtdR76X/l5DiOWpjrT
         MjIy5zkK07HI2b/WhXRvs0wOfSI0hUJK7FYXVR85YbTVaz+2AVNjQ7Pxq2PAkUq5dwzW
         yY2nmSoFQf3FcymKxLpqy2jWIinB78HCgMLj8z7a8KeUIxszDFtf1Ak78N1XLfqA67LN
         co4S5TxMaNUgDgAzDA+Re30RTpM3Eay6Gh1RPKcKWhMm7jCIClu5i6zqChmddmOjd3iP
         lR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e8ipbfAsIl2WN5dGMntZ+BqGovacfK7XdsYMyQzN8Mk=;
        b=SP0SYqNwG5oIWqHgHQgnEMKm29M3NtXRD/Pa65TB3QRKEGASvGTFaTCk0VojIVtH2d
         +gDUKOJOidy39z0OmHsLXeYpyj/bvuezIoo+y76qFAHrUqu5Q/rv6pzjZ2kV74btPKY7
         qn/00fyNFShayBBtUZEmavgVQCK2Jha1SyXqYRcNjjfzrCU2aMr7DEJAtLIx/NqsXXIg
         9m3pn505dbLTeBKOfqYMphgNRRhwSTjMAFV+O3hjpqG2FD+8autEN3vJ5Cae8+tXQFHY
         m+3kb3FQNuG2RBsSyL4GpRNsEjPoycQ4HuR67rrDFMF5p26lWeR316GP0wX4AH5tnG9S
         IHhw==
X-Gm-Message-State: ALQs6tBPuQ36b0tFZViogSqKNRp+4Z9aLA5miGGJHlLMlfp0BNtUlpLC
        bC2/vwNlfiAqfNdbtpAUjcdWISMf
X-Google-Smtp-Source: AIpwx4+0Q6D33hDCeW3a6vZL/MEFUGwH+qnf9VbGVGy03zpf31nFWCxAnehwN/gVezUPg7qSXkIQNw==
X-Received: by 2002:a17:902:9898:: with SMTP id s24-v6mr2698212plp.51.1524069111862;
        Wed, 18 Apr 2018 09:31:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id 81sm3404990pfl.92.2018.04.18.09.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 09:31:50 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 0/2] Fix --short and --porcelain options for commit
Date:   Tue, 17 Apr 2018 23:06:53 -0400
Message-Id: <20180418030655.19378-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all - I last contributed about a year ago and I've finally found the
time to start contributing again, and hopefully I'll stick around this
time. Figured I'd start with something small :)

Samuel Lijin (2):
  commit: fix --short and --porcelain
  wt-status: const-ify all printf helper methods

 t/t7501-commit.sh |  4 ++--
 wt-status.c       | 57 +++++++++++++++++++++++++++++++++++--------------------
 wt-status.h       |  4 ++--
 3 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.16.2


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9581F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDIUmN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:13 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:33233 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbeDIUmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:12 -0400
Received: by mail-it0-f42.google.com with SMTP id x144-v6so12831462itc.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Re0aDF6z94PHM8U7wSo5PUEfIdTN1eWxyttRPEGJfNY=;
        b=CszpWuwYvbNINkiouW2dftMbu5NDT9vxPEVCzwK6lim92CBDpZ8EM5NV/cMtupJMY3
         C+fAkzx8eK+QqDLTjfEsMMLc8imn7Mu/lTamlTbiM3Zpck3bWlWy4FwspQuarh9MLbEP
         keMMzEHuH6dMoTRGIh82sVmv/cDEHxUMj2nkjYdt3EKe+JDMlX9Fb99Dx39CKWeJXloW
         S3W9y/0R59qh8MeS5LMtJYGjZqqwX02UE1hx5Qg2q26g6t8UkTUtky8TBpv4Isup5dxZ
         ZL22t3juVZ4ivrl5iHIpD0YJOe545hJkFT2KgUDsB8mU9fkGN8sgysjQjdebtDxG1X4p
         YnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Re0aDF6z94PHM8U7wSo5PUEfIdTN1eWxyttRPEGJfNY=;
        b=ESW/2iFkRpiNfxWPHqpg9UfRpl78kIs514U9gXwn7c1b1kVBmxGjzhksYyRc/nqSno
         iF3MQLPp2J6GGvO62/TmoXdXf0saWOh+Wb1PDOkMOCUzXlME/lwlXQ5Kj/PnfdGslGYd
         64Vomr8uyes9acIcQUlLuZINdb3rQd9wdPWZUgRcjctByVXwBJtXSayP/o0K+a4NgsBL
         JsWTj2Bo1Il0OSFnPzMFcqK1QQ92jmsGfHWkhErs7CXnZrDMgxoLwLujG6vjpupY3L+I
         N0fs5ldEbkTJSfcu3lZP3MfBTJjkCGgPQAW1Uw4ISuXcJZr4eZ6qS/nkWfKHlPEq1UH9
         xHeA==
X-Gm-Message-State: ALQs6tB1ZdRRT463PcH4STRYJhHuDhSm99DXJCzszhx0jbwaFhHttyzi
        CD92sw5eUQ882bhCb5qkAQiteZST
X-Google-Smtp-Source: AIpwx4+ETiucu3lajsUTOZ/IAvlGZe3rVTJ99g+1q6GDN6eaFsQ8tlZTj/eLPAym3cx01kCjI/BB3g==
X-Received: by 2002:a24:6c4a:: with SMTP id w71-v6mr1620976itb.87.1523306531999;
        Mon, 09 Apr 2018 13:42:11 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:11 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 0/8] gpg-interface: Multiple signing tools
Date:   Mon,  9 Apr 2018 14:41:21 -0600
Message-Id: <20180409204129.43537-1-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series extends the configuration to allow Git to better work with multiple signing tools.

Ben Toews (1):
  gpg-interface: handle alternative signature types

Jeff King (7):
  gpg-interface: handle bool user.signingkey
  gpg-interface: modernize function declarations
  gpg-interface: use size_t for signature buffer size
  gpg-interface: fix const-correctness of "eol" pointer
  gpg-interface: extract gpg line matching helper
  gpg-interface: find the last gpg signature line
  gpg-interface: prepare for parsing arbitrary PEM blocks

 Documentation/config.txt |  40 +++++++---
 builtin/fmt-merge-msg.c  |   6 +-
 builtin/receive-pack.c   |   7 +-
 builtin/tag.c            |   2 +-
 commit.c                 |   2 +-
 gpg-interface.c          | 198 +++++++++++++++++++++++++++++++++++++++--------
 gpg-interface.h          |  67 +++++++++++++---
 log-tree.c               |   7 +-
 ref-filter.c             |   2 +-
 t/lib-gpg.sh             |  26 +++++++
 t/t7004-tag.sh           |  11 +++
 t/t7510-signed-commit.sh |  32 +++++++-
 tag.c                    |   2 +-
 13 files changed, 336 insertions(+), 66 deletions(-)

-- 
2.15.1 (Apple Git-101)


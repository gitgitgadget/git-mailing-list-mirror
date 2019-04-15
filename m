Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D2620248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDOVFO (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:05:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfDOVFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:05:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so23813408wrp.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1wVJehgRfY0bOYUSSzYcdr88VtpeVmDIKs5PCjXjaE=;
        b=uTW1ST1Grqn7kPQ6ZsvsRmnVjWNEFnLXHtR7K2rBVp7iJm5unxx+NsMpV+IzPaDGxU
         BJsG6iHDbCBvuTavdmn5czEHxmKnJqlpzxrOHDXLL50X3w7l0+cvK1SpLbiDGhDIYU5b
         V/+WcuZH7Da3akYjIFcCCFYCNRvCAOywTG8qQnSSYEcQDJIAZebHqVjvbp8eNKPMM6nE
         38elYs+XTuXg1dCXIcNLvkow71lDyfD7NEQ6AuJiJ4HZhFxq8sgxI7DSJnFwHwlgGIjB
         Wz5HPrQ9cgVPEPSox15C01MFUDZ3bTMJGxgNIUDJKQrE0FUeHder4EVg7CaJ9Q1Bx4T3
         7EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1wVJehgRfY0bOYUSSzYcdr88VtpeVmDIKs5PCjXjaE=;
        b=pM6yORhWcbW+Og404+Fc1sZGjUcwZLVTBEwjg/96yzD1OUfEaI8qOYOeNNB9HfHUHX
         WiCmG3Q4gDhmu6HZMmrxSrMljiskCgF66Tji2+8dp/riHwQ5oB3VFsunFNa0qS7t3Gil
         boTj5tF/a2A9hIVCs13ogqKLxnuI54Sna/Qp46j+0tcqaPU4LxQB1FxUJsey4En9cflB
         TCnAS5XLGRnwFakqRbagTOcC/e3oN6B+fHJMOiVjRHEvksE1CPWULubuscebh0oRdSyB
         mF+BrDOW0RERg8taqAQtT0L9AMI02XSu5FNVJMBjNCI0nATVxgWZ4cVbJ1xfp8gHq/5m
         FbbQ==
X-Gm-Message-State: APjAAAUQjwT1KCpwgxFnRklRtbhxzD/vo57WE5NIuMrYaOhbfS2tXODi
        vAhsU49KreR+9kRx4yiHIiRI/895
X-Google-Smtp-Source: APXvYqzX9PvT8ERFv6WcNY1D7sgP87UKy8GIhI6ISgB9XNmhKdxmcQdSszegtPL0DBVXScrtbPvxjg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr47380623wrq.48.1555362311959;
        Mon, 15 Apr 2019 14:05:11 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t15sm50976899wrx.22.2019.04.15.14.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:05:11 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 0/1] Fix a bug in ref-filter
Date:   Mon, 15 Apr 2019 23:04:15 +0200
Message-Id: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developers,

Testing the behaviour of git with respect to pushing and pulling, I noticed
that %(push:track) in git for-each-ref reported the wrong value (ie the
upstream's value rather than the push one).

This patch fixes that.

Please tell me if you would prefer I split this patch in two, one
introducing `stat_push_info` in remote.c and the following one using it in
ref-filter.c


Damien Robert (1):
  Fix %(push:track) in ref-filter

 ref-filter.c            |  7 ++--
 remote.c                | 78 +++++++++++++++++++++++++++++++----------
 remote.h                |  2 ++
 t/t6300-for-each-ref.sh | 12 ++++++-
 4 files changed, 78 insertions(+), 21 deletions(-)

-- 
Patched on top of v2.21.0-196-g041f5ea1cf (git version 2.21.0)


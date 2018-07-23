Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FC01F597
	for <e@80x24.org>; Sun, 29 Jul 2018 00:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeG2CLA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 22:11:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46367 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbeG2CLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 22:11:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so3876625ply.13
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOWBdqj3t5ZQgZHlcAPCTbE8ji5jfCxq91HtdWE3WDQ=;
        b=RmMKx7nNT8Iygyqiswp1Vmb+6mryeaS7cmGbw8dmRLP6AxRlMFub9dRbHyzMMdwhfJ
         8r2fiJ3rVR4qzrr4SqJHPDN1GmkOWB+wfijz9zq2So5BoP5YPwIThO/FNneR2kI8MwFH
         zwRqRF5LgnyWzaH3YDqV11Y7ebthVv8eiqPOMbJlHrIsDRa2zP3nPZ/39B6JycGPS4Bh
         +LyNCgeJlmymY3sKqEF/grEOHcQo6fFKM6RfGeBskGA6LuJc7BfOsn6zi0x2/n/a7k9E
         BgPoVOM8unX1E+5k8e1RzRXWx+OVS3yDe6Xmy77KVJG1nmawCF3xIqJlm2D5xzQbvv6f
         o5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yOWBdqj3t5ZQgZHlcAPCTbE8ji5jfCxq91HtdWE3WDQ=;
        b=kleCgk5EytxJ7KUe7p4NeTQStWLR1pmNMXRlaFJ7vuyw5FwG0tKwFL7pLXwfwxIQ0I
         5y65/f+O3NwGvf9PJC/dpKVFOjk08XD8YOpqhm8z5BTb0Dgjre6gXCej9NrgckQPYnYh
         3MLktIhw0cpVDxkmexiQF3d6yPsmekzrJouHlDqFQJPpcem1O2To8BvztL87/wCIBR9v
         Y9OAg6kAwGd5YXDZfE4hG98ek9jSaF60zzzv3cCxjYQgVsnWUAAR4evYC1JaPAL+ji6O
         uVYHTcPITyhpuTwxjjWOpoIBP654KiwJwN3qJu9UaXWrC+RiMW11ZQgQcWbHRcIGUx9Q
         vaPQ==
X-Gm-Message-State: AOUpUlFEhMWNk/FhrXPN4c/E/BStYRjnGUS3abMDUE0PKu5GeKNYzrJg
        W8wp3uJvi8BhyfwfPI+stNoAiYj5
X-Google-Smtp-Source: AAOMgpc5jCOvh2FzWhvAmBYqW9XYios1dgPhe/NvbyjUpOP+8wu4ocxag/Zov6qs9eUjMVrjsc0pvA==
X-Received: by 2002:a17:902:b608:: with SMTP id b8-v6mr11362860pls.312.1532824955804;
        Sat, 28 Jul 2018 17:42:35 -0700 (PDT)
Received: from localhost.localdomain ([104.132.11.104])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13034856pfg.106.2018.07.28.17.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 17:42:35 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 0/4] Rerolling patch series to fix t7501
Date:   Sun, 22 Jul 2018 22:08:59 -0400
Message-Id: <20180723020903.22435-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715110807.25544-1-sxlijin@gmail.com>
References: <20180715110807.25544-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on Junio's review from last time.

Samuel Lijin (4):
  t7501: add coverage for flags which imply dry runs
  wt-status: rename commitable to committable
  wt-status: teach wt_status_collect about merges in progress
  commit: fix exit code when doing a dry run

 builtin/commit.c  |  32 +++---
 ref-filter.c      |   3 +-
 t/t7501-commit.sh | 150 ++++++++++++++++++++++++---
 wt-status.c       | 258 ++++++++++++++++++++++++----------------------
 wt-status.h       |  13 +--
 5 files changed, 298 insertions(+), 158 deletions(-)

-- 
2.18.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CFE207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934779AbcI2VuK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:50:10 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33019 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbcI2VuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:50:08 -0400
Received: by mail-pf0-f182.google.com with SMTP id 21so32956068pfy.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AyrjuWHyuZdGqqZpDL2x0nlkWsdtgmNHH3ecDGZxABI=;
        b=NjLxIjNL+lfDGnVIUrBBXrQcEqTM4W+Qp+TpfzzlMVJUsvyC0TZWxKaSui5u8FTtsC
         6TvDX13DWm6PkO5o0SDJYP56NmRnYESzSerhUSNtwrxtkDeA6OhGs/mqhrJX2tEpKSTD
         x6UJ+9SPsHU721l8g24k6jvnnwbHZzPdZtug16mpFI0wzKDsHleEYX+e54fs6rJc7zUY
         33A1GwrsBEbWi92im4OVglZx3utug1tn8fQlimj4pveYKYSGmXOwgoW1QJ0TvZ32gKpm
         vWSbAfeBK9axtNginwV28cVYcPQvHJ/+peQ8aWxbfbslJ0XAg7KruSBJx4CgAdhdPrKD
         2SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AyrjuWHyuZdGqqZpDL2x0nlkWsdtgmNHH3ecDGZxABI=;
        b=MKDR83+j1kUZgqJvNhqk5Txm5zAfNUJoNyNpwlid8r3NwzuHL9Y68KWKdoV1+zfdc3
         knHj4C0rGcmAV46aShEWoKITcYG+pCFuv2/MUVipZPfZC8L+rqp2A004IURbSmsdPzQ+
         36xWi++1vzYCNTdy5JRh85gCjdF/Me3mSyc0wm+mNWVCKzsMTfdSHZr5SZbNo5tRvz5R
         TI4ducweS3hFvA6wuBH6rcp3iF6x7k2ZbVzJqemHUqIqBHqwruTgVD80+vqdi8KkAvVm
         eK0wLwHTOYqYqDia4zBwZIp73mqIeu3qZQ/TLaaclgH0zmsVdXns4S/TgdxgYImPUkFc
         DHsA==
X-Gm-Message-State: AA6/9RntjW2KqW2irDjiLSlefpENAKx6jXNLp7pZDFBqBaaeGtV/wEktUUnRWPTAscYxfzuk
X-Received: by 10.98.18.77 with SMTP id a74mr5161727pfj.71.1475185807945;
        Thu, 29 Sep 2016 14:50:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4c71:119f:edd5:cf6c])
        by smtp.gmail.com with ESMTPSA id z66sm14576686pfd.11.2016.09.29.14.50.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 14:50:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v6 0/4] recursive support for ls-files
Date:   Thu, 29 Sep 2016 14:48:39 -0700
Message-Id: <1475185723-36871-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475099443-145608-1-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor fixes per the comments on version 5.

Brandon Williams (4):
  git: make super-prefix option
  ls-files: optionally recurse into submodules
  ls-files: pass through safe options for --recurse-submodules
  ls-files: add pathspec matching for submodules

 Documentation/git-ls-files.txt         |   7 +-
 Documentation/git.txt                  |   6 +
 builtin/ls-files.c                     | 202 ++++++++++++++++++++++++-------
 cache.h                                |   2 +
 dir.c                                  |  46 +++++++-
 dir.h                                  |   4 +
 environment.c                          |  10 ++
 git.c                                  |  28 ++++-
 t/t3007-ls-files-recurse-submodules.sh | 209 +++++++++++++++++++++++++++++++++
 9 files changed, 470 insertions(+), 44 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

-- 
2.10.0


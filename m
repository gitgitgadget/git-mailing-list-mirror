Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCF2202BB
	for <e@80x24.org>; Fri, 29 Mar 2019 16:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfC2Qc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 12:32:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfC2QcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 12:32:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so3140520wmj.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=Rib1lk1ItT6/jMDfv0WiN9y6m9olZbkx7Afjpi6NuwE=;
        b=fqhhYE17OuhA9Y2nSb5nvnAuNv8ne8F2mNP2QEDopKafjaSUC7MtQ6L1rsCTHsZtU6
         GpuqSU8y+Lmuy+elEM/v5wiizuDO6PPkPFolslIAzZUCNza4+kV7et96D7LqK3JY/2zd
         wyp4ubCrErw7F+i9vqbCHP29rTR0lG+jzuSi5wwbwtAxIIabpWgIv/V4966SITs8Bn61
         ctrjOdtVFE+wvLLnwOiYg1aX0lrp8UutgzTO1NF3hPXMLg1X5jy9fi3PlP1Nac+GrujG
         59EOJn7Gz3f7n3Uj7MEpdUq8bTfJDCFbXBqQs5sSpDm8QqwBAOOj8Di3X8i3xvlHX6Cn
         U66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=Rib1lk1ItT6/jMDfv0WiN9y6m9olZbkx7Afjpi6NuwE=;
        b=MHduy3BZFb1TCeRWevoCmSEdMT2YclOrcYLl43j4LVYBkC193V/IMvvJoYowhPBUC0
         EFejHY27Oavj6kWK2wISXF4gKJvqEqSgL0/NjU05TLzZ2A5At641JaIIcvgL9XM1arII
         +ljW/uVUYyN8T0jh8RtBRMv2jHGs33dTAxAi+/DPwzEpSAHIQbU9O9dFuto2h+MUjJX7
         qgMC1vswTpO3jJkzeIlRfyjG2KSuPupsXyu6AOHugamLZVSxJSg46zTr/1hacPZyfNbl
         iAvfhObEc3KX8bJPZivYFgCDX5nUDnLeiNuwggHcUW2SjcWR8dYeN6rLuHsxYPrld2gB
         1Cig==
X-Gm-Message-State: APjAAAVaAE8c9oLUeSNDmNOquuacN4syMXYksue9yuSOgwjhTWEHAPjc
        HxWaulef5fmp+wnfrPaERq6hD4+2iJE=
X-Google-Smtp-Source: APXvYqzkZ6PW5eQ7feeOHbslcM8VqImaUserdDc574sObGpyxpOg84tVMITQfg7bFzZArIgB8s4epw==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr1827427wmf.0.1553877143651;
        Fri, 29 Mar 2019 09:32:23 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-191-183.as13285.net. [89.242.191.183])
        by smtp.gmail.com with ESMTPSA id j64sm3463175wmb.36.2019.03.29.09.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:32:22 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] A couple of cherry-pick related fixes
Date:   Fri, 29 Mar 2019 16:30:07 +0000
Message-Id: <20190329163009.493-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

See the actual patches for a description of the fixes, I'm not sure
about the second one, see the notes on it. I'm going to be mostly
off-line for the next couple of weeks so it might take me a while to
respond to any comments.

Phillip Wood (2):
  commit/reset: try to clean up sequencer state
  fix cherry-pick/revert status after commit

 branch.c                        |  7 ++--
 builtin/commit.c                |  7 ++--
 sequencer.c                     | 60 +++++++++++++++++++++++++++++++++
 sequencer.h                     |  3 ++
 t/t3507-cherry-pick-conflict.sh | 19 +++++++++++
 t/t7512-status-help.sh          | 19 +++++++++++
 wt-status.c                     | 12 ++++++-
 7 files changed, 122 insertions(+), 5 deletions(-)

-- 
2.21.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EABB1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeCURou (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 13:44:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42422 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCURot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 13:44:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id f10so2045704pgs.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EbwG8c7jzYjQqaWzM+xHGk7lZmkrX7fJapa1+xI85QI=;
        b=KktM4mzdNeaVkmhL7MeEneEo/jjRJZZtaG5VFZ6Tv1aGCF5DnZdKrLOwWS28hTqijc
         3sSYCbH7hDhL3erDR4oWWdck1iIjywZUHjbcrZkGtOvyVuZOkUnlNcHGafR/JtWSp3TI
         yNZ6bfB/risXr18qVq80wGhl/kmpnLpHmZxNq0lco5HBvG9Z+VREq0O4U6xLECODVAnk
         EECxZi1G24Q6YOTAQJNbAlAkU14p/o2f/euYL1Hm4w2oNs55koR2lcY0G7VwnMRKwrHq
         WYav6qbNULnDTGb2AiMajjNiMnO4KSvo2UaS9x7PNQis+gXM42EdJkCEMwPe1P2UdXYY
         5ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EbwG8c7jzYjQqaWzM+xHGk7lZmkrX7fJapa1+xI85QI=;
        b=C08GZI3CRMJUImg188M2Qa/XY58ROEtAJsIHy+I27e+Y6oF+HUhXq7cswG7GDlwXyJ
         fe2rFRO79oZUKKWwavp/G71gcMMAkuvCcrnqBdR5VrwcNpRrRE/eu9zdzw2yFY0iaz8T
         PO8bFSvqhHhHjWtZqLWZ3ggShYehmYETpqGIFZ77W51/hMzMlDKeXJZr2120s9FmkVib
         acduHtE/UP9aM8dzGye5ni26Hu08W+Qud8AfXBshkjJivMAVjmba32MuZHAJ6A6qxZWg
         wk4jCWclPEgWEdwPEgc1pnFWSG79JVA0m8kpoWl1S05H5g0RSQQ+h6bMvlRu6hpLSonv
         dw5Q==
X-Gm-Message-State: AElRT7G7j5rprYsmOF46f56i3BKB66s8qfGpmlXeMbODK6a9X2dnxEKR
        L8Hdygk41JLfMXyYpNjQuXS+giTrd14=
X-Google-Smtp-Source: AG47ELuOhn4eiw+SB4yArrS2K+nJRkCLjnnuuHaEcvAilAylWa1R3ft6WQX5FCZNtmvGxvJRqEXbzA==
X-Received: by 10.98.79.90 with SMTP id d87mr17638635pfb.41.1521654288045;
        Wed, 21 Mar 2018 10:44:48 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id x3sm8172453pgv.86.2018.03.21.10.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 10:44:46 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v2 0/1] rebase-interactive: Add git_rebase__interactive__preserve_merges
Date:   Wed, 21 Mar 2018 10:44:37 -0700
Message-Id: <cover.1521653702.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
References: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version 2 keeps all changes in git-rebase--interactive.sh this should
make it easier to use blame. But there is quite a bit of refactoring
and reformatting so using "git blame -w" or "git blame -w -C -C" is
needed to improve the results of blame.

I can break this into several patches to have the history show the code
movement more directly if that is desired.

Wink Saville (1):
  rebase-interactive: Add git_rebase__interactive__preserve_merges

 git-rebase--interactive.sh | 469 +++++++++++++++++++++++++--------------------
 git-rebase.sh              |  16 +-
 2 files changed, 273 insertions(+), 212 deletions(-)

-- 
2.16.2


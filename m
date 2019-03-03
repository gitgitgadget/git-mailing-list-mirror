Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9F120248
	for <e@80x24.org>; Sun,  3 Mar 2019 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfCCM30 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 07:29:26 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34933 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCCM30 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 07:29:26 -0500
Received: by mail-pl1-f180.google.com with SMTP id p19so1191929plo.2
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 04:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bsz9OlZBCFRHVQ0ebD5sCZ5egfwAUx3fM/rGy9qWnZI=;
        b=s7WmHPbmqHyNd/2lBUgI/BIr909klhmftM1isLf4FsRZH3NJKbpNEzaFuo6Ve5Xa7p
         +9ApsXOrlBUIRDdK2H7TnmtrVnDDhGFFday/5C+Bv9qhClzHjddxRccrG6KoDy339JLl
         VaKM2rhi+jQRBG3zKlOQAuL/F5zaKzWnUUWDwpzfDY41Uuq83TgEVjfUDcObzKHXrQwN
         HZ8v84LM96JAyIgQJyNjlVRKeA0e3Pfuj1bSl0btuUuQx6UCLPGmXhOKy6+SJBhXnBF/
         KIa7Aq6Ojvimn2/aLkxW4LkwPLQy8XHPD7TdH00IyFc1tVjMxPjQNVwXNs6CcI8ow70w
         wXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bsz9OlZBCFRHVQ0ebD5sCZ5egfwAUx3fM/rGy9qWnZI=;
        b=j0szfGDOMxPMxikbnMwFGH0vvx06A1sM9v1Efhj4RpDHLN53p+MpMAZiICzyUE3eX0
         0SETFl8RlcnFDRI7tqU3yKtwwIYlMzYC6ixmeVzqzwYJA4G76fFKmMvSkDS6iGtX5tVI
         OQTZrkyVROtUOL3Vc9oFNx8Spv8g6xWdgybnmGZscJSbftTW1NkozrLQTA7OM6zjvYsM
         Rthoj3fFX0bUKe+Z4dDWKGiCcsSM+hTzm3HwUR5Q2iFn3A/Lt4BcQGgG5PLZmi++7jD0
         jcX7kH7fkVehznwYGaXGJe4aLqOu44UIJkKYMZ1fDaTIHN8dV+dIZ/wc7Gm8fRih+gGv
         W/7A==
X-Gm-Message-State: APjAAAXRGI02ajUecuHwgmuZ0MHZuBuzc/qpRgvLUsdwkn/9r+bmuw4Y
        hWFVuLxVFa6GPX4AEswo/BC7K4SCmfU=
X-Google-Smtp-Source: APXvYqxYibf+fntdHYUs4B4bqHh6MmJCRvCTywUVJX6yA79plPiSIFvEODmr8AnVwYeGDW7xnHGBhQ==
X-Received: by 2002:a17:902:e192:: with SMTP id cd18mr15299707plb.309.1551616165243;
        Sun, 03 Mar 2019 04:29:25 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id l5sm6861093pfi.97.2019.03.03.04.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:29:24 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        t.gummerer@gmail.com, christian.couder@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 0/3] Use helper functions in test script
Date:   Sun,  3 Mar 2019 17:58:39 +0530
Message-Id: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch ultimately aims to replace `test -(d|f|e|s)` calls in t3600-rm.sh
Previously we were using these to verify the presence of diretory/file, but
we already have helper functions, viz, `test_path_is_dir`, `test_path_is_file`,
`test_path_is_missing` and `test_file_not_empty` with better functionality

Helper functions are better as they provide better error messages and
improve readability. They are friendly to someone new to code.

Note: `test_file_not_empty` is implemented in [PATCH 1/3] of this mail

Rohit Ashiwal (3):
  test functions: Add new function `test_file_not_empty`
  t3600: refactor code according to contemporary guidelines
  t3600: use helper functions from test-lib-functions

 t/t3600-rm.sh           | 281 +++++++++++++++++++++-------------------
 t/test-lib-functions.sh |  10 ++
 2 files changed, 157 insertions(+), 134 deletions(-)

-- 
Thanks
Rohit


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37071F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfGaUEa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:04:30 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41681 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfGaUEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:04:30 -0400
Received: by mail-wr1-f54.google.com with SMTP id c2so67788893wrm.8
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mDJ/nc8M3/Tdmrgj9feBPA4zsJAC1bqBZz5QAB+S12U=;
        b=ejm9WAsdbq+F17KMNBMrKf7s46/XXMynvg68jqYvn8wPRFctluYJ797tJHMxQar+YY
         SCcXKBARq/WXwnlpFFxMOHi2gnGBQ+y3h7TqZ50CCbR1PLnasdp8/2AADL8g3YZ8s69Q
         P65AOV5/mazMEBX+3rI/XLtq8P7P4lC/lau8GyYqd7qvmDhDYRaRRJAMz9YRXVbV5YRA
         3uKDC5cVdci6GVCoLKnzscT5wi6wpve/CKXsdDO1t+E21m2tDvBLJ2l89LMgs59FRzMc
         JpvUsT3liINFQc7Qe6g+JnSVNNvUze0tzbUE4WQfPuOWQckfQYLhSmY08w4Z2oViyUjS
         n0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mDJ/nc8M3/Tdmrgj9feBPA4zsJAC1bqBZz5QAB+S12U=;
        b=VeexoaW5AvZ6oKR7DWld7QqZfkWfVSJdhduWbE2FFDinxw3RcikrIwSf8+oZSQdwDx
         qsnYFF3b76x+Tc5dFDLRk8t5ug4kkTrJw96q5NfSL6gTMMjNeky5URbFRYbseBfU7HeM
         xic2l5yDwEI9wkm7age8bn930kZDghC3Q/1x3REzR0P1QVvjrTroHA1c9HUa9HuHMWGD
         mRvstatLmT+GpmE95Np7VGfFFy0BNDlJlZj9pTjfjv2I6B8E5iYkashUBP4HlA0twPyS
         Cre1/fc9VFKnyrEseLdFnm0UYa4Q85MP4QvvJyD/HsacdpB2YRuBrqWXsyXnVD0V1rSB
         ZPaw==
X-Gm-Message-State: APjAAAVIl8cXv0v5dyREIEXEgDr5EJZx/PBth4cxfRGA0+SuQyzUowZI
        8sFrMldUkOzcydOUYHBFvl1hFuG/
X-Google-Smtp-Source: APXvYqyIEHeITfU9fXW9Mm3bzHY/ottuGjZaIDo0sCyJJL8JwbiAU68IrfNShK519JVCUVzaPUTt6Q==
X-Received: by 2002:adf:e552:: with SMTP id z18mr139712560wrm.45.1564603468508;
        Wed, 31 Jul 2019 13:04:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm155101300wrp.3.2019.07.31.13.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:04:28 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:04:28 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:04:24 GMT
Message-Id: <pull.298.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] trace2: clean up formatting in perf target format
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

This patch series contains a few column alignment and whitespace fixes for
perf target format. This should make it a little easier to read.

Jeff Hostetler (3):
  trace2: cleanup column alignment in perf target format
  trace2: trim whitespace in start message in perf target format
  trace2: trim whitespace in region messages in perf target format

 trace2/tr2_tgt_perf.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-298%2Fjeffhostetler%2Fupstream-2230-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-298/jeffhostetler/upstream-2230-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/298
-- 
gitgitgadget

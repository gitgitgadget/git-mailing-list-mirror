Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794131F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCVQ5i (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:38 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:43241 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeCVQ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:37 -0400
Received: by mail-pl0-f48.google.com with SMTP id f23-v6so5681354plr.10
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LaRY8iYradRNxEup/mvablU/U4Hwc1RlmiQKxDF0b5o=;
        b=YrS0SlaYxMQUFQSbUtl2A5XozvFIUCwk0X8034bhDh3lchPN5Jg+PzrFbwVC1KHu9r
         JG/LvFBPJ7HWyl1Z6WbzQq2y8/w86Xx6L4jiWWTpbtDQm7SHTy+QQScpEvWxEGEvu8bP
         RX+wtZKVSflrqWDisNVD/jzPPGIJkspRL9gVnz48NZSGkL1N+Grruh8BbNGG1ThNFJ9X
         qL8u6Bx4KK+bdtfjQkp7WqvtV/b8k3CFS04HgrHCbUVQYVjulCg5vOQ8MOlU4Z7n9CQw
         7xDo46AxmW19JxV1JxXK4sGxMwLJRaFwdPymbl3j/RF72q9vC9XchnM9EH6RjwPFJ7E4
         8LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LaRY8iYradRNxEup/mvablU/U4Hwc1RlmiQKxDF0b5o=;
        b=YT+jIcjB6bIxKxJddjpFP6zO7M6W+5ImChmw1XLJI1FEnoPIP7e+ZmTSbrKX7gXAKg
         1P1k0fOrkaJ02YPN6rRiLRTBM0WavgjxmMZ/NJi+FKCfuJSakVHHnQabyUxTFgEiHK6c
         iKRMFG6ulonTxEsDNxG/p0OxkzQCda2wDrOdyLhxapaFlyqcNJc7KcJIFV+qqzfgfn5P
         YHsy79fTLvCvlQQuwY43ib732G5aFL6VJJ33kU4flw4AGVbR26kay1LHH577aR5FpKNQ
         R9r3eS9J5zeHvZX9PzoexwHtpSerPPpaGr+oSrlCNQy0GxSIKG+oYj8CXXvzGsSOocgz
         EhiA==
X-Gm-Message-State: AElRT7HXFWojGHuyMgHM1+owRQ7QGrAeSlkWetdMVPe/Q6zbG/L8baiG
        5Vj5hSaJj1Aq83BLy6srmVDiMqxiAms=
X-Google-Smtp-Source: AG47ELuN3NdmXiu18a8fbLRCObCQgl196qgSTaT1yobD9CM0c/XpZ6pUZiErpb9JR7g+JgxVJJvhVg==
X-Received: by 2002:a17:902:7b81:: with SMTP id w1-v6mr1926762pll.66.1521737855982;
        Thu, 22 Mar 2018 09:57:35 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:34 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 0/9] rebase-interactive:
Date:   Thu, 22 Mar 2018 09:57:20 -0700
Message-Id: <cover.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've incorporated review feed back to date. I'm split the change
into 9 commits with each commit do a single class of operation.

I've prepared these commits using github and have Travis-CI setup to
test my changes. Of the 9 commits 2 failed, the 1st and 5th commits, I
tested those two locally and they were fine. I then restarted the builds
on Travis-CI they finished fine so it seems the errors were spurious.

Wink Saville (9):
  Simplify pick_on_preserving_merges
  Call git_rebase__interactive from run_specific_rebase
  Indent function git_rebase__interactive
  Extract functions out of git_rebase__interactive
  Use new functions in git_rebase__interactive
  Add and use git_rebase__interactive__preserve_merges
  Remove unused code paths from git_rebase__interactive
  Remove unused code paths from git_rebase__interactive__preserve_merges
  Remove merges_option and a blank line

 git-rebase--interactive.sh | 407 ++++++++++++++++++++++++---------------------
 git-rebase.sh              |  16 +-
 2 files changed, 229 insertions(+), 194 deletions(-)

-- 
2.16.2


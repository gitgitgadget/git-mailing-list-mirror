Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E031F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIFHVZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so9628450wrr.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eouvu+xWlCp/AJS6UeMl87qI/KKOKceqHJCLdLZ5R4E=;
        b=nMY+8seqsGticmooSEqJqjXFVXWjUhJEvinEbO/P3obJgyBTvqCjFKX9hmNzX5Z4qZ
         aMAIQr6o4F8QM7fMkVlcZyycLKi/GHG6aaGR/CGw5AsumpscodVXKPZWOpfOJDxc+RHI
         GNP5zMuciYWj5EU6+xbBsCv9BKoQTLoI1l4SRgTCCgecAAoYvRDHr1WksCC62pXReC8V
         STuZZS9mUBtXtGy3zgnBPTxsn5IJtZMCvR6d4QMZcqoy6BT6m7JEPVrq4zkBfVpmCIAQ
         Qnt0c+ntu3BOiANlfSbYpvR+lNcmYgrQNfqIYJavUypNV5+LGSuURhFQdh5+2jxJ3nBN
         oAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eouvu+xWlCp/AJS6UeMl87qI/KKOKceqHJCLdLZ5R4E=;
        b=ry/H3De/nNb4ydyyWjUoEC4qh3VB7K2doZ/J3BvJPRgedGXorYYxhrbuxaokDmVaiu
         s2ce3dMriB7IUR+0mGB++f+QktfG1SzzJbZeAIJ+AAr/uY/BgrsHbgdOfzHAXvdkWP51
         wG4HPw8Jb41hBhnXg0F52QyTfFbESJCeXW1sYS585wvbimEXybYYUG74CmJ+1/QTUSrU
         Gyxkc5mCiTJ/LLKcK5I2Dadh4JPJVfZeuIgTdkcAFyxXpOGtQ7M+EbbJchKml7QJBRst
         VeiZuxMUcnuQnW7VUNW1mqa5O3BsR4iCoCnOMIjoLDMQZdTtXXRS/MM9kZWOrxP7yf5P
         1/Fg==
X-Gm-Message-State: APzg51ABn7KAulxOahdQKXI757wusEFZQCFOrDS4ljjOE/TYN7MV0PU6
        auYutkd+3zgpjDwZMPHEG5hHoZfg+ZU=
X-Google-Smtp-Source: ANB0Vda6/0j+vFMSlYgamv4DGPmve4q26Ni7BOlEQKvGh33qfTUm3XYONLjA1Yq/kj4A3G31u3oaew==
X-Received: by 2002:adf:eb0d:: with SMTP id s13-v6mr432201wrn.174.1536202098022;
        Wed, 05 Sep 2018 19:48:18 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 0/5] Fix the racy split index problem
Date:   Thu,  6 Sep 2018 04:48:05 +0200
Message-Id: <20180906024810.8074-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the split index feature was introduced, refreshing a split
index is prone to a variant of the classic racy git problem, which
caused occasional failures in several random test scripts when run
with 'GIT_TEST_SPLIT_INDEX=yes'.  I won't go into details here, there
is plenty of text to be read already in the commit messages of patches
3 and 5.

RFC, because I'm not sure that the fix in patch 5 is the best fix for
this issue.  ... and because I usually don't dive this deep into core
stuff during my Git hacking adventures, so who knows what subtleties I
might have missed.


SZEDER Gábor (5):
  t1700-split-index: drop unnecessary 'grep'
  t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
  split index: add a test to demonstrate the racy split index problem
  t1700-split-index: date back files to avoid racy situations
  split-index: smudge and add racily clean cache entries to split index

 cache.h                     |   2 +
 read-cache.c                |   2 +-
 split-index.c               |  12 ++-
 t/t0090-cache-tree.sh       |  18 ++--
 t/t1700-split-index.sh      |  51 +++++++-----
 t/t1701-racy-split-index.sh | 162 ++++++++++++++++++++++++++++++++++++
 6 files changed, 216 insertions(+), 31 deletions(-)
 create mode 100755 t/t1701-racy-split-index.sh

-- 
2.19.0.rc0.188.g56c5ee2db1


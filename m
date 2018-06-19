Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6961F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937308AbeFSIE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:28 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44363 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756428AbeFSIEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:20 -0400
Received: by mail-wr0-f177.google.com with SMTP id x4-v6so19471232wro.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YMeY6zhhXMTgdHGD2GISEKxcRS2hDQT0OFsM9hy2uE8=;
        b=ewfVeUayrEx1KTL6tHvxnRWzxFMI37PktGoMT3UQYaUBEzW/HV4mBiXx7XOkwDlZd4
         zezZW+y5Oes1+8tTYoqOlbTOomeFpUvfTDuFdh0ByvnJ7470cCQDPQMA1hfgzDIfU2Wj
         vV+l2DwenYSo1Gj1EbJWXpz2iX23byLatTm1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YMeY6zhhXMTgdHGD2GISEKxcRS2hDQT0OFsM9hy2uE8=;
        b=R2nP9cyy5pTjKLcgfsYZzO6RgW/V0X6BzdLz4MtvwmWMWpAIk/u2EdPFLDn1FbUZhw
         49Ek1wsAyiKdVsY7c/6mFjBQOfF2z3wN1QfXBdDgahkouw1yO6ZJzgTzNU15lyv/QzY7
         hZSdmjfTnzpRLLwtUH29uZ9BXhu8hkWLL0Sdwb/M+4sk94YixrQk9slt/hohdLdqSU1K
         AiYiBlAluL3K+DR/jPM+0FVvYetFbdy4EFN8QaOH5yxCY/tQzCS3VHDmgF2mtM+KKX8I
         I0zqkTjzIomAjzST52ry1ml6/SWoHuv8Uka8IlaWL6fjl5/YUgLIAOFq5JjnY3BRHbs2
         Dhuw==
X-Gm-Message-State: APt69E0eoKJOFs5UrldVjDJeSZygGJYTjOZg1lTxzGF9L5jCoECRwoUw
        Odwqa3VoZ0F1RVQV+A73TBMn8E6t
X-Google-Smtp-Source: ADUXVKJCHebrlMSbEGGVUOoCDKl9Sd3C8+VStIZFIROKbFDaHPPhR4O948K/yA0xXprro58XBI5YyQ==
X-Received: by 2002:adf:878c:: with SMTP id b12-v6mr13670119wrb.92.1529395458505;
        Tue, 19 Jun 2018 01:04:18 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:17 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/6] git-p4: small step towards Python3 support
Date:   Tue, 19 Jun 2018 09:04:05 +0100
Message-Id: <20180619080411.6554-1-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset is a first small step towards Python3 support for
git-p4.py.

These are all the nice easy changes which can almost be done
automatically using 2to3.

After these changes, it compiles using Python3, but fails to run.
That's because of the bytes vs string change in Python3. Fixing that is
quite a bit harder (but not impossible).

I have some further changes to address this, but they are quite a bit
more invasive, and not actually working yet. It's based very loosely on the
"polystr()" suggestion from Eric on this list.

It still works fine with Python2.7 and Python2.6.

Luke Diamand (6):
  git-p4: python3: replace <> with !=
  git-p4: python3: replace dict.has_key(k) with "k in dict"
  git-p4: python3: remove backticks
  git-p4: python3: basestring workaround
  git-p4: python3: use print() function
  git-p4: python3: fix octal constants

 git-p4.py | 348 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 182 insertions(+), 166 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a


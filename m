Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6269E1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLSxA (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:53:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47060 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLSxA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:53:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so4668118pfb.13
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbxRb6hu572PoBEh4GOvciZs16IwXepbZ6o2oT7y3oU=;
        b=E+6QgP3ygX3j9jb8DiuFi5qfb+N9Fu7GNszRmQfoJ/mGvxqYqFQb5Noz9gb1LD/Xmp
         RgOMNxf/xFwXumTg2tkQzyxAJ978jolIPt5/lTt/hOlZWYywWBLSIImMm5ZHtdEvkAnn
         4vaFVhtrbACFEpZ/rX499QUAVHJvrb7d0yXVQ5SHIzkOO0pQklUFlmpI5cmpKokzGlPo
         V1ML+NIVImfRhTUOzGrxNQrcR+2hMF8Xh3G0UHTXMA4APCHn8JPTwrLYrQivsgFP0etc
         XiKLdog6LkKin6EePCBusYBM0sj9+uh2iFBnE7PKbEr1GusKrRtiZTFjAILIUTNEkeub
         Cqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbxRb6hu572PoBEh4GOvciZs16IwXepbZ6o2oT7y3oU=;
        b=YFh7iNvq9rci/gMm9Jg5uDVYSlNWAQKnrEhYxOrTXqY34LJGJP1gq7KDTrJ6uRqOTY
         0V31mEbpBRMthIe2bGbzjxI9utEw0H3GQy9NhcuAnOf5XmVthMQRLPNcXvmu1REfgESP
         X/HesEOJ0Cz7Wa9dhUgTuNIidIX5k7v69DlSCOr+nQhEvPJ9hhQncxpZ/dPPMXL4vBgV
         TrOjIooRMKhq0IxxybCCDtzNweqiZZu6E6KCnSIPyl7meyZVkymznR36teewBmvaOcg7
         YgU//F3Kkm0h9Vv6Hz7m4UsEbes7Fq04UwS9tdIxAScRiMIr+xgfDEjaJZK0CMTcsB/T
         OOwg==
X-Gm-Message-State: APjAAAWkX9MNPa/kccI2f+2ztqd1m8ChQhd2r1v5b9B3eZndLO76eRkk
        ERnPq3OJqhb9AxjTzH/HV8xZkPp0hF0=
X-Google-Smtp-Source: APXvYqz2O6dWMwJm8bXu4K187t0Jp9Ve9WSq+cid836REj7GWBRBAypBxGXOqUGx2YDd/QfUI3Zggg==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr14101561pjq.17.1562957578790;
        Fri, 12 Jul 2019 11:52:58 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id v4sm8475244pgf.20.2019.07.12.11.52.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:52:57 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     phillip.wood123@gmail.com, martin.agren@gmail.com,
        Johannes.Schindelin@gmx.de,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 0/1] rebase -i: support --ignore-whitespace
Date:   Sat, 13 Jul 2019 00:20:14 +0530
Message-Id: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc'ing Phillip Wood, Martin Ågren and Dscho; they might be interested]

There are two backends available for rebasing, viz, the am and the interactive.
Naturally, there shall be some features that are implemented in one but not in
the other. One such flag is --ignore-whitespace which indicated merge mechanism
to treat lines with only whitespace changes as unchanged.

NB: am's --ignore-space-change (also aliased --ignore-whitespace; see git-apply's
description) not only share the same name with diff's --ignore-space-change and
merge's -Xignore-space-change, but the similarity in naming appears to have been
intentional with am's --ignore-space-change being designed to have the same
functionality (see e.g. the commit messages for f008cef ("Merge branch
'jc/apply-ignore-whitespace'", 2014-06-04) and 4e5dd04 ("merge-recursive: options
to ignore whitespace changes", 2010-08-26)).

For the most part, these options do provide the same behaviour. However, there
are some edge cases where both apply's --ignore-space-change and merge's
-Xignore-space-change fall short of optimal behaviour, and that too in different
ways. Fixing these differences in edge cases is left for future work.

Rohit Ashiwal (1):
  rebase -i: add --ignore-whitespace flag

 Documentation/git-rebase.txt            |  9 +++-
 builtin/rebase.c                        | 24 +++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 6 deletions(-)
 create mode 100755 t/t3431-rebase-options-compatibility.sh

-- 
2.21.0


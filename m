Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5EF1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 00:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfA3Agx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 19:36:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43638 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfA3Agx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 19:36:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so24441740qtj.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 16:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nqRPBLuvy2bd/ppaxYCm+9GxJNUQfKqllEkC3RsMEg=;
        b=bcpRp4x3WtCbJzYkNla7loTLjGT8ZEBvKtfvmBJAVSb+7KXzFsMTRST+JI7jR14/nk
         hHCjRm8CY4uwawuyNEOZAaOiB+mlx3/uKyXtwMcGF+7VR/BHbTI28yvlyp6SVj+/usxR
         bk/RIRna18JLtZ/qUpYW4yj8N9Yy+B7gd7CmumPK9xBt9EN0giFd1kzbIOKelyn49B2S
         0iTSu/MrGvHYgH/bWKp3elWXsSWWrNkN+CtVE92SmvyHUnLCZH55M30VVb9Pf0DZtLjr
         wabTwz0oqrCT9GPt7cb+4Suwdl/UYQo56ffNchCB+zKMzj5rhN68vXzwkoJTIykb3hq3
         MkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9nqRPBLuvy2bd/ppaxYCm+9GxJNUQfKqllEkC3RsMEg=;
        b=dOuPUxhB/K2I4k06hNdxobjrT9uE7gQTbfLJ1rh1jKdEqoPoEhN2ILm/KcOz7Bs/Xl
         dP8B9joRrYRVgincZo0P+yoMpVZ1YMdL69+COTjBOjmHygWv6QEhp+VMxkOO7YQmwGiQ
         U2SZeu3uk1Fdi/aPa8RuObH/GQ7/x2Md9NS7OPgqmi7f3zt9ZNJPlWLvvLFEAZSt4qd9
         uQh7mp0CGCuxVgwdnNK/XIHwrFnPusMrc+WgbYMIaNzChLV5s10r0sVffSwk6shmsjqt
         vKw8qK/0iDkz4fc+nP6v1bfm21imfLnMev0ZleRd5AO3YttRTkHoO0ZhXU/dN65xHYrl
         5hLA==
X-Gm-Message-State: AJcUukd80FBZ6fAvfrtJF+JRiy/PRa4sl7j86WfB9fgRA2VWaqtsfxx7
        7yeXDCihJlENYcYwNAn1OO2to1E5
X-Google-Smtp-Source: ALg8bN50dMxxID97xKI3vjCTSQvaoMsY3cMlhdC+LtwrZ2hRrBJUiUskNr14S4TyXzpirfrPEye4/w==
X-Received: by 2002:a0c:fa46:: with SMTP id k6mr26064472qvo.36.1548808612192;
        Tue, 29 Jan 2019 16:36:52 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id u67sm80871791qki.22.2019.01.29.16.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 16:36:51 -0800 (PST)
Received: (nullmailer pid 15550 invoked by uid 1000);
        Wed, 30 Jan 2019 00:36:50 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v4 0/1] config: allow giving separate author and committer idents
Date:   Tue, 29 Jan 2019 18:35:49 -0600
Message-Id: <20190130003550.15502-1-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

this implements the changes requested in v3 of this patch:

- removes an extra comma from the enum
- reworks the logic for config handling so that the author and committer
  variables are handled along with the user variables.

Please review.

William Hubbs (1):
  config: allow giving separate author and committer idents

 Documentation/config/user.txt | 23 ++++++---
 blame.c                       |  3 +-
 builtin/am.c                  |  1 +
 builtin/commit.c              |  3 +-
 cache.h                       | 13 ++++-
 config.c                      |  4 +-
 ident.c                       | 92 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  5 +-
 t/t7517-per-repo-email.sh     | 74 ++++++++++++++++++++++++++++
 10 files changed, 197 insertions(+), 24 deletions(-)

-- 
2.19.2


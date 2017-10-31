Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3D71FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdJaAeB (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:01 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:57203 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbdJaAeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:00 -0400
Received: by mail-io0-f176.google.com with SMTP id m81so31295907ioi.13
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tIuE6of0XgcpduYIhIk5m2P8Bvgde2kXONepwVfyaAI=;
        b=ONqTFalHH163duw3AyiE6VepQ52Noi4MGuCamF49ht/UK0I3n5O7HsVVnvkHDIIz7C
         U/ppDkzvtZf1/ZzB2PpEYAOiUghb/eNMU9UujGxWqOQXy916P/NhKBn7Y9QJqxHrYjp3
         2EvSTMo9hkaeUxaNPv1bSsnezUD+3xSoxWsNj716nzbyT5mNb20vct8cT70DyLmurLGb
         TML/V8oEZwYVJwlfSLPgT1AGpZ1nTxhBCU/Y0JjmGBICaMWAwiFS6G65mbaPyy8+fxFp
         towb5EA6LBjtq+TrD/jo1LYm7imDIhZhklGum2evKSo7eDOUPXs2j18ii65wVudX/vs1
         Bqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIuE6of0XgcpduYIhIk5m2P8Bvgde2kXONepwVfyaAI=;
        b=kEbsnyEbVYxcRBwkaig/NSqfLYng0TsxfjOHig52DfOI3qDljCv4r/XRCYdPMurRrC
         +Mw6SalNz0BQScVSueH1ia1Om2Uy8/M0+JWOnxFuafaULdj2ks9DKZkLnk1hRnsgHdYA
         YMLffZ8vzVLwp4tRL46VXNS6uElmQJkpGY2+UQaO5vW5Yy12mDIjH+TNSWVaCD0YzufM
         92Bbx4bekxAgcMZy1ItCXtcpdjxzOcBdcMbHH3gyaDaAZeFkauvPfRr1wWaZWw4Fb1nr
         XAzKUeN9Ggic93jhJ+V8ypmMW+ewP8qixAp9qiEJNlasPQy/ALvwrJjC3RVT5/WsFWww
         gNPw==
X-Gm-Message-State: AMCzsaV6SWhDOCzs528EBIzlwdRKMdUt3s/0SJoHJfsPA9d8MczNmsL9
        JeJAQAeTPr1/ovHazR58TnBxC67/9WU=
X-Google-Smtp-Source: ABhQp+Sos25X4jA7fXTXMgEzAa9TIUsArig2h3coyXfzQ4LpA15/nF3UGJj1q1OXnpzG4pPnBVhajw==
X-Received: by 10.107.174.2 with SMTP id x2mr235303ioe.152.1509410039793;
        Mon, 30 Oct 2017 17:33:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id a139sm259094ita.24.2017.10.30.17.33.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:33:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 0/7] git-describe <blob>
Date:   Mon, 30 Oct 2017 17:33:44 -0700
Message-Id: <20171031003351.22341-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171028004419.10139-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not an RFC any more, but a serious series.

Occasionally a user is given an object hash from a blob as an error message
or other output (e.g. [1]).

It would be useful to get a further description of such a blob, such as
the (commit, path) tuple where this blob was introduced.

This implements the answer in builtin/describe,
however the heuristics are weak. See patch 6 for details.

Any feedback welcome,

Thanks,
Stefan

[1] https://stackoverflow.com/questions/10622179/how-to-find-identify-large-files-commits-in-git-history

Stefan Beller (7):
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe.c: rename `oid` to avoid variable shadowing
  builtin/describe.c: print debug statements earlier
  builtin/describe.c: factor out describe_commit
  builtin/describe.c: describe a blob
  t6120: fix typo in test name

 Documentation/git-describe.txt |  12 +++-
 builtin/describe.c             | 125 ++++++++++++++++++++++++++++++++---------
 list-objects.c                 |  50 ++++++++++-------
 revision.c                     |   2 +
 revision.h                     |   3 +-
 t/t6100-rev-list-in-order.sh   |  44 +++++++++++++++
 t/t6120-describe.sh            |  17 +++++-
 7 files changed, 203 insertions(+), 50 deletions(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

-- 
2.15.0.rc2.443.gfcc3b81c0a


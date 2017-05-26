Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B084820A04
	for <e@80x24.org>; Fri, 26 May 2017 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944669AbdEZTLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:38 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34591 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbdEZTK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:26 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so19367158pfj.1
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UvizziPGzh1l7t2COA77oJyGZFJ7+ntXjf469E22kls=;
        b=J7okU0su2bGW2eX3Tqn1cSpbmsKbx3jYNs4B9xbkqymJKZHThe9EnFlNy2yHN+KKrd
         4vmTwH4lGNYUX15pqKPsi/IIHSOxiqpuKx0y59nXwwy8GYNYoo+Fj8jwTN+HxnjrYCTa
         z3mHfIFoxSL+9OYcN8ITpVWOYoaWZTbGxWIWcYSqdTRSkqSyTiyagGFabyk2kX9XWk1a
         a2JZe9t/yztdVVqFCrof/waPEGVUht9vQQxmyR9qJJui6mVD5SZbdevCL9PC0sXo43MQ
         sYV59FEzH6I3Gfr1ge/8ML2n8E9Tc/PcTxQvbi3MkK1bUzKn0gel8a6plzkUTLkW0eeL
         5YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UvizziPGzh1l7t2COA77oJyGZFJ7+ntXjf469E22kls=;
        b=ltuVZ9K9Rz+uiYnuHuY9tlj4Mu7ZwAy/eDrJWMidy2vS3cui0q4eyhnGzL1yfryKYk
         H07Pr+BG3oa4I+H8IMqk63GOzr4K4SwFmNz1bUGJHD5SkbVt7YQeLAdVd/9xzpREhHzb
         t29XjbJDSOiY7nXhTmWYo+KDEOpu2qkBUBBfqKTXvVhmYHZJsIB0dtjrXIykhviTQvnw
         LGazFyQzyQJBTSvvOjxZ96oNoQPCfKY+EXT25TvHQiCT4BajAVBwO2sXgs8PDoBSWMtB
         ViDma2t+T2B5N2dZbwrOHGHRUkgw4hQ3pEgpVn+ukRmeImXwv3OSaqMynyhwM8yZ4srP
         UZ6A==
X-Gm-Message-State: AODbwcBdAbf3cpylkoPvb5lzN3Q7Xlu2bN0D96Kkc4bgINN7pVLUgKzY
        fviGRJkiUxBamT/Y
X-Received: by 10.99.185.91 with SMTP id v27mr4321928pgo.184.1495825820843;
        Fri, 26 May 2017 12:10:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id j191sm2909700pgc.53.2017.05.26.12.10.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/8] A reroll of sb/submodule-blanket-recursive
Date:   Fri, 26 May 2017 12:10:09 -0700
Message-Id: <20170526191017.19155-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* A reroll of sb/submodule-blanket-recursive.
* This requires ab/grep-preparatory-cleanup 
* It changed a lot from v1, as in v1 the tests did not work,
  hence the code was broken. Now it actually works.
* it also includes grep, fetch, push in addition to plain working tree
  manipulators.

Thanks,
Stefan

Stefan Beller (8):
  submodule recursing: do not write a config variable twice
  submodule test invocation: only pass additional arguments
  reset/checkout/read-tree: unify config callback for submodule
    recursion
  submodule loading: separate code path for .gitmodules and config
    overlay
  Introduce 'submodule.recurse' option for worktree manipulators
  builtin/grep.c: respect 'submodule.recurse' option
  builtin/push.c: respect 'submodule.recurse' option
  builtin/fetch.c: respect 'submodule.recurse' option

 Documentation/config.txt           |  5 +++
 builtin/checkout.c                 | 31 ++----------------
 builtin/fetch.c                    |  7 +++++
 builtin/grep.c                     |  3 ++
 builtin/push.c                     |  4 +++
 builtin/read-tree.c                | 32 ++++++-------------
 builtin/reset.c                    | 39 +++++++----------------
 submodule.c                        | 64 +++++++++++++++++++++++++++++++++-----
 submodule.h                        |  7 ++++-
 t/lib-submodule-update.sh          | 22 ++++++++++---
 t/t1013-read-tree-submodule.sh     |  4 +--
 t/t2013-checkout-submodule.sh      |  4 +--
 t/t5526-fetch-submodules.sh        | 10 ++++++
 t/t5531-deep-submodule-push.sh     | 21 +++++++++++++
 t/t7112-reset-submodule.sh         |  4 +--
 t/t7814-grep-recurse-submodules.sh | 18 +++++++++++
 16 files changed, 178 insertions(+), 97 deletions(-)

-- 
2.13.0.17.g582985b1e4


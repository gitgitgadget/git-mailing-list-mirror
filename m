Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E761F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 23:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeKLJtC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 04:49:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbeKLJtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 04:49:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id w22-v6so3415643plk.0
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02Ivu7gWaJnDG+4RdU9UGAMX7s4SRkukUTk8rNl2HDM=;
        b=EO8bdj5agYSA5G5q+tuoIn2HdM4gaJba/ojsYmaUCRTw17/b9y8mYpf6Ju9HmiIzvO
         CKTHO2WnpZTOQQGZaDn5mzijYGOHGjpIjRp2TUZxXB7PxfBIJUj1p+6yV2Gl6UD0aIex
         tE1wqnkrZSP8lnCStujxeuucjQhFzpkfSlYBp7rLToLhBVNpevlclv7ldi5wTbDy9yOG
         6Dmu6e9VyHCg9v02LACg1fwtCrOm4Yytn8w3YavH+eSY+RLt2rfaTeHmaF0SByPoru4P
         jE4SdYz8pwmVes9/MwpX69ckI3T/76hS8CtHVNhGMXCoNXGkbrSU39jRAQQ5uQQfECqE
         xZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=02Ivu7gWaJnDG+4RdU9UGAMX7s4SRkukUTk8rNl2HDM=;
        b=dJy2IsW5I/kNxofli0VT22qw1e1AiLIrCXKieMm9R/2n256a7RHOEn8g1bGzeWGSsL
         OKR8IhugfE3VVIAHpm0sCz2Q2+6my0AxrfHlYrK5b2jCc6RfoXu1csOlAgodRGTxmw6T
         gf++0VRfYda8k9iSGadf3Sm3rMpT7NSv5lqhsLwYAvDocwhDC650K+ISm6VdQ4pYqB7J
         KMYyks/d9wpz4HOV6ogvxR5N1JQxzwyze9Z/dY1enN02HuG4lNChT+An5pdXb8XrIc+Z
         67FqTrsoQdpT+/erh9JUKaAnNcP/z+Nsktyh5mx/ygtu3iCBVMlCeFqxVrVdO9P+E4OF
         nq4Q==
X-Gm-Message-State: AGRZ1gIRdA1D+bElpHuu4mdQsKcoEKSierNa+5TtM00oSgxrpr3hOvHH
        XytPjUnCN9bbxBFMbe41moM=
X-Google-Smtp-Source: AJdET5dghkdMT0VH39JO/MtoN1prd3n0LjqsFdIHm4pbt/n8Rzbhm2Eif39/CfRRNhlJDAUbAjtwCw==
X-Received: by 2002:a17:902:4165:: with SMTP id e92-v6mr18099745pld.209.1541980717976;
        Sun, 11 Nov 2018 15:58:37 -0800 (PST)
Received: from localhost.localdomain (143.sub-174-211-23.myvzw.com. [174.211.23.143])
        by smtp.gmail.com with ESMTPSA id v5sm16954798pgn.5.2018.11.11.15.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 15:58:37 -0800 (PST)
From:   nbelakovski@gmail.com
To:     rafa.almas@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, nbelakovski@gmail.com,
        peff@peff.net
Subject: [PATCH v2 0/2] refactoring branch colorization to ref-filter
Date:   Sun, 11 Nov 2018 15:58:29 -0800
Message-Id: <20181111235831.44824-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180927204049.GA2628@rigel>
References: <20180927204049.GA2628@rigel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Finally found some time to follow up on this :)

I decided to take the approach suggested by Peff for simplicity. I have
another version which uses a hash map to store *all* of the information
returned by get_worktrees, information which can then be accessed in
the fashion %(workree:path) or %(worktree:is_detached), but it seemed
like a lot of code to add and there was no use case to justify the
addition of a hash map at this time. If there's interest though, I can
make a separate patch after this one to introduce those changes. They
build directly off of the changes introduced here.

I've split this work into two commits since the items are logically
separate.

CI results: https://travis-ci.org/nbelakovski/git/builds/453723727

Nickolai Belakovski (2):
  ref-filter: add worktree atom
  branch: Mark and colorize a branch differently if it is checked out in
    a linked worktree

 builtin/branch.c               | 22 +++++++++++++---------
 color.h                        | 18 ++++++++++++++++++
 ref-filter.c                   | 31 +++++++++++++++++++++++++++++++
 t/t3200-branch.sh              |  8 ++++----
 t/t3203-branch-output.sh       | 21 +++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh | 15 +++++++++++++++
 t/test-lib-functions.sh        |  6 ++++++
 7 files changed, 108 insertions(+), 13 deletions(-)

-- 
2.14.2


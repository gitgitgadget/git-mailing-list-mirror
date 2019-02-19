Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C531F453
	for <e@80x24.org>; Tue, 19 Feb 2019 08:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfBSIbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 03:31:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42842 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSIbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 03:31:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so9888665pfi.9
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 00:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JM0KdKUM/iNKR10niZluiF7pssJ1CQ+DEoKWSO038zc=;
        b=AVV++mhwl8b5nQbeQN5ERexbMNY+xsr54MCxfFNNB2himP10u6zOkq9QOc7C2ed/Gr
         mKfYfcwQdOv818pyNDEB9QwYNBW6XB9uPvhIuQyWJwOQuG6yQYtE6AyNpyzoa8ZDFmAB
         oPTq+L2m7irOoY8JtZyRFQdAX23HMF7sTEcvhvvsJEYdOv8LwQXkQn3OnOwt5NC8Ljed
         QpzY0q71aQQqaRIMRq0oKQ59zXP++bYT5WfWhpzXEOHiI6zL4yja60f3VS519tMcgtvo
         Q1WJwaJcoTq5oGQD+eQW2bbCr6EnhsE+Whlf/BU3Xbj7b83xOa4V5AL77KpprTsfeyeU
         1kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JM0KdKUM/iNKR10niZluiF7pssJ1CQ+DEoKWSO038zc=;
        b=K5Syk7ZJixXQRGPtKcy9A1IP64Z06+QOsIwFfxarN0XehdgPSF0ux5uF9B699FC5/X
         +X2ZEMefnkZ3xRFlzDJHOZJZd4z53LbQJ+/81zKmAYGRgTqLq87VDBzqWuD8/p5i4F9a
         bdxh8i7q4X2Yn9ryU+YpRWqS89XvpZ6Mw0OeT4gHWQZ2Jvj1OE5wq+PksLXAaa8j+UYE
         FsvTp+TovLKhpQNWZezRWUfjdz29rNrLNVwIrfAh0uN/zvv8CFCinRFZagg849Pk+nyQ
         B0zWq7p191Iq7MQK2mL4fwLK1Y/NxzSsC9YZYFD/FOktY3GKgv/g+Eg0QUiK1UYXqiiI
         LHvQ==
X-Gm-Message-State: AHQUAubLC4Tm6pD1btTIfPLrkJr+etUYXrVyj57HAyc3YR7Xtawpw+oD
        MEj2jMqGt/ImQtiYwMVmQ8qcc1OS
X-Google-Smtp-Source: AHgI3IbARHZEoO7hdQwbEOZcJgv2Xst6GiN0RbiebvqOlxbY3VCw08RncJm2XK5Fu8ixv8lkZq7Pwg==
X-Received: by 2002:a62:1346:: with SMTP id b67mr29275611pfj.195.1550565109445;
        Tue, 19 Feb 2019 00:31:49 -0800 (PST)
Received: from localhost.localdomain (pdadde822.hkidnt01.ap.so-net.ne.jp. [218.221.232.34])
        by smtp.gmail.com with ESMTPSA id f62sm25190120pgc.67.2019.02.19.00.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 00:31:48 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v8 0/3]
Date:   Tue, 19 Feb 2019 17:31:20 +0900
Message-Id: <20190219083123.27686-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

I've made the various cosmetic changes that were suggested, as well as adding tests for 3/3

I don't have a particularly strong opinion on the subject of keeping the atom as "worktreepath"
or changing it to "worktree:path". We did feel earlier in this thread that if we went with
"worktree:path", then "worktree" is somewhat ambiguous, and that discussion led to deciding to
have "worktree" return the path,. After that I chose to name it "worktreepath" because I like to
make things explicit and intuitive.

Travis CI results: https://travis-ci.org/nbelakovski/git/builds/494817576

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: update output to include worktree info
  branch: add worktree info on verbose output

 Documentation/git-branch.txt       | 12 ++++--
 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++--
 ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |  8 ++--
 t/t3203-branch-output.sh           | 38 +++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 11 ++++++
 7 files changed, 156 insertions(+), 12 deletions(-)

-- 
2.14.2

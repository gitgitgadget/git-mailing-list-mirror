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
	by dcvr.yhbt.net (Postfix) with ESMTP id 548391F462
	for <e@80x24.org>; Tue, 28 May 2019 12:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfE1MmQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:42:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36506 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfE1MmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:42:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so31583277edx.3
        for <git@vger.kernel.org>; Tue, 28 May 2019 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PM445pByYKFixrZrr1BGm9QX/zjgmUaJExgQbXqcztg=;
        b=q2HO7uqRPsEo99Ph7YyotHe4Ou2+PhbT6eBdYhNVbcMB17eR3TyMWVAzUyuReTy0LS
         5/mLMVSd4vGMk1hNGVa1ZugT5uFF3FndfBFHqacUKYkjHFmjsyyJVVKZZq+U6yR8CI90
         fy62eO7atcKnEJHILpyJFGrXSOaFLBd0BEfRkGU/N43tTv7CXak+CqeWVhyuSV8xS1LC
         naidaiwS0ECqsEQ7QdsJP4quvlIbx36Y8b8be9oJsukh3aRarD+9xvTaYnbKpdujKES4
         tLVpz62/y7AMWEEI7WHEYnC01x7wSmU9HiuDbt1gsUdIk9C7okCIUgztQgn4+40Q9BF4
         AsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PM445pByYKFixrZrr1BGm9QX/zjgmUaJExgQbXqcztg=;
        b=ss3ACH065mvuSmFcodzMw904ckRRygt08LKDqqJS9Cbz4RSq/itmGA/KoMRbAIvdPr
         zs6cHrlIM768bw7xqGnFE/juL75od7V++yb8bsyTxMfbrTh3XEzgAwLi/RcAWNT8EB3V
         dDhIsxLTs7NwlNe9uucMld8V1LAnIk3c+LkYfDXBlMHJ9VQcPfybOB+MRXMaKkwNJDBP
         6QaZS9DA9LQfD0xSw25LOjzr9QvoTcWDQktv2mFHnpi+nmAHWnmx4zHkrE6h/W8jj9Nh
         93qwFa2/T0FilYvz4wDFTsbrQbkDC9tkgQE6pTmJ3k1S8pCr/bFcJ4so/By6sHcgkxAx
         acSA==
X-Gm-Message-State: APjAAAUlFZ/tVLaAelm7oHq62YXbQupmg8jHKYXEygA0y3wFvtuY1GN6
        pw6LiUoH+8FpgorsguPHkH1kFUba6Xk=
X-Google-Smtp-Source: APXvYqwjKnBo4SDMGFoWI0hR9Xd8Fxd405Ys8o6F3sSfoFyASagxH3DGQnrLzHpzKxJH247O5V+YLw==
X-Received: by 2002:a50:b56a:: with SMTP id z39mr128909346edd.91.1559047334638;
        Tue, 28 May 2019 05:42:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f50sm726193ede.61.2019.05.28.05.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:42:14 -0700 (PDT)
Date:   Tue, 28 May 2019 05:42:14 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 12:42:10 GMT
Message-Id: <pull.227.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Deprecate git rebase -p even more
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

Turns out that I forgot a couple of spots when I sent the patch series to
deprecate git rebase -p earlier...

Johannes Schindelin (3):
  tests: mark a couple more test cases as requiring `rebase -p`
  docs: say that `--rebase=preserve` is deprecated
  rebase docs: recommend `-r` over `-p`

 Documentation/git-pull.txt             |  5 +++--
 Documentation/git-rebase.txt           |  5 +++--
 t/t3422-rebase-incompatible-options.sh |  5 +++--
 t/t3427-rebase-subtree.sh              | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 11 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-227%2Fdscho%2Fdeprecate-rebase-p-more-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-227/dscho/deprecate-rebase-p-more-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/227
-- 
gitgitgadget

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
	by dcvr.yhbt.net (Postfix) with ESMTP id 506E41F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGXVPB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:15:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfGXVPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 17:15:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so42813700wme.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=p5jnXy088u5C54xb8QNLoDz6zYNYq4hqH+Y5+NMsm1c=;
        b=QGH7m9FEC3Q3ClEb6TyAXrqIuGzHpwc4o5422VkAsZpF+3YOL2jbnTmdOsf8F1c1S0
         pKBx6/MsV2rCX478I+cZmPpmE6AQGTupj7HjXfuQuXYwQavbNyrO+ToAOjEOg/W0eF5R
         2HDVytkseI6UGEfX9lmpoFOLilq8j/ryT+WDi2nd+P5gkZIOsCzLwf2zIC7OVcuKgfgY
         R3wCeYLEz0aUWhUUm6EGfXijK5QAe7EqLS12cS8F+tvsDoiBopBYosZNC+WBDbdfVPKu
         7PKL6AAQEzbYdtZIPToOTcNDnyULqxen/1CqMdFb1xeIXG9zMqjfCsDXLffPpfWXdKxH
         LSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p5jnXy088u5C54xb8QNLoDz6zYNYq4hqH+Y5+NMsm1c=;
        b=DRCYF42vqVfE3zd3H3VsUIJ4fI4Siw+cbqS7gOMz+w5+zKGh0W9sEiiwKthYsbIuNE
         PIAcpXoVszlYpTIf2Bgk21zaZXq0rwlR1BVRmN5pqEsxBQB4PumQKwxsXKITcjtRB0dn
         79TQeBabeym7xLKZQJ3l1VejI+dYcYskoTcgGqJO86WXDrTOYXgkzcxYCBijFblIA1mO
         RP/EMgXwoTm7mHvurylQyRlW4143iJXjmXfDV60zpW2qPodIhQqfbgcbkcB/DVsk23HF
         ipBztufd4rxzZXBc5XOcZMZB8Y5mi2W5IXU2elUU5MNvQoI08Dh/Rt3+4LY4oHHnWGbP
         z+tw==
X-Gm-Message-State: APjAAAVQCeIzflhpgOPWvDnA7QVY2SC+Dc20OEIyAB6ADjjyR6+M7Ppg
        NNvxp8ftHvmYSkFP7QDLjQjcQGoP
X-Google-Smtp-Source: APXvYqxVuHkCuChsYbryJn57FyX5IZBtFSLsLG3Ll+IPNxoXx6tNDquptjkkLgcWPQKRdo3eRlCPIQ==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr71663922wmc.34.1564002899010;
        Wed, 24 Jul 2019 14:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e19sm63830442wra.71.2019.07.24.14.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 14:14:58 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:14:58 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2019 21:14:55 GMT
Message-Id: <pull.293.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Clean up more of the fall-out from dropping the scripted git rebase
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

I had prepared these patches even before v2.22.0, but deemed them not
critical enough to push into that release.

Johannes Schindelin (2):
  rebase: fix white-space
  git: mark cmd_rebase as requiring a worktree

 builtin/rebase.c | 6 +-----
 git.c            | 7 +------
 2 files changed, 2 insertions(+), 11 deletions(-)


base-commit: 082ef75b7bfc90ac236afbb857a9552a026832b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-293%2Fdscho%2Frebase-cleanup-more-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-293/dscho/rebase-cleanup-more-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/293
-- 
gitgitgadget

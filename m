Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071D61F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 18:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfJ1S6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 14:58:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfJ1S6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 14:58:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so11049938wrm.8
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FdB0yxhJJHIDJ6yWMXjQwOPild7LIjzPx8cFf0tkcQg=;
        b=aSzvJn2ci//xFKtjLINTtPPK9x3E165vtEy/naljhxJSBU5lPHYqH8aj6atf370ED9
         hXUPjsHn497tPbMx8+E6CZcvpqZcxjf71r9KCWbcCNSVzBgOqD2CsPzMuFuT1T8wDA4j
         ikIWAVMwYtV0wpRyJ3F6e8DkcLvmfiOaxVluMUnRNWgFMYvjs/A6OsN+7jbmpQrwHofk
         4Z+xOCSWgyFmYtplDjolDOe4PGRw35+tg+7TTyJvV7965BqDUTnS96ZI/olYeALM+ikn
         G6dj+vcgLicdQ100ISsjHRbu9rk6Q/UlKcwmv1kqp1yjqZeVkfyNpauNE0ra6oOB8ZB6
         IrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FdB0yxhJJHIDJ6yWMXjQwOPild7LIjzPx8cFf0tkcQg=;
        b=dDAPGEgN+wJwr2zT/WnJmNEnrEPKqN1ibJ1bis52uFwLnQ66DfHvIpY6TaAX2MIuuE
         TAy61bvOh+IZ3zlgTxqmVH0ScwBsQ7Y3hRrj7tQJwankEg9wuD8VV+bvsvbYmr7IcFjw
         H1/E0gNoAgpRESLd1huTJNBDstp4tQKKdIZQOqYIMBquSXskPByVWXK6fash3P7H9kb1
         Rl4pxspN7cCEuRaNgUGF13fHEWl+c3P9o+JR2m+ku6Q3zG7GOHuyL78CC5+MDxFmYtdy
         QJnh0ZSX8C6SbnWYP0HuBNq+EX5qYDyTES0oUIwUSniNfqgeQKu9EHAILbw39AmTsxZT
         pjNA==
X-Gm-Message-State: APjAAAVHEOZkXmWhvaDrwsEgM/nyckylBDzr9TH8wEtlkqeeZhmlF/bZ
        YuDqXHPOWdwvor3pUVxqnS+Umbq7
X-Google-Smtp-Source: APXvYqzxmrCQef8pu1PQHVIdbMqCm2pq3YFFrdzmfXopwVCDj3tBtyOTdKDah5kC8iBOBeRjLdkKhQ==
X-Received: by 2002:adf:e488:: with SMTP id i8mr16149108wrm.302.1572289088890;
        Mon, 28 Oct 2019 11:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14sm11660767wru.24.2019.10.28.11.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 11:58:08 -0700 (PDT)
Message-Id: <pull.423.git.1572289087.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 18:58:06 +0000
Subject: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on untracked files, deleting
 them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep. I have typically had to explicitly delete
those files externally to Git Gui, and I want to be able to just select
those newly-created untracked files and "revert" them into oblivion.

This change updates the revert_helper function to check for untracked files
as well as changes, and then any changes to be reverted and untracked files
are handled by independent blocks of code. The user is prompted
independently for untracked files, since the underlying action is
fundamentally different (rm -f). If after deleting untracked files, the
directory containing them becomes empty, then the directory is removed as
well.

This introduces new strings in index.tcl. I have been told that there is a
separate process whereby the translations get updated.

Jonathan Gilbert (1):
  git-gui: Revert untracked files by deleting them

 git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 35 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-423%2Flogiclrd%2Fgit-gui-revert-untracked-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-423/logiclrd/git-gui-revert-untracked-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/423
-- 
gitgitgadget

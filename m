Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A7A1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeKOC3X (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:29:23 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40546 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKOC3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:29:23 -0500
Received: by mail-pl1-f170.google.com with SMTP id b22-v6so2570419pls.7
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PGQuComDUFA2BrN9ttfCEyOcMvvkuWzC7seqxbPSAis=;
        b=taaoti74LJtY6JR8KW7PufF3CIc8HJgNb7cIddenQDwZlaT3r70oUZ/dtRIG2l8I7D
         IsY0aESk4PlPfJn5bJsvOZLfYVLtSjUjBp1nQ6BCTwasu3cTgB69nWL3pURsgVeeHITc
         FZl33xWJ4HYIYOrSX3ApzPtuUnvEc6wBczxTHkdApjCVIv8GVNYSA7jqN9w9lBdWhm4E
         Ulxcu/+kGJzgPWA+wcSMdKS5xh/uLWFlSTqz9zDU2od6IA+4Kmi2rKrRsrV8G8GhOJnh
         G+TJyCwTGosPGt7fKpAsiS3efw1FaL3tBsgkEM5BdnX43ZrpLHvqaLJCevLN6OydOdFF
         HD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PGQuComDUFA2BrN9ttfCEyOcMvvkuWzC7seqxbPSAis=;
        b=sU0OsSh5KusoiI5183md2dQi47ifec9dwfZsMKBCs4eDY5JsagYF1DC1JEiBzoALXa
         1+VK2sTHurGQZHc5mJ/wMh7BBSt6GYcGvZShEtmrFuyMePe40ANZmeIFJa9r636kqCxr
         Qv/P25dt7cm1pRxQS2uAmoO34G9i0YWkSrp1da5hzZ17PXRGVXK55ZmQZ3olBMQ2fGZL
         gh5kNIn59Ubp/QI1mlyC2MPB9Gngl9/jysjO/3zksPhX0NF9Qh2Mzq4rfEhxhoxJSC5A
         pzTfcP0AoD8+qY/yIKLJbGVIhAXClrUKcGiBwxMd8qNKHgQtNWtTUPpDWyZN9hJLEDpe
         EKxA==
X-Gm-Message-State: AGRZ1gJ0M2m1X6rjiUrYQs/vTGCyz5FaNwgJDuAzN4lVAjhoqMg4zfwx
        /FLTmGaffoEk/2s2SDVgzR8018Np
X-Google-Smtp-Source: AJdET5dlME+EGJ4A4ldP2+ttOSB8dSyyfhWtVXD+ACP2K8VvWh+zdWsNxWtHNcy69XtRhVhOjVOvrg==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12-v6mr2531652plr.16.1542212729165;
        Wed, 14 Nov 2018 08:25:29 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a17sm28755039pgm.26.2018.11.14.08.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:25:28 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:25:28 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:25:23 GMT
Message-Id: <pull.76.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.76.git.gitgitgadget@gmail.com>
References: <pull.76.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] rebase: understand -C again, refactor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood reported a problem where the built-in rebase did not understand
options like -C1, i.e. it did not expect the option argument.

While investigating how to address this best, I stumbled upon 
OPT_PASSTHRU_ARGV (which I was so far happily unaware of).

Instead of just fixing the -C<n> bug, I decided to simply convert all of the
options intended for git am (or, eventually, for git apply). This happens to
fix that bug, and does so much more: it simplifies the entire logic (and
removes more lines than it adds).

Change since v1:

 * Introduce early parameter validation for the options passed through to 
   git am.

Johannes Schindelin (2):
  rebase: really just passthru the `git am` options
  rebase: validate -C<n> and --whitespace=<mode> parameters early

 builtin/rebase.c          | 108 ++++++++++++++++----------------------
 t/t3406-rebase-message.sh |   7 +++
 2 files changed, 52 insertions(+), 63 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-76%2Fdscho%2Frebase-Cn-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-76/dscho/rebase-Cn-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/76

Range-diff vs v1:

 1:  dc36a45068 = 1:  dc36a45068 rebase: really just passthru the `git am` options
 -:  ---------- > 2:  4c2ba52766 rebase: validate -C<n> and --whitespace=<mode> parameters early

-- 
gitgitgadget

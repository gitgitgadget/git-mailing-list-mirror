Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816CF1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 17:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJSB0h (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 21:26:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36389 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeJSB0h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 21:26:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so14512206pgv.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sJdMJF8EAVtTNBxbC/Incn1FMG0n1fWcTlsmkt9IYRs=;
        b=lpbw+S8wdeG3qhF+PST6dZZgUEE6nISudgEvScoOTe7DDL9OSJjaWDDEgaAJwcWOJg
         LuZQCP43sfRdasKATD+S5gFIt/esmxNtp2PgNAbxeZkJY78olWwhu62FzsU/DHH6a+1j
         qUTUxqMUYGNqp931pOJ+bElv6izthLAOx8vZxzEOjIk4mu+fvS78S8l6AtGCrduccPyn
         9FWqBLvrO42vsJxsKeX0Wji50zA9eH2YK5IYpRl42WRsYrnyZDR+ATm4gDXuO4IFO4VJ
         WJvt/upLp4+ZxZDzWLgoKnqna9df0+BomkCPAzad68m0kn7sUpuwIgEcG/7tTqxyjePS
         GwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sJdMJF8EAVtTNBxbC/Incn1FMG0n1fWcTlsmkt9IYRs=;
        b=LOHebfFwo47HcE2iE/f16zuf0X+eXj+prabZxG/395JjqM9hcbwtHpRHUpWdwiPe90
         AUd7fArnZXEJUAiLgVOyxU6c1d5KBhevhiRGvKKJ+vz/ayA3druk6BIpAzCnN04tmhl/
         LcQNjmS7j6IzF/I0H5K3cSveFKyfqamabthjZyk575RL+TUvmXJe3lF7L3LqXKO2SUHl
         AaAsxkZqVfqFnkCbq/d3I8iV6+hC0w7J3iYhuykc+mCkAUEnUT9wTVciQo237rklgjAQ
         pH6c+BdCNF4nQBZ53K4egD6WvJw+hh/caL/B2TzMhj6IZJIXRc0mDuv5TQ0P3lcFVYwq
         zDcg==
X-Gm-Message-State: ABuFfojklBJJf+pU9u4KjvLIYY1bn7O8j2/WgbvWMYjUiOFLgucsYCyX
        HjjNXxwOL/Ehrh+AFIhFx4g6GJDe
X-Google-Smtp-Source: ACcGV60aMHq1Lq+M47J8ohcoDwrrYsda8hKjhIYtwtaNpysit2/d9aiLNXrGIl7+HHEyfYtngUOjTQ==
X-Received: by 2002:a62:221c:: with SMTP id i28-v6mr31604162pfi.196.1539883479394;
        Thu, 18 Oct 2018 10:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q123-v6sm13735850pfq.169.2018.10.18.10.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 10:24:38 -0700 (PDT)
Date:   Thu, 18 Oct 2018 10:24:38 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Oct 2018 17:24:35 GMT
Message-Id: <pull.51.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] commit-reach: fix first-parent heuristic
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

I originally reported this fix [1] after playing around with the trace2
series for measuring performance. Since trace2 isn't merging quickly, I
pulled the performance fix patch out and am sending it on its own. The only
difference here is that we don't have the tracing to verify the performance
fix in the test script.

See the patch message for details about the fix.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/20180906151309.66712-7-dstolee@microsoft.com/

[RFC PATCH 6/6] commit-reach: fix first-parent heuristic

Derrick Stolee (1):
  commit-reach: fix first-parent heuristic

 commit-reach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: a4b8ab5363a32f283a61ef3a962853556d136c0e
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-51%2Fderrickstolee%2Ffirst-parent-heuristic-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-51/derrickstolee/first-parent-heuristic-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/51
-- 
gitgitgadget

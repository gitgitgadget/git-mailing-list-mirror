Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289BC1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfDZLs2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 07:48:28 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46311 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDZLs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 07:48:26 -0400
Received: by mail-ed1-f52.google.com with SMTP id d1so2862142edd.13
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=+sI6rYgf6WMM7yAZch7xz8nopHUZ15olqauUC1CtXnk=;
        b=tWAbDOZJFcWv+89K2WTL9gf0o7jVPvqqT9mjmuK40jXHSg96r/63+0mox3phIsNnew
         /TzkLLiVRW3MnBBPnavY8ucpuxLPaN0aSYunuM7Ako2QniXWXRHjaA9KMLIp3Xn35FBa
         X5DANPGTOX3db8HOOIK2gFr7ptYo3bKiGoyCGxveaE+X9TJm/+ctjMJdMQNfdykO7qw2
         Bo6y+mnoyKmTTM+t5A204CM/ZZmKPvlrS3GI841HHDC4V6xl8hgr9EEDlgyLqzCKHN5x
         nA+T6cIcbcojC9iNNydrJBmnYL1XQErdkp5QP3aPHtZGt61IYDdnWW1bh2UEAv46IXHx
         UDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=+sI6rYgf6WMM7yAZch7xz8nopHUZ15olqauUC1CtXnk=;
        b=hSmEjU8asR/bccOX3CzDuAYU/t1T6cbqH8tKxCeNPvE1DRrZctFcdqjYRsa1wUXxk5
         sgMOJ69PFM2wi8lblfy+9+EJu7yQwPvGKu5ljTReGS9fl5W5xRwWegQzSb3by14bcIuK
         zyoedKdM2TpbSNXq+GYiUVYRKrhYvARC6FoLPx4j3+i5InBeO037D8mTzSEnjrNhCInf
         4WBJbKHjSf20b3H2dnuifSHS9L3X+XbcfiRArONNT0j5q8UbNXUhCwFH8o41Xdi1zVKx
         5VwEDkk3/n2bO0lghrfUpmgVbf4vw/g+iamk1ltdyDa8PAo5kKKqeAmjpUsGMRty1sCk
         qNOg==
X-Gm-Message-State: APjAAAUlM4Fc8tLh0WAcNtSpzD4W21M/sNqn8c24LRi0hklA0yiM39K9
        91pzRF10Ye2qU7Ljg0EOZrsp/sST
X-Google-Smtp-Source: APXvYqxKw85b6pGmt9ock4Gazc3xb+NekqJEF/0ibVK0KFPTHPNxQIENOzVVCFQX17ZU8nJFP1NHZQ==
X-Received: by 2002:a50:f9cb:: with SMTP id a11mr28844613edq.1.1556279304790;
        Fri, 26 Apr 2019 04:48:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm4485003ejd.66.2019.04.26.04.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 04:48:24 -0700 (PDT)
Date:   Fri, 26 Apr 2019 04:48:24 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Apr 2019 11:48:22 GMT
Message-Id: <pull.181.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] commit-graph: improve error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small patch that revises the error messages from
ab/commit-graph-fixes, as recommended by Ævar. Hopefully, it can be merged
faster than the commit-graph v2 stuff, and I can update that series to
include this change if we agree it is a good one.

Thanks, -Stolee

Cc: avarab@gmail.com

In-Reply-To: 878svxrwsh.fsf@evledraar.gmail.com
[878svxrwsh.fsf@evledraar.gmail.com]

Derrick Stolee (1):
  commit-graph: improve error messages

 commit-graph.c          | 10 +++++-----
 t/t5318-commit-graph.sh |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-181%2Fderrickstolee%2Fgraph%2Fmessage-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-181/derrickstolee/graph/message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/181
-- 
gitgitgadget

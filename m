Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262AF1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeHaAQ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43163 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so9171616wre.10
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kcWzYEFjTG6cHB14oR06VrX8JTzPxQz1Iu5XCq3qrs=;
        b=FOaA4NqFq0I8gqY9/Mcj9K+eddkoQbwfNKlttjTZeAdwJHUJOku5xQFnQX1i9wQLtI
         1ehDxdXFF1x1LqAnLlZdppLgnioN9rdXmkoJ2KxMoSL4nlY5XCOaGSrgr1PuyJce8SRa
         8YPcpql+URyDibUPLeKnwfR7Ze9fENUj0zi+duqq0AwJXi3Asz0ggRhn7v0WJGFerWvL
         emwcxlgxL/p/izH5ZZua1GMxykv44Wsk0s0AKgK4GQqOFlgkCkWOqUFs8bcF+Aodbujj
         hywcQzxYkaF1hr/9sWsIludtZynsR+Mx9+YrlEQ2VW0O6OCK9evSP+VRJDEopeuvAMws
         0W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kcWzYEFjTG6cHB14oR06VrX8JTzPxQz1Iu5XCq3qrs=;
        b=ItKMi+aR+99WcbW1DsQzgUr02degN1LFHKk5FSLk3vkTTDJZBKhNHEVHZkCh86gTfu
         qKyOgy/xLQyM2UnlZcHVKxk3emJ3Ouh5oZ2APQ0M32HwYs95ChIsVxOlHbJtd7P9b6wI
         cIxbgD3bQOK4QEAqEzasE7vO5ZH/4A6XjHmI+poBe+OrhOSZebBo6n1r823PxXtN7FSL
         TIlxQfZqY0iJyiGALUXjliJ2wOwnS92654RKc6dwnn3QaE1+Z8L88OKXGqNKmX6QnWlC
         YCUWS/8Kc3M9OAMGAZLzIDgBf+AYDbquBsMKUXd9Pu5uE36/xYgYDS8OFoNB8P48LWz8
         Q8yg==
X-Gm-Message-State: APzg51DKBahQOkAVnSNo/MbczLZdfOERo+ux4kAHzFoqFDm6v1nK7Gbu
        iEG8un9jAWZWOxD/FoNu6TxUrqwPYAI=
X-Google-Smtp-Source: ANB0VdaGGT/x8zscNTSQpfY9yo6JsIyoJ9+AqHFFeNrWjfU+wMaMNkY2VnVzkHwJTMK2w8X2aYkpBQ==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr8845152wrt.210.1535659984501;
        Thu, 30 Aug 2018 13:13:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:13:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] fetch: document local ref updates with/without --force
Date:   Thu, 30 Aug 2018 20:12:43 +0000
Message-Id: <20180830201244.25759-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refer to the new git-push(1) documentation about when ref updates are
and aren't allowed with and without --force, noting how "git-fetch"
differs from the behavior of "git-push".

Perhaps it would be better to split this all out into a new
gitrefspecs(7) man page, or present this information using tables.

In lieu of that, this is accurate, and fixes a big omission in the
existing refspec docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/fetch-options.txt    | 15 +++++++++-----
 Documentation/pull-fetch-param.txt | 32 +++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 8bc36af4b1..fa0a3151b3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -68,11 +68,16 @@ endif::git-pull[]
 
 -f::
 --force::
-	When 'git fetch' is used with `<rbranch>:<lbranch>`
-	refspec, it refuses to update the local branch
-	`<lbranch>` unless the remote branch `<rbranch>` it
-	fetches is a descendant of `<lbranch>`.  This option
-	overrides that check.
+	When 'git fetch' is used with `<src>:<dst>` refspec it may
+	refuse to update the local branch as discussed
+ifdef::git-pull[]
+	in the `<refspec>` part of the linkgit:git-fetch[1]
+	documentation.
+endif::git-pull[]
+ifndef::git-pull[]
+	in the `<refspec>` part below.
+endif::git-pull[]
+	This option overrides that check.
 
 -k::
 --keep::
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index f1fb08dc68..ab9617ad01 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -33,11 +33,33 @@ name.
 it requests fetching everything up to the given tag.
 +
 The remote ref that matches <src>
-is fetched, and if <dst> is not an empty string, the local
-ref that matches it is fast-forwarded using <src>.
-If the optional plus `+` is used, the local ref
-is updated even if it does not result in a fast-forward
-update.
+is fetched, and if <dst> is not an empty string, an attempt
+is made to update the local ref that matches it.
++
+Whether that update is allowed without `--force` depends on the ref
+namespace it's being fetched to, the type of object being fetched, and
+whether the update is considered to be a fast-forward. Generally, the
+same rules apply for fetching as when pushing, see the `<refspec>...`
+section of linkgit:git-push[1] for what those are. Exceptions to those
+rules particular to 'git fetch' are noted below.
++
+Unlike when pushing with linkgit:git-push[1], any updates to
+`refs/tags/*` will be accepted without `+` in the refspec (or
+`--force`). The receiving promiscuously considers all tag updates from
+a remote to be forced fetches.
++
+Unlike when pushing with linkgit:git-push[1], any updates outside of
+`refs/{tags,heads}/*` will be accepted without `+` in the refspec (or
+`--force`), whether that's swapping e.g. a tree object for a blob, or
+a commit for another commit that's doesn't have the previous commit as
+an ancestor etc.
++
+As with pushing with linkgit:git-push[1], all of the rules described
+above about what's not allowed as an update can be overridden by
+adding an the optional leading `+` to a refspec (or using `--force`
+command line option). The only exception to this is that no amount of
+forcing will make the `refs/heads/*` namespace accept a non-commit
+object.
 +
 [NOTE]
 When the remote branch you want to fetch is known to
-- 
2.19.0.rc1.350.ge57e33dbd1


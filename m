Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB221F453
	for <e@80x24.org>; Thu, 18 Oct 2018 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJSB0l (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 21:26:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46986 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeJSB0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 21:26:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so15177557pfb.13
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i4d1oY3lrn26QchEtoiPp6EYUUfvlLAoFgz/WgiRecc=;
        b=lV7a2B/DL8+KcgzLZXU6QlcD138KiXZBGRkj08kEz1ZKKqit14CyYcIvMfohDyg8Kq
         H7jIIKqS86zmkNipIDOr4qY+LKQvjbU0sYMzfRhjBU/d4EEHdUl5477AFV9rpWwAVlcy
         I00k53d4oni5M5GnEqOvRl37Qv/A1fxm0knxPOa0Jqdr7aKT25BQGobiAvq5alCfxLmD
         ZQdUE7C9jW9FUqIVI5fHbYKYtzBNARbnJioaWFIdeH3tCbS7S2IrDXroEommEFBGE89I
         /mTi2tnYrjw+bGQzN40NsuQ9hmZb+qOucy4Y3jYKqVTdMWUIF+yH7zJp0zISShdgmGXS
         od5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i4d1oY3lrn26QchEtoiPp6EYUUfvlLAoFgz/WgiRecc=;
        b=TL9ph4T4J6oY9BemQJZtyqTwjN/m/3V+pRKb+pUnyltuXNCGe7OeAO3TyNQ/wJ33ze
         ZBmkbR65Jr38BX1K7lY+0qSS2DCTPkRzm107edCFI+uvbRDas53NxivAkqrZMDeWrbco
         RLmx+IrPDZ8Kn45oBOOPTQXfLhNlCcFwMm6qUXHSJ4lIxKqqT1c7xnj69I8rDt2NiHwf
         aY+DnoZej7i5AjS+HFXIDaoyo9rkKoJdKs3KkqW5ZBAdBavr6BGt0BjPiuF+I9w/OxDA
         Spy789TmMmMEp0SyeVg+/O3o3bn1IQDZS8EXJdlcRzftYcRhguobixKdjrztA4DHbMVl
         AnFw==
X-Gm-Message-State: ABuFfojPo5RNmybp6A+waKqb3YgnbqIr8ZpvncMScHmUhj53MM5w6qat
        ZGtDnUbJ/u1rOZgx6MORLfe0xXWP
X-Google-Smtp-Source: ACcGV62aSMY16tL8X7PbIXdgMCfJBcWohm9GNn3QZfsFOffjuDEg9e2Rq+bdfWB6gZLpt9culBYH7g==
X-Received: by 2002:a63:f848:: with SMTP id v8-v6mr28872415pgj.82.1539883480816;
        Thu, 18 Oct 2018 10:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p84-v6sm29605425pfi.22.2018.10.18.10.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 10:24:40 -0700 (PDT)
Date:   Thu, 18 Oct 2018 10:24:40 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Oct 2018 17:24:36 GMT
Message-Id: <53ebceb7f11d1e1ea39ae4ca86850190ae839eff.1539883476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.51.git.gitgitgadget@gmail.com>
References: <pull.51.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-reach: fix first-parent heuristic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The algorithm in can_all_from_reach_with_flags() performs a depth-
first-search, terminated by generation number, intending to use
a hueristic that "important" commits are found in the first-parent
history. This heuristic is valuable in scenarios like fetch
negotiation.

However, there is a problem! After the search finds a target commit,
it should pop all commits off the stack and mark them as "can reach".
This logic is incorrect, so the algorithm instead walks all reachable
commits above the generation-number cutoff.

The existing algorithm is still an improvement over the previous
algorithm, as the worst-case complexity went from quadratic to linear.
The performance measurement at the time was good, but not dramatic.
By fixing this heuristic, we reduce the number of walked commits.

We can also re-run the performance tests from commit 4fbcca4e
"commit-reach: make can_all_from_reach... linear".

Performance was measured on the Linux repository using
'test-tool reach can_all_from_reach'. The input included rows seeded by
tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
v3 releases and want all major v4 releases." The "large" case included
X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
tags to the set, which does not greatly increase the number of objects
that are considered, but does increase the number of 'from' commits,
demonstrating the quadratic nature of the previous code.

Small Case:

4fbcca4e~1: 0.85 s
  4fbcca4e: 0.26 s (num_walked: 1,011,035)
      HEAD: 0.14 s (num_walked:     8,601)

Large Case:

4fbcca4e~1: 24.0  s
  4fbcca4e:  0.12 s (num_walked:  503,925)
      HEAD:  0.06 s (num_walked:  217,243)

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9f79ce0a22..79419be8af 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -593,8 +593,10 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		while (stack) {
 			struct commit_list *parent;
 
-			if (stack->item->object.flags & with_flag) {
+			if (stack->item->object.flags & (with_flag | RESULT)) {
 				pop_commit(&stack);
+				if (stack)
+					stack->item->object.flags |= RESULT;
 				continue;
 			}
 
-- 
gitgitgadget

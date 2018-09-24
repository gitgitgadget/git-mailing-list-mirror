Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617691F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIYDB5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:01:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeIYDB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:01:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9612530pff.11
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O3iFukMUdl6Vt5Gqhj5VX1v8fp4BIE8pl+tlACAY9TI=;
        b=ohbQSr2oT6mCo1GcsIDTENIsNjJ7X/1Z8hssTiqOtPSHPG2yJSVEltuOQuBV/woKbY
         UhD9rxi3lSXp800SoQfvc6DKY2fUIDXbRhDnaAr06r/E53Z5jCcXiQHdS1typG/PTbXI
         HWQL/avzz0Kk2MNR1suaAC085GwMkj9dgMDjaEqhwty2mbpXHFXQJmsh/FvlI8YVzqXp
         A0XyTqQZn5G84ZEH7I8kfFUA8wfeKM/QU8is04xUSMy61XgghKSJGPOr74pBGXIhqrh2
         iSzyOZ5J8OtSTPyXUMWgcZgX/Op/rRolv6jmyWO1OYkqLJ26lFhtT4MIS3Kl90Rbepie
         Fk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O3iFukMUdl6Vt5Gqhj5VX1v8fp4BIE8pl+tlACAY9TI=;
        b=ck5T3frpUNQDElONB6wP0fNK0yxU3OtLZ+Lr96E4ZjcnZoe0wkOhA+sjTyvcsjxbcj
         7lq9tETGXN3Y+wo9B8ZO8+6lFZLYJ4z2HaDOIRTlrNHPaAI2VNhz1k8CaVoWB08gptla
         6ONFvXULXbnP834F06gizCqArSE6Pfd7BQwwuDIgZz2VCQ27dtWQ09v4U2Ahyj4RE5gm
         akIHD8s1O+G+pM1uhivSxatUXq6F5T0WgUDFfzY313iVGKjUgyDPBAWgMBKN1zfcT1BU
         F/0pJPovZpYODcHuRFBniufOCtkCHc+8fl8FUXp5jqYjFca5/9yGNe3szPK8qt3QSGwV
         xgrg==
X-Gm-Message-State: ABuFfohdJhBw5xUrkgVBtpwmh5yv+/yWOrCpbsAfo4ublIgyX7PQzGE/
        OgpvkI4XtRh7RD29YWJsp7bhbIuZ
X-Google-Smtp-Source: ACcGV63YNvnUfQ5C4fZgIWdpenKWcLfwbq5GKmgMsqdNqXqgeJrQWwXGascKkpZHCeqSwBq3Qp3aww==
X-Received: by 2002:a17:902:9045:: with SMTP id w5-v6mr503953plz.10.1537822671745;
        Mon, 24 Sep 2018 13:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p3-v6sm236884pfo.130.2018.09.24.13.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:57:50 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:57:50 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Sep 2018 20:57:47 GMT
Message-Id: <pull.39.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.v3.git.gitgitgadget@gmail.com>
References: <pull.39.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] Properly peel tags in can_all_from_reach_with_flags()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff reported [1], the refactored can_all_from_reach_with_flags() method
does not properly peel tags. Since the helper method can_all_from_reach()
and code in t/helper/test-reach.c all peel tags before getting to this
method, it is not super-simple to create a test that demonstrates this.

I modified t/helper/test-reach.c to allow calling
can_all_from_reach_with_flags() directly, and added a test in
t6600-test-reach.sh that demonstrates the segfault without the fix.

For V2, I compared the loop that inspects the 'from' commits in commit
ba3ca1edce "commit-reach: move can_all_from_reach_with_flags" to the version
here and got the following diff:

3c3
<                 if (from_one->flags & assign_flag)
---
>                 if (!from_one || from_one->flags & assign_flag)
5c5,7
<                 from_one = deref_tag(the_repository, from_one, "a from object", 0);
---
>
>                 from_one = deref_tag(the_repository, from_one,
>                                      "a from object", 0);
14a17,22
>
>                 list[nr_commits] = (struct commit *)from_one;
>                 if (parse_commit(list[nr_commits]) ||
>                     list[nr_commits]->generation < min_generation)
>                         return 0; /* is this a leak? */
>                 nr_commits++;

This diff includes the early termination we had before 'deref_tag' and the
comment for why we can ignore non-commit objects.

[1] 
https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u

Derrick Stolee (1):
  commit-reach: properly peel tags and clear flags

 commit-reach.c        | 44 +++++++++++++++++++++++++++++++++----------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 +++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 17 deletions(-)


base-commit: 6621c838743812aaba96e55cfec8524ea1144c2d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-39%2Fderrickstolee%2Ftag-fix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-39/derrickstolee/tag-fix-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/39

Range-diff vs v3:

 1:  0a1e661271 ! 1:  a0a3cf0134 commit-reach: properly peel tags
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    commit-reach: properly peel tags
     +    commit-reach: properly peel tags and clear flags
      
          The can_all_from_reach_with_flag() algorithm was refactored in 4fbcca4e
          "commit-reach: make can_all_from_reach... linear" but incorrectly
     @@ -14,6 +14,19 @@
          Correct the issue by peeling tags when investigating the initial list
          of objects in the 'from' array.
      
     +    The can_all_from_reach_with_flag() method uses 'assign_flag' as a
     +    value we can use to mark objects temporarily during our commit walk.
     +    The intent is that these flags are removed from all objects before
     +    returning. However, this is not the case.
     +
     +    The 'from' array could also contain objects that are not commits, and
     +    we mark those objects with 'assign_flag'. Add a loop to the 'cleanup'
     +    section that removes these markers.
     +
     +    Also, we forgot to free() the memory for 'list', so add that to the
     +    'cleanup' section. Also, use a cleaner mechanism for clearing those
     +    flags.
     +
          Signed-off-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -74,10 +87,18 @@
       
       cleanup:
      -	for (i = 0; i < from->nr; i++) {
     -+	for (i = 0; i < nr_commits; i++) {
     - 		clear_commit_marks(list[i], RESULT);
     - 		clear_commit_marks(list[i], assign_flag);
     - 	}
     +-		clear_commit_marks(list[i], RESULT);
     +-		clear_commit_marks(list[i], assign_flag);
     +-	}
     ++	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
     ++	free(list);
     ++
     ++	for (i = 0; i < from->nr; i++)
     ++		from->objects[i].item->flags &= ~assign_flag;
     ++
     + 	return result;
     + }
     + 
      
      diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
      --- a/t/helper/test-reach.c
 2:  b2e0ee4978 < -:  ---------- commit-reach: fix memory and flag leaks

-- 
gitgitgadget

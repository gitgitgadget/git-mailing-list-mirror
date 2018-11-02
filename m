Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084EB1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKBWVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:21:53 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:43496 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeKBWVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:21:53 -0400
Received: by mail-pl1-f173.google.com with SMTP id g59-v6so1004016plb.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDlYTP8Z3ukON1MHm7RYfzbPdTT/NNch3DaIocCE7A4=;
        b=uw2XJS9MCjrycgmHM2JQfy6P1zDn5jHUZgiGHtqs+NhnX3aJFKlo6yzKJq0mcQB356
         Bm+0zHvXapKAWhKC59eJPdh97eKwAXiIahsZh9AZU3rzdDdNzVGTLmtV9LIavQ3eGLwR
         BYwKrUEqdd1Zw9OHasXhDPGy0INc7bJoBA930YvAiiVVGFD98LEkJPzSfI/rXQEeI2+S
         IwwOkhfDXKGNnAt+yImIcDzhZyznE54QK37tW4tbuDxFd8bMoOEEFt8GTUQ1/xl8QdSJ
         47qjYicGiwqTOS0V6vhi52YSVxkSpr0QJjc+Qh4Yu/xcw25AtEsYgHd3C/4EKvmA9vHI
         avuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDlYTP8Z3ukON1MHm7RYfzbPdTT/NNch3DaIocCE7A4=;
        b=isIL6PbgfARfoci2FnqIVZ7Y3lHshTN4Ncupiyxs4a4ehq/FzpDicVuRJHfyv1mUKk
         JdsmYLadn7dTUbqG9FVSO0+Ap5GclqXu/eEg2NNCGszJI4sQ0dOOwY9tN8RkFI5/Eu53
         gJGqw8xcl8X4CRyTB56hyl3aF9xx+jAjLvTi6P2FuBI65LDNAeCF4zL6jDwksKFA5Y1z
         QlaZs9+66VrWG2KmpnOB5KpAirsihFgTk8M+kKbESL2Clu4z0RNkyrlCkTyarMAek1oS
         GIxiUIYdSEhLTyoBnRnAeKomLZDYaF89jEPx6kHiIEQnme3i1CHfppoxA368Zo+9OfEA
         Kgpg==
X-Gm-Message-State: AGRZ1gJRZ8pFFEh4t+8aab2i5sPo+J30oiNNhA3Fzg7Ys/bmrhVLhKzX
        pa2E8udeSM8151A5fh6V+HAlcTN9
X-Google-Smtp-Source: AJdET5cpULDBvG+IDeLhN42aWszmOHXwUlFgCDFrXJnlJv1rER0XyJn4JV8PfUqM+Zgs4djdmt+OrQ==
X-Received: by 2002:a17:902:9009:: with SMTP id a9-v6mr11812206plp.134.1541164485147;
        Fri, 02 Nov 2018 06:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c128-v6sm31502874pfb.147.2018.11.02.06.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:14:44 -0700 (PDT)
Date:   Fri, 02 Nov 2018 06:14:44 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Nov 2018 13:14:39 GMT
Message-Id: <pull.60.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Make add_missing_tags() linear
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported earlier [1], the add_missing_tags() method in remote.c has
quadratic performance. Some of that performance is curbed due to the
generation-number cutoff in in_merge_bases_many(). However, that fix doesn't
help users without a commit-graph, and it can still be painful if that
cutoff is sufficiently low compared to the tags we are using for
reachability testing.

Add a new method in commit-reach.c called get_reachable_subset() which does
a many-to-many reachability test. Starting at the 'from' commits, walk until
the generation is below the smallest generation in the 'to' commits, or all
'to' commits have been discovered. This performs only one commit walk for
the entire add_missing_tags() method, giving linear performance in the worst
case.

Tests are added in t6600-test-reach.sh to ensure get_reachable_subset()
works independently of its application in add_missing_tags().

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com/

Derrick Stolee (3):
  commit-reach: implement get_reachable_subset
  test-reach: test get_reachable_subset
  remote: make add_missing_tags() linear

 commit-reach.c        | 70 +++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        | 13 ++++++++
 remote.c              | 34 ++++++++++++++++++++-
 t/helper/test-reach.c | 34 ++++++++++++++++++---
 t/t6600-test-reach.sh | 52 ++++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 5 deletions(-)


base-commit: c670b1f876521c9f7cd40184bf7ed05aad843433
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-60%2Fderrickstolee%2Fadd-missing-tags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-60/derrickstolee/add-missing-tags-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/60

Range-diff vs v1:

 1:  4c0c5c9143 ! 1:  9e570603bd commit-reach: implement get_reachable_subset
     @@ -49,7 +49,7 @@
      +
      +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
      +					 struct commit **to, int nr_to,
     -+					 int reachable_flag)
     ++					 unsigned int reachable_flag)
      +{
      +	struct commit **item;
      +	struct commit *current;
     @@ -129,9 +129,12 @@
      + * Return a list of commits containing the commits in the 'to' array
      + * that are reachable from at least one commit in the 'from' array.
      + * Also add the given 'flag' to each of the commits in the returned list.
     ++ *
     ++ * This method uses the PARENT1 and PARENT2 flags during its operation,
     ++ * so be sure these flags are not set before calling the method.
      + */
      +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
      +					 struct commit **to, int nr_to,
     -+					 int reachable_flag);
     ++					 unsigned int reachable_flag);
      +
       #endif
 2:  382f4f4a5b = 2:  52e847b928 test-reach: test get_reachable_subset
 3:  ecbed3de5c = 3:  dfaceb162f remote: make add_missing_tags() linear

-- 
gitgitgadget

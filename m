Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B49A1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 03:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeJOL0W (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 07:26:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOL0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 07:26:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so19499130wrt.2
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rYU2/dg36yUl8hXRnrf1aFrwcoT1Aw/uY0/5riezsSA=;
        b=H1+0zYXs+MLxQelelK9NrEKxJTH3t9NIYHv0H+HaTEqbqOL0F/x4y3Es55OGEmPoG/
         ucWt6WZmC38H732a6aC4RmASH+KzPNNl6Ii0S+Df/z9Sxuyme2nQsfIQYsT95r6CPa/O
         +gMxPyJJuT4f4h+CcCv6+SKcUcwRfbhPqOXZTwoXsHlD9IqKzKgQzICnYvabazQ5EK3J
         xuIV8FbyalXOYccydXcFPl5CJG+F2lJwM3lfWABNcYkbvnlcZSbSJ/Fe6b3ZcbOeMVci
         9xexj4KJBWhdfakh0w3XNe9ta0hAR3nKaxHzxQNlcdljMkNAAdJLrEizcesIZOb3MNIl
         SRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rYU2/dg36yUl8hXRnrf1aFrwcoT1Aw/uY0/5riezsSA=;
        b=ThTcZxcWGkuN3AyJ9f0rInaO0KOZ/8sTVteY6CJbNygqfv4zXrKtQ1cc7X6srKl0TE
         wkLaNsvzWISUZHk04onU9d0aeW8Y35NlVfZTDsia/Te0gkv7VFm6e9H86Oy3XFJmcU5r
         X748OT1JVFxGjg00H9l15Kou0aLmwnAfAbfG7HiFyNzrwNBdUYMQfnMotZBl4+zb63ag
         r3y3Gzn+rb4U5QQDC1imOdaibnBMyoMc218kPtqkL2BFrsA2yACdE0ezL+k5lEXKTiJI
         4rKZxnAwIcPbvNcNeUgQBD1bcrv5uIfHon9IImlZfLMujoLQRUt3h62VObiyJoX7yqWC
         RY1A==
X-Gm-Message-State: ABuFfoj3H7uOLbneB0W2GMdxidzuseKVr8Drr10jrc1gfTMitexajSSK
        a9zPH4oAdQ/8O0RoGLFE1GY=
X-Google-Smtp-Source: ACcGV62hfHll78ICoZfgr6pu+Kkttrcgh0YRuYssHfenNLZj0sZOhnBKHu9KIECmFR7/MPK62upV7Q==
X-Received: by 2002:adf:8065:: with SMTP id 92-v6mr12525986wrk.23.1539574979141;
        Sun, 14 Oct 2018 20:42:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c14-v6sm10869719wmh.44.2018.10.14.20.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 20:42:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v12 0/8] filter: support for excluding all trees and blobs
References: <cover.1533854545.git.matvore@google.com>
        <cover.1539373969.git.matvore@google.com>
        <xmqqd0sc6ilk.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 15 Oct 2018 12:42:57 +0900
In-Reply-To: <xmqqd0sc6ilk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 15 Oct 2018 11:37:11 +0900")
Message-ID: <xmqqr2gr6fjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthew DeVore <matvore@google.com> writes:
>
>> Here is a re-roll-up since I haven't received any additional corrections for
>> almost a week.
>
> Sorry, but doesn't this topic already sit in 'next'?  If so, please make
> these small clean-ups as incremental patches.

Here is what I'd queue for now, with forged s-o-by from you ;-).

Thanks.

-- >8 --
From: Matthew DeVore <matvore@google.com>
Date: Fri, 12 Oct 2018 13:01:41 -0700
Subject: [PATCH] filter-trees: code clean-up of tests

A few trivial updates to test to match the current best practices.

 - avoid "grep -q" that strips potentially useful output from running
   tests under "-v".

 - use test_write_lines to prepare multi-line expected output file

 - reserve use of test_must_fail to "git" commands.

Signed-off-by: Matthew DeVore <matvore@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5317-pack-objects-filter-objects.sh | 2 +-
 t/t5616-partial-clone.sh               | 2 +-
 t/t6112-rev-list-filters-objects.sh    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 510d3537f6..d9dccf4d4d 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -69,7 +69,7 @@ test_expect_success 'get an error for missing tree object' '
 	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
 	HEAD
 	EOF
-	grep -q "bad tree object" bad_tree
+	grep "bad tree object" bad_tree
 '
 
 test_expect_success 'setup for tests of tree:0' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 53fbf7db88..392caa08fd 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -192,7 +192,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
 
 	sort -u fetched_types >unique_types.observed &&
-	printf "blob\ncommit\ntree\n" >unique_types.expected &&
+	test_write_lines blob commit tree >unique_types.expected &&
 	test_cmp unique_types.expected unique_types.observed
 '
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 2cbb81d3bb..d24f9d5b5a 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -38,8 +38,8 @@ test_expect_success 'specify blob explicitly prevents filtering' '
 		 awk -f print_2.awk) &&
 
 	git -C r1 rev-list --objects --filter=blob:none HEAD $file_3 >observed &&
-	grep -q "$file_3" observed &&
-	test_must_fail grep -q "$file_4" observed
+	grep "$file_3" observed &&
+	! grep "$file_4" observed
 '
 
 test_expect_success 'verify emitted+omitted == all' '
@@ -241,7 +241,7 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
 	xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&
 
 	sort -u unsorted_filtered_types >filtered_types &&
-	printf "blob\ntree\n" >expected &&
+	test_write_lines blob tree >expected &&
 	test_cmp expected filtered_types
 '
 
-- 
2.19.1-328-g5a0cc8aca7


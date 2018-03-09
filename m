Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B461F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbeGKMmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:42:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeGKMmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so2838963pgv.0
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=etyyWltjX4R6CcU1NT9PwXzmzAmUjuM1IWr4FVmy8rI=;
        b=aK5BNYId9xo1RrQTmsqhG9Tnvx/vft6UdgzMuAWcMRabth5byv6TIAY60kYlLp+OdV
         MY8LIQugwv/ihxIto2hR41Ok0R7dqm/OK57r/5rHHhLC1TjMhDi+v+5BF0w3rvgI9oYn
         lYVC2nBCUhLfQ+ZEhIDoCLTXQGKClGWqvZwRrKrWvhTXD0hfxE8clx3shd37Vkwawp7a
         5cmg8ooiLWcodyWGVwYbU3wu/HB270rFhaDkv8aBoko0Z9ZbKHRa+kNlV0Rl7x/5jcM1
         hznKrxwH3wFrHl5913DUrHXdCW8ACalPJqj+wHvUD7XZBhAoQT99mCWXyhkk3FjUQnGG
         RFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=etyyWltjX4R6CcU1NT9PwXzmzAmUjuM1IWr4FVmy8rI=;
        b=oscKce0pc29iRNdE7coy6xDNgzScRT9x9YK/vhgVznXYxgyoV2gJCVcIAJYgsOc2cU
         4X+8vuRjP872h2KJvPr5BwCTzhO0frUXDl+cibA0VIBWqPsOAP4Y2sUXiS3N5GhkGbmt
         SHifTfa9KeIJMEXj5rn1G7IX/+J3hRKJDRr+nAw5uaC3BTj3z86etD2n0rIh5ks/EPry
         x9Vi8r01fJmZ7Qhl3pfCoILHk8vdm1EG699OqwV3aTkhE3ItWiAEpbnznmIhQ5mqUc4V
         ETS+WLtorGEoDMxJ+K2kU0YLlHEu91tz0OBSCxglQocyxXHxTQ2e9DgAyhZKFnnOTHBV
         64Lw==
X-Gm-Message-State: APt69E1776NL/q2yONfuJOYqy3xlEXW4ggsD+Iq9d2ZvHIirjNFuv41m
        nKg2UGvKgafJSh6iDxIlUqlzLQ==
X-Google-Smtp-Source: AAOMgpfxGV71LgssvE4ruxRK1ODaA6pa0Q/aHZTtgTXw3WlXJYw4rBzhDm5vjc1pSRlKYDbT12M4qw==
X-Received: by 2002:a62:398c:: with SMTP id u12-v6mr30076185pfj.9.1531312695763;
        Wed, 11 Jul 2018 05:38:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id b1-v6sm23317019pfa.181.2018.07.11.05.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:38:14 -0700 (PDT)
Message-Id: <20cd1b914e74c8f45e5cc9ed82d83eee1463cd91.1531312689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.8.git.gitgitgadget@gmail.com>
References: <pull.8.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 9 Mar 2018 17:36:47 +0100
Subject: [PATCH 3/3] rebase --rebase-merges: adjust man page for octopus
 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that we support octopus merges in the `--rebase-merges` mode,
we should give users who actually read the manuals a chance to know
about this fact.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0e20a66e7..c4bcd24bb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -879,8 +879,8 @@ rescheduled immediately, with a helpful message how to edit the todo list
 (this typically happens when a `reset` command was inserted into the todo
 list manually and contains a typo).
 
-The `merge` command will merge the specified revision into whatever is
-HEAD at that time. With `-C <original-commit>`, the commit message of
+The `merge` command will merge the specified revision(s) into whatever
+is HEAD at that time. With `-C <original-commit>`, the commit message of
 the specified merge commit will be used. When the `-C` is changed to
 a lower-case `-c`, the message will be opened in an editor after a
 successful merge so that the user can edit the message.
@@ -889,7 +889,8 @@ If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
 At this time, the `merge` command will *always* use the `recursive`
-merge strategy, with no way to choose a different one. To work around
+merge strategy for regular merges, and `octopus` for octopus merges,
+strategy, with no way to choose a different one. To work around
 this, an `exec` command can be used to call `git merge` explicitly,
 using the fact that the labels are worktree-local refs (the ref
 `refs/rewritten/onto` would correspond to the label `onto`, for example).
-- 
gitgitgadget

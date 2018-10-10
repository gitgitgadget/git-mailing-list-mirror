Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755CD1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJJQPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:15:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35653 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJQPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:15:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so2211600plb.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Ce7OZ4FvMzW+aINjCIITmJXe/9VSuVeKhvJPrHBWwQ=;
        b=QUEsjQvRrtvxy8femWK3QLI6iQOgmdc0oqdygSziGCYCxXxs7+yaGhqfCX6gPioSyS
         40+Zi75Rv26KmCzpmvQdvDTg/5mkBwR4Oq2qZkS6ZWGpOV+tHkRUF1tADnZshO3vFrO1
         D3lT4DXnqtKgjZnd84F+vW8LLc1cLXADgumrwzsqYBInH8IsDa9ev3KVYcSj4Acs41AH
         bH8cg5Z3FTyhfY7IgtuvvzVxRQE5frAf7JyM2KevnoR+p9r7tek0vzK3aYI+AXHMlFTy
         skfXh7rK//dvug/+p7WlJfy4uy3c3haXuPpaWwbhKFZuy81b1kGdM0ahvE88Fcjm08qg
         fc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Ce7OZ4FvMzW+aINjCIITmJXe/9VSuVeKhvJPrHBWwQ=;
        b=L2Oj+GenPWKbMkvUav4qdtkYz7YKM542lDwUEIm0tjeMsIzTWQRjtAphcZmof/dcMG
         u2R8IZaV5+FA+4yWmKnlq1oUHM+fEx10RmISN9j43AsclKfp8XrVvg+dLtP4HUIOUDAH
         RIC0vB0vCyqmCsBe983AA1+2bjwfRWbJMnq4kHzZgpLQm8CWGSwkaf3ry2wDbWx0v6b8
         Rf5L8o+z1eviBbW2/TVnSvoP/gS6tq2hJyX4qcNwlVUkkzyuBqMe0ufHbd2ATCzNNjTE
         T6G2CMLk0cCmx/Pxn2LM1U/FmqOv0F8ZHmMGhVo9LgfavsgopzNsvykRzQV6eU61A9zy
         saPQ==
X-Gm-Message-State: ABuFfoicHZKhu1t2jd9VQrCRNptmsu3uygFvndkP4Fx4IqmdlrmlPTvp
        ElK4IqFz5je8ooYZaubCST619Joc
X-Google-Smtp-Source: ACcGV63yKT3uO4woummFfC+cj7c178OKloEH9Qxs/sUn3CaBapClsQjGP1cnRkotixZDn3jFPAQRMw==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5-v6mr31391027pll.200.1539161635671;
        Wed, 10 Oct 2018 01:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id x73-v6sm36948017pfk.139.2018.10.10.01.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:53:54 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:53:54 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Oct 2018 08:53:50 GMT
Message-Id: <pull.43.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.git.gitgitgadget@gmail.com>
References: <pull.43.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] rebase -i: introduce the 'break' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan asked a while back
[https://public-inbox.org/git/20180118183618.39853-3-sbeller@google.com/] 
for a todo command in interactive rebases that would essentially perform the
"stop" part of the edit command, but without the "pick" part: interrupt the
interactive rebase, with exit code 0, letting the user do things and stuff
and look around, with the idea of continuing the rebase later (using git
rebase --continue).

This patch introduces that, based on ag/rebase-i-in-c.

Changes since v1:

 * Wrapped the commit message correctly.
 * Added a preparatory patch to mention what happens in case an exec fails.
 * Mentioned the break command in the git-rebase(1) documentation.

Johannes Schindelin (2):
  rebase -i: clarify what happens on a failed `exec`
  rebase -i: introduce the 'break' command

 Documentation/git-rebase.txt | 6 +++++-
 rebase-interactive.c         | 1 +
 sequencer.c                  | 7 ++++++-
 t/lib-rebase.sh              | 2 +-
 t/t3418-rebase-continue.sh   | 9 +++++++++
 5 files changed, 22 insertions(+), 3 deletions(-)


base-commit: 34b47315d9721a576b9536492cca0c11588113a2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-43%2Fdscho%2Frebase-i-break-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-43/dscho/rebase-i-break-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/43

Range-diff vs v1:

 -:  ---------- > 1:  2eefdb4874 rebase -i: clarify what happens on a failed `exec`
 1:  b358178548 ! 2:  c74e02c4b6 rebase -i: introduce the 'break' command
     @@ -11,11 +11,26 @@
          before cherry-picking a commit, or immediately after an 'exec' or a
          'merge'.
      
     -    This commit introduces that functionality, as the spanking new 'break' command.
     +    This commit introduces that functionality, as the spanking new 'break'
     +    command.
      
          Suggested-by: Stefan Beller <sbeller@google.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     +diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
     +--- a/Documentation/git-rebase.txt
     ++++ b/Documentation/git-rebase.txt
     +@@
     + the files and/or the commit message, amend the commit, and continue
     + rebasing.
     + 
     ++To interrupt the rebase (just like an "edit" command would do, but without
     ++cherry-picking any commit first), use the "break" command.
     ++
     + If you just want to edit the commit message for a commit, replace the
     + command "pick" with the command "reword".
     + 
     +
      diff --git a/rebase-interactive.c b/rebase-interactive.c
      --- a/rebase-interactive.c
      +++ b/rebase-interactive.c

-- 
gitgitgadget

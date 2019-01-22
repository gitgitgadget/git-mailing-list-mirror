Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040021F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAVXXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:23:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34857 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfAVXXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:23:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so142707plo.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k+TPSMikRHGe00Y9/ylkGBGbmW32jHu3jvBhxMQ9pSA=;
        b=q+bD0CXsZNqm5cSuJEdUNdDmZJmlJKdgauV0qIWu7kY1qWeegohtl3Z2toNlmj8I0o
         YV07MVpMEhQ8iZCJ+XP5lJFaC9agE3JZvhY88vP85mPsCgRDGDguMj+uEhCdEjO+2Aix
         6dAeZocv7pxt/OYRDcHYZlphOhuwMWozoH0WThoseQX4nxFzKt7MdBf9xPeF9iFgW/YW
         BzelfIOyZ2pqJaKu4O5eYcXnSJ5RQ2ATIyAHUP8zzSXg1Hm47QaIn+lqHm31aQHliNld
         l9M5ojs5h8N10YOOq7cioA8sbAtwayjcsus01QSCrDU3gjlbildVqqutUT0EEUnf+bgI
         2MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k+TPSMikRHGe00Y9/ylkGBGbmW32jHu3jvBhxMQ9pSA=;
        b=aPND/wRpjG0d6DtgnW3+DQ6dXzyNUSvgLxv/JIR6i9HWqxaFRLz7OmYqUW1W97nLuq
         jdAS3BNCrkA3RF+Jfck8Xj+5yXGIRJJjkQF/mrCS6rDYs4sUwDtLcaqbtjx7s4pkRQNv
         pcqw+aA9JWvlJ82cacjmrZNyG5jb0A+xU7i7Q5WrE581qRb5sIdjTozPXpLOFWfCrFhM
         j0wO3SeCT+NlS9F5DqwNGRWMc8Cs02T27Nkmby3joJ/db7Um3yrkp3h17RlvxPIThZB7
         16CVpxVjCGVxRA4YCWnmQRQI8x1lR53y3ydT43YehuxQ7sa/drAFuuKk0I4FsthIsT4t
         xjRg==
X-Gm-Message-State: AJcUukdGl936Q/bW75MIGpciNfvSxTCmVxbe8epALD9jaBBDQ1q03JCs
        EpLccNXrFCK0EQXXO6Nl/IwSKVuP
X-Google-Smtp-Source: ALg8bN5Fyt8ZOJLj2Fkgg64KSX58imntpPwEzDCqwYJ/mln2+hHh1bBudL8HJHn75QLyL6XGT755OQ==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr35215436plk.196.1548199395296;
        Tue, 22 Jan 2019 15:23:15 -0800 (PST)
Received: from localhost.localdomain ([12.167.51.36])
        by smtp.gmail.com with ESMTPSA id 84sm23608057pfk.134.2019.01.22.15.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 15:23:14 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v6 0/3] 
Date:   Tue, 22 Jan 2019 15:22:58 -0800
Message-Id: <20190122232301.95971-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

From the latest round of comments:
-Added a check in populate_value to only do the hashmap lookup for refs of type branch,
since other types would not be checked out in a worktree
-Reworded the commit message on 2/3 to make it clearer that the change in output is meant
to inform users that the colored/marked branches will behave differently from the others
upon attempts to delete or check out
-Removed the extra verbose check on 3/3 and added the worktree path to the output if it exists
-Set 'worktrees' variable to NULL after free-ing, to allow for ref-filter to be reentrant

Travis-CI results: https://travis-ci.org/nbelakovski/git/builds/483134182

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: Mark and color a branch differently if it is checked out in a
    linked worktree
  branch: Add an extra verbose output displaying worktree path for refs
    checked out in a linked worktree

 Documentation/git-branch.txt       | 22 +++++++-----
 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++---
 ref-filter.c                       | 74 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |  8 ++---
 t/t3203-branch-output.sh           | 21 +++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 7 files changed, 144 insertions(+), 17 deletions(-)

-- 
2.14.2


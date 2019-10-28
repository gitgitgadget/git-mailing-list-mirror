Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433221F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJ1LUU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:20:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55752 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:20:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so8999290wmh.5
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NQ5bYP6r2gzvbX+fz+Wgp8V69PLbDmuVzILV8dN8Uos=;
        b=taoy3RLqRypVm1OqtYV2V60hpPontICVTK+f6bXNYhRiHi5zp1W7cCdpgDZcA69/66
         LNUOk9oGW6VbUz2NnFgriuk3/djlz1j/GNlLQTJj1WT2pEaTijsUqpZMzXdGL+DGoMAw
         S7ax797zPRqsZCG+K0wLXDXLvrJdXxug1vmTP8hYbDrx2O+GSA7JoRYPbSjuz3Gl5I38
         gDzYpLmAjnhpj3L6T4Wh9rJ58DoRlPbh36oH6/0gwu0/4Q+qaTq17go9soc8gtSXem1E
         h9u5TK08RgoRwtUc1qPyCDdfWEZhnJChOwAl1hwMlQVan9E6D4XdpeP1wxIaKOwMAjxP
         +C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NQ5bYP6r2gzvbX+fz+Wgp8V69PLbDmuVzILV8dN8Uos=;
        b=SE5K14jhcCKYJA97E1x0+4lW9kIRnTy8raIjuznvPOFSDXjRdCzXh3BxA2ouiB+twT
         1l4BLwWjxUHo6+EEpqt/IwwkcM77BVH5vTAG/RYYIH00CRt+qxqcgRjRMZ+k6JL4JSO2
         +kjppwV9S6TtjB5g9DNXgiY7n7aALs7jyP+7EY5iPFP9WpFMzR1qkJi4TALQX2C85VAQ
         eJLoWF/KWnb8afBbt294YuSYeMU4R9ECeGIUP+Jq4YJe7Pk559SZuTksHJM5mMlRTWF+
         kdaH7yTC2oHfzPyWPZHMWBOmkgnWINwOsPE99KOIh/wqvb/Zic15+Qb+O4sBJSSzNYro
         a2MQ==
X-Gm-Message-State: APjAAAV3cnhppvEPs2Xr58qoxQfa6YiDbVP7F8/nlzWIGIl34Kn489vZ
        G3vWebty9MTqibivFIpQ7QNXWTqx
X-Google-Smtp-Source: APXvYqzgYLFclCcCb3jLhzGogzYMeD+3QtwTgmq6VEW9dkM+unvVKExbmxi/KVACBjqw06sEPpTGIA==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr15927013wmd.8.1572261617134;
        Mon, 28 Oct 2019 04:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u68sm16300995wmu.12.2019.10.28.04.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:20:16 -0700 (PDT)
Message-Id: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.git.gitgitgadget@gmail.com>
References: <pull.355.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 11:20:13 +0000
Subject: [PATCH v2 0/2] Fix git stash with skip-worktree entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My colleague Dan Thompson reported a bug in a sparse checkout, where git
stash (after resolving merge conflicts and then making up their mind to
stash the changes instead of committing them) would "lose" files (and files
that were not even in the sparse checkout's cone!).

I first considered changing the behavior of git diff-index to simply ignore
skip-worktree entries. But after re-reading the documentation of the
skip-worktree bit, I became convinced that this would be incorrect a fix
because the command really does what it advertises to do.

Then, I briefly considered introducing a flag that would change the behavior
thusly, but ended up deciding against it.

The actual problem, after all, is the git update-index call and that it
heeds the --remove (but not the --add) option for skip-worktree entries.
"Heeds", I should say, because the idea of the skip-worktree bit really is
documented to imply that the worktree files should be considered identical
to their staged versions.

So arguably, it could be considered a bug that git update-index --remove 
even bothers to touch skip-worktree entries. But this behavior has been in
place for over 10 years, so I opted to introduce a new mode that does what 
git stash needs in order to fix the bug.

Changes since v1:

 * Added a test even for the --ignore-skip-worktree-entries option alone
   (i.e. without going through git stash)
 * Rebased onto tg/stash-refresh-index to avoid merge conflicts in 
   t/t3903-stash.sh.

Johannes Schindelin (2):
  update-index: optionally leave skip-worktree entries alone
  stash: handle staged changes in skip-worktree files correctly

 Documentation/git-update-index.txt |  6 ++++++
 builtin/stash.c                    |  5 +++--
 builtin/update-index.c             |  6 +++++-
 git-legacy-stash.sh                |  3 ++-
 t/t3903-stash.sh                   | 11 +++++++++++
 t/t7012-skip-worktree-writing.sh   | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 4 deletions(-)


base-commit: 34933d0eff5d4c91fae6ad6f71a6e6a69a496ced
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-355%2Fdscho%2Ffix-stash-with-skip-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-355/dscho/fix-stash-with-skip-worktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/355

Range-diff vs v1:

 1:  c263eb54b3 ! 1:  86dbb11f15 update-index: optionally leave skip-worktree entries alone
     @@ -72,3 +72,28 @@
       		OPT_SET_INT(0, "info-only", &info_only,
       			N_("add to index only; do not add content to object database"), 1),
       		OPT_SET_INT(0, "force-remove", &force_remove,
     +
     + diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
     + --- a/t/t7012-skip-worktree-writing.sh
     + +++ b/t/t7012-skip-worktree-writing.sh
     +@@
     + 	test_i18ncmp expected result
     + '
     + 
     ++test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
     ++	test_commit geroff-me &&
     ++	git update-index --skip-worktree geroff-me.t &&
     ++	rm geroff-me.t &&
     ++
     ++	: ignoring the worktree &&
     ++	git update-index --remove --ignore-skip-worktree-entries geroff-me.t &&
     ++	git diff-index --cached --exit-code HEAD &&
     ++
     ++	: not ignoring the worktree, a deletion is staged &&
     ++	git update-index --remove geroff-me.t &&
     ++	test_must_fail git diff-index --cached --exit-code HEAD
     ++'
     ++
     + #TODO test_expect_failure 'git-apply adds file' false
     + #TODO test_expect_failure 'git-apply updates file' false
     + #TODO test_expect_failure 'git-apply removes file' false
 2:  4c684be179 ! 2:  9835e66399 stash: handle staged changes in skip-worktree files correctly
     @@ -59,7 +59,7 @@
       --- a/t/t3903-stash.sh
       +++ b/t/t3903-stash.sh
      @@
     - 	test_path_is_missing to-remove
     + 	git stash apply
       '
       
      +test_expect_success 'stash handles skip-worktree entries nicely' '

-- 
gitgitgadget

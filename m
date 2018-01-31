Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B00B1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeAaLGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:02 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36871 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:01 -0500
Received: by mail-pf0-f181.google.com with SMTP id p1so12242379pfh.4
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqP/52xiTgGU94GrNrrzTiVt1sdDpxyobVQWfwzLt8c=;
        b=Ud8+O7DUS64vg7Ln85JyqYh4m43Q5hCgH6k8BfwW2xo1OrFOajdD83S+Rvoo6jJ0mi
         VcReTEu3gd0bijMUcFBXJ0gnhTlp3DdMxCpm6dUf6vOtikM5a5b5m4kwvFqWJp5pqBN6
         B4YweqpYmjVC6mlrgI/OXCQozWPChS+ZzGZEGwV/qtDbB0H1jQ3XC73Bm+r5hBeHwIHA
         +6ITtAybQl5xuQC8BJTJz60HcNNXWJ9UQWDqRdXaOwYCu7alXd7MdiSWc24dYY+EnBOl
         JmmIT/ckCD8zIEUC4Rpm3oQp/+TSg+fHBJIhnX2yWKGMAmNJ8bP4Jp44Ma3ksNDi8IxA
         tR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqP/52xiTgGU94GrNrrzTiVt1sdDpxyobVQWfwzLt8c=;
        b=ioblql0cKxa2bljT7DsKBny36rm4UrY9xpCKhnEkgP9pbY0JaD53w9Fg2pVfjRLIqD
         si5fxTSi5/5s2YUhk7nhPa8KhcfRnYV/1bQMbKVc1MdqvC3JpV+EYh0WbEZlMRl+m9wb
         x9FM9aTGHXVQ0eIyKYWq4oBRj7HHh6M7Yfr+d8SWi9kQZZ0umhwbP2IEQ5+XYMHNHqaa
         RtmFy31Sr3gEdc7AYYXVgiM1puruxjEfjMfB2vEP1u59tUwUKgWyHoeW+UsRnDDiLCxt
         yboX7zvPbunmE9BZN6xi2vLgKW0j9mca2JsR8DjqXxN/7EhxveDw5wqN/EfYp3Y+OiqR
         Qi0Q==
X-Gm-Message-State: AKwxytfmBvFgEcNPD3Ew6Spv91F3ik23OiMBqFDeNAjxxJM17Geh8lCF
        ebAooKFC2s7y+TYDZfuOBF4i8w==
X-Google-Smtp-Source: AH8x227vhBqWNK3FA31/mA5UTTj+/YvHzDokENoF30mXJkxI9dZ7HrhWEOoBMFpCX5gQdQ418CTbvg==
X-Received: by 10.98.58.194 with SMTP id v63mr33432950pfj.36.1517396760745;
        Wed, 31 Jan 2018 03:06:00 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id v20sm39897962pfe.176.2018.01.31.03.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:05:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:05:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/41] Automate updating git-completion.bash a bit
Date:   Wed, 31 Jan 2018 18:05:06 +0700
Message-Id: <20180131110547.20577-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I posted a proof of concept a while back [1]. This is the full version.

This series lets "git" binary help git-completion.bash to complete
--<stuff> so that when a new option is added, we don't have to update
git-completion.bash manually too (people often forget it). As a side
effect, about 180 more options are now completable.

parse-options is updated to allow developers to flag certain options
not to be completable if they want finer control over it.  But by
default, new non-hidden options are completable. Negative forms must
be handled manually. That's for the next step.

The number of patches is high, but changes after the first four
patches and 33/41 are quite simple. I still need some eyeballs though
to make sure I have not accidentally allowed completion of dangerous
options. Details are broken down per command in each commit message.

If people want to play with this, I have a script [2] that shows all
completable options for most commands (I ignore some that are
shell-based because I don't touch them in this series). You can then
do a "diff" to see new/old options.

There's a small conflict with 'pu' because --prune-tags is added in
git-completion.bash. The solution is simple and beautiful: ignore
those changes, --prune-tags will be completable anyway :)

[1] https://public-inbox.org/git/%3C20180116103700.4505-1-pclouds@gmail.com%3E/
[2] https://gist.github.com/pclouds/f337d4393b5cfab813909b8eea2eaa40

Nguyễn Thái Ngọc Duy (41):
  parse-options: support --git-completion-helper
  parse-options: add OPT_xxx_F() variants
  parse-options: let OPT__FORCE take optional flags argument
  git-completion.bash: introduce __gitcomp_builtin
  completion: use __gitcomp_builtin in _git_add
  completion: use __gitcomp_builtin in _git_am
  completion: use __gitcomp_builtin in _git_apply
  completion: use __gitcomp_builtin in _git_branch
  completion: use __gitcomp_builtin in _git_checkout
  completion: use __gitcomp_builtin in _git_cherry_pick
  completion: use __gitcomp_builtin in _git_clean
  completion: use __gitcomp_builtin in _git_clone
  completion: use __gitcomp_builtin in _git_commit
  completion: use __gitcomp_builtin in _git_config
  completion: use __gitcomp_builtin in _git_describe
  completion: use __gitcomp_builtin in _git_difftool
  completion: use __gitcomp_builtin in _git_fetch
  completion: use __gitcomp_builtin in _git_fsck
  completion: use __gitcomp_builtin in _git_gc
  completion: use __gitcomp_builtin in _git_grep
  completion: use __gitcomp_builtin in _git_help
  completion: use __gitcomp_builtin in _git_init
  completion: use __gitcomp_builtin in _git_ls_files
  completion: use __gitcomp_builtin in _git_ls_remote
  completion: use __gitcomp_builtin in _git_merge
  completion: use __gitcomp_builtin in _git_merge_base
  completion: use __gitcomp_builtin in _git_mv
  completion: use __gitcomp_builtin in _git_name_rev
  completion: use __gitcomp_builtin in _git_notes
  completion: use __gitcomp_builtin in _git_pull
  completion: use __gitcomp_builtin in _git_push
  completion: use __gitcomp_builtin in _git_remote
  remote: force completing --mirror= instead of --mirror
  completion: use __gitcomp_builtin in _git_replace
  completion: use __gitcomp_builtin in _git_reset
  completion: use __gitcomp_builtin in _git_revert
  completion: use __gitcomp_builtin in _git_rm
  completion: use __gitcomp_builtin in _git_show_branch
  completion: use __gitcomp_builtin in _git_status
  completion: use __gitcomp_builtin in _git_tag
  completion: use __gitcomp_builtin in _git_worktree

 apply.c                                |   5 +-
 builtin/add.c                          |   2 +-
 builtin/am.c                           |  16 +-
 builtin/branch.c                       |   2 +-
 builtin/checkout-index.c               |   2 +-
 builtin/checkout.c                     |   7 +-
 builtin/clean.c                        |   2 +-
 builtin/fetch.c                        |   2 +-
 builtin/gc.c                           |   7 +-
 builtin/grep.c                         |  13 +-
 builtin/ls-remote.c                    |   5 +-
 builtin/mv.c                           |   3 +-
 builtin/notes.c                        |   4 +-
 builtin/pull.c                         |   2 +-
 builtin/push.c                         |   2 +-
 builtin/remote.c                       |   2 +-
 builtin/replace.c                      |   3 +-
 builtin/revert.c                       |  12 +-
 builtin/rm.c                           |   2 +-
 builtin/tag.c                          |   2 +-
 builtin/update-server-info.c           |   2 +-
 builtin/worktree.c                     |   4 +-
 contrib/completion/git-completion.bash | 276 +++++++++----------------
 parse-options.c                        |  46 +++++
 parse-options.h                        |  40 ++--
 rerere.h                               |   3 +-
 t/t9902-completion.sh                  |  12 +-
 27 files changed, 236 insertions(+), 242 deletions(-)

-- 
2.16.1.205.g271f633410


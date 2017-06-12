Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA05220C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdFLVeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:34:25 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34847 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdFLVeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:34:24 -0400
Received: by mail-pg0-f45.google.com with SMTP id k71so50384864pgd.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c1vCCfcJdSghFW9TpqYsge6WcPW8DwK2t5KtLjHe6W8=;
        b=SuxVWzefovUW/KUCN85VNMyzTFIu5n9HvG7Suj3WVvGVxowSmv6lET9n7rBN845rRB
         q3KjbSZ4GuKZjoRrbcEO4TTKaienn/rzmwJcZmmpQs6+M7O6aCzRfQfSsNIUcPMPyzZk
         5Omhfq0L7YJ3cIDRlrm5+feAUF/kdpboerAdjmSrS9bPIeUUMAoyPHrfa+9yYxVs0PVy
         bkn/qv2VcNlP8vX8LP0TbkN9DNhwNt2rPPuMUvbviGYuA/CisXxfwcNP+v9jIDpvw4tl
         DygK2rMOIcWFVnncxz4TEkrxws0lRTN09Ihad2rLt1o4pra1kWFvbwDQzNPZgnMCWzMv
         hBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1vCCfcJdSghFW9TpqYsge6WcPW8DwK2t5KtLjHe6W8=;
        b=nqZIst+yHrp7svu0SPg/5m1F9I12cX0y10PpXoSSeC85FFA/mMWB9vUVCcUM6z0MZ1
         ElZdgXR0uP9Ac8AggFgqOxV7mTJPL9O0P13QBihCKAg6hVnwUvWFGY1bArYFH5lB4g/+
         YPcukb+/TQC0YxmRGukZyUooKnhPiwuMyXDeajycV0OLbw6YOykkZVm7TKe9B7pcuyHc
         Ro/2aQUNLJtKRxWp15X6dll0rcqx7o44v7MJ5ZmM8Ew1+5L037JMYMpY/cpzxR/UIKkp
         MvYv9smOTFy/pjMbSNcWpEpJKi8D80LTqb0vx+U3ivDqJAqwjoQ5wLDMauv/GTU7fgVZ
         Xqiw==
X-Gm-Message-State: AODbwcAwB7n0sMQlofHSmX9Yd56pTGYcsTBBxXouJE3VKvNv4iKFGt9Q
        gUFyz/0tdU02WPf4QrMuqQ==
X-Received: by 10.98.21.9 with SMTP id 9mr18228185pfv.46.1497303263148;
        Mon, 12 Jun 2017 14:34:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id v21sm13333468pfk.75.2017.06.12.14.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 14:34:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/4] config.h
Date:   Mon, 12 Jun 2017 14:34:02 -0700
Message-Id: <20170612213406.83247-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After some discussion I realized that my 'repository object' series was getting
to be rather long and increase in scope.  So I've decided to break off these
couple patches into their own series so they can be reviewed more easily.  This
should also let them be merged in faster as I suspect it'll take a while for my
'repository object' series to be reviewed thourouly and these couple patches
could result in a lot of merge conflicts as it touches a lot of files.

Brandon Williams (4):
  config: create config.h
  config: remove git_config_iter
  config: don't include config.h by default
  config: don't implicitly use gitdir

 advice.c                         |   1 +
 alias.c                          |   1 +
 apply.c                          |   1 +
 archive-tar.c                    |   1 +
 archive-zip.c                    |   1 +
 archive.c                        |   1 +
 attr.c                           |   1 +
 bisect.c                         |   1 +
 branch.c                         |   1 +
 builtin/add.c                    |   1 +
 builtin/am.c                     |   1 +
 builtin/blame.c                  |   2 +
 builtin/branch.c                 |   1 +
 builtin/cat-file.c               |   1 +
 builtin/check-attr.c             |   1 +
 builtin/check-ignore.c           |   1 +
 builtin/check-mailmap.c          |   1 +
 builtin/checkout-index.c         |   1 +
 builtin/checkout.c               |   1 +
 builtin/clean.c                  |   1 +
 builtin/clone.c                  |   1 +
 builtin/column.c                 |   1 +
 builtin/commit-tree.c            |   1 +
 builtin/commit.c                 |   1 +
 builtin/config.c                 |   3 +
 builtin/count-objects.c          |   1 +
 builtin/describe.c               |   1 +
 builtin/diff-files.c             |   1 +
 builtin/diff-index.c             |   1 +
 builtin/diff-tree.c              |   1 +
 builtin/diff.c                   |   1 +
 builtin/difftool.c               |   1 +
 builtin/fast-export.c            |   1 +
 builtin/fetch.c                  |   1 +
 builtin/fmt-merge-msg.c          |   1 +
 builtin/for-each-ref.c           |   1 +
 builtin/fsck.c                   |   1 +
 builtin/gc.c                     |   1 +
 builtin/grep.c                   |   1 +
 builtin/hash-object.c            |   1 +
 builtin/help.c                   |   1 +
 builtin/index-pack.c             |   1 +
 builtin/init-db.c                |   1 +
 builtin/log.c                    |   1 +
 builtin/ls-files.c               |   1 +
 builtin/ls-tree.c                |   1 +
 builtin/merge-base.c             |   1 +
 builtin/merge-file.c             |   1 +
 builtin/merge.c                  |   1 +
 builtin/mv.c                     |   1 +
 builtin/name-rev.c               |   1 +
 builtin/notes.c                  |   1 +
 builtin/pack-objects.c           |   1 +
 builtin/patch-id.c               |   1 +
 builtin/pull.c                   |   1 +
 builtin/push.c                   |   1 +
 builtin/read-tree.c              |   1 +
 builtin/rebase--helper.c         |   1 +
 builtin/receive-pack.c           |   1 +
 builtin/reflog.c                 |   1 +
 builtin/remote.c                 |   1 +
 builtin/repack.c                 |   1 +
 builtin/replace.c                |   1 +
 builtin/rerere.c                 |   1 +
 builtin/reset.c                  |   1 +
 builtin/rev-list.c               |   1 +
 builtin/rev-parse.c              |   1 +
 builtin/revert.c                 |   1 +
 builtin/rm.c                     |   1 +
 builtin/send-pack.c              |   1 +
 builtin/shortlog.c               |   1 +
 builtin/show-branch.c            |   1 +
 builtin/stripspace.c             |   1 +
 builtin/submodule--helper.c      |   1 +
 builtin/symbolic-ref.c           |   1 +
 builtin/tag.c                    |   1 +
 builtin/unpack-file.c            |   1 +
 builtin/unpack-objects.c         |   1 +
 builtin/update-index.c           |   1 +
 builtin/update-ref.c             |   1 +
 builtin/update-server-info.c     |   1 +
 builtin/var.c                    |   1 +
 builtin/verify-commit.c          |   1 +
 builtin/verify-pack.c            |   1 +
 builtin/verify-tag.c             |   1 +
 builtin/worktree.c               |   1 +
 builtin/write-tree.c             |   1 +
 cache.h                          | 189 --------------------------------------
 color.c                          |   1 +
 column.c                         |   1 +
 config.c                         |   7 +-
 config.h                         | 193 +++++++++++++++++++++++++++++++++++++++
 connect.c                        |   1 +
 convert.c                        |   1 +
 credential-cache--daemon.c       |   1 +
 credential.c                     |   1 +
 daemon.c                         |   1 +
 diff.c                           |   1 +
 dir.c                            |   1 +
 environment.c                    |   1 +
 fast-import.c                    |   1 +
 fetch-pack.c                     |   1 +
 git.c                            |   1 +
 gpg-interface.c                  |   1 +
 graph.c                          |   1 +
 grep.c                           |   1 +
 help.c                           |   1 +
 http-backend.c                   |   1 +
 http-fetch.c                     |   1 +
 http.c                           |   1 +
 ident.c                          |   1 +
 imap-send.c                      |   1 +
 ll-merge.c                       |   1 +
 log-tree.c                       |   1 +
 mailinfo.c                       |   1 +
 merge-recursive.c                |   1 +
 notes-utils.c                    |   1 +
 notes.c                          |   1 +
 pager.c                          |   1 +
 parse-options.c                  |   1 +
 pathspec.c                       |   1 +
 pretty.c                         |   1 +
 prompt.c                         |   1 +
 read-cache.c                     |   1 +
 refs.c                           |   1 +
 refs/files-backend.c             |   1 +
 remote-curl.c                    |   1 +
 remote.c                         |   1 +
 rerere.c                         |   1 +
 send-pack.c                      |   1 +
 sequencer.c                      |   1 +
 setup.c                          |   1 +
 sha1_file.c                      |   1 +
 sha1_name.c                      |   1 +
 submodule-config.c               |   1 +
 submodule.c                      |   1 +
 t/helper/test-config.c           |   1 +
 t/helper/test-submodule-config.c |   1 +
 trailer.c                        |   1 +
 transport.c                      |   1 +
 unpack-trees.c                   |   1 +
 upload-pack.c                    |   1 +
 userdiff.c                       |   1 +
 versioncmp.c                     |   1 +
 wrapper.c                        |   1 +
 xdiff-interface.c                |   1 +
 146 files changed, 342 insertions(+), 193 deletions(-)
 create mode 100644 config.h

-- 
2.13.1.518.g3df882009-goog


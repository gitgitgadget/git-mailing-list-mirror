Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34BE20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbdFNSHp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:07:45 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36554 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdFNSHo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:44 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so3914346pff.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfGfY5cPVLbcKcedy5BKwtwL73ylRQ6WsCtx3i+fxro=;
        b=uZmwjOkxZs1+4FeYy0JbgMoM4kLBcYTfmPRKbhbQ4Re579XaPeBv8A49i4GifIJ/UR
         6RsOLU/9b8RT4hHtzUonEJ0wfW2njfSoAN9H8ZYz+t/j0ghrOPQvz697DT+KkyuvHcTa
         +LT0uwJ7/KXZv0GaPMy+HIl4FBhnE4s2Yoe2S7AnFs4hco5zb4BxPk1KwfXkXkeaws4c
         AjqJvpwmRwqD+gNtUTsst2s5btwqb+ms0OVted2vg+V/FFfvn7N9XDgUj6vPQVUPoovI
         RD0s/Wqp9clsF3W53yQaj+jP/Yu7sTt1WkVxrFSSqK6rmNDd5PtnyZP9PxlY2mxhcyRW
         e9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gfGfY5cPVLbcKcedy5BKwtwL73ylRQ6WsCtx3i+fxro=;
        b=cU61N6XGdODsXia0L7Y+67CecJySSnsg+jOdtI4AlU9l7VyyfEGnGkOjqpCs06gJsp
         ubkGrTcrb4FMzcXhtRlRFKgqW/rptvI7j7UADvakVrfs0WU3GdxOcGD/lkVVG6F5hwpF
         gcRUBl3BLLEoQ/hdWhAbk+1vdiFN2Zv2bwRsfKIDO0/7kFo6EoEZh7xclw9HJWVKcEmR
         t681EsebnxVhI2Xk2ujuTnWxWwfr/L/361LpcbAP0/6bxgB/c9Uro3bnT50kZFDMszT4
         epOrFKMeVIFcnzkGlIKaTF1y6f9DJ51wTpxcCBEWqyG7o2CcmVJv8iDIME/QbW8CEl4j
         bfSQ==
X-Gm-Message-State: AKS2vOyr1HAY2DeMINvDaUOkSyaYZiKIVLWDE1vCKDs5YvCTCelxXuzf
        YTVR2NkOqvV1noGLmYUjeQ==
X-Received: by 10.99.55.18 with SMTP id e18mr1192799pga.245.1497463663259;
        Wed, 14 Jun 2017 11:07:43 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 0/6] config.h
Date:   Wed, 14 Jun 2017 11:07:33 -0700
Message-Id: <20170614180739.72193-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170613210321.152978-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:

* tweaked the discover_git_directory function's API based on Peff's feedback
* reordered the last three patches so that they flowed a bit better
* renamed 'git_config_with_options'
* rebased ontop of v4 of Dscho's alias series
  https://public-inbox.org/git/cover.1497440104.git.johannes.schindelin@gmx.de/


Brandon Williams (6):
  config: create config.h
  config: remove git_config_iter
  config: don't include config.h by default
  setup: teach discover_git_directory to respect the commondir
  config: respect commondir
  config: don't implicitly use gitdir or commondir

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
 builtin/config.c                 |  27 +++---
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
 cache.h                          | 204 ++-------------------------------------
 color.c                          |   1 +
 column.c                         |   1 +
 compat/precompose_utf8.c         |   1 +
 config.c                         |  41 ++++----
 config.h                         | 194 +++++++++++++++++++++++++++++++++++++
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
 setup.c                          |  18 ++--
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
 147 files changed, 398 insertions(+), 229 deletions(-)
 create mode 100644 config.h

-- 
2.13.1.518.g3df882009-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62681F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHTBKl (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHTBKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:10:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so899312wrw.7
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4djlva33xSMP+Yg5EX9Ia350qz6uQf0foyO7tB/KM0=;
        b=vZPocVNkdo5LIw5mrDw0ka0QXFr5sqxkFEcIItS2xsu19MGo364tlkWiYhVnl6BXhu
         /AO+O4RjbhvBaiNllCK9eLNUkMPA1Kzq2k9jWpMPcYa8d1JutzFPP6stOLMZSn2zDbdd
         db2gmA73BerA8u4tqlyqBwXGqpiIeLHyVFdaKBEj6xt1KCdqsX3o+WxZdNPFNNT/O9+m
         aXH7BUEJfyfFFSgBm+fNpgWBPBH6ZTWb4JLfXIOjukw8MJCWS2pd40e1deEhMkeG93qF
         VGZV2dqwboBMzO+b4oHpgMqLZKPqZH4BTPJzJtX80ZqA15Lv6Oa50WQCxV8JrpAlwzl1
         ldLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4djlva33xSMP+Yg5EX9Ia350qz6uQf0foyO7tB/KM0=;
        b=VAJyVcFLvWEgrMdiOz7Cnn2QQcJHkY9X5pLIIhrgdwkX4Ow7dE5nZyx+VpN8zv1WDx
         +gvSV0n3ACvk8aBEtoxmjLuSX9pMI0do+zgIyobuzGNpCg6ALJe4Bs5JJpy74ksewnDy
         eePhRyzofqQ9VfrwC7JiSwcZHFK2K9ldLzG+mBuNKzrBg3DTFGhk9RClQ7UxxTxZJvY/
         f8SDSypbn1aQfkvB1zfN6DdKuJD7+3yLkrG4wlMKmu4iL5GAb2Z4RHzM3ivm14WPysUe
         Go/SSykuK+mWu1+zBuwX/1upJINKurC9iQKkm+uyelUjDO5bZsuyXKkmg+G2r5ce2Ubp
         MJcA==
X-Gm-Message-State: AOUpUlG7FA/EU6a1bYBpqDd51o/4XrNBlFbLsS5lE6JDakzAW7MkK7Nm
        j27n5TJxiVtCQ7PqsG5fMhQ=
X-Google-Smtp-Source: AA+uWPypBhWPu8N1nvXdNRqep6LJ1n773EM98If7O6iC+Eibx10Mr6hAmcbIVkzGIR4bR2KmM58vHA==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr28140003wrs.0.1534715860798;
        Sun, 19 Aug 2018 14:57:40 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id x82-v6sm30485975wmd.11.2018.08.19.14.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 14:57:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] tests: make more use of 'test_must_be_empty'
Date:   Sun, 19 Aug 2018 23:57:21 +0200
Message-Id: <20180819215725.29001-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.903.gab616d7dc6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a continuation of and applies on top of
'ab/test-must-be-empty-for-master', and converts even more places to
use 'test_must_be_empty'.

There are still a bunch of cases in the form of 'test -z "$(cmd...)"'
that could use 'test_must_be_empty'...  maybe someday.

SZEDER Gábor (4):
  tests: use 'test_must_be_empty' instead of '! test -s'
  tests: use 'test_must_be_empty' instead of 'test ! -s'
  tests: use 'test_must_be_empty' instead of 'test_cmp /dev/null <out>'
  tests: use 'test_must_be_empty' instead of 'test_cmp <empty> <out>'

 t/t0000-basic.sh                             |  2 +-
 t/t0001-init.sh                              |  5 +--
 t/t0003-attributes.sh                        |  3 +-
 t/t0030-stripspace.sh                        | 22 ++++------
 t/t0040-parse-options.sh                     |  4 +-
 t/t0061-run-command.sh                       |  9 ++--
 t/t0090-cache-tree.sh                        |  2 +-
 t/t0203-gettext-setlocale-sanity.sh          |  4 +-
 t/t1300-config.sh                            |  5 +--
 t/t1410-reflog.sh                            |  3 +-
 t/t1411-reflog-show.sh                       |  3 +-
 t/t1450-fsck.sh                              | 11 +++--
 t/t1501-work-tree.sh                         |  2 +-
 t/t1510-repo-setup.sh                        | 24 +++++------
 t/t1600-index.sh                             |  3 +-
 t/t1700-split-index.sh                       |  4 +-
 t/t2013-checkout-submodule.sh                |  6 +--
 t/t2200-add-update.sh                        |  3 +-
 t/t2203-add-intent.sh                        |  6 +--
 t/t2204-add-ignored.sh                       |  8 ++--
 t/t3001-ls-files-others-exclude.sh           |  6 +--
 t/t3004-ls-files-basic.sh                    |  6 +--
 t/t3035-merge-sparse.sh                      |  5 +--
 t/t3210-pack-refs.sh                         |  6 +--
 t/t3301-notes.sh                             |  4 +-
 t/t3308-notes-merge.sh                       |  2 +-
 t/t3310-notes-merge-manual-resolve.sh        |  8 ++--
 t/t3404-rebase-interactive.sh                |  5 +--
 t/t3600-rm.sh                                |  6 +--
 t/t4011-diff-symlink.sh                      |  2 +-
 t/t4015-diff-whitespace.sh                   |  4 +-
 t/t4019-diff-wserror.sh                      |  2 +-
 t/t4027-diff-submodule.sh                    | 29 ++++++-------
 t/t4041-diff-submodule-option.sh             | 18 ++++----
 t/t4047-diff-dirstat.sh                      |  4 +-
 t/t4060-diff-submodule-option-diff-format.sh | 18 ++++----
 t/t4116-apply-reverse.sh                     |  2 +-
 t/t4124-apply-ws-rule.sh                     |  2 +-
 t/t4132-apply-removal.sh                     |  5 +--
 t/t4150-am.sh                                |  4 +-
 t/t4201-shortlog.sh                          |  2 +-
 t/t4203-mailmap.sh                           |  4 +-
 t/t4211-line-log.sh                          |  2 +-
 t/t4212-log-corrupt.sh                       |  6 +--
 t/t4300-merge-tree.sh                        | 34 +++------------
 t/t5304-prune.sh                             |  3 +-
 t/t5314-pack-cycle-detection.sh              |  3 +-
 t/t5401-update-hooks.sh                      | 10 ++---
 t/t5500-fetch-pack.sh                        |  2 +-
 t/t5509-fetch-push-namespaces.sh             |  2 +-
 t/t5523-push-upstream.sh                     |  2 +-
 t/t5526-fetch-submodules.sh                  | 45 ++++++++++----------
 t/t5541-http-push-smart.sh                   |  2 +-
 t/t5570-git-daemon.sh                        |  2 +-
 t/t6112-rev-list-filters-objects.sh          |  3 +-
 t/t6120-describe.sh                          |  3 +-
 t/t6130-pathspec-noglob.sh                   |  9 ++--
 t/t6200-fmt-merge-msg.sh                     |  4 +-
 t/t7001-mv.sh                                |  6 +--
 t/t7004-tag.sh                               |  8 +---
 t/t7008-grep-binary.sh                       |  6 +--
 t/t7064-wtstatus-pv2.sh                      |  5 +--
 t/t7201-co.sh                                |  7 ++-
 t/t7400-submodule-basic.sh                   | 28 ++++--------
 t/t7401-submodule-summary.sh                 |  2 +-
 t/t7406-submodule-update.sh                  |  2 +-
 t/t7501-commit.sh                            |  6 +--
 t/t7600-merge.sh                             |  9 ++--
 t/t7610-mergetool.sh                         |  3 +-
 t/t7810-grep.sh                              | 35 ++++++---------
 t/t7811-grep-open.sh                         | 18 +++-----
 t/t8010-cat-file-filters.sh                  |  2 +-
 t/t9011-svn-da.sh                            | 14 +++---
 t/t9131-git-svn-empty-symlink.sh             |  6 +--
 t/t9135-git-svn-moved-branch-empty-file.sh   |  3 +-
 t/t9200-git-cvsexportcommit.sh               |  4 +-
 t/t9802-git-p4-filetype.sh                   |  2 +-
 t/t9903-bash-prompt.sh                       |  6 +--
 78 files changed, 232 insertions(+), 345 deletions(-)

-- 
2.18.0.903.gab616d7dc6


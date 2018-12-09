Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21AE20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLIKpE (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeLIKpE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so7080563ljc.8
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+VF/2tyzrTDNxv8QVSfk8ftvEUfKDQOagM3iScAPa0=;
        b=V97sCyFMZEFPZtOR+PkjKh43R/l2jj0q2KzaVsdNrKOZPSJdeTzveMWdt6xxNy7N53
         BrKRWkBkX3/xK1TUsYPiefAaHZ9+qnpLkYoT2GnpV5YMG0HsBhTzN81J1irmGP2AXpIC
         o1rHU99Sbv3HAI1O+OS6zcGvZHn0Nz2Z0RSSzCIQxrNQQJNPtxFAZ5ysJtvORUuaiuiM
         UMjQdK8sDe2LWpgRXE3HaW1ZhmdYImrf2GsUCBOP2T2mPKT9YXJcgVgqMmV+tajCeSoO
         dBIJwvyh75/AIhxsoV+9bKkDkSxGwAYYDxcZ2NQS1vN+Z+ebtQVdIq3UepMQckM3iA2x
         7AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+VF/2tyzrTDNxv8QVSfk8ftvEUfKDQOagM3iScAPa0=;
        b=rHydrOdaO7irYRxefMQp/lwoWxq4rFZkDmCujmXVMe/A7/x0qq1Gu6Ss7ulQ1F1RkG
         tvq8uVWQx86WTsB2mlvvvDgMWyux5BwkOcd8RVTldc6I3KIJzzQO1jhNoBEfx93MUrof
         dhknAgrjGNyb2MSbnp7krp1xWbRTLeQxuR5QbnQO0PFVLwKHztXCMrWfWInFBA1Rn4hQ
         6qR5oyUoKo9rjV6/hqxqqjrC7BgwNdE7RVIgkkkUtNdbMMkyxadKRhdx+4L0G+vAHslr
         JrsnMOQlj6NRpAj45rZSOsc7gexaKHkPVRBXUwiRtAENapbtIlV6vmtBotnB7G+k9t7g
         cPQQ==
X-Gm-Message-State: AA+aEWYHzOr7hz/S6T3JbxA1NcglDBKv8eIStXhhGFccNTqknit99XOz
        65ycl0J5bNcPBFADnZXcQzCnaEJI
X-Google-Smtp-Source: AFSGD/W2rMr2csrUACQyExe5xaSUKQvyvth+X7y5ccWZx1Bh9LtDhcxZKTWTt7WQWZtFEqFqsrjaFg==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr5491349ljl.3.1544352300422;
        Sun, 09 Dec 2018 02:45:00 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:44:59 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC PATCH 00/24] Add backup log
Date:   Sun,  9 Dec 2018 11:43:55 +0100
Message-Id: <20181209104419.12639-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Backup log" is similar to reflog. But instead of keeping track of ref
changes, it keeps track of file content changes. These could be from
the index (e.g. "git add" replacing something in the index), worktree
("git reset --hard" deleting everything) or in gitdir ("git config
--edit", or deleted reflog).

Backup log, when enabled, keeps the backup versions so you can undo if
needed. Head for 01/24 to have a better picture what it does, when
backups are made... This series adds a new plumbing command 'git
backup-log' to manage these backups.

A couple things left to do:

- high level UI design, including maybe extended SHA-1 syntax
- whether "git checkout <paths>" should keep backups. I think doing it
  unconditionally may be too much, but maybe keep backups of files
  with "precious" attribute on
- a UI to edit $GIT_DIR/info/excludes and gitattributes so we can make
  backups of them
- whether we should keep command causing the changes in the backup log
  (e.g. this change is made by git-add, that one git-rebase...).
  Reflog has this. I did not add it because it complicates the parsing
  a bit and not sure if it's worth it.

Nguyễn Thái Ngọc Duy (24):
  doc: introduce new "backup log" concept
  backup-log: add "update" subcommand
  read-cache.c: new flag for add_index_entry() to write to backup log
  add: support backup log
  update-index: support backup log with --keep-backup
  commit: support backup log
  apply: support backup log with --keep-backup
  add--interactive: support backup log
  backup-log.c: add API for walking backup log
  backup-log: add cat command
  backup-log: add diff command
  backup-log: add log command
  backup-log: add prune command
  gc: prune backup logs
  backup-log: keep all blob references around
  sha1-file.c: let index_path() accept NULL istate
  config --edit: support backup log
  refs: keep backup of deleted reflog
  unpack-trees.c: keep backup of ignored files being overwritten
  reset --hard: keep backup of overwritten files
  checkout -f: keep backup of overwritten files
  am: keep backup of overwritten files on --skip or --abort
  rebase: keep backup of overwritten files on --skip or --abort
  FIXME

 .gitignore                         |   1 +
 Documentation/config/core.txt      |   5 +
 Documentation/git-apply.txt        |   3 +
 Documentation/git-backup-log.txt   | 109 ++++++++
 Documentation/git-update-index.txt |   3 +
 Makefile                           |   2 +
 apply.c                            |  38 ++-
 apply.h                            |   1 +
 backup-log.c                       | 388 +++++++++++++++++++++++++++++
 backup-log.h                       |  38 +++
 builtin.h                          |   1 +
 builtin/add.c                      |   5 +
 builtin/am.c                       |   3 +
 builtin/backup-log.c               | 371 +++++++++++++++++++++++++++
 builtin/checkout.c                 |   4 +
 builtin/commit.c                   |  16 +-
 builtin/config.c                   |  27 +-
 builtin/gc.c                       |   3 +
 builtin/pack-objects.c             |   9 +-
 builtin/rebase.c                   |   6 +-
 builtin/repack.c                   |   1 +
 builtin/reset.c                    |   2 +
 builtin/update-index.c             |   7 +
 cache.h                            |   2 +
 command-list.txt                   |   1 +
 git-add--interactive.perl          |  14 +-
 git.c                              |   1 +
 merge-recursive.c                  |   2 +-
 merge.c                            |   2 +
 parse-options.c                    |   2 +-
 reachable.c                        |   3 +
 read-cache.c                       |  49 +++-
 refs/files-backend.c               |  32 +++
 revision.c                         |   3 +
 sha1-file.c                        |   8 +-
 t/t2080-backup-log.sh              | 228 +++++++++++++++++
 unpack-trees.c                     | 143 +++++++++--
 unpack-trees.h                     |   6 +-
 38 files changed, 1488 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/git-backup-log.txt
 create mode 100644 backup-log.c
 create mode 100644 backup-log.h
 create mode 100644 builtin/backup-log.c
 create mode 100755 t/t2080-backup-log.sh

-- 
2.20.0.rc2.486.g9832c05c3d


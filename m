From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/32] nd/multiple-work-trees
Date: Sun, 28 Sep 2014 08:22:14 +0700
Message-ID: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3CT-00023I-5J
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbaI1BWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:22:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:46432 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaI1BWt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:22:49 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so4868702pab.20
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iFG+qy/blQ9wDb7Tc00SYAd9HNC+BpHSTQx0j8lZlaM=;
        b=s0tsjeR9jVcktQ24okiMFEaVkvcGAtclttBUd5ulDlGXR5e7eIox+a2hmk6+WrS7TC
         nB/0dMfKNPMz5M+d/Q9pnyYBcJvunibYCCjrNeIYTW0kB3fKxeYVfopS1YZUNahmxx1E
         nG2w3CRsFMknC3KEHHHxxoUNEcqWkmhFA3EMI1QWZ/jA/1Dw0yhyDL6jRVsSzGeBJg0F
         ISojQVYw2aU82zDb88iNHvZoRFHo2mKkEl9gEGr1wxgQIfCRaAMbtKJ/D78sux/rXnQe
         UehQbWBKIZFf04YBjlYTfAf/J6Q3Mq6y8rEJFLzq2uRJsGoyoq0GjNhQg/uSewEHNJtx
         wggQ==
X-Received: by 10.69.19.171 with SMTP id gv11mr45775389pbd.75.1411867369110;
        Sat, 27 Sep 2014 18:22:49 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id bw1sm8541646pbd.21.2014.09.27.18.22.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:22:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:22:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257559>

On Fri, Sep 26, 2014 at 4:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It has been a while since the last review exchanges were seen. =C2=A0=
Will
> it be time for v3 soon?

Sorry I've been slow on picking up feedback from v2. v3 is rebased on
latest master. Other changes are mostly *.txt, and one broken &&
chain.

Dennis Kaarsemaker (1):
  checkout: don't require a work tree when checking out into a new one

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (31):
  path.c: make get_pathname() return strbuf instead of static buffer
  path.c: make get_pathname() call sites return const char *
  git_snpath(): retire and replace with strbuf_git_path()
  path.c: rename vsnpath() to do_git_path()
  path.c: group git_path(), git_pathdup() and strbuf_git_path() togethe=
r
  git_path(): be aware of file relocation in $GIT_DIR
  *.sh: respect $GIT_INDEX_FILE
  reflog: avoid constructing .lock path with git_path
  fast-import: use git_path() for accessing .git dir instead of get_git=
_dir()
  commit: use SEQ_DIR instead of hardcoding "sequencer"
  $GIT_COMMON_DIR: a new environment variable
  git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
  *.sh: avoid hardcoding $GIT_DIR/hooks/...
  git-stash: avoid hardcoding $GIT_DIR/logs/....
  setup.c: convert is_git_directory() to use strbuf
  setup.c: detect $GIT_COMMON_DIR in is_git_directory()
  setup.c: convert check_repository_format_gently to use strbuf
  setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
  setup.c: support multi-checkout repo setup
  wrapper.c: wrapper to open a file, fprintf then close
  use new wrapper write_file() for simple file writing
  checkout: support checking out into a new working directory
  prune: strategies for linked checkouts
  checkout: reject if the branch is already checked out elsewhere
  checkout: clean up half-prepared directories in --to mode
  gc: style change -- no SP before closing parenthesis
  gc: factor out gc.pruneexpire parsing code
  gc: support prune --worktrees
  count-objects: report unused files in $GIT_DIR/worktrees/...
  git_path(): keep "info/sparse-checkout" per work-tree
  t2025: add a test to make sure grafts is working from a linked checko=
ut

 Documentation/config.txt                   |   9 +
 Documentation/git-checkout.txt             |  69 ++++++++
 Documentation/git-prune.txt                |   3 +
 Documentation/git-rev-parse.txt            |  10 ++
 Documentation/git.txt                      |   9 +
 Documentation/gitrepository-layout.txt     |  78 +++++++--
 builtin/branch.c                           |   4 +-
 builtin/checkout.c                         | 260 +++++++++++++++++++++=
+++++++-
 builtin/clone.c                            |   9 +-
 builtin/commit.c                           |   2 +-
 builtin/count-objects.c                    |   4 +-
 builtin/fetch.c                            |   5 +-
 builtin/fsck.c                             |   4 +-
 builtin/gc.c                               |  34 ++--
 builtin/init-db.c                          |   7 +-
 builtin/prune.c                            |  95 +++++++++++
 builtin/receive-pack.c                     |   2 +-
 builtin/reflog.c                           |   2 +-
 builtin/remote.c                           |   2 +-
 builtin/repack.c                           |   8 +-
 builtin/rev-parse.c                        |  11 ++
 cache.h                                    |  17 +-
 daemon.c                                   |  11 +-
 environment.c                              |  33 +++-
 fast-import.c                              |   7 +-
 git-am.sh                                  |  22 +--
 git-pull.sh                                |   2 +-
 git-rebase--interactive.sh                 |   6 +-
 git-rebase--merge.sh                       |   6 +-
 git-rebase.sh                              |   4 +-
 git-sh-setup.sh                            |   2 +-
 git-stash.sh                               |   6 +-
 git.c                                      |   2 +-
 notes-merge.c                              |   6 +-
 path.c                                     | 234 +++++++++++++++++----=
-----
 refs.c                                     |  86 ++++++----
 refs.h                                     |   2 +-
 run-command.c                              |   4 +-
 run-command.h                              |   2 +-
 setup.c                                    | 124 +++++++++++---
 sha1_file.c                                |   2 +-
 submodule.c                                |   9 +-
 t/t0060-path-utils.sh                      |  36 ++++
 t/t1501-worktree.sh                        |  76 +++++++++
 t/t1510-repo-setup.sh                      |   1 +
 t/t2025-checkout-to.sh (new +x)            | 117 +++++++++++++
 t/t2026-prune-linked-checkouts.sh (new +x) |  84 ++++++++++
 templates/hooks--applypatch-msg.sample     |   4 +-
 templates/hooks--pre-applypatch.sample     |   4 +-
 trace.c                                    |   1 +
 transport.c                                |   8 +-
 wrapper.c                                  |  31 ++++
 52 files changed, 1306 insertions(+), 270 deletions(-)
 create mode 100755 t/t2025-checkout-to.sh
 create mode 100755 t/t2026-prune-linked-checkouts.sh

--=20
2.1.0.rc0.78.gc0d8480

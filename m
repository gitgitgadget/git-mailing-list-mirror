From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v6 00/32] Support multiple checkouts
Date: Fri, 11 Jul 2014 09:13:30 +0200
Message-ID: <1405062810.23880.6.camel@spirit>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5V1e-0008IF-T5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 09:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbaGKHNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2014 03:13:41 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41663 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaGKHNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 03:13:39 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so592090wgh.26
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 00:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=54uWL79VBZkXPKSll8JNdG3vmgFxz2LzKUU0YI4o82I=;
        b=OBsJLsmixTPPy6CqIJEaGR2l6VN0ND+iDo7ESTjxME3SDj8CeCsUUF6/zUlZPpyECS
         lK4sLu+YkV9mOHRgooBiIkeOT9agkgjMjSf6jY4us96cqqVXNF+LAWP3XypEf4NX8E0d
         Z2p80JjI1RF22F3eaJ15hgSpU1eHVif/s+KlxKdJ5tI2oT1G53xTAwhHJvyLUFpfPmZD
         FmthRnaoHRmIcYeYQJYd0k9Gk8UOH/2DuOC3gJiDlPnV+B9Zus/cG+F6Ay21qQU56aTy
         Alvt8G/NjPLlOvU6rH2l/E/ClIfR4m8cvFYz0JdMS4Bv1LcBaW+lZBAximWg8jYcbVYa
         1rcQ==
X-Gm-Message-State: ALoCoQmfHDu+OqE0e7Hnkxo91dNpL8PEE3Fb1e0TdyOfZe58nH0107rCDUgb1bMuexfgYFvSaTbV
X-Received: by 10.180.91.16 with SMTP id ca16mr2764201wib.32.1405062814309;
        Fri, 11 Jul 2014 00:13:34 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id i12sm3278410wjr.32.2014.07.11.00.13.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 00:13:33 -0700 (PDT)
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253253>

Tested-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>

I've been using this branch for a little while now and have no breakage=
s
to report. Max Kirillov reported some bugs in the interaction with
submodules which I plan to chase when I have some time unless someone
beats me to it :)

On wo, 2014-07-09 at 14:32 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy wrote:
> This is basically a reroll from what was parked on 'pu' with two
> new patches at the end: one to not share info/sparse-checkout
> across worktrees, and one to allow 'checkout --to` from a bare
> repository.
>=20
> I cherry-picked two patches from jk/xstrfmt (on next) because they
> result in non-trivial conflicts. When this series is merged with
> jk/xstrfmt, you still get conflicts in environment.c, but you can jus=
t
> pick up my changes and drop Jeff's.
>=20
> Dennis Kaarsemaker (1):
>   checkout: don't require a work tree when checking out into a new on=
e
>=20
> Jeff King (2):
>   setup_git_env: use git_pathdup instead of xmalloc + sprintf
>   setup_git_env(): introduce git_path_from_env() helper
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (29):
>   path.c: make get_pathname() return strbuf instead of static buffer
>   path.c: make get_pathname() call sites return const char *
>   git_snpath(): retire and replace with strbuf_git_path()
>   path.c: rename vsnpath() to do_git_path()
>   path.c: group git_path(), git_pathdup() and strbuf_git_path() toget=
her
>   git_path(): be aware of file relocation in $GIT_DIR
>   *.sh: respect $GIT_INDEX_FILE
>   reflog: avoid constructing .lock path with git_path
>   fast-import: use git_path() for accessing .git dir instead of get_g=
it_dir()
>   commit: use SEQ_DIR instead of hardcoding "sequencer"
>   $GIT_COMMON_DIR: a new environment variable
>   git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
>   *.sh: avoid hardcoding $GIT_DIR/hooks/...
>   git-stash: avoid hardcoding $GIT_DIR/logs/....
>   setup.c: convert is_git_directory() to use strbuf
>   setup.c: detect $GIT_COMMON_DIR in is_git_directory()
>   setup.c: convert check_repository_format_gently to use strbuf
>   setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
>   setup.c: support multi-checkout repo setup
>   wrapper.c: wrapper to open a file, fprintf then close
>   use new wrapper write_file() for simple file writing
>   checkout: support checking out into a new working directory
>   checkout: clean up half-prepared directories in --to mode
>   checkout: detach if the branch is already checked out elsewhere
>   prune: strategies for linked checkouts
>   gc: style change -- no SP before closing bracket
>   gc: support prune --repos
>   count-objects: report unused files in $GIT_DIR/repos/...
>   git_path(): keep "info/sparse-checkout" per work-tree
>=20
>  Documentation/config.txt               |   9 ++
>  Documentation/git-checkout.txt         |  34 +++++
>  Documentation/git-prune.txt            |   3 +
>  Documentation/git-rev-parse.txt        |  10 ++
>  Documentation/git.txt                  |   9 ++
>  Documentation/gitrepository-layout.txt |  75 ++++++++--
>  builtin/branch.c                       |   4 +-
>  builtin/checkout.c                     | 248 +++++++++++++++++++++++=
+++++++++-
>  builtin/clone.c                        |   9 +-
>  builtin/commit.c                       |   2 +-
>  builtin/count-objects.c                |   4 +-
>  builtin/fetch.c                        |   5 +-
>  builtin/fsck.c                         |   4 +-
>  builtin/gc.c                           |  21 ++-
>  builtin/init-db.c                      |   7 +-
>  builtin/prune.c                        |  74 ++++++++++
>  builtin/receive-pack.c                 |   2 +-
>  builtin/reflog.c                       |   2 +-
>  builtin/remote.c                       |   2 +-
>  builtin/repack.c                       |   8 +-
>  builtin/rev-parse.c                    |  11 ++
>  cache.h                                |  17 ++-
>  daemon.c                               |  11 +-
>  environment.c                          |  45 ++++--
>  fast-import.c                          |   7 +-
>  git-am.sh                              |  22 +--
>  git-pull.sh                            |   2 +-
>  git-rebase--interactive.sh             |   6 +-
>  git-rebase--merge.sh                   |   6 +-
>  git-rebase.sh                          |   4 +-
>  git-sh-setup.sh                        |   2 +-
>  git-stash.sh                           |   6 +-
>  git.c                                  |   2 +-
>  notes-merge.c                          |   6 +-
>  path.c                                 | 234 +++++++++++++++++++++--=
--------
>  refs.c                                 |  86 +++++++-----
>  refs.h                                 |   2 +-
>  run-command.c                          |   4 +-
>  run-command.h                          |   2 +-
>  setup.c                                | 124 +++++++++++++----
>  sha1_file.c                            |   2 +-
>  submodule.c                            |   9 +-
>  t/t0060-path-utils.sh                  |  35 +++++
>  t/t1501-worktree.sh                    |  76 ++++++++++
>  t/t1510-repo-setup.sh                  |   1 +
>  t/t2025-checkout-to.sh (new +x)        |  72 ++++++++++
>  templates/hooks--applypatch-msg.sample |   4 +-
>  templates/hooks--pre-applypatch.sample |   4 +-
>  trace.c                                |   1 +
>  transport.c                            |   8 +-
>  wrapper.c                              |  31 +++++
>  51 files changed, 1109 insertions(+), 265 deletions(-)
>  create mode 100755 t/t2025-checkout-to.sh
>=20


--=20
Dennis Kaarsemaker
www.kaarsemaker.net

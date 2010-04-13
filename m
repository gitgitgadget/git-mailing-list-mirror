From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 00/46] nd/setup remainder for convenient reference
Date: Mon, 12 Apr 2010 22:08:53 -0500
Message-ID: <20100413030853.GJ4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 05:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1WUz-0004BS-HW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 05:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab0DMDIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 23:08:55 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:45765 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab0DMDIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 23:08:54 -0400
Received: by gxk9 with SMTP id 9so3835101gxk.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 20:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vBW5u8HzIpbbuR6mG0YRVP6FTrcT5cVpe02t8bLK7oQ=;
        b=JpS5vX3Og/INBl4Vaxu0xd+YC7JTnFzBFqbFtr239CeyGiNjSbUTrVUaTlT5YU0DF8
         lQ++A3eqzspjSzA7kBXGhqmNjuke0xNoVWCs7RS8+GIhgxcanbGLnSZKqvjH0lsR/Axb
         aa0b08E97MRryKYMnv9IQLUQBT44tBVq91scg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fJVxWt0DfnglayOMXbvW0hpwyGPLt7XpI9bsbpmr4loP2MSB9O5QPDXDZQCjPmKT5p
         kFIicNSjoYB2n7BdbonArfxcKM620UDeurJxpjTi9dePQhiigCA+rfqzwhdrl7zJDHPk
         HIoMx0l6fW+We7rdYPYXy7tdyO/4fS94FBV9w=
Received: by 10.150.119.26 with SMTP id r26mr4797825ybc.60.1271128133884;
        Mon, 12 Apr 2010 20:08:53 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 23sm309931iwn.2.2010.04.12.20.08.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 20:08:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144789>

I was thinking of sending the remainder of nd/setup after this to save
others the trouble of rebasing, but I fear the traffic would be too
disruptive.  So I am putting it up by git.

Caveats: maybe these patches make no sense.  After I last rebased
them, I walked away without looking.  Still, maybe they can save
you some time.

Good night,
Jonathan

The following changes since commit e0cc2322c409c6cfa897f395f6feb058e2d5=
3d4a:
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
        config: run setup before commiting pager choice

are available in the git repository at:

  git://repo.or.cz/git/jrn.git/ nd/setup

Jonathan Nieder (5):
      t0001: test git init when run via an alias
      t5512: test that ls-remote does not require a git repository
      t7002: test git grep --no-index from a bare repository
      t7006: expose test_terminal() for use by other tests
      help: note why it is appropriate for this command not to use RUN_=
SETUP_GENTLY

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (41):
      t1300: test that scripted commands do not respect stray .git/conf=
ig
      setup: save prefix (original cwd relative to toplevel) in startup=
_info
      builtin: remove prefix variable from run_builtin()
      run_builtin(): save "-h" detection result for later use
      builtin: remember whether repository has been searched for
      builtin: USE_PAGER should not be used without RUN_SETUP*
      hash-object: use RUN_SETUP_GENTLY
      shortlog: use RUN_SETUP_GENTLY
      grep: use RUN_SETUP_GENTLY
      archive: use RUN_SETUP_GENTLY
      mailinfo: use RUN_SETUP_GENTLY
      check-ref-format: use RUN_SETUP_GENTLY
      verify-pack: use RUN_SETUP_GENTLY
      apply: use RUN_SETUP_GENTLY
      bundle: use RUN_SETUP_GENTLY
      diff: use RUN_SETUP_GENTLY
      ls-remote: use RUN_SETUP_GENTLY
      var: use RUN_SETUP_GENTLY
      merge-file: use RUN_SETUP_GENTLY
      worktree setup: calculate prefix even if no worktree is found
      index-pack: trust the prefix returned by setup_git_directory_gent=
ly()
      index-pack: use RUN_SETUP_GENTLY
      Move enter_repo() to setup.c
      enter_repo(): initialize other variables as setup_git_directory_g=
ently() does
      rev-parse --git-dir: print relative gitdir correctly
      worktree setup: call set_git_dir explicitly
      Add git_config_early()
      Use git_config_early() instead of git_config() during repo setup
      worktree setup: restore original state when things go wrong
      init/clone: turn on startup->have_repository properly
      git_config(): do not read .git/config if there is no repository
      Do not read .git/info/exclude if there is no repository
      Do not read .git/info/attributes if there is no repository
      apply: do not check sha1 if there is no repository
      config: do not read .git/config if there is no repository
      builtins: utilize startup_info->help where possible
      builtins: check for startup_info->help, print and exit early
      Allow to undo setup_git_directory_gently() gracefully (and fix al=
ias code)
      alias: keep repository found while collecting aliases as long as =
possible
      Guard unallowed access to repository when it's not set up
      builtins: setup repository before print unknown command error

 attr.c                                    |    5 +-
 builtin/apply.c                           |    9 +-
 builtin/archive.c                         |    2 +-
 builtin/branch.c                          |    3 +
 builtin/bundle.c                          |    6 +-
 builtin/check-ref-format.c                |    2 +-
 builtin/checkout-index.c                  |    3 +
 builtin/clone.c                           |    3 +-
 builtin/commit.c                          |    6 +
 builtin/config.c                          |    9 +-
 builtin/diff.c                            |    6 +-
 builtin/gc.c                              |    3 +
 builtin/grep.c                            |   11 +-
 builtin/hash-object.c                     |    9 +-
 builtin/help.c                            |    5 +
 builtin/index-pack.c                      |   21 +--
 builtin/init-db.c                         |   10 +-
 builtin/log.c                             |    6 +-
 builtin/ls-files.c                        |    3 +
 builtin/ls-remote.c                       |    3 -
 builtin/mailinfo.c                        |    3 -
 builtin/merge-file.c                      |    4 +-
 builtin/merge-ours.c                      |    2 +-
 builtin/merge.c                           |    3 +
 builtin/pack-redundant.c                  |    2 +-
 builtin/rev-parse.c                       |    8 +
 builtin/shortlog.c                        |    4 +-
 builtin/show-ref.c                        |    2 +-
 builtin/update-index.c                    |    3 +
 builtin/upload-archive.c                  |    7 +-
 builtin/var.c                             |    2 -
 cache.h                                   |    8 +-
 config.c                                  |   22 +++-
 dir.c                                     |    8 +-
 environment.c                             |   31 ++++-
 git.c                                     |   84 +++++++-----
 help.c                                    |    4 +
 path.c                                    |   91 ------------
 setup.c                                   |  213 +++++++++++++++++++++=
+++++---
 t/lib-pager.sh                            |   37 +++++
 t/{t7006 =3D> lib-pager}/test-terminal.perl |    0
 t/t0001-init.sh                           |   56 ++++++++
 t/t1300-repo-config.sh                    |   15 ++
 t/t1302-repo-version.sh                   |    2 +-
 t/t1500-rev-parse.sh                      |    2 +-
 t/t1501-worktree.sh                       |    5 +
 t/t5512-ls-remote.sh                      |   14 ++
 t/t7002-grep.sh                           |  116 ++++++++++++++++
 t/t7006-pager.sh                          |   29 +----
 t/t7020-help.sh                           |   18 +++
 50 files changed, 660 insertions(+), 260 deletions(-)
 create mode 100644 t/lib-pager.sh
 rename t/{t7006 =3D> lib-pager}/test-terminal.perl (100%)
 create mode 100755 t/t7020-help.sh

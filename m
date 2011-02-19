From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/72] No-op C gettext wrappers
Date: Sat, 19 Feb 2011 19:23:43 +0000
Message-ID: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsQh-0001es-AY
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab1BSTZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41634 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:12 -0500
Received: by eye27 with SMTP id 27so2346667eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=MlgrwfowE6vwMt0vIdl2Iz6VE58uFALPffk+8RwT+Pw=;
        b=ZyylZRdH13hv6HHgTCyH0SLoEoIPSgBWVN3+zVEsnfjNf+JGbNQdlXLJeSZpZpw9uV
         3x2HTU8k8g4nyVZ7VJmb1z9sdb9jNj0GCd/vF4ZSoDUYXg9a142t3e4k/iI4/F+GuSgK
         1PXcT2ewQD2d8U0aGQhJqj0TXIp45Q9Wdb74M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=O5zgoyJfBSK/OaeLwzwlVXGPg3e24hn29RguaqrImbqfio3uaH9102PY743idA9O2a
         VfBkz9z17UJbAC1rsR73glg4KGfowHQI47JfZ+HtG3lXCm6igmAtsh1Qfen3gfaWStpl
         iS1gdw5aJFRTUFsaoO453qgNJSSAny6SilHF0=
Received: by 10.213.109.20 with SMTP id h20mr2519505ebp.97.1298143510493;
        Sat, 19 Feb 2011 11:25:10 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.09
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:10 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167307>

As discussed on-list previously I'm remaking the gettext series in a
form that'll be easier to swallow. This series is what's at the start
of my own ab/i18n branch hosted at git://github.com/avar/git.git.

It only does these:

 * A skeleton no-op gettext.h wrapper that does nothing
 * Marking up of the relevant source messages so they can be translated
 * Marking up and changing tests that would break under
   GETTEXT_POISON=3DYesPlease

After this is in I'll submit similar no-op wrappers and gettextization
of the *.sh and *.perl files I have gettextized in ab/i18n, after that
I'll be trying to get the remaining bits of ab/i18n in, which'll be:

 * The actual C, Shell and Perl gettext implementation + tests
 * Documentation on how to translate things
 * po/*.po files containing translations

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (72):
  gettext.h: add no-op _() and N_() wrappers
  cache.h: include gettext.h
  t/test-lib.sh: add always-set NO_GETTEXT_POISON prerequisite
  gettextize: git-init basic messages
  gettextize: git-init "Initialized [...] repository" message
  gettextize: git-clone basic messages
  gettextize: git-clone "Cloning into" message
  gettextize: git-add basic messages
  gettextize: git-add "no files added" message
  gettextize: git-add "Use -f if you really want" message
  gettextize: git-add "pathspec [...] did not match" message
  gettextize: git-add "remove '%s'" message
  gettextize: git-add refresh_index message
  gettextize: git-branch basic messages
  gettextize: git-branch "remote branch '%s' not found" message
  gettextize: git-branch "Deleted branch [...]" message
  gettextize: git-branch "git branch -v" messages
  gettextize: git-branch "(no branch)" message
  gettextize: git-checkout basic messages
  gettextize: git-checkout: our/their version message
  gettextize: git-checkout describe_detached_head messages
  gettextize: git-checkout "HEAD is now at" message
  gettextize: git-checkout "Switched to a .. branch" message
  gettextize: git-commit basic messages
  gettextize: git-commit "middle of a merge" message
  gettextize: git-commit formatting messages
  gettextize: git-commit print_summary messages
  gettextize: git-commit "enter the commit message" message
  gettextize: git-commit advice messages
  gettextize: git-diff basic messages
  gettextize: git-fetch basic messages
  gettextize: git-fetch formatting messages
  gettextize: git-fetch update_local_ref messages
  gettextize: git-fetch split up "(non-fast-forward)" message
  gettextize: git-grep basic messages
  gettextize: git-grep "--open-files-in-pager" message
  gettextize: git-log basic messages
  gettextize: git-log "--OPT does not make sense" messages
  gettextize: git-merge basic messages
  gettextize: git-merge "Updating %s..%s" message
  gettextize: git-merge "You have not concluded your merge" messages
  gettextize: git-merge "Wonderful" message
  gettextize: git-mv basic messages
  gettextize: git-mv "bad" messages
  gettextize: git-rm basic messages
  gettextize: git-reset basic messages
  gettextize: git-reset reset_type_names messages
  gettextize: git-reset "Unstaged changes after reset" message
  gettextize: git-tag basic messages
  gettextize: git-tag tag_template message
  gettextize: git-push basic messages
  gettextize: git-push "prevent you from losing" message
  gettextize: git-status basic messages
  gettextize: git-status "nothing to commit" messages
  gettextize: git-status shortstatus messages
  gettextize: git-status "Changes to be committed" message
  gettextize: git-status "Initial commit" message
  gettextize: git-status "renamed: " message
  gettextize: git-archive basic messages
  gettextize: git-bundle basic messages
  gettextize: git-clean basic messages
  gettextize: git-clean clean.requireForce messages
  gettextize: git-describe basic messages
  gettextize: git-gc basic messages
  gettextize: git-gc "Auto packing the repository" message
  gettextize: git-notes basic commands
  gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
  gettextize: git-revert basic messages
  gettextize: git-revert "Your local changes" message
  gettextize: git-revert literal "me" messages
  gettextize: git-revert split up "could not revert/apply" message
  gettextize: git-shortlog basic messages

 builtin/add.c                    |   46 ++++++------
 builtin/archive.c                |   14 ++--
 builtin/branch.c                 |   69 ++++++++--------
 builtin/bundle.c                 |    6 +-
 builtin/checkout.c               |   93 +++++++++++-----------
 builtin/clean.c                  |   33 +++++---
 builtin/clone.c                  |   63 ++++++++-------
 builtin/commit.c                 |  162 +++++++++++++++++++-----------=
--------
 builtin/describe.c               |   36 ++++----
 builtin/diff.c                   |   18 ++--
 builtin/fetch.c                  |   82 ++++++++++----------
 builtin/gc.c                     |   24 +++---
 builtin/grep.c                   |   34 ++++----
 builtin/init-db.c                |   58 +++++++------
 builtin/log.c                    |   68 ++++++++--------
 builtin/merge.c                  |  128 +++++++++++++++---------------
 builtin/mv.c                     |   32 ++++----
 builtin/notes.c                  |  112 +++++++++++++-------------
 builtin/push.c                   |   42 +++++-----
 builtin/reset.c                  |   42 +++++-----
 builtin/revert.c                 |   76 ++++++++++--------
 builtin/rm.c                     |   22 +++---
 builtin/shortlog.c               |    8 +-
 builtin/tag.c                    |   66 ++++++++--------
 cache.h                          |    1 +
 gettext.h                        |    9 ++
 t/lib-httpd.sh                   |    2 +-
 t/t0001-init.sh                  |    2 +-
 t/t1200-tutorial.sh              |    5 +-
 t/t2200-add-update.sh            |    2 +-
 t/t2204-add-ignored.sh           |   37 ++++++---
 t/t3030-merge-recursive.sh       |    2 +-
 t/t3200-branch.sh                |    2 +-
 t/t3203-branch-output.sh         |    2 +-
 t/t3501-revert-cherry-pick.sh    |    2 +-
 t/t3507-cherry-pick-conflict.sh  |    2 +-
 t/t3700-add.sh                   |   11 ++-
 t/t4001-diff-rename.sh           |    4 +-
 t/t4014-format-patch.sh          |    2 +-
 t/t5526-fetch-submodules.sh      |   40 ++++++++--
 t/t5541-http-push.sh             |    7 +-
 t/t5601-clone.sh                 |    2 +-
 t/t6040-tracking-info.sh         |    2 +-
 t/t6120-describe.sh              |    2 +-
 t/t7004-tag.sh                   |    1 +
 t/t7012-skip-worktree-writing.sh |    4 +-
 t/t7060-wtstatus.sh              |    2 +-
 t/t7102-reset.sh                 |    2 +-
 t/t7110-reset-merge.sh           |    6 +-
 t/t7201-co.sh                    |   10 +-
 t/t7300-clean.sh                 |    6 +-
 t/t7500-commit.sh                |    8 +-
 t/t7501-commit.sh                |    7 +-
 t/t7502-commit.sh                |   60 +++++++++------
 t/t7506-status-submodule.sh      |   28 +++---
 t/t7508-status.sh                |  115 +++++++++++++++------------
 t/t7600-merge.sh                 |    2 +-
 t/t7607-merge-overwrite.sh       |   10 ++-
 t/t7611-merge-abort.sh           |   20 ++++-
 t/t7811-grep-open.sh             |    2 +-
 t/test-lib.sh                    |    5 +
 wt-status.c                      |  116 ++++++++++++++--------------
 62 files changed, 1011 insertions(+), 865 deletions(-)
 create mode 100644 gettext.h

--=20
1.7.2.3

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Mon, 20 Sep 2010 20:37:09 +0000
Message-ID: <1285015029-23103-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Marcin Cieslak <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 22:38:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxn7n-0001yq-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab0ITUh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 16:37:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42958 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab0ITUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:37:56 -0400
Received: by wyf22 with SMTP id 22so4736460wyf.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=loi4AapWmXZbOZj9TS3Fmpevbv1ANbjh2Aa4jTyKXU8=;
        b=OVELn1zEzzwwMs5JfkOj1S7vtOJw7m/9CHc+GipMmkhJOLJ8ga09TiToCjr7W+BB26
         THNAmkfIAKOnbP8Ip3jj+XoQ5XE0cfQkSAHIL5ThQTFOszjxI3835nh2HC6p2sdOflwo
         tNudVGIwABWoJKyDY865IZZF8NegWHP0wOBh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=mDiut711qT2MCgmvrVcSYM1974Y+gi08tbRrrAU8V3s3DcRAZgXJDzIESa/mbBGBu4
         Bxso+6ukFulWmsesOxqHSFwGyO35rdqPw0CLnVSou66TYA5wKpac+m+bxasE5BZnXBlf
         1xpC3lPjjlwYzHCAugNLItYXzNIY0a7Ewa9ug=
Received: by 10.216.6.149 with SMTP id 21mr4781176wen.101.1285015074345;
        Mon, 20 Sep 2010 13:37:54 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm5454634weq.38.2010.09.20.13.37.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 13:37:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.272.g31195
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156661>

Please pull an updated ab/i18n. The version you have now should be
ejected in favor of it:

   git://github.com/avar/git.git ab/i18n
   http://github.com/avar/git/compare/87b5054...ab/i18n
   http://github.com/avar/git/compare/87b5054...ab/i18n.patch

Changes since last time, I can also send these to list on request. But
I don't think anyone wants a 160 patch flood:

    http://github.com/avar/git/compare/ab/i18n-in-pu...ab/i18n
    http://github.com/avar/git/compare/ab/i18n-in-pu...ab/i18n.patch

The Gist of it is:

  * I rewrote the huge monolithic commit that added NO_GETTEXT_POISON
    prereqs to tests out of the series and added these changes to
    individual tests instead. This was the practice I was using for
    patches later in the series, but I hadn't updated the earlier
    ones.

    In the process of doing that I found some tests that were
    mistakenly marked under NO_GETTEXT_POISON, mainly because the
    tests failed due to earlier tests that rightly had
    NO_GETTEXT_POISON. I did some re-arranging of test code to avoid
    this.

  * The PO files use line numbers again, and now have copyright
    notices at the top.

    It turns out that using msgmerge(1) is a major PITA without these
    line numbers, msgmerge will compeletely screw up merges that
    otherwise would have succeeded. E.g. it'll merge two similar but
    unrelated messages together and mark them as fuzzy, but if it has
    file/line number data it doesn't do this.

    Our PO usage is now completely standard, i.e. we're not removing
    anything that the normal GNU gettext tools add. I updated
    po/README to reflect this.

  * I did a msgmerge(1) on the existing PO files. This has left a lot
    of messages marked as fuzzy. TRANSLATORS: Please check if this has
    screwed up your translations.

=46urther notes below. But here's a diffstat between this series and th=
e
one that was merged into pu:
   =20
     command-list.txt          |    1 +
     po/README                 |   43 +-
     po/de.po                  | 1220 +++++++++++++++-
     po/en_GB.po               | 2778 +++++++++++++++++++++++++++++++++=
++-
     po/hi.po                  | 2777 +++++++++++++++++++++++++++++++++=
++-
     po/is.po                  |   64 +-
     po/pl.po                  | 2788 +++++++++++++++++++++++++++++++++=
++-
     po/sv.po                  | 3492 +++++++++++++++++++++++++++++++++=
++++++++++++
     t/t0201-gettext-poison.sh |   36 -
     t/t0205-gettext-poison.sh |   36 +
     t/t1200-tutorial.sh       |    3 +-
     t/t2204-add-ignored.sh    |   45 +-
     t/t3700-add.sh            |   15 +-
     t/t5541-http-push.sh      |    2 +-
     t/t7004-tag.sh            |   27 +-
     t/t7500-commit.sh         |    3 -
     t/t7501-commit.sh         |    7 +-
     t/t7502-commit.sh         |   60 +-
     t/t7508-status.sh         |   63 +-
     wt-status.c               |    2 +-
     20 files changed, 13143 insertions(+), 319 deletions(-)
   =20

Jan Kr=C3=BCger (1):
  po/de.po: add German translation

Marcin Cie=C5=9Blak (1):
  po/pl.po: add Polish translation

Peter Krefting (1):
  po/sv.po: add Swedish translation

Ramkumar Ramachandra (1):
  po/hi.po: add Hindi Translation

Sam Reed (1):
  po/en_GB.po: add British English translation

Thomas Rast (1):
  gettext tests: locate i18n lib&data correctly under --valgrind

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (154):
  t7004-tag.sh: re-arrange git tag comment for clarity

This is new, and can be cherry-picked out of this series (like
everything before "gettext: add infrastructure for translating Git
with gettext").

  tests: use test_cmp instead of piping to diff(1)
  builtin: use builtin.h for all builtin commands
  gettext: add infrastructure for translating Git with gettext

I squashed the "gettext tests: update test/is.po to match
t/t0200/test.c" commit into this one. It's easier to manage the series
that way.

  gettext tests: rename test to work around GNU gettext bug
  gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
  Makefile: A variable for options used by xgettext(1) calls
  Makefile: provide a --msgid-bugs-address to xgettext(1)
  Makefile: tell xgettext(1) that our source is in UTF-8
  Makefile: use variables and shorter lines for xgettext
  builtin.h: Include gettext.h
  gettext.c: work around us not using setlocale(LC_CTYPE, "")
  gettext tests: add GETTEXT_POISON=3DYesPlease Makefile parameter
  gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON

Moved earlier because git-init now uses a NO_GETTEXT_POISON prereq.

  gettextize: git-init basic messages
  gettextize: git-init "Initialized [...] repository" message
  gettext tests: test if $VERSION exists before using it
  gettext tests: add detection for is_IS.ISO-8859-1 locale
  gettext tests: test message re-encoding under Shell
  gettext tests: test re-encoding with a UTF-8 msgid under Shell
  gettext tests: mark a test message as not needing translation
  po/is.po: add Icelandic translation

This is here early because the next commit tests git-init messages in
Icelandic.

  gettext tests: test message re-encoding under C
  gettext tests: remove old sanity test under NO_GETTEXT
  gettextize: git-clone basic messages
  gettextize: git-clone "Cloning into" message
  gettextize: git-add basic messages
  gettextize: git-add "Use -f if you really want" message
  gettextize: git-add "pathspec [...] did not match" message
  gettextize: git-add "remove '%s'" message
  gettextize: git-add refresh_index message
  gettextize: git-branch basic messages

  gettextize: git-branch "remote branch '%s' not found" message
  gettextize: git-branch "Deleted branch [...]" message
  gettextize: git-branch "git branch -v" messages
  gettextize: git-branch "(no branch)" message

Examples of some of the new commits that come out of destroying the
big NO_GETTEXT_POISON commit.

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
  gettextize: git-log "--check does not make sense" message
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
  gettextize: git-status shortstatus messages
  gettextize: git-status "Changes to be committed" message
  gettextize: git-status "nothing to commit" messages
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
  gettextize: git-notes "Refusing to %s notes in %s" message
  gettextize: git-revert basic messages
  gettextize: git-revert "Your local changes" message
  gettextize: git-revert literal "me" messages
  gettextize: git-revert split up "could not revert/apply" message
  gettextize: git-shortlog basic messages
  Makefile: add GNU_GETTEXT, set when we expect GNU gettext
  Makefile: MSGFMT=3D"msgfmt --check" under GNU_GETTEXT
  gettext tests: add GETTEXT_POISON support for shell scripts
  gettext tests: add GETTEXT_POISON tests for shell scripts
  gettextize: git-am add git-sh-i18n
  gettextize: git-am one-line gettext $msg; echo
  gettextize: git-am multi-line getttext $msg; echo
  gettextize: git-am eval_gettext messages
  gettextize: git-am die messages
  gettextize: git-am cannot_fallback messages
  gettextize: git-am clean_abort messages
  gettextize: git-am "Apply?" message
  gettextize: git-am core say messages
  gettextize: git-am printf(1) message to eval_gettext
  gettext docs: add po/README file documenting Git's gettext
  Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=3DYesPleas=
e
  gettext docs: add a "Testing your changes" section to po/README
  gettext docs: add "Marking strings for translation" section in
    po/README
  gettext docs: the gettext.h C interface
  gettext docs: the git-sh-i18n.sh Shell interface
  gettext docs: the Git::I18N Perl interface
  gettext docs: add "Testing marked strings" section to po/README
  gettextize: git-pull add git-sh-i18n
  gettextize: git-pull die messages
  gettextize: git-pull eval_gettext + die message
  gettextize: git-pull eval_gettext + warning message
  gettextize: git-pull split up "no candidate" message
  gettextize: git-pull "You asked to pull" message
  gettextize: git-pull "[...] not currently on a branch" message
  gettextize: git-pull "rebase against" / "merge with" messages
  gettextize: git-submodule add git-sh-i18n
  gettextize: git-submodule echo + eval_gettext messages
  gettextize: git-submodule say + eval_gettext messages
  gettextize: git-submodule die + eval_gettext messages
  gettextize: git-submodule $update_module say + die messages
  gettextize: git-submodule "cached cannot be used" message
  gettextize: git-submodule "Submodule change[...]" messages
  gettextize: git-submodule $errmsg messages
  gettextize: git-submodule "Entering [...]" message
  gettextize: git-submodule "[...] path is ignored" message
  gettextize: git-submodule "path not initialized" message
  gettextize: git-submodule "blob" and "submodule" messages
  gettextize: git-stash add git-sh-i18n
  gettextize: git-stash echo + gettext message
  gettextize: git-stash say + gettext messages
  gettextize: git-stash die + gettext messages
  gettextize: git-stash die + eval_gettext messages
  gettextize: git-stash die + eval_gettext $* messages
  gettextize: git-stash die + eval_gettext $1 messages
  gettextize: git-stash "unknown option" message
  gettextize: git-stash drop_stash say/die messages
  gettextize: git-bisect add git-sh-i18n
  gettextize: git-bisect gettext + echo message
  gettextize: git-bisect echo + gettext messages
  gettextize: git-bisect echo + eval_gettext message
  gettextize: git-bisect die + gettext messages
  gettextize: git-bisect die + eval_gettext messages
  gettextize: git-bisect bisect_run + $@ messages
  gettextize: git-bisect bisect_reset + $1 messages
  gettextize: git-bisect bisect_replay + $1 messages
  gettextize: git-bisect [Y/n] messages
  gettextize: git-bisect bisect_next_check "You need to" message

  command-list.txt: list git-sh-i18n under purehelpers

This is new, should maybe be squashed into the original commit that
adds i18n support.

 .gitignore                          |    2 +
 Documentation/CodingGuidelines      |    7 +
 INSTALL                             |   12 +
 Makefile                            |  114 ++-
 builtin.h                           |    1 +
 builtin/add.c                       |   46 +-
 builtin/archive.c                   |   14 +-
 builtin/branch.c                    |   69 +-
 builtin/bundle.c                    |    6 +-
 builtin/checkout.c                  |   93 +-
 builtin/clean.c                     |   33 +-
 builtin/clone.c                     |   64 +-
 builtin/commit.c                    |  156 +-
 builtin/describe.c                  |   36 +-
 builtin/diff.c                      |   20 +-
 builtin/fetch-pack.c                |    2 +-
 builtin/fetch.c                     |   82 +-
 builtin/gc.c                        |   24 +-
 builtin/grep.c                      |   34 +-
 builtin/hash-object.c               |    2 +-
 builtin/index-pack.c                |    2 +-
 builtin/init-db.c                   |   56 +-
 builtin/log.c                       |   68 +-
 builtin/merge-index.c               |    2 +-
 builtin/merge-recursive.c           |    2 +-
 builtin/merge-tree.c                |    2 +-
 builtin/merge.c                     |  122 +-
 builtin/mktag.c                     |    2 +-
 builtin/mv.c                        |   32 +-
 builtin/notes.c                     |  134 +-
 builtin/pack-redundant.c            |    2 +-
 builtin/pack-refs.c                 |    2 +-
 builtin/patch-id.c                  |    2 +-
 builtin/push.c                      |   42 +-
 builtin/receive-pack.c              |    2 +-
 builtin/remote.c                    |    3 +-
 builtin/reset.c                     |   44 +-
 builtin/revert.c                    |   75 +-
 builtin/rm.c                        |   22 +-
 builtin/send-pack.c                 |    2 +-
 builtin/shortlog.c                  |    8 +-
 builtin/tag.c                       |   66 +-
 builtin/unpack-file.c               |    2 +-
 builtin/var.c                       |    2 +-
 command-list.txt                    |    1 +
 config.mak.in                       |    2 +
 configure.ac                        |   12 +
 daemon.c                            |    3 +
 fast-import.c                       |    3 +
 gettext.c                           |   27 +
 gettext.h                           |   22 +
 git-am.sh                           |   68 +-
 git-bisect.sh                       |   84 +-
 git-pull.sh                         |  147 +-
 git-sh-i18n.sh                      |   76 +
 git-stash.sh                        |   75 +-
 git-submodule.sh                    |   94 +-
 git.c                               |    3 +
 http-backend.c                      |    3 +
 http-fetch.c                        |    3 +
 http-push.c                         |    3 +
 imap-send.c                         |    3 +
 perl/Git/I18N.pm                    |   91 +
 perl/Makefile                       |    3 +-
 perl/Makefile.PL                    |   14 +-
 po/.gitignore                       |    1 +
 po/README                           |  209 +++
 po/de.po                            | 2923 +++++++++++++++++++++++++++=
++
 po/en_GB.po                         | 2784 +++++++++++++++++++++++++++=
+
 po/hi.po                            | 2787 +++++++++++++++++++++++++++=
+
 po/is.po                            |  194 ++
 po/pl.po                            | 2793 +++++++++++++++++++++++++++=
+
 po/sv.po                            | 3492 +++++++++++++++++++++++++++=
++++++++
 shell.c                             |    3 +
 show-index.c                        |    3 +
 t/lib-gettext.sh                    |   68 +
 t/lib-httpd.sh                      |    2 +-
 t/t0001-init.sh                     |    2 +-
 t/t0200-gettext-basic.sh            |  108 ++
 t/t0200/test.c                      |   23 +
 t/t0200/test.perl                   |   14 +
 t/t0200/test.sh                     |   14 +
 t/t0201-gettext-fallbacks.sh        |   49 +
 t/t0202-gettext-perl.sh             |   27 +
 t/t0202/test.pl                     |  109 ++
 t/t0203-gettext-setlocale-sanity.sh |   26 +
 t/t0204-gettext-reencode-sanity.sh  |   78 +
 t/t0205-gettext-poison.sh           |   36 +
 t/t1200-tutorial.sh                 |    5 +-
 t/t2200-add-update.sh               |    2 +-
 t/t2204-add-ignored.sh              |   37 +-
 t/t3030-merge-recursive.sh          |    2 +-
 t/t3200-branch.sh                   |    2 +-
 t/t3203-branch-output.sh            |    2 +-
 t/t3501-revert-cherry-pick.sh       |    2 +-
 t/t3507-cherry-pick-conflict.sh     |    2 +-
 t/t3700-add.sh                      |   11 +-
 t/t4001-diff-rename.sh              |    4 +-
 t/t4014-format-patch.sh             |    2 +-
 t/t4041-diff-submodule-option.sh    |   96 +-
 t/t4150-am.sh                       |    5 +-
 t/t4151-am-abort.sh                 |    2 +-
 t/t5601-clone.sh                    |    2 +-
 t/t6040-tracking-info.sh            |    2 +-
 t/t6120-describe.sh                 |    2 +-
 t/t7004-tag.sh                      |   21 +-
 t/t7012-skip-worktree-writing.sh    |    4 +-
 t/t7060-wtstatus.sh                 |    2 +-
 t/t7102-reset.sh                    |    2 +-
 t/t7110-reset-merge.sh              |    6 +-
 t/t7201-co.sh                       |   10 +-
 t/t7300-clean.sh                    |    6 +-
 t/t7400-submodule-basic.sh          |    4 +-
 t/t7401-submodule-summary.sh        |   59 +-
 t/t7407-submodule-foreach.sh        |    4 +-
 t/t7500-commit.sh                   |    6 +-
 t/t7501-commit.sh                   |    7 +-
 t/t7502-commit.sh                   |   56 +-
 t/t7506-status-submodule.sh         |   28 +-
 t/t7508-status.sh                   |  115 +-
 t/t7600-merge.sh                    |    2 +-
 t/t7811-grep-open.sh                |    2 +-
 t/test-lib.sh                       |   10 +
 upload-pack.c                       |    3 +
 wt-status.c                         |  118 +-
 125 files changed, 17499 insertions(+), 1141 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/README
 create mode 100644 po/de.po
 create mode 100644 po/en_GB.po
 create mode 100644 po/hi.po
 create mode 100644 po/is.po
 create mode 100644 po/pl.po
 create mode 100644 po/sv.po
 create mode 100644 t/lib-gettext.sh
 create mode 100755 t/t0200-gettext-basic.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
 create mode 100755 t/t0203-gettext-setlocale-sanity.sh
 create mode 100755 t/t0204-gettext-reencode-sanity.sh
 create mode 100755 t/t0205-gettext-poison.sh

--=20
1.7.3.272.g31195

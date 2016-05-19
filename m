From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.8.3
Date: Thu, 19 May 2016 10:48:49 -0700
Message-ID: <xmqqh9duj5vi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 19:50:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3S4U-0004no-VS
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbcESRsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 13:48:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932577AbcESRsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 13:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A5AD1B92C;
	Thu, 19 May 2016 13:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=JjNTn7BBy/FQ63Oc2Wxh3LCNo
	Bs=; b=KEOnyY2ygNdVBKBhltxXIBX+o+/g6QS/kQyKlIl9XVw4Xqxu+VBJ/WH9D
	Ivh7kcZirxBDrTlAm2Ev8Z1CLMPGAZrGrRF1HGEfDgD1H5SH+51XYZI0GM998gjT
	Q8JErQTvzL2aOQ9MIdXiZGS7QVOadUuicsEB2sgmCVuMvSpIaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IN10KvYzqrycyT0gbQW
	HoJllkBDH2jGZ5eS6DdpjXhV22nBOAZswLtLdFTC58aWRDWZcWaeogI6p3Ptkq0V
	G2sPRIXmLZ27B69lbWX1pJbrKAdMMvSNuBaudrQmPENtGsT/jQHs1TFp/BeefVFL
	BL4Ft+x4rpfcsXNOJRQOCX/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0155E1B92B;
	Thu, 19 May 2016 13:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 601771B928;
	Thu, 19 May 2016 13:48:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F27A3302-1DE9-11E6-B315-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295081>

The latest maintenance release Git v2.8.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.8.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.8.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.8.2
------------------

 * "git send-email" now uses a more readable timestamps when
   formulating a message ID.

 * The repository set-up sequence has been streamlined (the biggest
   change is that there is no longer git_config_early()), so that we
   do not attempt to look into refs/* when we know we do not have a
   Git repository.

 * When "git worktree" feature is in use, "git branch -d" allowed
   deletion of a branch that is checked out in another worktree

 * When "git worktree" feature is in use, "git branch -m" renamed a
   branch that is checked out in another worktree without adjusting
   the HEAD symbolic ref for the worktree.

 * "git format-patch --help" showed `-s` and `--no-patch` as if these
   are valid options to the command.  We already hide `--patch` option
   from the documentation, because format-patch is about showing the
   diff, and the documentation now hides these options as well.

 * A change back in version 2.7 to "git branch" broke display of a
   symbolic ref in a non-standard place in the refs/ hierarchy (we
   expect symbolic refs to appear in refs/remotes/*/HEAD to point at
   the primary branch the remote has, and as .git/HEAD to point at the
   branch we locally checked out).

 * A partial rewrite of "git submodule" in the 2.7 timeframe changed
   the way the gitdir: pointer in the submodules point at the real
   repository location to use absolute paths by accident.  This has
   been corrected.

 * "git commit" misbehaved in a few minor ways when an empty message
   is given via -m '', all of which has been corrected.

 * Support for CRAM-MD5 authentication method in "git imap-send" did
   not work well.

 * The socks5:// proxy support added back in 2.6.4 days was not aware
   that socks5h:// proxies behave differently.

 * "git config" had a codepath that tried to pass a NULL to
   printf("%s"), which nobody seems to have noticed.

 * On Cygwin, object creation uses the "create a temporary and then
   rename it to the final name" pattern, not "create a temporary,
   hardlink it to the final name and then unlink the temporary"
   pattern.

   This is necessary to use Git on Windows shared directories, and is
   already enabled for the MinGW and plain Windows builds.  It also
   has been used in Cygwin packaged versions of Git for quite a while.
   See http://thread.gmane.org/gmane.comp.version-control.git/291853
   and http://thread.gmane.org/gmane.comp.version-control.git/275680.

 * "git replace -e" did not honour "core.editor" configuration.

 * Upcoming OpenSSL 1.1.0 will break compilation b updating a few APIs
   we use in imap-send, which has been adjusted for the change.

 * "git submodule" reports the paths of submodules the command
   recurses into, but this was incorrect when the command was not run
   from the root level of the superproject.

 * The test scripts for "git p4" (but not "git p4" implementation
   itself) has been updated so that they would work even on a system
   where the installed version of Python is python 3.

 * The "user.useConfigOnly" configuration variable makes it an error
   if users do not explicitly set user.name and user.email.  However,
   its check was not done early enough and allowed another error to
   trigger, reporting that the default value we guessed from the
   system setting was unusable.  This was a suboptimal end-user
   experience as we want the users to set user.name/user.email without
   relying on the auto-detection at all.

 * "git mv old new" did not adjust the path for a submodule that lives
   as a subdirectory inside old/ directory correctly.

 * "git push" from a corrupt repository that attempts to push a large
   number of refs deadlocked; the thread to relay rejection notices
   for these ref updates blocked on writing them to the main thread,
   after the main thread at the receiving end notices that the push
   failed and decides not to read these notices and return a failure.

 * A question by "git send-email" to ask the identity of the sender
   has been updated.

 * Recent update to Git LFS broke "git p4" by changing the output from
   its "lfs pointer" subcommand.

 * Some multi-byte encoding can have a backslash byte as a later part
   of one letter, which would confuse "highlight" filter used in
   gitweb.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.8.2 are as follows:

Adam Dinwoodie (2):
      config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES
      commit: --amend -m '' silently fails to wipe message

Christian Couder (3):
      builtin/apply: get rid of useless 'name' variable
      builtin/apply: handle parse_binary() failure
      builtin/apply: free patch when parse_chunk() fails

Eric Sunshine (1):
      git-format-patch.txt: don't show -s as shorthand for multiple opt=
ions

Eric Wong (4):
      send-email: more meaningful Message-ID
      send-email: do not load Data::Dumper
      pack-objects: warn on split packs disabling bitmaps
      .mailmap: update to my shorter email address

Jeff King (22):
      setup: document check_repository_format()
      wrap shared_repository global in get/set accessors
      lazily load core.sharedrepository
      check_repository_format_gently: stop using git_config_early
      config: drop git_config_early
      setup: refactor repo format reading and verification
      init: use setup.c's repo version verification
      setup: unify repository version callbacks
      setup: drop repository_format_version global
      verify_repository_format: mark messages for translation
      branch: fix shortening of non-remote symrefs
      commit: do not ignore an empty message given by -m ''
      config: lower-case first word of error strings
      git_config_set_multivar_in_file: all non-zero returns are errors
      git_config_set_multivar_in_file: handle "unset" errors
      t5532: use write_script
      send-pack: close demux pipe before finishing async process
      run-command: teach async threads to ignore SIGPIPE
      send-pack: isolate sigpipe in demuxer thread
      fetch-pack: isolate sigpipe in demuxer thread
      t5504: drop sigpipe=3Dok from push tests
      remote.c: spell __attribute__ correctly

Johannes Schindelin (5):
      replace --edit: respect core.editor
      win32mmap: set errno appropriately
      mmap(win32): avoid copy-on-write when it is unnecessary
      mmap(win32): avoid expensive fstat() call
      Windows: only add a no-op pthread_sigmask() when needed

Johannes Sixt (1):
      Windows: add pthread_sigmask() that does nothing

Junio C Hamano (10):
      apply: remove unused call to free() in gitdiff_{old,new}name()
      submodule--helper: do not borrow absolute_path() result for too l=
ong
      setup.c: do not feed NULL to "%.*s" even with precision 0
      http: differentiate socks5:// and socks5h://
      t1020: do not overuse printf and use write_script
      t3404: use write_script
      send-email: fix grammo in the prompt that asks e-mail recipients
      Start preparing for 2.8.3
      Almost ready for 2.8.3
      Git 2.8.3

Kazuki Yamaguchi (10):
      branch -d: refuse deleting a branch which is currently checked ou=
t
      refs: add a new function set_worktree_head_symref
      branch -m: update all per-worktree HEADs
      set_worktree_head_symref(): fix error message
      imap-send: use HMAC() function provided by OpenSSL
      imap-send: check NULL return of SSL_CTX_new()
      imap-send: avoid deprecated TLSv1_method()
      configure: remove checking for HMAC_CTX_cleanup
      imap-send: check for NOLOGIN capability only when using LOGIN com=
mand
      imap-send: fix CRAM-MD5 response calculation

Lars Schneider (5):
      travis-ci: update Git-LFS and P4 to the latest version
      travis-ci: express Linux/OS X dependency versions more clearly
      git-p4: fix Git LFS pointer parsing
      t9824: fix wrong reference value
      Documentation: add setup instructions for Travis CI

Luke Diamand (3):
      git-p4 tests: cd to / before running python
      git-p4 tests: work with python3 as well as python2
      git-p4 tests: time_in_seconds should use $PYTHON_PATH

Marios Titas (2):
      ident: check for useConfigOnly before auto-detection of name/emai=
l
      ident: give "please tell me" message upon useConfigOnly error

Matthieu Moy (1):
      git-multimail: update to release 1.3.0

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      dir.c: remove dead function fnmatch_icase()
      wrapper.c: delete dead function git_mkstemps()

Nikola Forr=C3=B3 (1):
      difftool/mergetool: make the form of yes/no questions consistent

Ralf Thielow (1):
      string_list: use string-list API in unsorted_string_list_lookup()

Ren=C3=A9 Nyffenegger (1):
      Documentation: fix typo 'In such these cases'

SZEDER G=C3=A1bor (4):
      for-each-ref: fix description of '--contains' in manpage
      test-lib: simplify '--option=3Dvalue' parsing
      t9824: fix broken &&-chain in a subshell
      t5510: run auto-gc in the foreground

Shin Kojima (1):
      gitweb: apply fallback encoding before highlight

Stefan Beller (20):
      submodule foreach: correct path display in recursive submodules
      submodule update --init: correct path handling in recursive submo=
dules
      submodule status: correct path handling in recursive submodules
      submodule update: align reporting path for custom command executi=
on
      submodule update: test recursive path reporting from subdirectory
      t7407: make expectation as clear as possible
      recursive submodules: test for relative paths
      submodule--helper: fix potential NULL-dereference
      submodule--helper clone: create the submodule path just once
      notes: don't leak memory in git_config_get_notes_strategy
      abbrev_sha1_in_line: don't leak memory
      bundle: don't leak an fd in case of early return
      credential-cache, send_request: close fd when done
      submodule--helper, module_clone: always operate on absolute paths
      submodule--helper, module_clone: catch fprintf failure
      mv: allow moving nested submodules
      config doc: improve exit code listing
      config.c: drop local variable
      submodule-config: don't shadow `cache`
      t7300: mark test with SANITY

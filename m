From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12.1
Date: Tue, 18 Sep 2012 16:14:12 -0700
Message-ID: <7vboh2kjp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 01:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE709-0000tj-7c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2IRXOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2012 19:14:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab2IRXOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:14:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7B997E0;
	Tue, 18 Sep 2012 19:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=6PlV99DBXynRO7/CZ17ud+FSu
	OU=; b=PMW775Gz16+B4pkaq4vBHueH7mrs5uN2bBxH8lN89P9XtODK9lXt/77VA
	24cCpftEnX2tnHwU7iVOmkbE+ZIHtT6JeHnidAfEr09L0HTH5QCdswqYRIEvrKmH
	I7k2Gx/CkJIoOld6qFDjHQ0rI5AlVpk/r3lw2dSNHJe8AU/lxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wXlpjc457Id8yEPkjDn
	BBmrNbXlOAbWJa0bXsSEdRUp1+nBeEEUjzxFzOpd5wSO9tlbP2LkULOVtE2jpiUt
	MsH4GNyzHypvAeV62R8SSpVeMDCJRL+o9M2s0ysAMC/oh2QeVEztdxQwEYrnWMoD
	qJKkQ7PXnl75LSQ+o7YM8r8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B823797DF;
	Tue, 18 Sep 2012 19:14:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADC6297DD; Tue, 18 Sep 2012
 19:14:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F8F994E-01E6-11E2-BAE6-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205885>

The latest maintenance release Git v1.7.12.1 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

c5227b5202947bba3d63dca72662fad02d208800  git-1.7.12.1.tar.gz
b42d5db34612825676d0a231cf9c566f8ad45e9f  git-htmldocs-1.7.12.1.tar.gz
2d9c267c5370cdceb2e67f67abf5b152b0c18db9  git-manpages-1.7.12.1.tar.gz

Also the following public repositories all have a copy of the v1.7.12.1
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.7.12.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.12
-------------------

 * "git apply -p0" did not parse pathnames on "diff --git" line
   correctly.  This caused patches that had pathnames in no other
   places to be mistakenly rejected (most notably, binary patch that
   does not rename nor change mode).  Textual patches, renames or mode
   changes have preimage and postimage pathnames in different places
   in a form that can be parsed unambiguously and did not suffer from
   this problem.

 * "git cherry-pick A C B" used to replay changes in A and then B and
   then C if these three commits had committer timestamps in that
   order, which is not what the user who said "A C B" naturally
   expects.

 * "git commit --amend" let the user edit the log message and then
   died when the human-readable committer name was given
   insufficiently by getpwent(3).

 * Some capabilities were asked by fetch-pack even when upload-pack
   did not advertise that they are available.  fetch-pack has been
   fixed not to do so.

 * "git diff" had a confusion between taking data from a path in the
   working tree and taking data from an object that happens to have
   name 0{40} recorded in a tree.

 * "git for-each-ref" did not correctly support more than one --sort
   option.

 * "git log .." errored out saying it is both rev range and a path
   when there is no disambiguating "--" is on the command line.
   Update the command line parser to interpret ".." as a path in such
   a case.

 * The "--topo-order", "--date-order" (and the lack of either means
   the default order) options to "rev-list" and "log" family of
   commands were poorly described in the documentation.

 * "git prune" without "-v" used to warn about leftover temporary
   files (which is an indication of an earlier aborted operation).

 * Pushing to smart HTTP server with recent Git fails without having
   the username in the URL to force authentication, if the server is
   configured to allow GET anonymously, while requiring authentication
   for POST.

 * The reflog entries left by "git rebase" and "git rebase -i" were
   inconsistent (the interactive one gave an abbreviated object name).

 * When "git push" triggered the automatic gc on the receiving end, a
   message from "git prune" that said it was removing cruft leaked to
   the standard output, breaking the communication protocol.

 * "git show --quiet" ought to be a synonym for "git show -s", but
   wasn't.

 * "git show --format=3D'%ci'" did not give timestamp correctly for
   commits created without human readable name on "committer" line.

 * "git send-email" did not unquote encoded words that appear on the
   header correctly, and lost "_" from strings.

 * The interactive prompt "git send-email" gives was error prone. It
   asked "What e-mail address do you want to use?" with the address it
   guessed (correctly) the user would want to use in its prompt,
   tempting the user to say "y". But the response was taken as "No,
   please use 'y' as the e-mail address instead", which is most
   certainly not what the user meant.

 * "gitweb" when used with PATH_INFO failed to notice directories with
   SP (and other characters that need URL-style quoting) in them.

 * When the user gives an argument that can be taken as both a
   revision name and a pathname without disambiguating with "--", we
   used to give a help message "Use '--' to separate".  The message
   has been clarified to show where that '--' goes on the command
   line.

 * When the user exports a non-default IFS without HT, scripts that
   rely on being able to parse "ls-files -s | while read a b c..."
   started to fail.  Protect them from such a misconfiguration.

 * The attribute system may be asked for a path that itself or its
   leading directories no longer exists in the working tree, and it is
   fine if we cannot open .gitattribute file in such a case.  Failure
   to open per-directory .gitattributes with error status other than
   ENOENT and ENOTDIR should be diagnosed, but it wasn't.

 * After "gitk" showed the contents of a tag, neither "Reread
   references" nor "Reload" did not update what is shown as the
   contents of it, when the user overwrote the tag with "git tag -f".

 * "ciabot" script (in contrib/) has been updated with extensive
   documentation.

 * "git-jump" script (in contrib/) did not work well when
   diff.noprefix or diff.mnemonicprefix is in effect.

 * Older parts of the documentation described as if having a regular
   file in .git/refs/ hierarchy were the only way to have branches and
   tags, which is not true for quite some time.

 * A utility shell function test_seq has been added as a replacement
   for the 'seq' utility found on some platforms.

 * Compatibility wrapper to learn the maximum number of file
   descriptors we can open around sysconf(_SC_OPEN_MAX) and
   getrlimit(RLIMIT_NO_FILE) has been introduced for portability.

 * We used curl_easy_strerror() without checking version of cURL,
   breaking the build for versions before curl 7.12.0.

 * Code to work around MacOS X UTF-8 gotcha has been cleaned up.

 * Fallback 'getpass' implementation made unportable use of stdio API.

 * The "--rebase" option to "git pull" can be abbreviated to "-r",
   but we didn't document it.

 * It was generally understood that "--long-option"s to many of our
   subcommands can be abbreviated to the unique prefix, but it was not
   easy to find it described for new readers of the documentation set.

 * The synopsis said "checkout [-B branch]" to make it clear the
   branch name is a parameter to the option, but the heading for the
   option description was "-B::", not "-B branch::", making the
   documentation misleading.

Also contains numerous documentation updates.

----------------------------------------------------------------

Changes since v1.7.12 are as follows:

Adam Butcher (1):
      Fix '\ No newline...' annotation in rewrite diffs

Adam Spiers (1):
      Add missing -z to git check-attr usage text for consistency with =
man page

Andreas Schwab (1):
      Documentation/git-filter-branch: Move note about effect of removi=
ng commits

Brandon Casey (2):
      t/t5400: demonstrate breakage caused by informational message fro=
m prune
      prune.c: only print informational message in show_only or verbose=
 mode

David Aguilar (2):
      gitk: Teach "Reread references" to reload tags
      gitk: Rename 'tagcontents' to 'cached_tagcontent'

Eric S. Raymond (4):
      fast-import: document the --done option
      contrib/ciabot: Get ciabot configuration from git variables
      Improved documentation for the ciabot scripts.
      Make the ciabot scripts completely self-configuring in the normal=
 case.

=46elipe Contreras (1):
      gitk: Avoid Meta1-F5

Heiko Voigt (2):
      Let submodule command exit with error status if path does not exi=
st
      Documentation/CodingGuidelines: spell out more shell guidelines

Jay Soffian (1):
      gitweb: URL-decode $my_url/$my_uri when stripping PATH_INFO

Jeff King (29):
      diff: do not use null sha1 as a sentinel value
      do not write null sha1s to on-disk index
      fsck: detect null sha1 in tree entries
      include agent identifier in capability string
      docs: monospace listings in docbook output
      check-docs: mention gitweb specially
      check-docs: update non-command documentation list
      command-list: add git-sh-i18n
      command-list: mention git-credential-* helpers
      check-docs: factor out command-list
      check-docs: list git-gui as a command
      check-docs: drop git-help special-case
      check-docs: get documented command list from Makefile
      send-pack: fix capability-sending logic
      do not send client agent unless server does first
      parse_feature_request: make it easier to see feature values
      fetch-pack: mention server version with verbose output
      config: warn on inaccessible files
      gitignore: report access errors of exclude files
      attr: warn on inaccessible attribute files
      t5550: put auth-required repo in auth/dumb
      t5550: factor out http auth setup
      t/lib-httpd: only route auth/dumb to dumb repos
      t/lib-httpd: recognize */smart/* repos as smart-http
      t: test basic smart-http authentication
      t: test http access to "half-auth" repositories
      http: factor out http error code handling
      http: prompt for credentials on failed POST
      log: fix --quiet synonym for -s

Joachim Schmitz (2):
      http.c: don't use curl_easy_strerror prior to curl-7.12.0
      sha1_file.c: introduce get_max_fd_limit() helper

Junio C Hamano (34):
      test: rename $satisfied to $satisfied_prereq
      test: allow prerequisite to be evaluated lazily
      config: "git config baa" should exit with status 1
      t7406: fix misleading "rev-parse --max-count=3D1 HEAD"
      sane_execvp(): ignore non-directory on $PATH
      Documentation: do not mention .git/refs/* directories
      receive-pack: do not leak output from auto-gc to standard output
      sh-setup: protect from exported IFS
      fetch-pack: do not ask for unadvertised capabilities
      send-email: validate & reconfirm interactive responses
      rev-list docs: clarify --topo-order description
      gitcli: describe abbreviation of long options
      Documentation: update the introductory section
      git-config doc: unconfuse an example
      precompose-utf8: do not call checks for non-ascii "utf8"
      warn_on_inaccessible(): a helper to warn on inaccessible paths
      specifying ranges: we did not mean to make ".." an empty set
      mergetool: style fixes
      Prepare for 1.7.11.6
      apply: compute patch->def_name correctly under -p0
      doc: "git checkout -b/-B/--orphan" always takes a branch name
      split_ident_line(): make best effort when parsing author/committe=
r line
      Document file-glob for "git checkout -- '*.c'"
      gitcli: formatting fix
      gitcli: contrast wildcard given to shell and to git
      Almost 1.7.11.6
      Start preparing for 1.7.12.1
      Git 1.7.11.6
      Further merging down for 1.7.12.1
      Further merging in preparation for 1.7.12.1
      attr: failure to open a .gitattributes file is OK with ENOTDIR
      Git 1.7.11.7
      Draft release notes to 1.7.12.1
      Git 1.7.12.1

Kacper Kornet (2):
      t6300: test sort with multiple keys
      for-each-ref: Fix sort with multiple keys

Martin von Zweigbergk (4):
      add tests for 'git rebase --keep-empty'
      teach log --no-walk=3Dunsorted, which avoids sorting
      demonstrate broken 'git cherry-pick three one two'
      cherry-pick/revert: respect order of revisions to pick

Matthieu Moy (1):
      setup: clarify error messages for file/revisions ambiguity

Michael Haggerty (1):
      git-config.txt: fix example

Michael J Gruber (6):
      test-lib: provide case insensitivity as a prerequisite
      t0050: use the CASE_INSENSITIVE_FS test prereq
      t0050: use the SYMLINKS test prereq
      test-lib: provide UTF8 behaviour as a prerequisite
      rebase -i: use full onto sha1 in reflog
      t3910: use the UTF8_NFD_TO_NFC test prereq

Micha=C5=82 Kiedrowicz (1):
      tests: Introduce test_seq

Miklos Vajna (1):
      man: git pull -r is a short for --rebase

Mischa POSLAWSKY (1):
      git-jump: ignore (custom) prefix in diff mode

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      read_index_from: remove bogus errno assignments

Paul Gortmaker (1):
      apply: delete unused deflate_origlen from patch struct

Phil Hord (2):
      test: git-stash conflict sets up rerere
      stash: invoke rerere in case of conflict

Philip Oakley (1):
      Doc: Improve shallow depth wording

Ramkumar Ramachandra (1):
      t/perf: add "trash directory" to .gitignore

Ramsay Allan Jones (1):
      test-regex: Add a test to check for a bug in the regex routines

Robin Rosenberg (1):
      cleanup precompose_utf8

Stefan Zager (1):
      Make 'git submodule update --force' always check out submodules.

Stephen Boyd (1):
      send-email: initial_to and initial_reply_to are both optional

Thomas Rast (3):
      send-email: improve RFC2047 quote parsing
      diff_setup_done(): return void
      merge-recursive: eliminate flush_buffer() in favor of write_in_fu=
ll()

Wesley J. Landaker (1):
      Documentation: indent-with-non-tab uses "equivalent tabs" not 8

Yacine Belkadi (1):
      completion: add --no-edit to git-commit

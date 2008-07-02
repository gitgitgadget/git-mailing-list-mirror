From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Tue, 01 Jul 2008 23:28:25 -0700
Message-ID: <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
 <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
 <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 08:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDvqZ-0006OG-0O
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 08:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572AbYGBG2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 02:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759520AbYGBG2n
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 02:28:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbYGBG2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 02:28:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94A1127B6D;
	Wed,  2 Jul 2008 02:28:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E068927B6C; Wed,  2 Jul 2008 02:28:34 -0400 (EDT)
X-maint-at: 7ad0f27b925463c5ca6908573ed24ede11a9981f
X-master-at: e903b4095a097a549bb432748c06b0b0e600b27d
In-Reply-To: <7vabh93lk6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 25 Jun 2008 02:34:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1AB09F8C-4800-11DD-81B4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87090>

There are a few fixes on 'maint', in addition to futureproofing of "git
shell" so that eventually we can update the ssh clients to ask for serv=
er
side programs using "git upload-pack" syntax without a dash between "gi=
t"
and the subcommand name.

Many of the medimu size items for 1.6.0 have been merged to 'master'.  =
The
port to MinGW series will also be merged shortly.

----------------------------------------------------------------

GIT v1.6.0 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

User visible changes
--------------------

With the default Makefile settings, most of the programs are now
installed outside your $PATH, except for "git", "gitk", "git-gui" and
some server side programs that need to be accessible for technical
reasons.  Invoking a git subcommand as "git-xyzzy" from the command
line has been deprecated since early 2006 (and officially announced in
1.5.4 release notes); use of them from your scripts after adding
output from "git --exec-path" to the $PATH is still supported in this
release, but users are again strongly encouraged to adjust their
scripts to use "git xyzzy" form, as we will stop installing
"git-xyzzy" hardlinks for built-in commands in later releases.

Source changes needed for porting to MinGW environment are now all in t=
he
main git.git codebase.

By default, packfiles created with this version uses delta-base-offset
encoding introduced in v1.4.4.  Pack idx files are using version 2 that
allows larger packs and added robustness thanks to its CRC checking,
introduced in v1.5.2.


Updates since v1.5.6
--------------------

(subsystems)

* git-p4 in contrib learned "allowSubmit" configuration to control on
  which branch to allow "submit" subcommand.

(portability)

* Sample hook scripts shipped in templates/ are now suffixed with
  *.sample.  We used to prevent them from triggering by default by
  relying on the fact that we install them as unexecutable, but on
  some filesystems this approach does not work.  Instead of running
  "chmod +x" on them, the users who want to activate these samples
  as-is can now rename them dropping *.sample suffix.

* perl's in-place edit (-i) does not work well without backup files on =
Windows;
  some tests are rewritten to cope with this.

(documentation)

* Updated howto/update-hook-example

* Got rid of usage of "git-foo" from the tutorial.

* Disambiguating "--" between revs and paths is finally documented.

(performance, robustness, sanity etc.)

* even more documentation pages are now accessible via "man" and "git h=
elp".

* reduced excessive inlining to shrink size of the "git" binary.

* verify-pack checks the object CRC when using version 2 idx files.

* When an object is corrupt in a pack, the object became unusable even
  when the same object is available in a loose form,  We now try harder=
 to
  fall back to these redundant objects when able.  In particular, "git
  repack -a -f" can be used to fix such a corruption as long as necessa=
ry
  objects are available.

* git-clone does not create refs in loose form anymore (it behaves as
  if you immediately ran git-pack-refs after cloning).  This will help
  repositories with insanely large number of refs.

* core.fsyncobjectfiles configuration can be used to ensure that the lo=
ose
  objects created will be fsync'ed (this is only useful on filesystems
  that does not order data writes properly).

* "git commit-tree" plumbing can make Octopus with more than 16 parents=
=2E
  "git commit" has been capable of this for quite some time.

(usability, bells and whistles)

* git-apply can handle a patch that touches the same path more than onc=
e
  much better than before.

* git-apply can be told not to trust the line counts recorded in the in=
put
  patch but recount, with the new --recount option.

* git-archive can be told to omit certain paths from its output using
  export-ignore attributes.

* git-clone can clone from a remote whose URL would be rewritten by
  configuration stored in $HOME/.gitconfig now.

* git-diff --check now checks leftover merge conflict markers.

* When remote side used to have branch 'foo' and git-fetch finds that n=
ow
  it has branch 'foo/bar', it refuses to lose the existing remote track=
ing
  branch and its reflog.  The error message has been improved to sugges=
t
  pruning the remote if the user wants to proceed and get the latest se=
t
  of branches from the remote, including such 'foo/bar'.

* fast-export learned to export and import marks file; this can be used=
 to
  interface with fast-import incrementally.

* Original SHA-1 value for "update-ref -d" is optional now.

* git-send-mail can talk not just over SSL but over TLS now.

* You can tell "git status -u" to even more aggressively omit checking
  untracked files with --untracked-files=3Dno.

* Error codes from gitweb are made more descriptive where possible, rat=
her
  than "403 forbidden" as we used to issue everywhere.

(internal)


=46ixes since v1.5.6
------------------

All of the fixes in v1.5.6 maintenance series are included in
this release, unless otherwise noted.

 * diff -c/--cc showed unnecessary "deletion" lines at the context
   boundary (needs backmerge to maint).

 * "git-clone <src> <dst>" did not create leading directories for <dst>
   like the scripted version used to do (needs backport to maint).


----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.6.1.

Avery Pennarun (1):
  git-svn: avoid filling up the disk with temp files.

Bj=C3=B6rn Steinbrink (1):
  git cat-file: Fix memory leak in batch mode

Eric Wong (1):
  git-svn: don't sanitize remote names in config

Jeff King (1):
  doc/rev-parse: clarify reflog vs --until for specifying revisions

Jochen Voss (1):
  avoid off-by-one error in run_upload_archive

Joey Hess (1):
  fix git config example syntax

Junio C Hamano (5):
  diff --check: do not discard error status upon seeing a good line
  git-shell: accept "git foo" form
  GIT 1.5.4.6
  GIT 1.5.5.5
  Start draft release notes for 1.5.6.2

Thomas Rast (1):
  Fix 'git show' on signed tag of signed tag of commit


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix use of "perl -i" on Windows

Brian Gernhardt (2):
  Fix t4017-diff-retval for white-space from wc
  Add test results directory to t/.gitignore

Christian Couder (1):
  help: check early if we have a command, if not try a documentation to=
pic

Dmitry Potapov (2):
  update-hook-example: optionally allow non-fast-forward
  shrink git-shell by avoiding redundant dependencies

Don Zickus (1):
  git-apply: handle a patch that touches the same path more than once
    better

Jeff King (3):
  improve for-each-ref test script
  fetch: report local storage errors in status table
  fetch: give a hint to the user when local refs fail to update

Jing Xue (1):
  Add 'git-p4.allowSubmit' to git-p4

Johan Herland (4):
  Incorporate fetched packs in future object traversal
  Move pack_refs() and friends into libgit
  Prepare testsuite for a "git clone" that packs refs
  Teach "git clone" to pack refs

Johannes Schindelin (4):
  clone: respect url.insteadOf setting in global configs
  commit-tree: lift completely arbitrary limit of 16 parents
  Allow git-apply to recount the lines in a hunk (AKA recountdiff)
  clone: respect the settings in $HOME/.gitconfig and /etc/gitconfig

Jonathan Nieder (7):
  Documentation: fix links to tutorials and other new manual pages
  whitespace fix in Documentation/git-repack.txt
  Documentation: complicate example of "man git-command"
  git-daemon(1): don't assume git-daemon is in /usr/bin
  Documentation: prepare to be consistent about "git-" versus "git "
  Documentation: be consistent about "git-" versus "git "
  Documentation formatting and cleanup

Junio C Hamano (15):
  git-shell: accept "git foo" form
  Prepare execv_git_cmd() for removal of builtins from the filesystem
  Keep some git-* programs in $(bindir)
  Allow "git-reset path" when unambiguous
  Start draft release notes for 1.6.0
  diff --check: explain why we do not care whether old side is binary
  check_and_emit_line(): rename and refactor
  checkdiff: pass diff_options to the callback
  Teach "diff --check" about new blank lines at end
  diff --check: detect leftover conflict markers
  Update sample pre-commit hook to use "diff --check"
  Document the double-dash "rev -- path" disambiguator
  t9700: skip when Test::More is not available
  Update draft release notes for 1.6.0
  Update draft release notes for 1.6.0

Kevin Ballard (1):
  git-send-email: Accept fifos as well as files

Lea Wiemann (5):
  t/test-lib.sh: add test_external and test_external_without_stderr
  Git.pm: add test suite
  gitweb: standarize HTTP status codes
  test-lib.sh: show git init output when in verbose mode
  GIT-VERSION-GEN: do not fail if a 'HEAD' file exists in the working c=
opy

Linus Torvalds (4):
  Split up default "core" config parsing into helper routine
  Split up default "user" config parsing into helper routine
  Split up default "i18n" and "branch" config parsing into helper routi=
nes
  Add config option to enable 'fsync()' of object files

Miklos Vajna (1):
  A simple script to parse the results from the testcases

Nanako Shiraishi (1):
  gitcli: Document meaning of --cached and --index

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  Move all dashed-form commands to libexecdir

Nicolas Pitre (2):
  repack.usedeltabaseoffset config option now defaults to "true"
  pack.indexversion config option now defaults to 2

Olivier Marin (2):
  Documentation: remove {show,whatchanged}.difftree config options
  show_stats(): fix stats width calculation

Patrick Higgins (1):
  Remove the use of '--' in merge program invocation

Stephan Beyer (2):
  api-builtin.txt: update and fix typo
  t3404: stricter tests for git-rebase--interactive

Sverre Rabbelier (2):
  Modify test-lib.sh to output stats to t/test-results/*
  Hook up the result aggregation in the test makefile.

Ted Percival (1):
  Don't use dash commands (git-foo) in tutorial-2

Thomas Rast (2):
  git-send-email: add support for TLS via Net::SMTP::SSL
  git-send-email: prevent undefined variable warnings if no encryption =
is
    set

jrnieder@uchicago.edu (1):
  Documentation: don't assume git-sh-setup and git-parse-remote are in =
PATH

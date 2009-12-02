From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.6.rc1
Date: Wed, 02 Dec 2009 15:24:22 -0800
Message-ID: <7veind7ye1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755614AbZLBXYc@vger.kernel.org Thu Dec 03 00:24:54 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755614AbZLBXYc@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFyZ2-0005qc-HW
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Dec 2009 00:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbZLBXYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Dec 2009 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbZLBXYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Dec 2009 18:24:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZLBXY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Dec 2009 18:24:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CD38469C;
	Wed,  2 Dec 2009 18:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0b7O6CW3YyjrwLKanWKSURmMA
	V8=; b=EY0w2PAyow7wcd0jxEE9SV3rghOAmZlFcLDqNSW/SOq+1c4bDKOvMrsBF
	GmUegdmbBhAMYsglMUuNZUW4pZVY5vpsR0XZ9lD1W6XNloYZlNoNBThA8k6TUz1E
	OP/oE+33iwxePFUzgHfvS5z7t7JaEOZfNFs4xUdES+zZ5Ax0yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pA4azg/UOFB11eMOO0E
	vYiDsAeZ+QUq5L6N0udBQvnRo+cM5qYFyxDEdRdIuRFedvG0v5NRg911XaDC9kGZ
	FKy+aNbJsYOEHgNzXDfKU0cHZKwr3Vi0We2poxiKQkJj0DE77/VPiwIJpYxVxdbY
	LsWv78jls16uptNmXvi+1+Gc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D74308469B;
	Wed,  2 Dec 2009 18:24:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 360BC8469A; Wed,  2 Dec
 2009 18:24:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7A222D2-DF99-11DE-974E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134419>

A release candidate GIT 1.6.6.rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.6.rc1-1.fc11.$arch.rpm	(RPM)

Git v1.6.6 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Notes on behaviour change
-------------------------

 * In this release, "git fsck" defaults to "git fsck --full" and
   checks packfiles, and because of this it will take much longer to
   complete than before.  If you prefer a quicker check only on loose
   objects (the old default), you can say "git fsck --no-full".  This
   has been supported by 1.5.4 and newer versions of git, so it is
   safe to write it in your script even if you use slightly older git
   on some of your machines.

Preparing yourselves for compatibility issues in 1.7.0
------------------------------------------------------

In git 1.7.0, which is planned to be the release after 1.6.6, there wil=
l
be a handful of behaviour changes that will break backward compatibilit=
y.

These changes were discussed long time ago and existing behaviours have
been identified as more problematic to the userbase than keeping them f=
or
the sake of backward compatibility.

When necessary, transition strategy for existing users has been designe=
d
not to force them running around setting configuration variables and
updating their scripts in order to either keep the traditional behaviou=
r
or use the new behaviour on the day their sysadmin decides to install
the new version of git.  When we switched from "git-foo" to "git foo" i=
n
1.6.0, even though the change had been advertised and the transition
guide had been provided for a very long time, the users procrastinated
during the entire transtion period, and ended up panicking on the day
their sysadmins updated their git installation.  We tried very hard to
avoid repeating that unpleasantness.

=46or changes decided to be in 1.7.0, we have been much louder to stron=
gly
discourage such procrastination.  If you have been using recent version=
s
of git, you would have already seen warnings issued when you exercised
features whose behaviour will change, with the instruction on how to
keep the existing behaviour if you want to.  You hopefully should be
well prepared already.

Of course, we have also given "this and that will change in 1.7.0;
prepare yourselves" warnings in the release notes and announcement
messages.  Let's see how well users will fare this time.

 * "git push" into a branch that is currently checked out (i.e. pointed=
 by
   HEAD in a repository that is not bare) will be refused by default.

   Similarly, "git push $there :$killed" to delete the branch $killed
   in a remote repository $there, when $killed branch is the current
   branch pointed at by its HEAD, will be refused by default.

   Setting the configuration variables receive.denyCurrentBranch and
   receive.denyDeleteCurrent to 'ignore' in the receiving repository
   can be used to override these safety features.  Versions of git
   since 1.6.2 have issued a loud warning when you tried to do them
   without setting the configuration, so repositories of people who
   still need to be able to perform such a push should already have
   been future proofed.

   Please refer to:

   http://git.or.cz/gitwiki/GitFaq#non-bare
   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=3D=
108007

   for more details on the reason why this change is needed and the
   transition process that already took place so far.

 * "git send-email" will not make deep threads by default when sending =
a
   patch series with more than two messages.  All messages will be sent
   as a reply to the first message, i.e. cover letter.  Git 1.6.6 (this
   release) will issue a warning about the upcoming default change, whe=
n
   it uses the traditional "deep threading" behaviour as the built-in
   default.  To squelch the warning but still use the "deep threading"
   behaviour, give --chain-reply-to option or set sendemail.chainreplyt=
o
   to true.

   It has been possible to configure send-email to send "shallow thread=
"
   by setting sendemail.chainreplyto configuration variable to false.
   The only thing 1.7.0 release will do is to change the default when
   you haven't configured that variable.

 * "git status" will not be "git commit --dry-run".  This change does n=
ot
   affect you if you run the command without pathspec.

   Nobody sane found the current behaviour of "git status Makefile" use=
ful
   nor meaningful, and it confused users.  "git commit --dry-run" has b=
een
   provided as a way to get the current behaviour of this command since
   1.6.5.

 * "git diff" traditionally treated various "ignore whitespace" options
   only as a way to filter the patch output.  "git diff --exit-code -b"
   exited with non-zero status even if all changes were about changing =
the
   ammount of whitespace and nothing else.  and "git diff -b" showed th=
e
   "diff --git" header line for such a change without patch text.

   In 1.7.0, the "ignore whitespaces" will affect the semantics of the
   diff operation itself.  A change that does not affect anything but
   whitespaces will be reported with zero exit status when run with
   --exit-code, and there will not be "diff --git" header for such a
   change.


Updates since v1.6.5
--------------------

(subsystems)

 * various git-gui updates including new translations, wm states, etc.

 * git-svn updates.

 * "git fetch" over http learned a new mode that is different from the
   traditional "dumb commit walker".

(portability)

 * imap-send can be built on mingw port.

(performance)

 * "git diff -B" has smaller memory footprint.

(usability, bells and whistles)

 * The object replace mechanism can be bypassed with --no-replace-objec=
ts
   global option given to the "git" program.

 * In configuration files, a few variables that name paths can begin wi=
th ~/
   and ~username/ and they are expanded as expected.

 * "git subcmd -h" now shows short usage help for many more subcommands=
=2E

 * "git bisect reset" can reset to an arbitrary commit.

 * "git checkout frotz" when there is no local branch "frotz" but there
   is only one remote tracking branch "frotz" is taken as a request to
   start the named branch at the corresponding remote tracking branch.

 * "git commit -c/-C/--amend" can be told with a new "--reset-author" o=
ption
   to ignore authorship information in the commit it is taking the mess=
age
   from.

 * "git describe" can be told to add "-dirty" suffix with "--dirty" opt=
ion.

 * "git diff" learned --submodule option to show a list of one-line log=
s
   instead of differences between the commit object names.

 * "git diff" learned to honor diff.color.func configuration to paint
   function name hint printed on the hunk header "@@ -j,k +l,m @@" line
   in the specified color.

 * "git fetch" learned --all and --multiple options, to run fetch from
   many repositories, and --prune option to remove remote tracking
   branches that went stale.  These make "git remote update" and "git
   remote prune" less necessary (there is no plan to remove "remote
   update" nor "remote prune", though).

 * "git fsck" by default checks the packfiles (i.e. "--full" is the
   default); you can turn it off with "git fsck --no-full".

 * "git grep" can use -F (fixed strings) and -i (ignore case) together.

 * import-tars contributed fast-import frontend learned more types of
   compressed tarballs.

 * "git instaweb" knows how to talk with mod_cgid to apache2.

 * "git log --decorate" shows the location of HEAD as well.

 * "git log" and "git rev-list" learned to take revs and pathspecs from
   the standard input with the new "--stdin" option.

 * "--pretty=3Dformat" option to "log" family of commands learned:

   . to wrap text with the "%w()" specifier.
   . to show reflog information with "%g[sdD]" specifier.

 * "git notes" command to annotate existing commits.

 * "git merge" (and "git pull") learned --ff-only option to make it fai=
l
   if the merge does not result in a fast-forward.

 * The ancient "git merge <message> HEAD <branch>..." syntax will be
   removed in later versions of git.  A warning is given and tells
   users to use the "git merge -m <message> <branch>..." instead.

 * "git mergetool" learned to use p4merge.

 * "git rebase -i" learned "reword" that acts like "edit" but immediate=
ly
   starts an editor to tweak the log message without returning control =
to
   the shell, which is done by "edit" to give an opportunity to tweak t=
he
   contents.

 * "git send-email" can be told with "--envelope-sender=3Dauto" to use =
the
   same address as "From:" address as the envelope sender address.

 * "git send-email" will issue a warning when it defaults to the
   --chain-reply-to behaviour without being told by the user and
   instructs to prepare for the change of the default in 1.7.0 release.

 * In "git submodule add <repository> <path>", <path> is now optional a=
nd
   inferred from <repository> the same way "git clone <repository>" doe=
s.

 * "git svn" learned to read SVN 1.5+ and SVK merge tickets.

 * "gitweb" can optionally render its "blame" output incrementally (thi=
s
   requires JavaScript on the client side).

 * Author names shown in gitweb output are links to search commits by t=
he
   author.

=46ixes since v1.6.5
------------------

All of the fixes in v1.6.5.X maintenance series are included in this
release, unless otherwise noted.

 * Enumeration of available merge strategies iterated over the list of
   commands in a wrong way, sometimes producing an incorrect result.
   Will backport by merging ed87465 (builtin-merge.c: call
   exclude_cmds() correctly., 2009-11-25).

 * "git format-patch revisions... -- path" issued an incorrect error
   message that suggested to use "--" on the command line when path
   does not exist in the current work tree (it is a separate matter if
   it makes sense to limit format-patch with pathspecs like that
   without using the --full-diff option).  Will backport by merging
   7e93d3b (format-patch: add test for parsing of "--", 2009-11-26).

 * "git shortlog" did not honor the "encoding" header embedded in the
   commit object like "git log" did.  Will backport by merging 79f7ca0
   (shortlog: respect commit encoding, 2009-11-25).

----------------------------------------------------------------

Changes since v1.6.6-rc0 are as follows:

Avery Pennarun (1):
      builtin-merge.c: call exclude_cmds() correctly.

Benjamin Kramer (1):
      Explicitly truncate bswap operand to uint32_t

Bert Wesarg (2):
      Give the hunk comment its own color
      get_ref_states: strdup entries and free util in stale list

Bj=C3=B6rn Gustavsson (11):
      Teach the --all option to 'git fetch'
      Teach the --multiple option to 'git fetch'
      Add the configuration option skipFetchAll
      Add missing test for 'git remote update --prune'
      Re-implement 'git remote update' using 'git fetch'
      Clarify and correct -z
      apply: apply works outside a repository
      apply: Format all options using back-quotes
      apply: Use the term "working tree" consistently
      Fix over-simplified documentation for 'git log -z'
      gitworkflows: Consistently back-quote git commands

Brian Gernhardt (1):
      t/gitweb-lib: Split HTTP response with non-GNU sed

Christian Couder (6):
      Documentation: add "Fighting regressions with git bisect" article
      replace: use a GIT_NO_REPLACE_OBJECTS env variable
      Documentation: fix typos and spelling in replace documentation
      Documentation: talk a little bit about GIT_NO_REPLACE_OBJECTS
      bisect: simplify calling visualizer using '--bisect' option
      Documentation: update descriptions of revision options related to=
 '--bisect'

David Aguilar (1):
      help: Do not unnecessarily look for a repository

David Soria Parra (1):
      Documentation: Document --branch option in git clone synopsis

Erick Mattos (1):
      commit -c/-C/--amend: reset timestamp and authorship to committer=
 with --reset-author

=46elipe Contreras (3):
      format-patch: fix parsing of "--" on the command line
      format-patch: add test for parsing of "--"
      send-email: automatic envelope sender

Horst H. von Brand (1):
      git-pull.sh: Fix call to git-merge for new command format

Jakub Narebski (10):
      gitweb: Add optional "time to generate page" info in footer
      gitweb: Incremental blame (using JavaScript)
      gitweb: Colorize 'blame_incremental' view during processing
      gitweb: Create links leading to 'blame_incremental' using JavaScr=
ipt
      gitweb: Minify gitweb.js if JSMIN is defined
      t/gitweb-lib.sh: Split gitweb output into headers and body
      gitweb: Document current snapshot rules via new tests
      gitweb.js: Harden setting blamed commit info in incremental blame
      gitweb: Make linking to actions requiring JavaScript a feature
      gitweb: Add link to other blame implementation in blame views

Jay Soffian (4):
      remote: refactor some logic into get_stale_heads()
      teach warn_dangling_symref to take a FILE argument
      builtin-fetch: add --prune option
      builtin-fetch: add --dry-run option

Jeff King (1):
      prune-packed: only show progress when stderr is a tty

Johannes Sixt (2):
      t4014-format-patch: do not assume 'test' is available as non-buil=
tin
      Add a notice that only certain functions can print color escape c=
odes

Jonathan Nieder (1):
      Makefile: do not clean arm directory

Junio C Hamano (19):
      mailinfo: -b option keeps [bracketed] strings that is not a [PATC=
H] marker
      Pretty-format: %[+-]x to tweak inter-item newlines
      read_revision_from_stdin(): use strbuf
      Teach --stdin option to "log" family
      setup_revisions(): do not call get_pathspec() too early
      Make --stdin option to "log" family read also pathspecs
      t9001: test --envelope-sender option of send-email
      Add trivial tests for --stdin option to log family
      Protect scripted Porcelains from GREP_OPTIONS insanity
      builtin-apply.c: pay attention to -p<n> when determining the name
      Remove dead code from "git am"
      emit_line(): don't emit an empty <SET><RESET> followed by a newli=
ne
      Update draft release notes to 1.6.6 before merging topics for -rc=
1
      git-merge: a deprecation notice of the ancient command line synta=
x
      Update draft release notes to 1.6.6 before -rc1
      Do not misidentify "git merge foo HEAD" as an old-style invocatio=
n
      merge: do not add standard message when message is given with -m =
option
      Prepare for 1.6.5.4
      Git 1.6.6-rc1

Mark Rada (2):
      gitweb: check given hash before trying to create snapshot
      gitweb: Smarter snapshot names

Martin Storsj=C3=B6 (3):
      Disable CURLOPT_NOBODY before enabling CURLOPT_PUT and CURLOPT_PO=
ST
      Refactor winsock initialization into a separate function
      Enable support for IPv6 on MinGW

Matthew Ogilvie (5):
      cvsserver doc: database generally can not be reproduced consisten=
tly
      config documentation: some configs are auto-set by git-init
      t2300: use documented technique to invoke git-sh-setup
      t3409 t4107 t7406 t9150: use dashless commands
      t/README: Document GIT_TEST_INSTALLED and GIT_TEST_EXEC_PATH

Matthieu Moy (4):
      merge-recursive: point the user to commit when file would be over=
written.
      user-manual: Document that "git merge" doesn't like uncommited ch=
anges.
      merge-recursive: make the error-message generation an extern func=
tion
      builtin-merge: show user-friendly error messages for fast-forward=
 too.

Michael J Gruber (1):
      Documentation: Fix a few i.e./e.g. mix-ups

Nanako Shiraishi (2):
      t1200: fix a timing dependent error
      prepare send-email for smoother change of --chain-reply-to defaul=
t

Nicolas Pitre (1):
      pack-objects: split implications of --all-progress from progress =
activation

Ramsay Allan Jones (1):
      git-count-objects: Fix a disk-space under-estimate on Cygwin

Ren=C3=A9 Scharfe (2):
      strbuf_add_wrapped_text(): skip over colour codes
      mergetool--lib: simplify guess_merge_tool()

Stephen Boyd (3):
      gitweb.js: fix null object exception in initials calculation
      instaweb: restart server if already running
      gitweb.js: fix padLeftStr() and its usage

Tay Ray Chuan (1):
      remote-curl.c: fix rpc_out()

Uwe Kleine-K=C3=B6nig (1):
      shortlog: respect commit encoding

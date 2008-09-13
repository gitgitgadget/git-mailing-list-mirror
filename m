From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0.2
Date: Fri, 12 Sep 2008 23:13:31 -0700
Message-ID: <7vy71winec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 08:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeOPH-0003BL-Dm
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 08:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYIMGNm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Sep 2008 02:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYIMGNm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 02:13:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYIMGNk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Sep 2008 02:13:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68586609F0;
	Sat, 13 Sep 2008 02:13:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25B2B609EA; Sat, 13 Sep 2008 02:13:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1AE41A3A-815B-11DD-91F3-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95793>

The latest maintenance release GIT 1.6.0.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided in:

  RPMS/$arch/git-*-1.6.0.2-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.0.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.0.1
--------------------

* Installation on platforms that needs .exe suffix to git-* programs we=
re
  broken in 1.6.0.1.

* Installation on filesystems without symbolic links support did not
  work well.

* In-tree documentations and test scripts now use "git foo" form to set=
 a
  better example, instead of the "git-foo" form (which is an acceptable
  form if you have "PATH=3D$(git --exec-path):$PATH" in your script)

* Many commands did not use the correct working tree location when used
  with GIT_WORK_TREE environment settings.

* Some systems needs to use compatibility fnmach and regex libraries
  independent from each other; the compat/ area has been reorganized to
  allow this.


* "git apply --unidiff-zero" incorrectly applied a -U0 patch that inser=
ts
  a new line before the second line.

* "git blame -c" did not exactly work like "git annotate" when range
  boundaries are involved.

* "git checkout file" when file is still unmerged checked out contents =
from
  a random high order stage, which was confusing.

* "git clone $there $here/" with extra trailing slashes after explicit
  local directory name $here did not work as expected.

* "git diff" on tracked contents with CRLF line endings did not drive "=
less"
  intelligently when showing added or removed lines.

* "git diff --dirstat -M" did not add changes in subdirectories up
  correctly for renamed paths.

* "git diff --cumulative" did not imply "--dirstat".

* "git for-each-ref refs/heads/" did not work as expected.

* "git gui" allowed users to feed patch without any context to be appli=
ed.

* "git gui" botched parsing "diff" output when a line that begins with =
two
  dashes and a space gets removed or a line that begins with two pluses
  and a space gets added.

* "git gui" translation updates and i18n fixes.

* "git index-pack" is more careful against disk corruption while comple=
ting
  a thin pack.

* "git log -i --grep=3Dpattern" did not ignore case; neither "git log -=
E
  --grep=3Dpattern" triggered extended regexp.

* "git log --pretty=3D"%ad" --date=3Dshort" did not use short format wh=
en
  showing the timestamp.

* "git log --author=3Dauthor" match incorrectly matched with the
  timestamp part of "author " line in commit objects.

* "git log -F --author=3Dauthor" did not work at all.

* Build procedure for "git shell" that used stub versions of some
  functions and globals was not understood by linkers on some platforms=
=2E

* "git stash" was fooled by a stat-dirty but otherwise unmodified paths
  and refused to work until the user refreshed the index.

* "git svn" was broken on Perl before 5.8 with recent fixes to reduce
  use of temporary files.

* "git verify-pack -v" did not work correctly when given more than one
  packfile.

Also contains many documentation updates.

----------------------------------------------------------------

Changes since v1.6.0.1 are as follows:

Alex Riesen (1):
      Fix use of hardlinks in "make install"

Alexander Gavrilov (1):
      git-gui: Fix string escaping in po2msg.sh

Alexandre Bourget (2):
      git-gui: Update french translation
      git-gui: update all remaining translations to French.

Andreas F=C3=A4rber (1):
      Makefile: always provide a fallback when hardlinks fail

Arjen Laarhoven (1):
      Use compatibility regex library for OSX/Darwin

Ask Bj=C3=B8rn Hansen (1):
      Document sendemail.envelopesender configuration

Bj=C3=B6rn Steinbrink (1):
      for-each-ref: Allow a trailing slash in the patterns

Clemens Buchacher (2):
      git gui: show diffs with a minimum of 1 context line
      clone: fix creation of explicitly named target directory

Gustaf Hendeby (1):
      Document clarification: gitmodules, gitattributes

Heikki Orsila (3):
      Start conforming code to "git subcmd" style
      Improve documentation for --dirstat diff option
      Start conforming code to "git subcmd" style part 2

Jeff King (4):
      Fix "git log -i --grep"
      pretty=3Dformat: respect date format options
      checkout: fix message when leaving detached HEAD
      Use compatibility regex library also on FreeBSD

Johan Herland (1):
      Bring local clone's origin URL in line with that of a remote clon=
e

Johannes Sixt (1):
      Use compatibility regex library also on AIX

Jonas Fonseca (1):
      Fix passwd(5) ref and reflect that commit doens't use commit-tree

Junio C Hamano (17):
      ctype.c: protect tiny C preprocessor constants
      shell: do not play duplicated definition games to shrink the exec=
utable
      Fix example in git-name-rev documentation
      git-apply: Loosen "match_beginning" logic
      checkout: do not check out unmerged higher stages randomly
      gitattributes: -crlf is not binary
      diff: Help "less" hide ^M from the output
      'git foo' program identifies itself without dash in die() message=
s
      Start 1.6.0.2 maintenance cycle
      diff --cumulative is a sub-option of --dirstat
      log --author/--committer: really match only with name part
      "blame -c" should be compatible with "annotate"
      Mention the fact that 'git annotate' is only for backward compati=
bility.
      stash: refresh the index before deciding if the work tree is dirt=
y
      Update draft release notes for 1.6.0.2
      Update draft release notes for 1.6.0.2
      GIT 1.6.0.2

Linus Torvalds (2):
      index-pack: be careful after fixing up the header/footer
      Fix '--dirstat' with cross-directory renaming

Marcus Griep (2):
      Git.pm: Use File::Temp->tempfile instead of ->new
      git-svn: Fixes my() parameter list syntax error in pre-5.8 Perl

Miklos Vajna (2):
      Makefile: add merge_recursive.h to LIB_H
      t7501: always use test_cmp instead of diff

Nanako Shiraishi (4):
      tests: use "git xyzzy" form (t0000 - t3599)
      tests: use "git xyzzy" form (t3600 - t6999)
      tests: use "git xyzzy" form (t7000 - t7199)
      tests: use "git xyzzy" form (t7200 - t9001)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
      index-pack: setup git repository
      diff*: fix worktree setup
      grep: fix worktree setup
      read-tree: setup worktree if merge is required
      update-index: fix worktree setup
      setup_git_directory(): fix move to worktree toplevel directory

Nicolas Pitre (7):
      discard revindex data when pack list changes
      pack-objects: improve returned information from write_one()
      improve reliability of fixup_pack_header_footer()
      pack-objects: use fixup_pack_header_footer()'s validation mode
      index-pack: use fixup_pack_header_footer()'s validation mode
      fixup_pack_header_footer(): use nicely aligned buffer sizes
      improve handling of sideband message display

Paolo Bonzini (1):
      make git-shell paranoid about closed stdin/stdout/stderr

Paolo Ciarrocchi (1):
      tutorial: gentler illustration of Alice/Bob workflow using gitk

Petr Baudis (1):
      bash completion: Hide more plumbing commands

Ralf Wildenhues (1):
      Fix some manual typos.

Ramsay Allan Jones (2):
      Fix a warning (on cygwin) to allow -Werror
      Suppress some bash redirection error messages

SZEDER G=C3=A1bor (3):
      Documentation: fix reference to a for-each-ref option
      Documentation: fix disappeared lines in 'git stash' manpage
      Documentation: minor cleanup in a use case in 'git stash' manual

Shawn O. Pearce (2):
      pack-objects: Allow missing base objects when creating thin packs
      git-gui: Fix diff parsing for lines starting with "--" or "++"

Teemu Likonen (1):
      config.txt: Add missing colons after option name

Yann Dirson (1):
      Document gitk --argscmd flag.

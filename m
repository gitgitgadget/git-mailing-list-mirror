From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.4-rc2
Date: Wed, 22 Jul 2009 23:40:01 -0700
Message-ID: <7vd47r298e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 08:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTryp-000434-0e
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbZGWGkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 02:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZGWGkM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:40:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZGWGkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:40:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85406EA45;
	Thu, 23 Jul 2009 02:40:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6450BEA43; Thu, 23 Jul 2009
 02:40:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA8DB274-7753-11DE-905F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123849>

A release candidate GIT 1.6.4-rc2 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.4.rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.4.rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.4.rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.4.rc2-1.fc9.$arch.rpm	(RPM)

The changes since -rc1 are all small fixes and documentation updates; w=
e
are in a very good shape to expect 1.6.4 final by the end of the month.

GIT v1.6.4 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=3D=
108007

for more details on the reason why this change is needed and the
transition plan.

=46or a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose wh=
at
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.


Updates since v1.6.3
--------------------

(subsystems)

 * gitweb Perl style clean-up.

 * git-svn updates, including a new --authors-prog option to map author
   names by invoking an external program, 'git svn reset' to unwind
   'git svn fetch', support for more than one branches, etc.

(portability)

 * We feed iconv with "UTF-8" instead of "utf8"; the former is
   understood more widely.  Similarly updated test scripts to use
   encoding names more widely understood (e.g. use "ISO8850-1" instead
   of "ISO-8859-1").

 * Various portability fixes/workarounds for different vintages of
   SunOS, IRIX, and Windows.

 * Git-over-ssh transport on Windows supports PuTTY plink and TortoiseP=
link.

(performance)

 * Many repeated use of lstat() are optimized out in "checkout" codepat=
h.

 * git-status (and underlying git-diff-index --cached) are optimized
   to take advantage of cache-tree information in the index.

(usability, bells and whistles)

 * "git add --edit" lets users edit the whole patch text to fine-tune w=
hat
   is added to the index.

 * "git am" accepts StGIT series file as its input.

 * "git bisect skip" skips to a more randomly chosen place in the hope
   to avoid testing a commit that is too close to a commit that is
   already known to be untestable.

 * "git cvsexportcommit" learned -k option to stop CVS keywords expansi=
on

 * "git grep" learned -p option to show the location of the match using=
 the
   same context hunk marker "git diff" uses.

 * https transport can optionally be told that the used client
   certificate is password protected, in which case it asks the
   password only once.

 * "git imap-send" is IPv6 aware.

 * "git log --graph" draws graphs more compactly by using horizonal lin=
es
   when able.

 * "git log --decorate" shows shorter refnames by stripping well-known
   refs/* prefix.

 * "git push $name" honors remote.$name.pushurl if present before
   using remote.$name.url.  In other words, the URL used for fetching
   and pushing can be different.

 * "git send-email" understands quoted aliases in .mailrc files (might
   have to be backported to 1.6.3.X).

 * "git send-email" can fetch the sender address from the configuration
   variable "sendmail.from" (and "sendmail.<identity>.from").

 * "git show-branch" can color its output.

 * "add" and "update" subcommands to "git submodule" learned --referenc=
e
   option to use local clone with references.

 * "git submodule update" learned --rebase option to update checked
   out submodules by rebasing the local changes.

 * "gitweb" can optionally use gravatar to adorn author/committer names=
=2E

(developers)

 * A major part of the "git bisect" wrapper has moved to C.

=46ixes since v1.6.3
------------------

All of the fixes in v1.6.3.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.3.X series.

 * "git diff-tree -r -t" used to omit new or removed directories from
   the output.  df533f3 (diff-tree -r -t: include added/removed
   directories in the output, 2009-06-13) may need to be cherry-picked
   to backport this fix.

 * The way Git.pm sets up a Repository object was not friendly to calle=
rs
   that chdir around.  It now internally records the repository locatio=
n
   as an absolute path when autodetected.

---
exec >/var/tmp/1
echo O=3D$(git describe master)
O=3Dv1.6.4-rc1-7-gbba0fd2
git shortlog --no-merges $O..master ^maint


----------------------------------------------------------------

Changes since v1.6.4-rc1 are as follows:

Brandon Casey (4):
      refs.c: release file descriptor on error return
      sha1_name.c: avoid unnecessary strbuf_release
      configure.ac: rework/fix the NEEDS_RESOLV and NEEDS_LIBGEN tests
      configure.ac: properly unset NEEDS_SSL_WITH_CRYPTO when sha1 func=
 is missing

Eric Wong (2):
      git svn: rename tests that had conflicting numbers
      git svn: fix reparenting when ugly http(s) URLs are used

Junio C Hamano (5):
      checkout -f: deal with a D/F conflict entry correctly
      push: do not give big warning when no preference is configured
      Updates to draft release notes to 1.6.4
      combine-diff.c: fix performance problem when folding common delet=
ed lines
      diff --cc: a lost line at the beginning of the file is shown inco=
rrectly

Martin Koegler (1):
      git stash: modernize use of "dashed" git-XXX calls

Michael J Gruber (1):
      t4202-log.sh: Test git log --no-walk sort order

Mike Ralphson (1):
      cvsexportcommit: reorder tests to quiet intermittent failure

Pierre Habouzit (4):
      janitor: use NULL and not 0 for pointers.
      refactor: use bitsizeof() instead of 8 * sizeof()
      janitor: add DIV_ROUND_UP and use it.
      janitor: useless checks before free

SZEDER G=C3=A1bor (1):
      Trailing whitespace and no newline fix

Yann Dirson (2):
      List send-email config options in config.txt.
      Improve doc for format-patch threading options.

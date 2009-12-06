From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.5.5
Date: Sun, 06 Dec 2009 00:06:32 -0800
Message-ID: <7vtyw4il13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 09:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHC8o-0002jH-SC
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbZLFIGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 03:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbZLFIGj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:06:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbZLFIGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 03:06:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3EDBA4097;
	Sun,  6 Dec 2009 03:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ZO5W1BAdxWPgWQ8ENHbDs1bz6
	rk=; b=q0eAZURVwWEtDqBKGoIocpCTqUAV4inXf5adSqpSxkNTuegMAyMJ1Vn5O
	yuB0DPBOlW7OPJJIm7zGdsitD3RImUDS4YNeJAiHLxPdjLyugbjUcishqTv2er6T
	jIhmt1SPD8DFXPWo3B2R1H0EiNuNaSyIAUF7LXZ+nTeY6vQ7sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=l7KTuIK2KjrrYCHyL7I
	TAOMZxvzw940n+rOlgXgQcU31PD3qc3Pg1xXUdZGj2v+nNtkdyJxBQUTppevsUEj
	M9Vrv13Mb+DAsr2ka9YyE3Z6dRlNcWOxigMcPGpuOckUQgTG4fHtir9wdmJYonCI
	T2aqocxN6PddVa64gblkimKo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4FA0A4096;
	Sun,  6 Dec 2009 03:06:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BEDEFA4095; Sun,  6 Dec 2009
 03:06:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4849BB8E-E23E-11DE-8064-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134650>

The latest maintenance release Git 1.6.5.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.5.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.5.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.5-1.fc11.$arch.rpm	(RPM)

This is primarily to help other distros with older xmlto to partially
revert the change in 1.6.5.4 to help distros with newer docbook
stylesheets, but I also merged some fixes that have already been cookin=
g
and graduated to 'master' as well.


Git v1.6.5.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.5.4
--------------------

 * Manual pages can be formatted with older xmlto again.

 * GREP_OPTIONS exported from user's environment could have broken
   our scripted commands.

 * In configuration files, a few variables that name paths can begin wi=
th
   ~/ and ~username/ and they are expanded as expected.  This is not a
   bugfix but 1.6.6 will have this and without backporting users cannot
   easily use the same ~/.gitconfig across versions.

 * "git diff -B -M" did the same computation to hash lines of contents
   twice, and held onto memory after it has used the data in it
   unnecessarily before it freed.

 * "git diff -B" and "git diff --dirstat" was not counting newly added
   contents correctly.

 * "git format-patch revisions... -- path" issued an incorrect error
   message that suggested to use "--" on the command line when path
   does not exist in the current work tree (it is a separate matter if
   it makes sense to limit format-patch with pathspecs like that
   without using the --full-diff option).

 * "git grep -F -i StRiNg" did not work as expected.

 * Enumeration of available merge strategies iterated over the list of
   commands in a wrong way, sometimes producing an incorrect result.

 * "git shortlog" did not honor the "encoding" header embedded in the
   commit object like "git log" did.

 * Reading progress messages that come from the remote side while runni=
ng
   "git pull" is given precedence over reading the actual pack data to
   prevent garbled progress message on the user's terminal.

 * "git rebase" got confused when the log message began with certain
   strings that looked like Subject:, Date: or From: header.

 * "git reset" accidentally run in .git/ directory checked out the
   work tree contents in there.

Other minor documentation updates are included.

----------------------------------------------------------------

Changes since v1.6.5.4 are as follows:

Avery Pennarun (1):
      builtin-merge.c: call exclude_cmds() correctly.

Brandon Casey (1):
      t4201: use ISO8859-1 rather than ISO-8859-1

Brian Collins (1):
      grep: Allow case insensitive search of fixed-strings

=46elipe Contreras (2):
      format-patch: fix parsing of "--" on the command line
      format-patch: add test for parsing of "--"

Jeff King (4):
      diffcore-break: free filespec data as we go
      diffcore-break: save cnt_data for other phases
      rerere: don't segfault on failure to open rr-cache
      reset: improve worktree safety valves

Junio C Hamano (7):
      diffcore-rename: reduce memory footprint by freeing blob data ear=
ly
      Documentation: avoid xmlto input error
      Protect scripted Porcelains from GREP_OPTIONS insanity
      Remove dead code from "git am"
      Documentation: xmlto 0.0.18 does not know --stringparam
      Prepare for 1.6.5.5
      Git 1.6.5.5

Linus Torvalds (1):
      Fix diff -B/--dirstat miscounting of newly added contents

Lukas Sandstr=C3=B6m (1):
      git am/mailinfo: Don't look at in-body headers when rebasing

Matthew Ogilvie (1):
      core.autocrlf documentation: mention the crlf attribute

Matthieu Moy (4):
      Expand ~ and ~user in core.excludesfile, commit.template
      expand_user_path: expand ~ to $HOME, not to the actual homedir.
      merge-recursive: point the user to commit when file would be over=
written.
      user-manual: Document that "git merge" doesn't like uncommited ch=
anges.

Nicolas Pitre (1):
      give priority to progress messages

Philippe Bruhat (1):
      Make sure $PERL_PATH is defined when the test suite is run.

Raman Gupta (1):
      Add branch management for releases to gitworkflows

Ramsay Allan Jones (3):
      Makefile: merge two Cygwin configuration sections into one
      t9700-perl-git.sh: Fix a test failure on Cygwin
      git-count-objects: Fix a disk-space under-estimate on Cygwin

Ren=C3=A9 Scharfe (2):
      mergetool--lib: simplify guess_merge_tool()
      archive: clarify description of path parameter

Tim Henigan (2):
      Update 'git remote update' usage string to match man page.
      git remote: Separate usage strings for subcommands

Todd Zullinger (1):
      Documentation: Avoid use of xmlto --stringparam

Uwe Kleine-K=C3=B6nig (1):
      shortlog: respect commit encoding

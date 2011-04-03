From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.4.3
Date: Sun, 03 Apr 2011 01:36:24 -0700
Message-ID: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 10:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Io3-00027F-SF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 10:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab1DCIgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 04:36:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1DCIgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 04:36:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 111672F17;
	Sun,  3 Apr 2011 04:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IFPbyABZp7uutYdPwnc4x6Cpa
	J8=; b=N26FlUCW4m/4HC9b0bRPq7hS0zwhV2j+ySqPXy2AOc5eNS+f7ZAiQejbB
	s11ylZg2n9ndxKyjTKqlc4HWoVZwSa6hX6i1F4JsmcSGzIDcS9rjGnGOflSO0gE5
	LDiri/o1sgNfXShDfcDpu+h/yWcpA7nw9NiWwiyvaUjiMOWo2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=V1yAuxkll+2EYhFJv33
	0dHXf06++/ZWTPyTRqgY0aloQOyTD7JKiOH6DLDj77zaJOpwZzndmh/sSOX+sdav
	e6XpJqxMgFxpK3jINqyyjzycWpYPNkN7xevG/qFpYJn3B180gm5ka6OQfyYLldyC
	GJFobrD+S65Ebkhgoxpp6ef4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D26232F16;
	Sun,  3 Apr 2011 04:38:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 791EB2F15; Sun,  3 Apr 2011
 04:38:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDF4F932-5DCD-11E0-8A5B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170685>

The latest maintenance release Git 1.7.4.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.4.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.4.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.4.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.4.3-1.fc13.$arch.rpm	(RPM)

Git v1.7.4.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.4.2
--------------------

 * "git apply" used to confuse lines updated by previous hunks as lines
   that existed before when applying a hunk, contributing misapplicatio=
n
   of patches with offsets.

 * "git branch --track" (and "git checkout --track --branch") used to
   allow setting up a random non-branch that does not make sense to fol=
low
   as the "upstream".  The command correctly diagnoses it as an error.

 * "git checkout $other_branch" silently removed untracked symbolic lin=
ks
   in the working tree that are in the way in order to check out paths
   under it from the named branch.

 * "git cvsimport" did not bail out immediately when the cvs server can=
not
   be reached, spewing unnecessary error messages that complain about t=
he
   server response that it never got.

 * "git diff --quiet" did not work very well with the "--diff-filter"
   option.

 * "git grep -n" lacked a long-hand synonym --line-number.

 * "git stash apply" reported the result of its operation by running
   "git status" from the top-level of the working tree; it should (and
   now does) run it from the user's working directory.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.4.2 are as follows:

Alex Riesen (1):
      HOME must be set before calling git-init when creating test repos=
itories

Carlos Mart=C3=ADn Nieto (1):
      Documentation/config.txt: make truth value of numbers more explic=
it

Clemens Buchacher (1):
      do not overwrite untracked symlinks

=46abian Keil (1):
      git-cvsimport.perl: Bail out right away when reading from the ser=
ver fails

Jeff King (1):
      docs: fix filter-branch subdir example for exotic repo names

Joe Ratterman (1):
      grep: Add the option '--line-number'

Johan Herland (1):
      branch/checkout --track: Ensure that upstream branch is indeed a =
branch

Johannes Sixt (3):
      Demonstrate breakage: checkout overwrites untracked symlink with =
directory
      stash: fix incorrect quoting in cleanup of temporary files
      stash: copy the index using --index-output instead of cp -p

Junio C Hamano (9):
      checkout: fix bug with ambiguous refs
      apply: do not patch lines that were already patched
      apply -v: show offset count when patch did not apply exactly
      diff --quiet: disable optimization when --diff-filter=3DX is used
      doc: technical details about the index file format
      t8001: check the exit status of the command being tested
      parse-remote: typofix
      Doc: mention --delta-base-offset is the default for Porcelain com=
mands
      Git 1.7.4.3

Maxin john (1):
      contrib/thunderbird-patch-inline: do not require bash to run the =
script

Michael J Gruber (2):
      git-bisect.txt: streamline run presentation
      git-bisect.txt: example for bisecting with hot-fix

Michael Witten (3):
      git tag documentation grammar fixes and readability updates
      Typos: t/README
      strbuf.h: remove a tad stale docs-in-comment and reference api-do=
c instead

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      doc: technical details about the index file format

Piotr Krukowiecki (2):
      git stash: show status relative to current directory
      Add test: git stash shows status relative to current dir

Stephen Boyd (2):
      parse-remote: replace unnecessary sed invocation
      git-pack-objects.txt: fix grammatical errors

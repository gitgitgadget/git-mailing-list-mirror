From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1.5
Date: Fri, 01 Mar 2013 14:16:48 -0800
Message-ID: <7v1ubyg3zj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 01 23:17:25 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UBYGa-0005Hm-IN
	for glk-linux-kernel-3@plane.gmane.org; Fri, 01 Mar 2013 23:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab3CAWQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 1 Mar 2013 17:16:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3CAWQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Mar 2013 17:16:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A6DAB2D;
	Fri,  1 Mar 2013 17:16:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ndj12yzXz2W6hcYXv6SDPGcXf
	Wg=; b=F5YTtU2DK5rB/wpIML44QL63mzxK+SR2Zol1ZHV6CYdrhHaR4t+pkTTef
	pWEddbv/x4flN8mMpgtO4/F+SayBZ0cWdyyNrZ11Rz3QPWdMnixsIPIdAtkolA4E
	vUZrYShk+uXWDlMlqvAZENoD81sERl9JlWdxR2RtOqYjVX3y+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=VSi9vyYwgISm3mf2b9m
	gkMGtgjEfNG38qibE8Dk6Sp9i31ze4JsAPxQsHkfWHL0IuzKfDFobB8Nwjss+tTR
	ieZ5F8UrLosgh1OSsMriB0fUsEvx2mqkjoOTIZHmQmtRl8s9oBPJIatX3vHhhPsf
	9ij0YrogppzLkj4pbkZeqYJ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BA66AB2C;
	Fri,  1 Mar 2013 17:16:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4580DAB27; Fri,  1 Mar 2013
 17:16:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6DD6136-82BD-11E2-B8EF-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217297>

The latest maintenance release Git v1.8.1.5 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

3349a15de7c5501715bda9b68301d0406272f8e0  git-1.8.1.5.tar.gz
84d832fc70a053e97ce336c4a0af0371461e469f  git-htmldocs-1.8.1.5.tar.gz
7f211a2f8fe36180373a20b32eb930018883bfd1  git-manpages-1.8.1.5.tar.gz

Also the following public repositories all have a copy of the v1.8.1.5
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.8.1.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

=46ixes since v1.8.1.4
--------------------

 * Given a string with a multi-byte character that begins with '-' on
   the command line where an option is expected, the option parser
   used just one byte of the unknown letter when reporting an error.

 * In v1.8.1, the attribute parser was tightened too restrictive to
   error out upon seeing an entry that begins with an ! (exclamation),
   which may confuse users to expect a "negative match", which does
   not exist.  This has been demoted to a warning; such an entry is
   still ignored.

 * "git apply --summary" has been taught to make sure the similarity
   value shown in its output is sensible, even when the input had a
   bogus value.

 * "git clean" showed what it was going to do, but sometimes ended
   up finding that it was not allowed to do so, which resulted in a
   confusing output (e.g. after saying that it will remove an
   untracked directory, it found an embedded git repository there
   which it is not allowed to remove).  It now performs the actions
   and then reports the outcome more faithfully.

 * "git clone" used to allow --bare and --separate-git-dir=3D$there
   options at the same time, which was nonsensical.

 * "git cvsimport" mishandled timestamps at DST boundary.

 * We used to have an arbitrary 32 limit for combined diff input,
   resulting in incorrect number of leading colons shown when showing
   the "--raw --cc" output.

 * The smart HTTP clients forgot to verify the content-type that comes
   back from the server side to make sure that the request is being
   handled properly.

 * "git help remote-helpers" failed to find the documentation.

 * "gitweb" pages served over HTTPS, when configured to show picon or
   gravatar, referred to these external resources to be fetched via
   HTTP, resulting in mixed contents warning in browsers.

Also contains various documentation fixes.

----------------------------------------------------------------

Changes since v1.8.1.4 are as follows:

Andrej E Baranov (1):
      gitweb: refer to picon/gravatar images over the same scheme

Andrew Wong (1):
      Documentation/githooks: Fix linkgit

Asheesh Laroia (1):
      git-mergetool: print filename when it contains %

Ben Walton (3):
      Move Git::SVN::get_tz to Git::get_tz_offset
      perl/Git.pm: fix get_tz_offset to properly handle DST boundary ca=
ses
      cvsimport: format commit timestamp ourselves without using strfti=
me

Brad King (1):
      Documentation/submodule: Add --force to update synopsis

David Aguilar (3):
      mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
      difftool--helper: fix printf usage
      p4merge: fix printf usage

Erik Faye-Lund (1):
      parse-options: report uncorrupted multi-byte options

Greg Price (1):
      Documentation: "advice" is uncountable

Jeff King (2):
      http_request: reset "type" strbuf before adding
      Makefile: avoid infinite loop on configure.ac change

Jiang Xin (1):
      Add utf8_fprintf helper that returns correct number of columns

John Keeping (3):
      Rename {git- =3D> git}remote-helpers.txt
      builtin/apply: tighten (dis)similarity index parsing
      t4038: add tests for "diff --cc --raw <trees>"

Junio C Hamano (7):
      doc: mention tracking for pull.default
      combine-diff: lift 32-way limit of combined diff
      t5551: fix expected error output
      user-manual: typofix (ofthe->of the)
      Prepare for 1.8.1.5
      Update draft release notes to 1.8.1.5
      Git 1.8.1.5

Matthieu Moy (1):
      git.txt: update description of the configuration mechanism

Michael J Gruber (1):
      git-bisect.txt: clarify that reset quits bisect

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      clone: forbid --bare --separate-git-dir <dir>

Shawn O. Pearce (1):
      Verify Content-Type from smart HTTP servers

Thomas Rast (1):
      Make !pattern in .gitattributes non-fatal

W. Trevor King (4):
      user-manual: Update for receive.denyCurrentBranch=3Drefuse
      user-manual: Reorganize the reroll sections, adding 'git rebase -=
i'
      user-manual: Use request-pull to generate "please pull" text
      user-manual: Flesh out uncommitted changes and submodule updates

Zoltan Klinger (1):
      git-clean: Display more accurate delete messages

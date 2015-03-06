From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.2
Date: Fri, 06 Mar 2015 15:11:11 -0800
Message-ID: <xmqqegp1wusu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Mar 07 00:49:55 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YU20A-0004ou-Ms
	for glk-linux-kernel-3@plane.gmane.org; Sat, 07 Mar 2015 00:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbbCFXtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 6 Mar 2015 18:49:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932228AbbCFXtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Mar 2015 18:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E6C3FB5A;
	Fri,  6 Mar 2015 18:49:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=l4lqXnrOUwfpvvkU9xT/5fa6P
	0o=; b=WBSnPI0j/bDUeO2WQTLiqy85PNFV6uK2mcsUVvYWZ+W9nlcaP/LNMgZrd
	aSWC5zvGuMD3lI9RP7wuJqEJTBDREo9AyvSs1pLuWi9yqSQwRh88t4oDmhInWAw+
	q45rd3y9+UDR6iIdW8TKHKz5tyEroO/o9BYaW1jqJnlUA5W0RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=nwczTkOhFEv8qVzmwHj
	COdIOZbQSbyGEEPyrD0suR3JzGTO8ST3qPHxRFHiA7EWsABLLKv8KiiF8WyfxFIg
	m/u8OP4b8d/X3IsoBF594uDLehyBgaolhY2T7LimOYjHvP2C4NC5tfYRWWkFt/Eu
	0ArkvaGf9LoUNVgXaO3IT5xg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDD1A3FB59;
	Fri,  6 Mar 2015 18:49:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EE143FB58;
	Fri,  6 Mar 2015 18:49:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73D000D8-C45B-11E4-93D3-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264975>

The latest maintenance release Git v2.3.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.3.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.1
------------------

 * "update-index --refresh" used to leak when an entry cannot be
   refreshed for whatever reason.

 * "git fast-import" used to crash when it could not close and
   conclude the resulting packfile cleanly.

 * "git blame" died, trying to free an uninitialized piece of memory.

 * "git merge-file" did not work correctly in a subdirectory.

 * "git submodule add" failed to squash "path/to/././submodule" to
   "path/to/submodule".

 * In v2.2.0, we broke "git prune" that runs in a repository that
   borrows from an alternate object store.

 * Certain older vintages of cURL give irregular output from
   "curl-config --vernum", which confused our build system.

 * An earlier workaround to squelch unhelpful deprecation warnings
   from the complier on Mac OSX unnecessarily set minimum required
   version of the OS, which the user might want to raise (or lower)
   for other reasons.

 * Longstanding configuration variable naming rules has been added to
   the documentation.

 * The credential helper for Windows (in contrib/) used to mishandle
   a user name with an at-sign in it.

 * Older GnuPG implementations may not correctly import the keyring
   material we prepare for the tests to use.

 * Clarify in the documentation that "remote.<nick>.pushURL" and
   "remote.<nick>.URL" are there to name the same repository accessed
   via different transports, not two separate repositories.

 * The pack bitmap support did not build with older versions of GCC.

 * Reading configuration from a blob object, when it ends with a lone
   CR, use to confuse the configuration parser.

 * We didn't format an integer that wouldn't fit in "int" but in
   "uintmax_t" correctly.

 * "git push --signed" gave an incorrectly worded error message when
   the other side did not support the capability.

 * "git fetch" over a remote-helper that cannot respond to "list"
   command could not fetch from a symbolic reference e.g. HEAD.

 * The insn sheet "git rebase -i" creates did not fully honor
   core.abbrev settings.

 * The tests that wanted to see that file becomes unreadable after
   running "chmod a-r file", and the tests that wanted to make sure it
   is not run as root, we used "can we write into the / directory?" as
   a cheap substitute, but on some platforms that is not a good
   heuristics.  The tests and their prerequisites have been updated to
   check what they really require.

 * The configuration variable 'mailinfo.scissors' was hard to
   discover in the documentation.

 * Correct a breakage to git-svn around v2.2 era that triggers
   premature closing of FileHandle.

 * Even though we officially haven't dropped Perl 5.8 support, the
   Getopt::Long package that came with it does not support "--no-"
   prefix to negate a boolean option; manually add support to help
   people with older Getopt::Long package.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v2.3.1 are as follows:

Aleksander Boruch-Gruszecki (1):
      merge-file: correctly open files when in a subdir

Aleksey Vasenev (1):
      wincred: fix get credential if username has "@"

Alexander Kuleshov (1):
      Git.pm: two minor typo fixes

Eric Sunshine (1):
      builtin/blame: destroy initialized commit_info only

Jeff King (8):
      t/lib-httpd: switch SANITY check for NOT_ROOT
      t/lib-gpg: include separate public keys in keyring.gpg
      t/lib-gpg: sanity-check that we can actually sign
      config: do not ungetc EOF
      decimal_width: avoid integer overflow
      config_buf_ungetc: warn when pushing back a random character
      for_each_loose_file_in_objdir: take an optional strbuf path
      fast-import: avoid running end_packfile recursively

Jonathon Mah (1):
      sha1_file: fix iterating loose alternate objects

Junio C Hamano (7):
      tests: correct misuses of POSIXPERM
      config.txt: clarify that add.ignore-errors is deprecated
      config.txt: mark deprecated variables more prominently
      Documentation/git-remote.txt: stress that set-url is not for tria=
ngular
      CodingGuidelines: describe naming rules for configuration variabl=
es
      Prepare for 2.3.2
      Git 2.3.2

Kirill A. Shutemov (1):
      rebase -i: use full object name internally throughout the script

Kyle J. McKay (3):
      git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
      git-send-email.perl: support no- prefix with older GetOptions
      Git::SVN::*: avoid premature FileHandle closure

Matthieu Moy (2):
      Documentation/config.txt: document mailinfo.scissors
      Documentation/git-am.txt: mention mailinfo.scissors config variab=
le

Mike Hommey (2):
      transport-helper: do not request symbolic refs to remote helpers
      transport-helper: fix typo in error message when --signed is not =
supported

Patrick Steinhardt (1):
      git-submodule.sh: fix '/././' path normalization

Ramsay Allan Jones (1):
      git-compat-util.h: remove redundant code

Ren=C3=A9 Scharfe (4):
      connect: use strcmp() for string comparison
      for-each-ref: use skip_prefix() to avoid duplicate string compari=
son
      pretty: use starts_with() to check for a prefix
      sha1_name: use strlcpy() to copy strings

Ryuichi Kokubo (1):
      git-svn: fix localtime=3Dtrue on non-glibc environments

Stefan Beller (2):
      hex.c: reduce memory footprint of sha1_to_hex static buffers
      read-cache.c: free cache entry when refreshing fails

Tom G. Christensen (2):
      Makefile: handle broken curl version number in version check
      ewah: fix building with gcc < 3.4.0

Torsten B=C3=B6gershausen (1):
      test-lib.sh: set prerequisite SANITY by testing what we really ne=
ed

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      do not include the same header twice

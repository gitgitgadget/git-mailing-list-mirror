From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [ANNOUNCE] Git v1.8.4.1
Date: Fri, 27 Sep 2013 11:52:00 -0700
Message-ID: <20130927185200.GL9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Sep 27 20:52:13 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VPd9A-0005vy-It
	for glk-linux-kernel-3@plane.gmane.org; Fri, 27 Sep 2013 20:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab3I0SwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 27 Sep 2013 14:52:08 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39597 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab3I0SwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Sep 2013 14:52:06 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so2976408pdi.14
        for <multiple recipients>; Fri, 27 Sep 2013 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Pj7ggq5G2JoL3ahHNRqAGn9G3TNbjbXriXQR2S05zqQ=;
        b=czdoIcfgMenV1530vy2zzcNaHLpKvlY6Cr2p/nXVzoT8YU9pfF925YzdtpXeCw7Wss
         x6EJR4OtegMJq7yoFUbtx1r8mtald48fCJdgxs47wSt74R7HWudCOLS9gfZSFGYrnAul
         t1mlM26iWINkEeE8FI4kAaz2TrR+u0XkyS7/6CsbhhYn8jBVonh5jDFCdn3yg55RvmzE
         UeY0EODRXT3mjRNc0qCiqHkJYJ1y/YNWPSCASwybcSxtWJNqx7noIKiY+kELW0/fZXVD
         8lpZYI47MQEqnh4IQq/bovCwTsHISw4Oviml0AQ8aFZ8m6tqlnHoshkW4kAqXNfl/wRN
         eLtg==
X-Received: by 10.66.158.72 with SMTP id ws8mr13343767pab.39.1380307924704;
        Fri, 27 Sep 2013 11:52:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dw3sm10360221pbc.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 11:52:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235472>

The latest maintenance release Git v1.8.4.1 is now available.

The release tarballs are found at:

    http://alioth.debian.org/~jrnieder-guest/git/

and their SHA-1 checksums are:

49004a8dfcbb7c0848147737d9877fd7313a42ec  git-1.8.4.1.tar.gz
1f0e5c5934ec333b5630a8c93a0fb0b1895dfcb8  git-htmldocs-1.8.4.1.tar.gz
dc0f9de1cacc8912f131b67dc5a19a96768ecc95  git-manpages-1.8.4.1.tar.gz

The following public repositories all have a copy of the v1.8.4.1
tag and the maint branch that the tag points at:

  url =3D https://googlers.googlesource.com/jrn/git
  url =3D git://repo.or.cz/git/jrn.git
  url =3D git://gitorious.org/git/jrn.git
  url =3D https://github.com/jrn/git

Git v1.8.4.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.8.4
------------------

 * Some old versions of bash do not grok some constructs like
   'printf -v varname' which the prompt and completion code started
   to use recently.  The completion and prompt scripts have been
   adjusted to work better with these old versions of bash.

 * In FreeBSD's and NetBSD's "sh", a return in a dot script in a
   function returns from the function, not only in the dot script,
   breaking "git rebase" on these platforms (regression introduced
   in 1.8.4-rc1).

 * "git rebase -i" and other scripted commands were feeding a
   random, data dependant error message to 'echo' and expecting it
   to come out literally.

 * Setting the "submodule.<name>.path" variable to the empty
   "true" caused the configuration parser to segfault.

 * Output from "git log --full-diff -- <pathspec>" looked strange
   because comparison was done with the previous ancestor that
   touched the specified <pathspec>, causing the patches for paths
   outside the pathspec to show more than the single commit has
   changed.

 * The auto-tag-following code in "git fetch" tries to reuse the
   same transport twice when the serving end does not cooperate and
   does not give tags that point to commits that are asked for as
   part of the primary transfer.  Unfortunately, Git-aware transport
   helper interface is not designed to be used more than once, hence
   this did not work over smart-http transfer.  Fixed.

 * Send a large request to read(2)/write(2) as a smaller but still
   reasonably large chunks, which would improve the latency when the
   operation needs to be killed and incidentally works around broken
   64-bit systems that cannot take a 2GB write or read in one go.

 * A ".mailmap" file that ends with an incomplete line, when read
   from a blob, was not handled properly.

 * The recent "short-cut clone connectivity check" topic broke a
   shallow repository when a fetch operation tries to auto-follow
   tags.

 * When send-email comes up with an error message to die with upon
   failure to start an SSL session, it tried to read the error
   string from a wrong place.

 * A call to xread() was used without a loop to cope with short
   read in the codepath to stream large blobs to a pack.

 * On platforms with fgetc() and friends defined as macros, the
   configuration parser did not compile.

 * New versions of MediaWiki introduced a new API for returning
   more than 500 results in response to a query, which would cause
   the MediaWiki remote helper to go into an infinite loop.

 * Subversion's serf access method (the only one available in
   Subversion 1.8) for http and https URLs in skelta mode tells its
   caller to open multiple files at a time, which made "git svn
   fetch" complain that "Temp file with moniker 'svn_delta' already
   in use" instead of fetching.


Also contains a handful of trivial code clean-ups, documentation
updates, updates to the test suite, etc.

----------------------------------------------------------------

Changes since v1.8.4 are as follows:

Andreas Schwab (1):
      Documentation/git-merge.txt: fix formatting of example block

Benoit Person (1):
      git-remote-mediawiki: bugfix for pages w/ >500 revisions

Brandon Casey (3):
      git-completion.bash: use correct Bash/Zsh array length syntax
      t9902-completion.sh: old Bash still does not support array+=3D(''=
) notation
      contrib/git-prompt.sh: handle missing 'printf -v' more gracefully

Jeff King (2):
      config: do not use C function names as struct members
      mailmap: handle mailmap blobs without trailing newlines

Jharrod LaFon (1):
      avoid segfault on submodule.*.path set to an empty "true"

Johannes Sixt (1):
      stream_to_pack: xread does not guarantee to read all requested by=
tes

Jonathan Nieder (1):
      Git 1.8.4.1

Junio C Hamano (6):
      t5802: add test for connect helper
      fetch: rename file-scope global "transport" to "gtransport"
      fetch: refactor code that prepares a transport
      fetch: refactor code that fetches leftover tags
      fetch: work around "transport-take-over" hack
      Start preparing for 1.8.4.1

Kyle J. McKay (3):
      Git.pm: add new temp_is_locked function
      git-svn: allow git-svn fetching to work using serf
      Git.pm: revert _temp_cache use of temp_is_locked

Matthieu Moy (2):
      die_with_status: use "printf '%s\n'", not "echo"
      rebase: fix run_specific_rebase's use of "return" on FreeBSD

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      fetch-pack: do not remove .git/shallow file when --depth is not s=
pecified

Ralf Thielow (1):
      l10n: de.po: use "das Tag" instead of "der Tag"

Ramsay Allan Jones (1):
      builtin/fetch.c: Fix a sparse warning

Sebastien Helleu (1):
      l10n: fr.po: hotfix for commit 6b388fc

Steffen Prohaska (2):
      xread, xwrite: limit size of IO to 8MB
      Revert "compat/clipped-write.c: large write(2) fails on Mac OS X/=
XNU"

Tay Ray Chuan (1):
      t7406-submodule-update: add missing &&

Thomas Rast (2):
      log: use true parents for diff even when rewriting
      log: use true parents for diff when walking reflogs

Thorsten Glaser (1):
      fix shell syntax error in template

brian m. carlson (1):
      send-email: don't call methods on undefined values

From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.8.2
Date: Fri, 29 Apr 2016 15:04:36 -0700
Message-ID: <xmqq7ffgvzpn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awGWu-0000hM-Si
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 00:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbcD2WEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 18:04:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752501AbcD2WEk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 18:04:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B250E1892C;
	Fri, 29 Apr 2016 18:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=1MC+nxfk3XCMKpB2z2u+Rs3bI
	K8=; b=D8TEMflXPZ5FErNIIBty3y9RQrMsB6i5BWvk7/qI9JsezZk/MIxJmQlH2
	XZF30CkUcIeQV9Iqg8IuzsqT/4r7p8jwEsrkZ6pD06afbubdOT3jbDdCfEOEBUv4
	EOA6oKkju1B9o27so7LTuue7VfpI7L7oLdbHH6WjyJsfPISMkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=tkoXHRznz9EgXG8tUB5
	PothAxKbRp7Tmpl112NlBB9l/AKQnSzEBsWHtBzvzVcHBse0/rQG85VSPxdav6+6
	NXRc4xzeuOXZpN7aMOpnmKpEuicJC+Iu3UELF1vxUor0IhmZpVr7LeqBD+QMjZJI
	Os4jx3aI25xPQSlkpx9+KVsY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A91741892B;
	Fri, 29 Apr 2016 18:04:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BFD71892A;
	Fri, 29 Apr 2016 18:04:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D891698-0E56-11E6-BCF1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293059>

The latest maintenance release Git v2.8.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.8.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.8.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.8.1
------------------

 * The embedded args argv-array in the child process is used to build
   the command line to run pack-objects instead of using a separate
   array of strings.

 * Bunch of tests on "git clone" has been renumbered for better
   organization.

 * The tests that involve running httpd leaked the system-wide
   configuration in /etc/gitconfig to the tested environment.

 * "index-pack --keep=3D<msg>" was broken since v2.1.0 timeframe.

 * "git config --get-urlmatch", unlike other variants of the "git
   config --get" family, did not signal error with its exit status
   when there was no matching configuration.

 * The "--local-env-vars" and "--resolve-git-dir" options of "git
   rev-parse" failed to work outside a repository when the command's
   option parsing was rewritten in 1.8.5 era.

 * Fetching of history by naming a commit object name directly didn't
   work across remote-curl transport.

 * A small memory leak in an error codepath has been plugged in xdiff
   code.

 * strbuf_getwholeline() did not NUL-terminate the buffer on certain
   corner cases in its error codepath.

 * The startup_info data, which records if we are working inside a
   repository (among other things), are now uniformly available to Git
   subcommand implementations, and Git avoids attempting to touch
   references when we are not in a repository.

 * "git mergetool" did not work well with conflicts that both sides
   deleted.

 * "git send-email" had trouble parsing alias file in mailrc format
   when lines in it had trailing whitespaces on them.

 * When "git merge --squash" stopped due to conflict, the concluding
   "git commit" failed to read in the SQUASH_MSG that shows the log
   messages from all the squashed commits.

 * "git merge FETCH_HEAD" dereferenced NULL pointer when merging
   nothing into an unborn history (which is arguably unusual usage,
   which perhaps was the reason why nobody noticed it).

 * Build updates for MSVC.

 * "git diff -M" used to work better when two originally identical
   files A and B got renamed to X/A and X/B by pairing A to X/A and B
   to X/B, but this was broken in the 2.0 timeframe.

 * "git send-pack --all <there>" was broken when its command line
   option parsing was written in the 2.6 timeframe.

 * When running "git blame $path" with unnormalized data in the index
   for the path, the data in the working tree was blamed, even though
   "git add" would not have changed what is already in the index, due
   to "safe crlf" that disables the line-end conversion.  It has been
   corrected.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.8.1 are as follows:

Alexander Kuleshov (1):
      submodule-config: use hashmap_iter_first()

Christian Couder (1):
      Documentation: talk about pager in api-trace.txt

David Aguilar (2):
      mergetool: support delete/delete conflicts
      mergetool: honor tempfile configuration when resolving delete con=
flicts

Elia Pinto (1):
      api-trace.txt: fix typo

Gabriel Souza Franco (2):
      fetch-pack: fix object_id of exact sha1
      fetch-pack: update the documentation for "<refs>..." arguments

Jeff King (12):
      t1515: add tests for rev-parse out-of-repo helpers
      rev-parse: let some options run outside repository
      strbuf_getwholeline: NUL-terminate getdelim buffer on error
      setup: make startup_info available everywhere
      setup: set startup_info->have_repository more reliably
      remote: don't resolve HEAD in non-repository
      mailmap: do not resolve blobs in a non-repository
      grep: turn off gitlink detection for --no-index
      use setup_git_directory() in test-* programs
      send-email: ignore trailing whitespace in mailrc alias file
      credential-cache--daemon: clarify "exit" action semantics
      t/lib-httpd: pass through GIT_CONFIG_NOSYSTEM env

Johannes Sixt (1):
      Windows: shorten code by re-using convert_slashes()

John Keeping (3):
      config: fail if --get-urlmatch finds no value
      Documentation/git-config: use bulleted list for exit codes
      Documentation/git-config: fix --get-all description

Junio C Hamano (7):
      index-pack: correct --keep[=3D<msg>]
      index-pack: add a helper function to derive .idx/.keep filename
      merge: fix NULL pointer dereference when merging nothing into voi=
d
      Makefile: fix misdirected redirections
      Start preparing for 2.8.2
      Prepare for 2.8.2
      Git 2.8.2

Matthieu Moy (2):
      lockfile: mark strings for translation
      lockfile: improve error message when lockfile exists

Michael Procter (1):
      upload-pack: use argv_array for pack_objects

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      git-apply.txt: remove a space
      git-apply.txt: mention the behavior inside a subdir

Ori Avtalion (1):
      Documentation: git diff --check detects conflict markers

Pranit Bauva (2):
      t/t7502 : drop duplicate test
      api-parse-options.txt: document OPT_CMDMODE()

Ramsay Jones (2):
      xdiff/xprepare: use the XDF_DIFF_ALG() macro to access flag bits
      xdiff/xprepare: fix a memory leak

SZEDER G=C3=A1bor (1):
      diffcore: fix iteration order of identical files during rename de=
tection

Saurav Sachidanand (1):
      dir: store EXC_FLAG_* values in unsigned integers

Stanislav Kolotinskiy (1):
      git-send-pack: fix --all option when used with directory

Stefan Beller (1):
      clone tests: rename t57* =3D> t56*

Sven Strickroth (3):
      commit: do not lose SQUASH_MSG contents
      MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_=
CORR any more
      MSVC: use shipped headers instead of fallback definitions

Torsten B=C3=B6gershausen (1):
      correct blame for files commited with CRLF

Vasco Almeida (4):
      l10n: fr: fix transcation of "dir"
      l10n: fr: fix wrongly translated option name
      l10n: fr: change "id de cl=C3=A9" to match "id-cl=C3=A9"
      l10n: fr: don't translate "merge" as a parameter

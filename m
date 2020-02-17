Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8234BC7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 06:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCBA20718
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 06:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BXeLJVeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBQGkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:40:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56447 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQGkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 01:40:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23670B09F9;
        Mon, 17 Feb 2020 01:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=15Xm9thina60cCGiDQyk4NLRc
        rE=; b=BXeLJVeAZSgTBexmevGrdE35SltV2kIb8LM+FpIk+b3HJ2RiG/4yg4R2P
        WmciB6aHTQ94e+rSXwPbPPTMzfgRG1HLAgZkksueRo+9wTAkScxSLt+a6WbPiaz+
        L5zeG8kYI1v0drc7ZPH74TTnfAMG35m8EwWTQ9Dpnrel1OmqfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=f9RxcFjvJERh6eU4nz0
        PaE94nucaMGLAQnrPaRd9FrLgMRkNSWh9yojcVPAy3g/nqflcuWtdJDWrnBoS6xP
        PznD4I7tvV5QNjqTrVRm3QFkWvfJ7J+/6Psq1EuHYPuBFmFtN+1U8gtsczAmiJvC
        fy/Z/oSGG+2LsbvNOAn2yUII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D958B09F8;
        Mon, 17 Feb 2020 01:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AFD8B09F6;
        Mon, 17 Feb 2020 01:40:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.25.1
Date:   Sun, 16 Feb 2020 22:40:01 -0800
Message-ID: <xmqq36b9n2da.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 544F0F38-5150-11EA-A380-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.25.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.25.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.25.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.25
-----------------

 * "git commit" gives output similar to "git status" when there is
   nothing to commit, but without honoring the advise.statusHints
   configuration variable, which has been corrected.

 * has_object_file() said "no" given an object registered to the
   system via pretend_object_file(), making it inconsistent with
   read_object_file(), causing lazy fetch to attempt fetching an
   empty tree from promisor remotes.

 * The code that tries to skip over the entries for the paths in a
   single directory using the cache-tree was not careful enough
   against corrupt index file.

 * Complete an update to tutorial that encourages "git switch" over
   "git checkout" that was done only half-way.

 * Reduce unnecessary round-trip when running "ls-remote" over the
   stateless RPC mechanism.

 * "git restore --staged" did not correctly update the cache-tree
   structure, resulting in bogus trees to be written afterwards, which
   has been corrected.

 * The code recently added to move to the entry beyond the ones in the
   same directory in the index in the sparse-cone mode did not count
   the number of entries to skip over incorrectly, which has been
   corrected.

 * Work around test breakages caused by custom regex engine used in
   libasan, when address sanitizer is used with more recent versions
   of gcc and clang.

 * "git fetch --refmap=3D" option has got a better documentation.

 * Corner case bugs in "git clean" that stems from a (necessarily for
   performance reasons) awkward calling convention in the directory
   enumeration API has been corrected.

 * "git grep --no-index" should not get affected by the contents of
   the .gitmodules file but when "--recurse-submodules" is given or
   the "submodule.recurse" variable is set, it did.  Now these
   settings are ignored in the "--no-index" mode.

 * Technical details of the bundle format has been documented.

 * Unhelpful warning messages during documentation build have been
   squelched.

Also contains various documentation updates, code clean-ups and minor fix=
ups.

----------------------------------------------------------------

Changes since v2.25.0 are as follows:

Denton Liu (2):
      .mailmap: fix erroneous authorship for Johannes Schindelin
      .mailmap: map Yi-Jyun Pan's email

Derrick Stolee (3):
      unpack-trees: correctly compute result count
      clean: demonstrate a bug with pathspecs
      fetch: document and test --refmap=3D""

Elijah Newren (2):
      string-list: note in docs that callers can specify sorting function
      dir: treat_leading_path() and read_directory_recursive(), round 2

Emily Shaffer (2):
      unpack-trees: watch for out-of-range index position
      submodule: add newline on invalid submodule error

Heba Waly (2):
      commit: honor advice.statusHints when rejecting an empty commit
      doc/gitcore-tutorial: fix prose to match example command

Jacques Bodin-Hullin (1):
      parse-options: lose an unnecessary space in an error message

Jeff King (7):
      restore: invalidate cache-tree when removing entries with --staged
      transport: don't flush when disconnecting stateless-rpc helper
      dir: restructure in a way to avoid passing around a struct dirent
      dir: point treat_leading_path() warning to the right place
      Makefile: use compat regex with SANITIZE=3Daddress
      t4018: drop "debugging" cat from hunk-header tests
      t7800: don't rely on reuse_worktree_file()

Johannes Berg (1):
      pack-format: correct multi-pack-index description

Johannes Schindelin (3):
      msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
      ci: ignore rubygems warning in the "Documentation" job
      convert: fix typo

Jonathan Tan (2):
      sha1-file: remove OBJECT_INFO_SKIP_CACHED
      t5616: make robust to delta base change

Junio C Hamano (2):
      .mailmap: fix GGG authoship screwup
      Git 2.25.1

Kyle Meyer (1):
      submodule foreach: replace $path with $sm_path in example

Martin =C3=85gren (2):
      git-filter-branch.txt: wrap "maths" notation in backticks
      diff-options.txt: avoid "regex" overload in example

Masaya Suzuki (1):
      doc: describe Git bundle format

Philippe Blain (1):
      grep: ignore --recurse-submodules if --no-index is given

Ralf Thielow (1):
      submodule.c: mark more strings for translation

brian m. carlson (7):
      run-command: avoid undefined behavior in exists_in_PATH
      docs: use "currently" for the present time
      doc: move author and committer information to git-commit(1)
      docs: expand on possible and recommended user config options
      doc: provide guidance on user.name format
      doc: dissuade users from trying to ignore tracked files
      docs: mention when increasing http.postBuffer is valuable


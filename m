Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4757C2BB1D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B5620714
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 00:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZuhCF7bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCRAHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:07:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53062 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRAHP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 20:07:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D97974457B;
        Tue, 17 Mar 2020 20:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=a
        i2bCjXRuy0KsOgE115K9YIbR7E=; b=ZuhCF7bjxgjUYRlojhb2dhQj1F8EXnNsg
        k0gtZLCAiyAS9IP/v77mzyGfvdaVwq1TmQ0a6fdH4ePBQ2A2Lbj5eaUdxDu893OK
        AOYi+DwvUgdeEgWU/SG2EwZzyBNJjggzoU5wm29Wj2P8AMbfZcUG7KkxKeLRH6n6
        9R4YzYvIec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=WzrQEZmteVGwFBVXbqcnACOcQO+XQ6UNNqUT3106FN14vG8g6SIfpJpP
        WiiefsHecp5PylmJcbEASbRIoNl8oR+HZOjiaLIQR9O00WwyuYll9+3gHIBYvJ75
        wkdBzMF/vWHau29Hu+uEaAdqDj40IDYoYpzAfJP7WDzR0yZetx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB0314457A;
        Tue, 17 Mar 2020 20:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7FC344576;
        Tue, 17 Mar 2020 20:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.25.2
Date:   Tue, 17 Mar 2020 17:07:06 -0700
Message-ID: <xmqqeetqh6fp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 678B2140-68AC-11EA-87BB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.25.2 is now available at the
usual places.  These merge down various fixes that have been merged
to 'master' and will be part of the upcoming v2.26.0 release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.25.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.25.2 Release Notes
========================

Fixes since v2.25.1
-------------------

 * Minor bugfixes to "git add -i" that has recently been rewritten in C.

 * An earlier update to show the location of working tree in the error
   message did not consider the possibility that a git command may be
   run in a bare repository, which has been corrected.

 * The "--recurse-submodules" option of various subcommands did not
   work well when run in an alternate worktree, which has been
   corrected.

 * Running "git rm" on a submodule failed unnecessarily when
   .gitmodules is only cache-dirty, which has been corrected.

 * "git rebase -i" identifies existing commits in its todo file with
   their abbreviated object name, which could become ambigous as it
   goes to create new commits, and has a mechanism to avoid ambiguity
   in the main part of its execution.  A few other cases however were
   not covered by the protection against ambiguity, which has been
   corrected.

 * The index-pack code now diagnoses a bad input packstream that
   records the same object twice when it is used as delta base; the
   code used to declare a software bug when encountering such an
   input, but it is an input error.

 * The code to automatically shrink the fan-out in the notes tree had
   an off-by-one bug, which has been killed.

 * "git check-ignore" did not work when the given path is explicitly
   marked as not ignored with a negative entry in the .gitignore file.

 * The merge-recursive machinery failed to refresh the cache entry for
   a merge result in a couple of places, resulting in an unnecessary
   merge failure, which has been fixed.

 * Fix for a bug revealed by a recent change to make the protocol v2
   the default.

 * "git merge signed-tag" while lacking the public key started to say
   "No signature", which was utterly wrong.  This regression has been
   reverted.

 * MinGW's poll() emulation has been improved.

 * "git show" and others gave an object name in raw format in its
   error output, which has been corrected to give it in hex.

 * Both "git ls-remote -h" and "git grep -h" give short usage help,
   like any other Git subcommand, but it is not unreasonable to expect
   that the former would behave the same as "git ls-remote --head"
   (there is no other sensible behaviour for the latter).  The
   documentation has been updated in an attempt to clarify this.

Also contains various documentation updates, code clean-ups and minor fixups.

----------------------------------------------------------------

Changes since v2.25.1 are as follows:

Alexandr Miloslavskiy (1):
      mingw: workaround for hangs when sending STDIN

Beat Bolli (1):
      unicode: update the width tables to Unicode 13.0

David Turner (1):
      git rm submodule: succeed if .gitmodules index stat info is zero

Derrick Stolee (2):
      partial-clone: demonstrate bugs in partial fetch
      partial-clone: avoid fetching when looking for objects

Elijah Newren (4):
      unpack-trees: exit check_updates() early if updates are not wanted
      check-ignore: fix documentation and implementation to match
      t3433: new rebase testcase documenting a stat-dirty-like failure
      merge-recursive: fix the refresh logic in update_file_flags

Emily Shaffer (2):
      prefix_path: show gitdir when arg is outside repo
      prefix_path: show gitdir if worktree unavailable

Harald van Dijk (1):
      show_one_mergetag: print non-parent in hex form.

Jeff King (9):
      merge-recursive: silence -Wxor-used-as-pow warning
      avoid computing zero offsets from NULL pointer
      xdiff: avoid computing non-zero offset from NULL pointer
      obstack: avoid computing offsets from NULL pointer
      index-pack: downgrade twice-resolved REF_DELTA to die()
      doc: move credential helper info into gitcredentials(7)
      doc/config/push: use longer "--" line for preformatted example
      doc-diff: use single-colon rule in rendering Makefile
      run-command.h: fix mis-indented struct member

Johan Herland (2):
      t3305: check notes fanout more carefully and robustly
      notes.c: fix off-by-one error when decreasing notes fanout

Johannes Schindelin (11):
      built-in add -i: do not try to `patch`/`diff` an empty list of files
      built-in add -i: accept open-ended ranges again
      parse_insn_line(): improve error message when parsing failed
      rebase -i: re-fix short SHA-1 collision
      rebase -i: also avoid SHA-1 collisions with missingCommitsCheck
      tests: fix --write-junit-xml with subshells
      t5580: test cloning without file://, test fetching via UNC paths
      mingw: add a helper function to attach GDB to the current process
      t/lib-httpd: avoid using macOS' sed
      ci: prevent `perforce` from being quarantined
      Azure Pipeline: switch to the latest agent pools

Junio C Hamano (4):
      merge-recursive: use subtraction to flip stage
      Documentation: clarify that `-h` alone stands for `help`
      Revert "gpg-interface: prefer check_signature() for GPG verification"
      Git 2.25.2

Philippe Blain (4):
      t7410: rename to t2405-worktree-submodule.sh
      t2405: use git -C and test_commit -C instead of subshells
      t2405: clarify test descriptions and simplify test
      submodule.c: use get_git_dir() instead of get_git_common_dir()



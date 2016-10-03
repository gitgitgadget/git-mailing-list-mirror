Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB0C207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbcJCWap (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:30:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60948 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751821AbcJCWan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E79144CB4;
        Mon,  3 Oct 2016 18:30:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=pjw6D6nJ3ppyUNDy9dPGlFl9j
        2Y=; b=VpjLBQZWfIjgxCtqKna9KDpVzjXh8QZArG8rQkg8Bmm++Tl+LKgLJeqqm
        UJC1oGeefMK7busd/cXoPCvtEf8GNw4wujW52BSWlhsSitosigmPLTh4P00dPRLA
        1hJXldjKd8zLAwQ0mH97eanxt13/wXRL8g2UwrsZfjv08vSBSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=gskv8jc0dWy3fTbzPMf
        C16CS2oq+Yx0uGKZym8gbrDQzC3uW+podgjh99uuVJMwvJS+EeWMEYrOXABclt8M
        OPSBf+IRNkqKYB4fZn9lc/xT10b1sVXFWm84h3/hSYBdiLn521SUk51IYp+4K5DT
        VVacv2JNE/oTSxL51UdpdHzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0548744CB3;
        Mon,  3 Oct 2016 18:30:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A5AD44CB2;
        Mon,  3 Oct 2016 18:30:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.10.1
Date:   Mon, 03 Oct 2016 15:30:39 -0700
Message-ID: <xmqqvax93w1c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 043DB9E8-89B9-11E6-91D9-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.10.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.10.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.10.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.10
-----------------

 * Clarify various ways to specify the "revision ranges" in the
   documentation.

 * "diff-highlight" script (in contrib/) learned to work better with
   "git log -p --graph" output.

 * The test framework left the number of tests and success/failure
   count in the t/test-results directory, keyed by the name of the
   test script plus the process ID.  The latter however turned out not
   to serve any useful purpose.  The process ID part of the filename
   has been removed.

 * Having a submodule whose ".git" repository is somehow corrupt
   caused a few commands that recurse into submodules loop forever.

 * "git symbolic-ref -d HEAD" happily removes the symbolic ref, but
   the resulting repository becomes an invalid one.  Teach the command
   to forbid removal of HEAD.

 * A test spawned a short-lived background process, which sometimes
   prevented the test directory from getting removed at the end of the
   script on some platforms.

 * Update a few tests that used to use GIT_CURL_VERBOSE to use the
   newer GIT_TRACE_CURL.

 * Update Japanese translation for "git-gui".

 * "git fetch http::/site/path" did not die correctly and segfaulted
   instead.

 * "git commit-tree" stopped reading commit.gpgsign configuration
   variable that was meant for Porcelain "git commit" in Git 2.9; we
   forgot to update "git gui" to look at the configuration to match
   this change.

 * "git log --cherry-pick" used to include merge commits as candidates
   to be matched up with other commits, resulting a lot of wasted time.
   The patch-id generation logic has been updated to ignore merges to
   avoid the wastage.

 * The http transport (with curl-multi option, which is the default
   these days) failed to remove curl-easy handle from a curlm session,
   which led to unnecessary API failures.

 * "git diff -W" output needs to extend the context backward to
   include the header line of the current function and also forward to
   include the body of the entire current function up to the header
   line of the next one.  This process may have to merge to adjacent
   hunks, but the code forgot to do so in some cases.

 * Performance tests done via "t/perf" did not use the same set of
   build configuration if the user relied on autoconf generated
   configuration.

 * "git format-patch --base=3D..." feature that was recently added
   showed the base commit information after "-- " e-mail signature
   line, which turned out to be inconvenient.  The base information
   has been moved above the signature line.

 * Even when "git pull --rebase=3Dpreserve" (and the underlying "git
   rebase --preserve") can complete without creating any new commit
   (i.e. fast-forwards), it still insisted on having a usable ident
   information (read: user.email is set correctly), which was less
   than nice.  As the underlying commands used inside "git rebase"
   would fail with a more meaningful error message and advice text
   when the bogus ident matters, this extra check was removed.

 * "git gc --aggressive" used to limit the delta-chain length to 250,
   which is way too deep for gaining additional space savings and is
   detrimental for runtime performance.  The limit has been reduced to
   50.

 * Documentation for individual configuration variables to control use
   of color (like `color.grep`) said that their default value is
   'false', instead of saying their default is taken from `color.ui`.
   When we updated the default value for color.ui from 'false' to
   'auto' quite a while ago, all of them broke.  This has been
   corrected.

 * A shell script example in check-ref-format documentation has been
   fixed.

 * "git checkout <word>" does not follow the usual disambiguation
   rules when the <word> can be both a rev and a path, to allow
   checking out a branch 'foo' in a project that happens to have a
   file 'foo' in the working tree without having to disambiguate.
   This was poorly documented and the check was incorrect when the
   command was run from a subdirectory.

 * Some codepaths in "git diff" used regexec(3) on a buffer that was
   mmap(2)ed, which may not have a terminating NUL, leading to a read
   beyond the end of the mapped region.  This was fixed by introducing
   a regexec_buf() helper that takes a <ptr,len> pair with REG_STARTEND
   extension.

 * The procedure to build Git on Mac OS X for Travis CI hardcoded the
   internal directory structure we assumed HomeBrew uses, which was a
   no-no.  The procedure has been updated to ask HomeBrew things we
   need to know to fix this.

 * When "git rebase -i" is given a broken instruction, it told the
   user to fix it with "--edit-todo", but didn't say what the step
   after that was (i.e. "--continue").

 * "git add --chmod=3D+x" added recently lacked documentation, which has
   been corrected.

 * "git add --chmod=3D+x <pathspec>" added recently only toggled the
   executable bit for paths that are either new or modified. This has
   been corrected to flip the executable bit for all paths that match
   the given pathspec.

 * "git pack-objects --include-tag" was taught that when we know that
   we are sending an object C, we want a tag B that directly points at
   C but also a tag A that points at the tag B.  We used to miss the
   intermediate tag B in some cases.

 * Documentation around tools to import from CVS was fairly outdated.

 * In the codepath that comes up with the hostname to be used in an
   e-mail when the user didn't tell us, we looked at ai_canonname
   field in struct addrinfo without making sure it is not NULL first.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.10.0 are as follows:

Alex Henrie (5):
      am: put spaces around pipe in usage string
      cat-file: put spaces around pipes in usage string
      git-rebase--interactive: fix English grammar
      git-merge-octopus: do not capitalize "octopus"
      unpack-trees: do not capitalize "working"

Beat Bolli (1):
      SubmittingPatches: use gitk's "Copy commit summary" format

Brandon Williams (1):
      pathspec: remove unnecessary function prototypes

Brian Henderson (3):
      diff-highlight: add some tests
      diff-highlight: add failing test for handling --graph output
      diff-highlight: add support for --graph output

Elia Pinto (5):
      t5541-http-push-smart.sh: use the GIT_TRACE_CURL environment var
      test-lib.sh: preserve GIT_TRACE_CURL from the environment
      t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
      t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var
      git-check-ref-format.txt: fixup documentation

Eric Wong (3):
      http: warn on curl_multi_add_handle failures
      http: consolidate #ifdefs for curl_multi_remove_handle
      http: always remove curl easy from curlm session on release

Jeff King (20):
      rebase-interactive: drop early check for valid ident
      gc: default aggressive depth to 50
      test-lib: drop PID from test-results/*.count
      diff-highlight: ignore test cruft
      diff-highlight: add multi-byte tests
      diff-highlight: avoid highlighting combined diffs
      error_errno: use constant return similar to error()
      color_parse_mem: initialize "struct color" temporary
      t5305: move cleanup into test block
      t5305: drop "dry-run" of unpack-objects
      t5305: use "git -C"
      t5305: simplify packname handling
      pack-objects: walk tag chains for --include-tag
      remote-curl: handle URLs without protocol
      patch-ids: turn off rename detection
      patch-ids: refuse to compute patch-id for merge commit
      docs/cvsimport: prefer cvs-fast-export to parsecvs
      docs/cvs-migration: update link to cvsps homepage
      docs/cvs-migration: mention cvsimport caveats
      ident: handle NULL ai_canonname

Jiang Xin (1):
      l10n: zh_CN: fixed some typos for git 2.10.0

Johannes Schindelin (4):
      git-gui: respect commit.gpgsign again
      regex: -G<pattern> feeds a non NUL-terminated string to regexec() a=
nd fails
      regex: add regexec_buf() that can work on a non NUL-terminated stri=
ng
      regex: use regexec_buf()

Johannes Sixt (4):
      t9903: fix broken && chain
      t6026-merge-attr: clean up background process at end of test case
      t3700-add: create subdirectory gently
      t3700-add: do not check working tree file mode without POSIXPERM

Josh Triplett (1):
      format-patch: show base info before email signature

Junio C Hamano (6):
      submodule: avoid auto-discovery in prepare_submodule_repo_env()
      symbolic-ref -d: do not allow removal of HEAD
      Prepare for 2.9.4
      Start preparing for 2.10.1
      Prepare for 2.10.1
      Git 2.10.1

Kirill Smelkov (1):
      t/perf/run: copy config.mak.autogen & friends to build area

Lars Schneider (1):
      travis-ci: ask homebrew for its path instead of hardcoding it

Matthieu Moy (1):
      Documentation/config: default for color.* is color.ui

Mike Ralphson (1):
      vcs-svn/fast_export: fix timestamp fmt specifiers

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      checkout: add some spaces between code and comment
      checkout.txt: document a common case that ignores ambiguation rules
      checkout: fix ambiguity check in subdir

Philip Oakley (12):
      doc: use 'symmetric difference' consistently
      doc: revisions - name the left and right sides
      doc: show the actual left, right, and boundary marks
      doc: revisions: give headings for the two and three dot notations
      doc: revisions: extra clarification of <rev>^! notation effects
      doc: revisions: single vs multi-parent notation comparison
      doc: gitrevisions - use 'reachable' in page description
      doc: gitrevisions - clarify 'latter case' is revision walk
      doc: revisions - define `reachable`
      doc: revisions - clarify reachability examples
      doc: revisions: show revision expansion in examples
      doc: revisions: sort examples and fix alignment of the unchanged

Ralf Thielow (1):
      rebase -i: improve advice on bad instruction lines

Ray Chen (1):
      l10n: zh_CN: review for git v2.10.0 l10n

Ren=C3=A9 Scharfe (6):
      compat: move strdup(3) replacement to its own file
      introduce hex2chr() for converting two hexadecimal digits to a char=
acter
      strbuf: use valid pointer in strbuf_remove()
      checkout: constify parameters of checkout_stage() and checkout_merg=
ed()
      unpack-trees: pass checkout state explicitly to check_updates()
      xdiff: fix merging of hunks with -W context and -u context

Satoshi Yasushima (6):
      git-gui: consistently use the same word for "remote" in Japanese
      git-gui: consistently use the same word for "blame" in Japanese
      git-gui: apply po template to Japanese translation
      git-gui: add Japanese language code
      git-gui: update Japanese translation
      git-gui: update Japanese information

Stefan Beller (5):
      xdiff: remove unneeded declarations
      transport: report missing submodule pushes consistently on stderr
      diff.c: use diff_options directly
      diff: omit found pointer from emit_callback
      diff: remove dead code

Thomas Gummerer (4):
      add: document the chmod option
      update-index: add test for chmod flags
      read-cache: introduce chmod_index_entry
      add: modify already added files when --chmod is given

Vasco Almeida (2):
      l10n: pt_PT: update Portuguese translation
      l10n: pt_PT: update Portuguese repository info


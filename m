Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD6E1C3F06
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317245; cv=none; b=qkNMkXKpH7lfs7iWPJe/AkGDsnEElgrSTAimRvh7zykHbXvYljHSu9G+fQTIO4V8BgdSYv+MLPLcPNYHrcbfkll/FRy51jNCF+KT6Na5Z9kqpouaB/AYOhkbNG7uwEpS2wyMsXnTssukrpJcBYzxr7BsdRW9HaWAjuQuMO+AkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317245; c=relaxed/simple;
	bh=5QFVxX7dIWZTjuOVVnmv7F8xc1a63bYvPdNibziG+k8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=poYefm+pXH9QVGtoKa0D5FYPVRHxRjI7ZgSR64qgtGYUM92m3w8c/Kp6MYDZotky7l2BJPYWYJdmQ0+s7ex9iUZiU1mL9nNTnOanSLlJq3Fn9/qZVegqlhOZRFYIrUHH1zDkdkUjaRYPBn8jGv0Z+ePpC3bY7Ib47ZUsc1j3Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ufHavjMi; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ufHavjMi"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea0b25695dso1141127b3.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730317239; x=1730922039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnJiAdMnDK+sl/AKFQeFaQHyEDOTKmGr1+DWSMRsy/I=;
        b=ufHavjMibwbqr4Uktq1VNpRbwlUnkYK+z8+zmOgo6xvKBL3UqLzEQKVtnaGGONjH2n
         dfC+AAvdYaZweWejWOFuG0xEPJDwFsnamnf7lDfoD4TMMfOHz+ROmRvNdBwpg+LJdwo7
         iRIHXO5aXJW4qXXXJTarUwiKrbYGP33xfRy9bu4DWMC80xCiAAg6+1AEnPj1REQLDgu0
         mdoA5MWN7aiaC+aPyGrnRg42oGE4SrFLne4GgUoI2FPOsSVYh6YiQoZlVYzVKfJu6qCm
         lLghlNx3/MoPOiIyc8HEwQh8p1ZbYr7dYY2QHm/jSYIedQdWwVwlfApFCa+g3M6HsD0/
         MO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730317239; x=1730922039;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnJiAdMnDK+sl/AKFQeFaQHyEDOTKmGr1+DWSMRsy/I=;
        b=aZY3u5TskOsqDcfE6WbfXFNU1bz2xxsE6yM/pdwjpp3eSp7acGRVq75eU5e0DqepDA
         X974QJSX3hm6r2PlqEL9854CtKz9/2ALorCmAC+v979nlmt9+HewBY8V4EqkuRaLMGcL
         lPGoJujHmud1ELEyZDAqQzsaoE2eos7Bw4M8hv0Qjjklr4TSo8Y4+957Kx/x6xoHiItB
         x0JtF+IeFWMm2t2wRV5pwNNbtTTnLqE9u061Yoo3IySeHliBvE07NJfGsAujpDNXEplN
         a3STEdMfXEO/LRUzrTgGNhLNhExzXbGovhSerYlS4ZBqu0pQZyFj6cEB//nVGXbXFeQQ
         2rRw==
X-Gm-Message-State: AOJu0YzwutJmtSkrhBnHU2PzGlWDS6vNOSdk+ZUMHzE+1Aqk3Vw8chMQ
	zJMZ79g6R+sxTx+wd2MaIeT3JKuJP/5GBlkQTjfnUkNvEuX/6lzVtzKYYLDKTKc7pJQ8u/wxmNh
	NwB0=
X-Google-Smtp-Source: AGHT+IHN+kq4MiATuKvD4bqdd7jb1wYxaZkzA4gi17AHODibZcPtkpF4B/2einiM5nJG7VmnGAmACg==
X-Received: by 2002:a05:690c:2d08:b0:6e3:10e7:b418 with SMTP id 00721157ae682-6e9d8b554acmr122005767b3.46.1730317238627;
        Wed, 30 Oct 2024 12:40:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c97797sm25877937b3.126.2024.10.30.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:40:37 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:40:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #12; Wed, 30)
Message-ID: <ZyKLq+pYo4tffdCR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-master-at: 23d289d273d861f0a6244480e89ff937f66efa77
X-next-at: 8800431eeacca56afc106ed9e72ebe59bca077b0

What's cooking in git.git (Oct 2024, #12; Wed, 30)
--------------------------------------------------

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

This is the fifth integration round from the interim maintainer. A
large number of topics are currently sitting in 'next' and will likely
graduate to 'master' before the end of the week.

Regrettably, there continue to be lots of topics that are stuck
waiting for more discussion and would benefit from review. Please have
a look at any topics that you feel comfortable reviewing and please do
so if you find the time.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	https://github.com/git/git/

(Note that other usual spots are not updated while Junio is on
vacation, including the below):

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/ttaylorr/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* co/t6050-pipefix (2024-10-22) 1 commit
 (merged to 'next' on 2024-10-22 at d377ddbb64)
 + t6050: avoid pipes with upstream Git commands

 Avoid losing exit status by having Git command being tested on the
 upstream side of a pipe.

 source: <20241022012701.8959-1-chizobajames21@gmail.com>


* kh/submitting-patches (2024-10-21) 1 commit
 (merged to 'next' on 2024-10-22 at 0882adfc45)
 + SubmittingPatches: tags -> trailers

 Docfix.

 source: <d3a1ba01104da8496d52308c07c5c274fd30b0c2.1729443395.git.code@khaugsbakk.name>


* ks/t4205-fixup (2024-10-21) 1 commit
 (merged to 'next' on 2024-10-22 at daa85d02c3)
 + t4205: fix typo in 'NUL termination with --stat'

 Testfix.

 source: <20241020191910.31096-1-five231003@gmail.com>


* ps/ref-filter-sort (2024-10-21) 1 commit
 (merged to 'next' on 2024-10-22 at 6313df7028)
 + ref-filter: format iteratively with lexicographic refname sorting

 Teaches the ref-filter machinery to recognize and avoid cases where
 sorting would be redundant.

 source: <d23c3e3ee7fdb49fcd05b4f2e52dd2a1cfdc10f2.1729510342.git.ps@pks.im>


* ps/reftable-strbuf (2024-10-17) 10 commits
 (merged to 'next' on 2024-10-22 at 469c11aca4)
 + reftable: handle trivial `reftable_buf` errors
 + reftable/stack: adapt `stack_filename()` to handle allocation failures
 + reftable/record: adapt `reftable_record_key()` to handle allocation failures
 + reftable/stack: adapt `format_name()` to handle allocation failures
 + t/unit-tests: check for `reftable_buf` allocation errors
 + reftable/blocksource: adapt interface name
 + reftable: convert from `strbuf` to `reftable_buf`
 + reftable/basics: provide new `reftable_buf` interface
 + reftable: stop using `strbuf_addf()`
 + reftable: stop using `strbuf_addbuf()`
 (this branch is used by ps/reftable-detach.)

 Implements a new reftable-specific strbuf replacement to reduce
 reftable's dependency on Git-specific data structures.

 source: <cover.1729140565.git.ps@pks.im>


* sk/t7011-cleanup (2024-10-22) 1 commit
 (merged to 'next' on 2024-10-22 at 4273cb6260)
 + t7011: ensure no whitespace after redirect

 Test cleanup.

 source: <20241019163439.274656-1-kuforiji98@gmail.com>

--------------------------------------------------
[New Topics]

* as/show-index-uninitialized-hash (2024-10-27) 1 commit
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Expecting a reroll.
 cf. <26d1bd3c-4f90-4406-8a1f-2eb085c46bab@gmail.com>
 source: <20241026120950.72727-1-abhijeet.nkt@gmail.com>


* jk/dumb-http-finalize (2024-10-25) 11 commits
 (merged to 'next' on 2024-10-30 at 00932eb724)
 + packfile: use oidread() instead of hashcpy() to fill object_id
 + packfile: use object_id in find_pack_entry_one()
 + packfile: convert find_sha1_pack() to use object_id
 + http-walker: use object_id instead of bare hash
 + packfile: warn people away from parse_packed_git()
 + packfile: drop sha1_pack_index_name()
 + packfile: drop sha1_pack_name()
 + packfile: drop has_pack_index()
 + dumb-http: store downloaded pack idx as tempfile
 + t5550: count fetches in "previously-fetched .idx" test
 + midx: avoid duplicate packed_git entries
 (this branch is used by kn/the-repository.)

 The dumb-http code regressed when the result of re-indexing a pack
 yielded an *.idx file that differs in content from the *.idx file it
 downloaded from the remote. This has been corrected by no longer
 relying on the *.idx file we got from the remote.

 Will merge to 'master'.
 source: <20241025064148.GA2110169@coredump.intra.peff.net>

--------------------------------------------------
[Cooking]

* ak/more-typofixes (2024-10-24) 1 commit
 (merged to 'next' on 2024-10-25 at 63e3f967f3)
 + t: fix typos

 More typofixes.

 Will merge to 'master'.
 source: <20241024114721.14270-1-algonell@gmail.com>


* ps/mingw-rename (2024-10-27) 3 commits
 - compat/mingw: support POSIX semantics for atomic renames
 - compat/mingw: allow deletion of most opened files
 - compat/mingw: share file handles created via `CreateFileW()`

 Teaches the MinGW compatibility layer to support POSIX semantics for
 atomic renames when other process(es) have a file opened at the
 destination path.

 Waiting for final ack before 'next'.
 source: <cover.1730042775.git.ps@pks.im>


* ps/reftable-detach (2024-10-23) 8 commits
 - reftable/system: provide thin wrapper for lockfile subsystem
 - reftable/stack: drop only use of `get_locked_file_path()`
 - reftable/system: provide thin wrapper for tempfile subsystem
 - reftable/stack: stop using `fsync_component()` directly
 - reftable/system: stop depending on "hash.h"
 - reftable: explicitly handle hash format IDs
 - reftable/system: move "dir.h" to its only user
 - Merge branch 'ps/reftable-strbuf' into ps/reftable-detach

 Isolates the reftable subsystem from the rest of Git's codebase by
 using fewer pieces of Git's infrastructure.

 Needs review.
 source: <cover.1729677003.git.ps@pks.im>


* sk/t9101-cleanup (2024-10-23) 1 commit
 (merged to 'next' on 2024-10-25 at 43a35137b5)
 + t9101: ensure no whitespace after redirect

 Test cleanup.

 Will merge to 'master'.
 source: <20241023121113.915310-1-kuforiji98@gmail.com>


* ak/t1016-cleanup (2024-10-22) 1 commit
 (merged to 'next' on 2024-10-22 at 1dd1717591)
 + t1016: clean up style

 Test cleanup.

 Will merge to 'master'.
 source: <20241022110730.7655-1-algonell@gmail.com>


* cw/config-extensions (2024-10-22) 1 commit
 (merged to 'next' on 2024-10-30 at 875fa0b619)
 + doc: consolidate extensions in git-config documentation
 (this branch is used by cw/worktree-extension.)

 Centralize documentation for repository extensions into a single place.

 Will merge to 'master'?
 source: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>


* kh/mv-breakage (2024-10-23) 1 commit
 (merged to 'next' on 2024-10-25 at db92c3efa1)
 + t7001: add failure test which triggers assertion

 Demonstrate an assertion failure in 'git mv'.

 Will merge to 'master'.
 source: <c4ada0b787736ecd5aee986b1b8a4f90ccb84e21.1729631436.git.code@khaugsbakk.name>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Needs review.
 source: <20241020173216.40852-2-ken@kmatsui.me>


* kn/arbitrary-suffixes (2024-10-24) 1 commit
 (merged to 'next' on 2024-10-30 at 3eedf30c6c)
 + CodingGuidelines: discourage arbitrary suffixes in function names

 Update the project's CodingGuidelines to discourage naming functions
 with a "_1()" suffix.

 Will merge to 'master'.
 source: <20241024105357.2605168-1-karthik.188@gmail.com>


* ps/leakfixes-part-9 (2024-10-21) 22 commits
 - list-objects-filter-options: work around reported leak on error
 - builtin/merge: release outbut buffer after performing merge
 - dir: fix leak when parsing "status.showUntrackedFiles"
 - t/helper: fix leaking buffer in "dump-untracked-cache"
 - t/helper: stop re-initialization of `the_repository`
 - sparse-index: correctly free EWAH contents
 - dir: release untracked cache data
 - combine-diff: fix leaking lost lines
 - builtin/tag: fix leaking key ID on failure to sign
 - transport-helper: fix leaking import/export marks
 - builtin/commit: fix leaking cleanup config
 - trailer: fix leaking strbufs when formatting trailers
 - trailer: fix leaking trailer values
 - builtin/commit: fix leaking change data contents
 - upload-pack: fix leaking URI protocols
 - pretty: clear signature check
 - diff-lib: fix leaking diffopts in `do_diff_cache()`
 - revision: fix leaking bloom filters
 - builtin/grep: fix leak with `--max-count=0`
 - grep: fix leak in `grep_splice_or()`
 - t/helper: fix leaks in "reach" test tool
 - builtin/ls-remote: plug leaking server options

 More leakfixes.

 Needs review.
 source: <cover.1729502823.git.ps@pks.im>


* ps/upload-pack-doc (2024-10-21) 1 commit
 (merged to 'next' on 2024-10-25 at ede395593c)
 + doc: document how uploadpack.allowAnySHA1InWant impact other allow options

 Documentation update to clarify that 'uploadpack.allowAnySHA1InWant'
 implies both 'allowTipSHA1InWant' and 'allowReachableSHA1InWant'.

 Will merge to 'master'.
 source: <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>


* rj/cygwin-exit (2024-10-18) 1 commit
 (merged to 'next' on 2024-10-25 at a3acd18921)
 + credential-cache: treat ECONNABORTED like ECONNRESET

 Treat ECONNABORTED the same as ECONNRESET in 'git credential-cache' to
 work around a possible Cygwin regression. This resolves a race condition
 caused by changes in Cygwin's handling of socket closures, allowing the
 client to exit cleanly when encountering ECONNABORTED.

 Will merge to 'master'.
 source: <20241018052952.GE2408674@coredump.intra.peff.net>


* rs/grep-lookahead (2024-10-22) 1 commit
 (merged to 'next' on 2024-10-25 at 44fc090a5e)
 + grep: disable lookahead on error

 Fix 'git grep' regression on macOS by disabling lookahead when
 encountering invalid UTF-8 byte sequences.

 Will merge to 'master'.
 source: <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>


* sa/notes-edit (2024-10-21) 1 commit
 (merged to 'next on 2024-10-25 at 29b26e5ca6)
 + notes: teach the -e option to edit messages in editor

 Teach 'git notes add' and 'git notes append' a new '-e' flag,
 instructing them to open the note in $GIT_EDITOR before saving.

 Will merge to 'master'.
 source: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>


* ss/duplicate-typos (2024-10-21) 1 commit
 (merged to 'next' on 2024-10-25 at a55ee8bc52)
 + global: Fix duplicate word typos

 Typofixes.

 Will merge to 'master'.
 source: <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>


* ua/atoi (2024-10-24) 3 commits
 (merged to 'next' on 2024-10-25 at ecd980f7eb)
 + imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing
 + merge: replace atoi() with strtol_i() for marker size validation
 + daemon: replace atoi() with strtoul_ui() and strtol_i()

 Replace various calls to atoi() with strtol_i() and strtoul_ui(), and
 add improved error handling.

 Will merge to 'master'.
 source: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Needs review.
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* jc/optional-path (2024-10-14) 3 commits
 - parseopt: values of pathname type can be prefixed with :(optional)
 - config: values of pathname type can be prefixed with :(optional)
 - t7500: make each piece more independent

 Teach configuration values of type "pathname" a new ':(optional)'
 suffix.

 Needs review.
 source: <20241014204427.1712182-1-gitster@pobox.com>


* kh/update-ref (2024-10-21) 6 commits
 (merged to 'next' on 2024-10-25 at 317cc41dd3)
 + Documentation: mutually link update-ref and symbolic-ref
 + Documentation/git-update-ref.txt: discuss symbolic refs
 + Documentation/git-update-ref.txt: remove confusing paragraph
 + Documentation/git-update-ref.txt: demote symlink to last section
 + Documentation/git-update-ref.txt: remove safety paragraphs
 + Documentation/git-update-ref.txt: drop “flag”

 Documentation updates to 'git-update-ref(1)'.

 Will merge to 'master'.
 source: <cover.1729543007.git.code@khaugsbakk.name>


* am/git-blame-ignore-revs-by-default (2024-10-14) 2 commits
 - blame: introduce --override-ignore-revs to bypass ignore revisions list
 - blame: respect .git-blame-ignore-revs automatically

 Teaches 'git blame' to treat '.git-blame-ignore-revs' as if it were
 passed as '--ignore-revs-file' by default.

 Under discussion.
 source: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>


* kn/ci-clang-format-tidy (2024-10-18) 2 commits
 (merged to 'next' on 2024-10-30 at d063e828d5)
 + clang-format: align consecutive macro definitions
 + clang-format: re-adjust line break penalties

 Updates the '.clang-format' to match project conventions.

 Will merge to 'master'?
 source: <cover.1729241030.git.karthik.188@gmail.com>


* la/trailer-info (2024-10-14) 1 commit
 - trailer: spread usage of "trailer_block" language

 Refactoring.

 Needs review.
 source: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>


* ps/platform-compat-fixes (2024-10-28) 11 commits
 (merged to 'next' on 2024-10-22 at 46b99d8301)
 + t6006: fix prereq handling with `test_format ()`
 + http: fix build error on FreeBSD
 + builtin/credential-cache: fix missing parameter for stub function
 + t7300: work around platform-specific behaviour with long paths on MinGW
 + t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 + t3404: work around platform-specific behaviour on macOS 10.15
 + t1401: make invocation of tar(1) work with Win32-provided one
 + t/lib-gpg: fix setup of GNUPGHOME in MinGW
 + t/lib-gitweb: test against the build version of gitweb
 + t/test-lib: wire up NO_ICONV prerequisite
 + t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE

 Various platform compatibility fixes split out of the larger effort
 to use Meson as the primary build tool.

 Will merge to 'master'.
 source: <cover.1729060405.git.ps@pks.im>
 source: <zod73s7j77gjj2f62clg3utxlxnclbyhjjz3yc74x7zyh35fzy@blwhzqefxyrs>


* ps/upgrade-clar (2024-10-21) 5 commits
 (merged to 'next' on 2024-10-30 at b8b092bb78)
 + cmake: set up proper dependencies for generated clar headers
 + cmake: fix compilation of clar-based unit tests
 + Makefile: extract script to generate clar declarations
 + Makefile: adjust sed command for generating "clar-decls.h"
 + t/unit-tests: update clar to 206accb
 (this branch is used by ps/build.)

 Buildfix and upgrade of Clar to a newer version.

 Will merge to 'master'?
 source: <cover.1729506329.git.ps@pks.im>


* wf/diff-highlight-install (2024-10-14) 1 commit
 - diff-highlight: make install link into DESTDIR

 Adds an 'install' recipe to diff-highlight's Makefile.

 Under discussion.
 source: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>


* bc/drop-ancient-libcurl-and-perl (2024-10-23) 12 commits
 - gitweb: make use of s///r
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241023004600.1645313-1-sandals@crustytoothpaste.net>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728939687.git.steadmon@google.com>


* tb/cross-pack-delta-reuse (2024-10-11) 11 commits
 . pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap
 . pack-bitmap.c: record whether the result was filtered
 . pack-bitmap: enable cross-pack delta reuse
 . t5332: enable OFS_DELTAs via test_pack_objects_reused
 . write_reused_pack_one(): translate bit positions directly
 . pack-bitmap: drop `from_midx` field from `bitmapped_pack`
 . pack-bitmap.c: extract `find_base_bitmap_pos()`
 . pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
 . pack-bitmap.c: delay calling 'offset_to_pack_pos()'
 . pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
 . pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`

 Allow pack-objects to reuse an existing delta in a packfile, when
 it ends up sending the base object from a different packfile.

 Needs review.
 source: <cover.1728505840.git.me@ttaylorr.com>


* bf/set-head-symref (2024-10-23) 8 commits
 - fetch set_head: handle mirrored bare repositories
 - fetch: set remote/HEAD if it does not exist
 - refs: add create_only option to refs_update_symref_extended
 - refs: add TRANSACTION_CREATE_EXISTS error
 - remote set-head: better output for --auto
 - remote set-head: refactor for readability
 - refs: atomically record overwritten ref in update_symref
 - t/t5505-remote: set default branch to main

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Needs review.
 source: <20241023153736.257733-1-bence@ferdinandy.com>


* ps/build (2024-10-24) 31 commits
 - meson: fix conflicts with in-flight topics
 - Introduce support for the Meson build system
 - Documentation: add comparison of build systems
 - t: allow overriding build dir
 - t: better support for out-of-tree builds
 - Documentation: extract script to generate a list of mergetools
 - Documentation: teach "cmd-list.perl" about out-of-tree builds
 - Documentation: allow sourcing generated includes from separate dir
 - Makefile: simplify building of templates
 - Makefile: allow "bin-wrappers/" directory to exist
 - Makefile: refactor generators to be PWD-independent
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: extract script to generate gitweb.cgi
 - Makefile: extract script to massage Shell scripts
 - Makefile: use "generate-perl.sh" to massage Perl library
 - Makefile: extract script to massage Perl scripts
 - Makefile: consistently use PERL_PATH
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS
 - Merge branch 'ps/platform-compat-fixes' into ps/build
 - Merge branch 'ps/upgrade-clar' into ps/build
 + http: fix build error on FreeBSD
 + builtin/credential-cache: fix missing parameter for stub function
 + t7300: work around platform-specific behaviour with long paths on MinGW
 + t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 + t3404: work around platform-specific behaviour on macOS 10.15
 + t1401: make invocation of tar(1) work with Win32-provided one
 + t/lib-gpg: fix setup of GNUPGHOME in MinGW
 + t/lib-gitweb: test against the build version of gitweb
 + t/test-lib: wire up NO_ICONV prerequisite
 + t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
 (this branch uses ps/upgrade-clar.)

 Build procedure update plus introduction of Mason based builds

 Under discussion.
 source: <cover.1729771605.git.ps@pks.im>


* ds/path-walk (2024-10-08) 17 commits
 - pack-objects: thread the path-based compression
 - pack-objects: refactor path-walk delta phase
 - scalar: enable path-walk during push via config
 - pack-objects: enable --path-walk via config
 - repack: update usage to match docs
 - repack: add --path-walk option
 - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 - p5313: add performance tests for --path-walk
 - pack-objects: update usage to match docs
 - pack-objects: add --path-walk option
 - pack-objects: extract should_attempt_deltas()
 - path-walk: add prune_all_uninteresting option
 - revision: create mark_trees_uninteresting_dense()
 - path-walk: allow visiting tags
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - path-walk: introduce an object walk by path

 A new algorithm for object graph traversal to favor visiting the
 objects at the same tree path in succession (as opposed to visiting
 objects that are different between trees as we walk commit
 histories) is introduced to optimize object packing.

 Expecting a reroll.
 cf. <dd18a858-31bf-497d-bb19-d371102dfa2a@gmail.com>
 source: <pull.1813.git.1728396723.gitgitgadget@gmail.com>


* hy/partial-repack-fix (2024-10-16) 3 commits
 . partial-clone: update doc
 . t0410: adapt tests to repack changes
 . repack: pack everything into packfile

 "git repack" avoids losing local objects that are reachable from
 objects in a packfile fetched from a promisor remote.

 Need review.
 source: <20241014032546.68427-1-hanyang.tony@bytedance.com>


* ua/t3404-cleanup (2024-10-14) 2 commits
 (merged to 'next' on 2024-10-25 at 26b7b76329)
 + t3404: replace test with test_line_count()
 + t3404: avoid losing exit status with focus on `git show` and `git cat-file`

 Test update.

 Will merge to 'master'.
 source: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>


* ej/cat-file-remote-object-info (2024-10-29) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20241028203457.19715-1-eric.peijian@gmail.com>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 . fetch-pack.c: do not declare local commits as "have" in partial repos
 . packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Appears to break CI.
 cf. https://github.com/ttaylorr/git/actions/runs/11523538245
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* jc/breaking-changes-early-adopter-option (2024-10-11) 1 commit
 (merged to 'next' on 2024-10-18 at 899fb7e75f)
 + BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Will merge to 'master'.
 source: <xmqq1q0mcnt8.fsf@gitster.g>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-10-21) 9 commits
 - ref: add symlink ref content check for files backend
 - ref: check whether the target of the symref is a ref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: support multiple worktrees check for refs
 - ref: initialize target name outside of check functions
 - ref: check the full refname instead of basename
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <ZxZ+xteOnm0im5vC@nand.local>
 source: <ZxZX5HDdq_R0C77b@ArchLinux>


* tb/incremental-midx-part-2 (2024-10-04) 17 commits
 - fixup! pack-bitmap.c: open and store incremental bitmap layers
 - fixup! midx: implement writing incremental MIDX bitmaps
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>
 source: <ZwBsbW5jsFw0mxKk@nand.local>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>

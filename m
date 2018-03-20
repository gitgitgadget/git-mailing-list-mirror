Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29BE1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 09:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCTJey (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 05:34:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34792 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeCTJew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 05:34:52 -0400
Received: by mail-io0-f195.google.com with SMTP id r18so1516575ioa.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OaqJery+9SGjjEwy5Dl1DQqk9+xeKe2yOxR3ZfR+3+E=;
        b=HOqB2COcLpXWmCTMfnBgIKqc2flDAy+lliEuYS2rPoMfecIsvptsRLdBuHceCft21z
         Iocjrvnvvxgc08ByMdLyUnAVgTW8G93D1sX/M374M5+L73Umknv8W/sjWXTJ99Qg4YzN
         lk4ovE6PaAqfdw9z3gkyeHRWofaVsRuw7sANTwEyM1/sa8exJUbbI0sC+jpDllo4xmzV
         iFXmPQMVABAkc8rw8KQnnbiRmQXoEufoEBSMKS7Hj3Lswg6WaL0rq5SzfD2Oqvbelj0r
         FIXeowa5IZNM9MGmvhcy3QQHYorXLbHm1jPP0IkQQ7zfOmVHR5Nj8XM7ug7whQ4EmCh7
         qnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OaqJery+9SGjjEwy5Dl1DQqk9+xeKe2yOxR3ZfR+3+E=;
        b=RATespPo1JXKmQ9DoOQFvNMVhy5/6yHD8wro2+zcN16eDrvJq14KiLllgJAyU3PItM
         6XdLz9cjRXI1G5rn6CfwYhhVsrFzfl3IPIrW9nemUh0fMAuFmnzH59DMg4LS9M939WaF
         ZEcPFDJn2cCPsDk3RLTFO0SzVnjF2qW8W7RhsWlSv9GaKKFRtvoxtv84AVBl8c2Kn587
         717k4xEMD/sWqYqNcUExkh5YClYk0e5KlUoa5lDpPnpSroAbuLRQsEgRsd+N14E+NhVO
         0CQEO5UNraNkgAugOLseEJJLDZyo+Ox3RwGMt1MlTfLugau1cip4adLF6OrZjejEUMio
         tz6Q==
X-Gm-Message-State: AElRT7H8xY7H8ADhb4J+4RAmGB6Xmm1O33xNgZDn60qU6Uz0ZewInkxH
        TsHvHPPxEYLCdWhSIN5Lq+/Km40w
X-Google-Smtp-Source: AG47ELuQCP/366ey6JlvmqTO0jBZAHZ8CZK9FfmpmQ0lgQ6OdTm0PbUWg3q5e5Wx5/JF6zHc48YYJw==
X-Received: by 10.107.191.69 with SMTP id p66mr14831085iof.294.1521538491727;
        Tue, 20 Mar 2018 02:34:51 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.81])
        by smtp.gmail.com with ESMTPSA id j19sm862210ioe.15.2018.03.20.02.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 02:34:51 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] [GSoC] Project proposal: convert scripts to builtins
Date:   Tue, 20 Mar 2018 15:19:21 +0545
Message-Id: <20180320093421.26817-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAP8UFD2gN9Litjm_Wn8XoR7QMg6BXasETUX33ntcB2_gQ5AVTg@mail.gmail.com>
References: <CAP8UFD2gN9Litjm_Wn8XoR7QMg6BXasETUX33ntcB2_gQ5AVTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
This is my draft for my proposal on "Convert Scripts to builtins" for GSoC.
Please review and provide feedback.


Cheers,
Pratik Karki


Convert Scripts to builtins
===========================

Abstract
--------

Many components of Git are still in the form of shell and Perl scripts.
This has certain advantages of being extensible but causes problems in
production code on multiple platforms like Windows.
I propose to rewrite a couple of shell and perl scripts into portable
and performant C code, making them built-ins. The major advantage of
doing this is improvement in efficiency and performance.

Much more scripts like `git-am` , `git-pull`, `git-branch` have already
been rewritten in C. Much more scripts like `git-rebase`, `git-stash`,
`git-add --interactive` are still present in shell and perl scripts.
I propose to work in `git-rebase` and `git-stash`.

Shell Scripts:
--------------

Although shell scripts are more faster can be extensible in
functionality and can be more easier to write, they introduce certain
disadvantages.

1.  Dependencies:
     The scripting languages and shell scripts make more productive code
    but there is an overhead of dependencies. The shell scripts are
    lighter and simpler and call other executables to perform
    non-trivial tasks. Taking `git-stash` shell script for example.
    `sed`, `rm`, `echo`, `test` are constantly present in `git-stash`.
    These look common to POSIX platforms but for non-POSIX platforms
    there needs some extra work for porting these commands. For example,
    in Git for Windows, the workaround for these commands in non-POSIX
    platform adds some extra utilities and adds MSYS2 shell commands and
    needs to pack language runtime for Perl. This increases the
    installation size and requires more disk space. Again, adding more
    batteries again needs implementation in all of the dependency
    libraries and executables.

2.  Inefficiency:
     Git has internal caches for configuration values, the repository
    index and repository objects. The porcelain commands do not have
    access to git's internal API and so they spawn git processes to
    perform git operations. For every git invocation, git would re-read
    the user's configuration files, repository index, repopulate the
    filesystem cache, etc. This leads to overhead and unnecessary I/O.
    Windows is known to have worse I/O performance compared to Linux.
    There is also slower I/O performance of HDD compared to SSD. This
    unnecessary I/O operations causes runtime overhead and becomes
    slower in poor I/O performance setups. Now, writing the porcelain
    into C built-ins leverages the git API and there is no need of
    spawning separate git processes, caching can be used to reduce
    unnecessary I/O processes.

3.  Spawing processes is less performant:
     Shell scripts usually spawn a lot of processes. Shell scripts are
    very lighter and hence have limited functionalites. For
    `git-stash.sh` to work it needs to perform lots of git operations
    like `git rev-parse` `git config` and thus spawns git executable
    processes for performing these operations. Again for invoking
    `git config` and providing configuration values, it spawn new
    processes to handle that. Spawning is implemented by `fork()` and
    `exec()` by shells. Now, on systems that do not support
    copy-on-write semantics for `fork()`, there is duplication of the
    memory of the parent process for every `fork()` call which turns out
    to be an expensive process. Now, in Windows, Git uses MSYS2
    exclusively to emulate `fork()` but since, Windows doesnot support
    forking semantics natively, the workaround provided by MSYS2
    emulates `fork()` without [copy-on-write
    semantics](https://www.cygwin.com/faq.html#faq.api.fork). Doing this
    creates another layer over Windows processes and thus slows git.

Rewriting C built-ins
---------------------

These above mentioned problems need to be fixed. The only fix for these
problems would be to write built-ins in C for all these shell scripts
leveraging the git API. Writing in built-in reduces the dependency
required by shell scripts. Since, Git is native executable in Windows,
doing this can make MSYS2 POSIX emulation obsolete. Then, using git's
internal API and C data types, built-in `git_config_get_value()` can be
used to get configuration value rather than spawning another git-config
process. This removes the necessary to re-read git configuration cache
everytime and reduces I/O. Furthermore, git-stash and git-rebase will be
more faster and show consistent behaviour as instead of spawing another
process and parsing command-line arguments manually, they can be
hardcoded to be built-in and leverage all the required git's internal
API's like `parse-options`.

To implement git-stash and git-rebase in C, I propose to avoid spawning
lots of external git processes and reduce redundant I/O by taking
advantage of the internal object, index and configuration cache. I
propose to use C data structures instead of needless parsing as C has
richer and performant data structures. Windows will definitely benefit
from these rewrites as the use of MSYS2 POSIX emulation would be
obsolete and unnecessary I/O processes would be reduced and there won't
be need of spawning external git processes.

But, while rewriting regressions should be totally avoided. The code
should not cause regression and introduce bugs not present in previous
scripts. Thought the re-write wouldn't look more simpler like previous
scripts, it should not have different behaviour or bugs compared to the
script and should not be hard to maintain compared to the script.

Potential Problems
------------------

### New Re-write code becomes less simpler and Bugs could get introduced:

C is a more verbose language than shell script and looks less simpler
than shell scripts. Doing things in less than 4 lines of shell script in
C can take up more than 12 lines to make it more simpler. For example,
in a previously used script `git-commit.sh` we can see,

```bash
     run_status () {
	# If TMP_INDEX is defined, that means we are doing
	# "--only" partial commit, and that index file is used
	# to build the tree for the commit.  Otherwise, if
	# NEXT_INDEX exists, that is the index file used to
	# make the commit.  Otherwise we are using as-is commit
	# so the regular index file is what we use to compare.
	if test '' != "$TMP_INDEX"
	then
		GIT_INDEX_FILE="$TMP_INDEX"
		export GIT_INDEX_FILE
	elif test -f "$NEXT_INDEX"
	then
		GIT_INDEX_FILE="$NEXT_INDEX"
		export GIT_INDEX_FILE
	fi

	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
		color=
	else
		color=--nocolor
	fi
	git runstatus ${color} \
		${verbose:+--verbose} \
		${amend:+--amend} \
		${untracked_files:+--untracked}
    }
 ```
This script has been rewritten as builtin in C.
These lines of code have been replaced in C providing more
built-in performance but looks less simpler and
contains high multiline functions in `commit.c`.

```C
`static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
		      struct wt_status *s)
{
	struct object_id oid;

	if (s->relative_paths)
		s->prefix = prefix;

	if (amend) {
		s->amend = 1;
		s->reference = "HEAD^1";
	}
	s->verbose = verbose;
	s->index_file = index_file;
	s->fp = fp;
	s->nowarn = nowarn;
	s->is_initial = get_oid(s->reference, &oid) ? 1 : 0;
	if (!s->is_initial)
		hashcpy(s->sha1_commit, oid.hash);
	s->status_format = status_format;
	s->ignore_submodule_arg = ignore_submodule_arg;

	wt_status_collect(s);
	wt_status_print(s);

	return s->commitable;
}
```
We can see the C version requires more lines of code and seem complex
than the script. But, this C code is not depending on external libraries
and dependencies hence provides good performance and can be optimized
further. The C codes after re-writing can be further documented,
optimized and designed to make it more simpler for maintaining it. The
functions can be documented with well-defined inputs, outputs and
behaviour. The internal git API can be used and the recurring codes can
be modified which can shrink the codebase and make git codebase smaller
and resulting in smaller installation size in different platforms.

Now, while doing this re-write there is high possibility of introducing
bugs. Though, the test-suite can catch obvious bugs, other less-obvious
bugs can escape from test scenarios. To fix this problem, new tests with
the co-ordination of other maintainers and contributors should be
written for the cases where the test fails to catch bugs. Other code
coverage tools can also be used to ensure that the test suite for the
command tests all code in builtin. Though it may take more time, careful
rewriting and review of code must be done seriously by doing one to one
line translations of shell scripts to C. The re-written code after tests
must go through rigorous review process to find and squash bugs present
in it.

> "Given enough eyeballs, all bugs are shallow."
>  - Linus Torvalds

Timeline and Development Cycle
------------------------------

-   Apr 23: Accepted student proposals announced.
-   Apr 23 onwards: Researching of all the test suites. Discussion of
    possible test improvements in for `git-stash` and `git-rebase`.
-   May 1: Rewriting skeleton begins.
-   May 13: Making `builtin/stash.c` ready for review process. (This
    goes on for some time.)
-   May 26: Making `builtin/rebase.c` ready for review process. (This
    goes on for some time.)
-   June 10: Make second versions with more improvements and more
    batteries ready for next review cycle.
-   June 20: Writing new tests and using more code-coverage tools to
    squash bugs present.
-   June 25 - Jul 20: Start optimizing `builtin/stash.c` and
    `builtin/rebase.c`. Benchmarking and profiling is done. They are
    exclusively compared to their original shell scripts, to check
    whether they are more performant or not and the results are
    published in the mailing list for further discussion.
-   Jul 20 - Aug 5: More optimizing and polishing of `builtin/stash.c`
    and `builtin/rebase.c` and running of new tests series written and
    send them for code review.
-   Aug 14: Submit final patches.
-   Aug 22: Results announced.
-   Apr 24 - Aug 14: Documentation is written. "What I'm working on" is
    written and posted in my blog regarding GSoC with Git.

About me
--------

I'm Pratik Karki and am studing bachelors in Computer Engineering in
Advanced College of Engineering and Management (Affiliated to Institue
of Engineering, Tribhuvan University). I've been writing C, C++, Ruby,
Perl, Clojure, Lisp, Java, JS, Erlang, Rust for 3 years, and contributed
to some projects which can be seen in
[Github](https://github.com/prertik). I've been doing independent
contract works for small upcoming start-ups in Nepal.
I have been planning to contribute in Git for a long time. Thanks, to
GSoC I've submitted small patch as a microproject: [test: avoid pipes in
git related commands for test
suite](https://public-inbox.org/git/20180319173204.31952-1-predatoramigo@gmail.com/).
I am looking forward to submitting more patches to Git on a long time
basis.

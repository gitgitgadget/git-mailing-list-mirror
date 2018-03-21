Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67961F404
	for <e@80x24.org>; Wed, 21 Mar 2018 06:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeCUGQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 02:16:32 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38232 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUGQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 02:16:30 -0400
Received: by mail-io0-f194.google.com with SMTP id b20so5275798iof.5
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EfrVvVifiyNiYIzS8rqBRCyShJCXcWhvgFQJqi2io3Q=;
        b=B/YBUMOXQY8vCwAiH/dXGR7Wj9N3NXHYm18dY8Iw3gFZA8gfVWDv2zUgHzevxk3F4a
         xDulj3JHqfgKa0jqUL43ZhMYFb9sBY7g9EHXh1lOkUpv5xzL3KN67uZTN/NmXcXptH5O
         nJ0NredjCs4zRaEWW1USLs+BBHSB1MlPqlGZ2QOJszvs8WQCeNYfaDJXPNo4rfZI7W0i
         sFVzqNBNlwK0jwDJNcXA+S6NxXz6ULwyyanMrIy6j3XmK45WLcI2/R3r/w65+kqf2+iP
         xvczwUUSe/Ca/LgaQPveWjUwAYTQRycTfvsJW7gP8kfN1UsUMwx1ZcHIJymigKZJuQ/N
         U/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EfrVvVifiyNiYIzS8rqBRCyShJCXcWhvgFQJqi2io3Q=;
        b=hmTMmiUWDFTXTeNPxfXka2rfx+/wWC0VtkBx7uBaAW2RI9y2WHkYGhvjsToY+H11ib
         XC9NbG5g5hGWjnj4cnf+56+u5OhH7HUdJiFr1sgS84KajQrYMBWYiVHUiNvA55Hrl3Rj
         YLYSyrAl2LhuSLWvTPy6GDmYO9Y4+Ja91o8GUeETXoWw/Jv7zMAuLPenno4QQ9fTNyQq
         MXNX9KI573I6DiyTdZfbhWWMMTBM3NYdY3JUn6RzyTr6fWYqO7lzchYoa3ZL9fCbp8gi
         jdTUbnbdK/SiamZE+VLjgKjy8huZlpZOvYkC1pYNhJpdaIf0YCrUWIRYlFO3fe+orqQf
         8hbA==
X-Gm-Message-State: AElRT7G4huP8Kvx7j7tpXBmwvdZuSYUx3TTASN0tuRvH7Up6ICIyZ9sq
        REA6bGb3Vk6k9ehZ2aUpldgmA1IG
X-Google-Smtp-Source: AG47ELsF+Gtr61uI/EPWwphO5XDZcclVIu/cVYI6A4+U3vix8mrvX8XiYhvU/vRPxBUBlfQG0+tozg==
X-Received: by 10.107.7.161 with SMTP id g33mr12317289ioi.82.1521612988850;
        Tue, 20 Mar 2018 23:16:28 -0700 (PDT)
Received: from localhost.localdomain ([27.34.20.48])
        by smtp.gmail.com with ESMTPSA id a128sm2258621ioe.2.2018.03.20.23.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 23:16:28 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] [GSoC] Project proposal: convert scripts to builtins
Date:   Wed, 21 Mar 2018 12:01:05 +0545
Message-Id: <20180321061605.27814-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <nycvar.QRO.7.76.6.1803201616290.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1803201616290.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the feedback. Thanks to you, I realized my proposal was
a bit ambitious. Both git-stash and git-rebase are big
commitment. After much analyzing, I found out I cannot complete
both in the given time frame. So, I decided to stick to one and
complete it. I decided to stick with git-stash. Thank you for directing
me to the un-merged matches. Now, I can find the points where the
patch couldn't be effective and work towards completing those
effective things.

Please provide feedback for this updated proposal.

Cheers,
Pratik Karki


Convert Scripts to builtins
===========================

Abstract
--------

Many components of Git are still in the form of shell and Perl scripts.
This has certain advantages of being extensible but causes problems in
production code on multiple platforms like Windows.\
I propose to rewrite a couple of shell and perl scripts into portable
and performant C code, making them built-ins. The major advantage of
doing this is improvement in efficiency and performance.

Much more scripts like `git-am` , `git-pull`, `git-branch` have already
been rewritten in C. Much more scripts like `git-rebase`, `git-stash`,
`git-add --interactive` are still present in shell and perl scripts. I
propose to work in `git-stash`.

### Shell Scripts:

Although shell scripts are more faster can be extensible in
functionality and can be more easier to write, they introduce certain
disadvantages.

1.  Dependencies:\
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

2.  Inefficiency:\
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

3.  Spawing processes is less performant:\
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
everytime and reduces I/O. Furthermore, git-stash will be more faster
and show consistent behaviour as instead of spawing another process and
parsing command-line arguments manually, they can be hardcoded to be
built-in and leverage all the required git's internal API's like
`parse-options`.

To implement git-stash in C, I propose to avoid spawning lots of
external git processes and reduce redundant I/O by taking advantage of
the internal object, index and configuration cache. I propose to use C
data structures instead of needless parsing as C has richer and
performant data structures. Windows will definitely benefit from these
rewrites as the use of MSYS2 POSIX emulation would be obsolete and
unnecessary I/O processes would be reduced and there won't be need of
spawning external git processes.

But, while rewriting regressions should be totally avoided. The code
should not cause regression and introduce bugs not present in previous
scripts. Thought the re-write wouldn't look more simpler like previous
scripts, it should not have different behaviour or bugs compared to the
script and should not be hard to maintain compared to the script.

There has been some development in `git-stash` as seen on
[<https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/>]
(https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/).
To maximize the productivity, the findings from the patch submitted can
be used. Since, there are already much discussions regarding the
rewrite.

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
This script has been rewritten as builtin in C. These lines of code
have been replaced in C providing more built-in performance
but looks less simpler and contains high multiline functions in `commit.c`

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
    possible test improvements in for `git-stash`.

    Firstly, the test suite coverage of every command will be reviewed
    using gcov and kcov.The test suite might not be perfect or
    comprehensive but must cover all the major code paths and
    command-line switches of the script. For the tests which seem
    inadequate, minimum required tests are written and developed
    incrementally. The minimum tests must provide safety net for
    migration of scripts to built-ins. The tests would be sent as a
    separate patch for parallel development and review process so that
    development of built-ins can happen at the same time productively.
    The tests will be written for every code changes and will be worked
    throughout the summer.

-   May 1: Rewriting skeleton begins.

    The shell scripts are translated on a line-by-line basis into C
    code. The C code will be written in a way to maximize the use of git
    internal API. In git-stash `parse-options` API can be used for
    implementing parsing argument of command-line. This would be way
    better than parsing via the scripts. Firstly, I will start
    implementing `stash --helper`from respective scripts to C code. Then
    increment it further more. Then I'll start converting git-stash.sh
    on a line-by-line basis.\
     Again for git-stash some work seem to be done
    [<https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/>]
    (https://public-inbox.org/git/20171110231314.30711-1-joel@teichroeb.net/).
    Now, to maximize the output I'll be taking findings from the
    previous patch and use it for my patch. As seen from the comments in
    the patch some tests for checking branch when `git stash branch`
    fails needs to be written. New tests will be written and code
    coverage tools will be used for the written code.

-   May 13: Making minimal `builtin/stash.c` with `stash--helper` ready
    for review process. (This goes on for some time.)

    The initial review of minimal builtin would be ready for git-stash.
    The result C code at this stage may not be necessarily be efficient
    but would be free from obvious bugs and can serve as a baseline for
    the final patch. This is sent for review process which can take some
    time. The code will ofcourse be tested using the test suite with
    some additional tests.

-   May 13 - June 10: Make second versions with more improvements and
    more batteries ready for next review cycle.

    The improved versions after rigorous review process is made ready
    for `builtin/stash.c`. This improved version will be functionally
    equivalent to the previous scripts and will be error free and will
    be ready for optimization and will be very extensible. It will use
    the internal API and can be optimized for faster processes. Certain
    recurring codes at this point are modified to decrease the code
    base.\
    At this point, the previous written tests will need some development
    and with the more understanding of the working of the builtin code,
    the tests are again optimized and code-coverage tools like gcov is
    used. The tests are again updated and sent over in a separate patch.
    The tests written at this stage will be very efficient and cover
    across all code bases effectively.

-   June 10 - Jul 20: Start optimizing `builtin/stash.c`. Benchmarking
    and profiling is done. They are exclusively compared to their
    original shell scripts, to check whether they are more performant or
    not and the results are published in the mailing list for further
    discussion.

The C code will be optimized for speed and efficiency in this stage. The
built-ins will now be profiled using the new efficient test suites to
find hot spots. Bench-marking is also done in comparison to original
scripts.The performance for stash can be measured by making it stash
large number of changes in another working directory and measuring the
time for completion of the task. After finding out, a graphical
representation of performance findings will be published to git mailing
list and discussions will commence on more optimization.

-   Jul 20 - Aug 5: More optimizing and polishing of `builtin/stash.c`
    and further polishing of tests series written and send them for code
    review.

After discussions with the git community, optimization is done further
and the code and tests at this stage are polished for final submissions.
The tests are polished and rigorous testing of bugs and performance
penalty is done. This will help to find previous hidden errors if
present.

-   Aug 14: Submit final patches.
     The final patch series containing all the summer's code is
    submitted for final review and merge to git.

-   Aug 22: Results announced.

-   Apr 24 - Aug 14: Documentation is written. "What I'm working on" is
    written and posted in my blog regarding GSoC with Git.

    The documentation of the code written is done in the whole summer.
    Additionally, a blog series will be written in a weekly basis of my
    current findings and will write about "What I'm working on" to
    further provide information about my development of summer project.

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

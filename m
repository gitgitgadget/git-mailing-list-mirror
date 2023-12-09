Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1kvWoRm"
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E331193
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 05:35:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28654179ec0so2944404a91.2
        for <git@vger.kernel.org>; Sat, 09 Dec 2023 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702128947; x=1702733747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMoc1KR4C4gKsElLhwC8bOmRR8PaQZxZb8lm7lTfBz8=;
        b=C1kvWoRmdN/2KfcUh0cusmyewTkUDRGMOsnv0t3erGx5zqaCs9+UHDOUpOc0lszY88
         zjNOjvIAhz8owSI5jeHKlrOTmEdYhTUdICJ1U1/oHyNfbW+qdLNtwCviiVG8Kj3N/2QD
         PiWCCeld+J96S8l/aCtOMDPE35Q76AkGZAY91kBxBcB2fW6ZlTxiPvnzqhmwMLGLoEyo
         zWRy9vhnNTobNCuPzJqMKpRqQ2qDKW+fGEK/OoHDyVuNu23zI8bC6FV7bdam/xRg/4Oh
         qthqJVNPQCkVMj4X/QZ0lH1MDUXuLYlvGAXaVGB1wklzuoFyRQeLd4LAiRbedRfN8WgY
         UZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702128947; x=1702733747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMoc1KR4C4gKsElLhwC8bOmRR8PaQZxZb8lm7lTfBz8=;
        b=XrRUdI0E4BYecaEgrZbtizyxvZ6iCylYjcFMKR4kVEpzeQXU4kRYLSl8YUPUnC6FqY
         Pw62aAm58yo1Qr0PhpK6jqu6sxkzNowBLdfnYX8en2IdPkkuqU1NqSsFFTG/h6b+X6d4
         oqdzqy1mdEiYHICVTgHCTeKfIi+03NHVaN1bu0PSY7GpaHF5L/1JxbL158AXiKq5hytg
         xNCY49QDTI6F9ubJ4lxVVCTvxbczXNxjnr/MvlpxaQt63010OXuNe+Nre1jtdE9oQuK5
         CRN8D0eEfsB17asPeoikSXXQYeIgzCSteywb/c8dp1+wGvieGm1ZhNpBofDUSU6nLhrh
         rZKQ==
X-Gm-Message-State: AOJu0YyZJrEfwgRsqo7wiS+y3oPFpE45TXVFsRl/SZLBEEMjZzHg341q
	GwxNw10mDPWtIitbZvItLBR9SfprfGQ=
X-Google-Smtp-Source: AGHT+IE262G+pd9SmJ0BAEa4j2bj53NghfzZUFPhx4LS1TtMQnJDC2YsQ5utcPVbzeU4Du6uMOYZtw==
X-Received: by 2002:a17:90b:4b8e:b0:286:ba9c:892f with SMTP id lr14-20020a17090b4b8e00b00286ba9c892fmr1351293pjb.48.1702128946590;
        Sat, 09 Dec 2023 05:35:46 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id er14-20020a17090af6ce00b0028654cc39besm5109939pjb.23.2023.12.09.05.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Dec 2023 05:35:45 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: New attempt to export test-lib from Git, maybe Sharness2?
Date: Sat,  9 Dec 2023 21:35:39 +0800
Message-Id: <802ca62b9d9672e9553ab064452d46e0d72dfc76.1702116416.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CAMP44s3qa_CoM_4--UmwYQTgO-5dHh6=jogH-rxF7OXEWr53Lw@mail.gmail.com>
References: <CAMP44s3qa_CoM_4--UmwYQTgO-5dHh6=jogH-rxF7OXEWr53Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

On Mon, 20 Mar 2023 18:15:17 -0600, Felipe Contreras wrote:
> Hello,
> 
> Version 1.2.0 of Sharness [1] -- the test harness library derived from
> Git's test lib -- is released. 

I like Sharness which make it possible to reuse the test framework of
Git. I try to use sharness in my projects and I'm having fun writing
test cases using familiar shell scripts.

But the test framework used by Sharpness is from Git v1.7.9 and is
quite old. The absence of test helper API and command options such as
"--run=..." is quite inconvenient for me. Furthermore, the lack of
lint tools results in many errors in my test cases (e.g., missing
"&&" between statements).

It's not easy to upgrade sharness to the latest test framework of Git.
So I decide to start a new project. The new project is named test-lib,
see:

  * https://github.com/jiangxin/test-lib

Some of my projects have upgraded the test framework from sharkness to
test-lib:

 * git-po-helper: https://github.com/git-l10n/git-po-helper/tree/main/test
 * git-repo-go: https://github.com/alibaba/git-repo-go/tree/master/test

I wonder if we can start Sharness2 based on this solution. See the
README of the test-lib project for details:


diff --git a/README.md b/README.md
new file mode 100644
index 0000000000..4cc529ab73
--- /dev/null
+++ b/README.md
@@ -0,0 +1,159 @@
+Test Lib From Git Core
+======================
+
+Test-lib is a test framework developed by Junio and is specifically
+designed for the Git project. It allows us to write a test suite
+using shell script, which contains a collection of test cases. The
+output of each test suite is presented in TAP ([Test Anything
+Protocol]) format. We can use test-lib or any other TAP harness
+programs (e.g., prove) to run and analyze the output of the test
+suites.
+
+In order to reuse the git test framework into other projects,
+the [sharness project] made a successful attempt. However, it is
+based on an outdated version of git (v1.7.9), which results in
+bugs and missing new features. For example:
+
+ * Commit d88785e424 (test-lib: set `BASH_XTRACEFD` automatically,
+   2016-05-11) and commit a5bf824f3b4d (t: prevent '-x' tracing
+   from interfering with test helpers' stderr, 2018-02-25) of the Git
+   project addressed bugs when we run test suites with "-x" option.
+
+ * Commit 0445e6f0a1 (test-lib: '--run' to run only specific tests,
+   2014-04-30) provided better control of the set of tests to run.
+
+ * Commit 92b269f5c5 (test-lib: turn on `GIT_TEST_CHAIN_LINT`
+   by default, 2015-04-22) turned on chain-lint by default to
+   prevent the accidental omission of "&&" between statements in
+   test cases. Additionally, Git offers more linter tools such as
+   "chainlint.pl" to help write correct test cases.
+
+ * The latest version of the Git project includes numerous test
+   helpers that are not present in sharness. These helpers
+   provide a more comprehensive and efficient testing developing
+   tools. E.g.: `test_bool_env`, `test_cmp_bin`, `test_commit`,
+   `test_config`, `test_env`, `test_file_not_empty`, `test_file_size`,
+   `test_line_count`, `test_oid`, `test_path_exists`,
+   `test_path_is_executable`, `test_path_is_missing`, `test_tick`,
+   `write_script`, etc.
+
+In order to reuse the latest test framework of the Git project and
+easy to maintain, use the following strategies:
+
+1. Use [git-filter-repo] to export test-lib related files and their
+   commit histories from the Git project. The generated tailored
+   commits are saved in the branch named "git-test-lib".
+
+2. The test-lib test framework relies on a helper program named
+   "test-tool", which is written in C. To use test-lib without the
+   need for C compilation, re-implemented part of the "test-tool"
+   subcommands in Python.
+
+3. Apply a series of patches to test-lib so that it can be easily
+   reused in other projects. Some patches are borrowed from Sharness.
+
+4. This project is a by-product of the Git project. For each Git
+   release, we will re-run step 1 to export the latest test
+   framework from Git projects which may include new files we
+   missed in older versions. The generated commit history will
+   overwrite the "git-test-lib" branch, and the master branch will
+   rebase on it.
+
+
+Install test-lib
+----------------
+
+To create test suites in shell scripts powered by test-lib, you can
+follow these steps:
+
+1. Set up a directory (such as "test") to save test suites and
+   files of test-lib.
+
+        $ mkdir test
+
+2. Clone or copy the test-lib repository inside the test directory.
+
+        $ cd test
+        $ git clone https://github.com/jiangixn/test-lib lib
+
+4. Copy files from the example test directory.
+
+        $ cp lib/test-example/.gitignore .
+        $ cp lib/test-example/.gitattributes .
+        $ cp lib/test-example/Makefile .
+
+4. Start writing a test suite powered by test-lib, make sure it
+   sources the "test-lib.sh" file from test-lib. Refer to the example
+   test suite (e.g. "test/t0001-test-tool-chmtime.sh") to write
+   your own test suite:
+
+        test_description='My first test suite'
+
+        . lib/test-lib.sh
+
+
+Usage of test-lib
+-----------------
+
+As for how to use test-lib to write, run and manage your test suites,
+please see the documentation [README.git] for reference.
+
+
+Filtering test-lib from the Git project
+---------------------------------------
+
+"test-lib" is part of the Git project and is stored in the "t/"
+subdirectory. We use "git-filter-repo" to export test-lib related
+files to the root directory of this project. We repeat this
+periodically to save historical commits of test-lib in the
+"git-test-lib" branch of this project. The master branch of this
+project will merge with or rebase onto the "git-test-lib" branch.
+As how to filter and export test-lib from the Git project, see the
+steps below.
+
+1. Make a fresh clone of the Git project before filtering.
+
+        $ git clone --single-branch --no-tags \
+          https://github.com/git/git.git \
+          git-test-lib
+
+        $ cd git-test-lib
+
+2. Use git-filter-repo to filter and export test-lib.
+
+        $ git filter-repo \
+          --preserve-commit-encoding \
+          --prune-degenerate always \
+          --path COPYING \
+          --path shared.mak \
+          --path t/.gitattributes \
+          --path t/.gitignore \
+          --path t/Makefile \
+          --path t/README \
+          --path t/aggregate-results.sh \
+          --path t/chainlint/ \
+          --path t/chainlint.pl \
+          --path t/check-non-portable-shell.pl \
+          --path t/oid-info/ \
+          --path t/perf/.gitignore \
+          --path t/perf/Makefile \
+          --path t/perf/README \
+          --path t/perf/aggregate.perl \
+          --path t/perf/config \
+          --path t/perf/min_time.perl \
+          --path t/perf/perf-lib.sh \
+          --path t/perf/p0000-perf-lib-sanity.sh \
+          --path t/perf/run \
+          --path t/test-lib-functions.sh \
+          --path t/test-lib-github-workflow-markup.sh \
+          --path t/test-lib-junit.sh \
+          --path t/test-lib.sh \
+          --path t/lib-subtest.sh \
+          --path t/t0000-basic.sh \
+          --path-rename t/:
+
+
+[Test Anything Protocol]: http://testanything.org/
+[sharness project]: https://github.com/felipec/sharness
+[git-filter-repo]: https://github.com/newren/git-filter-repo
+[README.git]: ./README.git
-- 
2.42.0.rc2.21.gd1f87c2148


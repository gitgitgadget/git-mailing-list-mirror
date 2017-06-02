Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C74C20D12
	for <e@80x24.org>; Fri,  2 Jun 2017 10:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdFBK3T (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 06:29:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34872 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFBK3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 06:29:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so17912724wmc.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0HybrluOrw5tb4kEQhvDJOPDmy0d/dcJ5WzGBFMnzc=;
        b=gvkzsTnBqfqoxMr1IuPYxEEVZcRe8lP3FumzQqTsFo87we9ZwWDn9eragnlAX4ecut
         wl/+WWGgr0EFtLoN1GX8+P9cayxpUGm62+gUC/pP9ivwAcq1AORdmUx1gr0wF5zP+qhS
         b2dvhFXinFMsMtMu48h8TjmFKBgrFCGMZ9tBOiN8GeTV8UFPi4r360qlePs0pCMY4Sll
         hqvanHvq/+6uegq9J3IBAHPQLdKC0B5fuwkmWkjwUXRqOJvLuZybdFvF4joGDi+wK7+U
         W+EqP7GRzfbMKERi7aLO8P4HeC+NDTkSK9BMUsVg5DjU9FNAuBQhszblE6/K5Wn96bQP
         b1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0HybrluOrw5tb4kEQhvDJOPDmy0d/dcJ5WzGBFMnzc=;
        b=CntXZe5Tu1W2Jm5bL3YHpfezqLzqTLtvc0H9i+HIdc3+uporKtK7LYF31QDDKKHDeI
         7PDDbl6rxbIc4uOIBjxnBHTqkJ5jlMAR+50dO0Uc9Mb2PzufwwbKrjWiwnmv+z+l8cVC
         LPoF0Dz1dlfigSSDSFxu+GodS8AkJHQAFZ4uAracfiPjhpNaZZSXPwccihAocTglc2xF
         JjsoyqTffrjeCD6ConzebkHfr2f/WOPS3m+Gx407gjXX+dAfa36Umml1BOqNDX4NlZMG
         xgNbM9px49tA9cIdzWjs8klgslSVDnnDge2eRq9mhrRll7p/nRwxdR+RI2dXhjGtZTxN
         A5/Q==
X-Gm-Message-State: AODbwcAkRch+9JpIYzFXAihAG1mxAjXAtJSrUjjKMc5qTOk/CCe6d1+R
        wyMsNdokckMfpb6Kv4c=
X-Received: by 10.80.173.164 with SMTP id a33mr5512804edd.102.1496399351296;
        Fri, 02 Jun 2017 03:29:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h46sm7864919ede.56.2017.06.02.03.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 03:29:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
Date:   Fri,  2 Jun 2017 10:28:53 +0000
Message-Id: <20170602102853.23073-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a performance test for the new core.fsmonitor facility using the
sample query-fsmonitor hook.

This is WIP code for the reasons explained in the setup comments,
unfortunately the perf code doesn't easily allow you to run different
setup code for different versions you're testing. This test will stop
working if the fsmonitor is merged into the master branch.

Output against linxu.git:

    $ GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8' ./run origin/master avar/fsmonitor ./p7519-fsmonitor.sh
    [...]
    Test                          origin/master     avar/fsmonitor
    -----------------------------------------------------------------------
    7519.2: status (first)        0.08(0.04+0.09)   0.12(0.07+0.10) +50.0%
    7519.3: status (subsequent)   0.08(0.04+0.09)   0.12(0.06+0.11) +50.0%
    7519.4: status -uno           0.02(0.02+0.05)   0.06(0.05+0.06) +200.0%
    7519.5: status -uall          0.08(0.06+0.07)   0.12(0.07+0.10) +50.0%

And against a larger in-house monorepo I have here, with the same
options (except the repo path):

    Test                          origin/master     avar/fsmonitor
    -----------------------------------------------------------------------
    7519.2: status (first)        0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
    7519.3: status (subsequent)   0.20(0.11+0.18)   0.27(0.15+0.21) +35.0%
    7519.4: status -uno           0.04(0.03+0.10)   0.22(0.08+0.12) +450.0%
    7519.5: status -uall          0.20(0.13+0.16)   0.27(0.18+0.19) +35.0%

Against linux.git with a hack to flush the FS cache (on Linux) before
running the first 'git status', only running one test so the result
isn't discarded as the slowest of N:

    $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_COMMAND='sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null && make -j8' ./run origin/master avar/fsmonitor ./p7519-fsmonitor.sh
    [...]
    Test                          origin/master     avar/fsmonitor
    ------------------------------------------------------------------------
    7519.2: status (first)        0.30(0.18+0.10)   8.26(0.22+0.10) +2653.3%
    7519.3: status (subsequent)   0.08(0.04+0.08)   0.81(0.09+0.07) +912.5%
    7519.4: status -uno           0.02(0.01+0.06)   0.08(0.04+0.07) +300.0%
    7519.5: status -uall          0.08(0.06+0.07)   0.15(0.08+0.09) +87.5%

Now obviously due to 1 run that has a lot of noise, but I would expect
that first invocation to be blindingly fast since watchman has info on
what files were modified since the cache was flushed.

The same on the large monorepo noted above:

    Test                          origin/master     avar/fsmonitor
    -----------------------------------------------------------------------
    7519.2: status (first)        0.59(0.28+0.24)   0.93(0.35+0.19) +57.6%
    7519.3: status (subsequent)   0.20(0.10+0.19)   0.28(0.16+0.20) +40.0%
    7519.4: status -uno           0.04(0.04+0.09)   0.11(0.08+0.12) +175.0%
    7519.5: status -uall          0.29(0.11+0.18)   0.40(0.16+0.19) +37.9%

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---


On Fri, Jun 2, 2017 at 2:40 AM, Ben Peart <peartben@gmail.com> wrote:
> Any chance you can provide me with a bash script that contains the exact
> sequence of commands you are running to get this result?  I've been trying
> to replicate it using your notes but have not been able to.  I'd like to see
> if it is a repo difference, a platform difference, a command sequence
> difference (or something else entirely :)).

I can do better than that, here's a new perf test on top of this
series which demonstates the issue. I've only tested this on Linux
4.9.0 with watchman 4.9.0 compiled from git (yes, they're
coincidentally the same version).

A good addition to this would be `printf <fmt for date N sec in the
past> | watchman -j` as noted in my earlier mail, but I ran out of
time.

You can also set any combination of GIT_PERF_7519_UNTRACKED_CACHE &
GIT_PERF_7519_SPLIT_INDEX to play with turning that on. I haven't
tested all combinations of that, but e.g. testing with untrackedCache
didn't give results that looked different from the performance
regressions noted above.

Aside from performance, I think a very good addition to stress-test
this series would be a patch to t/test-lib*sh guarded by some env flag
to do a similar watchman watch-del/watch/watch-list dance as the one
I'm doing here in the setup, and setting up the hook / config.

That would allow testing the entire git test suite with this feature,
to find any subtle bugs this might have introduced in git-status.

 t/perf/p7519-fsmonitor.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 t/perf/p7519-fsmonitor.sh

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
new file mode 100755
index 0000000000..b838a0ff14
--- /dev/null
+++ b/t/perf/p7519-fsmonitor.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description="Test core.fsmonitor"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success 'setup' '
+	# Maybe set untrackedCache & splitIndex depending on the
+	# environment, defaulting to false.
+	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
+	then
+		git config core.untrackedCache true
+	else
+		git config core.untrackedCache false
+	fi &&
+	if test -n "$GIT_PERF_7519_SPLIT_INDEX"
+	then
+		git config core.splitIndex true
+	else
+		git config core.splitIndex false
+	fi &&
+
+	# Relies on core.fsmonitor not being merged into master. Needs
+	# better per-test ways to disable it if it gets merged.
+	git config core.fsmonitor true &&
+
+	# Hook scaffolding
+	mkdir .git/hooks &&
+	cp ../../../templates/hooks--query-fsmonitor.sample .git/hooks/query-fsmonitor &&
+
+	# Setup watchman & ensure it is actually watching
+	watchman watch-del "$PWD" >/dev/null 2>&1 &&
+	watchman watch "$PWD" >/dev/null 2>&1 &&
+	watchman watch-list | grep -q -F "$PWD"
+'
+
+# Setting:
+#
+#    GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_COMMAND='sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches && make -j8'
+#
+# Can be used as a hack to performance test 'git status' on a cold fs
+# cache with an existing watchman watching the directory, which should
+# be blindingly fast, compared to amazingly slow without watchman.
+test_perf 'status (first)'       'git status'
+
+
+# The same git-status once the fs cache has been warmed, if using the
+# GIT_PERF_MAKE_COMMAND above. Otherwise the same as above.
+test_perf 'status (subsequent)'  'git status'
+
+# Let's see if -uno & -uall make any difference
+test_perf 'status -uno'          'git status -uno'
+test_perf 'status -uall'         'git status -uall'
+
+test_done
-- 
2.13.0.506.g27d5fe0cd


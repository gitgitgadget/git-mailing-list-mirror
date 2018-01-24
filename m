Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4CC1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeAXJai (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:38 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44051 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeAXJag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:36 -0500
Received: by mail-pf0-f193.google.com with SMTP id m26so2590273pfj.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBugjBElCUwjzKSFeq4QVr80RouaYqzt2SMJ+mTdmQw=;
        b=ATuq8uO6YfTGJApYdDn0i3cBSY+qnplMQTjzM7X4xsMGOJ/f9z4hfJIc38SRJV+exV
         A3uYFqsyqAY++ixhqQjmhWGVfLSfjmg0muE5AQ+lJcyed/rqWMdNxCtSGALda0d0X9cL
         mfgDM7n8FdS0d3R2U7H8VPR6R/3Cq2pHYI3XBe60PiPy/V7gNsiD+tiEYBhADHk9urr1
         +WCwXG+LepgwMf/tArnjRHXINOJ9XYdXyk/P2cgwTqBUt2CnOKBn+il3YPADk6dfmqwT
         pjY7DEdx64sI+hEGlJgq+cfe49kZ7QBaebH7x4lPzoP85uuOS/U/YTCu/l7jpn93IwbT
         d5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBugjBElCUwjzKSFeq4QVr80RouaYqzt2SMJ+mTdmQw=;
        b=oqnSCzj4qkILzdQGlYsoY5A3gp6YI/y9lbm94r+iFwkV5hsuzMTk6/88cif0QvjO/t
         tHmu9iKylbcBd3acvDvCPKsoMgaHD7LD0lQkuxBsqbR1JfjNuzuLNnz/qer+ZwzmMaIN
         S1UuUujAtZMlhyZmvNKJErdlgUODPDJNlaFSa/562xKmjt5F4pb8DLyQcn6xgOXDKNam
         96gW4c4ty5hipG6hYCV5xozJH4I4XCHeQZ65QPJ+x1ztBPyPFiHFpcMGZrsRXUz6L2Tu
         4Rmv1M7VKHCmQAt8Ub2zahye0GigrGZE5MUz1mhfrvzvU3450Wlto8tD6Qy8STo0h6OU
         Jx1w==
X-Gm-Message-State: AKwxyte1jkKMTgICCmgirhhrN1kqfws1akuEFcNwys3uLWOb4Ecew8GK
        qbvMz9GUcHKx/rxSUwV5vEARUA==
X-Google-Smtp-Source: AH8x226bDpmJfAFUQbR7XJMp8E9/XWsZSomr//R4/9L7x30ssc0nqd1VbmJJ1LD6DII3Oiq9TpMcEA==
X-Received: by 10.101.96.4 with SMTP id m4mr10490030pgu.104.1516786235340;
        Wed, 24 Jan 2018 01:30:35 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id u195sm32543788pgb.64.2018.01.24.01.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/5] status: add a failing test showing a core.untrackedCache bug
Date:   Wed, 24 Jan 2018 16:30:19 +0700
Message-Id: <20180124093023.9071-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093023.9071-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
 <20180124093023.9071-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The untracked cache gets confused when a directory is swapped out for
a file. It is easiest to reproduce this by swapping out a directory
with a symlink to another directory, and as the tests show the symlink
case is the only case we've found where "git status" will subsequently
report incorrect information, even though it's possible to otherwise
get the untracked cache into a state where its internal data
structures don't reflect reality.

In the symlink case, whatever files are inside the target of the
symlink will be incorrectly shown as untracked. This issue does not
happen if the symlink links to another file, only if it links to
another directory.

A stand-alone testcase for copying into a terminal:

    (
        rm -rf /tmp/testrepo &&
        git init /tmp/testrepo &&
        cd /tmp/testrepo &&
        mkdir x y &&
        touch x/a y/b &&
        git add x/a y/b &&
        git commit -msnap &&
        git rm -rf y &&
        ln -s x y &&
        git add y &&
        git commit -msnap2 &&
        git checkout HEAD~ &&
        git status &&
        git checkout master &&
        sleep 1 &&
        git status &&
        git status
    )

This will incorrectly show y/a as an untracked file. Both the "git
status" call right before "git checkout master" and the "sleep 1"
after the "checkout master" are needed to reproduce this, presumably
due to the untracked cache tracking on the basis of cached whole
seconds from stat(2).

When git gets into this state, a workaround to fix it is to issue a
one-off:

    git -c core.untrackedCache=false status

For the non-symlink case, the bug is that the output of
test-dump-untracked-cache should not include:

   /one/ 0000000000000000000000000000000000000000 recurse valid

It being in the output implies that cached traversal of root includes
the directory "one" which does not exist on disk anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index e5fb892f95..dba7f50bbb 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -22,6 +22,12 @@ avoid_racy() {
 	sleep 1
 }
 
+status_is_clean() {
+	>../status.expect &&
+	git status --porcelain >../status.actual &&
+	test_cmp ../status.expect ../status.actual
+}
+
 test_lazy_prereq UNTRACKED_CACHE '
 	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
@@ -683,4 +689,85 @@ test_expect_success 'untracked cache survives a commit' '
 	test_cmp ../before ../after
 '
 
+test_expect_success 'teardown worktree' '
+	cd ..
+'
+
+test_expect_success SYMLINKS 'setup worktree for symlink test' '
+	git init worktree-symlink &&
+	cd worktree-symlink &&
+	git config core.untrackedCache true &&
+	mkdir one two &&
+	touch one/file two/file &&
+	git add one/file two/file &&
+	git commit -m"first commit" &&
+	git rm -rf one &&
+	ln -s two one &&
+	git add one &&
+	git commit -m"second commit"
+'
+
+test_expect_failure SYMLINKS '"status" after symlink replacement should be clean with UC=true' '
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	status_is_clean
+'
+
+test_expect_success SYMLINKS '"status" after symlink replacement should be clean with UC=false' '
+	git config core.untrackedCache false &&
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	status_is_clean
+'
+
+test_expect_success 'setup worktree for non-symlink test' '
+	git init worktree-non-symlink &&
+	cd worktree-non-symlink &&
+	git config core.untrackedCache true &&
+	mkdir one two &&
+	touch one/file two/file &&
+	git add one/file two/file &&
+	git commit -m"first commit" &&
+	git rm -rf one &&
+	cp two/file one &&
+	git add one &&
+	git commit -m"second commit"
+'
+
+test_expect_failure '"status" after file replacement should be clean with UC=true' '
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	test-dump-untracked-cache >../actual &&
+	grep -F "recurse valid" ../actual >../actual.grep &&
+	cat >../expect.grep <<EOF &&
+/ 0000000000000000000000000000000000000000 recurse valid
+/two/ 0000000000000000000000000000000000000000 recurse valid
+EOF
+	status_is_clean &&
+	test_cmp ../expect.grep ../actual.grep
+'
+
+test_expect_success '"status" after file replacement should be clean with UC=false' '
+	git config core.untrackedCache false &&
+	git checkout HEAD~ &&
+	status_is_clean &&
+	status_is_clean &&
+	git checkout master &&
+	avoid_racy &&
+	status_is_clean &&
+	status_is_clean
+'
+
 test_done
-- 
2.16.0.47.g3d9b0fac3a


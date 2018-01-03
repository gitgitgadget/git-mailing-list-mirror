Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0631F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeACUtq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:46 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:43673 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeACUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:42 -0500
Received: by mail-wr0-f180.google.com with SMTP id w68so3015422wrc.10
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=77DpaZFl7/g6Ufv5MVrKpwo81rztHU2/eMF351cjCV0=;
        b=MieRHuhEEWSKDWUij7hWxZUFamx9anHyCgs//Q6jJcU/wVxuiBx8Kroz5wjqFkzy0O
         +tkGPitpxT2sHwAQ4zpcSDFdwo4J5JNljMogGbekyD6F9VzW14vP3FLj7q5xwIObPEDx
         qpmoaFJsZMt3ze9CaAWZYqTqYLHLT/XTvanHWIMug90BBnc0R3G1IBGDVGmzVnq5nnHp
         v6um0uEG7YgW+HLVjCBguz4NycHz8Voc5UExPUv4vs1XrTbijR6CHgSBRZ9l4nQUQ0CF
         j7u7uF5XYm2LK+RXq/1/ZFtblgFnKhdY8Mv0arGlxsCxkbyK6f9YAnxdfjihghsCBF7n
         4inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=77DpaZFl7/g6Ufv5MVrKpwo81rztHU2/eMF351cjCV0=;
        b=kT+7NMKbgNO3RWpUtcBJm2WZOt1TpzwAf5uAD/ReEPFdqCVAYEfj4/a0Th0KvUA5O7
         R1MDngFXuNA4xLFhpZkML0Ffl5CIk7qlhXTvRswCUv8ktNCxzRQ4EaYx+aR/E6HcvBRc
         YyYJvXtWuiBTYhAs2Q7KHXzrQpLf1HFalEE382DAs8ZzooUccmNLrQVQsYOP7LPc7GAe
         /8vJonoU/8x+8gDYRYawCShgwgcpCYT/UWVvpmt6dfh300hpNya/nHpSCok12GKcOwqs
         XdLrk1uhx28VElci9243ieKGhI/84EjDacxTGqWI15YGIfgd1ZmtTGfT9HfqxH6gqc89
         XjFA==
X-Gm-Message-State: AKGB3mKA8Th4GtuOj5aotWFTQDoa69UYwvO8lKGrFFI6ce7AntgF+rFF
        zN1museB4NNNYZiwHz0WUAwhoHZ0
X-Google-Smtp-Source: ACJfBot3CmF6J3rMyHgUf/VdfpBxB0GpenQkOmzCJoxstYKfnJSCOgjVCR0/bG73eFCqxGYh2dcIrA==
X-Received: by 10.223.190.135 with SMTP id i7mr2795429wrh.184.1515012580140;
        Wed, 03 Jan 2018 12:49:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] status: add a failing test showing a core.untrackedCache bug
Date:   Wed,  3 Jan 2018 20:49:24 +0000
Message-Id: <20180103204928.3769-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180103204928.3769-1-avarab@gmail.com>
References: <20180103204928.3769-1-avarab@gmail.com>
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.15.1.424.g9478a66081


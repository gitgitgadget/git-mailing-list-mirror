Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DFEC1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeIZEoN (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:13 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39854 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIZEoN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:13 -0400
Received: by mail-ed1-f48.google.com with SMTP id h4-v6so185083edi.6
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0hiLFsi6N+zD69VmUURWdwsROxwb/Narz5T/ytUhcv4=;
        b=EhFOG7Wti0zEL6zDkrEhqwpLPwt55xueqe82woN9YTDCoKXtRjIoIfNoDbeQFTq1xk
         IPQ9AowoWeuJslO2NUn0bnWqE+AjcL1BJLZDi2lJOEQSUiqqfB4ijYbZUawc0PjL9pXN
         7TQHKo+nx/tBQrP2aJ8j3kPUtW/6lgs/vHwrHa7UDep9LMSZuogt+7ElQDD3g3VU1pf5
         jmmbBLe14iIzqmboQgYZbGA09D4ot4DhJz9E2hS08AOKpF/SvR3ujrEZX9WIdz5uyGt+
         rrB5wXe+CaFTvpE0q0NsNx2EfbT89ea+HIASPmCkCw3poGYN9aJBgJcQwWzJEP3tUULI
         dzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hiLFsi6N+zD69VmUURWdwsROxwb/Narz5T/ytUhcv4=;
        b=ZtKGT+p6T/lZM6puEJhxSzFkGvLvO1PBuJENLKDA7lKeOKqTqDIOX5+QNVLvOpea23
         k33aUMdNx9V5mGMXjSx1Ayp1+58EHFsYnBG1MIgxX/ftQ64w9VGGruZao+mmtCb66MPf
         +rCsIMcTM2Nsa0raJ23wi2vJUKiTs9oh7ovLgGPdCIeKmNp8oHmTldGJalQ39A5SLIaZ
         pjv7DWlg5FBF5LsKAafFKJtqKnSBnuhg0AO2HOBZVHoSNhUYe28nXpF6R0xJZRndrK9Y
         dN0tgKpzAjo+SSSrxA/Sm7iWghdxJ8VYHPJOOqaQfTamJRMW7Ce5aeed5JjhPJ77aueL
         5vmA==
X-Gm-Message-State: ABuFfoh58XE9K0ZGXKPIvYyOTVm7RjtCE2UNwdTqP8ICxtFQvLp9rA6Z
        /wIWByHqotYR5BQ4skkE5XozWeea
X-Google-Smtp-Source: ACcGV61LNRqKN4fGEG+CWsJ0rF345RZo3u4wRZgDp3W7PWRh7WlqK1EuvR4yiW3Kn7UkUxPKZV+4Zg==
X-Received: by 2002:a50:d1c7:: with SMTP id i7-v6mr4727129edg.169.1537914866595;
        Tue, 25 Sep 2018 15:34:26 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:25 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v9 05/21] stash: add tests for `git stash show` config
Date:   Wed, 26 Sep 2018 01:33:19 +0300
Message-Id: <fb89d3dfa8ab6a4d1be2aa0e2df6dea5d0d58f43.1537911869.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces tests for `git stash show`
config. It tests all the cases where `stash.showStat`
and `stash.showPatch` are unset or set to true / false.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3907-stash-show-config.sh | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 t/t3907-stash-show-config.sh

diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
new file mode 100755
index 0000000000..10914bba7b
--- /dev/null
+++ b/t/t3907-stash-show-config.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='Test git stash show configuration.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit file
+'
+
+# takes three parameters:
+# 1. the stash.showStat value (or "<unset>")
+# 2. the stash.showPatch value (or "<unset>")
+# 3. the diff options of the expected output (or nothing for no output)
+test_stat_and_patch () {
+	if test "<unset>" = "$1"
+	then
+		test_unconfig stash.showStat
+	else
+		test_config stash.showStat "$1"
+	fi &&
+
+	if test "<unset>" = "$2"
+	then
+		test_unconfig stash.showPatch
+	else
+		test_config stash.showPatch "$2"
+	fi &&
+
+	shift 2 &&
+	echo 2 >file.t &&
+	if test $# != 0
+	then
+		git diff "$@" >expect
+	fi &&
+	git stash &&
+	git stash show >actual &&
+
+	if test $# = 0
+	then
+		test_must_be_empty actual
+	else
+		test_cmp expect actual
+	fi
+}
+
+test_expect_success 'showStat unset showPatch unset' '
+	test_stat_and_patch "<unset>" "<unset>" --stat
+'
+
+test_expect_success 'showStat unset showPatch false' '
+	test_stat_and_patch "<unset>" false --stat
+'
+
+test_expect_success 'showStat unset showPatch true' '
+	test_stat_and_patch "<unset>" true --stat -p
+'
+
+test_expect_success 'showStat false showPatch unset' '
+	test_stat_and_patch false "<unset>"
+'
+
+test_expect_success 'showStat false showPatch false' '
+	test_stat_and_patch false false
+'
+
+test_expect_success 'showStat false showPatch true' '
+	test_stat_and_patch false true -p
+'
+
+test_expect_success 'showStat true showPatch unset' '
+	test_stat_and_patch true "<unset>" --stat
+'
+
+test_expect_success 'showStat true showPatch false' '
+	test_stat_and_patch true false --stat
+'
+
+test_expect_success 'showStat true showPatch true' '
+	test_stat_and_patch true true --stat -p
+'
+
+test_done
-- 
2.19.0.rc0.23.g1c0a08a5d3


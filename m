Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317441F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbeLTTo6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38133 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbeLTTo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so2978838wrw.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6VRjcnBvSrlU4gBKfhbliNQT9yhqphW2VwFgzkHDULY=;
        b=W5uHB146GLek2uzDSzg8AZV644XsKHSGr++FIsq66IXwak/F66n0TnDoxhm4DMJb1O
         IKLKPVED7IKALQW/q0gLr9QNR1fmCjmpQ2ghfzpHNbZvTcBRd592hLYbOy3c+G0xsQcB
         kgXqILYixGXbds9BGY+2qQcWFfO6YkEdJ6joOinEk2tlLy37fzC4KdJ6DJiD8EHL8QPL
         h7v6v/UFWqKm4p2gpfdHdqIgvYG3sJ+htenshoPv6gzd++cZRt+9zGwbSDwcyNaJUo5Y
         5i3oCyPolVkyv03yJnUaifdUjJiCbNVTmCbOS2VX9elcyehq4r7qRjDDoPx/zd++VEXt
         33sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VRjcnBvSrlU4gBKfhbliNQT9yhqphW2VwFgzkHDULY=;
        b=EctE6dVCeM4ETz5s0ZOSYXB09o+OCpHUmfV4iDwoT6CtOBtoMqtQf+gQVoJ2x0ZXYq
         1udARiw1wzVGhxg80IPv7mQNXq5rh9UWnRVutrGVOd6b0UE4rAUeJJER7foPy45dqLe9
         jEbGxiOF+vz2+aNQyKeuKlW1JKzKb76n1EpZ8dchwLzt95Xig0T5VDpfq9b4Yh0TpUoe
         IEKjcTamnQsLMnfKmrMX828gmWkgyo+tcnSHqW+9Tib881HlC/7Yo/Y6Yv2imP7lBRXq
         RDAHOplVLVbkM4COgm+ZgPdE9z0Aqz4JpXR0vXx5t/8oFacpFaFYb3h4fkzvuxNSEx2L
         Wk0g==
X-Gm-Message-State: AA+aEWa6y5sJx0pdM3iIM/sjqUJ4NsJJjMq9vO8dRASraTBqpTomtAM/
        as+94C85xVoSMx2ct4VhgLYzcBetWsU=
X-Google-Smtp-Source: AFSGD/UQe9D1ZD1EsBOG4IbLxhfyk37t3tOU32Cf3hTBfsDSS56uNfbLTWqlO97CBz8udQnOMDvD9g==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr9989947wre.244.1545335096173;
        Thu, 20 Dec 2018 11:44:56 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:55 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 08/26] stash: add tests for `git stash show` config
Date:   Thu, 20 Dec 2018 21:44:24 +0200
Message-Id: <29c2db2e73bae6b8249a5b4d73ce784a4c861953.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
2.20.1.441.g764a526393


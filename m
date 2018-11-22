Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837111F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439023AbeKWJr7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32855 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439015AbeKWJr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id 79so10466215wmo.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGn7OHoV1E2uOEwZYOatdNV1UspxvvVTuBJneQzAoTM=;
        b=S6tcEPeGXXk0DxuoK3KpnhEslc16qdIu90Ngt9s6UQ/OF2XOioNqjg3q17W3zGz9+s
         8YDax+p7yJO/3b2zgA5fpw0K3fO3g/ndiiv2LDqpJ9Biuy1e14IEYwll15usDNHlkW0+
         cVne45L/uDusKeImeJGGTo2rZJtkzY08Cm5ynMvm7AZ8E8jpZ4tqVIhkxXqTj1G99RIT
         tMVJmjBvT2Xo8xqeJZuYp8KoMnvvZFdbPJ60X5d/vElPyIrRArp+DV61+LBekwV5di+O
         HgznMg+Cx46W7WzKmacAeT4SIyI26CGiakL0+IpJlVftz3n0++5pMUNznHFXDi5sg5r/
         Y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGn7OHoV1E2uOEwZYOatdNV1UspxvvVTuBJneQzAoTM=;
        b=MGi3JWD4HgjFJpmsSIrMvi6vRZ4IhtOwiZhlA7i2FVxQyTQkDmizy4XBhvoln6ltoS
         dzFxWzNAyPlLrIyJ9jUQwlyiNLPqXC4y5aw9F7B8JKOaHV6jT86iKYMSmpUFLcbEkCfb
         Mp7SzO2bqMXbX4IsAadfZbZaZoZGEkX1/xLWSpIXa8uvqReBIMXBc3neHx/7sL4HcMTm
         yeiKwbYUAa0fwiwzKe3nhUWdBchaXvkTjLfAMoxttlFTlBAjOju8VwoJBPjCXkC/ghmF
         qFeHW76nAsmRqbLPLsvYxaFtijPuIHvcwgWWy7WMxvSvaotB1D/O3HuSYn4yzRtVE++t
         HxLQ==
X-Gm-Message-State: AGRZ1gJFr1rphlx03klaqJGbdoRre5JQuf27llWsodxojbvJ29JQw8bo
        c8PBhY+KxrhvYs88XpxpKRXbe+FF
X-Google-Smtp-Source: AJdET5e1ZHger6dsXfBHr9aG4by4udP/N3M+VsRb8mNFO+mEfbqfXWswzw/utIaEcO8mxtnzrsaCtg==
X-Received: by 2002:a1c:6283:: with SMTP id w125-v6mr11983357wmb.117.1542927978381;
        Thu, 22 Nov 2018 15:06:18 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:17 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 07/22] stash: add tests for `git stash show` config
Date:   Fri, 23 Nov 2018 01:05:27 +0200
Message-Id: <1b0d546c452872d45d8fc9e648855ef5c17eb7fb.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
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
2.19.1.878.g0482332a22


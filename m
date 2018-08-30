Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153331F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHaBp4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40958 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so3410764wme.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/hUYF0eD4bC++PZhTahdexEjNVpsQok5ks3MlAx/E90=;
        b=Nc6WvxrzchTeM+OA7p3ZWRJEGI7f2/y0aqTs6bRun9p3vTuXAT5P8K1N4qPizkGPsV
         6XtYmrkTFh7fuoxchKHC3lY2CcV13wKoD6vzrqjdxphdhQKtWbb2kJh0bcegXb1AL8ZU
         DEe+iyb+DpjOxWI6XoHlSQxah1dEVSVRU/QrfdaCpBHmgZRTOImw8UBuq/3H3VaXhw4C
         p0vbN35T1QuLE6So+HpbtEk7D9Pc1CyNwYDhmCb01G7IZ2UV9xVLqSyZs3OiVd5LrWiA
         3cSfpyId2wyxQQTDHTkXF/rSo+jMLJMqHXbCCLJUdhCLqV7aBSZO68BmyCYijcrhGp0S
         bkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hUYF0eD4bC++PZhTahdexEjNVpsQok5ks3MlAx/E90=;
        b=qN3VC+jbbBnr5owJLu13C6zQlznhMtgJg2qJ0bbc0usyZIkhdAGEiej0d+JeEIRO2E
         yBkCt1J4HFKP6UDWb8T1HMfL789gkOgu5H0EIbAEgNEbOIIJcTZbMDBfoKUpcZUXAf5k
         HpDA7dVELHNNCqoeWdagXk98xsxzEi5gj5pz8slJMJMA1xfN7D6QBgl1Od4SW6nxy/vR
         a/xByLZuWkvA8bblidVZFTC3xRwv2Njbt1dtNYZa8Q7oFIrqeuxi/ixI5naQObVobFkZ
         N/RHenSzpyeopdmtmzq91u1N7jBhvwNejG5Ekuoqvbdo4RjjVhrq0xc8akVjZRCCX9Eb
         zBLw==
X-Gm-Message-State: APzg51DO8lwMaJR8t3TK4WD+cBiM1/VSq8h2mBqHqTjRK56ryshYNkQl
        rGpfzZIAp+pvMQU1PC9Wav3pm/3y
X-Google-Smtp-Source: ANB0Vdb93q2eqP7NZD662sFfUgm0pIfyQXJxS9cd3ll+fpHjYo8SldPYbodYsn3mn8FSb8cJWE+6kQ==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr2888909wmt.55.1535665302742;
        Thu, 30 Aug 2018 14:41:42 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:42 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 05/20] stash: add tests for `git stash show` config
Date:   Fri, 31 Aug 2018 00:40:35 +0300
Message-Id: <65603caf56cfaeb1dff92546b7efe38dccb2d071.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
 t/t3907-stash-show-config.sh | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 t/t3907-stash-show-config.sh

diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
new file mode 100755
index 0000000000..8fe369c1a1
--- /dev/null
+++ b/t/t3907-stash-show-config.sh
@@ -0,0 +1,81 @@
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
+		test_might_fail git config --unset stash.showStat
+	else
+		test_config stash.showStat "$1"
+	fi &&
+
+	if test "<unset>" = "$2"
+	then
+		test_might_fail git config --unset stash.showPatch
+	else
+		test_config stash.showPatch "$2"
+	fi &&
+
+	shift &&
+	shift &&
+	echo 2 >file.t &&
+	git diff "$@" >expect &&
+	git stash &&
+	git stash show >actual &&
+
+	if test -z "$1"
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
2.19.0.rc0.22.gc26283d74e


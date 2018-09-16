Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08D41F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeIPNMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 09:12:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:42015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbeIPNMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 09:12:14 -0400
Received: from p2520la.lan ([79.218.121.221]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1gLv2b2feo-00WaDE; Sun, 16
 Sep 2018 09:50:03 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [PATCH v5 3/3] t0014: Introduce an alias testing suite
Date:   Sun, 16 Sep 2018 09:50:02 +0200
Message-Id: <20180916075002.3303-3-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180916075002.3303-1-timschumi@gmx.de>
References: <20180907224430.23859-1-timschumi@gmx.de>
 <20180916075002.3303-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g+4ev5dXDuJBh20zOw/EAYQNJmFl675woyjKBNjPxQpX0O0pJNE
 wECZoVenFom6gkTc/s3bVR0mWQWzcJ/XMNBQF2raQ5KpaH/ZtFjXZikd6TmZoQPq/uEMJg/
 7xI3g+ekOay7z4slU82KtzxCaT3ynu3X5fc9LBngr+K31ltc79DDW/Y9ovT290olea/6gbv
 l/zwIyQsSFTxn/SJJw8Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ojTy+mK7tI=:vyrBNmmO7CxYXnoihaDgkg
 xZWfNILvj/+ZEV2hemejymYbOt6CKQhInpZoM5Jv6AdQLLzH7NLizKwsUhWyOIKU6aFEbWrZo
 ipJtsQKQNLsl28RUzvu481TT7eTxmnVh8i54LCCz+caUEoETHnoNhv0w1hxX3ZTq80tWLTZE2
 5zbI3SsCnq10J+tQk1KbXsj//NgRRFT/s4ckpcWlkR3Ljk/ik/uZEJV9WpEjQW0MXvD2ttu+O
 U3v7B8UuTAxLM+ItmIomvIpAT5sL5m6JtWloYdFKW65sSv11m+uGtnLnOUlxDIUED13TQDRJF
 GME/qshnm67IgP7et+AlCg5cZH1ODUX8mWp8jpzCul/l7XYpmFGw46erzDQRI4hGSohrHUOhk
 nQ8yAvC/ENTZeudz6wuyNpq5y8HRM+Gpo8ayACdPrpaX1lC7yj2hiXMKKU2rA7692TOygav+1
 nKCjkC8d0bScO7Q7iDEUPiCucQo3DOZxPht6odIuxLyiN5ZbIhoxdZnDGoaaDgoXOxBhUAk8E
 18RfEt3kOby2m0vAOBQctUoFMgysedTsl2b/a3xjBXA+cUZCPtBxcyUaqTnPJRZ7J35mZTUjc
 GxcKTJCpai51/KcpVvWWNxUtOoVx6oj2zV/x6O5N5wvK52EEHcHixB8TiAFsW0DBuCeacqBsM
 JkWCzDhRVqc6vM35dWMl926yH3n1DWy2uK9zv/TQBngxzpTHfMj4qWC1BSNR+tnv0jui3XVFN
 3g/TcLY6VRL4YJbTFoQ8brIOv8XUpkk7Xsi074q9L3cZe/kp6VfQsX+W6iFNX7zHzB5Ho71Vg
 +/P88Yvqm6BAgcRBTMXLcIu4gQdUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a testing suite that is dedicated to aliases.
For now, check only if nested aliases work and if looping
aliases are detected successfully.

The looping aliases check for mixed execution is there but
disabled, because it is blocking the test suite for a full
minute. As soon as there is a solution for loops using
external commands, it should be enabled.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
Changes since v4:
 - Actually execute a command in the first two cases
 - Remove the "setup code"
 - Use i18ngrep to match the part of a message
 - Comment out the last test

 t/t0014-alias.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t0014-alias.sh

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
new file mode 100755
index 000000000..a070e645d
--- /dev/null
+++ b/t/t0014-alias.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git command aliasing'
+
+. ./test-lib.sh
+
+test_expect_success 'nested aliases - internal execution' '
+	git config alias.nested-internal-1 nested-internal-2 &&
+	git config alias.nested-internal-2 status &&
+	git nested-internal-1 >output &&
+	test_i18ngrep "^On branch " output
+'
+
+test_expect_success 'nested aliases - mixed execution' '
+	git config alias.nested-external-1 nested-external-2 &&
+	git config alias.nested-external-2 "!git nested-external-3" &&
+	git config alias.nested-external-3 status &&
+	git nested-external-1 >output &&
+	test_i18ngrep "^On branch " output
+'
+
+test_expect_success 'looping aliases - internal execution' '
+	git config alias.loop-internal-1 loop-internal-2 &&
+	git config alias.loop-internal-2 loop-internal-3 &&
+	git config alias.loop-internal-3 loop-internal-2 &&
+	test_must_fail git loop-internal-1 2>output &&
+	test_i18ngrep "^fatal: alias loop detected: expansion of" output
+'
+
+# This test is disabled until external loops are fixed, because would block
+# the test suite for a full minute.
+#
+#test_expect_failure 'looping aliases - mixed execution' '
+#	git config alias.loop-mixed-1 loop-mixed-2 &&
+#	git config alias.loop-mixed-2 "!git loop-mixed-1" &&
+#	test_must_fail git loop-mixed-1 2>output &&
+#	test_i18ngrep "^fatal: alias loop detected: expansion of" output
+#'
+
+test_done
-- 
2.19.0.rc2.1.g4c98b8d69.dirty


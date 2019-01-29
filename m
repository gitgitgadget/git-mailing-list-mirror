Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32921F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfA2VTP (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:19:15 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:49856 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfA2VTP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 16:19:15 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb9fZ006222;
        Tue, 29 Jan 2019 11:39:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=M590GK2Vu9r+g0hLsDJzDkY5ClZQpEvC/8+KOESX+OA=;
 b=IYPQ/UqyYyqXzPmODCTRQ6r5JUdNK/DPVh+M2mIAD+NMTcDoYe1brZKH/F60nmqki86Z
 onXb6Ns0wnOP+2LtkNA9N0ElhPCffr+c0jRXDcii879tjSHlQUTf6NT1Dkc6bhy5693G
 IxQgJ5LzAoHKy13JIfp0m+TpO1xshQKnM2SrPXbwe+PfIy3a45x7dW3emZH3ZUa42jxM
 SGqQ+2PNRL2RBR4BMeVQFXK5idpveCG2tXAsjUF0+Gui9J3tuVEO+ayB0jZBcEpiKniq
 /HsIHz65Co++pZPFW7Gay4jlhvZ7mVCN2NTv1n2DQD9X6d6mGBTPgzCFolDzrUTJmRlC Ug== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9832j51y-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:36 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300G47YLXUYE0@ma1-mtap-s01.corp.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9PJK00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 8e0fa9800c58351f1c85d9dbec811360
X-Va-R-CD: f1724aed3bccb82585006345fc1fd7ab
X-Va-CD: 0
X-Va-ID: fee1f0b0-06cc-49bc-a679-23b131f6f829
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 8e0fa9800c58351f1c85d9dbec811360
X-V-R-CD: f1724aed3bccb82585006345fc1fd7ab
X-V-CD: 0
X-V-ID: 6b7cc972-e4fb-4bff-b647-8f82312ef5a4
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 03/13] t0500: New regression test for git add of a
 path that contains a .git directory
Date:   Tue, 29 Jan 2019 11:38:09 -0800
Message-id: <20190129193818.8645-4-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 t/t0500-apple.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t0500-apple.sh

diff --git a/t/t0500-apple.sh b/t/t0500-apple.sh
new file mode 100755
index 0000000000..d5f79237a8
--- /dev/null
+++ b/t/t0500-apple.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2012-2016 Apple Inc.
+#
+# Tests for regressions found by Apple Inc. for issues that upstream does not
+# want to fix or accept tests for.
+
+
+test_description='Apple Inc. specific tests'
+
+. ./test-lib.sh
+
+TESTROOT=$(pwd)
+
+# <rdar://problem/10238070>
+#
+# This test case addresses a regression introduced between v1.7.3 and v1.7.5
+# git bisect good v1.7.3
+# git bisect bad v1.7.5
+# ...
+# found 18e051a3981f38db08521bb61ccf7e4571335353
+
+test_expect_success '<rdar://problem/10238070> -- git add of a path that contains a .git directory' '
+	rm -rf .git &&
+	mkdir -p orig/sub/dir/otherdir &&
+	cd orig/sub &&
+	echo "1" > dir/file &&
+	echo "2" > dir/otherdir/file &&
+	git init --quiet &&
+	git add -A &&
+	git commit -m "Initial Commit" --quiet &&
+	cd - > /dev/null &&
+	git init --bare --quiet "${TESTROOT}/git_dir.git" &&
+	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/sub/" &&
+	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ add -f -- "${TESTROOT}/orig/" &&
+	git --git-dir="${TESTROOT}/git_dir.git" --work-tree=/ commit -m "Commit." |
+		grep -q "2 files changed, 2 insertions"
+'
+
+test_done
-- 
2.20.0 (Apple Git-115)


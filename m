Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F168720209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdGAScY (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:24 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59137 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbdGAScX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:23 -0400
X-AuditID: 1207440c-c65ff70000001e54-3b-5957eab62832
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BA.2E.07764.6BAE7595; Sat,  1 Jul 2017 14:32:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBg010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 29/30] t3210: add some tests of bogus packed-refs file contents
Date:   Sat,  1 Jul 2017 20:31:07 +0200
Message-Id: <70b7e80537793270c4e3a01358f3922090b8b3be.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvtVXikwYHDkhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGVc/exTsFSgYuaHS6wNjG94uxg5
        OSQETCSu7Ghg6mLk4hAS2MEksbN3MwuEc5JJ4sq1RjaQKjYBXYlFPc1MILaIgJrExLZDYEXM
        ApOYJd5eWwiWEBYIkvjb9ATMZhFQlXi+ZSOYzSsQJbHqykxWiHXyErvaLoLZnAIWEn/a1jOD
        2EIC5hLNB/tYJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREnQ8
        Oxi/rZM5xCjAwajEw7shJCxSiDWxrLgy9xCjJAeTkijvymuhkUJ8SfkplRmJxRnxRaU5qcWH
        GCU4mJVEeHOfh0cK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeJmA
        0SUkWJSanlqRlplTgpBm4uAEGc4DNHzhXZDhxQWJucWZ6RD5U4zGHHN+7/jCxPFqwv9vTEIs
        efl5qVLivK0vgUoFQEozSvPgpsESxytGcaDnhHkZQJbyAJMO3LxXQKuYgFYJzwgBWVWSiJCS
        amD0tDV3XK/9aYHhda07jUyS1m88drmmdpe0Bi+ZtP3syebUPWWBYfdMPWym26x1OeLTcb5k
        2kbbGJ0mNed6CYO4pkcrhZ79igudZvJZLPqkophWrqT1pOfXYiN3aKvYnE0sL37Xqvqaha96
        zux4Bu7GLKM9/F3nlyo21s/h8++/LRtqdkLgshJLcUaioRZzUXEiAP5uVtH3AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `packed-refs` contains indecipherable lines, we should emit an
error and quit rather than just skipping the lines. Unfortunately, we
currently do the latter. Add some failing tests demonstrating the
problem.

This will be fixed in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3210-pack-refs.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 9b182a0c32..4b65836283 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -194,6 +194,33 @@ test_expect_success 'notice d/f conflict with existing ref' '
 	test_must_fail git branch foo/bar/baz/lots/of/extra/components
 '
 
+test_expect_failure 'reject packed-refs with unterminated line' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
+	echo "fatal: unterminated line in .git/packed-refs: $HEAD refs/zzzzz" >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
+test_expect_failure 'reject packed-refs containing junk' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%s\n" "bogus content" >>.git/packed-refs &&
+	echo "fatal: unexpected line in .git/packed-refs: bogus content" >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
+test_expect_failure 'reject packed-refs with a short SHA-1' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
+	printf "fatal: unexpected line in .git/packed-refs: %.7s %s\n" $HEAD refs/zzzzz >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
 test_expect_success 'timeout if packed-refs.lock exists' '
 	LOCK=.git/packed-refs.lock &&
 	>"$LOCK" &&
-- 
2.11.0


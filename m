Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83E11FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbdJZITH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:19:07 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64140 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932162AbdJZITB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 04:19:01 -0400
X-AuditID: 12074411-f95ff70000007f0a-be-59f19a73ad40
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 34.AB.32522.37A91F95; Thu, 26 Oct 2017 04:18:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCA47.dip0.t-ipconnect.de [87.188.202.71])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9Q8IuW8030384
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 26 Oct 2017 04:18:58 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] t0000: check whether the shell supports the "local" keyword
Date:   Thu, 26 Oct 2017 10:18:53 +0200
Message-Id: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsUixO6iqFsy62OkwcY8i64r3UwWDb1XmC1u
        r5jPbPGjpYfZ4sybRkYHVo+/7z8weTzr3cPocfGSssfiB14enzfJBbBGcdmkpOZklqUW6dsl
        cGWsmLmfueAYf8WtG91sDYyPeboYOTkkBEwkVlx4y9rFyMUhJLCDSeLz9GXMIAkhgZNMEnM+
        GoPYbAK6Eot6mplAbBEBNYmJbYdYQBqYBXoZJbqe/GABSQgL+EjMOrSXDcRmEVCV+Dn9ECOI
        zSsQJfH82kcWiG3yEuce3GaewMi1gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZole
        akrpJkZIGAjuYJxxUu4QowAHoxIP74ePHyKFWBPLiitzDzFKcjApifIy7AEK8SXlp1RmJBZn
        xBeV5qQWH2KU4GBWEuG9M+NjpBBvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxW
        hoNDSYK3bSZQo2BRanpqRVpmTglCmomDE2Q4D9BwaZAa3uKCxNzizHSI/ClGY46Om3f/MHE8
        m/m6gVmIJS8/L1VKnHcjSKkASGlGaR7cNFgsv2IUB3pOmHchSBUPMA3AzXsFtIoJaFWT6geQ
        VSWJCCmpBsY4jo0nzhyYuuGjqtKOZtX3S5ky06zUtvxt38g35XaT5/aNBxN3L4zY8c/GUJRB
        dYKS5uU1P/9/tOGPdVMw2mHxR2yjnaIj7/XthcsM+4ruR2qbPV+TIvb4W0zyMu677ZMezP75
        UDyrt/r//jPTL3ZYPzmhdab6eMj+43fXHY3nqubreJj7qdlUiaU4I9FQi7moOBEAC37PVsAC
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test balloon to see if we get complaints from anybody who is
using a shell that doesn't support the "local" keyword. If so, this
test can be reverted. If not, we might want to consider using "local"
in shell code throughout the git code base.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This has been discussed on the mailing list [1,2].

Michael

[1] https://public-inbox.org/git/CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com/
[2] https://public-inbox.org/git/20160601163747.GA10721@sigill.intra.peff.net/

 t/t0000-basic.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 1aa5093f36..7fd87dd544 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -20,6 +20,31 @@ modification *should* take notice and update the test vectors here.
 
 . ./test-lib.sh
 
+try_local_x () {
+	local x="local" &&
+	echo "$x"
+}
+
+# This test is an experiment to check whether any Git users are using
+# Shells that don't support the "local" keyword. "local" is not
+# POSIX-standard, but it is very widely supported by POSIX-compliant
+# shells, and if it doesn't cause problems for people, we would like
+# to be able to use it in Git code.
+#
+# For now, this is the only test that requires "local". If your shell
+# fails this test, you can ignore the failure, but please report the
+# problem to the Git mailing list <git@vger.kernel.org>, as it might
+# convince us to continue avoiding the use of "local".
+test_expect_success 'verify that the running shell supports "local"' '
+	x="notlocal" &&
+	echo "local" >expected1 &&
+	try_local_x >actual1 &&
+	test_cmp expected1 actual1 &&
+	echo "notlocal" >expected2 &&
+	echo "$x" >actual2 &&
+	test_cmp expected2 actual2
+'
+
 ################################################################
 # git init has been done in an empty repository.
 # make sure it is empty.
-- 
2.14.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C4E20899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdHNUQu (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:16:50 -0400
Received: from mout.web.de ([212.227.15.14]:49993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdHNUQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:16:48 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnBD3-1d7UD92g4D-00hNsn; Mon, 14
 Aug 2017 22:16:34 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, Benoit Lecocq <benoit@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t1002: stop using sum(1)
Message-ID: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
Date:   Mon, 14 Aug 2017 22:16:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:b/6uHA5DrM/1fl6DgEKZojdaU9FAfjSzDmGFxNOy8jQp7cvGOuN
 y5EdmFK0z6c6Kg0YmLf4y4y0ktA49PIM9GguRo6pHJWgBZkVgDPDyj53SXMiatF/ihw4i61
 RO/m+yr9NtFdr+uDmKqWOyaighq4lCfJ14AGC1mfnAZWbLCmvPR8eQvW8NMogNnqHlE5ycE
 bt60ZJuR+vxaiL58+Yq3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QKF0cVCz7QQ=:hWH5lx3iubuSWe0jqHuG3W
 MXwjeqtq2rPWaa1xXjk/5MZL0nSmR5p/s2L9pT5XKd/ocridt3HC4XghaPd9k1vz4IvoVo8E3
 YWBHNK+kRyCTrdlR2iWJFzCTIUF2pUC7nxvL3iRbk9x+u6z1+cmawDsR4PNb4gY9FIqsIMNbp
 YclUmWtIUZwQyb2pzhNDWK4OS/e4Ji0cO74s+KAJpod2ZU2ZvyWtn/J+JBDikTwyr+38fFc6u
 1nTXt3IcFCsvxoSMZT1vWtMAelFU4VWe+bPY7aOPJ0YCq9ivaTX7GVqbOjMl95crqY6Zp9oIE
 WR3tg3y17PKdkO/AOelVpb3orElrr236vCTR9X7BCjFvLxyp27/ilk8EsIhWCLc5Cz/IVKK8I
 RPVVYsXg+ZBNR/82rUDriTSeQ9qBslh5dyVM+Zln+zKISa9ckLH/soFe/ihKNJa7aGLyLUcuG
 3bOL5hojImb4V8BeRQkwR0dONG7EFzmVzcX16HmfzgptjybpJMdkZD5DzVCwkdTeyza/ub1Sa
 H8ArB9o0M/6iN0aodxHc8P8NN7TcduXxLo8idAPWBLgMUDvVvQYoUOA4Ewcbh94OdDupeKHBP
 EDV3VZKxSrYl8sntdhfLXNj1IIMUbnm/lqPKb6c7vEf8wOkK+5z+F1UOHP4Thh4fXvNyqN28M
 5z67scI15OFFbHvz4OrDga7KDsgBM6Ui5/wB9SCGFq7IWr6/gDxE6+7ZEj1KFvOci2lVmyJFL
 BNJUW+4lNSNBNwa+UuDzVrGCWuHGmV9ZBlIPdBTwTXOJWH4lxRUiBXXcFU6Y0XjAsIMyXtxHe
 +M4kX49r5M7rAPgGlw1WVrhj2Sal0WufHv0Gty8hd/iEWytfuo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sum(1) is a command for calculating checksums of the contents of files.
It was part of early editions of Unix ("Research Unix", 1972/1973, [1]).
cksum(1) appeared in 4.4BSD (1993) as a replacement [2], and became part
of POSIX.1-2008 [3].  OpenBSD 5.6 (2014) removed sum(1).

We only use sum(1) in t1002 to check for changes in three files.  On
MinGW we use md5sum(1) instead.  We could switch to the standard command
cksum(1) for all platforms; MinGW comes with GNU coreutils now, which
provides sum(1), cksum(1) and md5sum(1).  Use our standard method for
checking for file changes instead: test_cmp.

It's more convenient because it shows differences nicely, it's faster on
MinGW because we have a special implementation there based only on
shell-internal commands, it's simpler as it allows us to avoid stripping
out unnecessary entries from the checksum file using grep(1), and it's
more consistent with the rest of the test suite.

We already compare changed files with their expected new contents using
diff(1), so we don't need to check with "test_must_fail test_cmp" if
they differ from their original state.  A later patch could convert the
direct diff(1) calls to test_cmp as well.

With all sum(1) calls gone, remove the MinGW-specific implementation
from test-lib.sh as well.

[1] http://minnie.tuhs.org/cgi-bin/utree.pl?file=V3/man/man1/sum.1
[2] http://minnie.tuhs.org/cgi-bin/utree.pl?file=4.4BSD/usr/share/man/cat1/cksum.0
[3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cksum.html
---
 t/t1002-read-tree-m-u-2way.sh | 67 ++++++++++++++++++++++---------------------
 t/test-lib.sh                 |  3 --
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index e3bf821694..7ca2e65d10 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -51,7 +51,9 @@ test_expect_success \
      treeM=$(git write-tree) &&
      echo treeM $treeM &&
      git ls-tree $treeM &&
-     sum bozbar frotz nitfol >M.sum &&
+     cp bozbar bozbar.M &&
+     cp frotz frotz.M &&
+     cp nitfol nitfol.M &&
      git diff-tree $treeH $treeM'
 
 test_expect_success \
@@ -61,8 +63,9 @@ test_expect_success \
      read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >1-3.out &&
      cmp M.out 1-3.out &&
-     sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol &&
      check_cache_at bozbar clean &&
      check_cache_at frotz clean &&
      check_cache_at nitfol clean'
@@ -79,8 +82,9 @@ test_expect_success \
      test_might_fail git diff -U0 --no-index M.out 4.out >4diff.out &&
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
-     sum bozbar frotz nitfol >actual4.sum &&
-     cmp M.sum actual4.sum &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol &&
      echo yomin >yomin1 &&
      diff yomin yomin1 &&
      rm -f yomin1'
@@ -98,8 +102,9 @@ test_expect_success \
      test_might_fail git diff -U0 --no-index M.out 5.out >5diff.out &&
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
-     sum bozbar frotz nitfol >actual5.sum &&
-     cmp M.sum actual5.sum &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol &&
      : dirty index should have prevented -u from checking it out. &&
      echo yomin yomin >yomin1 &&
      diff yomin yomin1 &&
@@ -115,8 +120,9 @@ test_expect_success \
      git ls-files --stage >6.out &&
      test_cmp M.out 6.out &&
      check_cache_at frotz clean &&
-     sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol &&
      echo frotz >frotz1 &&
      diff frotz frotz1 &&
      rm -f frotz1'
@@ -132,8 +138,8 @@ test_expect_success \
      git ls-files --stage >7.out &&
      test_cmp M.out 7.out &&
      check_cache_at frotz dirty &&
-     sum bozbar frotz nitfol >actual7.sum &&
-     if cmp M.sum actual7.sum; then false; else :; fi &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp nitfol.M nitfol &&
      : dirty index should have prevented -u from checking it out. &&
      echo frotz frotz >frotz1 &&
      diff frotz frotz1 &&
@@ -165,8 +171,10 @@ test_expect_success \
      read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >10.out &&
      cmp M.out 10.out &&
-     sum bozbar frotz nitfol >actual10.sum &&
-     cmp M.sum actual10.sum'
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol
+'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -209,11 +217,8 @@ test_expect_success \
      git ls-files --stage >14.out &&
      test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
-     sum bozbar frotz >actual14.sum &&
-     grep -v nitfol M.sum > expected14.sum &&
-     cmp expected14.sum actual14.sum &&
-     sum bozbar frotz nitfol >actual14a.sum &&
-     if cmp M.sum actual14a.sum; then false; else :; fi &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
      check_cache_at nitfol clean &&
      echo nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
@@ -231,11 +236,8 @@ test_expect_success \
      test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
-     sum bozbar frotz >actual15.sum &&
-     grep -v nitfol M.sum > expected15.sum &&
-     cmp expected15.sum actual15.sum &&
-     sum bozbar frotz nitfol >actual15a.sum &&
-     if cmp M.sum actual15a.sum; then false; else :; fi &&
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
      echo nitfol nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
      rm -f nitfol1'
@@ -267,8 +269,10 @@ test_expect_success \
      git ls-files --stage >18.out &&
      test_cmp M.out 18.out &&
      check_cache_at bozbar clean &&
-     sum bozbar frotz nitfol >actual18.sum &&
-     cmp M.sum actual18.sum'
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol
+'
 
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
@@ -281,11 +285,8 @@ test_expect_success \
      git ls-files --stage >19.out &&
      test_cmp M.out 19.out &&
      check_cache_at bozbar dirty &&
-     sum frotz nitfol >actual19.sum &&
-     grep -v bozbar  M.sum > expected19.sum &&
-     cmp expected19.sum actual19.sum &&
-     sum bozbar frotz nitfol >actual19a.sum &&
-     if cmp M.sum actual19a.sum; then false; else :; fi &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol &&
      echo gnusto gnusto >bozbar1 &&
      diff bozbar bozbar1 &&
      rm -f bozbar1'
@@ -300,8 +301,10 @@ test_expect_success \
      git ls-files --stage >20.out &&
      test_cmp M.out 20.out &&
      check_cache_at bozbar clean &&
-     sum bozbar frotz nitfol >actual20.sum &&
-     cmp M.sum actual20.sum'
+     test_cmp bozbar.M bozbar &&
+     test_cmp frotz.M frotz &&
+     test_cmp nitfol.M nitfol
+'
 
 test_expect_success \
     '21 - no local change, dirty cache.' \
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b6e53f78a..51f52dcd4e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -991,9 +991,6 @@ case $uname_s in
 	find () {
 		/usr/bin/find "$@"
 	}
-	sum () {
-		md5sum "$@"
-	}
 	# git sees Windows-style pwd
 	pwd () {
 		builtin pwd -W
-- 
2.14.1

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583231F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbcHALiK (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:38:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:64529 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbcHALiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:38:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1auqpw37AH-00ZjAP; Mon, 01 Aug 2016 13:36:37
 +0200
Date:	Mon, 1 Aug 2016 13:36:29 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 01/16] t5520: verify that `pull --rebase` shows the helpful
 advice when failing
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <aa807cf08ddfd45d5a1339825ddec24071cabc01.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q7/MfXWSO2ZlLA0v6mzpdbX83ItrWtiz1b6W8WD5QCJozeCD1qI
 JZyfr7NBI5O9aeZd5dzIBApYxHktMQVuoYG0TkFwMl+4PnXz7v+Tn6haOVn8BXhm9E8Tce+
 dvD83IareIyNu2s0XMGWrI0+1dmX7HvVCdkTmpdg78EXlKQNHWWSoGO3WCeeVUq2fT8oBSo
 q0mLP5ip8Al4FdXh2aR9A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:GVhA3KqCfuE=:4fRSt1iPM8zNstRISZHsxU
 NlsyCkHcgZ3+vOWfkIbP9crCppMPF0fhSszhTAJZKq/H2gs94PxRUIXkhjNJjEpd61xlF81FT
 NB5MYrW9Gmrz5ncU8RgPWBRUpyvYFlNo/jWK8Xb0nBRKoBlqGAtdqyZWydo3vXuIokrtgcyUa
 +Db/ncSfQz+cKE9of3lN7By5NXTW18aEKNUmJpdhPSptfuoNVyqqtTzYxzxxvnlwWYEY2w+va
 HcSsvmhuyH28vHbxqSSIZ1kM6Eqy8849sc1LwuuUgWBRyF/rHvBbj+sPyeorRt8gufjmGgd95
 Ko9fX4R5OR8MwocbfscuiFJAmkHkF9iCWilsT9m/sJGSVIc/vxt5tOeDp5Woiq8muAP0UYr+m
 DqrQa9soIqkO7r9cUgm/XIv0P94e9YdnEdOgJiE22fufm3DJNEID2HD5VzITVrzcFax7v+6fS
 lH9yqEl86q+xtecqy8YSyuhstNgmK43VpOzqMQeESUluuup+fY9fO27WSqvH0Vsu5k4G0yK2D
 a7NunY0LLIbt4e75Vo5Y80Q/i9RvlHcA6uGzFl8No6tuyYhg/8NW3/f6+CW9Jnxrh1qXQ+Cq/
 kHDYS25Bi70+P4iqQcqs8g4aslHoqHSRPqzpwVbGW1zBCffUyBK7oD/BrbaBgfylZS5jgCHLC
 CN+FpWVe5eHLJTcN7J5AngZ/GC61leiqvSKG4vF5RYybn+42cWRSb+7tLPLEmYhupg1zFbEd4
 6jCFwDVd42UqjQe+Vq5JQJVwfEgeEkRROYj5m7RU13694QScKSMgKLtxII3qPeVh8JsrPXtGK
 jPPA1Sx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It was noticed by Brendan Forster last October that the builtin `git am`
regressed on that. Our hot fix reverted to spawning the recursive merge
instead of using it as a library function.

As we are about to revert that hot fix, after making the recursive merge a
true library function (i.e. a function that does not die() in case of
"normal" errors), let's add a test that verifies that we do not regress on
the same problem which made the hot fix necessary in the first place.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 37ebbcf..6ad37b5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,38 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase with conflicts shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b seq &&
+	test_seq 5 >seq.txt &&
+	git add seq.txt &&
+	test_tick &&
+	git commit -m "Add seq.txt" &&
+	echo 6 >>seq.txt &&
+	test_tick &&
+	git commit -m "Append to seq.txt" seq.txt &&
+	git checkout -b with-conflicts HEAD^ &&
+	echo conflicting >>seq.txt &&
+	test_tick &&
+	git commit -m "Create conflict" seq.txt &&
+	test_must_fail git pull --rebase . seq 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
+test_expect_success 'failed --rebase shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
+	# force checkout because `git reset --hard` will not leave clean `file`
+	git checkout -f -b fails-to-rebase HEAD^ &&
+	test_commit v2-without-cr file "2" file2-lf &&
+	test_must_fail git pull --rebase . diverging 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-- 
2.9.0.281.g286a8d9



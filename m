Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61ECA2018D
	for <e@80x24.org>; Thu, 11 May 2017 13:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbdEKNsP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:56407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932769AbdEKNsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:48:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlDb4-1dhbEQ4Axq-00b30a; Thu, 11
 May 2017 15:47:57 +0200
Date:   Thu, 11 May 2017 15:47:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/11] PREVIEW: t5516: stop testing .git/branches/
 functionality
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <6211d3073605233299c48719d9f0feeb618217a2.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vRjzSIdWA0CF4six0pnuQDAGNF60Ug+b0no5ieEK8RnUnvpQ6u5
 5yR95oNdOP+zdN4xFQtnM9/Kpk9CgfTc6sh6CrZygjnN0OB45+KcWzaMQx5HIlj7flLbrA+
 O935JBhEwi82bjSD2Q39FyNFjr7NyICuK9METpho7t3FXkJ2grJPr9xq+nXnnWWkpAm1Jp1
 Yf3g64WbhhxTcfH0m1hBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TqnEi3wQG4U=:9ODWE1MRREqz86a6Z6FjuJ
 w4BvDRwYkXSLNf4m2I1TSy6otC0w3ycOxe+Juc8EUvHMKPvKHDq9JWEqmfvtLYZAdAH4u3Q2N
 TSIDG0MTeaP0dv1028tFERGgKpimsPF0wtj55dBzwUOTf2D/o4picV0Vhl1QsAzTAc6NCdVW7
 /+94MLZtUwWCci2GgM3NHdosjF2R0og/OUgzE/0xsbBN5dsK/MrQh1MN9WcZK/eQt0WdOz+xQ
 p6HBIWNi7+I40GCojkGUIi9NambCi+ldQb1Me2MFMo80PzEb1A11BARC7KtvUbDnmhN8sPe9c
 fPHtovBXvNbr+LozNvX33tYUR6/aFTia19HKyqQ/fQlG8DyFhuHjYCwTRdZxCG9++owHDjDOS
 uMkk/2Cq2zEPAT3gyRB5AI8ZYQLrLM/wtlMRz7CsRQTQvzND8qWTzagqSSCSEynnSZlGmY9pG
 1VpRQlBY/aYLdrCcrdGZV7rqjuMuWBGNvyM9l3tutjZH4ojTtfQkN7jima1TytAXF86Pfzril
 W809jplZJyp17oTRKWHzS875fIb4AIkR4Ct7JAd9wqOAx5NZ01aWWLkTDbEcrrbI5dbL6uOHO
 jRnT7km/ZssB/a9Q7S0opXDGyujNWRTYKCRSLJehtvLbP4cp0hofXDHwQw0gOCv46OczIsUqh
 IKwX7OxgnQI22apZFuI+Xr/dUawio5q1A3SD2VXa/qG3iD3KgJlkeyl4b8hWU/JpZLBcxEwtJ
 lREd2KrB8oooRUtr22jUxENciBUJajKLxwF5FQLUh1CF9G0H/VbpfIP5N63WW1U8hlQ6XPMdH
 azWiIF/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to remove support for .git/remotes/ and .git/branches/, at
long last. In preparation for this move, let's remove the corresponding
regression tests from t5516-fetch-push.

Note: the `push --prune` test case (and another test case after that)
relied on the side effect where a branch with the name `second` was
created earlier. We simply move that branch creation into that test
case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5516-fetch-push.sh | 59 +--------------------------------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 457f648ad91..c8ba7b67f67 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -862,64 +862,6 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	! grep "warning: updating the current branch" stderr
 '
 
-test_expect_success 'fetch with branches' '
-	mk_empty testrepo &&
-	git branch second $the_first_commit &&
-	git checkout second &&
-	mkdir -p testrepo/.git/branches &&
-	echo ".." > testrepo/.git/branches/branch1 &&
-	(
-		cd testrepo &&
-		git fetch branch1 &&
-		echo "$the_commit commit	refs/heads/branch1" >expect &&
-		git for-each-ref refs/heads >actual &&
-		test_cmp expect actual
-	) &&
-	git checkout master
-'
-
-test_expect_success 'fetch with branches containing #' '
-	mk_empty testrepo &&
-	mkdir -p testrepo/.git/branches &&
-	echo "..#second" > testrepo/.git/branches/branch2 &&
-	(
-		cd testrepo &&
-		git fetch branch2 &&
-		echo "$the_first_commit commit	refs/heads/branch2" >expect &&
-		git for-each-ref refs/heads >actual &&
-		test_cmp expect actual
-	) &&
-	git checkout master
-'
-
-test_expect_success 'push with branches' '
-	mk_empty testrepo &&
-	git checkout second &&
-	mkdir -p .git/branches &&
-	echo "testrepo" > .git/branches/branch1 &&
-	git push branch1 &&
-	(
-		cd testrepo &&
-		echo "$the_first_commit commit	refs/heads/master" >expect &&
-		git for-each-ref refs/heads >actual &&
-		test_cmp expect actual
-	)
-'
-
-test_expect_success 'push with branches containing #' '
-	mk_empty testrepo &&
-	mkdir -p .git/branches &&
-	echo "testrepo#branch3" > .git/branches/branch2 &&
-	git push branch2 &&
-	(
-		cd testrepo &&
-		echo "$the_first_commit commit	refs/heads/branch3" >expect &&
-		git for-each-ref refs/heads >actual &&
-		test_cmp expect actual
-	) &&
-	git checkout master
-'
-
 test_expect_success 'push into aliased refs (consistent)' '
 	mk_test testrepo heads/master &&
 	mk_child testrepo child1 &&
@@ -1042,6 +984,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 
 test_expect_success 'push --prune' '
 	mk_test testrepo heads/master heads/second heads/foo heads/bar &&
+	git branch second $the_first_commit &&
 	git push --prune testrepo : &&
 	check_push_result testrepo $the_commit heads/master &&
 	check_push_result testrepo $the_first_commit heads/second &&
-- 
2.12.2.windows.2.800.gede8f145e06



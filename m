Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68DC2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbcGELX0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:23:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:54053 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950AbcGELXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:23 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjIit-1brWjh2aP1-00dWov; Tue, 05 Jul 2016 13:23:02
 +0200
Date:	Tue, 5 Jul 2016 13:23:01 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 01/17] Verify that `git pull --rebase` shows the helpful
 advice when failing
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <d50b69901158ee10cb375a7b1c3c3c600bace010.1467717729.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ejTKbWtNtVcnT27d3BY9PhlgKvDCw75H5VWTNDV1/TT+Nz0Dur6
 6zI4R6/EyvMi6d4w3DyoDpVrgzBXBTUA675y/JLtAXt4W8UBoFflP4XvNEte/lbPPKWuqu0
 SDJ5po1tqaLJOiEUR/JKzYsEw7/pYl96MjCn8W7yXW4ObO0YwwmPYiRP1p1RuQhuoiSuVs9
 4yrt6WON2C7EUw8oO+xIg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ldXMlyDHgKg=:RZDRb5cx21oNtzmnoQAmFd
 W5k4PQK/e10iF+L3VswYAIIGACO8sYKOD9biM5eXGdtMBAorQ62x2vz/a+JjS7Z02iAIDC99W
 9sofdPoECZbkCsKPFzyq4ofB6S55OBbvMxwyyXx+IDe+Cl7V7CwUS2o9jMz0XDAvzPn6X5pmW
 N0PAwg62AHleKU0z+aAYMUo6J7BT2UOLdDH66nX8rMDY+2EjuIN7EJnDsQG/sIqnFKcmarPCv
 eV049AcvrrDX7XzBDxrnP//s7U6pu43UUBCE/bLFRSufVtNSzKa8K948uzfZsRfGNAvofvabL
 sqzOseu8Bnnxzg6wYrWJTMGvTfnKUh3tpvGoHcflup4XaV/06oekopp80BqBVXOmQCH8Spg+C
 8lxsalBE+qHh7UIVpesCFS/XH2jzdFAIdc01f5M1VWeM3e1/pEu4XkjzGkjfI6Opjbmb1dzRV
 MC04fem9Sz6CYYcG1vuDEyyVSTfJfsChK32hCIm8A7HC1iphfKf0re8aBOzIBLPjI0Jf+zLxv
 wlP8DQU3LrIYjVJBT2fst4NJW3Y3epvj7j7wTMO6yULJYElUOYXOUGw9KSh0z9WAm8yiYdHTt
 +H4ool8XTLoGI+FfnaxLO0qRJEVeSdXqFnCIKveQpxZDhoftci5gh+LdMvTMni4kq0RPTtjy5
 lyW8TOA5dcmCYdJ7OYtNjFFvB95N9xFoa1Y9AeVcTkKiecYVsxUPUoRhroOvm9algr4gKJvTr
 Ly2N6KaiStQKLvcCYLCzkkmEU+Wq3jpq64EIPVycpvaWQMrSt/YwVWtFIjhwO56GJSZzgHsc2
 2VilmRH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3159956..b281d6f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,36 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase with conflicts shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b seq &&
+	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
+	git add seq.txt &&
+	test_tick &&
+	git commit -m "Add seq.txt" &&
+	printf "6\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Append to seq.txt" seq.txt &&
+	git checkout -b with-conflicts HEAD^ &&
+	printf "conflicting\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Create conflict" seq.txt &&
+	test_must_fail git pull --rebase . seq 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+test_expect_success 'failed --rebase shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
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
2.9.0.280.g32e2a70



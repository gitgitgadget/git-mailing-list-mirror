Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E76B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbdCIWZ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:63878 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753551AbdCIWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:56 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1cxh4w2Xuc-00BewG; Thu, 09
 Mar 2017 23:25:48 +0100
Date:   Thu, 9 Mar 2017 23:25:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 11/11] t1309: document cases where we would want early
 config not to die()
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <5dc405f0170324cd811732729633416986d252d7.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xdLhFXPjeva4gmM+nmqO7ZNDCYFU/zHkV4gmKPKCiJNk19BCwwt
 5uzFByVYpQEVCnark9NEaSq3y14Qbaxu1a3yQdFraw+BT/YIZ8l8NN6JqgiKL0l39LLxLRR
 Ktrwb05mvVDkZ1oMVgQNKYQJjIJcY5siHXUpedoEf48/DBXCjTjCpwY5osjP39vDiXqthti
 6ggk/S3OM/PAStN6x28kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KHFvT9lTtYE=:IlG3wa0coj/xiB2gX6jqsK
 04honzJVkCu145nxl1brGFMCpNreBFgJAXEj0J0jSfrGI979IJEUTec1FqFHgKe+q189gtckX
 4a1pIoIgB1REfJ1vf6koBdIqfV3vJhgtZ9LSgB44adcD5U9RyJSbL80ixdfVa78NejfNbx4y2
 HZcW4Zoj1Kus3ZT08HiMu23bskObvnuZNcz/UN3kXGW3MS7bafjud9NEpHnkLymgog5gyFHZe
 99WXhJNnN7jYvnDEHy5hwdzMg9zxh6RG+v9UZ4cUQqDKJaR/A1+dba/KKCDYutPeeawbB10Mi
 JlQGLMUp16/Zxt5hz7M+ycEVZpL/UT8WOeisgjG7Znv9DgW7FDUlCxh3P9ltVGvh6CR7E4e1M
 C/yPLIsXSE5mwexCAtcxHQpkO0Mf2bLJEiq0cucuP1ADLCRdk6uY3r/9oEo1LwV7J0m8b4qsg
 OXZpk3RizHKJZ2VwQl0bmqCy5Dki43lzOe+9le08rEY8JcIKQ9lL5v/ctw/f+Bl9Eg/gdtHZw
 GmbbjLh+y/EStXPXgK2LmKuNnro5JOXsHzP6divVyAFVn1jrURgokkQEZYtyl6BapqYtnSa12
 RHCtYceQHNTwgClN8BIyQefY08qxGUTJCpWfB9W2ED3GUB3OMtCdXw2ATn3etS2QYpOJHaBQb
 3ML4ePR61VnVn2cQdz4dk8/UHlO1OjNFmMuEexGR1KpsKJQrGihBe/QIk0y1xMT4ZHzEWsOMP
 itiS8mB++8fN9+3vU9n+CrVTcsFMtENUIop+alx1+OzhSTVFUGc8IswDgdC8c0WAjmPEpBFAq
 jZpgYfF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King came up with a couple examples that demonstrate how the new
read_early_config() that looks harder for the current .git/ directory
could die() in an undesirable way.

Let's add those cases to the test script, to document what we would like
to happen when early config encounters problems.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1309-early-config.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 0c55dee514c..027eca63a3c 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -47,4 +47,29 @@ test_expect_success 'ceiling #2' '
 	test xdg = "$(cat output)"
 '
 
+test_with_config ()
+{
+	rm -rf throwaway &&
+	git init throwaway &&
+	(
+		cd throwaway &&
+		echo "$*" >.git/config &&
+		test-config read_early_config early.config
+	)
+}
+
+test_expect_success 'ignore .git/ with incompatible repository version' '
+	test_with_config "[core]repositoryformatversion = 999999" 2>err &&
+	grep "warning:.* Expected git repo version <= [1-9]" err
+'
+
+test_expect_failure 'ignore .git/ with invalid repository version' '
+	test_with_config "[core]repositoryformatversion = invalid"
+'
+
+
+test_expect_failure 'ignore .git/ with invalid config' '
+	test_with_config "["
+'
+
 test_done
-- 
2.12.0.windows.1.7.g94dafc3b124

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214EE1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbcLATpr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:45:47 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33222 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758181AbcLATpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:45:34 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so98258739pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=D3Tfg5T8yOQb3No4XRoHm3tFLjwj83VC/sWK5hmhugbNJS7sSorw2ceKVgFiS3ZNQ4
         6yC7g3tF3IiEmk31WenifY/PLg5Y9xgGgtkx8VVpVdDCMQp/ZX6J/VkHa6zg6Qkf9yH4
         MffySFxvawRvnlpCCt7bV81hCxsfTP2VESBQZDGzHN8mv+Xz4SsGAnzEp6wX9u6eHoPu
         +97cUo0q8N7D+84uLKD6isPJz3AISHLG/PZax68geVi2EIcDUzK8ihCXSAvoVHFz3DR/
         jE8HtpIGqo0ipql5AYz5qPclMDHK3/P4gca6V4n+/eiQfg0xZVgIX9Vf411KZP5FNLH5
         2mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=ijngE/zVbYMHrs+bylD8afUY9ZC6Z4ksJpAx/Vt6nHQic5/1gb/v3eh+09/8wZCL9W
         mp2NmBOR1S9DOSH7VEu74XMYQoRCUUpejPZpoNVmF3tm7KMr4LtoHshkA5L3l49pnrYb
         ASor61EuSyFEIaXmnDp2Op7McT0a0pBP2JXgfDePSNQmJ0Sa1SqgUWiYztFXkvXqtp87
         H6rpdoc4U/Wr347LLXKSojp0ka1vyEi6IWk/y/wH1CyH8qrEJlKHguu0srfVenNzJ9xb
         /ITLAhO2swNDdwwHXVxnD7ZRNocoO8kcvtdvN3dHvbSKb9376axOInWCmqV2PQnCqZ8C
         L8pA==
X-Gm-Message-State: AKaTC02xsqSSmH2pf0hR0u/XIV15eNOLS+g/mVqLWYjWlSONE7e63o/cQbSSDvuJ6SoSsbuy
X-Received: by 10.84.216.8 with SMTP id m8mr87779370pli.116.1480621490717;
        Thu, 01 Dec 2016 11:44:50 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q145sm2090998pfq.22.2016.12.01.11.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:44:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v6 1/4] lib-proto-disable: variable name fix
Date:   Thu,  1 Dec 2016 11:44:04 -0800
Message-Id: <1480621447-52399-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480621447-52399-1-git-send-email-bmwill@google.com>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_proto function assigns the positional parameters to named
variables, but then still refers to "$desc" as "$1". Using $desc is
more readable and less error-prone.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/lib-proto-disable.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index b0917d9..be88e9a 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -9,7 +9,7 @@ test_proto () {
 	proto=$2
 	url=$3
 
-	test_expect_success "clone $1 (enabled)" '
+	test_expect_success "clone $desc (enabled)" '
 		rm -rf tmp.git &&
 		(
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -18,7 +18,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "fetch $1 (enabled)" '
+	test_expect_success "fetch $desc (enabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -27,7 +27,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "push $1 (enabled)" '
+	test_expect_success "push $desc (enabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -36,7 +36,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "push $1 (disabled)" '
+	test_expect_success "push $desc (disabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=none &&
@@ -45,7 +45,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "fetch $1 (disabled)" '
+	test_expect_success "fetch $desc (disabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=none &&
@@ -54,7 +54,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "clone $1 (disabled)" '
+	test_expect_success "clone $desc (disabled)" '
 		rm -rf tmp.git &&
 		(
 			GIT_ALLOW_PROTOCOL=none &&
-- 
2.8.0.rc3.226.g39d4020


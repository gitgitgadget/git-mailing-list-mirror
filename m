Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84841FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbcLBABT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:01:19 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36239 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbcLBABR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:01:17 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so99975621pgc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=fkd8pt4/Z7ul1d2sA0KBCRtg3Y3iYEnkuK9E+jvcI0CmlYD9QO6d8HanipwYALCGyL
         oCPXyijD4dT5wDu1MmMDfrhc7HN7TC/Ut5t7W3uzt9jwRbJV2bmLBh4e0sPYjfUSbsUI
         hnZnMDDmkNZI8FTCEhtCSx0YsbIt/DyXu3pJe1nt27UnOFyyhHWP5o2f0zdg2dDbXQNy
         Q7XkFWZEw27AC85n4Co3NK2g68fzcqizDnIpAmeQhF4T1VxIZP7OXnLewXLRsKaqCPcs
         h65+1tXyoneb9TJBL3tJPhq+O1psonHBqg8eXpuIXmj1+jSa0JrTqg0a9EDmWKLIHxiY
         uEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=UbxL0mLMIsPQM0O7AAmaiad82LXPdJTavp25HhS5WkNoxKMUSqrZxViNdSAWhi+aLv
         ft83WkecTuW2OWGlwsUYUY2a6KSHf0F1aN4xhpo6kf8ZnbH1/3a2E9gBa65QLub00zZr
         eTtDNrRSRZgoyn5+7z4kOX/j/Dbbl6CqKLgzK8fdfSjCyBcLwnTse1kxyTtK0tCYVY4v
         pA9NXZtzh/+BWLQ82xurTsU9z3XAYERupthNmxyBLgyjw9x54gKSvvjmfS5Ah9igtXVE
         NnuVCTfsyepoJX2TwC+xdWw0rQYubt2H8VXcxIqDeX8ELBj4chnz6XlRg/9xoDBlHNeq
         PUOw==
X-Gm-Message-State: AKaTC02zBCP4l0nytRE0HimydqX6J2+tkFVcry5HE4qCdAmiaYDtxMEMfY+cFbnwPV5rglmj
X-Received: by 10.99.158.18 with SMTP id s18mr15822784pgd.88.1480636877007;
        Thu, 01 Dec 2016 16:01:17 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r124sm2692687pgr.6.2016.12.01.16.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 16:01:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v8 1/5] lib-proto-disable: variable name fix
Date:   Thu,  1 Dec 2016 16:00:58 -0800
Message-Id: <1480636862-40489-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480636862-40489-1-git-send-email-bmwill@google.com>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480636862-40489-1-git-send-email-bmwill@google.com>
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


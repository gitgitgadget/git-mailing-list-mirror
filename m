Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396FB1FF6D
	for <e@80x24.org>; Wed, 14 Dec 2016 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbcLNWk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:58 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34092 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934968AbcLNWkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:16 -0500
Received: by mail-pg0-f41.google.com with SMTP id x23so12522426pgx.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=hCjGSZTxLyrTN6rETj42gxfw4GzTtZOreVHnQsfGPMNJomoKv5XRiTbfy6E94w275P
         lbldLZsUbCbBM6IzsDP4tAinZyY81a9GhQgeVD/0gGv8LzjMl/kZme+vAwe+2lbBrwxf
         gDSAcEEeJSbWMSIWnXzUp9s0qmAHMZhHOrFbPTefiOy3cd+gzEhBLitcy0OD7gCd0vNJ
         r6UErP0Xd2R76bDLNFCgBw6JKqx6SCY85C0obtrUZOWa9SU76GF6kBv2BjEOyX81uEez
         z++CTpw66TJP+XtQhFVOA1CiYewu0XqgETujPRklAviZQtrPtXuYo7PCiPwQqG1IxUMT
         Pr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=R6u7H3LZrR6ya8sIKkraHmaH0xMaj5mmA0JcU+deKfyZjaA1TQynb/pSmO1qFH+EKH
         2QkQPiLox6nYcybGZoz5L8TG5xS1nfAk//ppBKlpysvsw8hakPrJG3lfc8u96oMfQBnS
         atK1aQxyFgx+X1qw2CuSu6uQa/tQPx382KJojSafNKbAmZ8uXZvEHbbEReVv4NTStUJ7
         dJgHiQG5aHnekfftCB+R9TsI2IB4PYkfmS+xG7PpWB0obVLcuZs4MPs48iYjgsU28Pho
         HSBlRkuYHOgvntiVuw63SE7gofNjncNwaMYhR3rDS2C94HjzuqlIZNPLsUp8IxKQkSgE
         taaA==
X-Gm-Message-State: AKaTC03OFYy+q3+FFVG7n8jTgpRJC5PXl15GagpimaZH4pJze5IFcs+cS0m4vqQgx8ODCnEN
X-Received: by 10.99.37.2 with SMTP id l2mr187734756pgl.160.1481755215382;
        Wed, 14 Dec 2016 14:40:15 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 1/6] lib-proto-disable: variable name fix
Date:   Wed, 14 Dec 2016 14:39:50 -0800
Message-Id: <1481755195-174539-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5083F2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 02:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbcKHCz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 21:55:26 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36820 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbcKHCzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 21:55:25 -0500
Received: by mail-wm0-f48.google.com with SMTP id p190so219679795wmp.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=l9/sPp1r02TPn6f0+NidNj/ANa+ORwrR5vo1WZC7OE2gN42vsmIOFO79kofyqm9wvi
         hE+8nWWuCkd3lGQd+Fr/08kH0XfQkwL7Bd3E5xxUVUls4Ti7fUVKqZRw1/Dmr/QeAmfQ
         henG+HJf2+jTqITNvYcP+5n5RwWATH9yEfc2/YeJdOzbvWq7/YMjWAg5IaVtCgOcAY3L
         AtkbJm2XzRJ1M7DqVJzDKLubu42NMdnoZKSez8LwYfSuav+B48cjfD6yxDO8cbUSod7f
         VsvrvLdq1CnmJnpj7APqGVSPd61KBCrEX87Th+qqhrptXfusioBrRc/nw1zbEddpnnug
         0mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=dhWmuvMZsN+mxTv0Jn04z6VzzPyvXbGVEqEXa7lBy1knwItwKJMY/U7qF7/iUM94ze
         ZONFo8nvK6Jcb9W+jl9rXQ0OtJoJfH2vgTl/yXGWAnL2iaVB2kehHNf2y7xu+tmEpsox
         I4Me1BPd8sxd1xaC/39fCRHmSa2yuyrTR7esP/atJuvfvhfX16hMhf5ekYZ89R8NLDqP
         lAx/KxhhAcM0S6fBt1iBfIRlRMU/gZXqqJgGQqXCfi2mDEbGzo4KucgaoB1MU1vQq+y/
         nMJO5DY9iVvaoa1PeqBMN6GMk/roToLTJzqSFaZX936Q6UX7OOXnneCRWyb6CwB3r3Gq
         KrOw==
X-Gm-Message-State: ABUngvdJ4RziGWc7pCGItY4kvwEtcry666T5VD3H0ORqVovnsZeKuO3FiHvvxAdiYwcF3PHc
X-Received: by 10.194.246.3 with SMTP id xs3mr9491624wjc.87.1478555473322;
        Mon, 07 Nov 2016 13:51:13 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n6sm33317146wjg.30.2016.11.07.13.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 13:51:12 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        bburky@bburky.com, peff@peff.net, jrnieder@gmail.com
Subject: [PATCH v5 1/2] lib-proto-disable: variable name fix
Date:   Mon,  7 Nov 2016 13:51:01 -0800
Message-Id: <1478555462-132573-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478547323-47332-1-git-send-email-bmwill@google.com>
References: <1478547323-47332-1-git-send-email-bmwill@google.com>
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


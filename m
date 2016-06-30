Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B25C20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcF3BIZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 21:08:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34630 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcF3BIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 21:08:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id bz2so22573587pad.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 18:08:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K24H5R1ii4OdL6gfu+50Ihq27m78tc54+meWFiCSaGc=;
        b=cWQNhhX56Q6rXhMwkP6sGCqnJZ7n4X4/0AKnH0GmV+JXNynv0mP3BIa+eCuIOgt43T
         gCuylYtV2Ds6dPBVNzkO19hDjOeAk8dqFk1bWBPQecqDBKJZAGWEb7o5D4vZ9UUGBBIi
         km4O5ojMdpjPT1ojfMwKHXm/Ns1c2SNxHjaoIYCRrJNRPQ75ub6s8t+nzQtLiDUgW36U
         zaVQpy1GuoVKjxi1J1xjV19QUwCqU5NgkRUzfNWZVDm4PfuqZrfCgpt8CVs5FPnlRJ51
         ORlCDc+ZKxY22M6O3EYjcj0m0LJZsMQFTcPjqQ0ehG8ntCEXr/XQYzxNp0+l4famRskt
         i9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K24H5R1ii4OdL6gfu+50Ihq27m78tc54+meWFiCSaGc=;
        b=PtzWma6q7BWRcMR3buU+jKQ4LMDN4kKBUzwK+HBYnAMgIKk40hqv9QlXIP4ZwrLCR6
         U5wRbMcEYAS7pj/6KTnZYyWYt684YiUaXyct/qjhQIVS0Q8fj9AtadEhbV9Pp3MaX9O4
         DTz5iSuN6vvvyGF4BS8IwTpzKUg4McleEM/P+FPc4PGiFLYE1aADo39j4aX1yztxFsgm
         SrslvbMNcxko0HUaIOaR5HX8GPXeu73/EkxC12m8KwpmJj8o2f8MCjvnFsPQhpBZiCEM
         MRwl3vaJyzVROQVGS4j5VDLqsP52fVvF+UZVJoCUg7xGujIUHmoVbH86CQk38K3bbns7
         zQ6g==
X-Gm-Message-State: ALyK8tLJwf78PW4UM4DSzyziFHNzuMEkScpRPCJp10LXtfHGjxngXLRDUFtXb9iw7NZP6kzd
X-Received: by 10.66.101.231 with SMTP id fj7mr16925987pab.59.1467248417563;
        Wed, 29 Jun 2016 18:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4c6d:bc1b:299f:eb0])
        by smtp.gmail.com with ESMTPSA id d69sm613037pfj.31.2016.06.29.18.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jun 2016 18:00:16 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, dwwang@google.com
Cc:	Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] add a test for push options
Date:	Wed, 29 Jun 2016 17:59:51 -0700
Message-Id: <20160630005951.7408-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gdd65b60
In-Reply-To: <20160630005951.7408-1-sbeller@google.com>
References: <20160630005951.7408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The functions `mk_repo_pair` as well as `test_refs` are borrowed from
t5543-atomic-push, with additional hooks installed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-push-options.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/t5544-push-options.sh

diff --git a/t/t5544-push-options.sh b/t/t5544-push-options.sh
new file mode 100755
index 0000000..49d5f80
--- /dev/null
+++ b/t/t5544-push-options.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='pushing to a repository using push options'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+	test_create_repo workbench &&
+	(
+		cd upstream &&
+		git config receive.denyCurrentBranch warn &&
+		mkdir -p .git/hooks &&
+		cat >.git/hooks/pre-receive <<-'EOF' &&
+		#!/bin/sh
+		cat $GIT_PUSH_OPTION_FILE >hooks/pre-receive.push_options
+		EOF
+		chmod u+x .git/hooks/pre-receive
+
+		cat >.git/hooks/post-receive <<-'EOF' &&
+		#!/bin/sh
+		cat $GIT_PUSH_OPTION_FILE >hooks/post-receive.push_options
+		EOF
+		chmod u+x .git/hooks/post-receive
+	) &&
+	(
+		cd workbench &&
+		git remote add up ../upstream
+	)
+}
+
+# Compare the ref ($1) in upstream with a ref value from workbench ($2)
+# i.e. test_refs second HEAD@{2}
+test_refs () {
+	test $# = 2 &&
+	git -C upstream rev-parse --verify "$1" >expect &&
+	git -C workbench rev-parse --verify "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'one push option works for a single branch' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --push-option=asdf up master
+	) &&
+	test_refs master master &&
+	echo "asdf" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'push option denied by remote' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions false &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		test_must_fail git push --push-option=asdf up master
+	) &&
+	test_refs master HEAD@{1}
+'
+
+test_expect_success 'two push options work' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --push-option=asdf --push-option="more structured text" up master
+	) &&
+	test_refs master master &&
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_done
-- 
2.9.0.141.gdd65b60


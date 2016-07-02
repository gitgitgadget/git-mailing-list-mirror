Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D984E2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcGBAUa (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 20:20:30 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35635 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcGBAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 20:20:28 -0400
Received: by mail-pa0-f49.google.com with SMTP id hl6so42754796pac.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 17:20:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHQUco70hqipJs3HV/oWXduD4Nqm+/jouN4LPQgMk5U=;
        b=IkowRuDPfkZaFLhkB8w5A35ZY8TlxXSJJHTTUVNEeTnJJbKg0cuitsZBnSRAhbGQJI
         muyGcQeZRXiQA8iiGii3k+96JXw/7CkNAXvCAsVxEUN/NnUhBklny2yghW5NYP9eo2v4
         2vE/obLsx9FuQqFFGTl5s6Fu8gazhgpL9gtcIgrHKRHr6vtaePX+bhzYEvPH4MJo3cpc
         +QAfQEHuZZOF0zIliA3KSX76VY08td/FlUr1zyy6gADO/GSJKoeOR7iozDh7St8mzbc1
         65EnuMcbEA74AdazLMJJSop/aa8/akFICvQTgJ1NiZRnBB42YVq1ltl9cwf49N2Pi/U/
         6egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHQUco70hqipJs3HV/oWXduD4Nqm+/jouN4LPQgMk5U=;
        b=CTXLPOhSKDuY5IRg5X+vF2N/ZJVRvAeB5o4DlED9uNLUp9STFF2/eGVcrXxAHLKrA8
         IBi+Dki5hHPI3k4u9OBVX3sZn7Qdd7qSKrMkIY4Ncyid7kl0A03tL85FNep7vShD+sax
         AwzvtXEGABKmIh1qC4qayo02FR3dlZR6bOKDTPuthtZA2gvd9WDw44Kytn8c9eDz68fS
         7LPuOhZfdrxqsq2DDMLJhTfRGL1zZ4IpSm4tsqodfqOdMx8YUh/yLmu0kPhiMnpMyTZC
         9IegcOKjbJXuiZJaXLQrUWboGKxo5C60teHzvXjvBhYgYQqTfF0a4qqV4I5MuGNWnEEl
         zGJA==
X-Gm-Message-State: ALyK8tIVxYA1ZAS7OvHf+a+ILTWwLjEqAkQEh/zPhudHVC8HBnU6fzFck3uimW/xvMCf3SBA
X-Received: by 10.67.23.48 with SMTP id hx16mr1621415pad.7.1467418827597;
        Fri, 01 Jul 2016 17:20:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c009:86e6:19a6:486e])
        by smtp.gmail.com with ESMTPSA id e9sm197842pfg.2.2016.07.01.17.20.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 17:20:26 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, peff@peff.net
Cc:	dwwang@google.com, gitster@pobox.com, dennis@kaarsemaker.net,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] add a test for push options
Date:	Fri,  1 Jul 2016 17:20:14 -0700
Message-Id: <20160702002014.29497-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160702002014.29497-1-sbeller@google.com>
References: <20160702002014.29497-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The functions `mk_repo_pair` as well as `test_refs` are borrowed from
t5543-atomic-push, with additional hooks installed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5544-push-options.sh

diff --git a/t/t5544-push-options.sh b/t/t5544-push-options.sh
new file mode 100755
index 0000000..8dd3c8e
--- /dev/null
+++ b/t/t5544-push-options.sh
@@ -0,0 +1,101 @@
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
+		if test -n "$GIT_PUSH_OPTION_COUNT"; then
+			i=0
+			>hooks/pre-receive.push_options
+			while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+				eval "value=\$GIT_PUSH_OPTION_$i"
+				echo $value >>hooks/pre-receive.push_options
+				i=$((i + 1))
+			done
+		fi
+		EOF
+		chmod u+x .git/hooks/pre-receive
+
+		cat >.git/hooks/post-receive <<-'EOF' &&
+		#!/bin/sh
+		if test -n "$GIT_PUSH_OPTION_COUNT"; then
+			i=0
+			>hooks/post-receive.push_options
+			while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+				eval "value=\$GIT_PUSH_OPTION_$i"
+				echo $value >>hooks/post-receive.push_options
+				i=$((i + 1))
+			done
+		fi
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
2.9.0.141.gd59d3e9.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808451F744
	for <e@80x24.org>; Sat,  9 Jul 2016 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbcGIAbt (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 20:31:49 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33573 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365AbcGIAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 20:31:34 -0400
Received: by mail-pf0-f172.google.com with SMTP id i123so17156796pfg.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 17:31:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP5MPUDgWzD6E8QPxQXOIyTNsFUGwKe3AKdjgWKjtsw=;
        b=clmyF/V11HZcehD16RMlwYGHE6H/PyDMckmAurcT/llGvO/6n4shgeO4awQdbI9HSq
         1YcYgRwcL1xisUwi3JgkeizNYrnBpSoedI4qL1DZohLXpO0TIDuNE9jasl3pqtPI6Eyo
         EgHNJ/ZpwHGxqWIqdQBGJ4/AznUDhscAYoKRfKAO8NfzRTn8L0LKts/sadNbuD2sVO3J
         MGNknVpSqVAdGXArNri1zQVUTPJL3xJkkNfrVbl3LI1w9lNYtdLOXqnHOzBTalVpGSAQ
         yDFC7abu5NCTbH4jCISKPVy6Kwq3lLsSJ1qE4W5ekPEB586aaTxEhsFzkLbtx4LaITCe
         xBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP5MPUDgWzD6E8QPxQXOIyTNsFUGwKe3AKdjgWKjtsw=;
        b=Zv4TYaP7i2DN9GWxosu0P/6T3i7sMjSa773knDZmhINbUnPjDKaWzNqZnN/VKrpVd7
         RsmXNV1K3Tsw8znsY2lI5oc3NX+fcgIclviSSNa9JwVbIS4YFeq6VFMYirxVLX9gZCK1
         sYP5bkazJvJ8Yni9osdR0r5Z+WFE8qqL3iVT+m19Ki4xlmmZ5fjmk+hfqx+IOfV+xoiQ
         XjVj8diQGlJC4qKoW8ZuPNn6Vxw6o7gKy7GqtMDpBwnOif+EVLmBPRm79vogPJ9TOEA3
         Ir4edq1u3cdGe8zTn8aY3NaaHbgL8FeRlnnR9SmdpkcHzoNHcIT7sEeqLfg21YkKG3Sv
         yEug==
X-Gm-Message-State: ALyK8tJcRl2kwEFjRIvcTdp5QaGGNdxxDQkD4GaIzDW7DvElD1FW9DkSuGSp3hT1ivMto2Dd
X-Received: by 10.98.33.23 with SMTP id h23mr14517944pfh.42.1468024289700;
        Fri, 08 Jul 2016 17:31:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ccd7:b4ac:db99:b698])
        by smtp.gmail.com with ESMTPSA id uj5sm80544pac.28.2016.07.08.17.31.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 17:31:29 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] add a test for push options
Date:	Fri,  8 Jul 2016 17:31:13 -0700
Message-Id: <20160709003113.26930-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.g176c4f7
In-Reply-To: <20160709003113.26930-1-sbeller@google.com>
References: <20160709003113.26930-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The functions `mk_repo_pair` as well as `test_refs` are borrowed from
t5543-atomic-push, with additional hooks installed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5545-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5545-push-options.sh

diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
new file mode 100755
index 0000000..8dd3c8e
--- /dev/null
+++ b/t/t5545-push-options.sh
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
2.9.0.247.g176c4f7


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32041F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfHEVE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:04:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52231 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:04:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so76032678wms.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bp+sT7LHISdeJu8CKlX93DSGZ0LP6qQreiFVnD8Ec+E=;
        b=ks+tsBN2h//asd4YS+GUPgW40xN113HU22CzvwzGlZnbXrUbJWJGVjLe8IU+mM6DGA
         hj7wfvPahVPFx2a+xlDuN6CRds22eUcGF7/hJlXvncn4+evvF6hLumG8ZOqwNlh7nde6
         fXsAT5zIlxQs2VRaRaBeJwDqj9LH+1HtcTEn32uDL+MCKUCrrpvyv/qBVPfdnQj/VY7a
         IS2K/HfEI0oT14Ful3pNt0DiJvo2ep3BS4IYh4fyKgZ4qb0LDWcT2Jo0gG4Mf/7vUHbq
         zyFj7TpAWIUcmIbSgKpMf9JUHuJnG/jZZlfEHLR7PfkLEnqGbNF8d1rHGZe7D4Eh1kOV
         7qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bp+sT7LHISdeJu8CKlX93DSGZ0LP6qQreiFVnD8Ec+E=;
        b=T7Jyq87QrFGZXiuWsuLeq/pv3/1jNUplj11wAQGQBWFnYhPLjH3IwoDW5m9Oj4HwA6
         foHx/g6UbExeQ/izSg2MHdo9b+vE9DytK823SXu0wiM7gx42MPPZ4uK742QY3pB6Cl8m
         ZUqyos19sVT6jFLnhBxY5ExYk8zRQsC8nfbXrpkNQN5C+bA+UtuSMu5SX9Gupnz5CvJX
         92PztKCbKY6BjjQbEq+yEENmmQfcMSvzsZDGVRZu50xtTKFk30Yi9o501KA7Kb1nZKaJ
         IHx45nIdEkUyWN9YGcpq1b6Qc7g+KGyjw5JqzWN7mdNexvVFAPDx+uv8dCL7xU+A/vxD
         sw+Q==
X-Gm-Message-State: APjAAAWwYPQwv689CkueG3E34ZoqGFFsGlmeepHpUT6AX83yvIrmOK8S
        D7ywZFqlMogqU4dqky8qZbm2mCqA
X-Google-Smtp-Source: APXvYqxMfnW+xjm5ooNEZfdxqnEThkBJz2U6p+Dy7jjWaWCL3zSqcGJrx8EzCAs6ym0aKepBQd4Nvw==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr214040wmj.53.1565039094753;
        Mon, 05 Aug 2019 14:04:54 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id s12sm82312179wmh.34.2019.08.05.14.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 14:04:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/2] t0000-basic: use realistic test script names in the verbose tests
Date:   Mon,  5 Aug 2019 23:04:46 +0200
Message-Id: <20190805210447.7169-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190805210447.7169-1-szeder.dev@gmail.com>
References: <20190803080126.29488-1-szeder.dev@gmail.com>
 <20190805210447.7169-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our test scripts are named something like 't1234-command.sh', but the
script names used in 't0000-basic.sh' don't follow this naming
convention.  Normally this doesn't matter, because the test scripts
themselves don't care how they are called.  However, the next patch
will start to include the test number in the test's verbose output, so
the test script's name will matter in the two tests checking the
verbose output.

Update the tests 'test --verbose' and 'test --verbose-only' to follow
out test script naming convention.

Leave the other tests in 't0000' unchanged: changing the names of
their test scripts would be only pointless code churn.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0000-basic.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index e89438e619..d2b3dde89e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -276,15 +276,15 @@ test_expect_success 'pretend we have a mix of all possible results' "
 
 test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	test_must_fail run_sub_test_lib_test \
-		test-verbose "test verbose" --verbose <<-\EOF &&
+		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	mv test-verbose/out test-verbose/out+ &&
-	grep -v "^Initialized empty" test-verbose/out+ >test-verbose/out &&
-	check_sub_test_lib_test test-verbose <<-\EOF
+	mv t1234-verbose/out t1234-verbose/out+ &&
+	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
+	check_sub_test_lib_test t1234-verbose <<-\EOF
 	> expecting success: true
 	> ok 1 - passing test
 	> Z
@@ -303,14 +303,14 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 
 test_expect_success 'test --verbose-only' '
 	test_must_fail run_sub_test_lib_test \
-		test-verbose-only-2 "test verbose-only=2" \
+		t2345-verbose-only-2 "test verbose-only=2" \
 		--verbose-only=2 <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	check_sub_test_lib_test test-verbose-only-2 <<-\EOF
+	check_sub_test_lib_test t2345-verbose-only-2 <<-\EOF
 	> ok 1 - passing test
 	> Z
 	> expecting success: echo foo
-- 
2.23.0.rc1.309.g896d8c5f5f


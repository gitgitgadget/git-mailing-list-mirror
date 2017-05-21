Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5A5201CF
	for <e@80x24.org>; Sun, 21 May 2017 12:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbdEUM6g (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 08:58:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34060 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdEUM6g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 08:58:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so14666959pgb.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Era3eA6VUrhs7729kWnXMUERHy4eNdtO9Ei8YIKAra4=;
        b=o/Cw9UGHBxNxhIsqoFZml9i5lWPxZpsZ5dQ/qb4YAPodHAdNmECqoJ+nnMW6u+24B+
         269TSS4JpW4/8BQcaNu1zBWpYqA8qjfqo6DJafkuRNIp1VKLg2h2mwwkrs4Qdj37g7Tr
         q7sSRE83fPM9NQ+e5oMJdG3wqMJpEnRxLWbtzUBfteMdIGJYfQicviogE8H9OCMQF9jP
         if4HVQi+XeTJbbAZ9XHVRcvEuE9X4TaXb4ViKXaHP38tSptnCv7VlzYT6qXVmSUHqRrW
         /kE6K921lebXC1yhoRY1CVighwVgsYeOCcsass933ahHwFkls/jtQYSRTuLg42xK41AZ
         cA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Era3eA6VUrhs7729kWnXMUERHy4eNdtO9Ei8YIKAra4=;
        b=LgxYrBBNGZrBeTjddWEkAsZ1aMMFNRQKGUTOH98WQ96fFG7h10oieeACCqPFZPQnKm
         eSnIgJkypUX9mRAy48e2O78FN9pGwhKyP8K6Z+LxPxV9o0DTHwxpNn1jnIHhWe5/oF/0
         8n1zDcevLBeKacJiV7WG65Q7uaaY5/Go9V4IjRVNvUlPxkCF4C5nmCu/jDl7ClBTmLj8
         JsyUdtI01DiWk4fZKh3G6BqROMas8zwPoRjXig/kK3e1tMeEm0QT9b+fwJMfutaxuSAl
         u0MHcFp8PoIEHq80ZqByn31d8YmlirYBRjZEFZ59h/rAbl6iwRDDsjHg5EFrHmPIlBkh
         9NNw==
X-Gm-Message-State: AODbwcDO/vi7WGFRzhywQGwADwOdo6KPIDmn7REQl99RFY1ui2R+iWfy
        CUkDIUMVJY0ZTA==
X-Received: by 10.84.198.3 with SMTP id o3mr22941811pld.60.1495371515255;
        Sun, 21 May 2017 05:58:35 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id i63sm24835982pgc.26.2017.05.21.05.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 May 2017 05:58:34 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, peff@peff.net,
        bmwill@google.com, ramsay@ramsayjones.plus.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v4 1/2] t7407: test "submodule foreach --recursive" from subdirectory added
Date:   Sun, 21 May 2017 18:28:13 +0530
Message-Id: <20170521125814.26255-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170515183405.GA79147@google.com>
References: <20170515183405.GA79147@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Additional test cases added to the submodule-foreach test suite
to check the submodule foreach --recursive behavior from a
subdirectory as this was missing from the test suite.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
It was observed that after porting the submodule subcommand to
C, it passed all the test from the existing test-suite.
But since there was some observation made, where the output of
the orignal submodule foreach subcommand wasn't matching to that
of the newly ported function, this test has been added.

After which, it can been seen that the patch fails in test #9
of t7407-submodule-foreach, which is the newly added
test to that suite. The main reason of adding this test
was to bring the behavior of $path for the submodule
foreach --recursive case.

The observation made was as follows:

For a project - super containing dir (not a submodule)
and a submodule sub which contains another submodule
subsub. When we run a command from super/dir:

git submodule foreach "echo \$path-\$sm_path"

actual results:
Entering '../sub'
../sub-../sub
Entering '../sub/subsub'
../subsub-../subsub

ported function's result:
Entering '../sub'
sub-../sub
Entering '../sub/subsub'
subsub-../sub/subsub

This is occurring since in cmd_foreach of git-submodule.sh
when we use to recurse, we call cmd_foreach
and hence the process ran in the same shell.
Because of this, the variable $wt_prefix is set only once
which is at the beginning of the submodule foreach execution.
wt_prefix=$(git rev-parse --show-prefix)

And since sm_path and path are set using $wt_prefix as :
sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
path=$sm_path
It differs with the value of displaypath as well.

This make the value of $path confusing and I also feel it
deviates from its documentation:
$path is the name of the submodule directory relative
to the superproject.

But since in refactoring the code, we wish to maintain the
code in same way, we need to pass wt_prefix on every
recursive call, which may result in complex C code.
Another option could be to first correct the $path value
in git-submodule.sh and then port the updated cmd_foreach.

 t/t7407-submodule-foreach.sh | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..58a890e31 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -79,7 +79,6 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	) &&
 	test_i18ncmp expect actual
 '
-
 cat >expect <<EOF
 Entering '../sub1'
 $pwd/clone-foo1-../sub1-$sub1sha1
@@ -197,6 +196,40 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	test_i18ncmp expect actual
 '
 
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-../nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-../nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-../nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-../submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-../sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-../sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		cd untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 nested1-nested1
 nested2-nested2
-- 
2.11.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191B4201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbdETVnN (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35437 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdETVnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so5760499wrg.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oz2ZXtQlzriN/xsKjgBSNa3wy6S36RQeLHBf3rBQwmw=;
        b=QmrZKv5Tpr+Z4S2VihGfd0OjeJpJebluEjMwChcLSVgR6MtrFoYpRxOYGJ88HPbHdh
         pHD6fGjCB1PHmo2NXS1kZphmUviXFYyRJqJYP/K8+4ves0nUkW9CfBE6QAxyw//D3BMp
         BsPHYZXydtDK32HrJfyDKDNv/aqiBR9/ivjVohcNsrQ3hynsmmRf4XTrlJmuYpEN3j9w
         G0G8EkJnDAtq+LbYP6tfg/a9ltmbnZi4lp6h9Os0IFC7Fl8jxqfhTPa7OIDJA04BqNJB
         NUq8Zs6LMGWrRhHSqgnGJ6TXXhj26ZOBlyGdOz4Oe9TtVLv9bPkwzP1cyi/MlyTFdf6M
         MYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oz2ZXtQlzriN/xsKjgBSNa3wy6S36RQeLHBf3rBQwmw=;
        b=AaCHTWXGH3pPJqMpdlptRTqQsH3qdjdEc4wUM0nEiTX3kkc13AZkwx60EG4IXqB5iJ
         fFKgU4rRq2dJ/n1Ts83j30xnf8qvk98z7sm5scMgtjI5sezDBs9Jy5opBNHvE4FnUmO1
         cs1BcOVj1bD8kzkPf8/eVJ8kc1vmBvWLTJxD3akxua6ab0b9cq6+8tOAMi1rSJK0jHYu
         6ECq8Ry8Asn7kTEsMAjRd2aPNd5o4sphy0io82dfO6yaxh6jJ6OO96qq+zmTMWJMn4pB
         LP5XNh1jXTN3OwWyil/MhtM0FEcDqpjayMQ60+WsD1DD8VWI4LPQLyAv4FUV8CXy3Y4q
         IXjQ==
X-Gm-Message-State: AODbwcCrKx6Bgb+W706WbePs4LH+gAh4hH02St9F0aDgvCnJQcB2JfV0
        rfOQIc9CJsXwcw==
X-Received: by 10.223.155.134 with SMTP id d6mr7752165wrc.157.1495316583067;
        Sat, 20 May 2017 14:43:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/30] grep: change non-ASCII -i test to stop using --debug
Date:   Sat, 20 May 2017 21:42:11 +0000
Message-Id: <20170520214233.7183-9-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a non-ASCII case-insensitive test case to stop using --debug,
and instead simply test for the expected results.

The test coverage remains the same with this change, but the test
won't break due to internal refactoring.

This test was added in commit 793dc676e0 ("grep/icase: avoid kwsset
when -F is specified", 2016-06-25). It was asserting that the regex
must be compiled with compile_fixed_regexp(), instead test for the
expected results, allowing the underlying implementation to change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 04a61cb8e0..0059a1f837 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -36,29 +36,14 @@ test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre utf-8 string with "+"' '
 '
 
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
-	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
-		 grep fixed >debug1 &&
-	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
-	test_cmp expect1 debug1 &&
-
-	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
-		 grep fixed >debug2 &&
-	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
-	test_cmp expect2 debug2
+	git grep -i -F "TILRAUN: Halló Heimur!" &&
+	git grep -i -F "TILRAUN: HALLÓ HEIMUR!"
 '
 
 test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
-	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
-
-	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
-		 grep fixed >debug1 &&
-	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
-	test_cmp expect1 debug1 &&
-
-	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
-		 grep fixed >debug2 &&
-	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
-	test_cmp expect2 debug2
+	test_write_lines "TILRAUN: Halló Heimur [abc]!" >file3 &&
+	git add file3 &&
+	git grep -i -F "TILRAUN: Halló Heimur [abc]!" file3
 '
 
 test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
-- 
2.13.0.303.g4ebf302169


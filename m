Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE9F20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036676AbdEYTqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36116 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036685AbdEYTqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so54292319wmh.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oz2ZXtQlzriN/xsKjgBSNa3wy6S36RQeLHBf3rBQwmw=;
        b=tqyvDuUo+l/SGAJOHjHm+vhXe2ePPmY7T5ncleg/KStka/w5s2G3IzEAK5eix9X5mt
         3HObqQJv4GhNx9BW1GirbffLPM+47KD8hv4TgVVVTWUOkFK6f3/Dj+MMzD6jyfiyn4AZ
         7WGbIXuRyKMSI4XI0GoPYU+2zMYGby8ZU8A05rSQoVIEyXB9h+XeHWZyWgECcom/52e5
         Pbqg+w7wo7FOiYgDiWayBQsGEvfTz/6d3Tg7s1KKi57WKJeE+agoOkPq/qpyvKOaLRh5
         KSKqmUOYaaVk7C3Sl70VkL57OfBN3cGERJhBdeVSVoJTK0z2dkK8S9Toxlwuk/1aNkpd
         rC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oz2ZXtQlzriN/xsKjgBSNa3wy6S36RQeLHBf3rBQwmw=;
        b=nNTLXBDrUvv91YzaSGj+Zzvk0Dg6TvCeTwBEyPsQEdsyy9DG/z2xR/oYH4HgritxZI
         m5SFChyaZXcq9tltN+UvFBxCtVPamQwwsVBV9Hbk8bZib2dqGUZt2XHoh6u1fkjJV44/
         fA5kGJ9s4RbV07BDrmc1Dg7c8dKTw2Ehu2tRI7cvSRBRnefXh2NQo3stcaGPvbOcjFV7
         gxoSg3DTBW9Jm0XVdj4Ss/NLt8vpxVFMZWzMf3bclTgmpXWPtQWQqtVTyaSg61I2OL6q
         T4nHabqwoulOiqmqEFgj1VEQURzPpSTsc8AomWf0A5eI8bHRFbp34ccAdSDR5r224l81
         lsOA==
X-Gm-Message-State: AODbwcAwjTXP2YG6Xicuy7pBCq/Q5Lhfj5kdX39coxgjiGHd4dDwZkwh
        wcB82NPYAk2QKKI47jA=
X-Received: by 10.28.125.147 with SMTP id y141mr11592901wmc.87.1495741576659;
        Thu, 25 May 2017 12:46:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:15 -0700 (PDT)
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
Subject: [PATCH v4 08/31] grep: change non-ASCII -i test to stop using --debug
Date:   Thu, 25 May 2017 19:45:12 +0000
Message-Id: <20170525194535.9324-9-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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


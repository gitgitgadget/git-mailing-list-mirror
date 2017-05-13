Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2363201B0
	for <e@80x24.org>; Sat, 13 May 2017 23:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758615AbdEMXP7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:59 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33621 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbdEMXP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so12526123qkh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=coAqhDZTTtUk6URijA5R3wpxlWMGJFdBrSDu4ifDMLU=;
        b=B0yl9csWiHyM3+Fo/9nYR9w4GcJoEhLlOyw/q0JfK8Sp4ZvVujIa0Y/XQjjBtj0TWw
         bsa3mGoILsDJACCDH6q07J7xWKLSNC26NH6rnudRtkZ30qtUUPCqz9DRZUmU1mSIf7X2
         teYNASfEfrjotRwY1EOn4wplYLoyqlCNeShR61imjsdbtU+16CpTrSVto0lEHAhh7+kv
         x7y8C1czjQBnOCe7GE6Au4RnWiM4T42a6nSbFoVe7q6D235K+HfzFMvCmzDkjh0DluGh
         +x/OllXi8LO7zLNedLz4rPzo8QFa/tsabUHvAxdPd8fPV1uzEyrGQE97VJVFUAukUQVA
         W7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coAqhDZTTtUk6URijA5R3wpxlWMGJFdBrSDu4ifDMLU=;
        b=HmjllW5dUQ3FSdOafp7ZJCTdav/grKroO1ZplKKLcWWyrapbR1d86gcMGuAgIJ4wAy
         X3if+62nbGlWRf/B2/4cDd7BPPfejI3xN3518HTOtAzWbSMOIGC17TPG9/YyyzMvQM+9
         qjgvj/KCW3D+Gmzaq3xmM9eChqyTgnWUts4ApoZ8XvyM1y3G/d1MtFEKrZakQD7lUAbw
         zrGMoRECDTAqwvkYJvgw5CS6ygJFCrZNNbRBqWCnToe+/Off8zCp++iyBYTK6BoyPgq0
         qCQsF9g8F92b576EJ3sHGFDIm7hUNpINzrEqkvUMf2Tho0g587rHRi7pivrgkUdZdSjF
         oTuw==
X-Gm-Message-State: AODbwcC5JZLUfk24ZrdzKn8DdbDwOrtxPXSJ9HTt0Cs/a3tGwD384xEl
        6F/FOaaFh7HBwQ==
X-Received: by 10.55.43.168 with SMTP id r40mr10534659qkr.59.1494717357143;
        Sat, 13 May 2017 16:15:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:56 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/29] grep: change non-ASCII -i test to stop using --debug
Date:   Sat, 13 May 2017 23:14:47 +0000
Message-Id: <20170513231509.7834-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
2.11.0


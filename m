Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD1F1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 22:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeK1JyS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:54:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1JyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so24383872wrs.8
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8CzyvxWQ+9FpUvCmn0gurnRdjBJ4iFTG1Kwo5C4neI=;
        b=ILaxwwimZU3p8Pu7sdz/j4oIrCwcFw67zYMvaSqVKuzX6NyVYMaYtKhYc3FOPWockZ
         h61ppcQXQp/mdVQBspJgbI0uWKDm6Gtrcfx5oLBZ2SeUXqwgo0I94ObrFc2tmgKXrubY
         8KSDRAS29OXXR32Mfdgt0XCBQx/CrTOMbKisFWN3o8F9z+UuZ2rSn8tldXAMtiZGxd+2
         FyuXkynFXU+65/ny4o3FI7Hp/HaKN42RXJTKFE/EY8kFuOdQQUUvj5UBfb+W0PvJqQDc
         f6xy8CsrYr5gwGykwi89vAMI27h87K+O4mXJ1oEvxJs59dVEyAGxcWvqwfjeb40QIEeB
         vheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8CzyvxWQ+9FpUvCmn0gurnRdjBJ4iFTG1Kwo5C4neI=;
        b=G75N1Kfg77nz/AkGLM+RRhytrMf4AF91daq4LJYpUmijNeggoTmF+NDSZidq6lKDYJ
         pV6Z/VbU2mmvTXavMBJoyJ63pcHqA0IQ9++VKFqYgd/u78PRk1++j1TjfuQzSMm8inZG
         Kc+UYv5UVEvXgffbS15iPp48vpgm+//7Rq4HE6NKDoKm+sAEdWFocTT8kPLhfXjJuY9M
         +z29k5U+G8+XQHR47IyX8vnYDiFFFT9xvB6MF5p6Z45nsXLDNtVZos5B5I3MSsWz78Ag
         Qqec3EaC5ZBWStv8x6gej6RGrQyD2h3n2CMV+NzLCo/w4xOHED3CXJOV/XejHj5i+Uiq
         f+wQ==
X-Gm-Message-State: AA+aEWY3BHGcDMHYD0X8qVs9MzVRYGtEA7PrTsBZHbVmNTTxfCqJDwWp
        yNNAaCKo9UrR2zYtzAuFy0pjmteX
X-Google-Smtp-Source: AFSGD/WP8YKcoSxcIS58jbmYpCVJjAFee8U8VUGi7Y6i2KR+mx+EzoU8umdOQK0AfB4YQETipe6+Ug==
X-Received: by 2002:adf:b253:: with SMTP id y19mr28674698wra.184.1543359290134;
        Tue, 27 Nov 2018 14:54:50 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v189-v6sm710604wmd.40.2018.11.27.14.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:54:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] t/README: make the 'Skipping tests' section less confusing
Date:   Tue, 27 Nov 2018 23:54:41 +0100
Message-Id: <20181127225445.30045-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added this section in b5500d16cd ("t/README: Add a section about
skipping tests", 2010-07-02), but apparently didn't notice that there
was an existing "Skipping Tests" section added in
fbd458a3f6 ("t/README: Add 'Skipping Tests' section below 'Running
Tests'", 2008-06-20).

Then since 20873f45e7 ("t/README: Document the do's and don'ts of
tests", 2010-07-02) and 0445e6f0a1 ("test-lib: '--run' to run only
specific tests", 2014-04-30) we've started to refer to "Skipping
tests" or "Skipping Tests" sections in prose elsewhere.

Let's clean up this confusion by renaming the section, and while we're
at it improve the example. Usually we don't use the PERL prerequisite,
and we should accurately describe why you'd want to use prerequisites,
as opposed to GIT_SKIP_TESTS. So let's say "Tests that depend[...]"
instead of "If you need to skip tests[...]" here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/README b/t/README
index 28711cc508..b6ec28f634 100644
--- a/t/README
+++ b/t/README
@@ -494,7 +494,7 @@ And here are the "don'ts:"
 
    The harness will catch this as a programming error of the test.
    Use test_done instead if you need to stop the tests early (see
-   "Skipping tests" below).
+   "Using test prerequisites" below).
 
  - Don't use '! git cmd' when you want to make sure the git command
    exits with failure in a controlled way by calling "die()".  Instead,
@@ -587,28 +587,28 @@ And here are the "don'ts:"
    it'll complain if anything is amiss.
 
 
-Skipping tests
---------------
+Using test prerequisites
+------------------------
 
-If you need to skip tests you should do so by using the three-arg form
-of the test_* functions (see the "Test harness library" section
-below), e.g.:
+Tests that depend on something which may not be present on the system
+should use the three-arg form of the test_* functions (see the "Test
+harness library" section below), e.g.:
 
-    test_expect_success PERL 'I need Perl' '
-        perl -e "hlagh() if unf_unf()"
+    test_expect_success SYMLINKS 'setup' '
+        ln -s target link
     '
 
 The advantage of skipping tests like this is that platforms that don't
-have the PERL and other optional dependencies get an indication of how
+have the SYMLINKS and other optional dependencies get an indication of how
 many tests they're missing.
 
 If the test code is too hairy for that (i.e. does a lot of setup work
 outside test assertions) you can also skip all remaining tests by
 setting skip_all and immediately call test_done:
 
-	if ! test_have_prereq PERL
+	if ! test_have_prereq SYMLINKS
 	then
-	    skip_all='skipping perl interface tests, perl not available'
+	    skip_all="skipping symlink tests, the filesystem doesn't support it"
 	    test_done
 	fi
 
-- 
2.20.0.rc1.379.g1dd7ef354c


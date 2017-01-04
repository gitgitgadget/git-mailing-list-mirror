Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753161FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967148AbdADA6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 19:58:05 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33718 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967114AbdADA56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 19:57:58 -0500
Received: by mail-qk0-f171.google.com with SMTP id t184so393012299qkd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 16:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+b1Yzon4VltC1e26QD6RrVWwoju1GuS+fMOntusaGI=;
        b=IiOXLZ2OaIRwbeHQB8GubQwgveaOl17UC5pgA0sZEDn/MiT6llrIVcr+tbaklR9K/X
         HE0bCR3V+YstbukeaMCSksmBYbhkPhOiLxNBNsx+qts+x6N9StrmZcpFRhMfRSXBL8oE
         okJerMKd8AXcKRtP9OXViI4kp7PSwXCkMzlIXJTPx5BBjsm8me2j1TBbH/nhgtpT9O+n
         B+2DuTDd5KuhTLA8lctiMOH9ojv1c/nzln8NlGk36gJLNyIBmIkcLrka0cU1N8wSmHRA
         RH+t94acTv7VXlnWHWg1tJrU+eZD674dcUgc7/zzMHW+7D7N+pYh9UxJAtq/dx4JARwZ
         HEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+b1Yzon4VltC1e26QD6RrVWwoju1GuS+fMOntusaGI=;
        b=dADjcF5fws9fekswSS6TFrpEVKfoOsI+KDGRbgMIx/iArxYbQMEEnMUjlDmrIH5lZY
         +6dEUwEWBp1+CGzRHLjK5V7pIXtSu9uOBd2srM63sFfHs5jLmal4KUbtsTXbomjzo5ZL
         pkhY773LE/ybZrFfuukBaU7LQ3mbYwJHJiYXWGoW5WJWOJIKncXd3SNIyEfjVocdLFiR
         AIG9TTdKY+rOBlYDh5z/2OBnMJjUkJOe5hWAS4Y881i2AZgU9XO36l/zLV14TmVW7Cg1
         RboT71iAMNo45hiDA5CF2Ybf3567Q/nXWS5LsyUh67VDpSXITc9c4Ngr7JxCDCjFvd7D
         L8nQ==
X-Gm-Message-State: AIkVDXItCCajZXHNAlWyss6+Egne5c1wEUKOpryZvDuVcDBEnbAU9807e2z5adfRLntuaGKC
X-Received: by 10.55.165.141 with SMTP id o135mr62412262qke.119.1483491067208;
        Tue, 03 Jan 2017 16:51:07 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id n188sm44734941qkc.30.2017.01.03.16.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 16:51:06 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com
Subject: [PATCH 2/4] t7610: make tests more independent and debuggable
Date:   Tue,  3 Jan 2017 19:50:40 -0500
Message-Id: <20170104005042.51530-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104005042.51530-1-hansenr@google.com>
References: <20170104005042.51530-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="94eb2c062bd27d03d105453a465a"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--94eb2c062bd27d03d105453a465a

If a test fails it might leave the repository in a strange state.  Add
'git reset --hard' at the beginning of each test to increase the odds
of passing when an earlier test fails.

Also use test-specific branches to avoid interfering with later tests
and to make the tests easier to debug.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 14090739f..8e2b4e147 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -94,6 +94,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'custom mergetool' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -112,6 +113,7 @@ test_expect_success 'custom mergetool' '
 '
 
 test_expect_success 'mergetool crlf' '
+	git reset --hard &&
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -134,6 +136,7 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -145,8 +148,13 @@ test_expect_success 'mergetool in subdir' '
 '
 
 test_expect_success 'mergetool on file in parent dir' '
+	git reset --hard &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
 	(
 		cd subdir &&
+		test_must_fail git merge master >/dev/null 2>&1 &&
+		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
@@ -161,6 +169,7 @@ test_expect_success 'mergetool on file in parent dir' '
 '
 
 test_expect_success 'mergetool skips autoresolved' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
@@ -174,6 +183,8 @@ test_expect_success 'mergetool skips autoresolved' '
 '
 
 test_expect_success 'mergetool merges all from subdir' '
+	git reset --hard &&
+	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
@@ -190,6 +201,7 @@ test_expect_success 'mergetool merges all from subdir' '
 '
 
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
+	git reset --hard &&
 	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
@@ -204,6 +216,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 '
 
 test_expect_success 'conflicted stash sets up rerere'  '
+	git reset --hard &&
 	test_config rerere.enabled true &&
 	git checkout stash1 &&
 	echo "Conflicting stash content" >file11 &&
@@ -244,6 +257,7 @@ test_expect_success 'mergetool takes partial path' '
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
+	git reset --hard &&
 	git checkout -b delete-base branch1 &&
 	mkdir -p a/a &&
 	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
@@ -274,6 +288,7 @@ test_expect_success 'mergetool delete/delete conflict' '
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
+	git reset --hard &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
 	: >expect &&
@@ -284,6 +299,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
+	git reset --hard &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
@@ -292,6 +308,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
+	git reset --hard &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
@@ -308,6 +325,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 '
 
 test_expect_success 'deleted vs modified submodule' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -377,6 +395,7 @@ test_expect_success 'deleted vs modified submodule' '
 '
 
 test_expect_success 'file vs modified submodule' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -448,6 +467,7 @@ test_expect_success 'file vs modified submodule' '
 '
 
 test_expect_success 'submodule in subdirectory' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -509,6 +529,7 @@ test_expect_success 'submodule in subdirectory' '
 '
 
 test_expect_success 'directory vs modified submodule' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
@@ -559,6 +580,7 @@ test_expect_success 'directory vs modified submodule' '
 '
 
 test_expect_success 'file with no base' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
@@ -568,6 +590,7 @@ test_expect_success 'file with no base' '
 '
 
 test_expect_success 'custom commands override built-ins' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
@@ -579,6 +602,7 @@ test_expect_success 'custom commands override built-ins' '
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -595,6 +619,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
+	git reset --hard &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -607,6 +632,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
+	git reset --hard &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
@@ -639,6 +665,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	git reset --hard >/dev/null
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
+	git reset --hard &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-- 
2.11.0.390.gc69c2f50cf-goog


--94eb2c062bd27d03d105453a465a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPkhbuVMg8Q/oClw2VWZ
V2P64nWjd9mNitDdoM3oQMuFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwNDAwNTc1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA33488UnmslcuNDf1Hvd0l/Qdb9dIXZEH4l9Jp
KgNH6TlJQY2EUX/Dw15ZJs/eJaj+0OOOILuwuW8ZxPeBr8QPLtBGqz28oKkB6A2htHXjZiGPerau
M05cYESuY7CKwYr3ATjCZluv7aKjeDMPamudDgxzT1s9YxN+DtX4SIfmBrJqCANF8NgbYCR+JEUF
V7cdmq66pXr14wOe+WGWuSR8TM3cRvRZ3D7c3kECTF66zuhxhVWaXGcm35Ord+b+ItmPFX/vC4R7
SR1YCJqpeePG92unKp5YHsZ6QiePSSzZwuAqOLsbFHAYRo5veSNSAAkgnBa0YqNREnnEcf7MN9Pd
--94eb2c062bd27d03d105453a465a--

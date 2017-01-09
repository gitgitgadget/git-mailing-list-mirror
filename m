Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B25205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 05:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031518AbdAIFnf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:43:35 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33525 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939267AbdAIFnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:43:02 -0500
Received: by mail-qk0-f182.google.com with SMTP id s140so107701257qke.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 21:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4bVsMOEAj8+zr8gmUetBwI+fikiNjxU5TlDGxuuLMx0=;
        b=GifgYUikC1gAl005RJylJyMvfOn1c8Jk/4lgrrL01E7G0nYDp2FtW4D/q5jDuaBvLM
         cc6r/1KBmu93iV4z8edjK/MVpZX+q9IThhSphldi8hv/0lRsAt+vRtWfidJbXQBgSc9C
         SCvDQjt8mMgecuDLnqz3G0zQPdKacfLb4Sy7T7KmrNMFnpXBCQqSeQAypcoeU6zp30SL
         dKJmSF/1YznWf9k5rWWI2yS4q4UNnAKwpLNZo+RtVqxMKbxWo4zVFW6bXk+Y79mJKuWf
         EhYxVqH+eKP94QS72Yxg8mqhHyuY13scrOAlmfGzeeX15w6CwPXgrUNjeC3/6FSEKSkn
         NdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4bVsMOEAj8+zr8gmUetBwI+fikiNjxU5TlDGxuuLMx0=;
        b=lSmLdyMil8XF9Ywi4ziUMpHSKW5YdmGiOc9y5ogJmAGD1VnZFcURMi4RDXvkomyCBq
         HOZCt9mGVyk3ujGOaTaCl/bZbkd1JLSQ9eeHgwwteYALnU0cW6UgyI7u4ii2TrpipU/C
         RXHGlorPzyq/3J40Px3/+95en8Gm3SC+yPLWSsgl/4pFOXKZ2MrI/gGBVpqp4DfOnZo4
         62edG8LEuIYDrg9QgCNYX0PKta1xRds4DKkCgddtu8dlr+eNpY8no+5Ank++xqtHnLKO
         UElNgvnmRWj8FYiADCaZ+fsWCS8/NKja91wDBFVSZzQXWFp+qGb0c4MIFIL39qV+e1UT
         EC3Q==
X-Gm-Message-State: AIkVDXKV9bgm8YLUmoPYR6wDCCIh2TA8hpY7ySQcPZ7KZoM67XdL7nybsPYo/J9s8Lx66U+a
X-Received: by 10.55.42.34 with SMTP id q34mr93212845qkh.91.1483940580765;
        Sun, 08 Jan 2017 21:43:00 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id 21sm3452763qkh.13.2017.01.08.21.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 21:43:00 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v3 10/13] t7610: spell 'git reset --hard' consistently
Date:   Mon,  9 Jan 2017 00:42:35 -0500
Message-Id: <20170109054238.42599-11-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a114938e63490c50545a2d759"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114938e63490c50545a2d759

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 54164a320..c031ecd9e 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -289,23 +289,23 @@ test_expect_success 'mergetool takes partial path' '
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
-	git reset --hard HEAD &&
+	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	echo m | git mergetool a/a/file.txt &&
 	test -f b/b/file.txt &&
-	git reset --hard HEAD &&
+	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
@@ -316,7 +316,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
@@ -325,7 +325,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	test_when_finished "git clean -fdx" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
@@ -342,7 +342,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 '
 
 test_expect_success 'deleted vs modified submodule' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -560,7 +560,7 @@ test_expect_success 'directory vs modified submodule' '
 	test "$(cat submod/file16)" = "not a submodule" &&
 	rm -rf submod.orig &&
 
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
@@ -572,7 +572,8 @@ test_expect_success 'directory vs modified submodule' '
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
-	git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
+	git reset --hard &&
+	rm -rf submod-movedaside &&
 
 	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
@@ -582,7 +583,7 @@ test_expect_success 'directory vs modified submodule' '
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
 
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
@@ -590,13 +591,13 @@ test_expect_success 'directory vs modified submodule' '
 	( yes "r" | git mergetool submod ) &&
 	test "$(cat submod/file16)" = "not a submodule" &&
 
-	git reset --hard master >/dev/null 2>&1 &&
+	git reset --hard master &&
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N
 '
 
 test_expect_success 'file with no base' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
@@ -605,7 +606,7 @@ test_expect_success 'file with no base' '
 '
 
 test_expect_success 'custom commands override built-ins' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
@@ -616,7 +617,7 @@ test_expect_success 'custom commands override built-ins' '
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -632,7 +633,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -644,7 +645,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
-	test_when_finished "git reset --hard >/dev/null" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -662,7 +663,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	test_cmp expect actual
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
-	test_when_finished "git reset --hard >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -678,7 +679,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	git mergetool -O/dev/null --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
 	test_cmp expect actual &&
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 
 	git config --unset diff.orderFile &&
 	test_must_fail git merge order-file-side1 &&
-- 
2.11.0.390.gc69c2f50cf-goog


--001a114938e63490c50545a2d759
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
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJNdMALu4LNmBrVoXs6/
7SNDOUr8WoKBnzydKxE73Q0LMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTA1NDMwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBQvEC9FRVRPhKnD7deWrSHj1d9A1HycNcLpsOh
BSThSZMCfNtC3sFd+SspsSsasloDd3rvwI1QY32ABLpDjP+TM1Vc7EcF9tDwAeHxWkGBkimBN2ld
mcYbOaBVcNMmUiKU+mw4QnvndKBcEDwdt8p4e1n7lUIchdOzJjouwHaaSRdOQqQzCxreawf8On1e
S/y/gicpaP++noEiyqAkINdISo6eKwuDfzN8t259xY1by1+tUjAcLa+pJ4t+LEpu5l8Bt0+UPcmP
ahUw1aB/enyKNFRjlmKYjWvy9X3Eoq0oJCvsEzlyLSA4SOamVre0QMDfmlagPfUJWW9CFGOgiFpP
--001a114938e63490c50545a2d759--

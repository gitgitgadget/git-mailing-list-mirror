Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB6320A93
	for <e@80x24.org>; Mon,  9 Jan 2017 05:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdAIFnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:43:13 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33501 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939250AbdAIFm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:42:57 -0500
Received: by mail-qk0-f171.google.com with SMTP id s140so107700098qke.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 21:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WLKHufs3PK4ZwwITZw2uem96Ax4JsWQ6Tfmsa9hIOSI=;
        b=iqJkzej3bQ4EpHlUu/HaTC48HGMpy6W6r68yzawGCP/inB6LgSHvkSxn8BLHBZpV+c
         tk9G91o1VfW1VfWtOVsCqwI/Mud3x+zoBIQEJe4ZnMN5hJLK3vw8gtwk6nBvJ5t9u+gx
         Qwdj0aHTVinSEcHOmxL92jKdietOCmxe/GIzmRHq7feeKGGKD8SqGspvgFGlvatDCE7R
         g+5w/dZmn/DtX/jTqhNx9oI2dzngFNxKVGOIGgyiqKuQf0OCyHUGf4YgAtO7hLJnd6XB
         zuHBiwUQjvfJmeXyG83C02EdWSlmxccUD6ddfHF5d/SObnSYkxVGwOgaZHZEn1qfHo/N
         2j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WLKHufs3PK4ZwwITZw2uem96Ax4JsWQ6Tfmsa9hIOSI=;
        b=Qxps7ke63DxBKMhrgCs7LSSPanUdT2mb4Su5jSrXuX1t28fXS6mRAZf62rduf51Uxs
         RLfJZW/TpOwCZYUT3V4SbiUKwbxwOIOUwYRfHjRooq7Zr1kNURhR6gLCKdYpxl9NZTut
         fxSvCsv5gvryR0au+zVunB4pIq9RLLG7d2su+fe5PpJTnJmMQ5zbCkXe9YGNH+3qoE7f
         +1UNsfxQg9cVtqN1LcpXwePuwawFlApQCAQfslUgr2BuB1h9XGmxVyX+O+B/tvTeUzoJ
         CSPOUnfmV78gJGKsZHjhcnbsxsB+IBxZTLHkpHptsL6TnHxrw4DDT2FtMNK38ytAU7Bq
         XJ1Q==
X-Gm-Message-State: AIkVDXKhVnwtfe+yRttONEB76y9bOkXjN3td00SjaKURwVRjPx7lhqzkdGL6B/p1qs5zT6MO
X-Received: by 10.55.167.5 with SMTP id q5mr7732676qke.61.1483940575801;
        Sun, 08 Jan 2017 21:42:55 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id 21sm3452763qkh.13.2017.01.08.21.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 21:42:55 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v3 03/13] t7610: Move setup code to the 'setup' test case.
Date:   Mon,  9 Jan 2017 00:42:28 -0500
Message-Id: <20170109054238.42599-4-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a114fca42e81bb90545a2d69a"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114fca42e81bb90545a2d69a

Multiple test cases depend on these hunks, so move them to the 'setup'
test case.  This is a step toward making the tests more independent so
that if one test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 65 ++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 14090739f..550838a1c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -55,6 +55,22 @@ test_expect_success 'setup' '
 	git rm file12 &&
 	git commit -m "branch1 changes" &&
 
+	git checkout -b delete-base branch1 &&
+	mkdir -p a/a &&
+	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	git add a/a/file.txt &&
+	git commit -m"base file" &&
+	git checkout -b move-to-b delete-base &&
+	mkdir -p b/b &&
+	git mv a/a/file.txt b/b/file.txt &&
+	(echo one; echo two; echo 4) >b/b/file.txt &&
+	git commit -a -m"move to b" &&
+	git checkout -b move-to-c delete-base &&
+	mkdir -p c/c &&
+	git mv a/a/file.txt c/c/file.txt &&
+	(echo one; echo two; echo 3) >c/c/file.txt &&
+	git commit -a -m"move to c" &&
+
 	git checkout -b stash1 master &&
 	echo stash1 change file11 >file11 &&
 	git add file11 &&
@@ -86,6 +102,23 @@ test_expect_success 'setup' '
 	git rm file11 &&
 	git commit -m "master updates" &&
 
+	git clean -fdx &&
+	git checkout -b order-file-start master &&
+	echo start >a &&
+	echo start >b &&
+	git add a b &&
+	git commit -m start &&
+	git checkout -b order-file-side1 order-file-start &&
+	echo side1 >a &&
+	echo side1 >b &&
+	git add a b &&
+	git commit -m side1 &&
+	git checkout -b order-file-side2 order-file-start &&
+	echo side2 >a &&
+	echo side2 >b &&
+	git add a b &&
+	git commit -m side2 &&
+
 	git config merge.tool mytool &&
 	git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	git config mergetool.mytool.trustExitCode true &&
@@ -244,21 +277,7 @@ test_expect_success 'mergetool takes partial path' '
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
-	git checkout -b delete-base branch1 &&
-	mkdir -p a/a &&
-	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
-	git add a/a/file.txt &&
-	git commit -m"base file" &&
-	git checkout -b move-to-b delete-base &&
-	mkdir -p b/b &&
-	git mv a/a/file.txt b/b/file.txt &&
-	(echo one; echo two; echo 4) >b/b/file.txt &&
-	git commit -a -m"move to b" &&
-	git checkout -b move-to-c delete-base &&
-	mkdir -p c/c &&
-	git mv a/a/file.txt c/c/file.txt &&
-	(echo one; echo two; echo 3) >c/c/file.txt &&
-	git commit -a -m"move to c" &&
+	git checkout move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
@@ -607,26 +626,12 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
+	git checkout order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
 	echo a >>order-file &&
-	git checkout -b order-file-start master &&
-	echo start >a &&
-	echo start >b &&
-	git add a b &&
-	git commit -m start &&
-	git checkout -b order-file-side1 order-file-start &&
-	echo side1 >a &&
-	echo side1 >b &&
-	git add a b &&
-	git commit -m side1 &&
-	git checkout -b order-file-side2 order-file-start &&
-	echo side2 >a &&
-	echo side2 >b &&
-	git add a b &&
-	git commit -m side2 &&
 	test_must_fail git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
-- 
2.11.0.390.gc69c2f50cf-goog


--001a114fca42e81bb90545a2d69a
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
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHZp7bUsfK+XjQp8hAbR
lyRYElE/MRG5dFgEmpTKO5VcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTA1NDI1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQClB13ZtcXL7E+qBNrG2S+Q02A26GQa8XpXSrxI
Z1QCMzAdFK+rTTMlV9h2O2BcT8v9ElAPLmXQhrLhoLthoanCJRe6Q6AOJM2blN6bsKZoOfH+aXcX
95UXNUd2ZUmeVnkS4ZsmBBSkm0tLvV/eAGu5ZN8hGAk3K/zS4soGm5NLSUbJO5kiRwIX7ktwaR3v
Jc0+L+pD/ZXWFodcbeh24ueZg5j1q3sSILTaFPgYZC7jHLUh9ErK0S28tS/75RMjrblyh5EF+a76
AWIbwCvoyDdbxv71xxccy/1/h2IaNdp/Dk6OOuJauFF7kL32/UGlijZyZIldmkTVYGZ+FzHmal0K
--001a114fca42e81bb90545a2d69a--

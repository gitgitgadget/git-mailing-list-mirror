Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081D1205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 05:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdAIFnR (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:43:17 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35299 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933821AbdAIFm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:42:59 -0500
Received: by mail-qk0-f170.google.com with SMTP id u25so514988454qki.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 21:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2TTFUTsRIWbkeIgSFg9+b5e6uItIkIKRwfKvvAmlzI=;
        b=UdtESMeAHRAAUbhSR9bZ6bJ5Mf8g6HmE4ZsfHkRiNStAF7R9AYl/YJ3yzEsZ2j28kP
         IN0yK3eXWLMNKl9OTuGUU77vH0o9rZsB6/GSgnSGljmyvWWk9AxHKaW4ZoHJ+FxER/Ye
         O8JcGHc7uF7QvArMlOJiuO6RCmqCXG8tRGB5L6ZiCpS+xXOEOQXuNVaH7VycKBCSzSh/
         1I+AplwbLTnpjh/vcgyfYeqIFsq3NlZPMz1Q4HvwcoLNJkeVuCiLbO6jhDcfAV7INfJR
         gUTIFUgfVJ0y+YnQerZk0ByaNJHVFzeiS89Rz04Jz99KtafffBDwPine7WeXC05+GOzQ
         IuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2TTFUTsRIWbkeIgSFg9+b5e6uItIkIKRwfKvvAmlzI=;
        b=ptdpx0M85S/ieTRfEeXBdkp9967QhLrnBMYAziGd/8zxSeDiXsClszDcm7Gi/UqFnY
         l0NSxRnnoV6/ILNf8FqXkyFBjM3nGsuy4bKPpF+1gDQdzXhibdosWEpKUTi3ZVAzXmVB
         2ZCiI4pibIB5d9KOFpg4JSMY7wcMXKqStT9M8jGd7tyBR1Z8o2jEu9ebpCbvYcpmlSIB
         NIHqJNDlqJYLT3Yn2JUMhrX1EvSDgsyHL5NLiTFdafdm85Kmtninhe3GWM5qBToxehyr
         VerSbskW4kX/xEE60nwsoq+HBLl8DLcpvYW0rh+hUtewmRdSFhmC5K6zHh89jr1C/BIS
         clKw==
X-Gm-Message-State: AIkVDXLTs3X4L17kwQfRi17hHQQudJIu1z02a2niOpQBy1Zniy8MqyngP0SmSizOZ1x0i5co
X-Received: by 10.55.21.196 with SMTP id 65mr85637252qkv.230.1483940578650;
        Sun, 08 Jan 2017 21:42:58 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id 21sm3452763qkh.13.2017.01.08.21.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 21:42:58 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v3 07/13] t7610: delete some now-unnecessary 'git reset --hard' lines
Date:   Mon,  9 Jan 2017 00:42:32 -0500
Message-Id: <20170109054238.42599-8-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a114739d212d5cb0545a2d787"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114739d212d5cb0545a2d787

Tests now always run 'git reset --hard' at the end (even if they
fail), so it's no longer necessary to run 'git reset --hard' at the
beginning of a test.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 55587504e..7d5e1df88 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -184,7 +184,6 @@ test_expect_success 'mergetool in subdir' '
 
 test_expect_success 'mergetool on file in parent dir' '
 	test_when_finished "git reset --hard" &&
-	git reset --hard &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -277,7 +276,6 @@ test_expect_success 'conflicted stash sets up rerere'  '
 
 test_expect_success 'mergetool takes partial path' '
 	test_when_finished "git reset --hard" &&
-	git reset --hard &&
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-- 
2.11.0.390.gc69c2f50cf-goog


--001a114739d212d5cb0545a2d787
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
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPsY4bLi8nfRiv8lzT87
bbZAvPeGo2z823SujfyTIzN6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTA1NDI1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRX2FhwJM2j0SA4xZ8SBZNzyOH8VJWZtjZzG16
pIEfKuOipCgI6YqeWH5jKyJ4lpax4xxyXfYuzr+ZAfp3qLi7D0qHpGQv3puHXvqraFLS4PINP4Xp
gc4+JvZ8TT4kKaMBX+kdA9DW09jx/Xknt6o0dZWerhpTMk8T1JXIE67KjSxJpIZJsYvCUp1fF//J
iv+Z4ncDsBkjiYYL3VE2xqv+70UMTV3UPzeNGLl0y40nA7aqFhu8F3GuQRu+phNezbDwEYf9zGty
n2DEEhozB5mIMLYAb3M3rBgJKDsWlEY6MkVBup57Lxoq2U5UL5leRrCPfPV80KlaloU1EMtJCrWN
--001a114739d212d5cb0545a2d787--

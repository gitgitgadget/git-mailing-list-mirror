Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB7B205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 05:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031669AbdAIFn1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:43:27 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35370 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbdAIFnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:43:14 -0500
Received: by mail-qk0-f173.google.com with SMTP id u25so514991898qki.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 21:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x7o8ppviXEVyHXKDXjK5jFAMc++qkL5raSctCghH/1M=;
        b=jL/DpNmror3sj0A6xZuf6t8w7j9t7ocjakDfSg9OlOJuQxQxUljIPNF3QEuIORkqbQ
         TJXlZSdYfbj9FeoIcLRBBHquvHRnCw/NC3V9HOrcEvubinO6SMvbVqRfmDVKakrG2uIS
         +vlG8b4rTIkyg28Sn9X5jrjqmVuigycR/juKtGeFr6jNKhn5zsOuiqi5koSo6byMkU3c
         Ldr6iQrt2S2DUg1x1Fzu9pbalRrbskozEaF3x/6jNil+FYSfjXHyZpD1kPr8zD2sDtXn
         vvdTnDaPxK3GUb79W6jjqVVvimIC5woOvls57X24yvJ7UwUEtEtJD5QYZBScp9HS/2gP
         QgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x7o8ppviXEVyHXKDXjK5jFAMc++qkL5raSctCghH/1M=;
        b=r3VTnu4s9kd+lj3OTK1qAxCIIP4JsPwIxRlM8x81vtLG6xtIRw6ZUpeA5dmsdA6hPi
         7+7OqfNqsLdigKaEzx8I4WLUggjgwYhLsJj7BZXeq0jtcGSIaIZ203iOxnct/uYdNC1h
         fz8MkRNZhNvGM11O2F1UF3wL0DHlV7L0p0XyyjxGgPINNcKYXK3nx+1+FUKA6H54ZmuS
         hBt7SHtpjQP/IRV7cSd+lRfAzPYrMNrw6V57Ku5JxvX42AyzYQYhGC3+qc91bE4rnXiI
         nN2gCMpyG6AcSc/owoZyBFm4bVDhQmNgzNgxk2hJs6Prygh26vG9vlYxXolvzdbha2ec
         PndQ==
X-Gm-Message-State: AIkVDXJ775Mf954iOkoN02dguFhgTFmlEuVN78oa//Hag1GJCFAReQRNPxZjdighgE2XBCEr
X-Received: by 10.55.190.6 with SMTP id o6mr69380317qkf.124.1483940582684;
        Sun, 08 Jan 2017 21:43:02 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id 21sm3452763qkh.13.2017.01.08.21.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 21:43:02 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v3 13/13] mergetool: fix running in subdir when rerere enabled
Date:   Mon,  9 Jan 2017 00:42:38 -0500
Message-Id: <20170109054238.42599-14-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="94eb2c0431c6f650f20545a2d7bf"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--94eb2c0431c6f650f20545a2d7bf

If rerere is enabled and no pathnames are given, run cd_to_toplevel
before running 'git diff --name-only' so that 'git diff --name-only'
sees the files named by 'git rerere remaining', which outputs
pathnames relative to the top-level directory.

The cd_to_toplevel command could be run after 'git rerere remaining',
but it is run before just in case 'git rerere remaining' is ever
changed to print pathnames relative to the current working directory
rather than relative to the top-level directory.

An alternative approach would be to unconditionally convert all
relative pathnames (including the orderfile pathname) to be relative
to the top-level directory and then run cd_to_toplevel before 'git
diff --name-only', but unfortunately 'git rev-parse --prefix' requires
valid pathnames, which would break some valid use cases.

This fixes a regression introduced in
57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 git-mergetool.sh     | 32 ++++++++++++++++++++++++++++++++
 t/t7610-mergetool.sh |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b506896dc..22f56c25a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -456,6 +456,28 @@ main () {
 
 	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
 	then
+		# The pathnames output by the 'git rerere remaining'
+		# command below are relative to the top-level
+		# directory but the 'git diff --name-only' command
+		# further below expects the pathnames to be relative
+		# to the current working directory.  Thus, we cd to
+		# the top-level directory before running 'git diff
+		# --name-only'.  We change directories even earlier
+		# (before running 'git rerere remaining') in case 'git
+		# rerere remaining' is ever changed to output
+		# pathnames relative to the current working directory.
+		#
+		# Changing directories breaks a relative $orderfile
+		# pathname argument, so fix it up to be relative to
+		# the top-level directory.
+
+		prefix=$(git rev-parse --show-prefix) || exit 1
+		cd_to_toplevel
+		if test -n "$orderfile"
+		then
+			orderfile=$(git rev-parse --prefix "$prefix" "$orderfile") || exit 1
+		fi
+
 		set -- $(git rerere remaining)
 		if test $# -eq 0
 		then
@@ -463,6 +485,16 @@ main () {
 		fi
 	fi
 
+	# Note:  The pathnames output by 'git diff --name-only' are
+	# relative to the top-level directory, but it expects input
+	# pathnames to be relative to the current working directory.
+	# Thus:
+	#   * Either cd_to_toplevel must not be run before this or all
+	#     relative input pathnames must be converted to be
+	#     relative to the top-level directory (or absolute).
+	#   * Either cd_to_toplevel must be run after this or all
+	#     relative output pathnames must be converted to be
+	#     relative to the current working directory (or absolute).
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
 		${orderfile:+"-O$orderfile"} -- "$@")
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b36fde1c0..a55bf67e1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -234,7 +234,7 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	)
 '
 
-test_expect_failure 'mergetool merges all from subdir (rerere enabled)' '
+test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled true &&
-- 
2.11.0.390.gc69c2f50cf-goog


--94eb2c0431c6f650f20545a2d7bf
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
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMXwJrGbTI3kWj93jgEw
k71jHck1NWUBoYpRoIHmMUisMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTA1NDMxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAnva+PdVqch1W3Cb109UDlE4iV4YuHD3LK/eAk
n17oiPCQhL+e2YuG7SweyK8uSD5ZegtzEDWCdKnv8YniYQ1ypTGqrk8dZVVg3Lp5rbJUqJkPUIWs
eUnUYASO2vmVvMpGKWstzLy7ikYwvJRY/cPOrhtQ0aVH6Cmyb2+0inycW8Mal3gZQ5A7kvSHvy/5
xejeua0OPDGfN1JBLKAOHd+VZnMfVBaVLpyQ7OMJvoRa5atLFBcI6SEVamyzXrWwdNYW8jS3M/2m
hv7yi7tXTRzD0j2OhF9SE0db0X/IB5pGkRCVEMoDbwPEqgxKgdcz1b+PL1N9GAnB4qYX6aCkB4jo
--94eb2c0431c6f650f20545a2d7bf--

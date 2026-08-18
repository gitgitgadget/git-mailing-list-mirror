Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0F23A564
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089744; cv=none; b=l0k2X07UoIJKTyarEISI6m/ka3BGt2Zdz5LhbDf6ayxaQ2tn9EagZdhtSgbxzhaCNXkCV/5X9gKUS5+brrVVpo0dVCMh/F3vYW5Yfc3t3xkoPas6YBornEIzV3w5mjiKSnQkuhEpefs/VrB9MZU/oWqxBNDUXO+OEj3cLF9rOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089744; c=relaxed/simple;
	bh=Dxv/yAy3ALbA9YREYC1ATDIDAaGVOu5aI+a0rWOg8wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7y3bQWv/ouxuwz0ZuFGYBcznQH7hBoUqWwvtPx1UEGoyMNXtzJ6RM9tew55kdpYUm+6Ik3XpwuL54wryJCh2ncvfT7V7SOZbsJm2ve2oj+YFDsnbsHahrbA2gAFRfVrcf4rK35DSC9NN8FZP9kIYrGKbWGqGcn64URqqTg5aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfgyDEyO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfgyDEyO"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ea0b7d137so4297087b3.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089741; x=1787694541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nS0KqiBJPbEXSzJJDTnMDvzM/lAXYGyXwFrw5kQ4bmQ=;
        b=KfgyDEyOe1udCfde0/yIkDTJJL4/+c8Qm8kvsRDAYWZUO9nsm4WuuILJk+GpBVQTCb
         CMoPuhBcZpG5aclm5VYB4NmkRJkDEUiLlEWRyJhdZYeMwZorao9Ech+GA2xYuCISZ6wI
         ponwEfOPbvBfWkVDvVu9YFRNUt1vQT/OQcOEp1866vM5rFBW65wG4oi4gJt56VKQg5b/
         A/DpYsHT/NfkQ8JjhX8wXBl1e1PF2WDUBK/dkKY6j6kljruFPWcH0O/BPjKScE8G/wlR
         6UiPCKlwX92HQ330DobF5sY7yj1nitfeTHfffBJgBZz9Xz0DmYuI4yKu26zP5opBfA4l
         DVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089741; x=1787694541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nS0KqiBJPbEXSzJJDTnMDvzM/lAXYGyXwFrw5kQ4bmQ=;
        b=Yisy2IScXZQk8/UHB4p8oiBxb6OnGoKyfvCt8H/RaEb3Cf05D27mrjQ1P+ck7x+PQM
         PCsjvQTMDMfUZyt/0VDunIMaX2DeOXIc7ZyZhvRGqexL407DMKaG6RiDBPQyM38Dn5xL
         mvQkQL+4U7lswCCdD1qJayo9z40SxDDn6AoE4mN+cKqr7tGLpd3Vcn5BS3pv4oveEnYS
         /z26xf8HTyQLKWpWVQHr5cxvuA4mYpdL58MMkOo/NhpPkXz6COcAMZ60Yokj0yMyvIaC
         OAUSDuAIVDk/sVKn0E89ynRE+Udf525LFyDJKfaeAEk+jt5DqRBZtsMmkLdyi2kUrZFi
         XD5w==
X-Gm-Message-State: AOJu0Yx6dSzDF6oNxEho6a0BSEu+36hHvUNs6R0DG4SeszHPmdH/nB1R
	Ntjuec+drVxoOP9bKNL48mOiyKOz0AtWVzZv8W2n6ENpL/bCkGOjmYbxLoKUEEDT6mA=
X-Gm-Gg: AR+sD12pVS1MUl74q48X1V+Rwtn8pjbx20ZeUMu4IfExa/s913nJXKIme3sXct9jzRh
	8BsN3P9w9nMurkusSRiJZ/waRAWbE3eFamBKiOHXuZswUrlN3AkTxJUfdWmlHmWC60AkVypNBnC
	cqXfi/3JQwEtYC/88PbYQuGC6AozvCs036Y7yZb2DUKAI3eMgyYjxIS7NVbpRzooiuTawFXfn8U
	20P8KwbHCTxZ4Pj06CPGsVamUU3lixjFWWvyiD+ThyYp9OYLG46uGT0brMfOhoXkpmVHxilejEA
	8/nXx3JqVEMrbhUsQeNt+PTNkf7uWzvKoGatNMdWdqUYsMMP6OutjIQuexFbJr1K/KDChJrrr/u
	IjwA0JuhEsk1j3txYoCA6hGEGGoSN8lpQWr2x/ngnEF5GpikluSrByEB+e3zTwzMc51TglkmRKG
	Wm1JYhtMGXF4A1AUCfH11VCgwtPfA78vo+pvf4kgvXg2+RPxz5nK0mDCGhgx5x/JPwyI60NQVJD
	oiuwothsAQU18LN892S5tC5k9BUEsKHlyQG1T7dNDgY2w==
X-Received: by 2002:a05:690c:e1d5:10b0:809:9422:8c47 with SMTP id 00721157ae682-844e2ecd5e5mr1444227b3.22.1787089741297;
        Tue, 18 Aug 2026 14:49:01 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:40a9:be24:84bb:5d49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-844c8fa434dsm1366457b3.26.2026.08.18.14.49.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:49:00 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	avarab@gmail.com,
	ps@pks.im,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Tue, 18 Aug 2026 17:48:58 -0400
Message-ID: <20260818214858.65122-1-ggordon@gitlab.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqmruqt36l.fsf@gitster.g>
References: <xmqqmruqt36l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grayson Gordon <graysongordon1@gmail.com>

git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
OCSP "Certificate Status Request" extension and any stapled response a
server sends is ignored, including responses that explicitly state the
certificate has been revoked.

Add an http.sslVerifyStatus boolean that maps to
CURLOPT_SSL_VERIFYSTATUS.
http_options() is already the collect_fn for a urlmatch config, so the
per-URL form works with no changes:

    git config http.https://example.com/.sslVerifyStatus true

Defaults to false/"off". This is due to the nature of the OCSP protocol.
If enabled, git would expect to receive OCSP stapled responses. If the
stapled responses were not present, the connection would be blocked as
the status of the server's certificate could not be verified. This would
break connections to legitimate services that don't use OCSP as their
certificate revocation mechanism.

If the backend can't check the staple, curl_easy_setopt() returns
CURLE_NOT_BUILT_IN. Error message includes curl_easy_strerror() with
the option name to enable users to more easily identify a libcurl
built without status verification.

CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
7.61.0 floor, so no version guard is needed.

Tests are in t5551.

Additional note - I put this in http.adoc:
"Defaults to false, which
allows connections to remotes without validating whether or not
the certificate has been revoked by the certificate authority."

Technically, there are cases with older combinations of GnuTLS
and curl where the revocation logic actually WILL NOT allow
such connections. Search "OCSP" in the lore for full details.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---
 Documentation/config/http.adoc | 14 ++++++++++++++
 http.c                         | 14 ++++++++++++++
 t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..b54f627969 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -196,6 +196,20 @@ http.sslVerify::
 	over HTTPS. Defaults to true. Can be overridden by the
 	`GIT_SSL_NO_VERIFY` environment variable.
 
+http.sslVerifyStatus::
+	Whether to check the revocation status of the server
+	certificate using the stapled OCSP response supplied during
+	the TLS handshake ("OCSP stapling"). Defaults to false, which
+	allows connections to servers without validating if the
+	certificate has been revoked by the certificate authority.
+	Enabling this option will prevent connections to servers that
+	have a certificate status other than "good" per RFC 6960.
+	Connections to servers that do not return a stapled response
+	will also be refused.
++
+Set it per remote, e.g.
+`http.https://example.com/.sslVerifyStatus`, rather than globally.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
diff --git a/http.c b/http.c
index caccf2108e..4a4dd40fe2 100644
--- a/http.c
+++ b/http.c
@@ -44,6 +44,7 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
+static int curl_ssl_verify_status;
 static int curl_ssl_try;
 static char *curl_http_version;
 static char *ssl_cert;
@@ -400,6 +401,10 @@ static int http_options(const char *var, const char *value,
 		curl_ssl_verify = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp("http.sslverifystatus", var)) {
+		curl_ssl_verify_status = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
 	if (!strcmp("http.sslversion", var))
@@ -1133,6 +1138,15 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
+	if (curl_ssl_verify_status) {
+		CURLcode ret = curl_easy_setopt(result,
+						CURLOPT_SSL_VERIFYSTATUS, 1L);
+		if (ret != CURLE_OK)
+			die(_("http.sslVerifyStatus is set, but could not "
+			      "enable OCSP status verification: %s"),
+			    curl_easy_strerror(ret));
+	}
+
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..75ab07f031 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -680,6 +680,35 @@ test_expect_success 'passing hostname resolution information works' '
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
+test_lazy_prereq SSL_VERIFYSTATUS '
+	test "$HTTPD_PROTO" = "https" &&
+	test_might_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
+	! grep "http.sslVerifyStatus is set" err
+'
+
+test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=true fails without a staple' '
+	test_must_fail git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=false is a no-op' '
+	git -c http.sslVerifyStatus=false \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus applies to a matching URL' '
+	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus is not applied to other URLs' '
+	git -c "http.https://example.com/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
 # here user%40host is the URL-encoded version of user@host,
 # which is our intentionally-odd username to catch parsing errors
 url_user=$HTTPD_URL_USER/auth/smart/repo.git
-- 
2.50.1 (Apple Git-155)


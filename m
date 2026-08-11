Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1E453A58
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467727; cv=none; b=Vf7u92d9QiLXKFAvnFQieYmPymOkRDrorVntajd8MiHcLnBHyq4EKRa7/i5y1GWCcOk4DbXHoVucRQ9acH2Zz8/rygl3fBKsvcB4ZJqvDcZbB6VeCOR4YSgwbOOAlpOhVeJudfx7Eb9PwgipdbSbwD7vDxvgHkE7Hu98bsphIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467727; c=relaxed/simple;
	bh=qOu5yam1ZAn4KGPkegUCYgTFAR9eyG/nkrIJALTzjx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7LisFaecHunXXab+hDRIbvQDhC0gVfKqRYVUtnuAgciI4p65+BJ5TP0IqhmTBfCVsV68FT+nf5sL7z9YJInIUypWzpdZigSezyzaFRqlDZVbv5ijqkpHq9VRmVobQAqRkfVnpSW7//i0xgv5C38UmBRpMfMLoNf786lfhNv98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE539nfn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE539nfn"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dbcb505578so28307277b3.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786467724; x=1787072524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5lJESSdtO5t/XRlHreTHNKSgWkmq7xIiEHXWT1vymI=;
        b=nE539nfnQ9OZKuv5j3UC9y67d51b1a3QKf5Kb6Zx8UQRrWGLzk0CWL80mEhMUN1294
         oEaXcYG4jeRgdfsJjsN0vVTu0YcDnGwrN4DA5fSWTMukRdLxhh1qhN5wk4PE7IARmxSB
         cr8nkv1diRJeCaIqPoqReN1FbyKvIqgeUXXuGHM+aFn47/LgY/uIj6iqB673picoXeTy
         HKFFcklLYt4gX4b+xoaPs/VVr5HgFLqjQVRspK59jhRFdmANoLZ93+HKmu9V3VKA1D1Q
         GhV1jWtinxx4oKf1TsnMT/S66LKtG5zAGq7oV2/EGYAks+YUIMZxG1NXkZnmZFlBrjYi
         e7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467724; x=1787072524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5lJESSdtO5t/XRlHreTHNKSgWkmq7xIiEHXWT1vymI=;
        b=kG+DoRbX0YPXck1ukexaKj+dItiUa4kTGg2oaHjFIRXOKqUEJ6G56GZJgRz5foSxZL
         P48FUf2+HacwFHospPWA0UjfqU2/rVWn2Q7I0ob/uvHThZr9hRWIvqSfPKpXp/AK9wBS
         tQg+Q840HwX25gq8AJl1sMhZ7S3CFqL2WJt1K8vxdxVCVyI58eGXzQ3VO+hSqb1KRRsA
         aSc3JU2IgL3huUHLaGx94VeWmdfE8QCnytyvJ1SDivC7BxIKUxSB0hNGW10sTHa2r5YI
         LFnqFC+Pl7gQYbwita7Kq6oDJ4RlpumdHXvjJ/4FRRg7SyDUtBVujfIVoRBEh6Njln0A
         vkaQ==
X-Gm-Message-State: AOJu0Yy7t9WClinI/JZLJSMHJSiXXg0ocVMrfNBly1+Rq/LQ3Iemn1p+
	1a+qvVn/XE6TuQY/XwckzttdUIbSRGliOW4RsVebS1f6xZiaXJ1GNr5jY3p4shF9V0w=
X-Gm-Gg: AR+sD11rODxg9B4nS9vGcOEKTT+Yf8BTnmJrhHVxEU4BVSTgddodtGSkWBy8K4H22yx
	sqROrPHzS9YgX6pKrfaeHzHMoxp5NtOu7NWrUMY7QWf3QW/LU5vVCPr2Ba9xbuE/GBNlt9YqK8D
	uybtEqb+mIFiB2HkcZC3KCf+cwz3178f84tvjOtHDdMjOyIu+292bTPYBwofhLgfVHZ5omXaKdM
	vqx94V3+V65VrQlmKUs9bsRV/Pq+TQz0vYhjOf/Y1QiQJNegWjesnRo68wgpjnzvwjcvB5WLgVW
	JoFX+omxnvkrakAdQv++bna57fsb5v6kAo5niPfAO4xdSLeqhCWd+n5gcueybS8mMPka2kL23sI
	dLgYHS6VKzB1c9OkZbybmc8PrR6R3wQWBiC4lYpCUknp8cTWS2x6Ibu23FVk3l3pe+eSrfRsvWd
	a9P5voUWT59JAZmVUsA4j00qJQEOdX6nOhgUQNBhEvBLoO7uMSRQ1vHPTADUPVLBej3Xbtpo/li
	5gjRfkj5GYh2vlDFFlJdyPgyw8vRzyS8dH6lnlKeeFjYw==
X-Received: by 2002:a05:690c:7207:b0:80c:b92c:77a9 with SMTP id 00721157ae682-82f271b2e7emr36964627b3.6.1786467724177;
        Tue, 11 Aug 2026 10:02:04 -0700 (PDT)
Received: from ggordon--20250919-QJQMF.attlocal.net ([2600:1700:1d40:f4c0:c43c:c606:d461:4f02])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a443927dsm297957b3.15.2026.08.11.10.02.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 10:02:03 -0700 (PDT)
From: graysongordon-gl <graysongordon1@gmail.com>
X-Google-Original-From: graysongordon-gl <ggordon@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	avarab@gmail.com,
	ps@pks.im,
	Grayson Gordon <graysongordon1@gmail.com>
Subject: [PATCH] http: add http.sslVerifyStatus to check stapled OCSP responses
Date: Tue, 11 Aug 2026 13:02:00 -0400
Message-ID: <20260811170200.43097-1-ggordon@gitlab.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grayson Gordon <graysongordon1@gmail.com>

git asks libcurl to verify the peer certificate and the hostname, but it
never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request"
TLS extension is never requested and any stapled OCSP response the server
does send is ignored.

On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
response to the application and takes no view on it:
SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
whether the returned OCSP response(s) are acceptable or not", and libcurl
only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So git
will fetch from a server whose own staple says its certificate has been
revoked.

A GnuTLS-linked build behaves differently, and the difference does not
come from curl. GnuTLS consults a stapled response inside
gnutls_certificate_verify_peers(), so the failure surfaces through the
verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the same
server, therefore enforces revocation or not depending only on how its
libcurl was built. That difference is documented here rather than papered
over: this option turns the check on where the backend needs asking, and
setting it to false does not turn the check off on GnuTLS.

Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
Because http_options() is the collect_fn of a urlmatch config, the
per-URL form works with no further changes:

    git config http.https://example.com/.sslVerifyStatus true

It defaults to false, and has to. The option is fail-closed: libcurl fails
verification when the server staples nothing at all, so turning this on
globally would break every remote that does not staple.

Leaving the default to libcurl is not an option either. The same
complaint was raised there in https://github.com/curl/curl/issues/15483
and closed as intentional ("Marked as enhancement since this was done on
purpose"), with the observation that stapling is expected to see less use
as Let's Encrypt drops OCSP support. If the check is to be reachable at
all, the lever has to come from the application.

If the TLS backend cannot check the staple, curl_easy_setopt() returns
CURLE_NOT_BUILT_IN. Fail loudly there rather than carrying on, since
silently not checking is precisely what this option exists to prevent.

CURLOPT_SSL_VERIFYSTATUS has been available since libcurl 7.41.0, well
below the 7.61.0 floor documented in INSTALL, so no version guard is
needed.

The new test exercises the fail-closed path, which needs no CA and no OCSP
responder: lib-httpd's server staples nothing, so enabling the option has
to turn a working fetch into a failing one. Verified against an unpatched
build, where exactly the two assertions that depend on the new option fail
and the three controls still pass, and against OpenSSL, GnuTLS and
mbedTLS-linked builds of libcurl.

Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
---
 Documentation/config/http.adoc  | 17 +++++++
 http.c                          | 21 +++++++++
 t/t5567-http-verify-status.sh   | 72 +++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100755 t/t5567-http-verify-status.sh

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..40b849bf7f 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -196,6 +196,23 @@ http.sslVerify::
 	over HTTPS. Defaults to true. Can be overridden by the
 	`GIT_SSL_NO_VERIFY` environment variable.
 
+http.sslVerifyStatus::
+	Whether to check the revocation status of the server
+	certificate using the stapled OCSP response supplied during
+	the TLS handshake ("OCSP stapling"). Defaults to false.
++
+This is fail-closed: if the server staples no response, verification
+fails. Set it per remote, e.g.
+`http.https://example.com/.sslVerifyStatus`, rather than globally.
++
+What it changes depends on the TLS backend libcurl was built against.
+An OpenSSL-linked build ignores a stapled response unless this is set.
+A GnuTLS-linked build consults the staple during ordinary certificate
+verification, so it already rejects a revoked certificate under
+`http.sslVerify` alone, and setting this to `false` does not disable
+that. Where a backend cannot check the staple at all, git fails with an
+error rather than continuing unchecked.
+
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
diff --git a/http.c b/http.c
index 5f0f42fb18..c1a66988e7 100644
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
@@ -1131,6 +1136,22 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
 	}
 
+	/*
+	 * Ask the TLS backend to check the certificate's revocation
+	 * status via the stapled OCSP response. libcurl defaults this
+	 * off, and no backend except GnuTLS consults the staple on its
+	 * own, so without this git will happily accept a certificate
+	 * whose own staple says it has been revoked.
+	 *
+	 * Off by default because it is fail-closed: a server that
+	 * staples nothing fails verification outright, so enabling it
+	 * globally would break every remote that does not staple.
+	 */
+	if (curl_ssl_verify_status &&
+	    curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L) != CURLE_OK)
+		die(_("http.sslVerifyStatus is set, but the TLS backend of "
+		      "this libcurl cannot verify certificate status"));
+
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
diff --git a/t/t5567-http-verify-status.sh b/t/t5567-http-verify-status.sh
new file mode 100755
index 0000000000..c9167a05c2
--- /dev/null
+++ b/t/t5567-http-verify-status.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='http.sslVerifyStatus'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+LIB_HTTPD_SSL=t
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+# The test server staples no OCSP response, and that is what makes this
+# testable without standing up a CA and a responder: http.sslVerifyStatus is
+# fail-closed, so turning it on has to turn a working fetch into a failing one.
+#
+# lib-httpd.sh exports GIT_SSL_NO_VERIFY for its self-signed certificate. In
+# libcurl the status check is independent of peer verification, so it still
+# applies here.
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create http-accessible bare repository' '
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public main:main
+'
+
+# A TLS backend that cannot check the staple makes curl_easy_setopt() fail,
+# which http.c reports with a distinct message. Skip in that case rather than
+# reporting a failure that really means "this libcurl was built differently".
+# Any other failure leaves the prerequisite satisfied on purpose, so a broken
+# server makes the tests below fail loudly instead of silently vanishing.
+test_lazy_prereq SSL_VERIFYSTATUS '
+	git -c http.sslVerifyStatus=true \
+		ls-remote "$HTTPD_URL/smart/repo.git" 2>err
+	! grep "cannot verify certificate status" err
+'
+
+test_expect_success 'ls-remote succeeds with http.sslVerifyStatus unset' '
+	git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
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
+test_expect_success SSL_VERIFYSTATUS 'per-URL configuration applies to a matching URL' '
+	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git"
+'
+
+test_expect_success SSL_VERIFYSTATUS 'per-URL configuration is not applied to other URLs' '
+	git -c "http.https://example.com/.sslVerifyStatus=true" \
+		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
+	test_line_count -gt 0 actual
+'
+
+test_done
-- 
2.55.0


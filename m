Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF833B9D9A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479592; cv=none; b=FM1lOSNUWxEiolAkgCP8G+gsc9/mRHLWvIap3E79uXwo1hH+Q4/Xq6WmdsnUlh2VAfIKpknn53gYGWzu1OTXsI1gYJR+ztE1LNTFBGMBUFU7OFy0UyAJ6DxZQVFBOnZuvW2FQ2MdfCCCIwOqlLLYM06HzHTIbeAjNvpzhNbAdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479592; c=relaxed/simple;
	bh=XFTg39389gYjl4DlYjrE6Fh95Gp/ZuhV6U1JCuP5HtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SrRpHfx8volm1Skg0iQIx2VWkV13lwE01s00zERBPu2x3pUCF3YQ/PsczJXMEnn6+XzXJNz0JAv7BFumuZCyhLsJjRBs6h9EBwL2qEnw9rHb4W5Erj47Jg2+agJC7sClR7/3I9q1lci/Y8OGWuElqrjFxsf3Gh0Z8qdaGjErBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeCSPcFP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeCSPcFP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb3865ea6fso203748a34.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479590; x=1784084390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUabWVce8iHwnQPOo1Z1PgqpL5/OZl5hPyo2Jb0poJI=;
        b=DeCSPcFPNdKmikTAAdIad+mDocy0MEEFCUv4IPVmp5+uMPa+kwqfmGbOY68Li+DSug
         672qiYCKapqA8R7u5W1YTgK82T2gXFv5E0H8nH5HU1gChgheEJBlI2ZCO9I9HOLm9y5U
         48xK4c9ShX/EpnyfFAVH9k9DNZZKZ9h6ge7ikDL+Q5Zc8XCoSXMYXXYxfFEQxJPHE/Gr
         pLTZjvsq+j98Y3FClnGYSxzjuoGGZFFEOuYDTAuYxPhZMW9WWNrwHahKzpWxH3+QE17X
         SnpvdG/eVaMBiOqJbWVgYajBuIJ5TgpKcUh5QFw4ZHv+7UmzLRKkgo8OzAbKroMyD4ca
         AEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479590; x=1784084390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUabWVce8iHwnQPOo1Z1PgqpL5/OZl5hPyo2Jb0poJI=;
        b=YQkVHEBdRi4aMPZQCQvN4FrNm+zybAZP9B9E+b2OJuSFffYT751HsruBvYb+ojSOEh
         W0UFfaGtLojPJi+DZ3IyrWnZsNCHPxYObragSEuluiWLAKUtT9qTLQRBxhRBgK3nNi1e
         /yvFrsEF+ad6Q3T7YYy0Ihlx7SpeuNQrwbqIHfjT/r6HHB4rJDjMm3fwHDSbMfoPLvXO
         7aofeypzkVs7ADxzrVuxNr9tk800svV+t8yFy1KRflwmJngAGNlcv9JXJ7EYi8YQ2uoU
         kdJSKuwMFqNl85qHsvY+/vOZfrNLxkJKioARgAa8gDCGjBp8nJ3+W54xY85FPXCuQeQL
         pyPQ==
X-Gm-Message-State: AOJu0YzUM3ZGnhqG9gcZKpVc5wN+SfH02x09W1yc+ymUya3jwum3rmBT
	ckZ+Wn/oPj195TjOdMac8onF6MkJzAgMK62Bcn7dYIWOrzcTR0nzz7gKAFQf+LST
X-Gm-Gg: AfdE7cn/kJPpldra38obvX4kaGIEh+gSyCgjwwshAfrk3H/d2OcIn8FkCG1OVMcWPLo
	SmAEUlF/XVdTBRTCfRcoLwbFynQyIKUWGvQ9+KGxdfS9S8Dunv6yK1T3uO8NfVQpgXcUqECo5Ju
	gaInqDdkK8az4bGGOX9ytAWzipAphhu9hZeXao/WW2w56wmmZq6HKQnndu9FId8U74m2jJUQB6z
	RWbsu7/7O0gbqS9kHLGcuUja+qrFFMZJpZ7RvO1QheP2GjfGHpDd3bmozwwBRl3EV5C1djS7LrV
	T+qdtdB6SQVF0c2lFgiUctsMwwMgXYh4oSaVpcYDjo+MO7BFiVq9dnsrKF7jyYyrNWFOlTvhsv5
	ksWMwUM95LBGEOMXKy9sE1cjlh5zgsuVoWosVnBXI0hP+WdXiDSSAQvQK+iNC0JSJahUegYt3yT
	3IlSOnJqV0T90M6VR4fA==
X-Received: by 2002:a05:6830:4105:b0:7dd:9b19:a875 with SMTP id 46e09a7af769-7ebcfe42702mr420566a34.2.1783479589828;
        Tue, 07 Jul 2026 19:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.102.208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc241sm877852a34.20.2026.07.07.19.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:59:49 -0700 (PDT)
Message-Id: <771d264d2999a780e0c93e64bb4451a05214ab75.1783479584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 02:59:43 +0000
Subject: [PATCH 3/3] t/README: document writing concurrency-safe helpers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The apply-one-time-script.sh and http-429.sh fixes addressed the same
underlying problem: a test helper assuming it has exclusive access to a
file when the web server can run it for several requests at once. The
atomic idioms that avoid this are not specific to CGI or to HTTP, so
document them generally, alongside the other guidance for writing tests,
and leave a pointer from the lib-httpd helper list rather than a local
comment. The note covers the anti-pattern (a "test -f" then a separate
act) and the two safe operations (mkdir to elect a winner, rename to
consume a one-shot marker), citing Git's own lockfile machinery and
make_symlink() as precedent.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/README       | 32 ++++++++++++++++++++++++++++++++
 t/lib-httpd.sh |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/t/README b/t/README
index 085921be4b..a9d425f392 100644
--- a/t/README
+++ b/t/README
@@ -854,6 +854,38 @@ from the test harness library.  At the end of the script, call
 'test_done'.
 
 
+Writing concurrency-safe helpers
+--------------------------------
+
+Some test code runs concurrently: a test may background work with '&',
+and the helper scripts installed for the web server (in t/lib-httpd) are
+run once per request, so the same script can execute for several
+requests at once.  Such code cannot assume it has exclusive access to a
+file.
+
+When exactly one of several concurrent processes needs to "win" a
+decision, a single atomic filesystem operation can make it, rather than
+a check followed by a separate action.  A "test -f X" then "touch X"
+(or "rm X") races: two processes can both pass the check before either
+acts.  Two atomic operations avoid this:
+
+ - "mkdir dir", which fails if the directory already exists, so that
+   exactly one caller wins, electing a first or only request (see
+   t/lib-httpd/http-429.sh).
+
+ - "mv src dst" (rename), which fails if the source is gone, so that
+   exactly one caller consumes it, claiming a planted one-shot marker
+   (see t/lib-httpd/apply-one-time-script.sh).
+
+A "$$" suffix on per-request scratch files keeps concurrent invocations
+from clobbering each other's fixed-name files.
+
+This is a standard shell locking idiom, and the same reasoning behind
+Git's own lockfile machinery, which creates its lock with O_CREAT|O_EXCL,
+and make_symlink() in t/test-lib.sh, which uses an mkdir lock: an atomic
+operation whose failure indicates that another process got there first.
+
+
 Test harness library
 --------------------
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fc646447d5..d64f9c8c2d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -159,6 +159,9 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
+	# The web server can run any of these CGI scripts for two requests at
+	# once; a helper that keeps state between requests must do so with an
+	# atomic operation. See "Writing concurrency-safe helpers" in t/README.
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
-- 
gitgitgadget

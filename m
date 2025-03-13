Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35116BE17
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862361; cv=none; b=KdeEVJ7jzbFg+GbL8S8u7t2nqfwrcRFbJOCHWp35QSvhzN5QNMPUMOPa9C/4o2x2K/fpD2OnGQZ6h3u2LQcFBFUKNNmSLY6KoL6qhKR9nHnMn3Fb4rFeXhZGmkqax+8XG3kAS4F1IyruxKKPuA+DAu0jI+xyfzGtk7No/kZy1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862361; c=relaxed/simple;
	bh=X5v50eOJfbvI++Hh2mF2SkoZ+Cs2tY1aNwcZH0/bpxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjJwKlnZB6e9Xpsnw0rpfF8IYMQ6V8muPFmWsjHHBSUbYHM7ozwXmB8npPWxddxXxBaHqoPDP17Ll1cxsXUttMIZoYz/7mQ5pEQjgWpR6Xu0NI6KzMtF6PE3HoK1ur5S9zydYKt2SvHnR/dRe1VegU1BLoSxzy0ad2hxj1fXMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIztKwBc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIztKwBc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390fdaf2897so672366f8f.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862357; x=1742467157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWjBR91yJiWc0W0FMczNyaxN3Z1J3mYuzUjzU0VlCD4=;
        b=nIztKwBcgIj/nWhYekSP1Lil52v0OCeBYubq6U3cFYO1GulRKOe54mg74QT0CH+mz8
         WewkbZYeCukG0gTNMd1trybFgape8dwJbf3zXe5rL8S5XGVQtetdGIXgXFR1AqM3wCU0
         oNfGh1vbxdC5ZcvRXSoabCvKx0vGiQ62IWVnO31KF9hFSEWSrAET8uk26cposUARml5I
         4ENogzmaMegZkgNr/OtPi8448EoAnBSc2ZNXHYdYkVXH7Su1ygpO2361YWqdgBzxRwYc
         VBL3mjZ8bSKuxk2NqipjToKd2Msen/gGlkGXmDC579tuIFvwWGmvaZbwLfaUnDiGfMvA
         TYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862357; x=1742467157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWjBR91yJiWc0W0FMczNyaxN3Z1J3mYuzUjzU0VlCD4=;
        b=cnoBRm+yFVdZ0hibJ9UY7fw14GjY94xBdViW0jzIkjJfU8/ASHONLaqj9uViH1audr
         VvQixfonNR2vHmGFXztdjtm64jvSZ4rBYZqD1h/nME9ajHtUoWNG0ubUuhBoCmpKBIE7
         s4XhfZMS7F5T/tFuSF8hpaApi/KXCPenUf0VoyIH/FLSR7rouogeMAKgVSifGCIc8l88
         0r74yott0Y3jBUP6Y7poZRBz16xjJ7MAP/ufPJnyb4VWSKeZEFbVR6sGX1asA+8rRQji
         SZ3wwAXpSi46Yo0bDjdWie/v1u1EKH85uvdsOLzB5QN9jJvABICwDmmvMZKrPkeIVLKW
         oa3w==
X-Gm-Message-State: AOJu0Yyx/ukvzz8SpxEqMQWG0nBDLEK8urVt76dB1N3degYTZyDs9qZG
	MtUp5fa5lxYyZO434+9aA+pR9f++s+SaHeLpmdaIs5KD3mwwkrFb3HMgAg==
X-Gm-Gg: ASbGncsuhLiYfzWHZZvuMGnwnmALB5D9fw2zQMAVwElGPe71QBEWiC92g9I8Qy9rWN8
	44L/XCEBk5/EkRRRtdbdBNf5GCZmLhcyGlVZD9TrJVvM8EurEFD01ZQWuhUcI9RKpurzvqWC78T
	rEb8DciniEO1gEshD9WrpoEU6Hib2QqGnenn3LY9/b3KbQjQ/T+teLPGqn8hZfwo6h3V5ZZga1S
	7snezVe3UgCdtuGynrvOyQYkIK+OPIGgdl7MAn6nFGUP5IVnhbM0taoOtgmel6z3nX184hzOc/P
	TfibdEjLnHNMo5oTOj/cjZjilTl9hFjO66rlrswFwjpxsmEWaHYsWvBQMfUKWJH4pPxRMk3SaV8
	ZXaq5YlTUZdtep7SgUS/dFw2VFe8=
X-Google-Smtp-Source: AGHT+IF62Eckl8Gmm6/BT64bO5qcZOaJD9bkRhg2AKInyDE0u9Tkj6fWas01YkdKvCjh2cZM1xF/vQ==
X-Received: by 2002:a5d:6d0f:0:b0:390:e46f:4454 with SMTP id ffacd0b85a97d-39132d72c52mr22058801f8f.32.1741862356433;
        Thu, 13 Mar 2025 03:39:16 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb93csm1627313f8f.86.2025.03.13.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:39:15 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4] promisor-remote: fix segfault when remote URL is missing
Date: Thu, 13 Mar 2025 11:38:59 +0100
Message-ID: <20250313103859.817127-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.1.gf94452eaa2
In-Reply-To: <20250312114628.2744747-1-christian.couder@gmail.com>
References: <20250312114628.2744747-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strvec_push() to push `NULL` into a 'strvec' results in a
segfault, because `xstrdup(NULL)` crashes.

So when an URL is missing from the config, let's push the remote name
instead of `NULL` into the 'strvec' that stores URLs. This is
similar to what other Git commands do. For example `git fetch` uses
the remote name to fetch if no url has been configured. Similarly
`git remote get-url` reports the remote name if no url has been
configured.

We leave improving the strvec API and/or xstrdup() for a future
separate effort.

Note that an empty URL can still be configured using something like
`git remote add foo ""`.

While at it, let's warn and reject the remote, in the 'KnownUrl' case,
when no URL or an empty URL is advertised by the server, or when an
empty URL is configured on the client for a remote name advertised by
the server and configured on the client. This is on par with a warning
already emitted when URLs are different in the same case.

Let's also warn if the remote is rejected because name and url are the
same, as it could mean the url has not been configured.

While at it, let's also use git_config_get_string_tmp() instead of
git_config_get_string() to simplify memory management.

Also let's spell "URL" with uppercase letters in all the warnings.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Only 2 small changes since v3:

  - a sentence in a code comment has been removed,
  - a strcmp() has been replaced with strcasecmp()

Range diff since v3:

1:  ea3c8347de ! 1:  f94452eaa2 promisor-remote: fix segfault when remote URL is missing
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
     -          free(url);
     +          /*
    -+           * No URL defaults to the name of the remote, like
    -+           * elsewhere in Git (e.g. `git fetch` or `git remote
    -+           * get-url`). It's still possible that an empty URL is
    -+           * configured.
    ++           * No URL defaults to the name of the remote, like elsewhere
    ++           * in Git (e.g. `git fetch` or `git remote get-url`).
     +           */
     +          strvec_push(urls, git_config_get_string_tmp(url_key, &url) ? r->name : url);
     +
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +  warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
                remote_name, urls->v[i], remote_url);
      
    -+  if (!strcmp(remote_name, urls->v[i]))
    ++  if (!strcasecmp(remote_name, urls->v[i]))
     +          warning(_("remote name and URL are the same '%s', "
     +                    "maybe the URL is not configured locally"),
     +                  remote_name);

 promisor-remote.c                     | 44 +++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 59 +++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..dd589dd4ea 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -323,13 +323,17 @@ static void promisor_info_vecs(struct repository *repo,
 	promisor_remote_init(repo);
 
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		char *url;
+		const char *url;
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
 		strvec_push(names, r->name);
-		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
 
-		free(url);
+		/*
+		 * No URL defaults to the name of the remote, like elsewhere
+		 * in Git (e.g. `git fetch` or `git remote get-url`).
+		 */
+		strvec_push(urls, git_config_get_string_tmp(url_key, &url) ? r->name : url);
+
 		free(url_key);
 	}
 }
@@ -356,7 +360,7 @@ char *promisor_remote_info(struct repository *repo)
 			strbuf_addch(&sb, ';');
 		strbuf_addstr(&sb, "name=");
 		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		if (urls.v[i]) {
+		if (*urls.v[i]) {
 			strbuf_addstr(&sb, ",url=");
 			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
 		}
@@ -409,12 +413,42 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
+	if (!remote_url) {
+		warning(_("no URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
+	if (!*remote_url) {
+		/*
+		 * This shouldn't happen with a Git server, but not
+		 * sure how other servers will be implemented in the
+		 * future.
+		 */
+		warning(_("empty URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
+	if (!*urls->v[i]) {
+		warning(_("empty URL configured for remote '%s'"), remote_name);
+		return 0;
+	}
+
 	if (!strcmp(urls->v[i], remote_url))
 		return 1;
 
-	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, urls->v[i], remote_url);
 
+	if (!strcasecmp(remote_name, urls->v[i]))
+		warning(_("remote name and URL are the same '%s', "
+			  "maybe the URL is not configured locally"),
+			remote_name);
+
+	if (!strcmp(remote_name, remote_url))
+		warning(_("remote name and URL are the same '%s', "
+			  "maybe the URL is not configured on the remote side"),
+			remote_name);
+
 	return 0;
 }
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e..05ae96d1f7 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -193,6 +193,25 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownName' and missing URL in the config" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	# Lazy fetching by the client from the LOP will fail because of the
+	# missing URL in the client config, so the server will have to lazy
+	# fetch from the LOP.
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	git -C server config promisor.advertise true &&
 
@@ -228,6 +247,46 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownUrl' and url not configured on the server" '
+	git -C server config promisor.advertise true &&
+
+	git -C server config unset remote.lop.url &&
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+
+	# Clone from server to create a client
+	# It should fail because the client will reject the LOP as URLs are
+	# different, and the server cannot lazy fetch as the LOP URL is
+	# missing, so the remote name will be used instead which will fail.
+	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
+	git -C server config promisor.advertise true &&
+
+	git -C server config set remote.lop.url "" &&
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+
+	# Clone from server to create a client
+	# It should fail because the client will reject the LOP as an empty URL is
+	# not advertised, and the server cannot lazy fetch as the LOP URL is empty,
+	# so the remote name will be used instead which will fail.
+	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.49.0.rc2.1.gf94452eaa2


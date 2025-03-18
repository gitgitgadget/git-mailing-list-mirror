Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCCEAC6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295631; cv=none; b=WrSasdTwIhMWEnnciDkAYGaXpgkhAhgsRolAdbWMPKxnm3pyyEvnKXVM/CNOW0QbQrYEklRCgpVUpwAALbsZEH2HW55n12+6GrseJH5vetY5NtVAU3yFHtL6DJv5O8o63s3XLUbAFQ0/nGx4yHY+zXzF59RblL7MstqrDvMN7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295631; c=relaxed/simple;
	bh=EAX6+DuVWHToFCdolzIoY3DnJYQYHJk18th3Vo95Y1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyHlJVoBQ/Ca4ofm6rWp8S8sgUbk4hUUI+R7Wgokq5HovXfLomNcqByHfJYNY2hqya0HtTJT23r90R5oFU2e8ldcyrYs4ZlNBzqWYPZNxi6IchAONhayGIRQkQ8qrNRxIO8ufN5R5lGVRyGMunvf/wPmHFCoWGe5Mdmgt64wXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsczTnzK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsczTnzK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso20513025e9.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295627; x=1742900427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tos7JzDZZvIK2pnE0wchPyv5vHFBNmawEW7wUXu8gs4=;
        b=bsczTnzK7gH/tKzxTEeXv+JyEWYoEj5rv2oJ4kUOsCpeJpI+coyipTpjUDfsU363Ne
         g+1FyGDvSC50CD8YENS+VALAHj2LH2Pu7j8PrwnE2iRt17JPIDvAGcHmLgAeC2FA+Qw2
         ag3WvHAKTgwCQCXDmzsKgMWQCo7Lm6NjKwKi6aHenAZFKW2Lg8wY9i38YkDpjAClwiIg
         FohzAT7It7A2zCQi9oIgOwqvoIfBs6hdz4e1iqeMXtTx3z1vHBqJYrgqGbvWt/xovNAm
         FYTRxNr2dXTWHgBbXccxGpxXcmPkLZcsHCMeP5nKcng5jkOhYwq9QaujEXjtiKNVF32N
         4FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295627; x=1742900427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tos7JzDZZvIK2pnE0wchPyv5vHFBNmawEW7wUXu8gs4=;
        b=rKA5ZurLulfiF8++iYwdG4uylrILVSYrzqIo4ZQvP/z/enig57ck+mgbGz/no70vHM
         tJwATtD+Gtut4Qk28YcZwY3HTJfyFvm3zdFdfB8g9MrYzPGz+r07tZG3+jUMjs/28716
         Cws0IvtP4z9fGFAd254lsJsFBcy8N24xRacnyNCFmgCPywZbV2QLYaa+qHQXeZzEylTG
         A1KGgTAEzJMho6tr+WNH8JllY5zObdd6EPEYxROW8NnQWNTqFD/XMVKpAHdwSOu3dbnT
         CK4lqNMmTeY0zvg7rgkvKBS+vicGzMLTWkcqEitn4fVA+Onysd7osEdXKn2Yv8PmMzMh
         YIcw==
X-Gm-Message-State: AOJu0Yx9sCN06wVSdIFjijtBHQA1v9IlxbMUi9ARmCzGBSDB55/Q4oxV
	Pk3rdfQuqssfFPKoCMrfVKV1qjcC7Q0kOdrVLpccweqtKAtqKHZiB7T4zg==
X-Gm-Gg: ASbGnctehTISpbDUQz7ukusnm0i//R2eigSHMSTsyfoM9ujB8/Pia7bzNdPGDPktVYj
	65X0sc8l0M736XfmNy9Z11vGwNyvffjoeNs2EzM1i8qt6RnTBAiIl+poLtaCKvjki5+OwTqvAWD
	jCHC5rjK97oOEypy6dSHDexx1nnjXvW4HwGhYoJbMNKFRC36CAs2l7SuV3eUaAKFIjIxN9a0Tpg
	/Cz5v2Y6JFPS5U4GPE/U1QgIx9PDlrocr2seUP5iqCVkJv2FmNj3den0txq8cssLdKPFrHXiM39
	FGx2oCJhmaFCW/osDurSVEgU0HWXMp/st8QLs1p7JfAL+kLePd7IHRqO2mGUZiXk5yYxpLNDxdn
	8Ig==
X-Google-Smtp-Source: AGHT+IFNXJ67O2QM8Q0D3eFRx5vSA+pZH4t9AjR4s0IcYRZPlmVPnETjn6xiRmrjfWGEPiF5u0nxBw==
X-Received: by 2002:a05:600c:a582:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43d3ba0f49amr14315065e9.15.1742295627077;
        Tue, 18 Mar 2025 04:00:27 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:f066:6e28:cef1:9d6a:ca5b:64d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm131169515e9.26.2025.03.18.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:00:25 -0700 (PDT)
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
Subject: [PATCH v6 2/4] promisor-remote: fix segfault when remote URL is missing
Date: Tue, 18 Mar 2025 12:00:06 +0100
Message-ID: <20250318110008.656695-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.4.g81387f61c3
In-Reply-To: <20250318110008.656695-1-christian.couder@gmail.com>
References: <20250314141203.2548803-1-christian.couder@gmail.com>
 <20250318110008.656695-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strvec_push() to push `NULL` into a 'strvec' results in a
segfault, because `xstrdup(NULL)` crashes.

So when an URL is missing from the config, let's not push the remote
name and URL into the 'strvec's.

While at it, let's also not push them in case the URL is empty. It's
just not worth the trouble and it's consistent with how Git otherwise
treats missing and empty URLs in the same way.

Note that in case of missing or empty URL, Git uses the remote name to
fetch, which can work if the remote is on the same filesystem. So
configurations where the client, server and remote are all on the same
filesystem may need URLs to be configured even if they are the same as
the remote names. But this is a rare case, and the work around is easy
enough.

We leave improving the strvec API and/or xstrdup() for a future
separate effort.

While at it, let's also use git_config_get_string_tmp() instead of
git_config_get_string() to simplify memory management.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c                     | 16 +++----
 t/t5710-promisor-remote-capability.sh | 61 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6a0a61382f..ba80240f12 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -323,13 +323,15 @@ static void promisor_info_vecs(struct repository *repo,
 	promisor_remote_init(repo);
 
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		char *url;
+		const char *url;
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
-		strvec_push(names, r->name);
-		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
+		/* Only add remotes with a non empty URL */
+		if (!git_config_get_string_tmp(url_key, &url) && *url) {
+			strvec_push(names, r->name);
+			strvec_push(urls, url);
+		}
 
-		free(url);
 		free(url_key);
 	}
 }
@@ -356,10 +358,8 @@ char *promisor_remote_info(struct repository *repo)
 			strbuf_addch(&sb, ';');
 		strbuf_addstr(&sb, "name=");
 		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		if (urls.v[i]) {
-			strbuf_addstr(&sb, ",url=");
-			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
-		}
+		strbuf_addstr(&sb, ",url=");
+		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
 	}
 
 	strvec_clear(&names);
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index e26a97f588..b35b774235 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -193,6 +193,25 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownName' and missing URL in the config" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# Clone from server to create a client
+	# Lazy fetching by the client from the LOP will fail because of the
+	# missing URL in the client config, so the server will have to lazy
+	# fetch from the LOP.
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
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
 	test_when_finished "rm -rf client" &&
@@ -228,6 +247,48 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with 'KnownUrl' and url not configured on the server" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	git -C server config unset remote.lop.url &&
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
+	test_when_finished "rm -rf client" &&
+
+	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	git -C server config set remote.lop.url "" &&
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
2.49.0.1.g12e6251c65


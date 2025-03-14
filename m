Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF542747B
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961539; cv=none; b=ere1XoHEHyndJmti+XZ5ylh2MrUF1gHXZhmvtcdu1x8NneeSmffGfkjVi35HWOG6isyiVlvCaWIQ1L2uEMDYTKddoVe85XMOCoe3jL8AKDqcE4mSMiAMw4nsfAC1RRei88TqhsJcCl9mjco1mRomtprHReGIUz2XcLmX+kbgals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961539; c=relaxed/simple;
	bh=QkSyPBkHkjJB+4Kv2c+wDkH//HIR9ppU/ox6QPxK/oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+N3lmMPvNHns7jJL9p8w89BS8QpAHgMYSkfD3PWKT16b+CvPJmY8JHpvJgEvqCu79HRIREdOfkpDqrCA0RL6k4BONUmhk5RS61n/TgOKDfEYRyb7oGHxGohDWKHSzKzXfJrgxUXyOlqm/Titfs6TVsgcZsttuDIgLJOwjKxP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUFR1eTS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUFR1eTS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf848528aso20471395e9.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961534; x=1742566334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buxXoi39BsewLOH6ecsBMyOTREdrfvKHNvSiCqSJFME=;
        b=OUFR1eTSOdindnZd+6dKREKRwDP6d1b+Y8sCTAMGp5vZXkMk8BDjL7GqvBYvEA0Tez
         rhIGaHMvLDTmCKPMwtTJd9Gm7vyNn8Mv2HzgszzysIZVHyX46AhrP+6aJJ50lB83bnOX
         ZATWrahe85uCn0W4E+VWEhK44SnzooLsFNLQ4MjQu4HD8zmrJ0dNE/XSG3aGZ5pkewH+
         +KShV1OIV58Wd1SX/+Hfd3yRdhQntzRzK1WkAOw9rd+rhLn0t5G+uXY+1BjwU0/GHLzT
         MUIIO9HAOEr4ac9CnTPTebJduNNNmn4T82gakZTx5WLm2GO3aHd/dlCZuWQ6jJlNNt5/
         lzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961534; x=1742566334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buxXoi39BsewLOH6ecsBMyOTREdrfvKHNvSiCqSJFME=;
        b=c1qCKzPIqjP+G/250LLQxH04HuIP/G5XG+5wfOvOjYCj7FvDe9KZEn8pRvAFab8IFV
         kluTsH0Vd745XLzhmNwu7nwhr+v7Hi7zHrjIXsojhaxLmF2/S6O7S5Vzd7MCZ4I5BYui
         U3s8n1bvh9ndEaTwrVNaEbM1t7RwKd2kOm7urRhFTIW2VynB+NIWti49nZuwBXBfh4VB
         UWazSpZounx3Kweh0IiR4dC1dVZ58L9MthZROdm92ayBQcuPm/RV9Q8LSAvElCJkEgbg
         3q0wPMqagZyrhiYc/E8MSDCRyc4vdSnC7pr2jldFdSv79dSPAjutM4imlMkIQgqatRjK
         Xu0g==
X-Gm-Message-State: AOJu0YyQc2ar7F/j8qpPBRjCVqDBTEGgwk4vWr3BJILz2ilT0HnRNn0L
	7JA7sUNT46p9ON9DOgGZpPHqJhGcUtlbvSyHHn/Fksdza15KoRKwVWsHOw==
X-Gm-Gg: ASbGnctJIkOmUVdrpdD0MM5IPfBMlIUThk3e7EuHI2SaKHIU2gsfzSAbHyYvghE/Yg7
	5j3GjgBqGyt4e5MWu3bXwDwcur4GLMH+raWUGjFDFIYhtWMQAkDek/o/O8I5ANbIR3HBkpL0iuA
	l3AYndrrns4w5xXIHqzK5XyxsX32f0RCykU0AYUbY/Y/k1CAstqVxjyLerKWeStmUFZwUs+hXN+
	agaxY9CmFqWxVd42JQo+RkgYfEWdRK6nmHsDkw8ReRs1bR3EeDS0a0tFrECj5gaWDz3xQKd7Tf6
	gih6spnuSJ+inCotihyJ7gidtuPXQCyfsQUpndLI9vcmhWU+RXYt8BZluF26z52b69k3Sv+mBdC
	mqpWg0e7sh7JzgyZnXf4mQYhENpk=
X-Google-Smtp-Source: AGHT+IGF+sQKrum0Xeo+aqiIDY1892W8NyR3ZY+N/V7/dQM7cv800eNnv3cNBeiAPeANZ2QbJ3NFUQ==
X-Received: by 2002:a05:600c:1c20:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-43d1ec72879mr25968045e9.1.1741961534228;
        Fri, 14 Mar 2025 07:12:14 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe3a8cdsm8418255e9.2.2025.03.14.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:12:13 -0700 (PDT)
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
Subject: [PATCH v5 1/3] promisor-remote: fix segfault when remote URL is missing
Date: Fri, 14 Mar 2025 15:12:01 +0100
Message-ID: <20250314141203.2548803-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.36.ga8a9f9b33b
In-Reply-To: <20250314141203.2548803-1-christian.couder@gmail.com>
References: <20250313103859.817127-1-christian.couder@gmail.com>
 <20250314141203.2548803-1-christian.couder@gmail.com>
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
 promisor-remote.c                     | 16 ++++----
 t/t5710-promisor-remote-capability.sh | 59 +++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 8 deletions(-)

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


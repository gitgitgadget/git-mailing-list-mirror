Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D881459EA
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991051; cv=none; b=j+ZAK5/TTdsYvpLpFe/OQQAnFw8MxpUkjP8Ttj49berQxfxIa35vxwzgZIXgIx5mwHUipi796tXLONL70L3UAbtDT2UTHUoATn+BF6Y0IFV1wjL3yUscdjQLierjIQQwhb2yW0o7NdFSLfhbwNjeYj7O7Wb96wk9nVjpbqLkip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991051; c=relaxed/simple;
	bh=dj2oEgUMG2lP9jMVk/EfH54lsLwGcUAQAKHHBzCXREU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bifDqwq+txQZ6OnfK1Q6yFE7gwWthfE/kcHql6Z2jAKPANg1ARTWOxD/ydk8RYgf/GcLQpz2sojnvWHR9mqObnf/GQnkXhUGy9YRMb84J5NiKgPa4wW+GXROi3l5utWIOApRmFqoyRA8hvWRNZP30prwaYOSXz/eudiSvqC0WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu16YvgS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu16YvgS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so47244815e9.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991047; x=1738595847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDoofHypGY3q8bd/ONnVbh6cbpMmsUFTgNRLsWIgo9Q=;
        b=Xu16YvgSSfiv+Ic0UgICTRmHc5p5Ao/ckVXm9yeG/2fH1EwZLlmYvXM3yRMBwVkZ2S
         zdZViZV3gctXRdicxh06afU9ymXL9H4oPh181O/kIhDIbkyczpjeBmQrmReNFDusucNl
         vnbr4l4uAYTT21T4e/6aTMqYYkcciCevX6ecLs3nhaXapD6dHxfhPa3R8GvlKmOItc4s
         vqc2E/TZQ1pUoSoLuhUnCF23Nf8Zxdpz7riqzbKFU6Ug0ONVXsgCxhBqyWOu3e8frt8n
         XbvbZHtVJ7Lctl6j5iA5E/SGn5tzJ0iEIIN6n+3ahEmTrEth6Fwpj7iHn3EKgpkCwe6u
         Co1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991047; x=1738595847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDoofHypGY3q8bd/ONnVbh6cbpMmsUFTgNRLsWIgo9Q=;
        b=SfJTY4aVwQWZzWFGZLyrNFAh0u1lpdQML+xlkpsilanp10WrzAdr9nUjCX+7s26ea/
         HFfwJI57TdfzMyuVpO1VK70As1hcLqpJosrsE1HlBUdgaEvgu0325/Cjd0LnmAowCOcM
         1B/UK75vFiKxT1PqW8uAE3gGVVQK/Ol5iOQJ7aRpufuytRMEEQEQ+EytsmjiBn9P5ezZ
         vJvwmWjtJtLy9OPBwmE5uvIXx/0uQK5ARCZqc3mC+N6Qeiz96hdDt2xLtOswwwa3Kgla
         85UrnX/0nrEQRPCozDx1+rZ/Yn9smr1V+HBalNRHCpKsbSp/jUF/LSq/Fyz4ECGuStEy
         y58w==
X-Gm-Message-State: AOJu0YyNXHCIUD0tOTX5f9ayNSAsF9gIt7S1h8cSpZAwSE40alESzzoU
	8p66UjDh7ptBP2Y9rED4ZnV2IAS9d4Sz3nfqmTYa3WsGmPTa30rfGx7uyw==
X-Gm-Gg: ASbGncvPZ7fSPE+VfulU9cm6iPPmyujiyPR/9MtCQ47xs/H8GdDyhrG2G9SurrMOJkM
	tFI+iPxJrwVToUqznXnx609JvhMo8GreBwhD2S7Z+jxknbOuT4aHHd7dTuvAvFXlkb1Q+EnDRKC
	Z5Hywmo2LGO9N1HuBGTotaEKGgzdxyX8XxmLlcenyOUnId1hugSQ/HZv/VEolxWhvUwEJUBKHLl
	vLuq3IgJbANaAs2CEbofZHompOdv8O1FRwwqd/qzlQ6m8o3HafKOLdWDM+I+gS7pTezF0ggPj9O
	YK4FtQbvBkjd5uKdJnE17qq2pxRCGZqZMPQQkqBrKCEIt6WWeaoBtSNhPw/cw0A=
X-Google-Smtp-Source: AGHT+IFYm0weIRkmA/59z1gw0XOnF8s9g76EKMXz548hABp06z6uztRoIU+M01PRqjE5jPxL69AWWg==
X-Received: by 2002:a05:600c:4510:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-4389144f671mr348881925e9.27.1737991046848;
        Mon, 27 Jan 2025 07:17:26 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm135269625e9.39.2025.01.27.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:17:26 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/6] promisor-remote: check advertised name or URL
Date: Mon, 27 Jan 2025 16:17:00 +0100
Message-ID: <20250127151701.2321341-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.95.gcbf174a634
In-Reply-To: <20250127151701.2321341-1-christian.couder@gmail.com>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit introduced a "promisor.acceptFromServer" configuration
variable with only "None" or "All" as valid values.

Let's introduce "KnownName" and "KnownUrl" as valid values for this
configuration option to give more choice to a client about which
promisor remotes it might accept among those that the server advertised.

In case of "KnownName", the client will accept promisor remotes which
are already configured on the client and have the same name as those
advertised by the client. This could be useful in a corporate setup
where servers and clients are trusted to not switch names and URLs, but
where some kind of control is still useful.

In case of "KnownUrl", the client will accept promisor remotes which
have both the same name and the same URL configured on the client as the
name and URL advertised by the server. This is the most secure option,
so it should be used if possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.txt     | 22 ++++++---
 promisor-remote.c                     | 60 ++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 68 +++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
index 9cbfe3e59e..d1364bc018 100644
--- a/Documentation/config/promisor.txt
+++ b/Documentation/config/promisor.txt
@@ -12,9 +12,19 @@ promisor.advertise::
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
-	capability. Default is "none", which means no promisor remote
-	advertised by a server will be accepted. By accepting a
-	promisor remote, the client agrees that the server might omit
-	objects that are lazily fetchable from this promisor remote
-	from its responses to "fetch" and "clone" requests from the
-	client. See linkgit:gitprotocol-v2[5].
+	capability. If set to "knownName" the client will accept
+	promisor remotes which are already configured on the client
+	and have the same name as those advertised by the client. This
+	is not very secure, but could be used in a corporate setup
+	where servers and clients are trusted to not switch name and
+	URLs. If set to "knownUrl", the client will accept promisor
+	remotes which have both the same name and the same URL
+	configured on the client as the name and URL advertised by the
+	server. This is more secure than "all" or "knownUrl", so it
+	should be used if possible instead of those options. Default
+	is "none", which means no promisor remote advertised by a
+	server will be accepted. By accepting a promisor remote, the
+	client agrees that the server might omit objects that are
+	lazily fetchable from this promisor remote from its responses
+	to "fetch" and "clone" requests from the client. See
+	linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 5ac282ed27..790a96aa19 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -370,30 +370,73 @@ char *promisor_remote_info(struct repository *repo)
 	return strbuf_detach(&sb, NULL);
 }
 
+/*
+ * Find first index of 'vec' where there is 'val'. 'val' is compared
+ * case insensively to the strings in 'vec'. If not found 'vec->nr' is
+ * returned.
+ */
+static size_t strvec_find_index(struct strvec *vec, const char *val)
+{
+	for (size_t i = 0; i < vec->nr; i++)
+		if (!strcasecmp(vec->v[i], val))
+			return i;
+	return vec->nr;
+}
+
 enum accept_promisor {
 	ACCEPT_NONE = 0,
+	ACCEPT_KNOWN_URL,
+	ACCEPT_KNOWN_NAME,
 	ACCEPT_ALL
 };
 
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name UNUSED,
-				const char *remote_url UNUSED)
+				const char *remote_name, const char *remote_url,
+				struct strvec *names, struct strvec *urls)
 {
+	size_t i;
+
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+	i = strvec_find_index(names, remote_name);
+
+	if (i >= names->nr)
+		/* We don't know about that remote */
+		return 0;
+
+	if (accept == ACCEPT_KNOWN_NAME)
+		return 1;
+
+	if (accept != ACCEPT_KNOWN_URL)
+		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+
+	if (!strcasecmp(urls->v[i], remote_url))
+		return 1;
+
+	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+		remote_name, urls->v[i], remote_url);
+
+	return 0;
 }
 
-static void filter_promisor_remote(struct strvec *accepted, const char *info)
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
 {
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
+		else if (!strcasecmp("KnownUrl", accept_str))
+			accept = ACCEPT_KNOWN_URL;
+		else if (!strcasecmp("KnownName", accept_str))
+			accept = ACCEPT_KNOWN_NAME;
 		else if (!strcasecmp("All", accept_str))
 			accept = ACCEPT_ALL;
 		else
@@ -404,6 +447,9 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 	if (accept == ACCEPT_NONE)
 		return;
 
+	if (accept != ACCEPT_ALL)
+		promisor_info_vecs(repo, &names, &urls);
+
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -433,7 +479,7 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -441,6 +487,8 @@ static void filter_promisor_remote(struct strvec *accepted, const char *info)
 		free(decoded_url);
 	}
 
+	strvec_clear(&names);
+	strvec_clear(&urls);
 	strbuf_list_free(remotes);
 }
 
@@ -449,7 +497,7 @@ char *promisor_remote_reply(const char *info)
 	struct strvec accepted = STRVEC_INIT;
 	struct strbuf reply = STRBUF_INIT;
 
-	filter_promisor_remote(&accepted, info);
+	filter_promisor_remote(the_repository, &accepted, info);
 
 	if (!accepted.nr)
 		return NULL;
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 0390c1dbad..5bce99f5eb 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -160,6 +160,74 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=KnownName \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownName' and different remote names" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
+		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.serverTwo.url="file://$(pwd)/server2" \
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
+test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/server2" \
+		-c promisor.acceptfromserver=KnownUrl \
+		--no-local --filter="blob:limit=5k" server client &&
+	test_when_finished "rm -rf client" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'KnownUrl' and different remote urls" '
+	ln -s server2 serverTwo &&
+
+	git -C server config promisor.advertise true &&
+
+	# Clone from server to create a client
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
+		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
+		-c remote.server2.url="file://$(pwd)/serverTwo" \
+		-c promisor.acceptfromserver=KnownUrl \
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
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.46.0.rc0.95.gcbf174a634


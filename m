Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372281B372C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433246; cv=none; b=VOgTFX+oHQ/rZTsiMkHuabok6NyTXNy/iPiq98U7ZPX1cn1XYlRgkGWL0N2HUuA2MNvcXYSJt/l0HmseYNJ+UGcBaU/j8syon30p6j7QrqsBDXZVbUUhpJC7ONnaE5HvLLoXsZ+UbEL+Eq++uRbuF2bQa+8jXY/5ka5pUCOXYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433246; c=relaxed/simple;
	bh=IV3LyB3H+qRJhDo6yYig/Uh/ITF+82iHxAK4K7d40es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWTlWPaw2E7MITJ8lFOXexnD+m4+6gqjd4ou82ndp5Nm06wMEiBDuwbSC54vG0Exj2wfsb0ONUO9Na7EP+qETxmCPw8/9q4Dpqwt6uRTdA3GdCM1LOuDL9Bqat6taDA0uFCe8VLCIG7FcPpmPDLeh8LG+zv9jn6Qcwl1NVg072k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iti2xsKE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iti2xsKE"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ad969360so1789610e87.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433242; x=1723038042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ZthYY/Jj9GwL8xZn+HzFCMcpMgA7bNZxBgJ22wksA=;
        b=Iti2xsKEFHE8WR2l7kjKvlviFSSJcacGS6o3IBTkcLiSnSfb9vHMhG2jw7MLeeyS6R
         12+MW3ioYXqEMCIPjBcM6K6m6PWpGaHnz/caPS7Inqvr/fcOrVhEQSjFSaWT0s1s9YGN
         rrkB3UBwivXOHF4+yOplBFsQ2YYiHxwrkJqI6V0bpW4J75aLfNSZRSoYe9bLjf1vBp/i
         NvpKDVo8SFabF4ggyqAFIqvgeZaxceAT94+uzuEqQEJvRejb+BcP6GZYWXtIw6tylWsy
         rVycnH1DQnDEt9cUap8cBktqYkstM8XJSPv1DPMqxdcOTH/sYG3xrwuXye1fzMlHbr+f
         hyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433242; x=1723038042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4ZthYY/Jj9GwL8xZn+HzFCMcpMgA7bNZxBgJ22wksA=;
        b=d9actuLGJvR59W3kTqFYaEaCYOsH6vcW3g9D0qUm3LMZuEgNMCot8LIR5rg9xMtpA0
         RmBP+VOrzATMNUTlJTQzI1jBZ6NXOTVZBMijiNZdiDqcOBkRn6mFv1yHKqtrWYs5NUOL
         HyMfq4hSWy7xkeVN4kIgSLYt7UBXXu325GlNV8JMHQhAwKXUinCnQ5l4hDUfhMohyjbX
         3zJlxh1ZHD+3SFX3En1t66xB01UA3NlXWIrL/N6bNoIwm/rw+PGI/EDx3i4r1BhNg3OB
         fW3HdUTUCE093G8u5zIBBFUK1Sw5GROIFM+ldn3gijm5h6lWHNwFcFyrY+/RVKTCUprv
         Qxhw==
X-Gm-Message-State: AOJu0YwInE0r7BTAyq1jita4Q1Bpi8pnh3VK3sxe/UdI6kxrQTp+HJM7
	cfvSmNxPFnpvO0arrOoxo4z5rZwmI9xvMa1uluf/B3ZAxGGkPGMFdmklmg==
X-Google-Smtp-Source: AGHT+IG8rcLwW6mTVQcJx3ET7HES/xeXT79dqvGZFjf7BksL+zvG0+qmuumQDprqwPQtNDg3Z6rp6A==
X-Received: by 2002:ac2:4d9c:0:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-5309b272327mr8940670e87.23.1722433241164;
        Wed, 31 Jul 2024 06:40:41 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8669641a12.56.2024.07.31.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:40:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] promisor-remote: check advertised name or URL
Date: Wed, 31 Jul 2024 15:40:14 +0200
Message-ID: <20240731134014.2299361-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.gbcb884ee16
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
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
advertised by the client.

In case of "KnownUrl", the client will accept promisor remotes which
have both the same name and the same URL configured on the client as the
name and URL advertised by the server.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.txt     | 11 +++--
 promisor-remote.c                     | 54 +++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 68 +++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
index e3939d83a9..fadf593621 100644
--- a/Documentation/config/promisor.txt
+++ b/Documentation/config/promisor.txt
@@ -11,6 +11,11 @@ promisor.advertise::
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
-	capability, see linkgit:gitprotocol-v2[5]. Default is "none",
-	which means no promisor remote advertised by a server will be
-	accepted.
+	capability, see linkgit:gitprotocol-v2[5]. If set to
+	"knownName" the client will accept promisor remotes which are
+	already configured on the client and have the same name as
+	those advertised by the client. If set to "knownUrl", the
+	client will accept promisor remotes which have both the same
+	name and the same URL configured on the client as the name and
+	URL advertised by the server. Default is "none", which means
+	no promisor remote advertised by a server will be accepted.
diff --git a/promisor-remote.c b/promisor-remote.c
index d347f4d9b5..0ff26b835e 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -362,19 +362,54 @@ void promisor_remote_info(struct repository *repo, struct strbuf *buf)
 	strvec_clear(&urls);
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
 
 static void filter_promisor_remote(struct repository *repo,
@@ -384,10 +419,16 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
+	struct strvec names = STRVEC_INIT;
+	struct strvec urls = STRVEC_INIT;
 
 	if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
 		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
+		else if (!strcasecmp("KnownUrl", accept_str))
+			accept = ACCEPT_KNOWN_URL;
+		else if (!strcasecmp("KnownName", accept_str))
+			accept = ACCEPT_KNOWN_NAME;
 		else if (!strcasecmp("All", accept_str))
 			accept = ACCEPT_ALL;
 		else
@@ -398,6 +439,9 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
+	if (accept != ACCEPT_ALL)
+		promisor_info_vecs(repo, &names, &urls);
+
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -423,7 +467,7 @@ static void filter_promisor_remote(struct repository *repo,
 
 		decoded_url = url_decode(remote_url);
 
-		if (should_accept_remote(accept, remote_name, decoded_url))
+		if (should_accept_remote(accept, remote_name, decoded_url, &names, &urls))
 			strvec_push(accepted, remote_name);
 
 		strbuf_list_free(elems);
@@ -431,6 +475,8 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 
 	free(accept_str);
+	strvec_clear(&names);
+	strvec_clear(&urls);
 	strbuf_list_free(remotes);
 }
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 7e44ad15ce..c2c83a5914 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -117,6 +117,74 @@ test_expect_success "fetch with promisor.acceptfromserver set to 'None'" '
 		--no-local --filter="blob:limit=5k" server client &&
 	test_when_finished "rm -rf client" &&
 
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server
+'
+
+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownName'" '
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
+test_expect_success "fetch with 'KnownName' and different remote names" '
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
+	initialize_server
+'
+
+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownUrl'" '
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
+test_expect_success "fetch with 'KnownUrl' and different remote urls" '
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
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 ""
 '
-- 
2.46.0.4.gbcb884ee16


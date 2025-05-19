Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0242820CF
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664007; cv=none; b=b0dud4CRRYxynxOvHQmDvrFUakEuXE+xkcp9pH9ufP42PUgj2pWgeRrgzFwLqbpku7lcRi4yeHWJuPtnr+5H328NZ+2SKuYaxpaUrR8jd0FGQ7jlpavmj1BHGvTSukcX74JeZfkS0HxjsT+Nfj80sJDgFmUcZD1c5Rl8Dicznns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664007; c=relaxed/simple;
	bh=et2AZbYqWAZt+Cun4EOkoXgKCv8G12eHZuakumPRUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8k0RIa2mwxI8IogiGGSL8so/qMCP3eU1jD25r07K3m7RG8yeHFsQ70G9U/2OJImQhz2Qk6Si27nS+DGyZCgLsA0MDShiJAnunm3D6h7/0BsAK++q1F3BHwMvTZrNSFU3HLV05WjIPglI72eQn7fw1OFnB/Xb3VbRRC6lHjZmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko0HB6k/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko0HB6k/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso35326595e9.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664003; x=1748268803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOOxHEapdMalfKxkCGWBqJJ3n0UI/U6aev3oB/hgS3U=;
        b=Ko0HB6k/3iyMiy/dSajsrv78M9XsTVBWPFCLFLqhdRTcxvxvu3oOzXqaTRxCQnT8GC
         iEDvBdT1mwzSfTiyMn4iQkviaKdqu+pe8mYwJ70IqI05fPRHuDl5Bw5slYpbNiA1diZB
         QzG765cinMkYj8f5g3YMm9NfCRx0U6FSYSo7h9UJv0H3un+Zi6RR5iDZ+hlAlNqkV8H6
         9y2KRK5BufWHAUVPS+rhsfvdd9Raq6upck4dxodIruZml1MLSTyD4u8b6D/WLgMrviMO
         409Ks4BqSB2mT96vX01LT+7q+opmbBfQfGioD3sUpkegF0OCL0HREVWa2I3n7h2tFE+B
         yvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664003; x=1748268803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOOxHEapdMalfKxkCGWBqJJ3n0UI/U6aev3oB/hgS3U=;
        b=FyuJJl6LRRyVmdszqqXjZJOlfz4tzL3v+5B8xfokapj2PHxlG2FvIWlxnNebcrSTN9
         vnMMCjj58I2Re4RhUEIU60xqE4AOK3NMCkRTWBMfYUPSj4h88QInRAJPdshrQ7nKW1xQ
         xMJ+djlRV0+NIWeRg+dZURFBDce8svv1LEcZGzbPDMrKtn4IrRVguZl40INSHjFvXLo8
         7+Dk8F0jrfj3qRv9UbFUvZ8XesD88jFanOqN4m2kGeeq6rVI3Br7TDkYvkxtsN33g6YK
         4DZebaGEU8AA2awqk1hJ7bmH7W9TTu7EITWoWlfgk1q9kex2pdeTNld7D/YTFWnIcoUi
         TtUQ==
X-Gm-Message-State: AOJu0YyiKNCuqZnnbHCs2JpBu6ybuGnJ+OFD2io0S88EydJTxXCFsorj
	jqCGYUol8w3H6iTM8tImQMNiYCpJ22pb2VA59zpto+rKTK3zgcgt7RohFhSWLc6Y
X-Gm-Gg: ASbGncuJJJJUmcSns/T0sDwkh8YaVf2g8Av0/vWXfUq5L7Zl/x0cEspL4iHvnLAAX8/
	spDy6nXmwSB/3hYFFB3789/CNDKQgpNLnsNCL40WI6VBfa5TnwYvlqBPEWLeoRHKMJqHmr31JlQ
	PGD4KeLPMmnwyrZByyvNZb9acoxoyzbFrtvV/C6BnAK83KsUsB4fXepBK+Dbv/fPi8wvKKfZscB
	o4tSae57jPAe3rZH7wuwznSikjmVBjq1C/i7TiWTIAB4u1guRJFU7Iip1RO6TIttV7tbbp1Nyqg
	EAZinLGOawYKuMImQWXVl+ceMG4vtHNkV9mVRh0UuH+fzNKPGhxyhhju76cyHkvE/sjb+jirqKm
	x9NE/VxKpW03XZUiELN9C8xzxUdhG6N6MTV6y
X-Google-Smtp-Source: AGHT+IG3X6F8NsMqR8Fvr350G2nRtDK00ajzaiJ5DsGyoGkW/jfxqEKwV8+bd/cW//Q8LAI0btcLzw==
X-Received: by 2002:a05:600c:3b21:b0:441:b3eb:5720 with SMTP id 5b1f17b1804b1-442ff0396b5mr114236685e9.29.1747664002847;
        Mon, 19 May 2025 07:13:22 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm160372405e9.13.2025.05.19.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:13:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/5] promisor-remote: allow a client to check fields
Date: Mon, 19 May 2025 16:12:58 +0200
Message-ID: <20250519141259.3061550-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.596.g707f6eb7a2.dirty
In-Reply-To: <20250519141259.3061550-1-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit allowed a server to pass additional fields through
the "promisor-remote" protocol capability after the "name" and "url"
fields, specifically the "partialCloneFilter" and "token" fields.

Let's make it possible for a client to check if these fields match
what it expects before accepting a promisor remote.

We allow this by introducing a new "promisor.checkFields"
configuration variable. It should contain a comma or space separated
list of fields that will be checked.

By limiting the protocol to specific well-defined fields, we ensure
both server and client have a shared understanding of field
semantics and usage.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    | 35 ++++++++++++
 promisor-remote.c                     | 79 +++++++++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 35 ++++++++++++
 3 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 71311b70c8..c2443cabd8 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -46,3 +46,38 @@ promisor.acceptFromServer::
 	lazily fetchable from this promisor remote from its responses
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+
+promisor.checkFields::
+	A comma or space separated list of additional remote related
+	fields that a client will check before accepting a promisor
+	remote. Currently, "partialCloneFilter" and "token" are the only
+	supported field names.
++
+If one of these field names (e.g., "token") is being checked for an
+advertised promisor remote (e.g., "foo"), three conditions must be met
+for the check of this specific field to pass:
++
+1. The corresponding local configuration (e.g., `remote.foo.token`)
+   must be set.
+2. The server must advertise the "token" field for remote "foo".
+3. The value of the locally configured `remote.foo.token` must exactly
+   match the value advertised by the server for the "token" field.
++
+If any of these conditions are not met for any field name listed in
+`promisor.checkFields`, the advertised remote "foo" will be rejected.
++
+For the "partialCloneFilter" field, this allows the client to ensure
+that the server's filter matches what it expects locally, preventing
+inconsistencies in filtering behavior. For the "token" field, this can
+be used to verify that authentication credentials match expected
+values.
++
+The "name" and "url" fields are always checked according to the
+`promisor.acceptFromServer` policy, independently of this setting.
++
+The fields should be passed by the server through the
+"promisor-remote" capability by using the `promisor.sendFields` config
+variable. The fields will be checked only if the
+`promisor.acceptFromServer` config variable is not set to "None". If
+set to "None", this config variable will have no effect. See
+linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 13bfa817c3..8ac1c99bed 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -381,6 +381,20 @@ static struct string_list *fields_sent(void)
 	return &fields_list;
 }
 
+static struct string_list *fields_checked(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_list.cmp = strcasecmp;
+		fields_from_config(&fields_list, "promisor.checkFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
 /*
  * Linked list for promisor remotes involved in the "promisor-remote"
  * protocol capability.
@@ -537,6 +551,55 @@ enum accept_promisor {
 	ACCEPT_ALL
 };
 
+static int match_field_against_config(const char *field, const char *value,
+				      struct promisor_info *config_info)
+{
+	if (config_info->filter && !strcasecmp(field, promisor_field_filter))
+		return !strcmp(config_info->filter, value);
+	else if (config_info->token && !strcasecmp(field, promisor_field_token))
+		return !strcmp(config_info->token, value);
+
+	return 0;
+}
+
+static int all_fields_match(struct promisor_info *advertised,
+			    struct promisor_info *config_info,
+			    int in_list)
+{
+	struct string_list* fields = fields_checked();
+	struct string_list_item *item_checked;
+
+	for_each_string_list_item(item_checked, fields) {
+		int match = 0;
+		const char *field = item_checked->string;
+		const char *value = NULL;
+
+		if (!strcasecmp(field, promisor_field_filter))
+			value = advertised->filter;
+		else if (!strcasecmp(field, promisor_field_token))
+			value = advertised->token;
+
+		if (!value)
+			return 0;
+
+		if (in_list) {
+			for (struct promisor_info *p = config_info; p; p = p->next) {
+				if (match_field_against_config(field, value, p)) {
+					match = 1;
+					break;
+				}
+			}
+		} else {
+			match = match_field_against_config(field, value, config_info);
+		}
+
+		if (!match)
+			return 0;
+	}
+
+	return 1;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct promisor_info *config_info)
@@ -546,7 +609,7 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
-		return 1;
+		return all_fields_match(advertised, config_info, 1);
 
 	p = remote_nick_find(config_info, remote_name);
 
@@ -555,7 +618,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 
 	if (accept == ACCEPT_KNOWN_NAME)
-		return 1;
+		return all_fields_match(advertised, p, 0);
 
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
@@ -570,7 +633,7 @@ static int should_accept_remote(enum accept_promisor accept,
 		    remote_name);
 
 	if (!strcmp(p->url, remote_url))
-		return 1;
+		return all_fields_match(advertised, p, 0);
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, p->url, remote_url);
@@ -602,6 +665,10 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 			info->name = value;
 		else if (!strcmp(elem, "url"))
 			info->url = value;
+		else if (!strcasecmp(elem, promisor_field_filter))
+			info->filter = value;
+		else if (!strcasecmp(elem, promisor_field_token))
+			info->token = value;
 		else
 			free(value);
 	}
@@ -644,9 +711,6 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL)
-		config_info = promisor_config_info_list(repo, NULL);
-
 	/* Parse remote info received */
 
 	remotes = strbuf_split_str(info, ';', 0);
@@ -661,6 +725,9 @@ static void filter_promisor_remote(struct repository *repo,
 		if (!advertised)
 			continue;
 
+		if (!config_info)
+			config_info = promisor_config_info_list(repo, fields_checked());
+
 		if (should_accept_remote(accept, advertised, config_info))
 			strvec_push(accepted, advertised->name);
 
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 27c32b2573..3538aacfd5 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -327,6 +327,41 @@ test_expect_success "clone with promisor.sendFields" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.checkFields" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.token "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+	git -C server config promisor.sendFields "partialCloneFilter, token" &&
+	test_when_finished "git -C server config unset promisor.sendFields" &&
+	test_when_finished "rm trace" &&
+
+	# Clone from server to create a client
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.partialCloneFilter="blob:none" \
+		-c promisor.acceptfromserver=All \
+		-c promisor.checkFields=partialcloneFilter \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
+	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
+	test_grep "clone> promisor-remote=lop" trace &&
+	test_grep ! "clone> promisor-remote=lop;otherLop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.49.0.596.g707f6eb7a2.dirty


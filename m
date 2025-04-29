Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF8218EAB
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938400; cv=none; b=k/fuHAXHv3sLpX8mvqguJ1qGyzGAd5Wb3kp8Wy+ZkmNGYblWZvpD6WW8RNbZ3t4isqkgfUzVoLxoC3GBfZvHgcO9XHB3v98ebLxnG0wSpPfeCUacL3g7Mj7bEkLA8lFfOKfVxWfRXVHppY0PvG1zP/CI0NavYWJ6hSZXXq+hsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938400; c=relaxed/simple;
	bh=/dPXgEHxV03/y9D42a5J1xnP/rDiUu6Y7sTifbgKEcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4R+YUm4HAjM/a4+P6ey1Tmagt5jpF4Kl342JHaptUTTK2a7jjQ4niIFJHiNHQz+EBUwm23k9DNxBhBTOZxACeK67xYZYb2HSXr5PUAZphSnC7yvaC+TvOiSzrA3MiYIdgozb1Cx3rNitjmq/PAYEiDjM/T3JDFXuDV7j4ad/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYvHG5Ho; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYvHG5Ho"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1361826966b.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938396; x=1746543196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPGAnugJEpQIk8Gh7ntpUITTEETQzHO8Bbu5Z9yNSQM=;
        b=HYvHG5Ho8fpb6r72wGhe7JWZV1jtcbUKQ2d1Mk4FRQck1BKhAWj/WlR70bb0KtEGk4
         CEpdJqhqzOO0KSxWCWKcbsbXCM3FaaZHZJqKYmUZkaF6okEjpTukV2/kUTb7dpOF7r+p
         04cmLVnLdT2O2BEEXlYSbciH0FWjudwtInlr6RyP0JhU/3EaOgpfPeYaVV3UIz00G8kd
         d+kllKHXdQYAGy4PoFfRDuG7QUBMKul0bBxAIziCzZYkjXOnk9IkLU16ISs6iqnB4vdh
         mIljmHt9We7l1p7veY6QhGaAZc7sdjS+F4T/PIfpOgPhpsAHAyeLKTr7fwBNsCFZSxCs
         qEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938396; x=1746543196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPGAnugJEpQIk8Gh7ntpUITTEETQzHO8Bbu5Z9yNSQM=;
        b=Bk8nK0grtJddKJn4AZEwd01XIm6ty/uq4lCu/gXkXqkEYxt1aDZtvPVlz9xKFmxBdv
         rGuGsMC2LtJRmYc/YrNBtKLt7A7tgT0kl4Lmn+C7q4QghxkIvIorgjfypf5dHH+Vs3Fu
         NLwF/M3G1VxyFHjAWtdm2HjRrNV+/XAShQ//OT6ALQYtg42QjGMAmH5xlZFLc02bzr5K
         hetNpg19Lrbt81xZ3lCW7cTW/ZfhnHL5uJXEDlk+aX6k9frWTu9xgWqI0dm9L+4g1Qu7
         tJC+RwwBMoo+8qpBlisFS2uuc044AUjxCWPuVgwCIbS+djphAj9QvS4F5nfsamp7WzBW
         JDHA==
X-Gm-Message-State: AOJu0YxzmPn06E+TFG5ViQjV9a8ZoOOT7E5/C6sKUCEDuyV+ltaCLsJa
	p1P9NKAMRHrv8Jt1FKX596lPoq0nBXGwh9aljiSObEKrwevOcb4NWVODpw==
X-Gm-Gg: ASbGncuOPNQfvy82wHWZZEjp9OsfAM2co3xOfKCqqw2GDovtHP0MbJ6Em/iELNUMAUH
	y3cYP7rlz6/CRyi4hHY0Rt52HsBeWFQ4bjAJlEoVA2syj1PYmkSu25UZLksVgwvGQGlbVhtMQOc
	tmD6SNvPmGqUcqdujZ4d4HdQ5REYaU9PEtTSsnd1lttr0wPvJ3/iNlLseP+4G1zcjCQpxdFYbvS
	bOtL4hUlJVzRFmtZIUxucLAcPy3m58iJ3kQ2jak4kwbd+s7KdNCO7w3O5JTzwJ8xBgFQkVPKa3F
	UkAGzPE099BmDPUQDXEJYP3EKL5SVwqRVKEAKt/nm4Rg2lFAm+i0/QHxPyzazn1CIQeckx6G8HN
	1
X-Google-Smtp-Source: AGHT+IFOYv3lbatrKkZmFGWdvKJPK4xhRcKf5Nkp53wjsmeSc9N1yBcAIggcBGvWe3kaNjtCrmVCrA==
X-Received: by 2002:a17:906:68cf:b0:ace:c47c:d05 with SMTP id a640c23a62f3a-acec6a7ed35mr303547766b.17.1745938395397;
        Tue, 29 Apr 2025 07:53:15 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:3f04:7ca0:9d50:3329:cd00:6e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6aed0sm791432666b.135.2025.04.29.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:53:14 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] promisor-remote: allow a server to advertise more fields
Date: Tue, 29 Apr 2025 16:52:42 +0200
Message-ID: <20250429145243.992252-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.157.g09af0369a6
In-Reply-To: <20250429145243.992252-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now the "promisor-remote" protocol capability can only pass "name"
and "url" information from a server to a client in the form
"name=<remote_name>,url=<remote_url>".

Let's make it possible to pass more information by introducing a new
"promisor.sendFields" configuration variable. This variable should
contain a comma or space separated list of fields that will be looked
up in the configuration of the remote on the server to find the values
that will be passed to the client.

Only a set of predefined fields are allowed. The only fields in this
set are "partialCloneFilter" and "token".

For example if "promisor.sendFields" is set to "partialCloneFilter",
and the server has the "remote.<name>.partialCloneFilter" config
variable set to a value for a remote, then that value will be passed
in the form "partialCloneFilter=<value>" after the "name" and "url"
fields.

A following commit will allow the client to use the information to
decide if it accepts the remote or not. For now the client doesn't do
anything with the additional information it receives.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    | 18 +++++
 Documentation/gitprotocol-v2.adoc     | 52 +++++++++-----
 promisor-remote.c                     | 99 ++++++++++++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 32 +++++++++
 4 files changed, 175 insertions(+), 26 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 2638b01f83..71311b70c8 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -9,6 +9,24 @@ promisor.advertise::
 	"false", which means the "promisor-remote" capability is not
 	advertised.
 
+promisor.sendFields::
+	A comma or space separated list of additional remote related
+	fields that a server will send while advertising its promisor
+	remotes using the "promisor-remote" capability, see
+	linkgit:gitprotocol-v2[5]. Currently, only the
+	"partialCloneFilter" and "token" fields are supported. The
+	"partialCloneFilter" field contains the partial clone filter
+	used for the remote, and the "token" field contains an
+	authentication token for the remote.
++
+When a field is part of this list and a corresponding
+"remote.foo.<field>" config variable is set on the server to a
+non-empty value, then the field and its value will be sent when
+advertising the promisor remote "foo". This list has no effect unless
+the "promisor.advertise" config variable is set to "true", and the
+"name" and "url" fields are always advertised regardless of this
+setting.
+
 promisor.acceptFromServer::
 	If set to "all", a client will accept all the promisor remotes
 	a server might advertise using the "promisor-remote"
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 5598c93e67..b4648a7ce6 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -785,33 +785,52 @@ retrieving the header from a bundle at the indicated URI, and thus
 save themselves and the server(s) the request(s) needed to inspect the
 headers of that bundle or bundles.
 
-promisor-remote=<pr-infos>
+promisor-remote=<pr-info>
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The server may advertise some promisor remotes it is using or knows
 about to a client which may want to use them as its promisor remotes,
-instead of this repository. In this case <pr-infos> should be of the
+instead of this repository. In this case <pr-info> should be of the
 form:
 
-	pr-infos = pr-info | pr-infos ";" pr-info
+	pr-info = pr-fields | pr-info ";" pr-info
 
-	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
+	pr-fields = fld-name "=" fld-value | pr-fields "," pr-fields
 
-where `pr-name` is the urlencoded name of a promisor remote, and
-`pr-url` the urlencoded URL of that promisor remote.
+where all the `fld-name` and `fld-value` in a given `pr-fields` are
+field names and values related to a single promisor remote.
 
-In this case, if the client decides to use one or more promisor
-remotes the server advertised, it can reply with
-"promisor-remote=<pr-names>" where <pr-names> should be of the form:
+The server MUST advertise at least the "name" and "url" field names
+along with the associated field values, which are the name of a valid
+remote and its URL, in each `pr-fields`.
 
-	pr-names = pr-name | pr-names ";" pr-name
+The server MAY advertise the following optional fields:
+
+- "partialCloneFilter": Filter used for partial clone, corresponding
+  to the "remote.<name>.partialCloneFilter" config setting.
+- "token": Authentication token for the remote, corresponding
+  to the "remote.<name>.token" config setting.
+
+No other fields are defined by the protocol at this time. Clients SHOULD
+ignore fields they don't recognize to allow for future protocol extensions.
+
+For now, the client can only use information transmitted through these
+fields to decide if it accepts the advertised promisor remote. In the
+future that information might be used for other purposes though.
+
+Field values MUST be urlencoded.
+
+If the client decides to use one or more promisor remotes the server
+advertised, it can reply with "promisor-remote=<pr-names>" where
+<pr-names> should be of the form:
+
+	pr-names = pr-name | pr-names ";" pr-names
 
 where `pr-name` is the urlencoded name of a promisor remote the server
 advertised and the client accepts.
 
-Note that, everywhere in this document, `pr-name` MUST be a valid
-remote name, and the ';' and ',' characters MUST be encoded if they
-appear in `pr-name` or `pr-url`.
+Note that, everywhere in this document, the ';' and ',' characters
+MUST be encoded if they appear in `pr-name` or `fld-value`.
 
 If the server doesn't know any promisor remote that could be good for
 a client to use, or prefers a client not to use any promisor remote it
@@ -822,9 +841,10 @@ In this case, or if the client doesn't want to use any promisor remote
 the server advertised, the client shouldn't advertise the
 "promisor-remote" capability at all in its reply.
 
-The "promisor.advertise" and "promisor.acceptFromServer" configuration
-options can be used on the server and client side to control what they
-advertise or accept respectively. See the documentation of these
+On the server side, the "promisor.advertise" and "promisor.sendFields"
+configuration options can be used to control what it advertises. On
+the client side, the "promisor.acceptFromServer" configuration option
+can be used to control what it accepts. See the documentation of these
 configuration options for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
diff --git a/promisor-remote.c b/promisor-remote.c
index 24d0e70132..70abec4c24 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,84 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * List of field names allowed to be used in the "promisor-remote"
+ * protocol capability. Each field should correspond to a configurable
+ * property of a remote that can be relevant for the client.
+ */
+static const char *allowed_fields[] = {
+	"partialCloneFilter", /* Filter used for partial clone */
+	"token",              /* Authentication token for the remote */
+	NULL
+};
+
+/*
+ * Check if 'field' is in the list of allowed field names for the
+ * "promisor-remote" protocol capability.
+ */
+static int is_allowed_field(const char *field)
+{
+	const char **p;
+
+	for (p = allowed_fields; *p; p++)
+		if (!strcasecmp(*p, field))
+			return 1;
+	return 0;
+}
+
+static int valid_field(struct string_list_item *item, void *cb_data)
+{
+	const char *field = item->string;
+	const char *config_key = (const char *)cb_data;
+
+	if (!is_allowed_field(field)) {
+		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
+		return 0;
+	}
+	return 1;
+}
+
+static char *fields_from_config(struct string_list *fields_list, const char *config_key)
+{
+	char *fields = NULL;
+
+	if (!git_config_get_string(config_key, &fields) && *fields) {
+		string_list_split_in_place(fields_list, fields, ", ", -1);
+		filter_string_list(fields_list, 0, valid_field, (void *)config_key);
+	}
+
+	return fields;
+}
+
+static struct string_list *fields_sent(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized = 0;
+
+	if (!initialized) {
+		fields_list.cmp = strcasecmp;
+		fields_from_config(&fields_list, "promisor.sendFields");
+		initialized = 1;
+	}
+
+	return &fields_list;
+}
+
+static void append_fields(struct string_list *fields,
+			  struct string_list *field_names,
+			  const char *name)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, field_names) {
+		char *key = xstrfmt("remote.%s.%s", name, item->string);
+		const char *val;
+		if (!git_config_get_string_tmp(key, &val) && *val)
+			string_list_append(fields, item->string)->util = (char *)val;
+		free(key);
+	}
+}
+
 /*
  * Linked list for promisor remotes involved in the "promisor-remote"
  * protocol capability.
@@ -323,8 +401,9 @@ static int allow_unsanitized(char ch)
  * member, and values in the 'util' member.
  *
  * Currently supported field names:
- * - "name": The name of the promisor remote.
- * - "url": The URL of the promisor remote.
+ * - "name": The name of the promisor remote,
+ * - "url": The URL of the promisor remote,
+ * - the fields in 'allowed_fields[]' above.
  *
  * Except for "name", each "<field_name>/<field_value>" pair should
  * correspond to a "remote.<name>.<field_name>" config variable set to
@@ -355,7 +434,8 @@ static void promisor_info_list_free(struct promisor_info *p)
  * remotes. For each promisor remote, some of its fields, starting
  * with "name" and "url", are put in the 'fields' string_list.
  */
-static struct promisor_info *promisor_info_list(struct repository *repo)
+static struct promisor_info *promisor_info_list(struct repository *repo,
+						struct string_list *field_names)
 {
 	struct promisor_info *infos = NULL;
 	struct promisor_info **last_info = &infos;
@@ -377,6 +457,9 @@ static struct promisor_info *promisor_info_list(struct repository *repo)
 			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
 			string_list_append(&new_info->fields, "url")->util = (char *)url;
 
+			if (field_names)
+				append_fields(&new_info->fields, field_names, r->name);
+
 			*last_info = new_info;
 			last_info = &new_info->next;
 		}
@@ -399,7 +482,7 @@ char *promisor_remote_info(struct repository *repo)
 	if (!advertise_promisors)
 		return NULL;
 
-	info_list = promisor_info_list(repo);
+	info_list = promisor_info_list(repo, fields_sent());
 
 	if (!info_list)
 		return NULL;
@@ -520,7 +603,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL)
-		info_list = promisor_info_list(repo);
+		info_list = promisor_info_list(repo, NULL);
 
 	/* Parse remote info received */
 
@@ -537,13 +620,9 @@ static void filter_promisor_remote(struct repository *repo,
 		elems = strbuf_split(remotes[i], ',');
 
 		for (size_t j = 0; elems[j]; j++) {
-			int res;
 			strbuf_strip_suffix(elems[j], ",");
-			res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
+			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
 				skip_prefix(elems[j]->buf, "url=", &remote_url);
-			if (!res)
-				warning(_("unknown element '%s' from remote info"),
-					elems[j]->buf);
 		}
 
 		if (remote_name)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index b35b774235..4038c076f1 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -289,6 +289,38 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.sendFields" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.token "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+	git -C server config promisor.sendFields "token, partialCloneFilter" &&
+	test_when_finished "git -C server config unset promisor.sendFields" &&
+	test_when_finished "rm trace" &&
+
+	# Clone from server to create a client
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that fields are properly transmitted
+	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
+	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR2="name=otherLop,url=https://invalid.invalid,token=fooBar,partialCloneFilter=blob:limit=10k" &&
+	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
+	test_grep "clone> promisor-remote=lop;otherLop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.49.0.157.g09af0369a6


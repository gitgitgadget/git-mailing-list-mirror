Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C822370D68
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253161; cv=none; b=fKHCsKqUEZbJoUd+K6OiTX6X/W7EiTw/Wz2dI4BXhpHfLTIfStEsguCZFU7YQmNVyGHVheLBWjvAqcsEN2qgTCES1yrFXOKRPYUz7jxsQjVz20HuvbqngBdN0UY1wbw7xxDem1Le4ChPL3aW/OWMUBr4jFHLBjkd58XERvB2jM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253161; c=relaxed/simple;
	bh=a/MoQV5sl9u755bwID1ssd74N4xgBA10LF73oN3cXz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DylGAVBXn0jDGxzL34dCpAIJ81j7dpjy0stL4Q+cNZsnqBvn8WReXcwHAqDXbTCVyqTOZwuwqWT8efxNOsEYH5e9eVqAAQsqRArIBtxfxJjbDZQuYMCqbx/tWFG6yxId3PT8bpbk7sBveD9/rOjZgqjjNaL4bcSJ+aRqtVbMxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrwVPfpU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrwVPfpU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b5bded412so2322185f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253157; x=1774857957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Umyg4bxBMfLhAyiXkFue16NiGZw3JIMhG1MCQExcrvk=;
        b=QrwVPfpU4r+7IwE39qRBKXjsX1LMrr/KfHhTn7kPOFP5qrjnweWXj99mcXomRXmR7s
         VZPGg9sYU9dSUdOzFyB1fM+wKJPI1mQSH+KvGJNMle2wxSH2ARexZnF+bythm5w1S0p4
         WAbbHW069m+ZQ1JhHFbIv9xA4UfGZ7m8T5Rd7lL5DuXUdnBLh6MbMwZguH5r8Nebx/JZ
         88X40t6twYe5nhrbWBW2R5D4EzQKyJ1/TmjQfpkdW9VuRbJBdrPPh2lmRbgn2sxqTz8L
         Qgfrmzs2zAnP1T2BlKkQyWbqYx6hQYn78yGcNxDqFbUI8guQKlwW8+DuVInnAFwcGjh5
         7IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253157; x=1774857957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Umyg4bxBMfLhAyiXkFue16NiGZw3JIMhG1MCQExcrvk=;
        b=haY+8qLvAaT5wMSaA2v7XWRAE1h6foi8YRbbTD4K9nfyziEUoDaaUezrxCgwPIhUUA
         4JSMyJfvlE5gFQlCTNBhYOn9MTRf5xozDumAru7cxVbJkXxIVPPz4/KF+BW9twYdUwg7
         ah4MsxJywa1DQ6HEBEI3e4454dEySPJNGh6+w+hIyywhFUkcdGBPILjj1EtdnYdOsp4O
         mKjpHaeSgaSN8UJc/RS+tKfeHB8bqW7Q0qmWaFu0HU4Iv/R1/AgSJUWKLDgC7LmOphkE
         kQvX9jyNkUQ2JqjZ+FbhRxBDJPnR/kZZQk7565R4csjH3iEPv0ZwkWKwivvc6y3htPOV
         7/tw==
X-Gm-Message-State: AOJu0YwBM8p1Nt70h55SU2vcLh4Ss6yN5+pVctLHHb8XVL4j1qKg12qe
	1BwEhbW/gzSlEus3L5XQMC4Y/hvakVMw+XezKsbIr/+GTIXW1JzqR0zFqXBeaQ==
X-Gm-Gg: ATEYQzwJFM1dKJ0UDJwBFik4cgGJFktMwUJOqVrfbowUge/mJLDtVb+hP2IjWZ38OQ1
	ujRIElmeB0mnwjUAj99X+Y2Hcb/OvX0gAdbSAsfGG0lWflKx7LRpama29Z3xVZ/k3H8l4B3Syv1
	oYkRMrJgSQ+w887H5DJxbQQvLMWzSFYH+N4AZSl/NXwtgzUWMhm43t/o00pCArG+3N7eNwkoNto
	BwhguovuErsYDKgvEZtapj7HjVeFNQvsrUMSHxquhp2F+x1EXITxLBeu7+3Y/8FxZ/pj8U2qOc9
	Jp7KzaCCRc9tPK/pc13VR0YUMAJh+oGWyIR5beWstBaA0Bz5FntXgayOXnnQ9rcSgwKEQ477TDH
	uqo4yxkG4tQUXxb1VxXJMUqXogoBSB/OBcqKcTFxHhy9OpjBhxzNF7qJC+UYH6KB7YDJHGqjMzJ
	Vz11Hlqav35ffH/1CCdfcirIbpl9egbIi4lF6soQ5cN7pTKjnPC8UDvh+UqPiDFG6rBjrE0w46H
	yUouQ4DidS+5Xxqb1IVqdEzvq+I/jKS2pIeDgI=
X-Received: by 2002:a05:6000:40e0:b0:43b:433f:48a4 with SMTP id ffacd0b85a97d-43b642347f0mr18820552f8f.2.1774253157042;
        Mon, 23 Mar 2026 01:05:57 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:56 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 15/16] promisor-remote: auto-configure unknown remotes
Date: Mon, 23 Mar 2026 09:05:18 +0100
Message-ID: <20260323080520.887550-16-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have introduced the `promisor.acceptFromServerUrl`
config variable to whitelist some URLs advertised by a server through
the "promisor-remote" protocol capability.

However the new `promisor.acceptFromServerUrl` mechanism, like the old
`promisor.acceptFromServer` mechanism, still requires a remote to
already exist in the client's local configuration before it can be
accepted. This places a significant manual burden on users to
pre-configure these remotes, and creates friction for administrators
who have to troubleshoot or manually provision these setups for their
teams.

To eliminate this burden, let's automatically create a new `[remote]`
section in the client's config when a server advertises an unknown
remote whose URL matches a `promisor.acceptFromServerUrl` glob pattern.

Concretely, let's add four helpers:

 - sanitize_remote_name(): turn an arbitrary URL-derived string into a
   valid remote name by replacing non-alphanumeric characters,
   collapsing runs of '-', and prepending "promisor-auto-".

 - promisor_remote_name_from_url(): normalize the URL and extract
   host+port+path to build a human-readable base name, then pass it
   through sanitize_remote_name().

 - configure_auto_promisor_remote(): write the remote.*.url,
   remote.*.promisor and remote.*.advertisedAs keys to the repo
   config.

 - handle_matching_allowed_url(): pick the final name (user-supplied
   alias or auto-generated), handle collisions by appending "-1",
   "-2", etc., then call configure_auto_promisor_remote().

Let's also add should_accept_new_remote_url() which reuses the
url_matches_accept_list() helper introduced in a previous commit to
find a matching pattern, then delegates to handle_matching_allowed_url()
to create the remote.

And then let's call should_accept_new_remote_url() from the '!item'
(unknown remote) branch of should_accept_remote(), setting
`reload_config` so that the newly-written config is picked up.

Finally let's document all that by:

 - expanding the `promisor.acceptFromServerUrl` entry to describe
   auto-creation, the optional "name=" prefix syntax, the
   "promisor-auto-*" generation rules, and numeric-suffix collision
   handling, and by
 - adding a "remote.<name>.advertisedAs" entry to "remote.adoc".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  35 ++++-
 Documentation/config/remote.adoc      |   9 ++
 promisor-remote.c                     | 202 +++++++++++++++++++++++++-
 t/t5710-promisor-remote-capability.sh | 122 ++++++++++++++++
 4 files changed, 355 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 6f5442cd65..d8e5f4a6dc 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -53,9 +53,11 @@ promisor.acceptFromServer::
 
 promisor.acceptFromServerUrl::
 	A glob pattern to specify which URLs advertised by a server
-	are considered trusted by the client. This option acts as an
-	additive security whitelist that works in conjunction with
-	`promisor.acceptFromServer`.
+	are allowed to be auto-configured (created and persisted) on
+	the client side. Unlike `promisor.acceptFromServer`, which
+	only accepts already configured remotes, a match against this
+	option instructs Git to write a new `[remote "<name>"]`
+	section to the client's configuration.
 +
 This option can appear multiple times in config files. An advertised
 URL will be accepted if it matches _ANY_ glob pattern specified by
@@ -91,11 +93,28 @@ possible, and path segments like `..` are resolved.  Glob patterns
 are matched against this normalized URL as-is, so patterns should
 be written in normalized form (e.g., lowercase scheme and host).
 +
-Even if `promisor.acceptFromServer` is set to `None` (the default),
-Git will still accept field updates (like tokens) for known remotes,
-provided their URLs match a pattern in
-`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
-details on the protocol.
+The glob pattern can optionally be prefixed with a remote name and an
+equals sign (e.g., `cdn=https://cdn.example.com/*`). If such a prefix
+is provided, accepted remotes will be saved under that name. If no
+such prefix is provided, a safe remote name will be automatically
+generated by sanitizing the URL and prefixing it with
+`promisor-auto-`. If a remote with the chosen name already exists but
+points to a different URL, Git will append a numeric suffix (e.g.,
+`-1`, `-2`) to the name to prevent overwriting existing
+configurations. You should make sure that this doesn't happen often
+though, as remotes will be rejected if the numeric suffix increases
+too much. In all cases, the original name advertised by the server is
+recorded in the `remote.<name>.advertisedAs` configuration variable
+for tracing and debugging purposes.
++
+Note that this option acts as an additive security whitelist. It works
+in conjunction with `promisor.acceptFromServer` (see the documentation
+of that option for the implications of accepting a promisor
+remote). Even if `promisor.acceptFromServer` is set to `None` (the
+default), Git will still automatically configure new remotes, and
+accept field updates (like tokens) for known remotes, provided their
+URLs match a pattern in `promisor.acceptFromServerUrl`. See
+linkgit:gitprotocol-v2[5] for details on the protocol.
 
 promisor.checkFields::
 	A comma or space separated list of additional remote related
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..6e2bbdf457 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -91,6 +91,15 @@ remote.<name>.promisor::
 	When set to true, this remote will be used to fetch promisor
 	objects.
 
+remote.<name>.advertisedAs::
+	When a promisor remote is automatically configured using
+	information advertised by a server through the
+	`promisor-remote` protocol capability (see
+	`promisor.acceptFromServerUrl`), the server's originally
+	advertised name is saved in this variable. This is for
+	information, tracing and debugging purposes. Users should not
+	typically modify or create such configuration entries.
+
 remote.<name>.partialclonefilter::
 	The filter that will be applied when fetching from this	promisor remote.
 	Changing or clearing this value will only affect fetches for new commits.
diff --git a/promisor-remote.c b/promisor-remote.c
index 210e6950af..5321a9c4bf 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -750,10 +750,197 @@ static struct allowed_url *url_matches_accept_list(
 	return NULL;
 }
 
-static int should_accept_remote(enum accept_promisor accept,
+/*
+ * Sanitize the buffer to make it a valid remote name coming from the
+ * server by:
+ *
+ * - replacing any non alphanumeric character with a '-'
+ * - stripping any leading '-',
+ * - condensing multiple '-' into one,
+ * - prepending "promisor-auto-",
+ * - validating the result.
+ */
+static int sanitize_remote_name(struct strbuf *buf, const char *url)
+{
+	char prev = '-';
+	for (size_t i = 0; i < buf->len; ) {
+		if (!isalnum(buf->buf[i]))
+			buf->buf[i] = '-';
+		if (prev == '-' && buf->buf[i] == '-') {
+			strbuf_remove(buf, i, 1);
+		} else {
+			prev = buf->buf[i];
+			i++;
+		}
+	}
+
+	strbuf_strip_suffix(buf, "-");
+
+	if (!buf->len) {
+		warning(_("couldn't generate a valid remote name from "
+			  "advertised url '%s', ignoring this remote"), url);
+		return -1;
+	}
+
+	strbuf_insertstr(buf, 0, "promisor-auto-");
+
+	if (!valid_remote_name(buf->buf)) {
+		warning(_("generated remote name '%s' from advertised url '%s' "
+			  "is invalid, ignoring this remote"), buf->buf, url);
+		return -1;
+	}
+
+	return 0;
+}
+
+static char *promisor_remote_name_from_url(const char *url)
+{
+	struct url_info url_info = { 0 };
+	char *normalized = url_normalize(url, &url_info);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!normalized) {
+		warning(_("couldn't normalize advertised url '%s', "
+			  "ignoring this remote"), url);
+		return NULL;
+	}
+
+	if (url_info.host_len) {
+		strbuf_add(&buf, normalized + url_info.host_off, url_info.host_len);
+		strbuf_addch(&buf, '-');
+	}
+
+	if (url_info.port_len) {
+		strbuf_add(&buf, normalized + url_info.port_off, url_info.port_len);
+		strbuf_addch(&buf, '-');
+	}
+
+	if (url_info.path_len) {
+		strbuf_add(&buf, normalized + url_info.path_off, url_info.path_len);
+		strbuf_trim_trailing_dir_sep(&buf);
+		strbuf_strip_suffix(&buf, ".git");
+	}
+
+	free(normalized);
+
+	if (sanitize_remote_name(&buf, url)) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+static void configure_auto_promisor_remote(struct repository *repo,
+					   const char *name,
+					   const char *url,
+					   const char *advertised_as,
+					   bool reuse)
+{
+	char *key;
+
+	if (!reuse) {
+		fprintf(stderr, _("Auto-creating promisor remote '%s' for URL '%s'\n"),
+			name, url);
+
+		key = xstrfmt("remote.%s.url", name);
+		repo_config_set_gently(repo, key, url);
+		free(key);
+	}
+
+	/* NB: when reusing, this promotes an existing non-promisor remote */
+	key = xstrfmt("remote.%s.promisor", name);
+	repo_config_set_gently(repo, key, "true");
+	free(key);
+
+	if (advertised_as) {
+		key = xstrfmt("remote.%s.advertisedAs", name);
+		repo_config_set_gently(repo, key, advertised_as);
+		free(key);
+	}
+}
+
+#define MAX_REMOTES_WITH_SIMILAR_NAMES 20
+
+/* Return the allocated local name, or NULL on failure */
+static char *handle_matching_allowed_url(struct repository *repo,
+					 char *allowed_name,
+					 const char *remote_url,
+					 const char *remote_name)
+{
+	char *name;
+	char *basename = allowed_name ?
+		xstrdup(allowed_name) :
+		promisor_remote_name_from_url(remote_url);
+	int i = 0;
+	bool reuse = false;
+
+	if (!basename)
+		return NULL;
+
+	name = xstrdup(basename);
+
+	while (i < MAX_REMOTES_WITH_SIMILAR_NAMES) {
+		char *url_key = xstrfmt("remote.%s.url", name);
+		const char *existing_url;
+		int exists = !repo_config_get_string_tmp(repo, url_key, &existing_url);
+
+		free(url_key);
+
+		if (!exists)
+			break; /* Free to use */
+
+		if (!strcmp(existing_url, remote_url)) {
+			reuse = true;
+			break; /* Same URL, so safe to reuse */
+		}
+
+		i++;
+		free(name);
+		name = xstrfmt("%s-%d", basename, i);
+	}
+
+	if (i < MAX_REMOTES_WITH_SIMILAR_NAMES) {
+		configure_auto_promisor_remote(repo, name,
+					       remote_url, remote_name,
+					       reuse);
+	} else {
+		warning(_("too many remotes accepted with name like '%s-X', "
+			  "ignoring this remote"), basename);
+		FREE_AND_NULL(name);
+	}
+
+	free(basename);
+	return name;
+}
+
+static int should_accept_new_remote_url(struct repository *repo,
+					struct string_list *accept_urls,
+					struct promisor_info *advertised)
+{
+	struct allowed_url *allowed = url_matches_accept_list(accept_urls,
+							     advertised->url);
+	if (allowed) {
+		char *name = handle_matching_allowed_url(repo,
+							 allowed->remote_name,
+							 advertised->url,
+							 advertised->name);
+		if (name) {
+			free((char *)advertised->local_name);
+			advertised->local_name = name;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int should_accept_remote(struct repository *repo,
+				enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *accept_urls,
-				struct string_list *config_info)
+				struct string_list *config_info,
+				bool *reload_config)
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
@@ -772,9 +959,13 @@ static int should_accept_remote(enum accept_promisor accept,
 	/* Get config info for that promisor remote */
 	item = string_list_lookup(config_info, remote_name);
 
-	if (!item)
+	if (!item) {
 		/* We don't know about that remote */
-		return 0;
+		int res = should_accept_new_remote_url(repo, accept_urls, advertised);
+		if (res)
+			*reload_config = true;
+		return res;
+	}
 
 	p = item->util;
 
@@ -1029,7 +1220,8 @@ static void filter_promisor_remote(struct repository *repo,
 			string_list_sort(&config_info);
 		}
 
-		if (should_accept_remote(accept, advertised, accept_urls, &config_info)) {
+		if (should_accept_remote(repo, accept, advertised, accept_urls,
+					 &config_info, &reload_config)) {
 			if (!store_info)
 				store_info = store_info_new(repo);
 			if (promisor_store_advertised_fields(advertised, store_info))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 4ebad14af5..7d8df05fc7 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -377,6 +377,128 @@ test_expect_success "clone with 'None', URL whitelisted, but client has differen
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with URL whitelisted and no remote already configured" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that a remote has been auto-created with the right fields.
+	# The remote is identified by "remote.<name>.advertisedAs" == "lop".
+	FULL_NAME=$(git -C client config --name-only --get-regexp "remote\..*\.advertisedas" "^lop$") &&
+	REMOTE_NAME=$(echo "$FULL_NAME" | sed "s/remote\.\(.*\)\.advertisedas/\1/") &&
+
+	# Check ".url" and ".promisor" values
+	printf "%s\n" "$PWD_URL/lop" "true" >expect &&
+	git -C client config "remote.$REMOTE_NAME.url" >actual &&
+	git -C client config "remote.$REMOTE_NAME.promisor" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with named URL whitelisted and no pre-configured remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that a remote has been auto-created with the right "cdn" name and fields.
+	printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	git -C client config "remote.cdn.advertisedAs" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with URL whitelisted but colliding name" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.cdn.promisor=true \
+		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.cdn.url="https://example.com/cdn" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that a remote has been auto-created with the right "cdn-1" name and fields.
+	printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
+	git -C client config "remote.cdn-1.url" >actual &&
+	git -C client config "remote.cdn-1.promisor" >>actual &&
+	git -C client config "remote.cdn-1.advertisedAs" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the original "cdn" remote was not overwritten.
+	printf "%s\n" "https://example.com/cdn" "true" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with URL whitelisted and reusable remote" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.cdn.url="$PWD_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the existing "cdn" remote has been properly updated.
+	printf "%s\n" "$PWD_URL/lop" "true" "lop" "+refs/heads/*:refs/remotes/lop/*" >expect &&
+	git -C client config "remote.cdn.url" >actual &&
+	git -C client config "remote.cdn.promisor" >>actual &&
+	git -C client config "remote.cdn.advertisedAs" >>actual &&
+	git -C client config "remote.cdn.fetch" >>actual &&
+	test_cmp expect actual &&
+
+	# Check that no new "cdn-1" remote has been created.
+	test_must_fail git -C client config "remote.cdn-1.url" &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# As "bad name" contains a space, which is not a valid remote name,
+	# the pattern should be rejected with a warning and no remote created.
+	GIT_NO_LAZY_FETCH=0 git clone \
+		-c promisor.acceptfromserver=None \
+		-c "promisor.acceptFromServerUrl=bad name=https://example.com/*" \
+		--no-local --filter="blob:limit=5k" server client 2>err &&
+
+	# Check that a warning was emitted
+	test_grep "invalid remote name '\''bad name'\''" err &&
+
+	# Check that no remote was auto-created
+	test_must_fail git -C client config --get-regexp "remote\..*\.advertisedas" &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.sendFields" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.53.0.625.g20f70b52bb


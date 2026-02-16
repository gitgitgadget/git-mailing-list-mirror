Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E230CD81
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248221; cv=none; b=elXgBNTVC7Fu9PnjDbbTUprtYSQsH8mt0fC1g5HsL1/ec4qtw1yfz4jBZl2Hkbl/0O7wBIwKlKhnnVS2OB0tY4qcywwdZwIS8fY3OMILLI1wJ78jKKEyO/zudvqwtgZPYyyWpQ2TILcLdRDbzeTr9hjSF2E+c7fzVw5lfNiieDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248221; c=relaxed/simple;
	bh=eGsPhJcmDdzGOX1mI+i5yUbkoU2JXg+BX6KjAu2VlOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhir3MF+9U0gSnX97HDHTDaQaSzLk7bzlWdLxNwvoCaoKmwPMp4JQMQjFSc66oPjYmVvPlBCMCIkoDwh4K3PDX811vNBYqJk+9DsG3NPOuy1S0H4hDRc3pW0aqVGGzM9hKqtcReGPj2WDN/llGS8GkSGGl6Wv9TJsnzdVjuZ7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDG+gGZy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDG+gGZy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4833115090dso28573525e9.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248218; x=1771853018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p56ktStdCOnwO/gY4CQqZvVbn0Dt8HrV7GE1/Cj/ZZo=;
        b=cDG+gGZyoz6LRLcDywkWiB6lQpNmhQeEgS32vhVZV5Ws+HYLSQmh/fFrPb7ry6IvKs
         l+iixxDtHgQMpxS74NWM+cR18dTZr4aGXGQTo8oSwfDzZs1Or0KH/h4X41PsWgkNXcxq
         VAYGYMWSeLkPfThjoyjx8pbAi0j2mDGWx+q1xhKLWOoZ7nuTcNPAR24wOdLn13I6U5pJ
         R87U0lVSyDSk+xzffP6UyEi7SbsO7gHxPMHuEmv55kCMABapob2/pEMAYhLS/6JrTndV
         FtJZ0njyGD7WR7GduEbTytcvDIVEsELrN0nr68CgN6dD0qx7Cr3K5sVrxjYZ3sTBTVoA
         xB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248218; x=1771853018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p56ktStdCOnwO/gY4CQqZvVbn0Dt8HrV7GE1/Cj/ZZo=;
        b=DHus2E0oFGnwGpWuMqywcJ3UDSEjs+5ROx9IeWwAXKeDFM+CQ9x3ht57vS6In6zeYn
         I8YZg5+1k50OKmRX7ir9cwRQiO2gY5f/VaGisiLLmE1q2ICutAXLI4/LdqUpykfvuQCZ
         h40fiYMqoOoV2k0Sm/fLbLTwKDGpbJSarX6d6wMOGkGjBnWkxWPcTJThFYLnq8tngVX5
         GhZO/C7f8v/HqJYp7r0aAWtYSqnZeAx1cqSS1mtWuny3hpw7838jPV5BGHtt7m61YZQk
         uWSKAGF4Jppihcp+/Hq5X2iyhNf8A7Yp+4h3R6wirq/nBBLdCC30E53dj9CMa4PptS9f
         fkIQ==
X-Gm-Message-State: AOJu0YwJHUt7Qoa1FaJaPoojnQjlHo0Z/p8ZZOtBYOuDxk5KqTuh6eZd
	FSu4iVabLEgGdid6/AgRuiWZQYYyt0mV/CBEiO03IdLATOjFrzlIPMeGpHuAeg==
X-Gm-Gg: AZuq6aIV5vLxHhXP/KY+0gvg4FlxpLW+N7FcId9Y4ZnQFWV3Zzi9oo769gnOBnxFE5Q
	DZDQM5b8iXt2wLKjx/wl+hIrUobXJ8WFKhfTnmXytwDYjqQ8HUcSvozFtkeIyjI/DWjDGtfFRlP
	OvqOcgHyjKk4u6DgdY6swslqCRcsRrj42Fs/+qZewCIFNJCc5o0DFJnVMpumal7rFV8++1W9/g0
	oMaseSJOTdAiahlyymy5VWyyimawZcbRMPdDHTbSC5NCVQGgVxEbFDtcXj8c/awzCiia0IPNEZc
	uZSPF34cwnKk9pzyr0cXCUP2foln0TDYmqaM9G/B5TIcnXj6uYganRmhlfoQU8Q8O2Eg/ginysa
	iAxjnNlMP2zL0xKNH131g7CSAPhFzOrOfCAQDNZko0+kJppfyNkJq6X/oQ3/O4ekIYgAzsgojd1
	EXtuUCORNaIgVLbP2pRadHR8+SuWS4p0JH3gm9oQEFlE5P7dHFm0X9rpeX7XY4LTUGm7CLjW+ki
	DWQDb+I1F1XE6hQd/Gau1VlWeE2EXlwlbBZtTE=
X-Received: by 2002:a05:600c:1c29:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48373a5d5a8mr169397725e9.17.1771248217442;
        Mon, 16 Feb 2026 05:23:37 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:36 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/9] promisor-remote: allow a client to store fields
Date: Mon, 16 Feb 2026 14:23:08 +0100
Message-ID: <20260216132317.15894-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
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

Another previous commit, c213820c51 (promisor-remote: allow a client
to check fields, 2025-09-08), has made it possible for a client to
decide if it accepts a promisor remote advertised by a server based
on these additional fields.

Often though, it would be interesting for the client to just store in
its configuration files these additional fields passed by the server,
so that it can use them when needed.

For example if a token is necessary to access a promisor remote, that
token could be updated frequently only on the server side and then
passed to all the clients through the "promisor-remote" capability,
avoiding the need to update it on all the clients manually.

Storing the token on the client side makes sure that the token is
available when the client needs to access the promisor remotes for a
lazy fetch.

To allow this, let's introduce a new "promisor.storeFields"
configuration variable.

Note that for a partial clone filter, it's less interesting to have
it stored on the client. This is because a filter should be used
right away and we already pass a `--filter=<filter-spec>` option to
`git clone` when starting a partial clone. Storing the filter could
perhaps still be interesting for information purposes.

Like "promisor.checkFields" and "promisor.sendFields", the new
configuration variable should contain a comma or space separated list
of field names. Only the "partialCloneFilter" and "token" field names
are supported for now.

When a server advertises a promisor remote, for example "foo", along
with for example "token=XXXXX" to a client, and on the client side
"promisor.storeFields" contains "token", then the client will store
XXXXX for the "remote.foo.token" variable in its configuration file
and reload its configuration so it can immediately use this new
configuration variable.

A message is emitted on stderr to warn users when the config is
changed.

Note that even if "promisor.acceptFromServer" is set to "all", a
promisor remote has to be already configured on the client side for
some of its config to be changed. In any case no new remote is
configured and no new URL is stored.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    |  33 ++++++
 Documentation/gitprotocol-v2.adoc     |  12 ++-
 promisor-remote.c                     | 148 +++++++++++++++++++++++++-
 t/t5710-promisor-remote-capability.sh |  63 +++++++++++
 4 files changed, 250 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 93e5e0d9b5..b0fa43b839 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -89,3 +89,36 @@ variable. The fields are checked only if the
 `promisor.acceptFromServer` config variable is not set to "None". If
 set to "None", this config variable has no effect. See
 linkgit:gitprotocol-v2[5].
+
+promisor.storeFields::
+	A comma or space separated list of additional remote related
+	field names. If a client accepts an advertised remote, the
+	client will store the values associated with these field names
+	taken from the remote advertisement into its configuration,
+	and then reload its remote configuration. Currently,
+	"partialCloneFilter" and "token" are the only supported field
+	names.
++
+For example if a server advertises "partialCloneFilter=blob:limit=20k"
+for remote "foo", and that remote is accepted, then "blob:limit=20k"
+will be stored for the "remote.foo.partialCloneFilter" configuration
+variable.
++
+If the new field value from an advertised remote is the same as the
+existing field value for that remote on the client side, then no
+change is made to the client configuration though.
++
+When a new value is stored, a message is printed to standard error to
+let users know about this.
++
+Note that for security reasons, if the remote is not already
+configured on the client side, nothing will be stored for that
+remote. In any case, no new remote will be created and no URL will be
+stored.
++
+Before storing a partial clone filter, it's parsed to check it's
+valid. If it's not, a warning is emitted and it's not stored.
++
+Before storing a token, a check is performed to ensure it contains no
+control character. If the check fails, a warning is emitted and it's
+not stored.
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index c7db103299..d93dd279ea 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -826,9 +826,10 @@ are case-sensitive and MUST be transmitted exactly as specified
 above. Clients MUST ignore fields they don't recognize to allow for
 future protocol extensions.
 
-For now, the client can only use information transmitted through these
-fields to decide if it accepts the advertised promisor remote. In the
-future that information might be used for other purposes though.
+The client can use information transmitted through these fields to
+decide if it accepts the advertised promisor remote. Also, the client
+can be configured to store the values of these fields (see
+"promisor.storeFields" in linkgit:git-config[1]).
 
 Field values MUST be urlencoded.
 
@@ -856,8 +857,9 @@ the server advertised, the client shouldn't advertise the
 On the server side, the "promisor.advertise" and "promisor.sendFields"
 configuration options can be used to control what it advertises. On
 the client side, the "promisor.acceptFromServer" configuration option
-can be used to control what it accepts. See the documentation of these
-configuration options for more information.
+can be used to control what it accepts, and the "promisor.storeFields"
+option, to control what it stores. See the documentation of these
+configuration options in linkgit:git-config[1] for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
 protocol capability could be used by the server, when responding to
diff --git a/promisor-remote.c b/promisor-remote.c
index 5d8151cedb..59997dd4c7 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -403,6 +403,14 @@ static struct string_list *fields_checked(void)
 	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
 }
 
+static struct string_list *fields_stored(void)
+{
+	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
+	static int initialized;
+
+	return initialize_fields_list(&fields_list, &initialized, "promisor.storeFields");
+}
+
 /*
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
@@ -692,6 +700,132 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 	return info;
 }
 
+static bool store_one_field(struct repository *repo, const char *remote_name,
+			    const char *field_name, const char *field_key,
+			    const char *advertised, const char *current)
+{
+	if (advertised && (!current || strcmp(current, advertised))) {
+		char *key = xstrfmt("remote.%s.%s", remote_name, field_key);
+
+		fprintf(stderr, _("Storing new %s from server for remote '%s'.\n"
+				  "    '%s' -> '%s'\n"),
+			field_name, remote_name,
+			current ? current : "",
+			advertised);
+
+		repo_config_set_gently(repo, key, advertised);
+		free(key);
+
+		return true;
+	}
+
+	return false;
+}
+
+/* Check that a filter is valid by parsing it */
+static bool valid_filter(const char *filter, const char *remote_name)
+{
+	struct list_objects_filter_options filter_opts = LIST_OBJECTS_FILTER_INIT;
+	struct strbuf err = STRBUF_INIT;
+	int res = gently_parse_list_objects_filter(&filter_opts, filter, &err);
+
+	if (res)
+		warning(_("invalid filter '%s' for remote '%s' "
+			  "will not be stored: %s"),
+			filter, remote_name, err.buf);
+
+	list_objects_filter_release(&filter_opts);
+	strbuf_release(&err);
+
+	return !res;
+}
+
+/* Check that a token doesn't contain any control character */
+static bool valid_token(const char *token, const char *remote_name)
+{
+	const char *c = token;
+
+	for (; *c; c++)
+		if (iscntrl(*c)) {
+			warning(_("invalid token '%s' for remote '%s' "
+				  "will not be stored"),
+				token, remote_name);
+			return false;
+		}
+
+	return true;
+}
+
+struct store_info {
+	struct repository *repo;
+	struct string_list config_info;
+	bool store_filter;
+	bool store_token;
+};
+
+static struct store_info *store_info_new(struct repository *repo)
+{
+	struct string_list *fields_to_store = fields_stored();
+	struct store_info *s = xmalloc(sizeof(*s));
+
+	s->repo = repo;
+
+	string_list_init_nodup(&s->config_info);
+	promisor_config_info_list(repo, &s->config_info, fields_to_store);
+	string_list_sort(&s->config_info);
+
+	s->store_filter = !!string_list_lookup(fields_to_store, promisor_field_filter);
+	s->store_token = !!string_list_lookup(fields_to_store, promisor_field_token);
+
+	return s;
+}
+
+static void store_info_free(struct store_info *s)
+{
+	if (s) {
+		promisor_info_list_clear(&s->config_info);
+		free(s);
+	}
+}
+
+static bool promisor_store_advertised_fields(struct promisor_info *advertised,
+					     struct store_info *store_info)
+{
+	struct promisor_info *p;
+	struct string_list_item *item;
+	const char *remote_name = advertised->name;
+	bool reload_config = false;
+
+	if (!(store_info->store_filter || store_info->store_token))
+		return false;
+
+	/*
+	 * Get existing config info for the advertised promisor
+	 * remote. This ensures the remote is already configured on
+	 * the client side.
+	 */
+	item = string_list_lookup(&store_info->config_info, remote_name);
+
+	if (!item)
+		return false;
+
+	p = item->util;
+
+	if (store_info->store_filter && advertised->filter &&
+	    valid_filter(advertised->filter, remote_name))
+		reload_config |= store_one_field(store_info->repo, remote_name,
+						 "filter", promisor_field_filter,
+						 advertised->filter, p->filter);
+
+	if (store_info->store_token && advertised->token &&
+	    valid_token(advertised->token, remote_name))
+		reload_config |= store_one_field(store_info->repo, remote_name,
+						 "token", promisor_field_token,
+						 advertised->token, p->token);
+
+	return reload_config;
+}
+
 static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
@@ -700,7 +834,9 @@ static void filter_promisor_remote(struct repository *repo,
 	enum accept_promisor accept = ACCEPT_NONE;
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct store_info *store_info = NULL;
 	struct string_list_item *item;
+	bool reload_config = false;
 
 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -736,14 +872,24 @@ static void filter_promisor_remote(struct repository *repo,
 			string_list_sort(&config_info);
 		}
 
-		if (should_accept_remote(accept, advertised, &config_info))
+		if (should_accept_remote(accept, advertised, &config_info)) {
+			if (!store_info)
+				store_info = store_info_new(repo);
+			if (promisor_store_advertised_fields(advertised, store_info))
+				reload_config = true;
+
 			strvec_push(accepted, advertised->name);
+		}
 
 		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
 	string_list_clear(&remote_info, 0);
+	store_info_free(store_info);
+
+	if (reload_config)
+		repo_promisor_remote_reinit(repo);
 }
 
 char *promisor_remote_reply(const char *info)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 023735d6a8..6ef6431bd7 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -360,6 +360,69 @@ test_expect_success "clone with promisor.checkFields" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	git -C server remote add otherLop "https://invalid.invalid"  &&
+	git -C server config remote.otherLop.token "fooBar" &&
+	git -C server config remote.otherLop.stuff "baz" &&
+	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
+	test_when_finished "git -C server remote remove otherLop" &&
+
+	git -C server config remote.lop.token "fooXXX" &&
+	git -C server config remote.lop.partialCloneFilter "blob:limit=8k" &&
+
+	test_config -C server promisor.sendFields "partialCloneFilter, token" &&
+	test_when_finished "rm trace" &&
+
+	# Clone from server to create a client
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.token="fooYYY" \
+		-c remote.lop.partialCloneFilter="blob:none" \
+		-c promisor.acceptfromserver=All \
+		-c promisor.storeFields=partialcloneFilter \
+		--no-local --filter="blob:limit=5k" server client 2>err &&
+
+	# Check that the filter from the server is stored
+	echo "blob:limit=8k" >expected &&
+	git -C client config remote.lop.partialCloneFilter >actual &&
+	test_cmp expected actual &&
+
+	# Check that user is notified when the filter is stored
+	test_grep "Storing new filter from server for remote '\''lop'\''" err &&
+	test_grep "'\''blob:none'\'' -> '\''blob:limit=8k'\''" err &&
+
+	# Check that the token from the server is NOT stored
+	echo "fooYYY" >expected &&
+	git -C client config remote.lop.token >actual &&
+	test_cmp expected actual &&
+	test_grep ! "Storing new token from server" err &&
+
+	# Check that the filter for an unknown remote is NOT stored
+	test_must_fail git -C client config remote.otherLop.partialCloneFilter >actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Change the configuration on the server and fetch from the client
+	git -C server config remote.lop.partialCloneFilter "blob:limit=7k" &&
+	GIT_NO_LAZY_FETCH=0 git -C client fetch \
+		--filter="blob:limit=5k" ../server 2>err &&
+
+	# Check that the fetch updated the configuration on the client
+	echo "blob:limit=7k" >expected &&
+	git -C client config remote.lop.partialCloneFilter >actual &&
+	test_cmp expected actual &&
+
+	# Check that user is notified when the new filter is stored
+	test_grep "Storing new filter from server for remote '\''lop'\''" err &&
+	test_grep "'\''blob:limit=8k'\'' -> '\''blob:limit=7k'\''" err
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.53.0.77.g4627d513d6


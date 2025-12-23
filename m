Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24E32B9BD
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488299; cv=none; b=C5poHCKLgNOzlcBWdGreXI/Wbiu0DglowGU6LWBuqrG7fRmsm4JjuXXZ76zoyz6OLt3J0RhkB45GYH0V3vZmSHr4YPwGFegr2b1s5KzNY7L8LVQTreysMHcv+nBxj+vlpUmelqrAGltfQL6nZm4RHxtcKETBmti9XP4RXpH89IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488299; c=relaxed/simple;
	bh=eJkOUCL7ERD8LO5RD0PhRqs8IwV76eogRvlxho29HhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACX8eu9G/g11TRYhN7ci5UHzDG8UAEUIorZs1U8X7fL1Z+AsrLVD2XHsN2hmy2+UFtfFpuH9dbhdIqv4e3M/+JRkiK4+4rQJzA6V0v36QUD8KfCXK/rvVIegyzUjkBcDhJazynQX5l3cA3+qBhQVw8ceRAXp+gaChwRrnqs9o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyAQLnQ1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyAQLnQ1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47796a837c7so33469665e9.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488295; x=1767093095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHDCkOxUD9JBNKBB2Rd9Pqv5QcElN9yzYN3U+vZGxOY=;
        b=fyAQLnQ1RdMfI2WHJkTQ1m8yMk7nqpv+AJ/862+zwlTayT42HsRhmnMmtix0KTGk98
         OyeEIvWalywE03/IL8l54zFnuSIwy9FwJ+FidxnczT4U8BGKn0Dx0mUvZn2VppaO35iw
         OWMIewOLsKb1KbdKmCp7kBo/IMVh5HzIvobuEYtWulpAMmk64HZP+ZgVW4ZvrEU5P/kK
         5WB9igh9Yf2uRG9yT695yMjfVTTgKDi+ZRDnvktCHXVcYsmqSaq90YklunGrVwOScLxE
         s+kHaKCSBTGGmQfEmpdMZ2NnqmIFVJoKOxNloFuEQjOp0D7RilgKlwlixTYVOIJ+sY64
         zeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488295; x=1767093095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHDCkOxUD9JBNKBB2Rd9Pqv5QcElN9yzYN3U+vZGxOY=;
        b=KOF7zEvWsC3A+fIgOT9D4ULgYjyQfNAeARdoL0k2P0YwIXAm2fHzBzhWq8UZr2LK6P
         XzKQPGnpP0LkqSIik/5Z0YMlK8ngu46Q8rE/uaKAo8Oxe/ft43p5nc1VPPYGjQl5yvzX
         qAuS/rnlilfDbYe+wl301Qufffvm0bljHgGX1C16FM0ZJk4ijLbHJVQQw6lk3QlV5rCe
         V4Yr0fPb0nSJ6WyVnUxPboxvRRpXK+lP+AiEep/Fieqq3XMuC0ZtvGLxIMMUaucwt5zr
         95ibhI9YueVdab40KDPhcxFfkpPiIgJWXdtRNd6EbZDJkVCZp0dYkBMEvr81quVgbJso
         CpeA==
X-Gm-Message-State: AOJu0YyZYeD3KySbeObVq+MzIpO/Kli8kVp/qbBGdtiOKTiNXvo3+EzV
	q2jRmVO4lUjXgEUgcJoeGaJCecjaZ7euTF65f4DUFsLwYTh/ZALiUzhI4VU1mw==
X-Gm-Gg: AY/fxX45Hhl+ECFZ+i94c1Re0TmOkMlKIQnW0xI/vgHMzPFg786FgiO6L0ta+6mBvSz
	791IHm0C5n2r70Eth4GnCE+BXxjZEyaItV+ztjBH5lClVhF83V5dITuxm4Gn483n9AePqVfwL17
	mMaI2AnNGp1NdsSb+09avUTTvnpb3p7URBgoi66JvAF/IzwVNlg0ThTLJ2ntSF2c0FJcFYtLR+T
	IaCZGsaMhMEbgHCbPH3s4GIAANvf/xdBUuk4/Y7aahzoHMZJagGa9/hjGCU7Fg9+1h1qK8S7Z/4
	NbxK9ucjGFkwf3R7ilCZV7TG+LYP+Ozpewxk22mqFxfs+NmekhYBeVnKqXYzXgEk8KHLSkzDbcg
	Ip1uP8SJgPfpq6WXsKl67aJcHgR7ESSyVFK/E3FFazDjvSkcS3BsToIVzUFfGU74TtyByq+8Z8q
	lxeUSu30RMjyqf+BUanfrI0KlaNf8aDRvXvQ+1FGY4fajDfUP/Uff/2ORx7/CpmbEVgnBI3KbkG
	EYYDuVeEIuOEWR3yCYbKPAqJ/U=
X-Google-Smtp-Source: AGHT+IGQjn7SDiovyq8T3tZaeTc2ec8pbP80KL1y0K57gOrcpjVzIk7gMqRYERB5WNd/QTv0Y8WgJQ==
X-Received: by 2002:a05:600c:848c:b0:47b:d949:9b87 with SMTP id 5b1f17b1804b1-47d1954a485mr122554045e9.12.1766488294600;
        Tue, 23 Dec 2025 03:11:34 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:33 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] promisor-remote: allow a client to store fields
Date: Tue, 23 Dec 2025 12:11:06 +0100
Message-ID: <20251223111113.47473-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
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

In the same way, if it appears that it's better to use a different
filter to access a promisor remote, it could be helpful if the client
could automatically use it.

To allow this, let's introduce a new "promisor.storeFields"
configuration variable.

Like "promisor.checkFields" and "promisor.sendFields", it should
contain a comma or space separated list of field names. Only the
"partialCloneFilter" and "token" field names are supported for now.

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
 t/t5710-promisor-remote-capability.sh |  49 +++++++++
 4 files changed, 236 insertions(+), 6 deletions(-)

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
index 5d8151cedb..8d6d2d7b76 100644
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
+		repo_config_set_worktree_gently(repo, key, advertised);
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
+static struct store_info *new_store_info(struct repository *repo)
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
+static void free_store_info(struct store_info *s)
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
+				store_info = new_store_info(repo);
+			if (promisor_store_advertised_fields(advertised, store_info))
+				reload_config = true;
+
 			strvec_push(accepted, advertised->name);
+		}
 
 		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
 	string_list_clear(&remote_info, 0);
+	free_store_info(store_info);
+
+	if (reload_config)
+		repo_promisor_remote_reinit(repo);
 }
 
 char *promisor_remote_reply(const char *info)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 023735d6a8..a726af214a 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -360,6 +360,55 @@ test_expect_success "clone with promisor.checkFields" '
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
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
-- 
2.52.0.319.gfcaffa7898


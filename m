Received: from a3i227.smtp2go.com (a3i227.smtp2go.com [203.31.36.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36481192D8C
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.31.36.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440153; cv=none; b=F+Xg4Lw/tPcTEV5sSZz1yFb5vWIEHJzJXqrk3MA2K8YmxZ7VOfpGx4gjuB64NIUZh7w0y8RRvA5nBdn7+t0TygTdwzX6sDTS616VFteeKHMKE5wlNAhg4HOYj3kBCHBvMlwRJKoll1P1FMyVR/b4/cdCKm3ayE7yacn+ZmW0kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440153; c=relaxed/simple;
	bh=G5fVFP78FW6G1kbDl2B3sJS4z4zyioeVXkWOX145jKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpN1Ea0vZj8maaou7yaLzXuqHKNwWr+x0sFzDSvhKf7ofaKsPqytNs4WdwpyVFp//rJPTuHLCNT2tSw9rmrngyTsyvugWrbF0SapB3wY+2MqVWRiOWyetqcXngWAMcIaMW8k9Ve6k3vgUMXGzZ2abotQACOyytPWr/5itEGTxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me; spf=pass smtp.mailfrom=mail.kmatsui.me; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=GCtExP4Z; dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b=gS8sftcq; arc=none smtp.client-ip=203.31.36.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kmatsui.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.kmatsui.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="GCtExP4Z";
	dkim=pass (2048-bit key) header.d=kmatsui.me header.i=@kmatsui.me header.b="gS8sftcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1729440150; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=3m8h4Qf/2VvIaEqNqjVPN/1FITX+4K2RpCP7RpzWxcM=;
 b=GCtExP4ZjJwnGXB1tJ9w9ltp92ss5nTKBMCbIri7HOMf5IacOCbSHwiuuilFDxp3HQIQ9
 uwAjbxFFqye1ZIayT7NS7wOUQ3t/HCLP7FlZKpn0zZqzcFU+1Lu0sneGkQjbJe+Pj1+NFiQ
 V3LbchcRGs/IrBZPSp6GonQZD/HncVKDhkj3vzPwR4fi/9nB0+jikXaEAq1ygj1FfEKceLZ
 3iWpUc2E4Abpa2CC4H/E37Vb93f+ez0WxPRuH8tWkA14ug4ZGZqomSHoKToTdtuLrVf2Xzc
 l1CJKeORfZcZWd8RXY2XUt3xFTbiqgvajUKhO40qeD0XzRUsO3FzdOaEbBEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kmatsui.me;
 i=@kmatsui.me; q=dns/txt; s=s768575; t=1729440150; h=from : subject :
 to : message-id : date;
 bh=3m8h4Qf/2VvIaEqNqjVPN/1FITX+4K2RpCP7RpzWxcM=;
 b=gS8sftcqnPtlmtsxdTwmSupijCFciqOWAPQTF6OK3ybM9BRK7111gqovpJCyWimKRFmyU
 JGkw1mIeTqB6XXTivpTzJtIn6XNJEKFqLfoUnSGEaN1CFrmlqYzCbTMfIQRo2LOyH1uIqJP
 wIzsJEtOAErRKqAr8BVb462pZiylCflFlRM1yAFiNirGAlmG96c7n4GX6d9Q/9Y4+7OVOqn
 E4ziTEs5FEiFR2P86/aCflDb3LpwM45Dkb6Mih9yy41FG36w7FE5ZaJravg/1O+QrsJSrlM
 mzd2NPHq1tBPNSbn7yWQ1mbfw/zKQZRAd9XwcuUS8vHYkswhjARDbMKXDWSA==
Received: from [10.12.243.91] (helo=localhost.localdomain.com)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
	(Exim 4.97.1-S2G)
	(envelope-from <ken@kmatsui.me>)
	id 1t2YNv-FnQW0hPupZN-2iYA;
	Sun, 20 Oct 2024 16:02:27 +0000
From: Ken Matsui <ken@kmatsui.me>
To: git@vger.kernel.org
Cc: Ken Matsui <ken@kmatsui.me>,
	Matheus Tavares <matheus.tavb@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] config: support remote name in includeIf.hasconfig condition
Date: Sun, 20 Oct 2024 12:01:44 -0400
Message-ID: <20241020160143.92382-2-ken@kmatsui.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020152323.90543-1-ken@kmatsui.me>
References: <20241020152323.90543-1-ken@kmatsui.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 768575m:768575aMbf9Va:768575sazCkbE2Ql
X-smtpcorp-track: bQDdYGucp7r3.am3aX_UOyEej.Kahqag7_5lr

Changes in v2:

* Updated the description based on Kristoffer's review.

-- >8 --

includeIf.hasconfig only accepts remote.*.url, making it difficult to
apply configuration based on a specific remote, especially in projects
with multiple remotes (e.g., GitHub and non-GitHub hosting).  This often
leads to undesired application of multiple config files.

For example, the following configuration:

  [remote "origin"]
    url = https://git.kernel.org/pub/scm/git/git.git
  [remote "github"]
    url = https://github.com/myfork/git.git

  [includeIf "hasconfig:remote.*.url:https://github.com/**"]
    path = github.inc
  [includeIf "hasconfig:remote.*.url:https://git.kernel.org/**"]
    path = git.inc

would apply both github.inc and git.inc, even when only one config is
intended for the repository.

Introduce support for specifying a remote name (e.g., origin) to enable
more precise configuration management:

  [includeIf "hasconfig:remote.origin.url:https://github.com/**"]
    path = github.inc
  [includeIf "hasconfig:remote.origin.url:https://git.kernel.org/**"]
    path = git.inc

This ensures that only the intended config file is applied based on the
specific remote.

Signed-off-by: Ken Matsui <ken@kmatsui.me>
---
 Documentation/config.txt |  13 +++-
 config.c                 | 141 ++++++++++++++++++++++++++++++++++-----
 t/t1300-config.sh        |  28 ++++++++
 3 files changed, 163 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed807..22b50d523d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -161,14 +161,17 @@ all branches that begin with `foo/`. This is useful if your branches are
 organized hierarchically and you would like to apply a configuration to
 all the branches in that hierarchy.
 
-`hasconfig:remote.*.url:`::
+`hasconfig:remote.(<name>|*).url:`::
 	The data that follows this keyword is taken to
 	be a pattern with standard globbing wildcards and two
 	additional ones, `**/` and `/**`, that can match multiple
 	components. The first time this keyword is seen, the rest of
 	the config files will be scanned for remote URLs (without
 	applying any values). If there exists at least one remote URL
-	that matches this pattern, the include condition is met.
+	that matches this pattern, the include condition is met. `<name>`
+	is the name of the remote, and `*` matches any remote name. Note
+	that `<name>` is not globbed, so it must be an exact match (e.g.,
+	`dev-*` will not match `dev-foo`).
 +
 Files included by this option (directly or indirectly) are not allowed
 to contain remote URLs.
@@ -263,6 +266,12 @@ Example
 	path = foo.inc
 [remote "origin"]
 	url = https://example.com/git
+
+; include only if the given remote with the given URL exist.
+[includeIf "hasconfig:remote.origin.url:https://example.com/**"]
+	path = foo.inc
+[remote "origin"]
+	url = https://example.com/git
 ----
 
 Values
diff --git a/config.c b/config.c
index a11bb85da3..9de58eec7a 100644
--- a/config.c
+++ b/config.c
@@ -123,6 +123,37 @@ static long config_buf_ftell(struct config_source *conf)
 	return conf->u.buf.pos;
 }
 
+struct remote_urls_entry {
+	struct hashmap_entry ent;
+	char *name;
+	struct string_list urls;
+};
+
+static struct remote_urls_entry *remote_urls_find_entry(struct hashmap *remote_urls,
+							char *name)
+{
+	struct remote_urls_entry k;
+	struct remote_urls_entry *found_entry;
+
+	hashmap_entry_init(&k.ent, strhash(name));
+	k.name = name;
+	found_entry = hashmap_get_entry(remote_urls, &k, ent, NULL);
+	return found_entry;
+}
+
+static int remote_urls_entry_cmp(const void *cmp_data UNUSED,
+				 const struct hashmap_entry *eptr,
+				 const struct hashmap_entry *entry_or_key,
+				 const void *keydata UNUSED)
+{
+	const struct remote_urls_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct remote_urls_entry, ent);
+	e2 = container_of(entry_or_key, const struct remote_urls_entry, ent);
+
+	return strcmp(e1->name, e2->name);
+}
+
 struct config_include_data {
 	int depth;
 	config_fn_t fn;
@@ -132,9 +163,10 @@ struct config_include_data {
 	struct repository *repo;
 
 	/*
-	 * All remote URLs discovered when reading all config files.
+	 * All remote names & URLs discovered when reading all config files.
 	 */
-	struct string_list *remote_urls;
+	struct hashmap remote_urls;
+	int remote_urls_initialized;
 };
 #define CONFIG_INCLUDE_INIT { 0 }
 
@@ -328,16 +360,36 @@ static int include_by_branch(struct config_include_data *data,
 static int add_remote_url(const char *var, const char *value,
 			  const struct config_context *ctx UNUSED, void *data)
 {
-	struct string_list *remote_urls = data;
-	const char *remote_name;
+	struct hashmap *remote_urls = data;
+	const char *remote_section;
 	size_t remote_name_len;
 	const char *key;
 
-	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
+	if (!parse_config_key(var, "remote", &remote_section, &remote_name_len,
 			      &key) &&
-	    remote_name &&
-	    !strcmp(key, "url"))
-		string_list_append(remote_urls, value);
+	    remote_section &&
+	    !strcmp(key, "url")) {
+		const char *dot;
+		char *remote_name;
+		struct remote_urls_entry *e;
+
+		dot = strchr(remote_section, '.');
+		if (!dot)
+			return 0;
+
+		remote_name = xstrndup(remote_section, dot - remote_section);
+		e = remote_urls_find_entry(remote_urls, remote_name);
+		if (!e) {
+			e = xmalloc(sizeof(*e));
+			hashmap_entry_init(&e->ent, strhash(remote_name));
+			e->name = remote_name;
+			string_list_init_dup(&e->urls);
+			string_list_append(&e->urls, value);
+			hashmap_add(remote_urls, &e->ent);
+		} else {
+			string_list_append(&e->urls, value);
+		}
+	}
 	return 0;
 }
 
@@ -348,9 +400,9 @@ static void populate_remote_urls(struct config_include_data *inc)
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
-	string_list_init_dup(inc->remote_urls);
-	config_with_options(add_remote_url, inc->remote_urls,
+	hashmap_init(&inc->remote_urls, remote_urls_entry_cmp, NULL, 0);
+	inc->remote_urls_initialized = 1;
+	config_with_options(add_remote_url, &inc->remote_urls,
 			    inc->config_source, inc->repo, &opts);
 }
 
@@ -391,12 +443,35 @@ static int at_least_one_url_matches_glob(const char *glob, int glob_len,
 static int include_by_remote_url(struct config_include_data *inc,
 		const char *cond, size_t cond_len)
 {
+	struct hashmap_iter iter;
+	struct remote_urls_entry *remote;
+
+	if (inc->opts->unconditional_remote_url)
+		return 1;
+	if (!inc->remote_urls_initialized)
+		populate_remote_urls(inc);
+
+	hashmap_for_each_entry(&inc->remote_urls, &iter, remote, ent)
+		if (at_least_one_url_matches_glob(cond, cond_len, &remote->urls))
+			return 1;
+	return 0;
+}
+
+static int include_by_remote_name_and_url(struct config_include_data *inc,
+					  const char *cond, size_t cond_len,
+					  char *remote_name)
+{
+	struct remote_urls_entry *e;
+
 	if (inc->opts->unconditional_remote_url)
 		return 1;
-	if (!inc->remote_urls)
+	if (!inc->remote_urls_initialized)
 		populate_remote_urls(inc);
-	return at_least_one_url_matches_glob(cond, cond_len,
-					     inc->remote_urls);
+
+	e = remote_urls_find_entry(&inc->remote_urls, remote_name);
+	if (!e)
+		return 0;
+	return at_least_one_url_matches_glob(cond, cond_len, &e->urls);
 }
 
 static int include_condition_is_true(const struct key_value_info *kvi,
@@ -414,6 +489,32 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.", &cond,
+				 &cond_len)) {
+		const char *dot;
+		char *remote_name;
+		char *cond_prefix;
+		int ret;
+
+		dot = strchr(cond, '.');
+		if (!dot)
+			return 0;
+
+		remote_name = xstrndup(cond, dot - cond);
+		cond_prefix = xstrfmt("%s.url:", remote_name);
+		if (!skip_prefix_mem(cond, cond_len, cond_prefix, &cond,
+				     &cond_len)) {
+			free(cond_prefix);
+			free(remote_name);
+			return 0;
+		}
+		free(cond_prefix);
+
+		ret = include_by_remote_name_and_url(inc, cond, cond_len,
+						     remote_name);
+		free(remote_name);
+		return ret;
+	}
 
 	/* unknown conditionals are always false */
 	return 0;
@@ -2151,9 +2252,15 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = do_git_config_sequence(opts, repo, fn, data);
 	}
 
-	if (inc.remote_urls) {
-		string_list_clear(inc.remote_urls, 0);
-		FREE_AND_NULL(inc.remote_urls);
+	if (inc.remote_urls_initialized) {
+		struct hashmap_iter iter;
+		struct remote_urls_entry *remote;
+		hashmap_for_each_entry(&inc.remote_urls, &iter, remote, ent) {
+			string_list_clear(&remote->urls, 0);
+			free(remote->name);
+		}
+		hashmap_clear_and_free(&inc.remote_urls, struct remote_urls_entry, ent);
+		inc.remote_urls_initialized = 0;
 	}
 	return ret;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f13277c8f3..b04908b6ed 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2831,6 +2831,34 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
 '
 
+test_expect_success 'includeIf.hasconfig:remote.<name>.url' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-this <<-\EOF &&
+	[user]
+		this = this-is-included
+	EOF
+	cat >dont-include-that <<-\EOF &&
+	[user]
+		that = that-is-not-included
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[includeIf "hasconfig:remote.foo.url:sameurl"]
+		path = "$(pwd)/include-this"
+	[includeIf "hasconfig:remote.bar.url:sameurl"]
+		path = "$(pwd)/dont-include-that"
+	[remote "foo"]
+		url = sameurl
+	EOF
+
+	echo this-is-included >expect-this &&
+	git -C hasremoteurlTest config --get user.this >actual-this &&
+	test_cmp expect-this actual-this &&
+
+	test_must_fail git -C hasremoteurlTest config --get user.that
+'
+
 test_expect_success 'negated mode causes failure' '
 	test_must_fail git config --no-get 2>err &&
 	grep "unknown option \`no-get${SQ}" err
-- 
2.47.0


Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5663B8BD4
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293693; cv=none; b=ei640xd4eJLm6sU8kVXYRnMJriTectYPPA/VRO3WbpFy2eMortqQ9ed0cvAX/nByV7c11j6ChZ5KMEMd4bgvOpxMG8xKNAfq0iXGxXK6uTSqeHQ2RWwD8KUkR1WfyhPJB7SA1tM7r9F86jeGBbOyuTrRGWNPw5NILXN7SIqeNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293693; c=relaxed/simple;
	bh=ckZUxJ6A2PvMAgwrpW+hidzpRrzT94LfL9co0E2zl9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU/i0i8TfMsmdZzFr9D4tVV93WI2oiprCn7JX3QqsTVPY9ePbStqFuBugfneoeN4p2fKXmESSXTAnw7se9Zhb7v7sQ0o2ahTFJqRUh5FymDaSfQ/ICbVD94B99anOcB/LH6v75XMZ1kJ5z/tN/hZYrQreJBkMeTV0Is3SlczB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkajoPSf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkajoPSf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1179257066b.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293688; x=1777898488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR/+7hY+Oukg1YrfNfxlXx51EQz+B+CRwUztYYiFpSE=;
        b=kkajoPSfuYeGf7WpAu7nyAsx2jofWMXNgeUrdsRRx0LILTNp3YOpc7OEwA/F/eGHWn
         /mabmyTIbRjGyiPcWfwfRYTpa71qpmgsS80hB2qLZ/ivckmsfgiW7Pmp3mQUMmpB5IDN
         CPKPfhQUbyw1VdMtILOP7S+lUE3SoiUyXiWn6W/hzBqAFdnIDcdtBtP9okzh/B/XbGBh
         zRTrMblp6vGfcjPyGz85ZZL9dK2ZFDXN7CNCbI1tb1pR9etqWVq0mFm6vkr1XesSM4ZW
         wswI9NzuwatYGQwqaJhiAfkB8/QfI8T8j4y9pbqBei5ZRVE+ut0DNM4/WpjBqpA7YkR/
         Quwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293688; x=1777898488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zR/+7hY+Oukg1YrfNfxlXx51EQz+B+CRwUztYYiFpSE=;
        b=czVO7fZnyL+GeUBn/Ucf2gkDPN8lCU5m0Lb6D8xN74ViD1zVNWtEoNnatQ9aB/9w2w
         rBkMnxT8BESOMGNEzEtJj7sMpEJ71tXcKim1Hft4bwPR/jN02xShOedKod+r7gWv7YHJ
         oFUdrEjVNM+rkRHzKl6hqxJV6zJTmSDyLj850bkMyLbMGOm1ayE8RXj1WBZ/Kd7Fb2J3
         TiJK8m2cktE06o1uNXRwSN9wZa7wkPpu4OYqV9im1IPjwkT+DW3CwEAM7h0WVLxXQwpt
         05Rz0J5qf/OLZmoliDOF81xG23GolK5ncFxF5A+Yr/fHrCqfZnZaGEM7Om584L0kyQZo
         ywtA==
X-Gm-Message-State: AOJu0YwzBMmo4OoGEdtiP2h+ARm74eb4xJHEGb1MBDL6eyG91e4Ld6ID
	J3pWCScvIap/qwsg1KJsJFU8Cz/M2J6o2Y9DMZbeP6pXi5GQtxemm09NVtn4zg==
X-Gm-Gg: AeBDiev7HZBnVKqtZTNkq8NttmHImnIfy67y/ZpG7nS9ff9e61nWooET+WIyEau+Ofi
	ZyoKjuYwxPY6X/rf1B+xVMRZIc31H3WL+LhnoRRpQLHNwBOexOoPxb2pQbxOYUyrEChGQeKfSGI
	9aLuCPHBkclvzarY5lAs6MIu4LjkVEzniOG+gcs93g/zy6TioixETbIWyH0H6ecN44SXOAj6/CF
	S76Ev5FLYYbPKRR7KzjLbNm9+H+YHXLThQBB3Ab4/H+SFOymHYQiwH/9kOzm/pij0NTasO6QjOB
	gNpx/dMOT1VzZ0PzYxmqLiDLPCYd0uhMamjY1rnEnbevvQHLFOJ/5T181vRq/lA/t7ceVh5IPUA
	YnwjFS2MohFIya/d0jwAeHv69LaiZmfTzIRZ3Ny+RvIHjmwDfjrP43nhYtCepybll4wC/3xH+qo
	+sYVZCsmr01/WPBKxK4sZei8fPN4pZYKrayA8lLDIlHVBqMjPfKcprEJgXLjzdyKRs+StbAODPO
	mrrNIPAZnc6OUJXldU9C8ku3rVDA5LoqU+536TOjL9rGBJGVw==
X-Received: by 2002:a17:907:72d4:b0:bae:9df4:d9e6 with SMTP id a640c23a62f3a-bae9df4da32mr446357066b.30.1777293686785;
        Mon, 27 Apr 2026 05:41:26 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:25 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/8] Auto-configure advertised remotes via URL allowlist
Date: Mon, 27 Apr 2026 14:41:00 +0200
Message-ID: <20260427124108.3524129-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "promisor-remote" protocol capability allows a server
to advertise promisor remotes (and their tokens/filters), but the
client's `promisor.acceptFromServer` mechanism requires these remotes
to already exist in the config.

This is a significant burden for users and administrators who have to
pre-configure remotes.

This patch series improves on this by introducing a new
`promisor.acceptFromServerUrl` config option, which provides an
additive, URL-based security allowlist.

Multiple `promisor.acceptFromServerUrl` config options can be provided
in different config files. Each one should contain a URL glob pattern
which can optionally be prefixed with a remote name in the
"[<name>=]<pattern>" format.

The goal is for something like a simple:

  git config set --global promisor.acceptFromServerUrl "https://my-org.com/*"

to be all that is needed for internal work in many organizations. 

With this new config option:

 - The server can update fields (like tokens) for known remotes,
   provided their URL matches the allowlist, even if
   `acceptFromServer` is set to `None`.

 - Unknown remotes advertised by the server can be automatically
   configured on the client if their URL matches the allowlist.

 - If there is no `<name>` prefix before the glob pattern matched, the
   auto-configured remote is named using the
   "promisor-auto-<sanitized-url>" format. So the same auto-configured
   remote config entry will be reused for the same URL.

 - If a `<name>` prefix is provided, it will be used for the
   auto-configured remote config entry.

 - If the chosen name (auto-generated or prefixed) already exists but
   points to a different URL, overwriting the existing config is
   prevented by appending a numeric suffix (e.g., -1, -2) to the name
   and auto-configuring using that name.

 - The server's originally advertised name is always saved in the
   `remote.<name>.advertisedAs` config variable of the auto-configured
   remote for tracing and debugging.

Security considerations:

 - Advertised URLs and glob patterns are routed through
   url_normalize() / url_normalize_pattern() before matching, to
   prevent percent-encoding, case variation, or path-traversal (..)
   bypasses.

 - URL matching is done component by component: scheme and port
   must match exactly (no wildcards), the host is matched with
   WM_PATHNAME so a '*' cannot cross the '/' boundary into the
   path, and the path is matched without WM_PATHNAME so '*' can
   still span multi-level paths.

 - Auto-generated remote names are sanitized (non-alphanumeric
   characters are replaced with '-', runs of '-' are collapsed)
   and prefixed with 'promisor-auto-'. User-supplied names (from
   the 'name=<pattern>' syntax) are validated with
   valid_remote_name(). Together, these prevent a server from
   maliciously overwriting standard remotes (like 'origin').

 - If the auto-generated or user-supplied name collides with an
   existing remote configured to a different URL, a numeric
   suffix ('-1', '-2', ...) is appended, up to a bounded limit,
   so a server cannot hijack an existing remote by name.

 - Known remotes are still subject to URL consistency checks:
   even if an advertised URL matches the allowlist, it is only
   accepted for a known remote if it matches the URL already
   configured locally for that remote.

 - The documentation explains in detail how to write secure glob
   patterns in `promisor.acceptFromServerUrl`, and highlights the
   risks of overly broad patterns on shared hosting platforms.

High level description of the patches
=====================================

 - Patch 1/8 is new. It is a very small preparatory patch that
   simplifies some tests a bit.

 - Patches 2/8 and 3/8 expose and adapt a url_normalize_pattern()
   helper function in the urlmatch API.

 - Patch 4/8 adapts `struct promisor_info` by adding a new
   `local_name` member to it to prepare for the next patches.

 - Patches 5/8 to 7/8 implement the core feature. They introduce the
   parsing machinery, add the additive allowlist for known remotes
   (with url_normalize() security), and finally implement the
   auto-creation and collision resolution for unknown remotes.

 - Patch 8/8 cleans up and modernizes the existing
   `promisor.acceptFromServer` documentation.

Changes compared to v1
======================

Thanks to Patrick and Junio for reviewing the previous versions of
this series and of the preparatory series.

 - A lot of preparatory patches have been moved to a preparatory series
   that has already been merged. See:

   https://lore.kernel.org/git/20260407115243.358642-1-christian.couder@gmail.com/

   This is why this v2 contains only 8 patches compared to 16 patches
   in v1.

 - Everywhere in this series "whitelist" as been replaced with
   "allowlist".

 - In the tests added in this series, the new $TRASH_DIRECTORY_URL and
   $ENCODED_TRASH_DIRECTORY_URL introduced by the preparatory series
   are used instead of the previous $PWD_URL and $ENCODED_PWD_URL.

 - Patch 1/8 ("t5710: simplify 'mkdir X' followed by 'git -C X init'")
   is new.

 - Patch 3/8 ("urlmatch: add url_normalize_pattern() helper") replaces
   patch 3/16 ("urlmatch: add url_is_valid_pattern() helper") because
   in subsequent patches we now normalize patterns to validate them
   and match them component by component against URLs.

 - In patch 5/8, previously 13/16, ("promisor-remote: introduce
   promisor.acceptFromServerUrl"):

   - We add a `struct url_info pattern_info;` to `struct allowed_url`,
     so we can validate patterns using url_normalize_pattern() and, in
     a subsequent patch, match URLs component by component. This
     requires a new allowed_url_free() function that is passed to
     string_list_clear_func() to clear the `struct allowed_url`
     instances.

   - We don't use a `static struct string_list` to store the URL
     patterns we accept. Instead we load them from the config into a
     `struct string_list` passed as argument. The function doing this
     is renamed accordingly from accept_from_server_url() to
     load_accept_from_server_url().

   - A "clone with invalid promisor.acceptFromServerUrl" test is moved
     from patch 15/16 to this patch as it's more relevant in this
     patch (where we validate the content of the
     `promisor.acceptFromServerUrl` environment variable).

 - In patch 6/8, previously 14/16, ("promisor-remote: trust known
   remotes matching acceptFromServerUrl"):

   - In the commit message, an example, which shows how the new
     "acceptFromServerUrl" config option can be useful, is added.

   - The matching of URLs advertised by the server to URLs patterns
     from the config, is now performed component by component. This is
     reflected in the commit message, the documentation and the
     code. This ensures a `*` in the host pattern cannot cross into
     the path.

   - In the code, we add a new match_one_url() function to perform the
     matching.

 - In patch 7/8, previously 15/16 ("promisor-remote: auto-configure
   unknown remotes"):

   - In the doc, the unclear "considered trusted by the client" is
     clarified using "a client is allowed to act on" and subsequent
     explanations. In general the doc is also improved a bit. 

   - In the tests, parsing the "remote.<name>.advertisedAs" config
     option is now more careful about the possibility that more than
     one such options exist.

   - The test that was moved to patch 5/8 is still enhanced a bit in
     this commit by checking that no "remote.<name>.advertisedAs"
     config option has been added.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/24992478331

Range diff since v1
===================

 1:  b2894eb33a <  -:  ---------- promisor-remote: try accepted remotes before others in get_direct()
 -:  ---------- >  1:  44e9a16455 t5710: simplify 'mkdir X' followed by 'git -C X init'
 2:  a3206a6ae9 =  2:  42f174910c urlmatch: change 'allow_globs' arg to bool
 3:  51bbf65c52 <  -:  ---------- urlmatch: add url_is_valid_pattern() helper
 4:  f367beef72 <  -:  ---------- promisor-remote: clarify that a remote is ignored
 5:  1faf74cb3f <  -:  ---------- promisor-remote: refactor has_control_char()
 6:  40cf0af639 <  -:  ---------- promisor-remote: refactor accept_from_server()
 7:  b75dca8037 <  -:  ---------- promisor-remote: keep accepted promisor_info structs alive
 8:  f5e55dc407 <  -:  ---------- promisor-remote: remove the 'accepted' strvec
 -:  ---------- >  3:  8088374458 urlmatch: add url_normalize_pattern() helper
 9:  63c1db30de !  4:  6bfda89a79 promisor-remote: add 'local_name' to 'struct promisor_info'
    @@ Commit message
         In a following commit, we will store promisor remote information under
         a remote name different than the one the server advertised.
     
    -    To prepare for this change, let's add a new 'char* local_name' member
    +    To prepare for this change, let's add a new 'char *local_name' member
         to 'struct promisor_info', and let's update the related functions.
     
         While at it, let's also add a small promisor_info_internal_name()
    @@ Commit message
     
      ## promisor-remote.c ##
     @@ promisor-remote.c: static struct string_list *fields_stored(void)
    - 
    - /*
       * Struct for promisor remotes involved in the "promisor-remote"
    -- * protocol capability.
    -+ * protocol capability:
    +  * protocol capability.
       *
     - * Except for "name", each <member> in this struct and its <value>
     - * should correspond (either on the client side or on the server side)
     - * to a "remote.<name>.<member>" config variable set to <value> where
     - * "<name>" is a promisor remote name.
    -+ * - "name" is the name the server advertised.
    -+ * - "local_name" is the name we use locally (may be auto-generated).
    -+ *
     + * Except for "name" and "local_name", each <member> in this struct
     + * and its <value> should correspond (either on the client side or on
     + * the server side) to a "remote.<name>.<member>" config variable set
     + * to <value> where "<name>" is a promisor remote name.
       */
      struct promisor_info {
    - 	const char *name;
    -+	const char *local_name;
    +-	const char *name;
    ++	const char *name;	/* name the server advertised */
    ++	const char *local_name;	/* name used locally (may be auto-generated) */
      	const char *url;
      	const char *filter;
      	const char *token;
10:  e9b8a64ab8 <  -:  ---------- promisor-remote: pass config entry to all_fields_match() directly
11:  2e1260190a <  -:  ---------- promisor-remote: refactor should_accept_remote() control flow
12:  b33f06173a <  -:  ---------- t5710: use proper file:// URIs for absolute paths
13:  681b03e248 !  5:  fefa17e6dd promisor-remote: introduce promisor.acceptFromServerUrl
    @@ promisor-remote.c: static bool has_control_char(const char *s)
     +struct allowed_url {
     +	char *remote_name;
     +	char *url_pattern;
    ++	struct url_info pattern_info;
     +};
     +
    ++static void allowed_url_free(void *util, const char *str UNUSED)
    ++{
    ++	struct allowed_url *allowed = util;
    ++
    ++	if (!allowed)
    ++		return;
    ++
    ++	/* Depending on prefix, free either remote_name or url_pattern */
    ++	free(allowed->remote_name ? allowed->remote_name : allowed->url_pattern);
    ++	free(allowed->pattern_info.url);
    ++	free(allowed);
    ++}
    ++
     +static struct allowed_url *valid_accept_url(const char *url)
     +{
     +	char *dup, *p;
    @@ promisor-remote.c: static bool has_control_char(const char *s)
     +		p = dup;
     +	}
     +
    -+	if (has_control_char(p) || !url_is_valid_pattern(p)) {
    ++	if (has_control_char(p)) {
     +		warning(_("invalid url pattern '%s' "
     +			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
     +		free(dup);
    @@ promisor-remote.c: static bool has_control_char(const char *s)
     +	allowed = xmalloc(sizeof(*allowed));
     +	allowed->remote_name = (p == dup) ? NULL : dup;
     +	allowed->url_pattern = p;
    ++	allowed->pattern_info.url = url_normalize_pattern(p, &allowed->pattern_info);
    ++	if (!allowed->pattern_info.url) {
    ++		warning(_("invalid url pattern '%s' "
    ++			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
    ++		free(dup);
    ++		free(allowed);
    ++		return NULL;
    ++	}
     +
     +	return allowed;
     +}
     +
    -+static struct string_list *accept_from_server_url(struct repository *repo)
    ++static void load_accept_from_server_url(struct repository *repo,
    ++					struct string_list *accept_urls)
     +{
    -+	static struct string_list accept_urls = STRING_LIST_INIT_DUP;
    -+	static int initialized;
     +	const struct string_list *config_urls;
     +
    -+	if (initialized)
    -+		return &accept_urls;
    -+
    -+	initialized = 1;
    -+
     +	if (!repo_config_get_string_multi(repo, "promisor.acceptfromserverurl", &config_urls)) {
     +		struct string_list_item *item;
     +
    @@ promisor-remote.c: static bool has_control_char(const char *s)
     +			struct allowed_url *allowed = valid_accept_url(item->string);
     +			if (allowed) {
     +				struct string_list_item *new;
    -+				new = string_list_append(&accept_urls, item->string);
    ++				new = string_list_append(accept_urls, item->string);
     +				new->util = allowed;
     +			}
     +		}
     +	}
    -+
    -+	return &accept_urls;
     +}
     +
      static int should_accept_remote(enum accept_promisor accept,
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	struct string_list_item *item;
      	bool reload_config = false;
      	enum accept_promisor accept = accept_from_server(repo);
    -+	/* Pre-load and validate the acceptFromServerUrl config */
    -+	(void)accept_from_server_url(repo);
    ++	struct string_list accept_urls = STRING_LIST_INIT_DUP;
    ++
    ++	/* Load and validate the acceptFromServerUrl config */
    ++	load_accept_from_server_url(repo, &accept_urls);
      
      	if (accept == ACCEPT_NONE)
      		return;
    +@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    + 		}
    + 	}
    + 
    ++	string_list_clear_func(&accept_urls, allowed_url_free);
    + 	promisor_info_list_clear(&config_info);
    + 	string_list_clear(&remote_info, 0);
    + 	store_info_free(store_info);
    +
    + ## t/t5710-promisor-remote-capability.sh ##
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
    + 	check_missing_objects server 1 "$oid"
    + '
    + 
    ++test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
    ++	git -C server config promisor.advertise true &&
    ++	test_when_finished "rm -rf client" &&
    ++
    ++	# As "bad name" contains a space, which is not a valid remote name,
    ++	# the pattern should be rejected with a warning and no remote created.
    ++	GIT_NO_LAZY_FETCH=0 git clone \
    ++		-c promisor.acceptfromserver=None \
    ++		-c "promisor.acceptFromServerUrl=bad name=https://example.com/*" \
    ++		--no-local --filter="blob:limit=5k" server client 2>err &&
    ++
    ++	# Check that a warning was emitted
    ++	test_grep "invalid remote name '\''bad name'\''" err &&
    ++
    ++	# Check that the largest object is not missing on the server
    ++	check_missing_objects server 0 "" &&
    ++
    ++	# Reinitialize server so that the largest object is missing again
    ++	initialize_server 1 "$oid"
    ++'
    ++
    + test_expect_success "clone with promisor.sendFields" '
    + 	git -C server config promisor.advertise true &&
    + 	test_when_finished "rm -rf client" &&
14:  8c04e48d66 !  6:  2f238d0a7a promisor-remote: trust known remotes matching acceptFromServerUrl
    @@ Commit message
     
         To enable such targeted updates for trusted URLs, let's use the URL
         patterns from `promisor.acceptFromServerUrl` as an additional URL
    -    based whitelist.
    +    based allowlist.
     
         Concretely, let's check the advertised URLs against the URL glob
         patterns by introducing a new small helper function called
         url_matches_accept_list(), which iterates over the glob patterns and
         returns the first matching allowed_url entry (or NULL).
     
    -    (Before matching, the advertised URL is passed through url_normalize()
    -    so that case variations in the scheme/host, percent-encoding tricks,
    -    and ".." path segments cannot bypass the whitelist.)
    +    The URL matching is done component by component: scheme and port are
    +    compared exactly, the host is matched with wildmatch() using the
    +    WM_PATHNAME flag (so '*' cannot cross the '/' boundary into the path),
    +    and the path is matched with wildmatch() without WM_PATHNAME (so '*'
    +    can still match multi-level paths). Before matching, the advertised
    +    URL is passed through url_normalize() so that case variations in the
    +    scheme/host, percent-encoding tricks, and ".." path segments cannot
    +    bypass the allowlist.
     
         Let's then use this helper at the tail of should_accept_remote() so
         that, when `accept == ACCEPT_NONE`, a known remote whose URL matches
    -    the whitelist is still accepted.
    +    the allowlist is still accepted.
     
         To prepare for this new logic, let's also:
     
    @@ Commit message
            and relax its early return so that the function is entered when
            `accept_urls` has entries even if `accept == ACCEPT_NONE`.
     
    +    With this, many organizations may only need something like:
    +
    +      git config set --global \
    +              promisor.acceptFromServerUrl "https://my-org.com/*"
    +
    +    to accept only their own remotes. And if they need to accept additional
    +    remotes in some specific repos, they can also set:
    +
    +      git config set promisor.acceptFromServer knownUrl
    +
    +    and configure the additional remote manually only in the repos where
    +    they are needed.
    +
         Let's then properly document `promisor.acceptFromServerUrl` in
    -    "promisor.adoc" as an additive security whitelist for known remotes,
    -    including the URL normalization behavior, and let's mention it in
    -    "gitprotocol-v2.adoc".
    +    "promisor.adoc" as an additive security allowlist for known remotes,
    +    including the URL normalization behavior and the component-wise
    +    matching, and let's mention it in "gitprotocol-v2.adoc".
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
      	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
      
     +promisor.acceptFromServerUrl::
    -+	A glob pattern to specify which URLs advertised by a server
    -+	are considered trusted by the client. This option acts as an
    -+	additive security whitelist that works in conjunction with
    -+	`promisor.acceptFromServer`.
    ++	A glob pattern to specify which server-advertised URLs a
    ++	client is allowed to act on. When a URL matches, the client
    ++	will accept the advertised remote as a promisor remote and may
    ++	automatically accept field updates (such as authentication
    ++	tokens) from the server, even if `promisor.acceptFromServer`
    ++	is set to `none` (the default).
     ++
     +This option can appear multiple times in config files. An advertised
     +URL will be accepted if it matches _ANY_ glob pattern specified by
     +this option in _ANY_ config file read by Git.
     ++
    -+Be _VERY_ careful with these glob patterns, as it can be a big
    -+security hole to allow any advertised remote to be auto-configured!
    ++Be _VERY_ careful with these patterns: `*` matches any sequence of
    ++characters within the 'host' and 'path' parts of a URL (but cannot
    ++cross part boundaries). An overly broad pattern is a major security
    ++risk, as a matching URL allows a server to update fields (such as
    ++authentication tokens) on known remotes without further confirmation.
     +To minimize security risks, follow these guidelines:
     ++
     +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +   your specific organization or namespace (e.g.,
     +   `https://gitlab.com/your-org/*`).
     ++
    -+3. Don't use globs (`*`) in the domain name. For example
    -+   `https://cdn.example.com/*` is much safer than
    -+   `https://*.example.com/*`, because the latter matches
    -+   `https://evil-hacker.net/fake.example.com/repo`.
    ++3. Never use globs at the end of domain names. For example,
    ++   `https://cdn.your-org.com/*` might be safe, but
    ++   `https://cdn.your-org.com*/*` is a major security risk because
    ++   the latter matches `https://cdn.your-org.com.hacker.net/repo`.
     ++
    -+4. Make sure to have a `/` at the end of the domain name (or the end
    -+   of specific directories). For example `https://cdn.example.com/*`
    -+   is much safer than `https://cdn.example.com*`, because the latter
    -+   matches `https://cdn.example.com.hacker.net/repo`.
    ++4. Be careful using globs at the beginning of domain names. While the
    ++   code ensures a `*` in the host cannot cross into the path, a
    ++   pattern like `https://*.example.com/*` will still match any
    ++   subdomain. This is extremely dangerous on shared hosting platforms
    ++   (e.g., `https://*.github.io/*` trusts every user's site on the
    ++   entire platform).
     ++
    -+Before matching, the advertised URL is normalized: the scheme and
    -+host are lowercased, percent-encoded characters are decoded where
    -+possible, and path segments like `..` are resolved.  Glob patterns
    -+are matched against this normalized URL as-is, so patterns should
    -+be written in normalized form (e.g., lowercase scheme and host).
    ++Before matching, both the advertised URL and the pattern are
    ++normalized: the scheme and host are lowercased, percent-encoded
    ++characters are decoded where possible, and path segments like `..`
    ++are resolved. The port must also match exactly (e.g.,
    ++`https://example.com:8080/*` will not match a URL advertised on
    ++port 9999).
     ++
    -+Even if `promisor.acceptFromServer` is set to `None` (the default),
    -+Git will still accept field updates (like tokens) for known remotes,
    -+provided their URLs match a pattern in
    -+`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
    -+details on the protocol.
    ++For the security implications of accepting a promisor remote, see the
    ++documentation of `promisor.acceptFromServer`. For details on the
    ++protocol, see linkgit:gitprotocol-v2[5].
     +
      promisor.checkFields::
      	A comma or space separated list of additional remote related
    @@ promisor-remote.c
      
      struct promisor_remote_config {
      	struct promisor_remote *promisors;
    -@@ promisor-remote.c: static struct string_list *accept_from_server_url(struct repository *repo)
    - 	return &accept_urls;
    +@@ promisor-remote.c: static void load_accept_from_server_url(struct repository *repo,
    + 	}
      }
      
    ++static bool match_one_url(const struct url_info *pi, const struct url_info *ui)
    ++{
    ++	const char *pat = pi->url;
    ++	const char *url = ui->url;
    ++	char *p_str, *u_str;
    ++	bool res;
    ++
    ++	/*
    ++	 * Schemes must match exactly. They are case-folded by
    ++	 * url_normalize(), so strncmp() suffices.
    ++	 */
    ++	if (pi->scheme_len != ui->scheme_len || strncmp(pat, url, pi->scheme_len))
    ++		return false;
    ++
    ++	/*
    ++	 * Ports must match exactly. url_normalize() strips default
    ++	 * ports (like 443 for https), so length and content
    ++	 * comparisons are sufficient.
    ++	 */
    ++	if (pi->port_len != ui->port_len ||
    ++	    strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len))
    ++		return false;
    ++
    ++	/*
    ++	 * Match host and path separately to prevent a '*' in the host
    ++	 * portion of the pattern from matching across the '/'
    ++	 * boundary into the path. Use WM_PATHNAME for the host so '*'
    ++	 * cannot cross '/' there, and 0 for the path so '*' can still
    ++	 * match multi-level paths.
    ++	 */
    ++
    ++	p_str = xstrndup(pat + pi->host_off, pi->host_len);
    ++	u_str = xstrndup(url + ui->host_off, ui->host_len);
    ++	res = !wildmatch(p_str, u_str, WM_PATHNAME);
    ++	free(p_str);
    ++	free(u_str);
    ++
    ++	if (!res)
    ++		return false;
    ++
    ++	p_str = xstrndup(pat + pi->path_off, pi->path_len);
    ++	u_str = xstrndup(url + ui->path_off, ui->path_len);
    ++	res = !wildmatch(p_str, u_str, 0);
    ++	free(p_str);
    ++	free(u_str);
    ++
    ++	return res;
    ++}
    ++
     +static struct allowed_url *url_matches_accept_list(
     +		struct string_list *accept_urls, const char *url)
     +{
     +	struct string_list_item *item;
    -+	char *normalized = url_normalize(url, NULL);
    ++	struct url_info url_info;
    ++
    ++	url_info.url = url_normalize(url, &url_info);
     +
    -+	if (!normalized)
    ++	if (!url_info.url)
     +		return NULL;
     +
     +	for_each_string_list_item(item, accept_urls) {
     +		struct allowed_url *allowed = item->util;
     +
    -+		if (!wildmatch(allowed->url_pattern, normalized, 0)) {
    -+			free(normalized);
    ++		if (match_one_url(&allowed->pattern_info, &url_info)) {
    ++			free(url_info.url);
     +			return allowed;
     +		}
     +	}
     +
    -+	free(normalized);
    ++	free(url_info.url);
     +	return NULL;
     +}
     +
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +	/*
     +	 * Even if accept == ACCEPT_NONE, we MUST trust this known
     +	 * remote to update its token or other such fields if its URL
    -+	 * matches the acceptFromServerUrl whitelist!
    ++	 * matches the acceptFromServerUrl allowlist!
     +	 */
     +	if (url_matches_accept_list(accept_urls, remote_url))
     +		return all_fields_match(advertised, config_info, p);
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    - 	struct string_list_item *item;
    - 	bool reload_config = false;
    - 	enum accept_promisor accept = accept_from_server(repo);
    --	/* Pre-load and validate the acceptFromServerUrl config */
    --	(void)accept_from_server_url(repo);
    -+	struct string_list *accept_urls = accept_from_server_url(repo);
    + 	/* Load and validate the acceptFromServerUrl config */
    + 	load_accept_from_server_url(repo, &accept_urls);
      
     -	if (accept == ACCEPT_NONE)
    -+	if (accept == ACCEPT_NONE && !accept_urls->nr)
    ++	if (accept == ACCEPT_NONE && !accept_urls.nr)
      		return;
      
      	/* Parse remote info received */
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		}
      
     -		if (should_accept_remote(accept, advertised, &config_info)) {
    -+		if (should_accept_remote(accept, advertised, accept_urls, &config_info)) {
    ++		if (should_accept_remote(accept, advertised, &accept_urls, &config_info)) {
      			if (!store_info)
      				store_info = store_info_new(repo);
      			if (promisor_store_advertised_fields(advertised, store_info))
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	check_missing_objects server 1 "$oid"
      '
      
    -+test_expect_success "clone with 'None' but URL whitelisted" '
    ++test_expect_success "clone with 'None' but URL allowlisted" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
     +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that the largest object is still missing on the server
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with 'None' but URL not in whitelist" '
    ++test_expect_success "clone with 'None' but URL not in allowlist" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
     +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
     +		-c promisor.acceptfromserver=None \
     +		-c promisor.acceptFromServerUrl="https://example.com/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +	initialize_server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with 'None' but URL whitelisted in one pattern out of two" '
    ++test_expect_success "clone with 'None' but URL allowlisted in one pattern out of two" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
     +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
     +		-c promisor.acceptfromserver=None \
     +		-c promisor.acceptFromServerUrl="https://example.com/*" \
    -+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that the largest object is still missing on the server
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with 'None', URL whitelisted, but client has different URL" '
    ++test_expect_success "clone with 'None', URL allowlisted, but client has different URL" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	# The client configures "lop" with a different URL (serverTwo) than
     +	# what the server advertises (lop). Even though the advertised URL
    -+	# matches the whitelist, the remote is rejected because the
    ++	# matches the allowlist, the remote is rejected because the
     +	# configured URL does not match the advertised one.
     +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
     +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    -+		-c remote.lop.url="$PWD_URL/serverTwo" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/serverTwo" \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that the largest object is not missing on the server
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +	initialize_server 1 "$oid"
     +'
     +
    - test_expect_success "clone with promisor.sendFields" '
    + test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
      	git -C server config promisor.advertise true &&
      	test_when_finished "rm -rf client" &&
    -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "subsequent fetch from a client when promisor.advertise is f
    - 	check_missing_objects server 1 "$oid"
    - '
    - 
    -+
    -+
    - test_done
15:  314150a860 !  7:  a077f33df4 promisor-remote: auto-configure unknown remotes
    @@ Commit message
         promisor-remote: auto-configure unknown remotes
     
         Previous commits have introduced the `promisor.acceptFromServerUrl`
    -    config variable to whitelist some URLs advertised by a server through
    +    config variable to allowlist some URLs advertised by a server through
         the "promisor-remote" protocol capability.
     
         However the new `promisor.acceptFromServerUrl` mechanism, like the old
    @@ Commit message
     
      ## Documentation/config/promisor.adoc ##
     @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
    - 
      promisor.acceptFromServerUrl::
    - 	A glob pattern to specify which URLs advertised by a server
    --	are considered trusted by the client. This option acts as an
    --	additive security whitelist that works in conjunction with
    --	`promisor.acceptFromServer`.
    -+	are allowed to be auto-configured (created and persisted) on
    -+	the client side. Unlike `promisor.acceptFromServer`, which
    -+	only accepts already configured remotes, a match against this
    -+	option instructs Git to write a new `[remote "<name>"]`
    -+	section to the client's configuration.
    + 	A glob pattern to specify which server-advertised URLs a
    + 	client is allowed to act on. When a URL matches, the client
    +-	will accept the advertised remote as a promisor remote and may
    ++	will accept the advertised remote as a promisor remote, may
    ++	automatically create a new remote configuration for it and may
    + 	automatically accept field updates (such as authentication
    + 	tokens) from the server, even if `promisor.acceptFromServer`
    + 	is set to `none` (the default).
    +@@ Documentation/config/promisor.adoc: this option in _ANY_ config file read by Git.
    + Be _VERY_ careful with these patterns: `*` matches any sequence of
    + characters within the 'host' and 'path' parts of a URL (but cannot
    + cross part boundaries). An overly broad pattern is a major security
    +-risk, as a matching URL allows a server to update fields (such as
    +-authentication tokens) on known remotes without further confirmation.
    +-To minimize security risks, follow these guidelines:
    ++risk, as a matching URL allows a server to auto-configure new remotes
    ++and to update fields (such as authentication tokens) on known remotes
    ++without further confirmation. To minimize security risks, follow these
    ++guidelines:
    + +
    + 1. Start with a secure protocol scheme, like `https://` or `ssh://`.
      +
    - This option can appear multiple times in config files. An advertised
    - URL will be accepted if it matches _ANY_ glob pattern specified by
    -@@ Documentation/config/promisor.adoc: possible, and path segments like `..` are resolved.  Glob patterns
    - are matched against this normalized URL as-is, so patterns should
    - be written in normalized form (e.g., lowercase scheme and host).
    +@@ Documentation/config/promisor.adoc: are resolved. The port must also match exactly (e.g.,
    + `https://example.com:8080/*` will not match a URL advertised on
    + port 9999).
      +
    --Even if `promisor.acceptFromServer` is set to `None` (the default),
    --Git will still accept field updates (like tokens) for known remotes,
    --provided their URLs match a pattern in
    --`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
    --details on the protocol.
     +The glob pattern can optionally be prefixed with a remote name and an
     +equals sign (e.g., `cdn=https://cdn.example.com/*`). If such a prefix
     +is provided, accepted remotes will be saved under that name. If no
     +such prefix is provided, a safe remote name will be automatically
     +generated by sanitizing the URL and prefixing it with
    -+`promisor-auto-`. If a remote with the chosen name already exists but
    -+points to a different URL, Git will append a numeric suffix (e.g.,
    -+`-1`, `-2`) to the name to prevent overwriting existing
    -+configurations. You should make sure that this doesn't happen often
    -+though, as remotes will be rejected if the numeric suffix increases
    -+too much. In all cases, the original name advertised by the server is
    -+recorded in the `remote.<name>.advertisedAs` configuration variable
    -+for tracing and debugging purposes.
    ++`promisor-auto-`.
     ++
    -+Note that this option acts as an additive security whitelist. It works
    -+in conjunction with `promisor.acceptFromServer` (see the documentation
    -+of that option for the implications of accepting a promisor
    -+remote). Even if `promisor.acceptFromServer` is set to `None` (the
    -+default), Git will still automatically configure new remotes, and
    -+accept field updates (like tokens) for known remotes, provided their
    -+URLs match a pattern in `promisor.acceptFromServerUrl`. See
    -+linkgit:gitprotocol-v2[5] for details on the protocol.
    - 
    - promisor.checkFields::
    - 	A comma or space separated list of additional remote related
    ++If a remote with the chosen name already exists but points to a
    ++different URL, Git will append a numeric suffix (e.g., `-1`, `-2`) to
    ++the name to prevent overwriting existing configurations. You should
    ++make sure that this doesn't happen often though, as remotes will be
    ++rejected if the numeric suffix increases too much. In all cases, the
    ++original name advertised by the server is recorded in the
    ++`remote.<name>.advertisedAs` configuration variable for tracing and
    ++debugging purposes.
    +++
    + For the security implications of accepting a promisor remote, see the
    + documentation of `promisor.acceptFromServer`. For details on the
    + protocol, see linkgit:gitprotocol-v2[5].
     
      ## Documentation/config/remote.adoc ##
     @@ Documentation/config/remote.adoc: remote.<name>.promisor::
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      			string_list_sort(&config_info);
      		}
      
    --		if (should_accept_remote(accept, advertised, accept_urls, &config_info)) {
    -+		if (should_accept_remote(repo, accept, advertised, accept_urls,
    +-		if (should_accept_remote(accept, advertised, &accept_urls, &config_info)) {
    ++		if (should_accept_remote(repo, accept, advertised, &accept_urls,
     +					 &config_info, &reload_config)) {
      			if (!store_info)
      				store_info = store_info_new(repo);
      			if (promisor_store_advertised_fields(advertised, store_info))
     
      ## t/t5710-promisor-remote-capability.sh ##
    -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', URL whitelisted, but client has differen
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', URL allowlisted, but client has differen
      	initialize_server 1 "$oid"
      '
      
    -+test_expect_success "clone with URL whitelisted and no remote already configured" '
    ++test_expect_success "clone with URL allowlisted and no remote already configured" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
    ++	test_when_finished "rm -f full_names" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
    -+	# Check that a remote has been auto-created with the right fields.
    -+	# The remote is identified by "remote.<name>.advertisedAs" == "lop".
    -+	FULL_NAME=$(git -C client config --name-only --get-regexp "remote\..*\.advertisedas" "^lop$") &&
    -+	REMOTE_NAME=$(echo "$FULL_NAME" | sed "s/remote\.\(.*\)\.advertisedas/\1/") &&
    ++	# Check that exactly one remote has been auto-created, identified
    ++	# by "remote.<name>.advertisedAs" == "lop".
    ++	git -C client config get --all --show-names --regexp \
    ++		"remote\..*\.advertisedas" >full_names &&
    ++	test_line_count = 1 full_names &&
    ++	REMOTE_NAME=$(sed "s/^remote\.\(.*\)\.advertisedas .*$/\1/" full_names) &&
     +
     +	# Check ".url" and ".promisor" values
    -+	printf "%s\n" "$PWD_URL/lop" "true" >expect &&
    ++	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" >expect &&
     +	git -C client config "remote.$REMOTE_NAME.url" >actual &&
     +	git -C client config "remote.$REMOTE_NAME.promisor" >>actual &&
     +	test_cmp expect actual &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', U
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with named URL whitelisted and no pre-configured remote" '
    ++test_expect_success "clone with named URL allowlisted and no pre-configured remote" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that a remote has been auto-created with the right "cdn" name and fields.
    -+	printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
    ++	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
     +	git -C client config "remote.cdn.url" >actual &&
     +	git -C client config "remote.cdn.promisor" >>actual &&
     +	git -C client config "remote.cdn.advertisedAs" >>actual &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', U
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with URL whitelisted but colliding name" '
    ++test_expect_success "clone with URL allowlisted but colliding name" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', U
     +		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
     +		-c remote.cdn.url="https://example.com/cdn" \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that a remote has been auto-created with the right "cdn-1" name and fields.
    -+	printf "%s\n" "$PWD_URL/lop" "true" "lop" >expect &&
    ++	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" >expect &&
     +	git -C client config "remote.cdn-1.url" >actual &&
     +	git -C client config "remote.cdn-1.promisor" >>actual &&
     +	git -C client config "remote.cdn-1.advertisedAs" >>actual &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', U
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with URL whitelisted and reusable remote" '
    ++test_expect_success "clone with URL allowlisted and reusable remote" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	GIT_NO_LAZY_FETCH=0 git clone \
     +		-c remote.cdn.fetch="+refs/heads/*:refs/remotes/lop/*" \
    -+		-c remote.cdn.url="$PWD_URL/lop" \
    ++		-c remote.cdn.url="$TRASH_DIRECTORY_URL/lop" \
     +		-c promisor.acceptfromserver=None \
    -+		-c promisor.acceptFromServerUrl="cdn=$ENCODED_PWD_URL/*" \
    ++		-c promisor.acceptFromServerUrl="cdn=$ENCODED_TRASH_DIRECTORY_URL/*" \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
     +	# Check that the existing "cdn" remote has been properly updated.
    -+	printf "%s\n" "$PWD_URL/lop" "true" "lop" "+refs/heads/*:refs/remotes/lop/*" >expect &&
    ++	printf "%s\n" "$TRASH_DIRECTORY_URL/lop" "true" "lop" "+refs/heads/*:refs/remotes/lop/*" >expect &&
     +	git -C client config "remote.cdn.url" >actual &&
     +	git -C client config "remote.cdn.promisor" >>actual &&
     +	git -C client config "remote.cdn.advertisedAs" >>actual &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'None', U
     +	check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
    -+	git -C server config promisor.advertise true &&
    -+	test_when_finished "rm -rf client" &&
    -+
    -+	# As "bad name" contains a space, which is not a valid remote name,
    -+	# the pattern should be rejected with a warning and no remote created.
    -+	GIT_NO_LAZY_FETCH=0 git clone \
    -+		-c promisor.acceptfromserver=None \
    -+		-c "promisor.acceptFromServerUrl=bad name=https://example.com/*" \
    -+		--no-local --filter="blob:limit=5k" server client 2>err &&
    -+
    -+	# Check that a warning was emitted
    -+	test_grep "invalid remote name '\''bad name'\''" err &&
    -+
    -+	# Check that no remote was auto-created
    -+	test_must_fail git -C client config --get-regexp "remote\..*\.advertisedas" &&
    -+
    -+	# Check that the largest object is not missing on the server
    -+	check_missing_objects server 0 "" &&
    -+
    -+	# Reinitialize server so that the largest object is missing again
    -+	initialize_server 1 "$oid"
    -+'
    -+
    - test_expect_success "clone with promisor.sendFields" '
    + test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
      	git -C server config promisor.advertise true &&
      	test_when_finished "rm -rf client" &&
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
    + 	# Check that a warning was emitted
    + 	test_grep "invalid remote name '\''bad name'\''" err &&
    + 
    ++	# Check that no remote was auto-created
    ++	test_must_fail git -C client config get --regexp "remote\..*\.advertisedas" &&
    ++
    + 	# Check that the largest object is not missing on the server
    + 	check_missing_objects server 0 "" &&
    + 
16:  20f70b52bb !  8:  b68b9497aa doc: promisor: improve acceptFromServer entry
    @@ Documentation/config/promisor.adoc: variable is set to "true", and the "name" an
     +for protocol details.
      
      promisor.acceptFromServerUrl::
    - 	A glob pattern to specify which URLs advertised by a server
    + 	A glob pattern to specify which server-advertised URLs a


Christian Couder (8):
  t5710: simplify 'mkdir X' followed by 'git -C X init'
  urlmatch: change 'allow_globs' arg to bool
  urlmatch: add url_normalize_pattern() helper
  promisor-remote: add 'local_name' to 'struct promisor_info'
  promisor-remote: introduce promisor.acceptFromServerUrl
  promisor-remote: trust known remotes matching acceptFromServerUrl
  promisor-remote: auto-configure unknown remotes
  doc: promisor: improve acceptFromServer entry

 Documentation/config/promisor.adoc    | 123 ++++++--
 Documentation/config/remote.adoc      |   9 +
 Documentation/gitprotocol-v2.adoc     |   9 +-
 promisor-remote.c                     | 410 ++++++++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 202 ++++++++++++-
 urlmatch.c                            |  11 +-
 urlmatch.h                            |  12 +
 7 files changed, 730 insertions(+), 46 deletions(-)

-- 
2.54.0.19.gb68b9497aa


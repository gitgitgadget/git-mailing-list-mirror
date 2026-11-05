Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793919221;
	b=iWZPf1AQ0B16bqLt8Y+DUtqj6c82BByUsv7yY5u1K7SZQFxWh32OM6jWpYL7W9S38Ikp
	 6i+RLiiIWqLIE4fcg50vJZ3Jarw991vpqqvRHg7lTEmR57e1yTMFCwp7du1AFHyy07bQy
	 DJl3pfjlYpeMneRF49Sum+IUceifSTn1QQWZ+yCJvG/wsbYbqdeU0Yvw/zDMv4/3SZFON
	 /RFCrrSCpAabS3ccqCYjQMzpvaiRQ8tsvM3J5bAaqSNzY4fd53ZLse0kfAoWEgTLZR2/f
	 phzFQTrjLCxjeLI/qAZKYjOdRD4bEphfsJ12ptN4BTooVPoAM7gOzkf5aVgdKTq8yFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkPRbjA6Ah+NoxFSgRByl7i2xxH5BJbfkTTZA4I1ql8=;
	b=Ykx0zgUBRx+4zw4/5RGVcTv4zuv7wdbwlQJSsRObI5q3EobKsFrmJQ+vFTD7vjfNeEOz
	 6y+uY/yBsFIWyegrnlaf2w3WHvg+IDCHe6pxBRcMSLESvUN+wT08uQkjP7qq7poFE4trR
	 W9JuKkbmEt9g3OvYFzb66H1gtNToRh5OR/PZ3DhvS95ryIyCfrMTdAWbXpSIdFLv9AD/z
	 9I8qrIj4NqaBqO2ejfk2imH1onpnFIh5wcLeseh427OU3CshigK7a5X+5bLMJvQWtGlAD
	 bh5qYXcPd7Y1IVVzZkEunGtOpghccbw9Tscua+RP5lRlnji8hDfeF1ljcm2PaDsYEOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccnGvvyj;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D0606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF1D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccnGvvyj
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48fd2e38825so49917f8f.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793919219; x=1794524019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkPRbjA6Ah+NoxFSgRByl7i2xxH5BJbfkTTZA4I1ql8=;
        b=ccnGvvyjGOzBdJqrOU8bwg34l7VANCKuYvEQEqrIlZ5h+qt8CvboguSrkOQfbjUz3X
         roPOe2tvMi+IretNNHiw7Z/oNg6Z0cdourEAeQ4Ri+NvUnxmIeHwFS4wqWKi2GXNYWDg
         wYYbFQDZAb7Ekrrrrjg8FXG2vG7DnumT/ZOnVtlT/MUvxhWOpCleVgmKMB7bF7NBBe4o
         SSzFox4qKhkhB0Xv2cpvaNvU7qel1FaKjJoKY7itrfOFg3MsRJd63EwajnHdJYgpdz5j
         oiyamcL51vUx5M0HI0MBMPV/5OFO7L2kfVMsD1NWEv2C5q8iWxckO3uxTzP60oXaM47H
         Gcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793919219; x=1794524019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkPRbjA6Ah+NoxFSgRByl7i2xxH5BJbfkTTZA4I1ql8=;
        b=0MAOjG7xR4yHbEwwTniWifs+CNvdqSa+vQJuIWX17RU160fw3i/gtaYvxF11wfEto0
         jj6Cx8uBa+m5x3nnt2kr36n8ZUDOLLGozjj9MH2AZI7Ltb0ut/PIapf6iiO6ITjejOga
         l5uvJ3d0wLl0M+pmfHtBFQ1b+cJPFirnvcdVZo8tB4ghHPu4EBOdJY35aFmN749ogoMG
         tvmR/utsuFtGFb2Zadh4ZyZmS8lTwEyQvgmstpwmSoyzv2wYOHyZZjeEauxwIFnH/PUn
         FjzqsFvYEVgX0e/sQjh8lpV3qFOwvPqOPDG4u/jZuk5/adfWHx5SAdIOhCHcGeeXgHtV
         Uofg==
X-Gm-Message-State: APuU4Z+ux863KsT7lQSnRjJpaAiEqwxJ3mYP51oqBDs8eCi5chW6+wKH
	rFWI8onatZ3VaDdP/iEoc8iODV+ckIOaJgUoTSoMeWcpCXnocrgaYC2qL2ygm6kk
X-Gm-Gg: AYBFou3zVpYa0p3Aa9+a63BjCEVmBlXTDVQKYVQ1DM5VkDqPesWMsjfVBjSD3Lzw8wh
	9II2IagAaq7UXpNtafj+diO+RT22ZJ2A+uKWZYuleeHesGbUAmzAFCtO/zOajxZ/3VtTWKymJWE
	ZDTf4WarfzXLsORV4nnsyUeFngFYq4SvUuvDu34dUE0F+LcbQ6xYeGjaIEavXmlBsqA3VXqufin
	lMbIZ5d6wJeDDEm4rafegwB+78/a3Q0jv9fw0cXQ7AesRnkZZ2gHXJv7ZwCcQwVtExHPSX9se/c
	U/K8tBkVVXBfWsmq8VHp7bONaHPPGT2F5I21X2Hkb7UPlOICTKciD6Bdv5g6lvIbd6a9oFOmMhY
	XZTFEOXwkfGBBYCuue3EDoY/hy41tktx48tDNw/6kDywhnh0FwWTMijE5fAx0Kiu4ixlZVL+rh0
	BF2+72Im0WeLoOfYI7XAnNlkEnGhDpG6MsLCKjU5qKK2dnUaE5K815wEpzKrUtjPVOtzz6RnzRa
	m9A+E33inVcPlLlSe/MjTt7xa5lrNjC1TUm8H8ilaRytBSNN9xuKcIBSVpIZ4SBTwUHCrrnCG70
	k7Ltn9AUjoIcE1wkECWZG89P5vCA3oh/myVy8LfxUS6VdhWzVOIS0Y+fCKXdXysa3CS8svudb8z
	eO82/zqqre2/JlFufJVYQZ3ZkCLvv04QNkArc82MrUv4PhCwI+gAOhz72+FfkdUG6mPcHVVyRg9
	UTaA==
X-Received: by 2002:a05:6000:2489:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-49275fe4e84mr1915184f8f.17.1793919218866;
        Thu, 05 Nov 2026 14:53:38 -0800 (PST)
Received: from ngadou-Latitude-5580.. ([129.0.60.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df21sm81475f8f.54.2026.11.05.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:53:37 -0800 (PST)
From: Yopa Nelly <yopatatchou@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	kaartic.sivaraam@gmail.com,
	Nelly Yopa <yopatatchou@gmail.com>
Subject: [Outreachy][PATCH v2] promisor-remote: honor promisor.fetchOrder when trying remotes
Date: Thu,  5 Nov 2026 23:52:23 +0100
Message-ID: <20261105225223.1163975-1-yopatatchou@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104172434.691381-1-yopatatchou@gmail.com>
References: <20261104172434.691381-1-yopatatchou@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nelly Yopa <yopatatchou@gmail.com>

When a repository is configured with more than one promisor
remote, Git tries them one after another until the missing
objects have been fetched. The order is currently determined
only by the order in which remote.<name>.promisor entries appear
in the configuration. There is no way to say "try this remote
first" without moving config lines around.

Add a promisor.fetchOrder configuration variable that takes a
comma-separated list of remote names. Remotes named in the list
are tried first, in the order listed. Remotes not named in the
list are tried afterwards, in their original configuration
order. The extensions.partialClone remote is still moved to the
end of the list by promisor_remote_init() unless it is named in
fetchOrder, in which case its listed position wins.

The order is applied inside each of the two passes in
lazy_fetch_objects() first the accepted remotes, then the
rest so the existing "accepted before configured" behavior is
unchanged. Within each pass, the fetchOrder order takes
precedence over the configuration order.

The parsed list is stored in struct promisor_remote_config and
is re-parsed each time the config is read. Instead of sorting
the linked list at fetch time, try_promisor_remotes() walks the
list twice: once in fetchOrder order for the remotes named
there, and once in the original config order for the rest.

Signed-off-by: Yopa Nelly <yopatatchou@gmail.com>
---
 Documentation/config/promisor.adoc |  11 +++
 promisor-remote.c                  | 108 +++++++++++++++++++++++++----
 2 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index c1f3d766a6..ccc0925800 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -31,6 +31,17 @@ This list has no effect unless the "promisor.advertise" config
 variable is set to "true", and the "name" and "url" fields are always
 advertised regardless of this setting.
 
+`promisor.fetchOrder`::
+	A comma-separated list of promisor remote names. When Git
+	needs to lazily fetch a missing object, it tries the remotes
+	in this list first, in the order listed, then the remaining
+	configured promisor remotes in their configuration order.
+	The `extensions.partialClone` remote is tried last unless it
+	is named in this list.
++
+See linkgit:gitprotocol-v2[5] and the "Partial Clone Design
+Notes" in link:technical/partial-clone.html[Documentation/technical/partial-clone].
+
 promisor.acceptFromServer::
 	Controls which promisor remotes advertised by a server (using the
 	"promisor-remote" protocol capability) a client will accept. By
diff --git a/promisor-remote.c b/promisor-remote.c
index 316d9950aa..c664a48f88 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -19,8 +19,11 @@
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
 	struct promisor_remote **promisors_tail;
+	struct string_list fetch_order;
+	int fetch_order_initialized;
 };
 
+
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
 			 const struct object_id *oids,
@@ -120,6 +123,29 @@ static int promisor_remote_config(const char *var, const char *value,
 	size_t namelen;
 	const char *subkey;
 
+    	if (!strcmp(var, "promisor.fetchorder")) {
+		char *value_copy;
+
+		if (!value)
+			return config_error_nonbool(var);
+		/*
+		 * The list is re-read from scratch every time the config
+		 * is parsed, so start by clearing any previous entries.
+		 */
+		if (config->fetch_order_initialized)
+			string_list_clear(&config->fetch_order, 0);
+		else
+			string_list_init_nodup(&config->fetch_order);
+
+		value_copy = xstrdup(value);
+		string_list_split_in_place_f(&config->fetch_order, value_copy, ",", -1,
+					     STRING_LIST_SPLIT_TRIM |
+					     STRING_LIST_SPLIT_NONEMPTY);
+		free(value_copy);
+		config->fetch_order_initialized = 1;
+		return 0;
+	}
+
 	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
 		return 0;
 
@@ -157,6 +183,8 @@ static int promisor_remote_config(const char *var, const char *value,
 	return 0;
 }
 
+
+
 static void promisor_remote_init(struct repository *r)
 {
 	struct promisor_remote_config *config;
@@ -180,6 +208,7 @@ static void promisor_remote_init(struct repository *r)
 		else
 			promisor_remote_new(config, r->repository_format_partial_clone);
 	}
+
 }
 
 void promisor_remote_clear(struct promisor_remote_config *config)
@@ -193,6 +222,9 @@ void promisor_remote_clear(struct promisor_remote_config *config)
 	}
 
 	config->promisors_tail = &config->promisors;
+	if (config->fetch_order_initialized)
+		string_list_clear(&config->fetch_order, 0);
+	config->fetch_order_initialized = 0;
 }
 
 void repo_promisor_remote_reinit(struct repository *r)
@@ -262,6 +294,8 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+
+
 /*
  * Fetch the remaining objects (given in '*remaining_oids', which
  * contains '*remaining_nr' object ids) from the known promisor
@@ -279,6 +313,24 @@ static int remove_fetched_oids(struct repository *repo,
  * Return 1 when all the requested objects have been fetched, 0
  * otherwise.
  */
+static int try_one_remote(struct repository *repo, struct promisor_remote *r,
+			  struct object_id **remaining_oids,
+			  int *remaining_nr, int *to_free, int depth)
+{
+	if (fetch_objects(repo, r->name,
+			  *remaining_oids, *remaining_nr, depth) < 0) {
+		if (*remaining_nr == 1)
+			return 0;
+		*remaining_nr = remove_fetched_oids(repo, remaining_oids,
+						    *remaining_nr, *to_free);
+		if (*remaining_nr) {
+			*to_free = 1;
+			return 0;
+		}
+	}
+	return 1; /* all fetched */
+}
+
 static int try_promisor_remotes(struct repository *repo,
 				struct object_id **remaining_oids,
 				int *remaining_nr,
@@ -286,24 +338,56 @@ static int try_promisor_remotes(struct repository *repo,
 				int depth,
 				bool accepted_only)
 {
-	struct promisor_remote *r = repo->promisor_remote_config->promisors;
+	struct promisor_remote_config *config = repo->promisor_remote_config;
+	struct promisor_remote *r;
+	size_t i;
+	int fetched;
+
+	/*
+	 * First pass: try the remotes in the order the user listed
+	 * them in promisor.fetchOrder.
+	 */
+	if (config->fetch_order_initialized) {
+		for (i = 0; i < config->fetch_order.nr; i++) {
+			r = promisor_remote_lookup(config,
+						   config->fetch_order.items[i].string,
+						   NULL);
+			if (!r || accepted_only != r->accepted)
+				continue;
 
-	for (; r; r = r->next) {
+			fetched = try_one_remote(repo, r, remaining_oids,
+						 remaining_nr, to_free, depth);
+			if (fetched)
+				return 1;
+		}
+	}
+
+	/*
+	 * Second pass: try the remaining remotes in their config order.
+	 */
+	for (r = config->promisors; r; r = r->next) {
 		if (accepted_only != r->accepted)
 			continue;
-		if (fetch_objects(repo, r->name,
-				  *remaining_oids, *remaining_nr, depth) < 0) {
-			if (*remaining_nr == 1)
-				continue;
-			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
-							    *remaining_nr, *to_free);
-			if (*remaining_nr) {
-				*to_free = 1;
-				continue;
+
+		/* Skip ones we already tried in the first pass. */
+		if (config->fetch_order_initialized) {
+			bool already_tried = false;
+			for (i = 0; i < config->fetch_order.nr; i++) {
+				if (!strcmp(r->name, config->fetch_order.items[i].string)) {
+					already_tried = true;
+					break;
+				}
 			}
+			if (already_tried)
+				continue;
 		}
-		return 1; /* all fetched */
+
+		fetched = try_one_remote(repo, r, remaining_oids,
+					 remaining_nr, to_free, depth);
+		if (fetched)
+			return 1;
 	}
+
 	return 0;
 }
 
-- 
2.43.0


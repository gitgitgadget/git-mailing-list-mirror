Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776535DA6A
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253160; cv=none; b=gsn9gWongHPZFqVVn9edh9NVTStq/EYKgoUUWbJxbPYu/wSbSYy/VpvL+ABuwKFOJk55xZjno+oSAYlExYODhd81eKRlr7rac3eQDULTtLzXnQWMa5yl0ZcljQ2F9twHymbQn919cO3Yi9ID5q0FrgViujHp34qKhmvTTDMpHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253160; c=relaxed/simple;
	bh=HDR0pss0H6UuGL2KrW9YUY1mn6rKGpoFLGYAxnK+3lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSPkLGVJbvNsS5lcV1yX21VmBysOft8crFTSlDgzj3exA6xxWyCgiF6dG9aEVPlR36o0OiKgTaIAdfgocW7k4fewERcY/JU2G9wxj/z7td7k/AfN4T+08fpRJl197KNiFu8Aic5W+wtpnzQIieV+6sTuJKPIIfVgdueZr+5z3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8nuXFnZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8nuXFnZ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b4121c40aso2733249f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253156; x=1774857956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dUe903SyxNDsP20EzLoM0J+KwAi0cKmgatY6zO1AN8=;
        b=I8nuXFnZfjZux7a9Eah/PTDmxQqFEo3oMzh2ekBcURqlKxpRYwRuz3lTwiVNGDgOql
         m0GMLebPYppoM1GdnsyCRlzqo2+G/TG7kDbcq+wI7kVMX+yW6pXwa4QM/MwSu/PK45oR
         qr7q4PMjQK3bEiG5KL+ogJStgGWLNfiM6ThxjMAnAkotbq1CzKbnsxlaR+6dILrqnHBY
         IL254zVQNoS5pvzsbXJ1MeCVLzmXQiOqWE/DbQnloaCh/ySeieyG2bWj3h3VEUxM+aCD
         zpvFobjcKMcU8Du/4uP26jKGdGhkhJoe23sR1UvHdtuhI0Vv33BMG5BPg6VWkkY5Sj76
         TLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253156; x=1774857956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dUe903SyxNDsP20EzLoM0J+KwAi0cKmgatY6zO1AN8=;
        b=NQetZHlfHJHN4IPLlqvjNxAQ/piKH6EgdxEJG+8mhjx0vxU5BvuXnTgHMuPsEbxWWy
         QoWfJ+Xyuefr5W3XWXEJDaHoRgqcqe7XwW7wqoesZE5GCfU8WqnJr8x8CjJ3BfKaI5RD
         i4AzLH6ckfEEo93OWVgkEAzkPl74heUBcvK8ZQ1CkwncOCDVRWr8bTQ9syi0laDJJuPs
         /dynlWXkp7wBMrEKWGt2i5NaBgBelRsc5qVixwW+/JAoa/gdGg2NaCQOJNz3sZ8dnTTI
         h+x6xzkfLIMMFWbNp7ePVn9T4E+CIG/u1bIkedawO1873l7IYn6swkRzvj3Xuvr90w4f
         endw==
X-Gm-Message-State: AOJu0YzdAd+1i92f+JRI+mVmRIyQsyXdr5wSVi/tb9DzItenWCkTIMMw
	s8lxxe3cdEE9xVEUvezyS6Wy0x8xbWE/I2TAIp+oaEz5iMnZMSdJtHbWv7mzRw==
X-Gm-Gg: ATEYQzzmQ+O0PtBrDJUVcff9A9UK2e7scLfaQjUSpwt6VIp+6lBjH912bFTehcq1VM3
	2t0BfppLZ/k7ynBFczSeEn29FGm8gIBoNCsa23ioVPNC1tvvyViWUGYQCOOBWG0Z5dQ5bQw/xDo
	K3/O+FIeCDZmUsiAUzi5pHW9RwoeXKHjzb5d08QaBBPDYaFJzhBjrodxfFwvGzSgK37uUSYiyNk
	lepbA+w2v171kGFAf2nnLMt/vNqGjXea3mIAfiPzJNBdir4Gp3jfqMkpw5enbbbJJXF7DGSYF+s
	0KSeDTqbJk4/xRTZjsCAN64JyCda4g6dD3mAKNk6CFYKBgef2cuVfiMQg998iQTbfojOnLP0twi
	JUY0g2eve2ixPFXNSB8CiGB1A+ehSYgywV0Ppkjci7jlAc2udMrHZMTA9OO8FJ2xXX38V5oTxUI
	jWgF/dJGWV9Ql7AwDmxNq9QF+zd7acMFFz9OdhfohGrsLGkRwCLZ3v/eCztiX2K0OOD1k3hDPnT
	So7hmLYpJqKY0LeRcE/3ZQe2ymtlZ+jst56cRG8sJ4k4XaAHw==
X-Received: by 2002:a05:6000:184d:b0:439:b203:7711 with SMTP id ffacd0b85a97d-43b642405cfmr17425734f8f.3.1774253156095;
        Mon, 23 Mar 2026 01:05:56 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:55 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 14/16] promisor-remote: trust known remotes matching acceptFromServerUrl
Date: Mon, 23 Mar 2026 09:05:17 +0100
Message-ID: <20260323080520.887550-15-christian.couder@gmail.com>
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

A previous commit introduced the `promisor.acceptFromServerUrl` config
variable along with the machinery to parse and validate the URL glob
patterns and optional remote name prefixes it contains. However, these
URL patterns are not yet tied into the client's acceptance logic.

When a promisor remote is already configured locally, its fields (like
authentication tokens) may occasionally need to be refreshed by the
server. If `promisor.acceptFromServer` is set to the secure default
("None"), these updates are rejected, potentially causing future
fetches to fail.

To enable such targeted updates for trusted URLs, let's use the URL
patterns from `promisor.acceptFromServerUrl` as an additional URL
based whitelist.

Concretely, let's check the advertised URLs against the URL glob
patterns by introducing a new small helper function called
url_matches_accept_list(), which iterates over the glob patterns and
returns the first matching allowed_url entry (or NULL).

(Before matching, the advertised URL is passed through url_normalize()
so that case variations in the scheme/host, percent-encoding tricks,
and ".." path segments cannot bypass the whitelist.)

Let's then use this helper at the tail of should_accept_remote() so
that, when `accept == ACCEPT_NONE`, a known remote whose URL matches
the whitelist is still accepted.

To prepare for this new logic, let's also:

 - Add an 'accept_urls' parameter to should_accept_remote().

 - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
   explicit 'if (accept == ACCEPT_KNOWN_URL) return' and a new
   BUG() guard in the ACCEPT_NONE case, so url_matches_accept_list()
   is only called in the ACCEPT_NONE case.

 - Call accept_from_server_url() from filter_promisor_remote()
   and relax its early return so that the function is entered when
   `accept_urls` has entries even if `accept == ACCEPT_NONE`.

Let's then properly document `promisor.acceptFromServerUrl` in
"promisor.adoc" as an additive security whitelist for known remotes,
including the URL normalization behavior, and let's mention it in
"gitprotocol-v2.adoc".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc    | 46 +++++++++++++++++
 Documentation/gitprotocol-v2.adoc     |  9 ++--
 promisor-remote.c                     | 50 +++++++++++++++---
 t/t5710-promisor-remote-capability.sh | 73 +++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index b0fa43b839..6f5442cd65 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -51,6 +51,52 @@ promisor.acceptFromServer::
 	to "fetch" and "clone" requests from the client. Name and URL
 	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
 
+promisor.acceptFromServerUrl::
+	A glob pattern to specify which URLs advertised by a server
+	are considered trusted by the client. This option acts as an
+	additive security whitelist that works in conjunction with
+	`promisor.acceptFromServer`.
++
+This option can appear multiple times in config files. An advertised
+URL will be accepted if it matches _ANY_ glob pattern specified by
+this option in _ANY_ config file read by Git.
++
+Be _VERY_ careful with these glob patterns, as it can be a big
+security hole to allow any advertised remote to be auto-configured!
+To minimize security risks, follow these guidelines:
++
+1. Start with a secure protocol scheme, like `https://` or `ssh://`.
++
+2. Only allow domain names or paths where you control and trust _ALL_
+   the content. Be especially careful with shared hosting platforms
+   like `github.com` or `gitlab.com`. A broad pattern like
+   `https://gitlab.com/*` is dangerous because it trusts every
+   repository on the entire platform. Always restrict such patterns to
+   your specific organization or namespace (e.g.,
+   `https://gitlab.com/your-org/*`).
++
+3. Don't use globs (`*`) in the domain name. For example
+   `https://cdn.example.com/*` is much safer than
+   `https://*.example.com/*`, because the latter matches
+   `https://evil-hacker.net/fake.example.com/repo`.
++
+4. Make sure to have a `/` at the end of the domain name (or the end
+   of specific directories). For example `https://cdn.example.com/*`
+   is much safer than `https://cdn.example.com*`, because the latter
+   matches `https://cdn.example.com.hacker.net/repo`.
++
+Before matching, the advertised URL is normalized: the scheme and
+host are lowercased, percent-encoded characters are decoded where
+possible, and path segments like `..` are resolved.  Glob patterns
+are matched against this normalized URL as-is, so patterns should
+be written in normalized form (e.g., lowercase scheme and host).
++
+Even if `promisor.acceptFromServer` is set to `None` (the default),
+Git will still accept field updates (like tokens) for known remotes,
+provided their URLs match a pattern in
+`promisor.acceptFromServerUrl`. See linkgit:gitprotocol-v2[5] for
+details on the protocol.
+
 promisor.checkFields::
 	A comma or space separated list of additional remote related
 	field names. A client checks if the values of these fields
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index f985cb4c47..175358bba2 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -862,10 +862,11 @@ the server advertised, the client shouldn't advertise the
 
 On the server side, the "promisor.advertise" and "promisor.sendFields"
 configuration options can be used to control what it advertises. On
-the client side, the "promisor.acceptFromServer" configuration option
-can be used to control what it accepts, and the "promisor.storeFields"
-option, to control what it stores. See the documentation of these
-configuration options in linkgit:git-config[1] for more information.
+the client side, the "promisor.acceptFromServer" and
+"promisor.acceptFromServerUrl" configuration options can be used to
+control what it accepts, and the "promisor.storeFields" option, to
+control what it stores. See the documentation of these configuration
+options in linkgit:git-config[1] for more information.
 
 Note that in the future it would be nice if the "promisor-remote"
 protocol capability could be used by the server, when responding to
diff --git a/promisor-remote.c b/promisor-remote.c
index 4cb18e1a6a..210e6950af 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -14,6 +14,7 @@
 #include "url.h"
 #include "urlmatch.h"
 #include "version.h"
+#include "wildmatch.h"
 
 struct promisor_remote_config {
 	struct promisor_remote *promisors;
@@ -727,8 +728,31 @@ static struct string_list *accept_from_server_url(struct repository *repo)
 	return &accept_urls;
 }
 
+static struct allowed_url *url_matches_accept_list(
+		struct string_list *accept_urls, const char *url)
+{
+	struct string_list_item *item;
+	char *normalized = url_normalize(url, NULL);
+
+	if (!normalized)
+		return NULL;
+
+	for_each_string_list_item(item, accept_urls) {
+		struct allowed_url *allowed = item->util;
+
+		if (!wildmatch(allowed->url_pattern, normalized, 0)) {
+			free(normalized);
+			return allowed;
+		}
+	}
+
+	free(normalized);
+	return NULL;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
+				struct string_list *accept_urls,
 				struct string_list *config_info)
 {
 	struct promisor_info *p;
@@ -757,9 +781,6 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept == ACCEPT_KNOWN_NAME)
 		return all_fields_match(advertised, config_info, p);
 
-	if (accept != ACCEPT_KNOWN_URL)
-		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
-
 	if (strcmp(p->url, remote_url)) {
 		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
 			  "ignoring this remote"),
@@ -767,7 +788,21 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	return all_fields_match(advertised, config_info, p);
+	if (accept == ACCEPT_KNOWN_URL)
+		return all_fields_match(advertised, config_info, p);
+
+	if (accept != ACCEPT_NONE)
+		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
+
+	/*
+	 * Even if accept == ACCEPT_NONE, we MUST trust this known
+	 * remote to update its token or other such fields if its URL
+	 * matches the acceptFromServerUrl whitelist!
+	 */
+	if (url_matches_accept_list(accept_urls, remote_url))
+		return all_fields_match(advertised, config_info, p);
+
+	return 0;
 }
 
 static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
@@ -972,10 +1007,9 @@ static void filter_promisor_remote(struct repository *repo,
 	struct string_list_item *item;
 	bool reload_config = false;
 	enum accept_promisor accept = accept_from_server(repo);
-	/* Pre-load and validate the acceptFromServerUrl config */
-	(void)accept_from_server_url(repo);
+	struct string_list *accept_urls = accept_from_server_url(repo);
 
-	if (accept == ACCEPT_NONE)
+	if (accept == ACCEPT_NONE && !accept_urls->nr)
 		return;
 
 	/* Parse remote info received */
@@ -995,7 +1029,7 @@ static void filter_promisor_remote(struct repository *repo,
 			string_list_sort(&config_info);
 		}
 
-		if (should_accept_remote(accept, advertised, &config_info)) {
+		if (should_accept_remote(accept, advertised, accept_urls, &config_info)) {
 			if (!store_info)
 				store_info = store_info_new(repo);
 			if (promisor_store_advertised_fields(advertised, store_info))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index c7a484228f..4ebad14af5 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -306,6 +306,77 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with 'None' but URL whitelisted" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$PWD_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'None' but URL not in whitelist" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$PWD_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="https://example.com/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is not missing on the server
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
+test_expect_success "clone with 'None' but URL whitelisted in one pattern out of two" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$PWD_URL/lop" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="https://example.com/*" \
+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "clone with 'None', URL whitelisted, but client has different URL" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
+
+	# The client configures "lop" with a different URL (serverTwo) than
+	# what the server advertises (lop). Even though the advertised URL
+	# matches the whitelist, the remote is rejected because the
+	# configured URL does not match the advertised one.
+	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="$PWD_URL/serverTwo" \
+		-c promisor.acceptfromserver=None \
+		-c promisor.acceptFromServerUrl="$ENCODED_PWD_URL/*" \
+		--no-local --filter="blob:limit=5k" server client &&
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
@@ -573,4 +644,6 @@ test_expect_success "subsequent fetch from a client when promisor.advertise is f
 	check_missing_objects server 1 "$oid"
 '
 
+
+
 test_done
-- 
2.53.0.625.g20f70b52bb


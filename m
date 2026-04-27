Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBC312803
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293698; cv=none; b=UHb6fjKX5hpyZYGjVvX7G7000FItEL2VdeUAlylw4essuKTw0rkjPgkJCgys53cid+PCabfLvqhvqwpGHToW3lercvsPywfnQ2hhbgH/YgZXyKYYUfjjVRu/KbkK3rHYUJDKt0URSkYh7kYezzuExkwYSV67mgByYz50kD9dWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293698; c=relaxed/simple;
	bh=h/2DVnwpudn8ibTDCWsc0m08ATr+m8UCeVea20rg6aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZF3zfIxRqPgyalqXY+C3Uc26Q8TE/UKSjRQ3PaDTImeaiFWfoZ3BbBruV7D+s/jRFCULLXvxTI/fK+CIlYo3ZHdQ7c2be/v1D4W2xsxe0cqzP3UsxaFQtnssPVQe+joJhqvcwRKA1rAGSH3dNAz4lsIakGWT6lLiVvFZZw7ayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5hk9qAA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5hk9qAA"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso11283960a12.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293695; x=1777898495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3CaTNm1P9LHW7uPLyjmceKts0L+N+BJtWFFZDrZsug=;
        b=i5hk9qAA2Wx7aYsA11otBC/JN209qVy3bpjJMnq+xi9owcTS4QllgWRNDsZ46b0sbn
         qJOB/dL+LVpusEqtW6lbetOHhBR2MkOGshCuFYfwxrPyfT1Z4TjkHRK0NZY4BrUZEvY0
         YInRXdp4e+EIV8BCjp5hTkcI54x4EukBOtgto7Aw+qOjEwPCQJ6knUlCmrzrcnF9B4HB
         C3URLjQTJl7Tcb4GTmIrRBRV32N4yLSiS0S1TLqsGzSt5OqYI0e/lcPqLXBqDVnNGnBI
         8WtzOzonExqxaZ6ClY15jQKT7rO/9OpqXOYRIwbzK9pLUpyxulxxMP64EBnSB1P59rnu
         p6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293695; x=1777898495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3CaTNm1P9LHW7uPLyjmceKts0L+N+BJtWFFZDrZsug=;
        b=hZbdEPOvoFvLcDqjKlxjWwmqywhQgUM7WLON3FdLMbcD4Xh0uO/4BkuEpF0tHv71Ya
         cuCEw7MF4zKMogLtovuyPC+ZLkG5BkKzjV5V/jTeegnoTWFEgkOqTfsnS/Cr40njqWkj
         r5Pw6fH6It3T5A/yQ9x+vVEPJCMuNPvIcWSmwu19z+pZyqlHp0bcAD5rrAmePlijeEmE
         VynOs0YnbQy8zPj55roNZAbFBQAti3dhxqYuv0uGRKu3SlmwwTptrUW1as/gzeGXmkzT
         DxwN51ZjQjF6cm2Mrwa1AOieQ9Wmbk9Z7APcOschJaXBJFpd9EqFK9ShVvIfVa9P6HJd
         +ybA==
X-Gm-Message-State: AOJu0YxVK9i7BhAsGbvAxkyubKOxqqXUSAEP0seIVTtXzOrQ2EPg7GXe
	c///PepTraeXsaSwD5p8m7mSBekDSiM5Drex14vMlgKux7y4qquhmJb3OaNx7g==
X-Gm-Gg: AeBDieuU9m7kBG+WhwtK+1nlFdKqL4xv720cFY8P8sfweX6dExpPVYG8b5lnEHyqh0c
	sk4lPvUN4iclAGE1MQL1pA+PIYwHbO5dTGMSoC4TcRFDd9ZNrnQwxHi4SzK+lheLTiio21geMdI
	ukRynLNLXN3CEWQS+eYTGo70zRTmk2UukDqmK56PoddcButAWNGi41bl7XOynU5xHpheK6A+VLE
	B8ugRpLuV2wn0Me0vslsFJ8y081qNK34cBS6sNRUcDzNsPidPadlFPcpqwZCw6D+1Rqifc5/Hwe
	1TYncQcmhGOjMiosONTip/IScUEAnssCytliStbbvYK2KWpOMmAoQTe95XwmHsDH65BSOLNbwoN
	wjgWmIH/DG0GnZ27STaZe3EuvUf73pPz0HsiuVYP0RucKS2sL1HWUwHZKex7o3E8Cd9K1coINvG
	PQ+nYAqkFljQttg9ULGKRjA42xoqHeQbNdHSHuKYoHEBaz8sZbRApAhMUqH60q15JQNnt8EkQO4
	28cl66Y9B5KsUDPp7bGryVeMbFkbjkYntkuxN3XDnQASSFESQ==
X-Received: by 2002:a05:6402:5305:b0:678:9826:b758 with SMTP id 4fb4d7f45d1cf-6789826b949mr6415937a12.6.1777293694498;
        Mon, 27 Apr 2026 05:41:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/8] promisor-remote: introduce promisor.acceptFromServerUrl
Date: Mon, 27 Apr 2026 14:41:05 +0200
Message-ID: <20260427124108.3524129-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" protocol capability allows servers to advertise
promisor remotes, but doesn't allow these remotes to be automatically
configured on the client.

Let's introduce a new `promisor.acceptFromServerUrl` config variable
which contains a glob pattern, so that advertised remotes with a URL
matching that pattern will be automatically configured.

The glob pattern can optionally be prefixed with a remote name which
will be used as the name of the new local remote.

For now though, let's only introduce the functions to read and validate
the glob patterns and the optional prefixes.

Checking if the URLs of the advertised remotes match the glob patterns
and taking the appropriate action is left for a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c                     | 90 +++++++++++++++++++++++++++
 t/t5710-promisor-remote-capability.sh | 21 +++++++
 2 files changed, 111 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 7699e259eb..3f3924f587 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "environment.h"
 #include "url.h"
+#include "urlmatch.h"
 #include "version.h"
 
 struct promisor_remote_config {
@@ -657,6 +658,90 @@ static bool has_control_char(const char *s)
 	return false;
 }
 
+struct allowed_url {
+	char *remote_name;
+	char *url_pattern;
+	struct url_info pattern_info;
+};
+
+static void allowed_url_free(void *util, const char *str UNUSED)
+{
+	struct allowed_url *allowed = util;
+
+	if (!allowed)
+		return;
+
+	/* Depending on prefix, free either remote_name or url_pattern */
+	free(allowed->remote_name ? allowed->remote_name : allowed->url_pattern);
+	free(allowed->pattern_info.url);
+	free(allowed);
+}
+
+static struct allowed_url *valid_accept_url(const char *url)
+{
+	char *dup, *p;
+	struct allowed_url *allowed;
+
+	if (!url)
+		return NULL;
+
+	dup = xstrdup(url);
+	p = strchr(dup, '=');
+	if (p) {
+		*p = '\0';
+		if (!valid_remote_name(dup)) {
+			warning(_("invalid remote name '%s' before '=' sign "
+				  "in '%s' from promisor.acceptFromServerUrl config"),
+				dup, url);
+			free(dup);
+			return NULL;
+		}
+		p++;
+	} else {
+		p = dup;
+	}
+
+	if (has_control_char(p)) {
+		warning(_("invalid url pattern '%s' "
+			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
+		free(dup);
+		return NULL;
+	}
+
+	allowed = xmalloc(sizeof(*allowed));
+	allowed->remote_name = (p == dup) ? NULL : dup;
+	allowed->url_pattern = p;
+	allowed->pattern_info.url = url_normalize_pattern(p, &allowed->pattern_info);
+	if (!allowed->pattern_info.url) {
+		warning(_("invalid url pattern '%s' "
+			  "in '%s' from promisor.acceptFromServerUrl config"), p, url);
+		free(dup);
+		free(allowed);
+		return NULL;
+	}
+
+	return allowed;
+}
+
+static void load_accept_from_server_url(struct repository *repo,
+					struct string_list *accept_urls)
+{
+	const struct string_list *config_urls;
+
+	if (!repo_config_get_string_multi(repo, "promisor.acceptfromserverurl", &config_urls)) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, config_urls) {
+			struct allowed_url *allowed = valid_accept_url(item->string);
+			if (allowed) {
+				struct string_list_item *new;
+				new = string_list_append(accept_urls, item->string);
+				new->util = allowed;
+			}
+		}
+	}
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -901,6 +986,10 @@ static void filter_promisor_remote(struct repository *repo,
 	struct string_list_item *item;
 	bool reload_config = false;
 	enum accept_promisor accept = accept_from_server(repo);
+	struct string_list accept_urls = STRING_LIST_INIT_DUP;
+
+	/* Load and validate the acceptFromServerUrl config */
+	load_accept_from_server_url(repo, &accept_urls);
 
 	if (accept == ACCEPT_NONE)
 		return;
@@ -934,6 +1023,7 @@ static void filter_promisor_remote(struct repository *repo,
 		}
 	}
 
+	string_list_clear_func(&accept_urls, allowed_url_free);
 	promisor_info_list_clear(&config_info);
 	string_list_clear(&remote_info, 0);
 	store_info_free(store_info);
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index bf1cc54605..3b39505380 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -387,6 +387,27 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	check_missing_objects server 1 "$oid"
 '
 
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
2.54.0.19.gb68b9497aa


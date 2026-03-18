Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1333C51D
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866439; cv=none; b=NREBGYdCa9jUxPoL9IqDcdFXcTjHCovvqspRXBvr9rOvbOjj950BQgJDhwWG4cKm5oUeRlHIGGzdHEAocJExFCsRynPQAjPFaNyjvv0EzwHeVvPqxtKXkKsJYilctBXv+JxpMWvV0M6dfOkvbWPv6Ui2OgFuMATqTc7oiMP/FNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866439; c=relaxed/simple;
	bh=2tu1a5RkLYUz50OClOxcoO+uvBZus1v8r2aoNaROUOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ejn/SveLvn10nYthEPeZXrfPXVK7h7/3uXTIwfzvIm1o0lx7RZhA24wUcEhZHCmrrn4d0DDUxpaRgomGODAG3twcGhVHU2kETsGyBXgSM4eKcIfQNU49ctxQKzjeUgOeIursGczTgWimznIPL8MAC/uvTLWxEO9a3lTEBI3E9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhqxzNZU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhqxzNZU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so4085a12.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773866437; x=1774471237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9ht4/55lpQR2e4GCgp2KR2o0KLczN/XfUgcK+DlAG8=;
        b=FhqxzNZU0N0X4SHiXOa9DMam8ERauFnacEy2l2wkXILvrMcpb9oixj5mZVwus+sDex
         8n/LI12FpYrFgOgFEjT4r7utl2u5Gql67F7TFYic/NQZ/ABztUcNjlasqVTM8c6DdOmr
         PJ2VSf1wMlc5lrBpTBN/JGSM2dFgbpMx6DQEHlCrG0iOqVA1fYS5VvP+6V3ygOMpm5Ea
         P/gxooqzV68/pVhjHFah4dTpDzpcDGnmLWegjGmEkS9fIkQ8oZ/KcsOTVfBnNiOaEbko
         2/4+eOiunLn3gaIkpXgBDNQMFZ4zNYN0Kx5frmoN5wc7EYOmOkRct65HwH1ViFKajMMS
         vnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866437; x=1774471237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9ht4/55lpQR2e4GCgp2KR2o0KLczN/XfUgcK+DlAG8=;
        b=aPTlRa6sieZn/wLaUJn1CmWf1/NnQlN6m7JjpAjrPSRw27asMI/oXMa240X6+imxYD
         lblH3Dyeto3EEf6+4gdpbR2IjEJuP0zP3dbiMPKrar+Gi3+AGtQZ0kTqK9ox5KlYFtbh
         2j9ioaAgfq3qhmTBhfGLnWjDuijqHGDsKaLRfQKBKpfuLEoxflVG/KYJvpOCXDUaYbN2
         UyOMCjsxJySt2zTe5ZIo9b0m9NqToWkQ5x0xk7nTizTeS8NjtrWHdu3dvGpuvwzFFPMU
         aJlhvk5biYbeVvQ7SR2lav3ekzBDQqkDOlYRl30sDJKMD38CprYVfYw73Y0OfTcdn+47
         N71A==
X-Gm-Message-State: AOJu0YyVfgsbqqCBy9EcRA0tpvd8IzUAWXrWhQFA+762pWhsor/Le2ig
	2+wmWC/ENYawybO1Yy1Zwxak5cEKBlh0NTC0cMdfJcxdANRAxaO6y8EjrHXijEhv
X-Gm-Gg: ATEYQzzYGYfA8nHP3dcLtbnZPZPjMAkpnia4qcgizGPlW7ycHDSIipoIcHrbf4uGv0b
	I55JOvUkTtVDzF3k6xRujDzyd+Ls/RaAgra1EWlUg83K4S1jUGCiOnqjANfhglKhCWHGNXEfCkF
	heWuHVh4hOMpayGI6vtcy3nvZccz2VRsH/5qmm0vBNB3YbwzZXwh45zo+6wcBe6jDVCCCiNVF8k
	+3mDxVOkj80RI4LMV/1mvos/X//zrPeLQOmWF9vfCBpZixrqyQjcw8N5My0OfwkDUUKA+SeATCi
	GdtwEKTsHomorTzLsP3K6pZ/NDQcs8yRSKCSQ98CWtZbBimXDl9RQ23maz5WsLKbVinZdKeDPFh
	pptuHaUs6EQ0s1rPUx1dgMFqE0rSrGxX3LBVeXesuzKQVtKcOzuuQIKXcWCL5Wg0BtK2+oETEhc
	tesbTDAE/IxODfebc7gwHUeTNC8HV0wnRQusDEFwY7b7UXDDuYvj1NW6SWJl4=
X-Received: by 2002:a05:6a20:734c:b0:398:a33a:71b9 with SMTP id adf61e73a8af0-39b9a100c82mr4282754637.48.1773866436877;
        Wed, 18 Mar 2026 13:40:36 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb96e4sm4428567b3a.35.2026.03.18.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:40:36 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v2 1/2] remote: move remote group resolution to remote.c
Date: Thu, 19 Mar 2026 02:10:27 +0530
Message-ID: <20260318204028.1010487-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`get_remote_group`, `add_remote_or_group`, and the `remote_group_data`
struct are currently defined as static helpers inside builtin/fetch.c.
They implement generic remote group resolution that is not specific to
fetch — they parse `remotes.<name>` config entries and resolve a name
to either a list of group members or a single configured remote.

Move them to remote.c and declare them in remote.h so that other
builtins can use the same logic without duplication.

Useful for the next patch.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/fetch.c | 42 ------------------------------------------
 remote.c        | 37 +++++++++++++++++++++++++++++++++++++
 remote.h        | 12 ++++++++++++
 3 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 573c295241..6e56c484bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2135,48 +2135,6 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 	return 0;
 }
 
-struct remote_group_data {
-	const char *name;
-	struct string_list *list;
-};
-
-static int get_remote_group(const char *key, const char *value,
-			    const struct config_context *ctx UNUSED,
-			    void *priv)
-{
-	struct remote_group_data *g = priv;
-
-	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
-		/* split list by white space */
-		while (*value) {
-			size_t wordlen = strcspn(value, " \t\n");
-
-			if (wordlen >= 1)
-				string_list_append_nodup(g->list,
-						   xstrndup(value, wordlen));
-			value += wordlen + (value[wordlen] != '\0');
-		}
-	}
-
-	return 0;
-}
-
-static int add_remote_or_group(const char *name, struct string_list *list)
-{
-	int prev_nr = list->nr;
-	struct remote_group_data g;
-	g.name = name; g.list = list;
-
-	repo_config(the_repository, get_remote_group, &g);
-	if (list->nr == prev_nr) {
-		struct remote *remote = remote_get(name);
-		if (!remote_is_configured(remote, 0))
-			return 0;
-		string_list_append(list, remote->name);
-	}
-	return 1;
-}
-
 static void add_options_to_argv(struct strvec *argv,
 				const struct fetch_config *config)
 {
diff --git a/remote.c b/remote.c
index f6980dc656..75fdb4019d 100644
--- a/remote.c
+++ b/remote.c
@@ -2108,6 +2108,43 @@ int get_fetch_map(const struct ref *remote_refs,
 	return 0;
 }
 
+int get_remote_group(const char *key, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *priv)
+{
+	struct remote_group_data *g = priv;
+
+	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
+		/* split list by white space */
+		while (*value) {
+			size_t wordlen = strcspn(value, " \t\n");
+
+			if (wordlen >= 1)
+				string_list_append_nodup(g->list,
+						   xstrndup(value, wordlen));
+			value += wordlen + (value[wordlen] != '\0');
+		}
+	}
+
+	return 0;
+}
+
+int add_remote_or_group(const char *name, struct string_list *list)
+{
+	int prev_nr = list->nr;
+	struct remote_group_data g;
+	g.name = name; g.list = list;
+
+	repo_config(the_repository, get_remote_group, &g);
+	if (list->nr == prev_nr) {
+		struct remote *remote = remote_get(name);
+		if (!remote_is_configured(remote, 0))
+			return 0;
+		string_list_append(list, remote->name);
+	}
+	return 1;
+}
+
 int resolve_remote_symref(struct ref *ref, struct ref *list)
 {
 	if (!ref->symref)
diff --git a/remote.h b/remote.h
index fc052945ee..8ff2bd88fa 100644
--- a/remote.h
+++ b/remote.h
@@ -347,6 +347,18 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* list of the remote in a group as configured */
+struct remote_group_data {
+	const char *name;
+	struct string_list *list;
+};
+
+int get_remote_group(const char *key, const char *value,
+                    const struct config_context *ctx,
+                    void *priv);
+
+int add_remote_or_group(const char *name, struct string_list *list);
+
 /**
  * Return the fully-qualified refname of the tracking branch for `branch`.
  * I.e., what "branch@{upstream}" would give you. Returns NULL if no
-- 
2.53.0


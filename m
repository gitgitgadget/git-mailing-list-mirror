Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF48361DB0
	for <git@vger.kernel.org>; Sun,  3 May 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822459; cv=none; b=b9Fv/qa5mRVPf9B4w+9xeXtpWgTd8JRQa8lWfxvtqth/8VDmcn0AuTPURLl1f8YYjew6FC5iPw5i/WWHKYGE7lqaSoNcS64WlFBk1zu5wYVX8cwuOkudHGIvTIShasjjA8hMuqVqIEplD0BP0eXmcL99wEJnZrXSsVPYRYAUCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822459; c=relaxed/simple;
	bh=7lIKDj/JvUUxosmyJ7SZ5ejvvqpDA1NiFfdOUXPi68A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNnxFmhu2DAumiYJcmJV5GHkrfCTcdoRSGixP0xoK4Jb6E8urAPVq7Uu6RqsDDhXAVJi3GMM1t1lJdv+7H8/scJC01hKvKCt8Mn7XMwoH8dNHF68qJNBXx95EAuNTpoGyOIMYZOgJr/l6L8NoMg4EuD57Mu8ItkVT0ZkVrZS4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahVWbcms; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahVWbcms"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2addb31945aso17717375ad.1
        for <git@vger.kernel.org>; Sun, 03 May 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822457; x=1778427257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAGC+zZIaWE1cgwd3aB5woPDrsX/3l3WyduaMn27hFE=;
        b=ahVWbcmsgbBdaTBN5RkH0iAVbEhccGcG8MUEMWfQIQyW3V5v5BbRZOWTbK7JF1OlED
         I0GkJpqlle6YmndtlWn3pIxGz2OZvdFCjRV1pR0KbwQdWz9w0jgeuOzN/DBedUsMAx6Z
         brefFa+AKwFMitpPfL7eC7+lrIDpe9AdTPW4ixdIXjKC4SCojSCi6xdZzuJWbv6m67F5
         iHEvQ/dSgef/DUa5QPIdxagnZDgrzovJjUqVA/SLglVO+Cj213wz2S+JY6brTzh3a08S
         FXlLPeK9+JXwUFMPovsK3PAfxO7IJaQvJVfaXbF1Tjsfrq2G84tU7Ddehh/J3EheXbcv
         3oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822457; x=1778427257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAGC+zZIaWE1cgwd3aB5woPDrsX/3l3WyduaMn27hFE=;
        b=FqqDRTQ5MDfPTrsCvjeVUu3r+PuJYqLl5T9uCsf5sytm1lXL4bzwMXXFjIN60oawQJ
         lAGuVQ3afxOrDPWS/B0sS3j2LMXUW/Ovzp0RX83+P4j9MhAxhSa0+jOYuQmfjWXGHBkI
         +HchGdU2cdiHMne5s/aS+OcjSbzZFXgoOnaQ/Hs4uk54V8drBaLoWW4fQ1TITimBa6cl
         a1aF7sgHahRUyiIszsxZwxl4QAFC1XE+jMltHoqXcIZZ7cqC02opgEMydGDb+ZAoLnAA
         BTmIuPURxCEJMZ7oBoMtNCPnwTe5jfFJrJjS4ry76VmrvxK1xzy5zRr49kHAoL/QqLn6
         A/+w==
X-Forwarded-Encrypted: i=1; AFNElJ9sCfxLfjsd/tYJmrWmWFDQng5FN/M6EvZwSDZ0PgRZz8XhGZBr4UbHKDMoIQ3ZPqciaAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlMKGSnL/CavUuOtUsNjouUd+NcUm6xIfYcjjUDSm2Bsx+aDG
	ly+qhvwae2fENLfRmynsyWsghVkA+aGxsAkVjM22q3vAB2RdwCe9wbqo
X-Gm-Gg: AeBDies5Q4YVfEy9fbya6EB4VzTYTKRsp1ZXmE3RR0HWatX8RKixjcWjUveiSV6xj/K
	C83Ht4pXRX9CfhkHkH3LjQpQ0USlVWy8U1unaxIR2w9wpjr1KVakN29pleMakfd3HUtpo38pyHL
	u9zgBZIc2PUfIYScrK4f3iKlf8vIcBOiB7Dy90rn4BCsIzIRPiLEGa4Xk5E3Xt/mw09X+/G5LsT
	iB99tI9OV20wH3wlBPgA39ytOiBxDSgo5hQ83tR/Efhn3VrmzmdbRmRvQRvY7zFFNuzSrljJREB
	izul70DoPTLqY6ArT85+azyXOTB8cI5ZsseKlai5d5d6eY5f3rnaxXeExYOl/bgSiMmUxnV1E6c
	ViST0fupbvJpVsHLbqx9FzImHMEyqa/zVD79UkqZFslbynvu09S8yul5cwT379gjNgpBugrMpp8
	6/T6EkgxhqOGhjTssnNyxwXbpd/M3VvO2DhO5AcqAfhV3eGRtAmEIpMYXrmAbzRHvPQ7QUJNCu
X-Received: by 2002:a17:902:ebcb:b0:2b0:c59f:3b58 with SMTP id d9443c01a7336-2b9f25561eamr61686035ad.9.1777822457385;
        Sun, 03 May 2026 08:34:17 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f0acsm74618375ad.38.2026.05.03.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:34:17 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v5 2/3] remote: move remote group resolution to remote.c
Date: Sun,  3 May 2026 21:04:01 +0530
Message-ID: <20260503153402.1333220-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
References: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
 <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
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
index a22c319467..cfb26eb284 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2138,48 +2138,6 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
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
index a664cd166a..7133d29332 100644
--- a/remote.c
+++ b/remote.c
@@ -2114,6 +2114,43 @@ int get_fetch_map(const struct ref *remote_refs,
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
index 741d14a9fc..7915be3111 100644
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


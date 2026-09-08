Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE43583AA7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885722; cv=none; b=c0aS36JSBAQkQpP06YOHwTdyn8NQRhCAje6VF6a490e225/SJauR2s/fdfLApdBmK1EwRqNSwroOQT/BXQx9+whoLxI3yggQjGNpzkVSxUvTcgTNNRD6IEf3PjkoZExuc0VSb2vzh+SEEDysEbHVm1v/bPWYgupDuzMBznmpu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885722; c=relaxed/simple;
	bh=LeqjNNHyqN5wRgR1cP9zw5hr+d2M01N6pOBpBwmjALU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjdCnCcaYWxymQQFnelrXrXNiRaSn8dgAGZkJRKbTcpVaY8ZtuEVZgFZDEDO6kG7FcZX4dso9KaO6X2E6m1BapX2w3B6+ZH2pMAF6vD2Ja3ZCt5GY8HCnfZj9ArUDzI8qinJGlpTJepsYhy+ajnxYxzFjUrwk3xJNICSse4Sua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPW+qOO7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPW+qOO7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso52697915e9.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885718; x=1789490518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcaT7XI9fWlZEg9RdhkGK3sNKW6EwPfjKHqWUgHPU1A=;
        b=YPW+qOO7mid7xdrCZHeQADp3Xhi6sfGz7oDRBeMThP2u1cPhLnKS2mo9Gr/K19QWz7
         N06AyVJnvnrW8WYg0EX8NhhKXZdMDksdA6vXxGE6L4gdpy2YFShrMeAQTg0hzLVlkFhe
         r0lT/gTLj8eTRMrdkPRn1MsKJg7M6tFkRGRUpWQOPrvmfJN9yZWQLgVcGzAfbO/u/x3P
         AVgF84qAxMNfzS6zuWolJHvczXsD4U7OrRbThWA2Dwj3aLIhSEkLFUOXjfCtViA1hgul
         /SfHzXd2l7LX7QMHMluYk/2hjLj/jKMx5xHDxtqn/lk4qMvJnnKE/XwXAE/tXYTjBOjk
         9SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885718; x=1789490518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AcaT7XI9fWlZEg9RdhkGK3sNKW6EwPfjKHqWUgHPU1A=;
        b=DFZrq1BT40lJIVpe1oU8M4DJU7M01hRWEZhRX3V+e/imPNucJIAW0hxPpAUoln47a9
         1j/BYL6FFKftCkTnYTQ5XrkyoFt/bslny7a9abe+4yUYsE0i8dZcL0Baqt4jDEpXVGIO
         TG3BuE52PZ1WDmppf5FjjpHFMiEOUwMW5u4Iu0YMY6SJ1uVTGuysbHTr4qK2tdc+WDN0
         +be0prFwKNR6ZYtOC6nAM1BVnhbXE9hh6q24N+72LzWxJTOsFYRDS6Wn1pkQFONiftbM
         nxAV3JmsrG4vyXzClXz86ZswrkIEp6FFSlTO6TDYSxIPvwJf1daLBYcj+5TgSHEqZ+Gp
         JcWQ==
X-Gm-Message-State: AFuF++m/ScwVsc3RIKNP+YyoPxGLZdQNzV5BUhPmYho6dQf+GT2UDwTL
	7u0Kv1RdXz2fQCPsk1iMgs2uRRV7LiyFvfW9HueRf3BpfHcGvU98oaZK1U2CtIxw
X-Gm-Gg: AYBFou2fJGrksdY5wF3ZSZN6IIp7Ua//hhA2YBuF87JtzNDWtX8V3RTQi0uRGTyeJwH
	Ji21Qs3zBSKMMpam4taU3ZO428oI3sk29EL1yWwrsppRQ97glP3i01BSQp2ZgMWexLiUPFT9SAL
	m/PxYc70qV1CxOkmE566zq5BdVnTwupuNmgSVZgY7OBZvYfHUwQamm4TruoPSqP3Ybf8Ox8NdQI
	4/x22402Dyiokolx+SY8J/CYKwaMefKHzqOpuucD0KWCjK4TIsSCJabOdIwDZTjj3AuUJU2PgpC
	9wQMlGKbohuotAJqyup4nDQcLqzBfErLh05odE6384+EBiX/kSn4D5ZUbF16L773V2oxW8hM4fB
	nJFK/RoB5XKaqwGJF7/5NGjwGy/ScYDxp+RbEreA+7p7YfkEGdF9d4Ca4e73+embROJdv8a0lGx
	Vj7Nh8XDx7y3Ra856OVjDv8vaPbXX08tYGMclku4xXGM/Kan4uR1adboMUmVlYQETFgM0gdJt5Z
	1+eJdqWQym/mGDGpKjWduHiskpNvdkizdlUXwr6whG6mOCiGsZUxxooWlXh1oHTt1xsUvcfk67J
	YtQH+qaZ+Ah48BMzSC0uCKvXgxzfxhZvcovU8pD+yuDRDNPCT/vkLDW/fGRVfoag4R3c1Mis4jb
	wmWA8rioHBQ==
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cf81e3454mr649945235e9.4.1788885718411;
        Tue, 08 Sep 2026 09:41:58 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:57 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/5] upload-pack: read uploadpack.lazyFetchTrusted
Date: Tue,  8 Sep 2026 18:41:27 +0200
Message-ID: <20260908164129.560396-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits created and prepared the path_allowlist_apply()
and path_allowlist_config_apply() functions, but used them only for the
"safe.directory" configuration variable.

Let's reuse these functions for a new "uploadpack.lazyFetchTrusted"
configuration variable.

It allows us to:

  - read an allowlist from that config variable,
  - check if the current repo is in that list, and
  - return the result from a new upload_pack_lazy_fetch_trusted()
    function.

As path_allowlist_config_apply() lets each caller decide which paths
it is willing to accept using a callback, let's pass it a new
allow_trusted_path() callback. Unlike the "safe.directory" callback, it
accepts only absolute paths, and not ".", as `upload-pack` always
serves a repository given by an absolute path, so there is no "current
repository" for "." to refer to.

Note that a served repository is identified by its git directory, and
not by its worktree. This is because `upload-pack` uses enter_repo()
instead of the usual repository discovery, so it never learns about a
worktree and `r->worktree` is always NULL there. In practice this
means that a non-bare repository served as "/srv/repo" has to be
allowlisted as "/srv/repo/.git".

The new upload_pack_lazy_fetch_trusted() function will be used in a
following commit.

Note that the new config variable should be read only from protected
configuration files.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 upload-pack.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.h |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 22573ad365..a300870fa9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -34,6 +34,8 @@
 #include "json-writer.h"
 #include "strmap.h"
 #include "promisor-remote.h"
+#include "setup.h"
+#include "abspath.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1343,6 +1345,63 @@ static int upload_pack_config(const char *var, const char *value,
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 }
 
+/*
+ * Only absolute paths make sense here. Unlike 'safe.directory', "."
+ * is not accepted, as the served repository is always identified by
+ * an absolute path.
+ */
+static bool allow_trusted_path(const char *path, void *cbdata_)
+{
+	struct path_allowlist_cb_data *cbdata = cbdata_;
+
+	if (is_absolute_path(path))
+		return true;
+
+	warning(_("%s '%s' not absolute"), cbdata->key, path);
+	return false;
+}
+
+struct lazy_fetch_trusted {
+	char *repo_path;
+	bool trusted;
+};
+
+static int upload_pack_protected_lazy_fetch_config(const char *var, const char *value,
+						   const struct config_context *ctx UNUSED,
+						   void *cb_data)
+{
+	struct lazy_fetch_trusted *data = cb_data;
+	struct path_allowlist_cb_data cbdata = { .key = var };
+
+	if (strcmp("uploadpack.lazyfetchtrusted", var))
+		return 0;
+
+	path_allowlist_config_apply(var, value, data->repo_path, &data->trusted,
+				    allow_trusted_path, &cbdata);
+
+	return 0;
+}
+
+bool upload_pack_lazy_fetch_trusted(struct repository *r)
+{
+	struct lazy_fetch_trusted data = { 0 };
+
+	/*
+	 * A served repository is identified by its git directory, as
+	 * `upload-pack` uses enter_repo() instead of the usual repository
+	 * discovery, so its worktree, if any, is never known here.
+	 */
+	data.repo_path = real_pathdup(r->gitdir, 0);
+	if (!data.repo_path)
+		return false;
+
+	git_protected_config(upload_pack_protected_lazy_fetch_config, &data);
+
+	free(data.repo_path);
+
+	return !!data.trusted;
+}
+
 static int upload_pack_protected_config(const char *var, const char *value,
 					const struct config_context *ctx UNUSED,
 					void *cb_data)
diff --git a/upload-pack.h b/upload-pack.h
index d6ee25ea98..b2212992c3 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -12,4 +12,7 @@ struct strbuf;
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value);
 
+/* Is this repo trusted for lazy fetching? */
+bool upload_pack_lazy_fetch_trusted(struct repository *r);
+
 #endif /* UPLOAD_PACK_H */
-- 
2.55.0.792.ged91fccac1.dirty


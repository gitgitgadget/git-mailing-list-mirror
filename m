Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCDD2FB
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669203; cv=none; b=lEIolkBQQfkZN1QlB1wBPmTgBfb8+vuy17C2TZsbpswsi4GSLChDP/65mOYoXVcmRqvqXvz0a2C78JgRtM1jl+nzjsiAnjaWxvVGz8K4TGK1mgADqLcZYtvgAQzqsYjRoXKrf1FRu1Bp21DE6TxExz5e9rozJTPfLW25l8ybNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669203; c=relaxed/simple;
	bh=wtw4IqE1Bvc2CzKKYsqjndJA50WqpmlP+DG+nS8iZ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0PvZ0DTOqQRwNwMWOMmdgyyrUF03Ay0zlTgqKfAaYKWnIz54cdtiGYneavU2yvNnuDJL7ajhye1Ehx7psVORAl6iofG/JoKVaPDdyXBwz4+bDsUvUrBKoEFXcMQHVG8urr4XEfo7o2HJHZ9IaOACWN8VGghqL5ab4UIJj5ybBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcqRLLz6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcqRLLz6"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71d50b89132so1206555a34.2
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732669200; x=1733274000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhauHutODHFANCW4hs0xz+fYr1BuPMFJVuyibdfT4/A=;
        b=fcqRLLz6mO8BCjvC/Aszd7HRkwWABHFlzHTMCnJTryJ1vJpZXU0DiqHxJWDrBh/syx
         hskua3DTOXmNUCweI/D2wpaxf980fRL4ETjPR5owas4jAOPv6h5ZwMoeywJSnYfpyMHd
         VaeK9mmJ2jK714xOWVKigzALWTSd4srPciC4GyLNDM0HRVNkHc0lvIq4SCPtK9v8Ll/P
         usdcVsSz1s9bQKZAjJTy0UXGgYhnfKut6do1vsUT/ccbV7tL20V05g4yQyri+QJuA+AQ
         h9jgcoRjx+aW7c+uIVI3CmHJIV/HpEfujBopWWMIzsTuzAQDmMGWowzJBXCsSB95Q+GK
         YU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669200; x=1733274000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhauHutODHFANCW4hs0xz+fYr1BuPMFJVuyibdfT4/A=;
        b=clwLtQYisTs+yOO4CWN55WwjiJqHUmMduJy+8nzFHSCeTtOnAZlaUDoyRwaCbGhAaO
         /Yh097Rb3+ZIBaaDAnIeebF1E6zdI3/jOWpS53jVsQi+CesNISmvEG11+Mgn3GruByRm
         Q/1m91VEcpoKQd52V2Wby4hR+n8JxrzWSrHasUxnoFnsyMADrGQ8hVDtISyBoxYoSSrx
         RtzGICkQdcvMp7VZrLtI04uWwKAwAel3wmIw/0nLNDbsFn6LsYvFruT/m5fUTXzi5oJT
         C2InO+sAY67ZP94HoQkqE20/yna3tBwO4XhnD9b0G1KP+zVlfoS0evFBrYs5lyQaSoEu
         poQw==
X-Gm-Message-State: AOJu0YyGZOGn1iyVfCRF0A+rq4A01kNVzPAFjEEYZ8PxVMA8XKXdzai3
	dHuA27ZnoRS/l2ogear2dAY4+wpAFoLE0ZqEz3SinS0RZgg/2os7qOrJHA==
X-Gm-Gg: ASbGncu8XMPgh5x6ZYLtt9eCrOqy6d2JXQ2Tms4dAH6u5XJcSulalB5j0ztrpzasbJv
	m3dLQY6VG0QwYQMy9hj1uYT0ug3+UL7zaX/+AbEc3Lj0wORiTIsI7UyK+6Iis3recihcpqIiA+q
	lYmqtW8HO4vuvHuG8XlOqrY2kMfYjVUWkT7/qnMhSDulK7Pe/zZkxXE+3D/dO0SRPi7tgbp1653
	mB6SfGLPNvJDyOg6DZnNoFdonUFii7zTcCOTtJYiOb+IQBjoy7Sge4guw==
X-Google-Smtp-Source: AGHT+IHAPwJapobjdgJPp5L+cMFdgUNDvhTa+JAQbmtgd06zb8/h2drNj01YpHYtbKxzPUaaL08ZgA==
X-Received: by 2002:a05:6830:6f8c:b0:71d:4385:665e with SMTP id 46e09a7af769-71d65c93a1bmr587684a34.9.1732669200104;
        Tue, 26 Nov 2024 17:00:00 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378d26esm3316643a34.31.2024.11.26.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:59:59 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/4] bundle: add bundle verification options type
Date: Tue, 26 Nov 2024 18:57:04 -0600
Message-ID: <20241127005707.319881-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127005707.319881-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `unbundle()` is invoked, fsck verification may be configured by
passing the `VERIFY_BUNDLE_FSCK` flag. This mechanism allows fsck checks
on the bundle to be enabled or disabled entirely. To facilitate more
fine-grained fsck configuration, additional context must be provided to
`unbundle()`.

Introduce the `unbundle_opts` type, which wraps the existing
`verify_bundle_flags`, to facilitate future extension of `unbundle()`
configuration. Also update `unbundle()` and its call sites to accept
this new options type instead of the flags directly. The end behavior is
functionally the same, but allows for the set of configurable options to
be extended. This is leveraged in a subsequent commit to enable fsck
message severity configuration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/bundle.c |  2 +-
 bundle-uri.c     |  7 +++++--
 bundle.c         |  6 +++++-
 bundle.h         | 10 +++++++---
 transport.c      |  6 ++++--
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 127518c2a8..15ac75ab51 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -218,7 +218,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args, 0) ||
+			 &extra_index_pack_args, NULL) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 0df66e2872..cdf9e4f9e1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -367,6 +367,10 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	struct string_list_item *refname;
 	struct strbuf bundle_ref = STRBUF_INIT;
 	size_t bundle_prefix_len;
+	struct unbundle_opts opts = {
+		.flags = VERIFY_BUNDLE_QUIET |
+			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0),
+	};
 
 	bundle_fd = read_bundle_header(file, &header);
 	if (bundle_fd < 0) {
@@ -379,8 +383,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * a reachable ref pointing to the new tips, which will reach
 	 * the prerequisite commits.
 	 */
-	result = unbundle(r, &header, bundle_fd, NULL,
-			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
+	result = unbundle(r, &header, bundle_fd, NULL, &opts);
 	if (result) {
 		result = 1;
 		goto cleanup;
diff --git a/bundle.c b/bundle.c
index 4773b51eb1..485033ea3f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -628,9 +628,13 @@ int create_bundle(struct repository *r, const char *path,
 
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags)
+	     struct unbundle_opts *opts)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	enum verify_bundle_flags flags = 0;
+
+	if (opts)
+		flags = opts->flags;
 
 	if (verify_bundle(r, header, flags))
 		return -1;
diff --git a/bundle.h b/bundle.h
index 5ccc9a061a..6a09cc7bfb 100644
--- a/bundle.h
+++ b/bundle.h
@@ -39,6 +39,10 @@ enum verify_bundle_flags {
 int verify_bundle(struct repository *r, struct bundle_header *header,
 		  enum verify_bundle_flags flags);
 
+struct unbundle_opts {
+	enum verify_bundle_flags flags;
+};
+
 /**
  * Unbundle after reading the header with read_bundle_header().
  *
@@ -49,12 +53,12 @@ int verify_bundle(struct repository *r, struct bundle_header *header,
  * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
  * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
  *
- * Before unbundling, this method will call verify_bundle() with the
- * given 'flags'.
+ * Before unbundling, this method will call verify_bundle() with 'flags'
+ * provided in 'opts'.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
-	     enum verify_bundle_flags flags);
+	     struct unbundle_opts *opts);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 47fda6a773..8536b14181 100644
--- a/transport.c
+++ b/transport.c
@@ -176,6 +176,9 @@ static int fetch_refs_from_bundle(struct transport *transport,
 				  int nr_heads UNUSED,
 				  struct ref **to_fetch UNUSED)
 {
+	struct unbundle_opts opts = {
+		.flags = fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0,
+	};
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
@@ -186,8 +189,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args,
-		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
+		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
-- 
2.47.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C8AC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbiETSlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352961AbiETSlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745ED201A4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so12594133wrg.12
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9R/4fxQBUYGk8a35SKSaJTQD4v0GEn8fvOmPENFinj0=;
        b=bdQRKBYi08+aL018ZAjjILscpDfEGW91VWjn+vtM3X/IFvRhOs4pt4PLXJ3qHgCS4A
         ttx+2LS+aDizWBpbr7EGPvHO9aTEOFn8wHApoC6tEnNn70AgvvYZsGvydnUkYeanog0D
         0azGo/m46KIh3OfOQu0eQ+ZJwvgOccQC3oLPQbBueCzQ2kbzlOfXDyg+HpbsUHqbOdYB
         lTfYAU+siyDk/nWnU4mF8aDJaPVypf8iPq3gPDVPdr5/v04OiDZ/mIr3DdzCOyTIYM1N
         v1pTeuBFEd7QyFZZwJOeZq33Eotd0wMJUFT3S970M1lUidEzYpfZD1U2tbATtuWgpIj1
         BNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9R/4fxQBUYGk8a35SKSaJTQD4v0GEn8fvOmPENFinj0=;
        b=XDOKL3/d6Suo1aEQM5lshx+yljg5h/exZeKAjDdDgQaACFmOkrfCNmOPio4XTcDZj1
         2M6NeYo1lx5sCs2T5Fx4FQLR9XPWKyrpTlHfFgSCLRecLzjUWC0XZDJNCQXKzycCVUQX
         cVSmw+Rly+fwBvlG0MP8pTGaZKtfh1+iNNTezeA75tv6NDER5JU3xpmQt1g6CePxcFSY
         8ZqXeraVww7i2yI11qP/5hFt0XuW7aHNMHmTrAdPn/zdl8gC/SZwdC0QFucHTQz6r8eY
         Ux5d58LgVWk5lNnP9HwcoS5bZxKrI27g2yq6hBpEls7RXnZ+F8UGZuVkeB624J9xmG/e
         L1lw==
X-Gm-Message-State: AOAM5336YBGB3A/al/BT21jFS/819EC+VoIG54Mac+k5rMyFqeC4GdPU
        Q44tSoFuEON0S3mQZXOW/U9KiqnLoOs=
X-Google-Smtp-Source: ABdhPJzYFx54IEGbXn+JiX8W8U4HxtjHWMbUSqU8hdCgquHqC6q4N21n31s12ssdTtNzXmyhj8IxFw==
X-Received: by 2002:a5d:644e:0:b0:20e:7267:9ef7 with SMTP id d14-20020a5d644e000000b0020e72679ef7mr6270411wrw.520.1653072048051;
        Fri, 20 May 2022 11:40:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020adfa3c7000000b0020d0cdbf7eesm3204276wrb.111.2022.05.20.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:47 -0700 (PDT)
Message-Id: <cb270ece66d2ef7435a8f0987008935d51fb9b3a.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:21 +0000
Subject: [PATCH 03/24] bundle-uri: create basic file-copy logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Before implementing a way to fetch bundles into a repository, create the
basic logic. Assume that the URI is actually a file path. Future logic
will make this more careful to other protocols.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile     |  1 +
 bundle-uri.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h | 14 ++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Makefile b/Makefile
index f8bccfab5e9..8f27310836d 100644
--- a/Makefile
+++ b/Makefile
@@ -887,6 +887,7 @@ LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
+LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += cbtree.o
diff --git a/bundle-uri.c b/bundle-uri.c
new file mode 100644
index 00000000000..91aba061833
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,92 @@
+#include "cache.h"
+#include "bundle-uri.h"
+#include "bundle.h"
+#include "object-store.h"
+#include "refs.h"
+#include "run-command.h"
+
+static void find_temp_filename(struct strbuf *name)
+{
+	int fd;
+	/*
+	 * Find a temporray filename that is available. This is briefly
+	 * racy, but unlikely to collide.
+	 */
+	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	if (fd < 0)
+		die(_("failed to create temporary file"));
+	close(fd);
+	unlink(name->buf);
+}
+
+static int copy_uri_to_file(const char *uri, const char *file)
+{
+	/* Copy as a file */
+	return copy_file(uri, file, 0444);
+}
+
+static int unbundle_from_file(struct repository *r, const char *file)
+{
+	int result = 0;
+	int bundle_fd;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
+	struct strvec extra_index_pack_args = STRVEC_INIT;
+	struct string_list_item *refname;
+	struct strbuf bundle_ref = STRBUF_INIT;
+	size_t bundle_prefix_len;
+
+	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
+		return 1;
+
+	result = unbundle(r, &header, bundle_fd, &extra_index_pack_args);
+
+	/*
+	 * Convert all refs/heads/ from the bundle into refs/bundles/
+	 * in the local repository.
+	 */
+	strbuf_addstr(&bundle_ref, "refs/bundles/");
+	bundle_prefix_len = bundle_ref.len;
+
+	for_each_string_list_item(refname, &header.references) {
+		struct object_id *oid = refname->util;
+		struct object_id old_oid;
+		const char *branch_name;
+		int has_old;
+
+		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+			continue;
+
+		strbuf_setlen(&bundle_ref, bundle_prefix_len);
+		strbuf_addstr(&bundle_ref, branch_name);
+
+		has_old = !read_ref(bundle_ref.buf, &old_oid);
+		update_ref("fetched bundle", bundle_ref.buf, oid,
+			   has_old ? &old_oid : NULL,
+			   REF_SKIP_OID_VERIFICATION,
+			   UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	bundle_header_release(&header);
+	return result;
+}
+
+int fetch_bundle_uri(struct repository *r, const char *uri)
+{
+	int result = 0;
+	struct strbuf filename = STRBUF_INIT;
+
+	find_temp_filename(&filename);
+	if ((result = copy_uri_to_file(uri, filename.buf)))
+		goto cleanup;
+
+	if ((result = !is_bundle(filename.buf, 0)))
+		goto cleanup;
+
+	if ((result = unbundle_from_file(r, filename.buf)))
+		goto cleanup;
+
+cleanup:
+	unlink(filename.buf);
+	strbuf_release(&filename);
+	return result;
+}
\ No newline at end of file
diff --git a/bundle-uri.h b/bundle-uri.h
new file mode 100644
index 00000000000..8a152f1ef14
--- /dev/null
+++ b/bundle-uri.h
@@ -0,0 +1,14 @@
+#ifndef BUNDLE_URI_H
+#define BUNDLE_URI_H
+
+struct repository;
+
+/**
+ * Fetch data from the given 'uri' and unbundle the bundle data found
+ * based on that information.
+ *
+ * Returns non-zero if no bundle information is found at the given 'uri'.
+ */
+int fetch_bundle_uri(struct repository *r, const char *uri);
+
+#endif
-- 
gitgitgadget


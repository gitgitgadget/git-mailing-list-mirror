Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832BC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiFFTzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiFFTzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013764D11
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso8423004wmr.5
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JJkBD4+BoKpJTXlEBLl6bQZVX+aCJpdJfA0oOWbRDZM=;
        b=PLGOMOHyXJNnAXxnwFHtKQeaZvp+tK4M5r+8nTskqhIPh9OFE/ayKy2nMtmkcY92d2
         4kVi+hi4imzMKJce5B0aQ7XRylD7QSeTR0f+jF6hIKMSPTwNUqbVlXNEiPzLwuzn/cRe
         jY1AKdWg9AcT4XTw6jYg/Qc3GwlIgDZnrObYMuEEMN1JWKEsin/rldKEGSA6BQ3qvL8u
         PoJDXdziyLPsaoaymsbyVGAB7VM8O4/qJ+nK488Llz1r6HQ31fODipL1GK+Pd/ZjjD2s
         FrVmxaKiTiwJqmsHBehgKlJtzoUXNZZnQddgRhookz5NipZcouNelHqWnKqxZdAbGsY9
         aDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JJkBD4+BoKpJTXlEBLl6bQZVX+aCJpdJfA0oOWbRDZM=;
        b=brPaPq8Wu1qtNDbj0U8698wG0ZgtxqfMHH0qoZg4yLm4qzq6YEDrDKh1gf+0GjUirs
         kLxAFy7VGnnx1Rkepl+1J0X+bi4BHr8wPzK6LMYHZD4zTpfJ1ZsP9qJKrYPRv0WtmLsM
         +ej0bULrLiEyYXi3/tILc3LGUJCWp2EAuojApq6CiFAWuqQi9KC/21K3fwMosoNSRbWr
         txY5cRp9mM78C/1rA3tUBWPwRRnMXJmRpJowUjRaHzmvRy+9lXa4qcInHQzWeoDW5RxR
         V8wSBWwkZZYGeZEBwX9JfjuMh0qR2C11s0e37v7GBDfl/aAOVhAbkuk/wJvC4fxD7lbS
         nGFQ==
X-Gm-Message-State: AOAM531hTzRTqZERERWp4mx64DwElc9UgWeTHWU/QmS7vuKgHqKkBrRK
        W9q+TzcqWMh9laZtE1wFTUQY4Cupcag9Ign3
X-Google-Smtp-Source: ABdhPJxVFf/o2rzBMdJG6OT+x3lbkJdRS/QpT3/nDJ77v157gGFUvJrIwcJ5laubmhFDf4wVFPt+pw==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr24600011wme.67.1654545329901;
        Mon, 06 Jun 2022 12:55:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a1ced13000000b0039c1396b495sm18231343wmh.9.2022.06.06.12.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:29 -0700 (PDT)
Message-Id: <8a18acfbf05aca39c36302d0f5b7d1f7516f2113.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:22 +0000
Subject: [PATCH 3/6] bundle-uri: create basic file-copy logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Before implementing a way to fetch bundles into a repository, create the
basic logic. Assume that the URI is actually a file path. Future logic
will make this more careful to other protocols.

For now, we also only succeed if the content at the URI is a bundle
file, not a bundle list. Bundle lists will be implemented in a future
change.

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
index 00000000000..07b4bfe4e11
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
+	return copy_file(file, uri, 0444);
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


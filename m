Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0513CCA480
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiF2UlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiF2Uky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:40:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05222BCA
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e28so19026728wra.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E9/oMI4dsBmcNSvs8M36D0xpQNTO1EU7UAeRS2R3MT8=;
        b=VhpN7kwez0vsKYKw99Z/jES3EamqxwLVN6iV2PYtQ1BkDNHpk8cMAb75r+kZt9oZSz
         +Ksb1GhofP9UKOai/m+KTFcquP6zubJzvP0/a0R0WEdpZVmQHwx/fWwIKG/Lg/cOerZc
         n4eX6fObKgeEv7k2FpOQkSj5/iW53yGjrluAQ7uHP7LS3N/f1DnTj07w+AM+31Yl2Myv
         r8pO0Sx5BumoQ+RPvMcOZcZjb8GZHxlKZcAxesg8ZOWfvSQK8F/EeHC3U4azb/p4iDd+
         n7V5tsE3ndqBiraAi1xSoEvBoMRhdJmc7jv2T2t64wWZ06QMQ7ilPwTQo+hHgRkCfxZi
         abIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E9/oMI4dsBmcNSvs8M36D0xpQNTO1EU7UAeRS2R3MT8=;
        b=Evy38R7VfQSs9QC7rWmpUuwooRARsCDSLE5tNbN3aJ0sSxjbD1MAuTbA90/CB2bDki
         b6kRcy6NWsuD6d/+92Aq8JoJB1lg5KTATowYkbnFZ7s/nrfUjVwe/lUuQgoxvIDitqI/
         FYriGTf5Nru6N44kKmNnZuvPnWCtXPkrLCQcxuA/+KZHdVgWAHh1iHI8vWZnq1CZ7jVp
         bubtnfwoiTi1NbnQpZdLAPhoBwzvNZ8VLDT2UI8re9hHWKSyKlEu758HGf5taqnOxRLw
         9sqyL/B4zqOc55rrCJXnvSJwTMMZpQkF+ZgSiYP6uFvdkFdIMtzW4Wt9F45tp31Uf8ef
         IigQ==
X-Gm-Message-State: AJIora89elS3k3eGv2Rwyqp73C1m/nZSKqUB9CZroBxQN+6yzwYjo0fx
        jZYqETRPM3HfxvwDPd7IEAWunvfw29WDWQ==
X-Google-Smtp-Source: AGRyM1sz6Hpn7QhqdRRqqzLBFqO/L8riDiw0EC0A/arI5waIU8XMjMbO2eJ4ShGcFFwG+eNcSDMT2Q==
X-Received: by 2002:adf:d1ea:0:b0:21b:a6cb:fcf6 with SMTP id g10-20020adfd1ea000000b0021ba6cbfcf6mr5003839wrd.477.1656535251094;
        Wed, 29 Jun 2022 13:40:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b0039c457cea21sm4187353wml.34.2022.06.29.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:40:50 -0700 (PDT)
Message-Id: <abec47564fd9cea5ef9d8f112e90368681a4e066.1656535245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 20:40:42 +0000
Subject: [PATCH v2 3/6] bundle-uri: create basic file-copy logic
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
 bundle-uri.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h | 14 ++++++++
 3 files changed, 108 insertions(+)
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
index 00000000000..f0abbf434c8
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,93 @@
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
+	 * Find a temporary filename that is available. This is briefly
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
+	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))
+		return 1;
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


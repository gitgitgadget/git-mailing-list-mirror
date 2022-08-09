Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B65C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiHINLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbiHINLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:11:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D757513D79
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:11:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so14265941wrs.9
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=hjSXw2K7hcxJrsGK0XrsEAkQYSIrIWRaUdxf9463oJI=;
        b=HvEKNH781ckHFrHSkctW7K9KSxFYvcWvNyQuBTgIKPVeyOldTXhMJvsrjHvk77Wegp
         rSgRne9QartkoaVMa3OpnENZLyg9bAZHgwc58asYSJw3GlAO9uiT+roPYvOZ/OKoiXrW
         0AY6WRXzrfUsDAzdbMuNGTANDs7D+/S+ZIqYOdfAlIX+lMwc3+m0bvAbNZFlScUwvZRB
         owatW07DLD43bjmbCwkEmcbOHcAZemWsZ37ksyPxKIhpm6uls6y8qw4yFcp8VahOI+x5
         Zgl2IRtGtr/OlhY0/Qq4PSszwBD0BmxOoNzTZIhi+4H84cAfiM3hUOrnzxkX0iNKlV6J
         ChyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=hjSXw2K7hcxJrsGK0XrsEAkQYSIrIWRaUdxf9463oJI=;
        b=HvF7rLldLJk06+X2Zv8FvBJB0tQByCywHnD9p/d8yojOWI8DOGLIe89IV8oOtCV5Nx
         sNankPFYW0lsOPzF41ep7/KZzNGKJDlSLFQpsRRJNTS+TWjKc0ZuedECet8I+0odf618
         mbQ5Tnb0m+C5yaQuhmEPs1h4Hu3L7vRMCelYNTViVMU4fOXs6iVQ8Ut4+Fn5ysxfw0Di
         J6wJpu0AbY13Wh1moZPTSqbXIj/STYJdQ/t0P3vVwt8MhIP5coulV+Sx0NmdOk6+hlbR
         jgSj8sXRvTmc4CX6o1emI2RVyO3MmocEYM2J2yg6uo3izwasL61y+NWOhbMp+/GFSPj/
         7v7g==
X-Gm-Message-State: ACgBeo2j3rf22dcIrUQe0O5khbWGN6zEtSz9BLwHRX1kh14ribD5rF9v
        nUAao4twgzjMnKqDCGJWbC3R9M1dWsg=
X-Google-Smtp-Source: AA6agR6Z2rkUPIa3nIq27CG+jNni9LCa9Oj7mS8Jzsm7Pn6FdnJMI0L66rXPKgJIy3rRjMI1SoR/Qw==
X-Received: by 2002:adf:fc11:0:b0:220:79df:d2c4 with SMTP id i17-20020adffc11000000b0022079dfd2c4mr13934183wrr.481.1660050709734;
        Tue, 09 Aug 2022 06:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003a02cbf862esm16485116wmi.13.2022.08.09.06.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:11:48 -0700 (PDT)
Message-Id: <6a6f1a04889ac475dd9c07e98f2ffc4b677e8e40.1660050703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:11:40 +0000
Subject: [PATCH v3 2/5] bundle-uri: create basic file-copy logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
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

Note that the discovery of a temporary filename is slightly racy because
the odb_mkstemp() relies on the temporary file not existing. With the
current implementation being limited to file copies, we could replace
the copy_file() with copy_fd(). The tricky part comes in future changes
that send the filename to 'git remote-https' and its 'get' capability.
At that point, we need the file descriptor closed _and_ the file
unlinked. If we were to keep the file descriptor open for the sake of
normal file copies, then we would pollute the rest of the code for
little benefit. This is especially the case because we expect that most
bundle URI use will be based on HTTPS instead of file copies.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile            |   1 +
 bundle-uri.c        | 104 ++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h        |  14 ++++++
 t/t5557-http-get.sh |   2 +
 4 files changed, 121 insertions(+)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Makefile b/Makefile
index 1624471badc..7d5f48069ea 100644
--- a/Makefile
+++ b/Makefile
@@ -906,6 +906,7 @@ LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
+LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += cbtree.o
diff --git a/bundle-uri.c b/bundle-uri.c
new file mode 100644
index 00000000000..b35babc36aa
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,104 @@
+#include "cache.h"
+#include "bundle-uri.h"
+#include "bundle.h"
+#include "object-store.h"
+#include "refs.h"
+#include "run-command.h"
+
+static int find_temp_filename(struct strbuf *name)
+{
+	int fd;
+	/*
+	 * Find a temporary filename that is available. This is briefly
+	 * racy, but unlikely to collide.
+	 */
+	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	if (fd < 0) {
+		warning(_("failed to create temporary file"));
+		return -1;
+	}
+
+	close(fd);
+	unlink(name->buf);
+	return 0;
+}
+
+static int copy_uri_to_file(const char *file, const char *uri)
+{
+	/* File-based URIs only for now. */
+	return copy_file(file, uri, 0);
+}
+
+static int unbundle_from_file(struct repository *r, const char *file)
+{
+	int result = 0;
+	int bundle_fd;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
+	struct string_list_item *refname;
+	struct strbuf bundle_ref = STRBUF_INIT;
+	size_t bundle_prefix_len;
+
+	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
+		return 1;
+
+	if ((result = unbundle(r, &header, bundle_fd, NULL)))
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
+	if ((result = find_temp_filename(&filename)))
+		goto cleanup;
+
+	if ((result = copy_uri_to_file(filename.buf, uri))) {
+		warning(_("failed to download bundle from URI '%s'"), uri);
+		goto cleanup;
+	}
+
+	if ((result = !is_bundle(filename.buf, 0))) {
+		warning(_("file at URI '%s' is not a bundle"), uri);
+		goto cleanup;
+	}
+
+	if ((result = unbundle_from_file(r, filename.buf))) {
+		warning(_("failed to unbundle bundle from URI '%s'"), uri);
+		goto cleanup;
+	}
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
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
index 09fb0bd9a8a..76a4bbd16af 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -2,6 +2,8 @@
 
 test_description='test downloading a file by URL'
 
+TEST_PASSES_SANITIZE_LEAK=true
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
gitgitgadget


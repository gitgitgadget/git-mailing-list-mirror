Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44107C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiHBM3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiHBM3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0734251409
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z12so7594931wrs.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hjSXw2K7hcxJrsGK0XrsEAkQYSIrIWRaUdxf9463oJI=;
        b=dOZRV4Q/kERCyAst7pzoPEihmgOJgaidr3iZvsmT5jPpM6pvZ1aqX06LCtzTzYyAe9
         v/RPPd2owpUd/3CMYgOwP2apMqmX485QRRODyyjathhHLKRN9Q6HQLAxW2qS+GW66Kd9
         Pkd1wBGTk4TTdl34cEImvtqKgX3kXzrdboewjhDp9o21wvOVq+YtgUAbCBAmtGvVM/ot
         zw5sCma6DCl64y4fkhtl8usyeDy1f3wiiURYO1XMt2prn4hdncOzM+OfmVmsUj4uVuvP
         FLMfcQbPu/U40L0SiHjCdqKkTaPA+cfpHlc4BobqvkJvIUTuA8IDF86rW9PgjHPuQZg7
         WctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hjSXw2K7hcxJrsGK0XrsEAkQYSIrIWRaUdxf9463oJI=;
        b=MITjEIIyw9cc7IyjMJwMajUyIxF1dEUvNyhT0PthsLmsJ3BJwHz+m4EMswdz+ize6E
         8R//LGGWSkemB71/XlicMDiM4MtJJCww13lHOmtalXnS9nnEk7w0UWWvWecTpXuh8bKU
         yjtA7eAqi65yH8DXTn8Att1iAH/7Qc15fvQ9edyS1T4/abC0vSnL/0hm8WrvhA6t18qj
         keS4nQKx2bj720fWvFxZ608JWiMH7IJs3pKPM03JGEnAhDHOqwBjIuyMHUzqMrcG7T8t
         6Zpq5K3zqFa007gD7BAk3R1MVK3rIJqDbSroKILzJFX/0TFyFu7lrVxY83qH3WfX6a48
         A9ig==
X-Gm-Message-State: ACgBeo0LM4GygBBS34X2ocqKG3hzSWqLNllWfQyGuedAZeAZ9Y2dhn6y
        6ORSeqOVtAESgKWF5jrD4BhlReka/w4=
X-Google-Smtp-Source: AA6agR5hR7ug5gYNU9ustu7Hgi9QC2sOgEzcOQh/4Ue2Dn+6uPSZFB4IuuWLM262MFrF4SnogDXv6g==
X-Received: by 2002:a05:6000:1a89:b0:21d:ab1a:b177 with SMTP id f9-20020a0560001a8900b0021dab1ab177mr13048745wry.594.1659443388240;
        Tue, 02 Aug 2022 05:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c22c700b003a03e63e428sm27333450wmg.36.2022.08.02.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:47 -0700 (PDT)
Message-Id: <6a6f1a04889ac475dd9c07e98f2ffc4b677e8e40.1659443384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:41 +0000
Subject: [PATCH v2 2/5] bundle-uri: create basic file-copy logic
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


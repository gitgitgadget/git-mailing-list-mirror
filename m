Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571961DA628
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515646; cv=none; b=ZeTyszDJmDHUllRXBiuFgsQVO1HbJnWrUuEhfUEzWSsAIc9MB1y9sJWgKfdF43ZXA2YSYKbtZ2UELfF/VMtkTS1YJGl0cbkowWeBNiAZJq380fJztNi4DLUuczSeCHo/s+DYTEqf/7CCTkcXeQXUQ/+DjiU/GBkF4xaAFMDkTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515646; c=relaxed/simple;
	bh=kU29hKVhRZwrrWsJA0/eQCyqgtkcsqU/cxJipJqp0hw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P8ZPaogqe2yss8xlSnsP4MZ9UIKfAmACk0MIAzVg22EkkxXBJxFPWoH/aKFx+Cck961BeRC2hxOBCciZaJ7h4I9o8LtDxnxQYf8A6DUhEXcfX3wUe7F/nxv9pSPpTXN5/v2zV5HUS8MF1ytoKXWNVaYSCOZfZzdsxwICtMMqXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqdJp/ax; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqdJp/ax"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a736518eso27991225e9.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515642; x=1734120442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yyQDvfg142tl2Qma8RPQq3mdCt31snFq2U/7W0/pZQ=;
        b=KqdJp/ax0hZE6ihqMPZPG1gHzuNvjUWGBocPUZceVZgaSHpA8kAri/hPRFqqXlmRt+
         LdnoqgsNvmgnxlUwD14BHIqk+kx147YckX8mr/JgiGDypDC8RqYI7Q7cvtfTWMv21yxI
         qgVqKmdL8tYOpjIfIYBmsMKHle7PrnwVyHkpV3jPVogAnJCZCaEinY5bnkP/7I0saRUp
         +1kUc5tDdkszDpI9uxXAl64W6eTU45/Lf7hLNjVFllzvKKqZwYPRgHgxZGgP1nCLt3fT
         BuiSgeUjpRqeMepdTeobn46l51Kg21WFJB31uja/YQwZxsIbiogXW7tc2VWxlMpXAjJQ
         WsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515642; x=1734120442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yyQDvfg142tl2Qma8RPQq3mdCt31snFq2U/7W0/pZQ=;
        b=Q+H0Li/Zfm000+CSpKK3J1qm/voLEZI2rvoQitWOWp267uqtQ7lTpPz2kGB1HU7Mr4
         PE/z6gOd/6dwUc7evixnQHXbc181oNgM3xkdLjzHHtA/7zSa/JmtQvYxezNC+tRhzf0S
         AI8UTOptEiBVcILAkVNbVk3qgdfca/Wyq/vmLSKrnES0sHBswe7Zibb6gOion5/3jymk
         sgoWQ3snY3YDS1Igq4gwjbybvAhG4D/LStSaw5YbCpXF49yTiGbNpTGh6OZssiaDNzWP
         WcD9B42y+nyPfo95Z7i27Sd4w8IrovDnCsU+vNLLEZEnAMKNWlDiW1U8dlmEQB9maD/B
         d4oQ==
X-Gm-Message-State: AOJu0Yx2AipGEaz+qX26Y0FuAPJNDU6C6jEFouNSYgoUT1ocYC3muvR5
	saeklPdsLfEoYIfGFX9klpp3NX8zKqjUMH4o6LlRL27rFS9LvDbE54dKyg==
X-Gm-Gg: ASbGncvgcX0Lb/c/5VxX9Mf50jlf5vczeYaufRIZz7K6ATNAnfvrRCErJLeP4+O81EH
	wfDXBlngsp53mp4SunnKEhAQ1tzrhwMcdrXQDueVXGHr/6UyMVfdpziqEDInJfXHVdx2jaJW0Mf
	D7tv4KbKKztm3/EAQf5kdVDC+hv2uTpcerX8oSt/X8D7RNwgAiEu3YMMCi10Lwgz1+o0LCm3iBt
	rs0HcewNTOWvD3pBqPqZ9XOHIDC057pKndyVWKmogvaIQ1ErI0=
X-Google-Smtp-Source: AGHT+IGUXDFFDEZm2Ap4ltD1Mjqgv+w0hQzjkxdWgBeQ5RVMJ1LaM+vG92bDXGwbFQ7fFAqF97rSLg==
X-Received: by 2002:a05:600c:1f8c:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-434ddeb516emr45282085e9.12.1733515641749;
        Fri, 06 Dec 2024 12:07:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526c059sm101479475e9.5.2024.12.06.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:21 -0800 (PST)
Message-Id: <5728dd2702195b7ba3a208859f114e40ba2b6bbd.1733515638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:15 +0000
Subject: [PATCH 2/5] backfill: basic functionality and tests
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The default behavior of 'git backfill' is to fetch all missing blobs that
are reachable from HEAD. Document and test this behavior.

The implementation is a very simple use of the path-walk API, initializing
the revision walk at HEAD to start the path-walk from all commits reachable
from HEAD. Ignore the object arrays that correspond to tree entries,
assuming that they are all present already.

The path-walk API provides lists of objects in batches according to a
common path, but that list could be very small. We want to balance the
number of requests to the server with the ability to have the process
interrupted with minimal repeated work to catch up in the next run.
Based on some experiments (detailed in the next change) a minimum batch
size of 50,000 is selected for the default.

This batch size is a _minimum_. As the path-walk API emits lists of blob
IDs, they are collected into a list of objects for a request to the
server. When that list is at least the minimum batch size, then the
request is sent to the server for the new objects. However, the list of
blob IDs from the path-walk API could be much longer than the batch
size. At this moment, it is unclear if there is a benefit to split the
list when there are too many objects at the same path.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt            |  24 +++++
 Documentation/technical/api-path-walk.txt |   3 +-
 builtin/backfill.c                        | 104 +++++++++++++++++++++-
 t/t5620-backfill.sh                       |  94 +++++++++++++++++++
 4 files changed, 221 insertions(+), 4 deletions(-)
 create mode 100755 t/t5620-backfill.sh

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 640144187d3..0e10f066fef 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -14,6 +14,30 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
+Blobless partial clones are created using `git clone --filter=blob:none`
+and then configure the local repository such that the Git client avoids
+downloading blob objects unless they are required for a local operation.
+This initially means that the clone and later fetches download reachable
+commits and trees but no blobs. Later operations that change the `HEAD`
+pointer, such as `git checkout` or `git merge`, may need to download
+missing blobs in order to complete their operation.
+
+In the worst cases, commands that compute blob diffs, such as `git blame`,
+become very slow as they download the missing blobs in single-blob
+requests to satisfy the missing object as the Git command needs it. This
+leads to multiple download requests and no ability for the Git server to
+provide delta compression across those objects.
+
+The `git backfill` command provides a way for the user to request that
+Git downloads the missing blobs (with optional filters) such that the
+missing blobs representing historical versions of files can be downloaded
+in batches. The `backfill` command attempts to optimize the request by
+grouping blobs that appear at the same path, hopefully leading to good
+delta compression in the packfile sent by the server.
+
+By default, `git backfill` downloads all blobs reachable from the `HEAD`
+commit. This set can be restricted or expanded using various options.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 7075d0d5ab5..1fba0ce04cb 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -60,4 +60,5 @@ Examples
 --------
 
 See example usages in:
-	`t/helper/test-path-walk.c`
+	`t/helper/test-path-walk.c`,
+	`builtin/backfill.c`
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 38e6aaeaa03..e5f2000d5e0 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,16 +1,116 @@
 #include "builtin.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "parse-options.h"
 #include "repository.h"
+#include "commit.h"
+#include "hex.h"
+#include "tree.h"
+#include "tree-walk.h"
 #include "object.h"
+#include "object-store-ll.h"
+#include "oid-array.h"
+#include "oidset.h"
+#include "promisor-remote.h"
+#include "strmap.h"
+#include "string-list.h"
+#include "revision.h"
+#include "trace2.h"
+#include "progress.h"
+#include "packfile.h"
+#include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
 	N_("git backfill [<options>]"),
 	NULL
 };
 
+struct backfill_context {
+	struct repository *repo;
+	struct oid_array current_batch;
+	size_t batch_size;
+};
+
+static void clear_backfill_context(struct backfill_context *ctx)
+{
+	oid_array_clear(&ctx->current_batch);
+}
+
+static void download_batch(struct backfill_context *ctx)
+{
+	promisor_remote_get_direct(ctx->repo,
+				   ctx->current_batch.oid,
+				   ctx->current_batch.nr);
+	oid_array_clear(&ctx->current_batch);
+
+	/*
+	 * We likely have a new packfile. Add it to the packed list to
+	 * avoid possible duplicate downloads of the same objects.
+	 */
+	reprepare_packed_git(ctx->repo);
+}
+
+static int fill_missing_blobs(const char *path UNUSED,
+			      struct oid_array *list,
+			      enum object_type type,
+			      void *data)
+{
+	struct backfill_context *ctx = data;
+
+	if (type != OBJ_BLOB)
+		return 0;
+
+	for (size_t i = 0; i < list->nr; i++) {
+		off_t size = 0;
+		struct object_info info = OBJECT_INFO_INIT;
+		info.disk_sizep = &size;
+		if (oid_object_info_extended(ctx->repo,
+					     &list->oid[i],
+					     &info,
+					     OBJECT_INFO_FOR_PREFETCH) ||
+		    !size)
+			oid_array_append(&ctx->current_batch, &list->oid[i]);
+	}
+
+	if (ctx->current_batch.nr >= ctx->batch_size)
+		download_batch(ctx);
+
+	return 0;
+}
+
+static int do_backfill(struct backfill_context *ctx)
+{
+	struct rev_info revs;
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	int ret;
+
+	repo_init_revisions(ctx->repo, &revs, "");
+	handle_revision_arg("HEAD", &revs, 0, 0);
+
+	info.blobs = 1;
+	info.tags = info.commits = info.trees = 0;
+
+	info.revs = &revs;
+	info.path_fn = fill_missing_blobs;
+	info.path_fn_data = ctx;
+
+	ret = walk_objects_by_path(&info);
+
+	/* Download the objects that did not fill a batch. */
+	if (!ret)
+		download_batch(ctx);
+
+	clear_backfill_context(ctx);
+	return ret;
+}
+
 int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
+	struct backfill_context ctx = {
+		.repo = repo,
+		.current_batch = OID_ARRAY_INIT,
+		.batch_size = 50000,
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
@@ -23,7 +123,5 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
-	die(_("not implemented"));
-
-	return 0;
+	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
new file mode 100755
index 00000000000..64326362d80
--- /dev/null
+++ b/t/t5620-backfill.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='git backfill on partial clones'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# We create objects in the 'src' repo.
+test_expect_success 'setup repo for object creation' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	git init src &&
+
+	mkdir -p src/a/b/c &&
+	mkdir -p src/d/e &&
+
+	for i in 1 2
+	do
+		for n in 1 2 3 4
+		do
+			echo "Version $i of file $n" > src/file.$n.txt &&
+			echo "Version $i of file a/$n" > src/a/file.$n.txt &&
+			echo "Version $i of file a/b/$n" > src/a/b/file.$n.txt &&
+			echo "Version $i of file a/b/c/$n" > src/a/b/c/file.$n.txt &&
+			echo "Version $i of file d/$n" > src/d/file.$n.txt &&
+			echo "Version $i of file d/e/$n" > src/d/e/file.$n.txt &&
+			git -C src add . &&
+			git -C src commit -m "Iteration $n" || return 1
+		done
+	done
+'
+
+# Clone 'src' into 'srv.bare' so we have a bare repo to be our origin
+# server for the partial clone.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/src" srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+# do basic partial clone from "srv.bare"
+test_expect_success 'do partial clone 1, backfill gets all objects' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill1 &&
+
+	# Backfill with no options gets everything reachable from HEAD.
+	GIT_TRACE2_EVENT="$(pwd)/backfill-file-trace" git \
+		-C backfill1 backfill &&
+
+	# We should have engaged the partial clone machinery
+	test_trace2_data promisor fetch_count 48 <backfill-file-trace &&
+
+	# No more missing objects!
+	git -C backfill1 rev-list --quiet --objects --missing=print HEAD >revs2 &&
+	test_line_count = 0 revs2
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create a partial clone over HTTP' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	git clone --bare "file://$(pwd)/src" "$SERVER" &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	git clone --no-checkout --filter=blob:none \
+		"$HTTPD_URL/smart/server" backfill-http
+'
+
+test_expect_success 'backfilling over HTTP succeeds' '
+	GIT_TRACE2_EVENT="$(pwd)/backfill-http-trace" git \
+		-C backfill-http backfill &&
+
+	# We should have engaged the partial clone machinery
+	test_trace2_data promisor fetch_count 48 <backfill-http-trace &&
+
+	# Confirm all objects are present, none missing.
+	git -C backfill-http rev-list --objects --all >rev-list-out &&
+	awk "{print \$1;}" <rev-list-out >oids &&
+	GIT_TRACE2_EVENT="$(pwd)/walk-trace" git -C backfill-http \
+		cat-file --batch-check <oids >batch-out &&
+	! grep missing batch-out
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
+test_done
-- 
gitgitgadget


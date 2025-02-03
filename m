Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96B20B7F3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602676; cv=none; b=OsHtMe2NKu5AJ3pj2gpaLH4X/iLLVdo6YqfgqNLC7owT+RK7cC74QDgZPwW+1GKZ1VSFINN6fkPrnAb7Tpd+rFk27e6VftrGdpr+nGWLXf6ZK1W538Q0BvpMCA+YjZq1I5VXQQ/fEj9Lx3438RLsJC491yT8IaIgwhzrkyMfLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602676; c=relaxed/simple;
	bh=7LTRqHtyT8dx8//ep/9TiP1X2Ei2v9oir3Sa2Qldkio=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RUQlzazf190t5JkwH19nJLJMS4fjnMaoZER2eVUT+vU52iw9lkbXy9e329SbNjCeAoooVnuGhGuNBU4p3j/zfS1S4JgZmB6Z1na0V7D7QF8dEG3cj5KLYhQY5BLEpfEBWwjh+hger7xzUrzGYH4ZXwnCn0SWM017zud6EZT7kDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URGrmuOt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URGrmuOt"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso910840966b.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602672; x=1739207472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1it4nfRFvtvY1DNch9XTBIeI/iJr9GPk0q3aE2qAlU=;
        b=URGrmuOtkBh9jFBTv2fDdRtddkNBqtCFv8OlG/RA8+ibC6CNV0pCXhhOqQCk1cqUmi
         igS5GxA8H4/VaQiLOR3yHBGxyWRos8E980L2QdOPk+NxcSjMpdMUnVJpoZ5j/9LrI2rr
         +mf8XrHCHMUMvgdreDmBDHdl4aEMKhFvKmMUMIQuI7Ch4phsGbeO7wNxd0QZxPjkavHq
         ifSLAVfjgK+eToko7QybH9Vy4UIIRdPgrR5VdEtjirapAOMFYl5wjCWA2kmaI+NKZTts
         biPRsnYSr7+itCEhM//iU+bsFKqpM/oyfb4MTOF0cdYBEGEYi0iznhFfwMiNI+zW6K9g
         qzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602672; x=1739207472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1it4nfRFvtvY1DNch9XTBIeI/iJr9GPk0q3aE2qAlU=;
        b=ZbUMbB6pehu7V0ZoXq/nXJD4SLo7DOu2+NEdtHib5tLhvEc4IXrrtvxuQYKJjBWtSA
         v7bzpRKPWj95pHblOlynO+q1xx3Rj9aoKq4ZLknXMBIExfHqUeOLzpAVokzNBqOlBwpU
         RwqvzPfZJWfLB48VGgwylp0FjlCUG9B3yongPPIhRzGNEwYJcIW+j4NixStsNz6MDtX3
         /xX/jSr+jMlHEC0nH0dGbvTwYa6pMRmlAItThZwYddR96dU0ric2kpXzJkybc9u26ILH
         SWFbTPeGv/jGiTWzY9hDM5R+FhjuAgX4ssMH/JxIEntJRHe+4oRgtkOxDuO14KNaGSlG
         IwiQ==
X-Gm-Message-State: AOJu0Yy4a5U7i+J9VftNBJ2ruswV0b9BN3UAvzT2BbsKlMs2FKOCgmul
	OiTwQGwucuUTe3Hcxu9TN9By5zn8gkm4BInktsSNwfusgYXBTwrB/l2LoA==
X-Gm-Gg: ASbGncv0jdqDkKaaCM9ZtR8wrqkhgrU8O5WTk6Hdgvw0pK2f+5MxrG6id4h4P1y0C7M
	mL9VDjiXdUfx6rh1qLhwjpSExIYVo3H7h7yeOY6NLhv+IXBH1liR47vIvgODZjvLDBV9BeIkdP9
	cXIi566po898M8LH6oZRcHUrFo30y9DewqGKuE+ZO2y79AVpEgX7+4hqv/vxmLVNDHq1YVYOpdB
	C7wz1znWFPJhbMXApKV9cJpAk4CXnQjzFfTWfXrZDrk+aSMYwp6f5m/f9vxSKuIDknhnMVb5M37
	8GenWLhp23/zxmS1
X-Google-Smtp-Source: AGHT+IHpCaRo+vNF6RDrWUBbNiPTj4WwkYGxFjLSQIFVAr78MUWohgE5M5a0ZT9dfoHctxLhyaEqLg==
X-Received: by 2002:a17:907:3608:b0:ab7:835:1ece with SMTP id a640c23a62f3a-ab708351f8amr1537678966b.0.1738602671470;
        Mon, 03 Feb 2025 09:11:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a818csm785467666b.6.2025.02.03.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:11:11 -0800 (PST)
Message-Id: <d0cb9cb9af5efd5337f7af4de782660c7552fa69.1738602667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 17:11:04 +0000
Subject: [PATCH v3 2/5] backfill: basic functionality and tests
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
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
 Documentation/git-backfill.txt            |  31 +++++++
 Documentation/technical/api-path-walk.txt |   3 +-
 builtin/backfill.c                        | 102 +++++++++++++++++++++-
 t/meson.build                             |   1 +
 t/t5620-backfill.sh                       |  94 ++++++++++++++++++++
 5 files changed, 227 insertions(+), 4 deletions(-)
 create mode 100755 t/t5620-backfill.sh

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index ab384dad6e4..56cbb9ffd82 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -14,6 +14,37 @@ git backfill [<options>]
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
+In this way, `git backfill` provides a mechanism to break a large clone
+into smaller chunks. Starting with a blobless partial clone with `git
+clone --filter=blob:none` and then running `git backfill` in the local
+repository provides a way to download all reachable objects in several
+smaller network calls than downloading the entire repository at clone
+time.
+
+By default, `git backfill` downloads all blobs reachable from the `HEAD`
+commit. This set can be restricted or expanded using various options.
+
 THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
 
 SEE ALSO
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
index 58d0866c0fc..0eca175a7fe 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,16 +1,112 @@
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
+	size_t min_batch_size;
+};
+
+static void backfill_context_clear(struct backfill_context *ctx)
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
+		if (!has_object(ctx->repo, &list->oid[i],
+				OBJECT_INFO_FOR_PREFETCH))
+			oid_array_append(&ctx->current_batch, &list->oid[i]);
+	}
+
+	if (ctx->current_batch.nr >= ctx->min_batch_size)
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
+	path_walk_info_clear(&info);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
+	int result;
+	struct backfill_context ctx = {
+		.repo = repo,
+		.current_batch = OID_ARRAY_INIT,
+		.min_batch_size = 50000,
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
@@ -22,7 +118,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
-	die(_("not implemented"));
-
-	return 0;
+	result = do_backfill(&ctx);
+	backfill_context_clear(&ctx);
+	return result;
 }
diff --git a/t/meson.build b/t/meson.build
index 35f25ca4a1d..af53e8ee583 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -721,6 +721,7 @@ integration_tests = [
   't5617-clone-submodules-remote.sh',
   't5618-alternate-refs.sh',
   't5619-clone-local-ambiguous-transport.sh',
+  't5620-backfill.sh',
   't5700-protocol-v1.sh',
   't5701-git-serve.sh',
   't5702-protocol-v2.sh',
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


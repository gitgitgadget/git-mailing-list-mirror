Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31311662F3
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632545; cv=none; b=cXcJ+325Q6QoMcNAWfzXnfRcGJOxyyb/lIMiNayDP6R/JFASz3EhSt6pFte4YWexhKEmhrjFAVZDVAP1HTlmIP/O5kpaflUyRgw+QdmCMuaTo3nu+E/lxEdlvdOencbaugxsz0IcT8SiB+9MTxgFxIBeK6l5nKcym3/P6QPeRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632545; c=relaxed/simple;
	bh=QswTJQqQxn+Au+aETh1E5m7aeMXa3oWBd8fq/qMZ2DA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wa+B/toV+ACKgKCLkEQaQvz6qp10Rpw9md38A3vpmY4mvZVXDVIUso+rHbWo1blEsi6zGuQ2QbG3d7cTxXe+DC+32qF3nSpe3ZcBXFj6DDxXHN1YCCOXdQDYtnpcAL8aSD4m7asH1osc5IG1oOqHGQDgyL+MaUV9zY8YAr7gkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEYgxGcZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEYgxGcZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217136a74dso36397675e9.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718632541; x=1719237341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmDLer7snI3CeNnwOAubBVT3oNuADZCa8XQcQ/B8zlQ=;
        b=ZEYgxGcZvwSEED+gkOKqumF9EZcXw7N5T5JYYtkSsbWUE1oFZH/bOIoLxcPqdn1UzD
         1qsKzUoaGvMv8cpF4Nk1H1LhcAlxAux7LQcAafPXDKFXg535OFX9jKGAGOA7m6mSvyiV
         nVZl/oUn1tAuu0N6HPAFQbuP1bOVGIknXFcajiMCMzkjRn3leKrEBvC9YDl5ezIeK4UD
         NsX2Z+1RjOVM/3rh6HoyFZJUMHH2Z3TPXWHPh0fssdJYHmly7eRH/xw07NbGhLMjYhpL
         sAGh9HtbuSBPfqFdh4e0dwUt4QySfGFhgc7mbG+HY6lYNXC5L9qWGstfylhZZyTeO/Vl
         fTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632541; x=1719237341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmDLer7snI3CeNnwOAubBVT3oNuADZCa8XQcQ/B8zlQ=;
        b=I5OYTlqkF6ktQdtqcliDsrZVaI3vzVNaLsiMzgeutZQhQBey/M0oH9lSOlGwGzw2oW
         DnKOC0TJRsJExLkvVNWY9Vb43H7BA5HjztxER1AK5Pwe/6UPhnhAZGrF7L5D6bMhsFBd
         QKU9jdJElXgJueKWvBEWrfI24UP7PfGJHdYkADqPjObMizU9XiKBUMM+bNNN9KeVd8X5
         GeVQpF/y5hCgsUXhdhSz1N3Spg3aLtkUhYe7F+ZOExNRphnnBN73cU0dK1OQfnP3fguB
         tOqVH0upwQSLQ4p3CvfrKeosO2agKOVsAy8yZLi8RBN89OHHhdKKQ6beY8BZ5gJzm+eB
         /Pig==
X-Gm-Message-State: AOJu0YzBuYxZPJtppQLtTPQC4SMxCfXgMFbTullmKJl1Q6NmoQkaiO0M
	/E1fcwePn3x2xHCeKhs4DgQRAtvTADWgji6vSfuvxzCcA/AxI1c2yh3Mkw==
X-Google-Smtp-Source: AGHT+IGulyO22jvCKerBa7FOUv7zExB/rlk6qJyMxCZDurYWQCmSEGf8PxL8YdrmvkAA60DBLiL+1A==
X-Received: by 2002:a05:600c:a43:b0:421:ad:f104 with SMTP id 5b1f17b1804b1-42304827c4emr91279465e9.10.1718632541343;
        Mon, 17 Jun 2024 06:55:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229c60f758sm181632095e9.20.2024.06.17.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:55:40 -0700 (PDT)
Message-Id: <2f15099bbb9fed4919e829274b7683ace9094d15.1718632536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
References: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 13:55:35 +0000
Subject: [PATCH v7 3/3] unbundle: extend object verification for fetches
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

The existing fetch.fsckObjects and transfer.fsckObjects configurations
were not fully applied to bundle-involved fetches, including direct
bundle fetches and bundle-uri enabled fetches. Furthermore, there was no
object verification support for unbundle.

This commit extends object verification support in `bundle.c:unbundle`
by adding the `VERIFY_BUNDLE_FSCK` option to `verify_bundle_flags`. When
this option is enabled, we append the `--fsck-objects` flag to
`git-index-pack`.

The `VERIFY_BUNDLE_FSCK` option is now used by bundle-involved fetches,
where we use `fetch-pack.c:fetch_pack_fsck_objects` to determine whether
to enable this option for `bundle.c:unbundle`, specifically in:

- `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
- `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.

This addition ensures a consistent logic for object verification during
fetches. Tests have been added to confirm functionality in the scenarios
mentioned above.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  3 ++-
 bundle.c                    |  3 +++
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 33 ++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     | 33 +++++++++++++++++++++++++++++++++
 transport.c                 |  3 ++-
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..ed9b49fdbc1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -9,6 +9,7 @@
 #include "hashmap.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "fetch-pack.h"
 #include "remote.h"
 
 static struct {
@@ -373,7 +374,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..f124a2a5626 100644
--- a/bundle.c
+++ b/bundle.c
@@ -625,6 +625,9 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	if (flags & VERIFY_BUNDLE_FSCK)
+		strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..5ccc9a061a4 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,7 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_FSCK = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 2dcdd238a90..38a25d08d0a 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -34,7 +34,21 @@ test_expect_success 'create bundle' '
 		sed -e "/^$/q" -e "s/$(git rev-parse A) /$(git rev-parse B) /" \
 			<A.bundle >bad-header.bundle &&
 		convert_bundle_to_pack \
-			<A.bundle >>bad-header.bundle
+			<A.bundle >>bad-header.bundle &&
+
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad-object.bundle bad &&
+		git update-ref -d refs/heads/bad
 	)
 '
 
@@ -56,6 +70,23 @@ test_expect_success 'clone with bundle that has bad header' '
 	! grep "refs/bundles/" refs
 '
 
+test_expect_success 'clone with bundle that has bad object' '
+	# Unbundle succeeds if no fsckObjects confugured.
+	git clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-no-fsck &&
+	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	test_write_lines refs/bundles/bad >expect &&
+	test_cmp expect actual &&
+
+	# Unbundle fails with fsckObjects set true, but clone can still proceed.
+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-fsck 2>err &&
+	test_grep "missingEmail" err &&
+	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d9963..5182efc0b45 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -138,6 +138,39 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'clone bundle with different fsckObjects configurations' '
+	test_create_repo bundle-fsck &&
+	(
+		cd bundle-fsck &&
+		test_commit first &&
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad.bundle bad
+	) &&
+
+	git clone bundle-fsck/bad.bundle bundle-no-fsck &&
+
+	git -c fetch.fsckObjects=false -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-no-fsck &&
+
+	test_must_fail git -c fetch.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	test_must_fail git -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err
+'
+
 test_expect_success 'git bundle uses expected default format' '
 	git bundle create bundle HEAD^.. &&
 	cat >expect <<-EOF &&
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..a93c4171f7b 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args,
+		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

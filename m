Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196C14D2AB
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057300; cv=none; b=jbytuHUJzOdFlmCjf5gclg27+Gwl0ZGD0nqIPp3Bwf1BZN1VXb/bEGgB6MdMujxVNu76U+P3y2zwDD2b/z6dLrUVxyviF4wRvTdKjWQ1M+gT36i0BV469++61i5YTvyiwq8rsrfsKoMjwJSiOHdIJCc5Dk7lCU0I+5ByG8udzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057300; c=relaxed/simple;
	bh=Lms6/Kyx4SluTrDEuGuShr2HpqtO/iLV4zkG9ISJhuM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eofI2ggIr7Dlgymlc93DkhYwqdk8hCvZBqYAbuJ2ijdPwONHJqwbR6QlRADSqEJpU8vo6DCwRouxBk6hZ0XfGbI7PO47DH4AYYCzchHw+pY78cqLrNAYIoNpbVoyFvH2aG6Z3BZ8bO580RRzX2+mHfelCTgw/7cbTDez6Um8FJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJAmNcxM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJAmNcxM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42120e3911eso6900045e9.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057296; x=1717662096; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jTKImdaZpL/bvxfJj6IgP7QGU+M1LUchPwtQfNeF2I=;
        b=IJAmNcxMR/FpIANhqV9r/HSdYzPrqUegjKA/pW92LKRMtIJERWe/7ubkAOUljTctk+
         EMZpYnGLpg0uHgl0V5/GZXXRYEjedQBBY105aIhYO7UhmvVH/XkAPygJ2RuAMB0X7y/0
         souzdXkFOwKQ0gUhIK4LDvHHm+xESQBwj+n9Dz1ZVc38ZFSHBvE5+ru7UJOq927DymAg
         p1p1+bzvyQWLyCQNqjIaj+OsB4Zld/LwdZYxajEomqiv7yRj4s5jTyhjQisZ2iLEz0xK
         ESrg1EBsg8Ikq1TLGPhi912/A1ke4OVpzLubfjrVFzIJC59f2U64R1aAprsT33rS/VXz
         8pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057296; x=1717662096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jTKImdaZpL/bvxfJj6IgP7QGU+M1LUchPwtQfNeF2I=;
        b=ZHBlZXF997A03xa/cump5rqnrb+Be9TaCCjtSsTQbXpEQLJlPuN9w/DgU2L8I1Ext3
         boqPjGEr2d6gyhlJgGsHDZq6Ovt9siQNd63QY08JogZJMGKEACS/tac0SWdpYF9ue3mx
         w/IU9gUb1EXbjLQzMfPj5aYU2DM2jr2HR/P5wSXm1oCADA4i8Emx5gmzZCc0fsh4M/kg
         vIHWibIj2buHr3/2T2eUNZ32gtqI0aRo3dM8Kv//KTwIxk37j1aO3DxgunvAIcdhoa5F
         ioemffFVkTVzVKYPUycgrwVvuV4LZ4afM6+w+gN6eBvVgv4ZzdAAaJ5CbelixI4qo3CK
         dVGQ==
X-Gm-Message-State: AOJu0Yyimg4fll02c+2J9SmuFbnpmsKlG4cGp+IhWRGitK/5hyeWwVHt
	L4MyzBpeRsBPW1hjbGbMgBL0S7eg9q4Kq3WJaAWn6rOGChmC8D2ZdkrsTQ==
X-Google-Smtp-Source: AGHT+IEv6eVSPg8rR1JKu/xPK5FKrsSyZBfp3fHUOz/+1FfPtYAr/n76OVygaXHyN+tx7GiEHV8zkQ==
X-Received: by 2002:a05:600c:19d4:b0:420:fff:f4c9 with SMTP id 5b1f17b1804b1-421278185b8mr17719785e9.13.1717057295694;
        Thu, 30 May 2024 01:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212705993csm17744305e9.2.2024.05.30.01.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:21:35 -0700 (PDT)
Message-Id: <68b9bca9f8b19897997c2adc9a278ac5052e75cd.1717057290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 08:21:30 +0000
Subject: [PATCH v4 4/4] unbundle: introduce option
 VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
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

This commit introduces a new option `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to
`verify_bundle_flags`. In `bundle.c:unbundle`, this new option controls
whether broken object checks should be enabled by invoking
`fetch-pack.c:fetch_pack_fsck_objects`. Note that the option
`VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
`VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.

This flag is now used in the fetching process by:

- `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
- `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.

This addition ensures a consistent logic for object verification during
fetch operations. Tests have been added to confirm functionality in the
scenarios mentioned above.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  2 +-
 bundle.c                    |  7 +++++++
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 35 ++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     | 33 +++++++++++++++++++++++++++++++++
 transport.c                 |  2 +-
 6 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 066ff788104..e7ebac6ce57 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 26574e74bdd..53ac73834ea 100644
--- a/bundle.c
+++ b/bundle.c
@@ -17,6 +17,7 @@
 #include "list-objects-filter-options.h"
 #include "connected.h"
 #include "write-or-die.h"
+#include "fetch-pack.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -615,6 +616,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
 
 	if (verify_bundle(r, header, flags))
 		return -1;
@@ -626,6 +628,11 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
 	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
+		fsck_objects = 1;
+	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
+		fsck_objects = fetch_pack_fsck_objects();
+
+	if (fsck_objects)
 		strvec_push(&ip.args, "--fsck-objects");
 
 	if (extra_index_pack_args) {
diff --git a/bundle.h b/bundle.h
index cf23c8615d3..a39d8ea1a7e 100644
--- a/bundle.h
+++ b/bundle.h
@@ -34,6 +34,7 @@ enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
 	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
+	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 3),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 8f4f802e4f1..48be1b18802 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -30,7 +30,21 @@ test_expect_success 'create bundle' '
 		git bundle create B.bundle topic &&
 
 		# Create a bundle with reference pointing to non-existent object.
-		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle &&
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
 
@@ -52,6 +66,25 @@ test_expect_success 'clone with bundle that has bad header' '
 	! grep "refs/bundles/" refs
 '
 
+test_expect_success 'clone with bundle that has bad object' '
+	# Unbundle succeeds if no fsckObjects confugured.
+	git clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-no-fsck &&
+	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/bad
+	EOF
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
index 1b3d61ffcec..6cd5683bb45 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

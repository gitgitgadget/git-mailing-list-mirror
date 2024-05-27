Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B079E1
	for <git@vger.kernel.org>; Mon, 27 May 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824523; cv=none; b=NQeBZO8IIAWRiP6kQHKfo0lj4/MFvHhBt7X/gUhgG1z55vwHA1SZbjB9Eq48mq1GXwsFtpnB2AEPIaoub0KgiSPcKnH6fQYXFL7bYQ8eRK1O6q8MS0g+7KxTf6Q9MTcffBbDxcg0iXC2cW2npL3hzOBPbPM2iqnCY6fLzgUq1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824523; c=relaxed/simple;
	bh=To0bV7hH2ZM8APigD9Mf+Y96ivUCOI7+udMBmc0EVzg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BUMG+YR+f9PcpelFhzIozIKToXcvlNnIbq/nSMIkhdP26J4cLhfOSR2CL5AUsouHtreWnSqWvpry+Xt+OZ+hQRbP4B+yvW1oxh8ldtk6XqHK/EuzTmewxg/DzDK0apeOTrwRaBkzDr13UxIrRRoYVboi9j/hE09mdQzmx9qR6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8HlH5oe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8HlH5oe"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so3346868f8f.3
        for <git@vger.kernel.org>; Mon, 27 May 2024 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716824520; x=1717429320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfdR6e1SK83bbm9MuMwWl7lb+t5dZ8GuqMVndYfpxmk=;
        b=U8HlH5oe31X0l6PAY5uKiMQNMLAdE468/ec7qe5Yj5RDo55dnvekt7B1FpGt2PdkFu
         JSrbnvUXap0NIj6TbBUOKoMBUNE8rMC0I2DLhaP2e4ikoffLDh9C0nTXwCLfOIUwzXSH
         MW1P/AsUbGHQBAg1Ub8U+U0V2WIm/oeIjYS8qW8+gVaWoQtCF1mY3Q9+FW025rcWjrFr
         gp7WzV2f/vUPz0Dxgl56DJfXfOXgX3tTR4TDCVTP39asW7LWi1jkoSF+RqrTWux3nROy
         61XT1Cr8AXgtxijfCPNq1aHYtRAz1EldvYg/9jsv8bJW6qN3+3xs2WM7Cq/YCkGSCW4i
         XyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824520; x=1717429320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfdR6e1SK83bbm9MuMwWl7lb+t5dZ8GuqMVndYfpxmk=;
        b=QUWCImsqBwqGbvGxMYO8unqFylTSgOy7weu1b6UzgwrW8iYBySR69KNgzP//pmTkMl
         xNlPRSajkc+7Wtz/d6nFVIrGIizv9laiVaHzbNehVQT6kSRcQq94RxsIowaI+nr3bgu8
         Wfkcl+KHpSPS13sbdSF9cC55v9h3J72dG7miRwiOiwNiUaOIfz6jDBI02ZM25RoihMoz
         mrGZhro5kJc1LC0wFrR09fljuqG1/9FeA2CXphPTlqsFnd5Qq9NA/5HZB0VNr8AuIkLr
         ZfEilpL8490hJCW360nHme8gnRwMrUR63/qdt1MKIH2OKruL81PNwaAaKS7GsxzjFpXK
         z+7Q==
X-Gm-Message-State: AOJu0YwdZLOl2M1OS6kYbCujCiN/uu+YDrqTxaf+gGrw+GvwGDeGXHJC
	/XdfBnIwoarpscuB14qmBWnyppV3yIjy+JXw4dwYmhRl88jOG+j9kvEipg==
X-Google-Smtp-Source: AGHT+IHPjjQ9T6WSxxboYzFmEn3W6gcWKTpKDsXOlry6G+rLezotV2AJdA4+RHet0MvWJMSzdOt78g==
X-Received: by 2002:a05:6000:ac5:b0:354:f6bf:b272 with SMTP id ffacd0b85a97d-3552fe19424mr6457736f8f.48.1716824520045;
        Mon, 27 May 2024 08:42:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0931c9sm9285959f8f.65.2024.05.27.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:41:59 -0700 (PDT)
Message-Id: <8f488a5eeaaa0cdb525c34c2c165e6ee74ee7691.1716824518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 15:41:54 +0000
Subject: [PATCH v3 1/4] bundle-uri: verify oid before writing refs
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

When using the bundle-uri mechanism with a bundle list containing
multiple interrelated bundles, we encountered a bug where tips from
downloaded bundles were not discovered, thus resulting in rather slow
clones. This was particularly problematic when employing the heuristic
`creationTokens`.

And this is easy to reproduce. Suppose we have a repository with a
single branch `main` pointing to commit `A`, firstly we create a base
bundle with

  git bundle create base.bundle main

Then let's add a new commit `B` on top of `A`, so that an incremental
bundle for `main` can be created with

  git bundle create incr.bundle A..main

Now we can generate a bundle list with the following content:

  [bundle]
      version = 1
      mode = all
      heuristic = creationToken

  [bundle "base"]
      uri = base.bundle
      creationToken = 1

  [bundle "incr"]
      uri = incr.bundle
      creationToken = 2

A fresh clone with the bundle list above would give the expected
`refs/bundles/main` pointing at `B` in new repository, in other words we
already had everything locally from the bundles, but git would still
download everything from server as if we got nothing.

So why the `refs/bundles/main` is not discovered? After some digging I
found that:

1. Bundles in bundle list are downloaded to local files via
   `download_bundle_list` or via `fetch_bundles_by_token` for the
   creationToken heuristic case.
2. Then it tries to unbundle each bundle via `unbundle_from_file`, which
   is called by `unbundle_all_bundles` or called within
   `fetch_bundles_by_token` for the creationToken heuristic case.
3. Here, we first read the bundle header to get all the prerequisites
   for the bundle, this is done in `read_bundle_header`.
4. Then we call `unbundle`, which calls `verify_bundle` to ensure that
   the repository does indeed contain the prerequisites mentioned in the
   bundle.
5. The `verify_bundle` will call `parse_object`, within which the
   `prepare_packed_git` or `reprepare_packed_git` is eventually called,
   which means that the `raw_object_store->packed_git` data gets filled
   in and ``packed_git_initialized` is set. This also means consecutive
   calls to `prepare_packed_git` doesn't re-initiate
   `raw_object_store->packed_git` since `packed_git_initialized` already
   is set.
6. If `unbundle` succeeds, it writes some refs via `refs_update_ref`
   with `REF_SKIP_OID_VERIFICATION` set. So the bundle refs which can
   target arbitrary objects are written to the repository.
7. Finally in `do_fetch_pack_v2`, `mark_complete_and_common_ref` and
   `mark_tips` are called with `OBJECT_INFO_QUICK` set to find local
   tips. Here it won't call `reprepare_packed_git` anymore so it would
   fail to parse oids that only reside in the last bundle.

Back to the example above, when unbunding `incr.bundle`, `base.pack` is
enlisted to `packed_git` bacause of the prerequisites to verify. While
we can not find `B` for negotiation at a latter time because `B` exists
in `incr.pack` which is not enlisted in `packed_git`.

This commit fixes this bug by dropping the `REF_SKIP_OID_VERIFICATION`
flag when writing bundle refs, so we can:

1. Ensure that the bundle refs we are writing are pointing to valid
   objects.
2. Ensure all the tips from bundle refs can be correctly parsed.

And a set of negotiation related tests for bundle-uri are added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |   3 +-
 t/t5558-clone-bundle-uri.sh | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 91b3319a5c1..65666a11d9c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -400,8 +400,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		refs_update_ref(get_main_ref_store(the_repository),
 				"fetched bundle", bundle_ref.buf, oid,
 				has_old ? &old_oid : NULL,
-				REF_SKIP_OID_VERIFICATION,
-				UPDATE_REFS_MSG_ON_ERR);
+				0, UPDATE_REFS_MSG_ON_ERR);
 	}
 
 	bundle_header_release(&header);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 1ca5f745e73..a5b04d6f187 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -20,7 +20,10 @@ test_expect_success 'fail to clone from non-bundle file' '
 test_expect_success 'create bundle' '
 	git init clone-from &&
 	git -C clone-from checkout -b topic &&
+
 	test_commit -C clone-from A &&
+	git -C clone-from bundle create A.bundle topic &&
+
 	test_commit -C clone-from B &&
 	git -C clone-from bundle create B.bundle topic
 '
@@ -259,6 +262,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	! grep "refs/bundles/" refs
 '
 
+#########################################################################
+# Clone negotiation related tests begin here
+
+test_expect_success 'negotiation: bundle with part of wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="clone-from/A.bundle" \
+		clone-from nego-bundle-part &&
+	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# Ensure that refs/bundles/topic are sent as "have".
+	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle with all wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=topic --no-tags \
+		--bundle-uri="clone-from/B.bundle" \
+		clone-from nego-bundle-all &&
+	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-no-heuristic &&
+
+	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-heuristic &&
+
+	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list with all wanted commits' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=left --no-tags \
+		--bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-all &&
+
+	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
 #########################################################################
 # HTTP tests begin here
 
-- 
gitgitgadget


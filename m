Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE978176AC8
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057297; cv=none; b=WfdcJPI5FfBpTmt/blMQr49g/9ykmms0RGmdbXIGW/p7+x7qkHxbyzdtH8EIf2ljRs8rKi6CPr0TZdMuzTcZDA+rUOSOfjN03jPcHQviXWeCmb6M5+7riowOAF0q6iZ435gi4x4HO1u5rCm+eLCf2cuQ0boH2VFUUW1BNkcBh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057297; c=relaxed/simple;
	bh=30VS9gKq6DgVT4uxjnk9hN20fyrzgiVC1sNDD0efieY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GpV1IiUwAMB+8+MDmcx5y3IX8JFGYcpdNnMBGmuRJsp594qv7l5bRSv3g74Y1UyWS+ejLNG59uj50ZBXle/rK8WCisTeU/gGlO3PWJql7UKvhZfOafm4SAxtVYI3nvH6Jve08C2rgWVvS+Wqjm2K9KmwJrVs0haKG43s3saWvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEMXj46o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEMXj46o"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so6935835e9.1
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057293; x=1717662093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d65I8c0+sonjs789kJQ24DNFY7+bNQ6fFEDbhPkbH0s=;
        b=cEMXj46oUhHX3ErWWqk6JVdsXx9/aAfgqKB1XnG7ksgzEEkO90eDscs7j/a4dHjlIm
         R8jrup7S+eEvpae5gIAVyQySgsjQBZRYDGGbnRJLGaghIhMic5PkzjRKFv0/F42KGG41
         NNNxlOCfJ/cdNFJJB6Y2rQAhfCdW841T5c+N5AJyI5+jrqILY5VsA/2vhfybvKZ4gjJ9
         MX93yV8CSgBvpRfVRJeeqWfO2PAlQnguR0TKK2zzCA29L8xwn7tUjH9P8h4voU79mCyk
         ttO4kiHfP73bazIgj8xr20Wqh3M/E67qzrYIGaF2DMcird4Vggugu1T0BT6gK8J3xljq
         bNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057293; x=1717662093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d65I8c0+sonjs789kJQ24DNFY7+bNQ6fFEDbhPkbH0s=;
        b=KjkRxb0Y6z/MeKaNew6j/1cS94dbcdy3JoTq2Y7x5z6nEAb1sHhg8NwGvzdD2OKvjb
         S5lwI/LZ9FCr67c3sHNTRiStiEUXO516umEhU29ObQzkO5RyB+EuO+XHP4OzKPazoS7O
         JjAjksKptZgmJd2axZSXzoIXcd7gqMxONdy4DklfN/H6sVQaE9IyjJOyiaFQEnk4YaFl
         BbM6JqeyZThbIwIUpCV7tNiwZGoY+PFKLloW5QcPcxRniitiFe3NiJwr9STy8uog6Tlt
         1RcLYVkFyYlvi6voZQMmN3woHUjxxpiAMb5al3ITdP2nh9xk9AVWX4YwesHRTJeFRnL3
         kWqg==
X-Gm-Message-State: AOJu0YyF91STXcuaC5jXpRO+R+J8iCM5JHblV7Tkd8lyOUXxy0HghKtZ
	sCvSuJmwdOLTvJT+gxqpxC/JDMZOhumboCUoMAavw2/LpPTeC/ut1gUUVw==
X-Google-Smtp-Source: AGHT+IE/RwG77dsJTreWukur88RVfT4k4Ms4u49n/d4QNASiQ+oH8fSfpQaH1M6XiiOiidACgaQ/aA==
X-Received: by 2002:a05:600c:a03:b0:421:1d5:c0a3 with SMTP id 5b1f17b1804b1-4212792410amr14253275e9.28.1717057292422;
        Thu, 30 May 2024 01:21:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dcb2e09b9sm613433f8f.48.2024.05.30.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:21:31 -0700 (PDT)
Message-Id: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 08:21:26 +0000
Subject: [PATCH v4 0/4] object checking related additions and fixes for bundles in fetches
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
    blanet <bupt_xingxin@163.com>

While attempting to fix a reference negotiation bug in bundle-uri, we
identified that the fetch process lacks some crucial object validation
checks when processing bundles. The primary issues are:

 1. In the bundle-uri scenario, object IDs were not validated before writing
    bundle references. This was the root cause of the original negotiation
    bug in bundle-uri and could lead to potential repository corruption.
 2. The existing "fetch.fsckObjects" and "transfer.fsckObjects"
    configurations were not applied when directly fetching bundles or
    fetching with bundle-uri enabled. In fact, there were no object
    validation supports for unbundle.

The first patch addresses the bundle-uri negotiation issue by removing the
REF_SKIP_OID_VERIFICATION flag when writing bundle references.

Patches 2 through 4 extend verify_bundle_flags for bundle.c:unbundle to add
support for object validation (fsck) in different scenarios, mainly
following the suggestions from Junio on the mailing list.

Xing Xin (4):
  bundle-uri: verify oid before writing refs
  unbundle: extend verify_bundle_flags to support fsck-objects
  fetch-pack: expose fsckObjects configuration logic
  unbundle: introduce option VERIFY_BUNDLE_FSCK_FOLLOW_FETCH

 bundle-uri.c                |   5 +-
 bundle.c                    |  10 ++
 bundle.h                    |   2 +
 fetch-pack.c                |  17 ++--
 fetch-pack.h                |   5 +
 t/t5558-clone-bundle-uri.sh | 186 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  33 +++++++
 transport.c                 |   2 +-
 8 files changed, 246 insertions(+), 14 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v3:

 1:  8f488a5eeaa ! 1:  e958a3ab20c bundle-uri: verify oid before writing refs
     @@ Commit message
          When using the bundle-uri mechanism with a bundle list containing
          multiple interrelated bundles, we encountered a bug where tips from
          downloaded bundles were not discovered, thus resulting in rather slow
     -    clones. This was particularly problematic when employing the heuristic
     -    `creationTokens`.
     +    clones. This was particularly problematic when employing the
     +    "creationTokens" heuristic.
      
     -    And this is easy to reproduce. Suppose we have a repository with a
     -    single branch `main` pointing to commit `A`, firstly we create a base
     -    bundle with
     +    To reproduce this issue, consider a repository with a single branch
     +    "main" pointing to commit "A". Firstly, create a base bundle with:
      
            git bundle create base.bundle main
      
     -    Then let's add a new commit `B` on top of `A`, so that an incremental
     -    bundle for `main` can be created with
     +    Then, add a new commit "B" on top of "A", and create an incremental
     +    bundle for "main":
      
            git bundle create incr.bundle A..main
      
     -    Now we can generate a bundle list with the following content:
     +    Now, generate a bundle list with the following content:
      
            [bundle]
                version = 1
     @@ Commit message
                uri = incr.bundle
                creationToken = 2
      
     -    A fresh clone with the bundle list above would give the expected
     -    `refs/bundles/main` pointing at `B` in new repository, in other words we
     -    already had everything locally from the bundles, but git would still
     -    download everything from server as if we got nothing.
     +    A fresh clone with the bundle list above should result in a reference
     +    "refs/bundles/main" pointing to "B" in the new repository. However, git
     +    would still download everything from the server, as if it had fetched
     +    nothing locally.
      
     -    So why the `refs/bundles/main` is not discovered? After some digging I
     +    So why the "refs/bundles/main" is not discovered? After some digging I
          found that:
      
          1. Bundles in bundle list are downloaded to local files via
     -       `download_bundle_list` or via `fetch_bundles_by_token` for the
     -       creationToken heuristic case.
     -    2. Then it tries to unbundle each bundle via `unbundle_from_file`, which
     -       is called by `unbundle_all_bundles` or called within
     -       `fetch_bundles_by_token` for the creationToken heuristic case.
     -    3. Here, we first read the bundle header to get all the prerequisites
     -       for the bundle, this is done in `read_bundle_header`.
     -    4. Then we call `unbundle`, which calls `verify_bundle` to ensure that
     -       the repository does indeed contain the prerequisites mentioned in the
     +       `bundle-uri.c:download_bundle_list` or via
     +       `bundle-uri.c:fetch_bundles_by_token` for the "creationToken"
     +       heuristic.
     +    2. Each bundle is unbundled via `bundle-uri.c:unbundle_from_file`, which
     +       is called by `bundle-uri.c:unbundle_all_bundles` or called within
     +       `bundle-uri.c:fetch_bundles_by_token` for the "creationToken"
     +       heuristic.
     +    3. To get all prerequisites of the bundle, the bundle header is read
     +       inside `bundle-uri.c:unbundle_from_file` to by calling
     +       `bundle.c:read_bundle_header`.
     +    4. Then it calls `bundle.c:unbundle`, which calls
     +       `bundle.c:verify_bundle` to ensure the repository contains all the
     +       prerequisites.
     +    5. `bundle.c:verify_bundle` calls `parse_object`, which eventually
     +       invokes `packfile.c:prepare_packed_git` or
     +       `packfile.c:reprepare_packed_git`, filling
     +       `raw_object_store->packed_git` and setting `packed_git_initialized`.
     +    6. If `bundle.c:unbundle` succeeds, it writes refs via
     +       `refs.c:refs_update_ref` with `REF_SKIP_OID_VERIFICATION` set. Here
     +       bundle refs which can target arbitrary objects are written to the
     +       repository.
     +    7. Finally, in `fetch-pack.c:do_fetch_pack_v2`, the functions
     +       `fetch-pack.c:mark_complete_and_common_ref` and
     +       `fetch-pack.c:mark_tips` are called with `OBJECT_INFO_QUICK` set to
     +       find local tips for negotiation. The `OBJECT_INFO_QUICK` flag
     +       prevents `packfile.c:reprepare_packed_git` from being called,
     +       resulting in failures to parse OIDs that reside only in the latest
             bundle.
     -    5. The `verify_bundle` will call `parse_object`, within which the
     -       `prepare_packed_git` or `reprepare_packed_git` is eventually called,
     -       which means that the `raw_object_store->packed_git` data gets filled
     -       in and ``packed_git_initialized` is set. This also means consecutive
     -       calls to `prepare_packed_git` doesn't re-initiate
     -       `raw_object_store->packed_git` since `packed_git_initialized` already
     -       is set.
     -    6. If `unbundle` succeeds, it writes some refs via `refs_update_ref`
     -       with `REF_SKIP_OID_VERIFICATION` set. So the bundle refs which can
     -       target arbitrary objects are written to the repository.
     -    7. Finally in `do_fetch_pack_v2`, `mark_complete_and_common_ref` and
     -       `mark_tips` are called with `OBJECT_INFO_QUICK` set to find local
     -       tips. Here it won't call `reprepare_packed_git` anymore so it would
     -       fail to parse oids that only reside in the last bundle.
     -
     -    Back to the example above, when unbunding `incr.bundle`, `base.pack` is
     -    enlisted to `packed_git` bacause of the prerequisites to verify. While
     -    we can not find `B` for negotiation at a latter time because `B` exists
     -    in `incr.pack` which is not enlisted in `packed_git`.
     -
     -    This commit fixes this bug by dropping the `REF_SKIP_OID_VERIFICATION`
     -    flag when writing bundle refs, so we can:
     -
     -    1. Ensure that the bundle refs we are writing are pointing to valid
     -       objects.
     -    2. Ensure all the tips from bundle refs can be correctly parsed.
     -
     -    And a set of negotiation related tests for bundle-uri are added.
      
     +    In the example above, when unbunding "incr.bundle", "base.pack" is added
     +    to `packed_git` due to prerequisites verification. However, "B" cannot
     +    be found for negotiation because it exists in "incr.pack", which is not
     +    included in `packed_git`.
     +
     +    This commit fixes the bug by removing `REF_SKIP_OID_VERIFICATION` flag
     +    when writing bundle refs. When `refs.c:refs_update_ref` is called to to
     +    write the corresponding bundle refs, it triggers
     +    `refs.c:ref_transaction_commit`.  This, in turn, invokes
     +    `refs.c:ref_transaction_prepare`, which calls `transaction_prepare` of
     +    the refs storage backend. For files backend, this function is
     +    `files-backend.c:files_transaction_prepare`, and for reftable backend,
     +    it is `reftable-backend.c:reftable_be_transaction_prepare`. Both
     +    functions eventually call `object.c:parse_object`, which can invoke
     +    `packfile.c:reprepare_packed_git` to refresh `packed_git`. This ensures
     +    that bundle refs point to valid objects and that all tips from bundle
     +    refs are correctly parsed during subsequent negotiations.
     +
     +    A test has been added to demonstrate that bundles with incorrect
     +    headers, where refs point to non-existent objects, do not result in any
     +    bundle refs being created in the repository. Additionally, a set of
     +    negotiation-related tests for fetching with bundle-uri has been
     +    included.
     +
     +    Reviewed-by: Karthik Nayak <karthik.188@gmail.com>
     +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## bundle-uri.c ##
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle file' '
     + 
       test_expect_success 'create bundle' '
       	git init clone-from &&
     - 	git -C clone-from checkout -b topic &&
     +-	git -C clone-from checkout -b topic &&
     +-	test_commit -C clone-from A &&
     +-	test_commit -C clone-from B &&
     +-	git -C clone-from bundle create B.bundle topic
     ++	(
     ++		cd clone-from &&
     ++		git checkout -b topic &&
     ++
     ++		test_commit A &&
     ++		git bundle create A.bundle topic &&
      +
     - 	test_commit -C clone-from A &&
     -+	git -C clone-from bundle create A.bundle topic &&
     ++		test_commit B &&
     ++		git bundle create B.bundle topic &&
      +
     - 	test_commit -C clone-from B &&
     - 	git -C clone-from bundle create B.bundle topic
     ++		# Create a bundle with reference pointing to non-existent object.
     ++		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
     ++	)
       '
     + 
     + test_expect_success 'clone with path bundle' '
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'clone with bundle that has bad header' '
     ++	git clone --bundle-uri="clone-from/bad-header.bundle" \
     ++		clone-from clone-bad-header 2>err &&
     ++	# Write bundle ref fails, but clone can still proceed.
     ++	commit_b=$(git -C clone-from rev-parse B) &&
     ++	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
     ++	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
     ++	! grep "refs/bundles/" refs
     ++'
     ++
     + test_expect_success 'clone with path bundle and non-default hash' '
     + 	test_when_finished "rm -rf clone-path-non-default-hash" &&
     + 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any mode, all failures)' '
       	! grep "refs/bundles/" refs
       '
 2:  057c697970f ! 2:  beb70735811 unbundle: introduce unbundle_fsck_flags for fsckobjects handling
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: introduce unbundle_fsck_flags for fsckobjects handling
     +    unbundle: extend verify_bundle_flags to support fsck-objects
      
     -    This commit adds a new enum `unbundle_fsck_flags` which is designed to
     -    control the fsck behavior when unbundling. `unbundle` can use this newly
     -    passed in enum to further decide whether to enable `--fsck-objects` for
     -    "git-index-pack".
     +    This commit extends `verify_bundle_flags` by adding a new option
     +    `VERIFY_BUNDLE_FSCK_ALWAYS`, which enables checks for broken objects in
     +    `bundle.c:unbundle`. This option is now used as the default for fetches
     +    involving bundles, specifically by `transport.c:fetch_refs_from_bundle`
     +    for direct bundle fetches and by `bundle-uri.c:unbundle_from_file` for
     +    _bundle-uri_ enabled fetches.
      
     -    Currently only `UNBUNDLE_FSCK_NEVER` and `UNBUNDLE_FSCK_ALWAYS` are
     -    supported as the very basic options. Another interesting option would be
     -    added in later commits.
     +    Upcoming commits will introduce another option as a replacement that
     +    fits better with fetch operations. `VERIFY_BUNDLE_FSCK_ALWAYS` will be
     +    further used to add "--fsck-objects" support for "git bundle unbundle"
     +    and "git bundle verify".
      
     +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
     - ## builtin/bundle.c ##
     -@@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
     - 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
     - 			     _("Unbundling objects"), NULL);
     - 	ret = !!unbundle(the_repository, &header, bundle_fd,
     --			 &extra_index_pack_args, 0) ||
     -+			 &extra_index_pack_args, 0, UNBUNDLE_FSCK_NEVER) ||
     - 		list_bundle_refs(&header, argc, argv);
     - 	bundle_header_release(&header);
     - cleanup:
     -
       ## bundle-uri.c ##
      @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
       	 * the prerequisite commits.
       	 */
       	if ((result = unbundle(r, &header, bundle_fd, NULL,
      -			       VERIFY_BUNDLE_QUIET)))
     -+			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_ALWAYS)))
     ++			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
       		return 1;
       
       	/*
      
       ## bundle.c ##
     -@@ bundle.c: int create_bundle(struct repository *r, const char *path,
     - 
     - int unbundle(struct repository *r, struct bundle_header *header,
     - 	     int bundle_fd, struct strvec *extra_index_pack_args,
     --	     enum verify_bundle_flags flags)
     -+	     enum verify_bundle_flags flags,
     -+	     enum unbundle_fsck_flags fsck_flags)
     - {
     - 	struct child_process ip = CHILD_PROCESS_INIT;
     - 
      @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	if (header->filter.choice)
       		strvec_push(&ip.args, "--promisor=from-bundle");
       
     -+	switch (fsck_flags) {
     -+	case UNBUNDLE_FSCK_ALWAYS:
     ++	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
      +		strvec_push(&ip.args, "--fsck-objects");
     -+		break;
     -+	case UNBUNDLE_FSCK_NEVER:
     -+	default:
     -+		break;
     -+	}
      +
       	if (extra_index_pack_args) {
       		strvec_pushv(&ip.args, extra_index_pack_args->v);
     @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
      
       ## bundle.h ##
      @@ bundle.h: int create_bundle(struct repository *r, const char *path,
     - 		  int argc, const char **argv, struct strvec *pack_options,
     - 		  int version);
     - 
     -+enum unbundle_fsck_flags {
     -+	UNBUNDLE_FSCK_NEVER = 0,
     -+	UNBUNDLE_FSCK_ALWAYS,
     -+};
     -+
       enum verify_bundle_flags {
       	VERIFY_BUNDLE_VERBOSE = (1 << 0),
       	VERIFY_BUNDLE_QUIET = (1 << 1),
     -@@ bundle.h: int verify_bundle(struct repository *r, struct bundle_header *header,
     -  */
     - int unbundle(struct repository *r, struct bundle_header *header,
     - 	     int bundle_fd, struct strvec *extra_index_pack_args,
     --	     enum verify_bundle_flags flags);
     -+	     enum verify_bundle_flags flags,
     -+	     enum unbundle_fsck_flags fsck_flags);
     - int list_bundle_refs(struct bundle_header *header,
     - 		int argc, const char **argv);
     ++	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
     + };
       
     + int verify_bundle(struct repository *r, struct bundle_header *header,
      
       ## transport.c ##
      @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
       		get_refs_from_bundle_inner(transport);
       	ret = unbundle(the_repository, &data->header, data->fd,
      -		       &extra_index_pack_args, 0);
     -+		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_ALWAYS);
     ++		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
       	transport->hash_algo = data->header.hash_algo;
       	return ret;
       }
 3:  67401d4fbcb ! 3:  5ddc894c2c1 fetch-pack: expose fsckObjects configuration logic
     @@ Metadata
       ## Commit message ##
          fetch-pack: expose fsckObjects configuration logic
      
     -    Currently we can use "transfer.fsckObjects" or "fetch.fsckObjects" to
     -    control whether to enable checks for broken objects during fetching. But
     -    these configs are only acknowledged by `fetch-pack.c:get_pack` and do
     -    not make sense when fetching from bundles or using bundle-uris.
     +    Currently, we can use "transfer.fsckObjects" and the more specific
     +    "fetch.fsckObjects" to control checks for broken objects in received
     +    packs during fetches. However, these configurations were only
     +    acknowledged by `fetch-pack.c:get_pack` and did not take effect in
     +    direct bundle fetches and fetches with _bundle-uri_ enabled.
      
     -    This commit exposed the fetch-then-transfer configuration logic by
     -    adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. In next
     -    commit, this new function will be used by `unbundle` in fetching
     -    scenarios.
     +    This commit exposes the fetch-then-transfer configuration logic by
     +    adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
     +    new function is used to replace the assignment for `fsck_objects` in
     +    `fetch-pack.c:get_pack`. In the next commit, it will also be used by
     +    `bundle.c:unbundle` to better fit fetching scenarios.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## fetch-pack.c ##
     @@ fetch-pack.c: static const struct object_id *iterate_ref_map(void *cb_data)
      +int fetch_pack_fsck_objects(void)
      +{
      +	fetch_pack_setup();
     -+
     -+	return fetch_fsck_objects >= 0
     -+	       ? fetch_fsck_objects
     -+	       : transfer_fsck_objects >= 0
     -+	       ? transfer_fsck_objects
     -+	       : 0;
     ++	if (fetch_fsck_objects >= 0)
     ++		return fetch_fsck_objects;
     ++	if (transfer_fsck_objects >= 0)
     ++		return transfer_fsck_objects;
     ++	return 0;
      +}
      +
       struct ref *fetch_pack(struct fetch_pack_args *args,
     @@ fetch-pack.h: void negotiate_using_fetch(const struct oid_array *negotiation_tip
        */
       int report_unmatched_refs(struct ref **sought, int nr_sought);
       
     ++/*
     ++ * Return true if checks for broken objects in received pack are required.
     ++ */
      +int fetch_pack_fsck_objects(void);
      +
       #endif
 4:  c19b8f633cb ! 4:  68b9bca9f8b unbundle: introduce new option UNBUNDLE_FSCK_FOLLOW_FETCH
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: introduce new option UNBUNDLE_FSCK_FOLLOW_FETCH
     +    unbundle: introduce option VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
      
     -    This commit adds a new option `UNBUNDLE_FSCK_FOLLOW_FETCH` to
     -    `unbundle_fsck_flags`, this new flag is currently used in the _fetch_
     -    process by
     +    This commit introduces a new option `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to
     +    `verify_bundle_flags`. In `bundle.c:unbundle`, this new option controls
     +    whether broken object checks should be enabled by invoking
     +    `fetch-pack.c:fetch_pack_fsck_objects`. Note that the option
     +    `VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
     +    `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.
      
     -    - `transport.c:fetch_refs_from_bundle` for fetching directly from a
     -      bundle.
     -    - `bundle-uri.c:unbundle_from_file` for unbundling bundles downloaded
     -      from bundle-uri.
     +    This flag is now used in the fetching process by:
      
     -    So we now have a relatively consistent logic for checking objects during
     -    fetching. Add tests for the above two situations are added.
     +    - `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
     +    - `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.
     +
     +    This addition ensures a consistent logic for object verification during
     +    fetch operations. Tests have been added to confirm functionality in the
     +    scenarios mentioned above.
      
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
       	 * the prerequisite commits.
       	 */
       	if ((result = unbundle(r, &header, bundle_fd, NULL,
     --			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_ALWAYS)))
     -+			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_FOLLOW_FETCH)))
     +-			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_ALWAYS)))
     ++			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
       		return 1;
       
       	/*
     @@ bundle.c
       static const char v2_bundle_signature[] = "# v2 git bundle\n";
       static const char v3_bundle_signature[] = "# v3 git bundle\n";
      @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     - 	     enum unbundle_fsck_flags fsck_flags)
     + 	     enum verify_bundle_flags flags)
       {
       	struct child_process ip = CHILD_PROCESS_INIT;
      +	int fsck_objects = 0;
     @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	if (verify_bundle(r, header, flags))
       		return -1;
      @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
     + 		strvec_push(&ip.args, "--promisor=from-bundle");
       
     - 	switch (fsck_flags) {
     - 	case UNBUNDLE_FSCK_ALWAYS:
     --		strvec_push(&ip.args, "--fsck-objects");
     + 	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
      +		fsck_objects = 1;
     -+		break;
     -+	case UNBUNDLE_FSCK_FOLLOW_FETCH:
     ++	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
      +		fsck_objects = fetch_pack_fsck_objects();
     - 		break;
     - 	case UNBUNDLE_FSCK_NEVER:
     - 	default:
     - 		break;
     - 	}
     - 
     -+	if (fsck_objects)
     -+		strvec_push(&ip.args, "--fsck-objects");
      +
     ++	if (fsck_objects)
     + 		strvec_push(&ip.args, "--fsck-objects");
     + 
       	if (extra_index_pack_args) {
     - 		strvec_pushv(&ip.args, extra_index_pack_args->v);
     - 		strvec_clear(extra_index_pack_args);
      
       ## bundle.h ##
     -@@ bundle.h: int create_bundle(struct repository *r, const char *path,
     - enum unbundle_fsck_flags {
     - 	UNBUNDLE_FSCK_NEVER = 0,
     - 	UNBUNDLE_FSCK_ALWAYS,
     -+	UNBUNDLE_FSCK_FOLLOW_FETCH,
     +@@ bundle.h: enum verify_bundle_flags {
     + 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
     + 	VERIFY_BUNDLE_QUIET = (1 << 1),
     + 	VERIFY_BUNDLE_FSCK_ALWAYS = (1 << 2),
     ++	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 3),
       };
       
     - enum verify_bundle_flags {
     + int verify_bundle(struct repository *r, struct bundle_header *header,
      
       ## t/t5558-clone-bundle-uri.sh ##
     -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle file' '
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
     + 		git bundle create B.bundle topic &&
       
     - test_expect_success 'create bundle' '
     - 	git init clone-from &&
     --	git -C clone-from checkout -b topic &&
     -+	(
     -+		cd clone-from &&
     -+		git checkout -b topic &&
     -+
     -+		test_commit A &&
     -+		git bundle create A.bundle topic &&
     -+
     -+		test_commit B &&
     -+		git bundle create B.bundle topic &&
     + 		# Create a bundle with reference pointing to non-existent object.
     +-		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
     ++		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle &&
      +
      +		cat >data <<-EOF &&
      +		tree $(git rev-parse HEAD^{tree})
      +		parent $(git rev-parse HEAD)
      +		author A U Thor
      +		committer A U Thor
     - 
     --	test_commit -C clone-from A &&
     --	git -C clone-from bundle create A.bundle topic &&
     ++
      +		commit: this is a commit with bad emails
     - 
     --	test_commit -C clone-from B &&
     --	git -C clone-from bundle create B.bundle topic
     ++
      +		EOF
      +		git hash-object --literally -t commit -w --stdin <data >commit &&
      +		git branch bad $(cat commit) &&
     -+		git bundle create bad.bundle bad &&
     ++		git bundle create bad-object.bundle bad &&
      +		git update-ref -d refs/heads/bad
     -+	)
     + 	)
       '
       
     - test_expect_success 'clone with path bundle' '
     -@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
     - 	test_cmp expect actual
     +@@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with bundle that has bad header' '
     + 	! grep "refs/bundles/" refs
       '
       
     -+test_expect_success 'clone with bad bundle' '
     -+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad.bundle" \
     -+		clone-from clone-bad 2>err &&
     -+	# Unbundle fails, but clone can still proceed.
     ++test_expect_success 'clone with bundle that has bad object' '
     ++	# Unbundle succeeds if no fsckObjects confugured.
     ++	git clone --bundle-uri="clone-from/bad-object.bundle" \
     ++		clone-from clone-bad-object-no-fsck &&
     ++	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
     ++	grep "refs/bundles/" refs >actual &&
     ++	cat >expect <<-\EOF &&
     ++	refs/bundles/bad
     ++	EOF
     ++	test_cmp expect actual &&
     ++
     ++	# Unbundle fails with fsckObjects set true, but clone can still proceed.
     ++	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad-object.bundle" \
     ++		clone-from clone-bad-object-fsck 2>err &&
      +	test_grep "missingEmail" err &&
     -+	git -C clone-bad for-each-ref --format="%(refname)" >refs &&
     ++	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
      +	! grep "refs/bundles/" refs
      +'
      +
     @@ t/t5607-clone-bundle.sh: test_expect_success 'fetch SHA-1 from bundle' '
       	git fetch --no-tags foo/tip.bundle "$(cat hash)"
       '
       
     -+test_expect_success 'clone bundle with fetch.fsckObjects' '
     ++test_expect_success 'clone bundle with different fsckObjects configurations' '
      +	test_create_repo bundle-fsck &&
      +	(
      +		cd bundle-fsck &&
     @@ t/t5607-clone-bundle.sh: test_expect_success 'fetch SHA-1 from bundle' '
      +		git branch bad $(cat commit) &&
      +		git bundle create bad.bundle bad
      +	) &&
     ++
     ++	git clone bundle-fsck/bad.bundle bundle-no-fsck &&
     ++
     ++	git -c fetch.fsckObjects=false -c transfer.fsckObjects=true \
     ++		clone bundle-fsck/bad.bundle bundle-fetch-no-fsck &&
     ++
      +	test_must_fail git -c fetch.fsckObjects=true \
     -+		clone bundle-fsck/bad.bundle bundle-fsck-clone 2>err &&
     ++		clone bundle-fsck/bad.bundle bundle-fetch-fsck 2>err &&
     ++	test_grep "missingEmail" err &&
     ++
     ++	test_must_fail git -c transfer.fsckObjects=true \
     ++		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
      +	test_grep "missingEmail" err
      +'
      +
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
       	if (!data->get_refs_from_bundle_called)
       		get_refs_from_bundle_inner(transport);
       	ret = unbundle(the_repository, &data->header, data->fd,
     --		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_ALWAYS);
     -+		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_FOLLOW_FETCH);
     +-		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_ALWAYS);
     ++		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
       	transport->hash_algo = data->header.hash_algo;
       	return ret;
       }

-- 
gitgitgadget

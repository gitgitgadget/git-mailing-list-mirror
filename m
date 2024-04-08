Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2325753
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597899; cv=none; b=TPNRdqbuavctJZiJla9B1lxUv/sGiEpNoRCjreDwoXyCp04JA5rL/q4SyrHI7wJZ3Tlwvn1Vrz86LCC7BfxLZYAQI5mCNkQtxPj1VQJfX0VZvxf3eaqQDNbriwbXstRpanBNYFANhMcg9nxFbgzmkP9P1MFABeTyPdccj762xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597899; c=relaxed/simple;
	bh=q2RS1kcN7v7gZgdMXCPRNhMIyUrZ8rwAqw/QXHoPlfY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MGmuQbXaCqP+rtJ0l1lMy0UbkH6sS61ru/QRKWySn1HutNTdteZFNCN9jThxN/Ghm5Re8+i8LQD+pOjK462Cgbmbxw3c+2xCsq0zqkFAn0rE4CH/Q4v8IZA+/I3XsEDedDj2H/5rtC4LCJqokyfJPnLc7rM+ltHLf8aUHPRzCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMm15V1V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMm15V1V"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41650de9e1eso9654065e9.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597895; x=1713202695; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5DRQnIPOJwtuf8yEq64imP3mORngoKZAjI/HztnR9E=;
        b=mMm15V1VpAEVlUyMz67/IZLQTOkeoQc/NCQxIvv9Yfbsoot3HZwtvbaAIqpoJIKzCn
         NR670qA9Xm1DspgbqZN+YrKUAtwyZezs0H5nBOg2k99YvzN9A84Ug4DSMKkUcXhWSgw5
         hqDQGsSb4TORTL7l2XC9SS1Gn7wRaHgjXBhoIRN9Yf67rU+NXhJPDM9bmZwK+d48mLK8
         nLK0wRtABdn4uQQXSNIk9OAcrBQISIU9fYVL7drpQ9nAk6SXSextuy9qk1CB7DbOlEvB
         EHiaxdh1FWsOHwfggIg1TiNnpdKEwSN/eETu+9ZBxlutz+KXooIxWSLy+C7rM0pe5BCc
         A0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597895; x=1713202695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5DRQnIPOJwtuf8yEq64imP3mORngoKZAjI/HztnR9E=;
        b=i53f5SWD9ZMKjCCyaI9BJ65wTHdxiqHljtKWmlBTeyFTjaJ9BrFrovfgYV4WdRQBX7
         VFp20KXPjdm3xb+EttBNNGPpdGuUhWFeRRzI3J+LmVmIPxlQqibpbBG/9G8iDApenj7/
         MCUQrFlr4eHK0jJlFkUYKbIOWq7JtpRA1/TYDigGS8BM4Lg3H7Ip/8+HN3JvcfZ4Qm9b
         T926Kv+b2tR2+OWrFzKMqsf6J8RnNrKLsHVyR17C/+bi2Qo4HKcO0uTP4eUL1yTQEhCs
         ekF7TgAh80WYEJG1sm+uS8WiSBF4yMtu2XiKn8CjtBl/R6wk0wYs7F+Lp0V9+OETd0ql
         WAUQ==
X-Gm-Message-State: AOJu0Yy8kpk/oaDv6+Qi1B6QY3e1QhMp6Sl+Q+vlwb7e41/RMTsUJmSU
	eEY2yy6F1wa2o4/2DTijXVs1pSP7LaVpfsDu/JFiU58JaCMF+o8pd5vMQ7Xp
X-Google-Smtp-Source: AGHT+IGNeA9gmqzT8ayrXQq65yNGdoF3qcVjjma4fA3EEfg7jrXcxFhO9ms27imetppQGXNBFQvanw==
X-Received: by 2002:a05:600c:1d1f:b0:416:6bb7:dfe6 with SMTP id l31-20020a05600c1d1f00b004166bb7dfe6mr351398wms.2.1712597894931;
        Mon, 08 Apr 2024 10:38:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b004162bac1393sm14131135wmq.43.2024.04.08.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:38:14 -0700 (PDT)
Message-Id: <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 17:38:10 +0000
Subject: [PATCH v2 0/3] show-ref: add --symbolic-name option
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>

For reftable development, it would be handy to have a tool to provide the
direct value of any ref whether it be a symbolic ref or not. Currently there
is git-symbolic-ref, which only works for symbolic refs, and git-rev-parse,
which will resolve the ref. Let's add a --symbolic-name option that will
print out the value the ref directly points to without dereferencing it.

Changes since V1:

 * changed output format to print out values as a third column
 * made plumbing changes to enable the value of a symbolic ref to be read
   from the iterator
 * changed the name of the flag

John Cai (3):
  refs: keep track of unresolved reference value in iterator
  refs: add referent to each_repo_ref_fn
  show-ref: add --symbolic-name option

 Documentation/git-show-ref.txt | 21 ++++++++++++++++++-
 builtin/replace.c              |  1 +
 builtin/show-ref.c             | 38 ++++++++++++++++++++++++----------
 builtin/submodule--helper.c    |  2 +-
 refs.c                         | 31 ++++++++++++++++++---------
 refs.h                         |  6 ++++--
 refs/files-backend.c           | 20 ++++++++++--------
 refs/iterator.c                |  3 ++-
 refs/ref-cache.c               |  3 +++
 refs/ref-cache.h               |  2 ++
 refs/refs-internal.h           |  1 +
 refs/reftable-backend.c        | 13 ++++++++----
 remote.c                       |  2 +-
 replace-object.c               |  1 +
 sequencer.c                    |  4 ++--
 t/helper/test-ref-store.c      |  2 +-
 t/t1403-show-ref.sh            | 20 ++++++++++++++++++
 worktree.c                     |  4 +++-
 18 files changed, 130 insertions(+), 44 deletions(-)


base-commit: 7774cfed6261ce2900c84e55906da708c711d601
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1684%2Fjohn-cai%2Fjc%2Fshow-ref-direct-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1684/john-cai/jc/show-ref-direct-v2
Pull-Request: https://github.com/git/git/pull/1684

Range-diff vs v1:

 -:  ----------- > 1:  6adc9dd26da refs: keep track of unresolved reference value in iterator
 -:  ----------- > 2:  b60e78560e0 refs: add referent to each_repo_ref_fn
 1:  c32572a8d0b ! 3:  a9e6644327a show-ref: add --unresolved option
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    show-ref: add --unresolved option
     +    show-ref: add --symbolic-name option
      
          For reftable development, it would be handy to have a tool to provide
          the direct value of any ref whether it be a symbolic ref or not.
          Currently there is git-symbolic-ref, which only works for symbolic refs,
     -    and git-rev-parse, which will resolve the ref. Let's add a --unresolved
     -    option that will only take one ref and return whatever it points to
     -    without dereferencing it.
     +    and git-rev-parse, which will resolve the ref. Let's teach show-ref a
     +    --symbolic-name option that will cause git-show-ref(1) to print out the
     +    value symbolic references points to.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/git-show-ref.txt ##
      @@ Documentation/git-show-ref.txt: SYNOPSIS
     + [verse]
     + 'git show-ref' [--head] [-d | --dereference]
     + 	     [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]
     +-	     [--heads] [--] [<pattern>...]
     ++	     [--heads] [--symbolic-name] [--] [<pattern>...]
     + 'git show-ref' --verify [-q | --quiet] [-d | --dereference]
     + 	     [-s | --hash[=<n>]] [--abbrev[=<n>]]
       	     [--] [<ref>...]
     - 'git show-ref' --exclude-existing[=<pattern>]
     - 'git show-ref' --exists <ref>
     -+'git show-ref' --unresolved <ref>
     - 
     - DESCRIPTION
     - -----------
      @@ Documentation/git-show-ref.txt: OPTIONS
     - 	it does, 2 if it is missing, and 1 in case looking up the reference
     - 	failed with an error other than the reference being missing.
     + 	Dereference tags into object IDs as well. They will be shown with `^{}`
     + 	appended.
     + 
     ++--symbolic-name::
     ++
     ++	Print out the value the reference points to without dereferencing. This
     ++	is useful to know the reference that a symbolic ref is pointing to.
     ++
     + -s::
     + --hash[=<n>]::
     + 
     +@@ Documentation/git-show-ref.txt: $ git show-ref --heads --hash
     + ...
     + -----------------------------------------------------------------------------
       
     -+--unresolved::
     ++When using `--symbolic-name`, the output is in the format:
     ++
     ++-----------
     ++<oid> SP <ref> SP <symbolic-name>
     ++-----------
      +
     -+	Prints out what the reference points to without resolving it. Returns
     -+	an exit code of 0 if it does, 2 if it is missing, and 1 in case looking
     -+	up the reference failed with an error other than the reference being
     -+	missing.
     ++For example,
      +
     - --abbrev[=<n>]::
     ++-----------------------------------------------------------------------------
     ++$ git show-ref --symbolic-name
     ++b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:refs/heads/main
     ++...
     ++-----------------------------------------------------------------------------
     ++
     + EXAMPLES
     + --------
       
     - 	Abbreviate the object name.  When using `--hash`, you do
      
       ## builtin/show-ref.c ##
     -@@ builtin/show-ref.c: static const char * const show_ref_usage[] = {
     +@@
     + static const char * const show_ref_usage[] = {
     + 	N_("git show-ref [--head] [-d | --dereference]\n"
     + 	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]\n"
     +-	   "             [--heads] [--] [<pattern>...]"),
     ++	   "             [--heads] [--symbolic-name] [--] [<pattern>...]"),
     + 	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
     + 	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]]\n"
       	   "             [--] [<ref>...]"),
     - 	N_("git show-ref --exclude-existing[=<pattern>]"),
     - 	N_("git show-ref --exists <ref>"),
     -+	N_("git show-ref --unresolved <ref>"),
     - 	NULL
     +@@ builtin/show-ref.c: struct show_one_options {
     + 	int hash_only;
     + 	int abbrev;
     + 	int deref_tags;
     ++	int symbolic_name;
       };
       
     -@@ builtin/show-ref.c: static int cmd_show_ref__patterns(const struct patterns_options *opts,
     - 	return 0;
     - }
     + static void show_one(const struct show_one_options *opts,
     +-		     const char *refname, const struct object_id *oid)
     ++		     const char *refname,
     ++		     const char *referent,
     ++		     const struct object_id *oid, const int is_symref)
     + {
     + 	const char *hex;
     + 	struct object_id peeled;
     +@@ builtin/show-ref.c: static void show_one(const struct show_one_options *opts,
     + 	hex = repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
     + 	if (opts->hash_only)
     + 		printf("%s\n", hex);
     +-	else
     ++	else if (opts->symbolic_name & is_symref) {
     ++		printf("%s %s ref:%s\n", hex, refname, referent);
     ++	} else
     + 		printf("%s %s\n", hex, refname);
       
     --static int cmd_show_ref__exists(const char **refs)
     -+static int cmd_show_ref__raw(const char **refs, int show)
     + 	if (!opts->deref_tags)
     +@@ builtin/show-ref.c: struct show_ref_data {
     + 	int show_head;
     + };
     + 
     +-static int show_ref(const char *refname, const struct object_id *oid,
     +-		    int flag UNUSED, void *cbdata)
     ++static int show_ref_referent(struct repository *repo UNUSED,
     ++			     const char *refname,
     ++			     const char *referent,
     ++			     const struct object_id *oid,
     ++			     int flag, void *cbdata)
       {
     --	struct strbuf unused_referent = STRBUF_INIT;
     --	struct object_id unused_oid;
     --	unsigned int unused_type;
     -+	struct strbuf referent = STRBUF_INIT;
     -+	struct object_id oid;
     -+	unsigned int type;
     - 	int failure_errno = 0;
     - 	const char *ref;
     - 	int ret = 0;
     -@@ builtin/show-ref.c: static int cmd_show_ref__exists(const char **refs)
     - 		die("--exists requires exactly one reference");
     - 
     - 	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
     --			      &unused_oid, &unused_referent, &unused_type,
     -+			      &oid, &referent, &type,
     - 			      &failure_errno)) {
     - 		if (failure_errno == ENOENT || failure_errno == EISDIR) {
     - 			error(_("reference does not exist"));
     -@@ builtin/show-ref.c: static int cmd_show_ref__exists(const char **refs)
     - 		goto out;
     - 	}
     + 	struct show_ref_data *data = cbdata;
       
     -+		if (!show)
     -+			goto out;
     -+
     -+		if (type & REF_ISSYMREF)
     -+			printf("ref: %s\n", referent.buf);
     -+		else
     -+			printf("ref: %s\n", oid_to_hex(&oid));
     -+
     - out:
     --	strbuf_release(&unused_referent);
     -+	strbuf_release(&referent);
     - 	return ret;
     +@@ builtin/show-ref.c: static int show_ref(const char *refname, const struct object_id *oid,
     + match:
     + 	data->found_match++;
     + 
     +-	show_one(data->show_one_opts, refname, oid);
     ++	show_one(data->show_one_opts, refname, referent, oid, flag & REF_ISSYMREF);
     + 
     + 	return 0;
       }
       
     ++static int show_ref(const char *refname, const struct object_id *oid,
     ++		    int flag, void *cbdata)
     ++{
     ++	return show_ref_referent(NULL, refname, NULL, oid, flag, cbdata);
     ++}
     ++
     + static int add_existing(const char *refname,
     + 			const struct object_id *oid UNUSED,
     + 			int flag UNUSED, void *cbdata)
     +@@ builtin/show-ref.c: static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
     + 
     + 	while (*refs) {
     + 		struct object_id oid;
     ++		int flags = 0;
     + 
     + 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
     +-		    !read_ref(*refs, &oid)) {
     +-			show_one(show_one_opts, *refs, &oid);
     ++		    !read_ref_full(*refs, 0, &oid, &flags)) {
     ++			show_one(show_one_opts, *refs, NULL, &oid, flags & REF_ISSYMREF);
     + 		}
     + 		else if (!show_one_opts->quiet)
     + 			die("'%s' - not a valid ref", *refs);
     +@@ builtin/show-ref.c: static int cmd_show_ref__patterns(const struct patterns_options *opts,
     + 		head_ref(show_ref, &show_ref_data);
     + 	if (opts->heads_only || opts->tags_only) {
     + 		if (opts->heads_only)
     +-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
     ++			for_each_ref_all("refs/heads/", show_ref_referent, &show_ref_data);
     + 		if (opts->tags_only)
     +-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
     ++			for_each_ref_all("refs/tags/", show_ref_referent, &show_ref_data);
     + 	} else {
     +-		for_each_ref(show_ref, &show_ref_data);
     ++		for_each_ref_all("", show_ref_referent, &show_ref_data);
     + 	}
     + 	if (!show_ref_data.found_match)
     + 		return 1;
      @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, const char *prefix)
     - 	struct exclude_existing_options exclude_existing_opts = {0};
     - 	struct patterns_options patterns_opts = {0};
     - 	struct show_one_options show_one_opts = {0};
     --	int verify = 0, exists = 0;
     -+	int verify = 0, exists = 0, unresolved = 0;
     - 	const struct option show_ref_options[] = {
       		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with heads)")),
       		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can be combined with tags)")),
       		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),
     -+		OPT_BOOL(0, "unresolved", &unresolved, N_("print out unresolved value of reference")),
     ++		OPT_BOOL(0, "symbolic-name", &show_one_opts.symbolic_name, N_("print out symbolic reference values")),
       		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
       			    "requires exact ref path")),
       		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
     -@@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, const char *prefix)
     - 	argc = parse_options(argc, argv, prefix, show_ref_options,
     - 			     show_ref_usage, 0);
     - 
     --	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-existing",
     -+	die_for_incompatible_opt4(exclude_existing_opts.enabled, "--exclude-existing",
     - 				  verify, "--verify",
     --				  exists, "--exists");
     -+				  exists, "--exists",
     -+				  unresolved, "--unresolved");
     - 
     - 	if (exclude_existing_opts.enabled)
     - 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
     - 	else if (verify)
     - 		return cmd_show_ref__verify(&show_one_opts, argv);
     --	else if (exists)
     --		return cmd_show_ref__exists(argv);
     -+	else if (exists || unresolved)
     -+		return cmd_show_ref__raw(argv, unresolved);
     - 	else
     - 		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
     - }
      
     - ## t/t1403-show-ref.sh ##
     -@@ t/t1403-show-ref.sh: test_expect_success 'show-ref sub-modes are mutually exclusive' '
     - 	test_must_fail git show-ref --exclude-existing --exists 2>err &&
     - 	grep "exclude-existing" err &&
     - 	grep "exists" err &&
     -+	grep "cannot be used together" err &&
     -+
     -+	test_must_fail git show-ref --exclude-existing --unresolved 2>err &&
     -+	grep "exclude-existing" err &&
     -+	grep "unresolved" err &&
     -+	grep "cannot be used together" err &&
     + ## refs.c ##
     +@@ refs.c: int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
     + 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
     + }
     + 
     ++int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_data)
     ++{
     ++	return do_for_each_repo_ref(the_repository, prefix, fn, 0,
     ++				    0, cb_data);
     ++}
      +
     -+	test_must_fail git show-ref --verify --unresolved 2>err &&
     -+	grep "verify" err &&
     -+	grep "unresolved" err &&
     - 	grep "cannot be used together" err
     - '
     + int for_each_namespaced_ref(const char **exclude_patterns,
     + 			    each_ref_fn fn, void *cb_data)
     + {
     +
     + ## refs.h ##
     +@@ refs.h: int refs_for_each_branch_ref(struct ref_store *refs,
     + 			     each_ref_fn fn, void *cb_data);
     + int refs_for_each_remote_ref(struct ref_store *refs,
     + 			     each_ref_fn fn, void *cb_data);
     +-
     + /* just iterates the head ref. */
     + int head_ref(each_ref_fn fn, void *cb_data);
     + 
     +@@ refs.h: int for_each_tag_ref(each_ref_fn fn, void *cb_data);
     + int for_each_branch_ref(each_ref_fn fn, void *cb_data);
     + int for_each_remote_ref(each_ref_fn fn, void *cb_data);
     + int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
     ++int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_data);
       
     + /* iterates all refs that match the specified glob pattern. */
     + int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
     +
     + ## t/t1403-show-ref.sh ##
      @@ t/t1403-show-ref.sh: test_expect_success '--exists with existing special ref' '
       	git show-ref --exists FETCH_HEAD
       '
       
     -+test_expect_success '--unresolved with existing reference' '
     ++test_expect_success '--symbolic-name with a non symbolic ref' '
      +	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
      +	cat >expect <<-EOF &&
     -+	ref: $commit_oid
     -+	EOF
     -+	git show-ref --unresolved refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success '--unresolved with symbolic ref' '
     -+	test_when_finished "git symbolic-ref -d SYMBOLIC_REF_A" &&
     -+	cat >expect <<-EOF &&
     -+	ref: refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     ++	$commit_oid refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +	EOF
     -+	git symbolic-ref SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
     -+	git show-ref --unresolved SYMBOLIC_REF_A >actual &&
     ++	git show-ref --symbolic-name refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--unresolved with nonexistent object ID' '
     -+	oid=$(test_oid 002) &&
     -+	test-tool ref-store main update-ref msg refs/heads/missing-oid-2 $oid $ZERO_OID REF_SKIP_OID_VERIFICATION &&
     ++test_expect_success '--symbolic-name with symbolic ref' '
     ++	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &&
     ++	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
      +	cat >expect <<-EOF &&
     -+	ref: $oid
     ++	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +	EOF
     -+	git show-ref --unresolved refs/heads/missing-oid-2 >actual &&
     ++	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
     ++	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
      +	test_cmp expect actual
      +'
     -+
     -+test_expect_success '--unresolved with nonexistent reference' '
     -+	cat >expect <<-EOF &&
     -+	error: reference does not exist
     -+	EOF
     -+	test_expect_code 2 git show-ref --unresolved refs/heads/not-exist 2>err &&
     -+	test_cmp expect err
     -+'
      +
       test_done

-- 
gitgitgadget

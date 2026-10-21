Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581752;
	b=2bQtxY8bJZC0EA6DSOjYFEv03OicuLkhGF5sq7esP6Kmcrld4+4OKVOBMZkxv+sk5G4b
	 D5UZM8TRwzqoKaVcJGBsrnFf3kUb6WKC9wzUG4q/zk5POtpQBxWzobm/i7um9tFADhWFQ
	 m+jYGf+UR608+Sz1MCn50RScntuwxd1BtQH16m40BBAGLWVpQOQrD4YN7ViiW89PYynf4
	 NI3tKm3AMepnjVgrRGXvqnXxdcWfkew7BhmI9Nl6+qwUpw2jI1h9BAJQ/qqPfxJ/+8EnR
	 JGcWM/6Ryq2SlkUiBetRMRm7+BKtDoCcsHUMaEcIlfPwl5q1y671aM7XT6coDvCDnGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
	b=ccW68pVF0BX/+LbDRBHVSKoRspYI4Gpq/GmycShHT4GnelUZtArQ2TaL/k9IbBm19ZmE
	 fBIyjdE04zvCYNzwHpMmUneShxMDog6/AexKsmf8gcPLbOZvDEVIzqRIKGhUI0644k6Iv
	 KIPkmB5DzoMHKd+EREzj5uOo5Iz/053a/RPumsHD9n13ij3HdWIzsbt8z2XChbp7gUDME
	 D5L8DJsdAmrD7t9OPn6kmPMsRcxw61ilO03aOrBWN2zsWeRcd+rH+/kL8KWtH3mu5FlQA
	 CkJh1KsLtndDOT3lBvGCYEqjFqZZqK2si+lWfhw4oJCh7RaJH+x4UZkBSSFSg8NxHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ciOXghEt;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AAC606A321
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AAC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ciOXghEt
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so402774a91.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581751; x=1793186551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
        b=ciOXghEtD6wQ1BrXDMOi9KPdRFGo1mVhNktnGbWKlOJRwB2rQHvMMZ5CukdeH+QttQ
         +3K5sFN+Zd8GzRstNDcVgvf/G62sccpPVCIJRB/SvxvXFccocXiSniBHJyYZxtwDzYSe
         ZG/7yrdWnnJdN3cU/4LbkpwaI+oVua/CZPDa9zcdQWXGGUNdlQz3LB3owwNaq7TLU6my
         Nor1/EUdHg7qyo6aU+du/9GaHHiR28BATZ7DTAHWgikqFNpLVnTpuLXiSt8yo4dWfMHW
         qjjiYTNq39gsfboQXRl7BAzfeaTfy8TWDTUXMzOmSctB9uEtv3FA+7B/Inr90SJcNDY0
         ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581751; x=1793186551;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
        b=GTzFZ9iXMULRFE9dFPhg2Gz7x4uYQdihHZCmtBy8l8S8xJhYyKn1G+jZPuGAD8Cw6c
         WrQseryqQvAJA/qUdBrRDyub7YFzo0DuVDuKnEOeU8OYYiupifIENSY7l6qkdUEtnugy
         KA1Br9thOadFsWXvWLZ+SpnT0m9yiNEraR+oke5r3IeeDCNGbsc1YJRAqS7+KH1O97Fi
         4v8JWxGswedpp7xjT2Ln82ahWa/tm4ErccLoE4UQ9OprQJjWwMPq2VxXwJiY3TEO/Hy2
         VQWTYenNoawLHOMFivlowNiLr3g2ZkFy0tzrRRHTtgIGAajlfnYJh7uRfrpJZHRFTVTl
         N63Q==
X-Gm-Message-State: AFq9FYK8lHtSJO/b715ShaYpFHaG+5CUhC5LfLnoiGcoS4NQ38XAu/c1
	lXnwGgjIv7TcD/vxtqXref9JJkVlqLnwvXkSXe22vtUNAV515T8ANTlMAbnozQ==
X-Gm-Gg: AYBFou29zKotbAhNUWurrEm7HiTPk0HE7/QCtnEC2IGZxl0KCFRPpzG4s5DLludZzQM
	a+DatyWV/r/xjJ1UfEb1JHi7ia9S0cQbXmzeLP6U6ABEgJ/L8MVB4MnMMVVP8hajx2ApfWJqCgn
	qTG0e5kexUktFCZL2utz59Ug+c3zDqzjAWJLtAaY4EFJPLpNF6pGr8MwKypa2nZ/Heb9Lfvn2/a
	7nUuhuJA5qaSdlqKEwxruDEPut0RCCeG7QzP469ZYi+Exzk/PEKfZXi+hlSKxGeZpr9Uqi4garE
	BpuSlE5wDXurkWeSTW4Q3Q7z4/UTToqdo/msmjb3G6f9cKtewTylgjkYQuGoP4SbAP/IMStv5j7
	zXEHY4OyvDgonL+uBLyu/zr30XJRsvQyIgqVdrxPie1G/cVx87GiQkG1m8jRZnuaQB1CtMrjvKs
	QAt9AVye37CURVvQ/M+OkFf1cF8/9ZTAVB0R9udZ7/HKAWDC1UAS0Z4cnzYaaLNFiydxT1dWIvY
	/chRD0xB0N7Z1C+rmpZDb0frHtIqbTIbOLSo9AxZ2wi5YvcnS16X8v/
X-Received: by 2002:a17:90b:1c0d:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3ad86b0c7d7mr1579575a91.9.1792581751049;
        Wed, 21 Oct 2026 04:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad83482f35sm1965707a91.1.2026.10.21.04.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:30 -0700 (PDT)
Message-Id: <3a7a1fb95320ed7226d00b5ff759cf88dedf5de0.1792581744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:21 +0000
Subject: [PATCH v4 3/6] connected: drop dependency on `the_repository`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The next commits will need to use the repository to read configuration
in check_connected(). Rather than accessing `the_repository`, refactor
the code to instead require the caller to pass in a repository so that
we can remove `USE_THE_REPOSITORY_VARIABLE`.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/clone.c        |  2 +-
 builtin/fetch.c        |  5 +++--
 builtin/receive-pack.c | 12 ++++++++----
 bundle.c               |  2 +-
 connected.c            | 22 +++++++++++-----------
 connected.h            |  4 +++-
 fetch-pack.c           |  3 ++-
 7 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 44037dd428..1532361ea0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -572,7 +572,7 @@ static void update_remote_refs(const struct ref *refs,
 		opt.transport = transport;
 		opt.progress = transport->progress;
 
-		if (check_connected(iterate_ref_map, &rm, &opt))
+		if (check_connected(the_repository, iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..0ef7fe92f1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1250,7 +1250,8 @@ static int store_updated_refs(struct display_state *display_state,
 
 		opt.exclude_hidden_refs_section = "fetch";
 		rm = ref_map;
-		if (check_connected(iterate_ref_map, &rm, &opt)) {
+		if (check_connected(the_repository, iterate_ref_map,
+				    &rm, &opt)) {
 			rc = error(_("%s did not send all necessary objects"),
 				   display_state->url);
 			goto abort;
@@ -1422,7 +1423,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 
 	opt.quiet = 1;
 	opt.exclude_hidden_refs_section = "fetch";
-	return check_connected(iterate_ref_map, &rm, &opt);
+	return check_connected(the_repository, iterate_ref_map, &rm, &opt);
 }
 
 static int fetch_and_consume_refs(struct display_state *display_state,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1d5b050beb..4f8f58950a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1385,7 +1385,8 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 			oid_array_append(&extra, &si->shallow->oid[i]);
 
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
-	if (check_connected(command_singleton_iterator, cmd, &opt)) {
+	if (check_connected(the_repository, command_singleton_iterator,
+			    cmd, &opt)) {
 		rollback_shallow_file(the_repository, &shallow_lock);
 		oid_array_clear(&extra);
 		return -1;
@@ -1827,8 +1828,9 @@ static void set_connectivity_errors(struct command *commands,
 		odb_transaction_env(transaction, &env);
 		opt.env = env.v;
 
-		if (!check_connected(command_singleton_iterator, &singleton,
-				     &opt))
+		if (!check_connected(the_repository,
+				     command_singleton_iterator,
+				     &singleton, &opt))
 			continue;
 
 		cmd->error_string = "missing necessary objects";
@@ -2090,7 +2092,9 @@ static void execute_commands(struct command *commands,
 		opt.env = env.v;
 		opt.exclude_hidden_refs_section = "receive";
 
-		if (check_connected(iterate_receive_command_list, &data, &opt))
+		if (check_connected(the_repository,
+				    iterate_receive_command_list,
+				    &data, &opt))
 			set_connectivity_errors(commands, si, transaction);
 
 		if (use_sideband)
diff --git a/bundle.c b/bundle.c
index f55a521b2a..0a68e856f5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -259,7 +259,7 @@ int verify_bundle(struct repository *r,
 	if (ret)
 		goto cleanup;
 
-	if ((ret = check_connected(iterate_ref_map, &iter, &opts)))
+	if ((ret = check_connected(r, iterate_ref_map, &iter, &opts)))
 		error(_("some prerequisite commits exist in the object store, "
 			"but are not connected to the repository's history"));
 
diff --git a/connected.c b/connected.c
index 929b9bd28d..34045f1032 100644
--- a/connected.c
+++ b/connected.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
@@ -35,23 +33,24 @@ static int promised_object_cb(const struct object_id *oid UNUSED,
  * objects in non-promisor packs, in which case we'll have to fall back to the
  * rev-list-based connectivity checks. Returns a negative error code on error.
  */
-static int check_connected_promisor(oid_iterate_fn fn,
+static int check_connected_promisor(struct repository *repo,
+				    oid_iterate_fn fn,
 				    void *cb_data,
 				    const struct object_id **oid)
 {
 	struct odb_for_each_object_options opts = {
 		.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
-		.prefix_hex_len = the_repository->hash_algo->hexsz,
+		.prefix_hex_len = repo->hash_algo->hexsz,
 	};
 	int err;
 
-	odb_reprepare(the_repository->objects);
+	odb_reprepare(repo->objects);
 	do {
 		bool found = false;
 
 		opts.prefix = *oid;
 
-		err = odb_for_each_object_ext(the_repository->objects, NULL,
+		err = odb_for_each_object_ext(repo->objects, NULL,
 					      promised_object_cb, &found, &opts);
 		if (err < 0)
 			return err;
@@ -78,7 +77,8 @@ static int check_connected_promisor(oid_iterate_fn fn,
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_connected(oid_iterate_fn fn, void *cb_data,
+int check_connected(struct repository *repo,
+		    oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt)
 {
 	struct child_process rev_list = CHILD_PROCESS_INIT;
@@ -101,8 +101,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		return err;
 	}
 
-	if (repo_has_promisor_remote(the_repository)) {
-		err = check_connected_promisor(fn, cb_data, &oid);
+	if (repo_has_promisor_remote(repo)) {
+		err = check_connected_promisor(repo, fn, cb_data, &oid);
 		if (err) {
 			if (opt->err_fd)
 				close(opt->err_fd);
@@ -119,7 +119,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args,"rev-list");
 	strvec_push(&rev_list.args, "--objects");
 	strvec_push(&rev_list.args, "--stdin");
-	if (repo_has_promisor_remote(the_repository))
+	if (repo_has_promisor_remote(repo))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		strvec_push(&rev_list.args, "--not");
@@ -160,7 +160,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
 			   base_len);
 		strbuf_addstr(&idx_file, ".idx");
-		new_pack = add_packed_git(the_repository, idx_file.buf,
+		new_pack = add_packed_git(repo, idx_file.buf,
 					  idx_file.len, 1);
 		strbuf_release(&idx_file);
 	}
diff --git a/connected.h b/connected.h
index 16b2c84f2e..0624965baa 100644
--- a/connected.h
+++ b/connected.h
@@ -2,6 +2,7 @@
 #define CONNECTED_H
 
 struct object_id;
+struct repository;
 struct transport;
 
 /*
@@ -66,7 +67,8 @@ struct check_connected_options {
  *
  * If "opt" is NULL, behaves as if CHECK_CONNECTED_INIT was passed.
  */
-int check_connected(oid_iterate_fn fn, void *cb_data,
+int check_connected(struct repository *repo,
+		    oid_iterate_fn fn, void *cb_data,
 		    struct check_connected_options *opt);
 
 #endif /* CONNECTED_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index 30a4dd6119..2cf8f8d653 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2186,7 +2186,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		opt.shallow_file = alternate_shallow_file;
 		if (args->deepen)
 			opt.is_deepening_fetch = 1;
-		if (check_connected(iterate_ref_map, &iterator, &opt)) {
+		if (check_connected(the_repository, iterate_ref_map,
+				    &iterator, &opt)) {
 			error(_("remote did not send all necessary objects"));
 			free_refs(ref_cpy);
 			ref_cpy = NULL;
-- 
gitgitgadget


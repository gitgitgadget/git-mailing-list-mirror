Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761127;
	b=lx4edfgv+G+EOsm7WFcDlHewq4AiUyZhy/4ZjEpsCsBfT0fEdIItuHpA4g3VsXyijBmW
	 hNi88jbSeqoC3cxfOLchFWi8pthDtN5FNy/SThQ9iMEwPARlNaigNl758To/flaf28Vi2
	 5Gf8udfZ+A+1Rshsoh/tPZ1V2fZ2At/u07dZycTPeJw0O6+a23GXyDCZ4Ab5HMONAq0c4
	 UNPWlRTQKi4OzKI/ZgVqQu9WVgs+mtmq3hrsFpG9Ux0LV0S4iCUmM2ZjqhdveorXZGGtN
	 Xu0WfAP3h2xTYsRSeYfUp7zqRcJ4kpJIQCRU2tp2OAAsfHVt4wAK1JRrO9VMTSIDcxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
	b=1WVZjwVRXLL3fxVQ/SQ/NAJBkrwmGkm+AEv2yXsf7M2nPgYyrT+8KsAldgYJ3GqDte++
	 agw3DdTu3oviEwDCunCd1okqNIcw7jhJpffFwAQyHtoqaUmHGMEeD1auXcK+sYZ272bSG
	 8NC1R+Ga7okFBrj/7NvxkJsyN/zLwLHkFhN9yo4QaS1sJurtH7qLzE+PceBBIpCapnXbw
	 I6c4D5kshhzwiUPv0CrE42yXtz+xjiytoq8r2eI/wdTHuMtN2aEOEV3AggtlNlYSVhNRP
	 PBRzPU3XfaAKpoJVui/Q2aUTBZT3Eji3FZebS80Safpn/lZP24F2KcYO6JgqhM/AGmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zs7iOJ0X;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADC606A32D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCADC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zs7iOJ0X
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677af43eed4so915621d50.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761126; x=1793365926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
        b=Zs7iOJ0XtnOWbbRyWP2nVX1AeRxwge52A7YZMdhKVhYdyWJi2Oz58MGza+8LNFSgYl
         oLksmmO39U7Ic//dF/d+u6OEOdWwbaY+QOYo45a25GIWE1vpF3QJcF/YknX7NsOR437y
         J0UHEvxxYniNv3ANWOENGRsokCR584BIcDJ6QQdNeh+DWtcY7wlRLRfZL9BQiRNZFXQ7
         ka5Jr9PPdgVk1+In8vnX5/frMReicQmUSqFkoONpBBMm8snBNYWpTqV5MvR6g2L7h2Yu
         FTX+S/M+2Cg9ghWbtCF4pU3p1X3953gObaDwAbst3L4t2Nl7fI6xoCCsjKZBF1Si0iDC
         nC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761126; x=1793365926;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQu+biLCxUrIQpCskwwd9mo2ufAM9ZuXI5bDKHT0yJA=;
        b=ZoAIZyBJS/6KBudiLTC2evALYe7R5EHfbZXOjUyRHhjV7Z5siVfIc2x7umz+Lcw83h
         4OErVaO++uKk7jxg+Wd/ByI8f0zTX+eqMY7aqyUZX0DiJ8o6ai2CiiJYiQfYk/SpL8P3
         FAo1w170zgPXGvULuuBpe3ZCIa3eqqeEPFcui6/5mEAGH9xu3iBqAbW9RKTDEvGRU1zL
         0ecjgSQMxAGNhrQ0KZP8XwpKDGA4/KykmrRCTblN4DwaR+At7reBpvRF/ta8uAKMbW4o
         oTIi0m52L83TM1U0LjrX30APRW/+enRfttNTdT9kSoVBvmV4GHay91LWLxAa7cVj29OD
         r0Hg==
X-Gm-Message-State: AFq9FYL8i/wHX+svFIwM3r9E5EjIgGNxVu2c7phBBo7vzQtnFX8ZaVZt
	7tqi7g2YiVZ1mW3aE0/zoNWDtXT0N+4SEb9K7j2oZfl6pOrD/T57+NVw4gHdXK30
X-Gm-Gg: AYBFou30iMlMME0VM1X7H7TjxOljjO5HGUaleNLEDjKCCIrqmqpKmMo1TDn3PQL+u8y
	rnER7DXpeZt6gcDHmbEECR1l2ImMK5ucGW5Gssn8eX83LVyjpFQJ4QseqolWFKTkd/1p+C7noFZ
	uZsm7TXGPpcWtkHdoLqBnYReg+fpVM7dMBraxkMuL+9agRtwex3cbR48skErMu9k2t12ScqfSJa
	d4N5qV46WoD1sowzhkxJBZVCHEFKY5YbdklhtKpssyyjTGf8fj+wsK6daCtIFJQchgW/VkpwHK1
	nIgMgrMl9imDwzWzhatIUVRSTcOjkb3hpTYf0C0wLkiiTO7r+c7bhXhnEWGaqWmxy8kFl7YMF8v
	HNEEpWjOoHMDKXt+kaN2v/WFdYN347iHrWtFdUfJCQegRY4yM24tjxPBaPC2kUM5CHBt6cNy3sq
	jl4nqAP4OQq7iGDTxsPLTPXYzitevdVq+NcmGxXuh8XIgNnGL9PBxwAKY9VtHuuc8t4cZr4YKaC
	mOrWTv+OoJXl66NN1bP/TA+U9aSNnXN7po0C8g+ZX1ofCRprKzMGzZ7KAmj
X-Received: by 2002:a05:690e:80a:10b0:679:c7d1:ffd6 with SMTP id 956f58d0204a3-67a35bedd13mr1210541d50.36.1792761125872;
        Fri, 23 Oct 2026 06:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a34009247sm1314599d50.11.2026.10.23.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:04 -0700 (PDT)
Message-Id: <3a7a1fb95320ed7226d00b5ff759cf88dedf5de0.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:56 +0000
Subject: [PATCH v5 3/6] connected: drop dependency on `the_repository`
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


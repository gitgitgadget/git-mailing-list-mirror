Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBB3E122C
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171591; cv=none; b=HlOEYBf12i0JsfbYLGFRWlUTjWB7zwWWAJlcuRyMIOjpJcsIfnlwlSqwFX6JrPj9wfMXZKBG6oTGI8KJdhvOwCscazSzynNz0SqgOOeh2dCpuzNVswGnD5znWJfjKeH+sYQa8hwREq8eUd66maOd+8bK/V8NC645YALB9At9EPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171591; c=relaxed/simple;
	bh=/eVDA1f3jrIOC8Unzd0pFU/8PSU57fHfV0r1oCUhIKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pjSrOnC51LCIpT1ijJVR6Bo+GVmdarLWgozBnVqP74ALC5nRZoOXwu/szTLc3aMsdswANjL1AxuBazjw5tl1SEzCr2rBCKqc5gvqu3ww0tVaY25+uUhteAt3F2HDiEopbNV7MuCHEpGANWdwHVp05q4QMiFMHyDhRKnkfsVCElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtXv5rNE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtXv5rNE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d560ede296so649296685a.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171588; x=1776776388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beymlgFr/YboZxFQwo976Na4fpAIT1nSSgpCEyfALzQ=;
        b=LtXv5rNElgvrBlDSFVXLnK1KrRKv5fC0Bohby8Q5Wj4YAfCe9VazFwD+J+3AEswIs2
         r8RW3jhQqn1bC5jL+ri0lapsQVKUiu+5SdLYpI/ZNzyqpbFzyw0oza3KY14ehuqrrArO
         tkx34r5b/m62VLf15CWXnoC3DKbTwwy2ihnaY5ip1qMDpHY8G4Lp9J98IazHu2D9Kroi
         tcV3CBTljVjzFtVakYSOYirQr0Dze7fWh2Sw+YhcKwO03hK7I6NTY0SweIUIC7TOjfvQ
         8SdTnefy1SokH4TK68AEPWY94WW1fsREp4xf3eha2/K8Il/f0NFE32tWVukTzuVgYL4K
         hhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171588; x=1776776388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beymlgFr/YboZxFQwo976Na4fpAIT1nSSgpCEyfALzQ=;
        b=b4Xz32Krtm7I2I8S4NWcME8LuBtDFyKRgDRhTb1HUZcP13jhXM1/Bf0Q7+5VzmJWY8
         pT75Fcv/cpMrOv1AzXvSOELYD5+5LBkhQVtYiKngc7ZB8Ybv3pjq04Z7vf0eHC9sEG48
         BBoMTCIyNsyjenpRn+I6pQ3RKSzu9SVp3U1yp+/aP6/kqOENJphsA8ZaIJ3x9mS0thDk
         nyeEy5ZBirojBEsJrbFzAqOZCMs8NTEueU8tqD8nTIt5XcfgI3rYBh3A0IHnkKWfqq7z
         GnWV0PVzw+DhVcKIoho+O7ga62/lGnAViMU82vuNWai+sh83OLVJi/Ezqcevuwnii5Bi
         8A9A==
X-Gm-Message-State: AOJu0Yx25/ZOy1cVEefosGHOTgQAwnErhRgKhIhXCoNZwJz4SgqpRk0N
	1i95u3nY1/2SbsAMuAFzzAqca/SeLMYJ8B4k9DEaS+++27ltKgnJi8HVJeeVLQ==
X-Gm-Gg: AeBDiesRYL2wMVL/ZiwOBU/Qi0GykVky9dKQF7XkWcabWKJoHw6DSktM9jYCwLdPVht
	qRNh7W6fxfBhXNtIRjSKr74jiEdtwAlrJShBJRtQ2cipMIU7SowfYpF2iYmhiYC06VILh3X1S2E
	OdW+hhRM1l5et+8EewYHrqf70uZw8CXSg0wTNCoqg2Rrr/JeGsK6R8SZzglE8hqpKYLRSIphnAz
	OZ5xvnjO5EButOCirEH3YDiqT97TsHgGkH++kU8GM3gCpB1RYdqhD59TiDCPMx4KELK8mCI7+u3
	s47/eof+GRzZIUfGfj3iae4aPuTiYEf7gvBUQgP31s7KZ7FeMigQjew2bBRaKZs2df4ynZJPMIr
	agj8/CRRZdG/VYVIbTL0ZV+F4rLvmssQ5PNw57cCuvh25qdH//l9vixuwYxl6IQJhrUMHMMDKJf
	9f4B9fAGJdt6skgEejO4DmubmxskU=
X-Received: by 2002:a05:620a:6914:b0:8d9:e4d:47a8 with SMTP id af79cd13be357-8ddce0da543mr2409643485a.26.1776171587641;
        Tue, 14 Apr 2026 05:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9738cd3sm1113893685a.40.2026.04.14.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:59:46 -0700 (PDT)
Message-Id: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 12:59:41 +0000
Subject: [PATCH v12 0/4] checkout: 'autostash' for branch switching
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
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 ++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 ++---
 builtin/checkout.c              | 147 ++++++++++------------
 builtin/stash.c                 |  32 +++--
 sequencer.c                     |  81 ++++++++++---
 sequencer.h                     |   6 +
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  29 +++++
 t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 14 files changed, 491 insertions(+), 159 deletions(-)


base-commit: 9e8f4e9c04e3efa494e78b710e0c5f6cc77a0a5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v12
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v11:

 1:  9ab5431b47 = 1:  9ab5431b47 stash: add --label-ours, --label-theirs, --label-base for apply
 2:  e7f8328e3c ! 2:  e11a622bdf sequencer: allow create_autostash to run silently
     @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
       				      const char *path,
      -				      const char *refname)
      +				      const char *refname,
     ++				      const char *message,
      +				      bool silent)
       {
       	struct strbuf buf = STRBUF_INIT;
       	struct lock_file lock_file = LOCK_INIT;
     +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     + 		struct object_id oid;
     + 
     + 		strvec_pushl(&stash.args,
     +-			     "stash", "create", "autostash", NULL);
     ++			     "stash", "create",
     ++			     message ? message : "autostash", NULL);
     + 		stash.git_cmd = 1;
     + 		stash.no_stdin = 1;
     + 		strbuf_reset(&buf);
      @@ sequencer.c: static void create_autostash_internal(struct repository *r,
       					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
       		}
     @@ sequencer.c: static void create_autostash_internal(struct repository *r,
       void create_autostash(struct repository *r, const char *path)
       {
      -	create_autostash_internal(r, path, NULL);
     -+	create_autostash_internal(r, path, NULL, false);
     ++	create_autostash_internal(r, path, NULL, NULL, false);
       }
       
       void create_autostash_ref(struct repository *r, const char *refname)
       {
      -	create_autostash_internal(r, NULL, refname);
     -+	create_autostash_internal(r, NULL, refname, false);
     ++	create_autostash_internal(r, NULL, refname, NULL, false);
      +}
      +
     -+void create_autostash_ref_silent(struct repository *r, const char *refname)
     ++void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
     ++				 const char *message)
      +{
     -+	create_autostash_internal(r, NULL, refname, true);
     ++	create_autostash_internal(r, NULL, refname, message, true);
       }
       
       static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     @@ sequencer.h: void commit_post_rewrite(struct repository *r,
       
       void create_autostash(struct repository *r, const char *path);
       void create_autostash_ref(struct repository *r, const char *refname);
     -+void create_autostash_ref_silent(struct repository *r, const char *refname);
     ++void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
     ++				 const char *message);
       int save_autostash(const char *path);
       int save_autostash_ref(struct repository *r, const char *refname);
       int apply_autostash(const char *path);
 3:  3242fd3261 ! 3:  4593745e90 sequencer: teach autostash apply to take optional conflict marker labels
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## sequencer.c ##
     -@@ sequencer.c: void create_autostash_ref_silent(struct repository *r, const char *refname)
     - 	create_autostash_internal(r, NULL, refname, true);
     +@@ sequencer.c: void create_autostash_ref_with_msg_silent(struct repository *r, const char *refn
     + 	create_autostash_internal(r, NULL, refname, message, true);
       }
       
      -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
      +static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
      +				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
       	int ret = 0;
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       		strvec_push(&child.args, stash_oid);
       		ret = run_command(&child);
       	}
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     + 		strvec_push(&store.args, "stash");
     + 		strvec_push(&store.args, "store");
     + 		strvec_push(&store.args, "-m");
     +-		strvec_push(&store.args, "autostash");
     ++		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
     + 		strvec_push(&store.args, "-q");
     + 		strvec_push(&store.args, stash_oid);
     + 		if (run_command(&store))
      @@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
       	}
       	strbuf_trim(&stash_oid);
       
      -	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
      +	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
     -+				      NULL, NULL, NULL);
     ++				      NULL, NULL, NULL, NULL);
       
       	unlink(path);
       	strbuf_release(&stash_oid);
     @@ sequencer.c: int apply_autostash(const char *path)
       int apply_autostash_oid(const char *stash_oid)
       {
      -	return apply_save_autostash_oid(stash_oid, 1);
     -+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
     ++	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
       }
       
       static int apply_save_autostash_ref(struct repository *r, const char *refname,
      -				    int attempt_apply)
      +				    int attempt_apply,
      +				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
       {
       	struct object_id stash_oid;
       	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
       	oid_to_hex_r(stash_oid_hex, &stash_oid);
      -	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
      +	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     -+				       label_ours, label_theirs, label_base);
     ++				       label_ours, label_theirs, label_base,
     ++				       stash_msg);
       
       	refs_delete_ref(get_main_ref_store(r), "", refname,
       			&stash_oid, REF_NO_DEREF);
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
       int save_autostash_ref(struct repository *r, const char *refname)
       {
      -	return apply_save_autostash_ref(r, refname, 0);
     -+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
     ++	return apply_save_autostash_ref(r, refname, 0,
     ++					NULL, NULL, NULL, NULL);
       }
       
       int apply_autostash_ref(struct repository *r, const char *refname)
       {
      -	return apply_save_autostash_ref(r, refname, 1);
     -+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
     ++	return apply_save_autostash_ref(r, refname, 1,
     ++					NULL, NULL, NULL, NULL);
      +}
      +
      +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
      +				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
      +{
      +	return apply_save_autostash_ref(r, refname, 1,
     -+					label_ours, label_theirs, label_base);
     ++					label_ours, label_theirs, label_base,
     ++					stash_msg);
       }
       
       static int checkout_onto(struct repository *r, struct replay_opts *opts,
     @@ sequencer.h: int save_autostash_ref(struct repository *r, const char *refname);
       int apply_autostash_ref(struct repository *r, const char *refname);
      +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
      +				    const char *label_ours, const char *label_theirs,
     -+				    const char *label_base);
     ++				    const char *label_base,
     ++				    const char *stash_msg);
       
       #define SUMMARY_INITIAL_COMMIT   (1 << 0)
       #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 4:  97a5d87c81 ! 4:  911e520431 checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +			strbuf_addf(&autostash_msg,
      +				    "autostash while switching to '%s'",
      +				    new_branch_info->name);
     -+			create_autostash_ref_silent_with_msg(the_repository,
     -+							    "CHECKOUT_AUTOSTASH_HEAD",
     -+							    autostash_msg.buf);
     ++			create_autostash_ref_with_msg_silent(the_repository,
     ++						   "CHECKOUT_AUTOSTASH_HEAD",
     ++						   autostash_msg.buf);
      +			created_autostash = 1;
      +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		}
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       }
      
       ## sequencer.c ##
     -@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
     - static void create_autostash_internal(struct repository *r,
     - 				      const char *path,
     - 				      const char *refname,
     -+				      const char *message,
     - 				      bool silent)
     - {
     - 	struct strbuf buf = STRBUF_INIT;
     -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     - 		struct object_id oid;
     - 
     - 		strvec_pushl(&stash.args,
     --			     "stash", "create", "autostash", NULL);
     -+			     "stash", "create",
     -+			     message ? message : "autostash", NULL);
     - 		stash.git_cmd = 1;
     - 		stash.no_stdin = 1;
     - 		strbuf_reset(&buf);
     -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     - 
     - void create_autostash(struct repository *r, const char *path)
     - {
     --	create_autostash_internal(r, path, NULL, false);
     -+	create_autostash_internal(r, path, NULL, NULL, false);
     - }
     - 
     - void create_autostash_ref(struct repository *r, const char *refname)
     - {
     --	create_autostash_internal(r, NULL, refname, false);
     -+	create_autostash_internal(r, NULL, refname, NULL, false);
     - }
     - 
     - void create_autostash_ref_silent(struct repository *r, const char *refname)
     - {
     --	create_autostash_internal(r, NULL, refname, true);
     -+	create_autostash_internal(r, NULL, refname, NULL, true);
     -+}
     -+
     -+void create_autostash_ref_silent_with_msg(struct repository *r,
     -+					  const char *refname,
     -+					  const char *message)
     -+{
     -+	create_autostash_internal(r, NULL, refname, message, true);
     - }
     - 
     - static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     - 				    const char *label_ours, const char *label_theirs,
     --				    const char *label_base)
     -+				    const char *label_base,
     -+				    const char *stash_msg)
     - {
     - 	struct child_process child = CHILD_PROCESS_INIT;
     - 	int ret = 0;
      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     - 		strvec_push(&store.args, "stash");
     - 		strvec_push(&store.args, "store");
     - 		strvec_push(&store.args, "-m");
     --		strvec_push(&store.args, "autostash");
     -+		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
     - 		strvec_push(&store.args, "-q");
       		strvec_push(&store.args, stash_oid);
       		if (run_command(&store))
       			ret = error(_("cannot store %s"), stash_oid);
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       	}
       
       	return ret;
     -@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
     - 	strbuf_trim(&stash_oid);
     - 
     - 	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
     --				      NULL, NULL, NULL);
     -+				      NULL, NULL, NULL, NULL);
     - 
     - 	unlink(path);
     - 	strbuf_release(&stash_oid);
     -@@ sequencer.c: int apply_autostash(const char *path)
     - 
     - int apply_autostash_oid(const char *stash_oid)
     - {
     --	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
     -+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
     - }
     - 
     - static int apply_save_autostash_ref(struct repository *r, const char *refname,
     - 				    int attempt_apply,
     - 				    const char *label_ours, const char *label_theirs,
     --				    const char *label_base)
     -+				    const char *label_base,
     -+				    const char *stash_msg)
     - {
     - 	struct object_id stash_oid;
     - 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     - 
     - 	oid_to_hex_r(stash_oid_hex, &stash_oid);
     - 	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     --				       label_ours, label_theirs, label_base);
     -+				       label_ours, label_theirs, label_base,
     -+				       stash_msg);
     - 
     - 	refs_delete_ref(get_main_ref_store(r), "", refname,
     - 			&stash_oid, REF_NO_DEREF);
     -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     - 
     - int save_autostash_ref(struct repository *r, const char *refname)
     - {
     --	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
     -+	return apply_save_autostash_ref(r, refname, 0,
     -+					NULL, NULL, NULL, NULL);
     - }
     - 
     - int apply_autostash_ref(struct repository *r, const char *refname)
     - {
     --	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
     -+	return apply_save_autostash_ref(r, refname, 1,
     -+					NULL, NULL, NULL, NULL);
     - }
     - 
     - int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     - 				    const char *label_ours, const char *label_theirs,
     --				    const char *label_base)
     -+				    const char *label_base,
     -+				    const char *stash_msg)
     - {
     - 	return apply_save_autostash_ref(r, refname, 1,
     --					label_ours, label_theirs, label_base);
     -+					label_ours, label_theirs, label_base,
     -+					stash_msg);
     - }
     - 
     - static int checkout_onto(struct repository *r, struct replay_opts *opts,
     -
     - ## sequencer.h ##
     -@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     - void create_autostash(struct repository *r, const char *path);
     - void create_autostash_ref(struct repository *r, const char *refname);
     - void create_autostash_ref_silent(struct repository *r, const char *refname);
     -+void create_autostash_ref_silent_with_msg(struct repository *r,
     -+					  const char *refname,
     -+					  const char *message);
     - int save_autostash(const char *path);
     - int save_autostash_ref(struct repository *r, const char *refname);
     - int apply_autostash(const char *path);
     -@@ sequencer.h: int apply_autostash_oid(const char *stash_oid);
     - int apply_autostash_ref(struct repository *r, const char *refname);
     - int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     - 				    const char *label_ours, const char *label_theirs,
     --				    const char *label_base);
     -+				    const char *label_base,
     -+				    const char *stash_msg);
     - 
     - #define SUMMARY_INITIAL_COMMIT   (1 << 0)
     - #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
      
       ## t/t3420-rebase-autostash.sh ##
      @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {

-- 
gitgitgadget

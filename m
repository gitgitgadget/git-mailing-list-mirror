Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291F4A5EA5
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288677; cv=none; b=RaaeogmSstMqgqMKFY0IjYXkfHEjrcmkEuTaED3lX3Vaml4WCJlwBIOCh6dHKg4aFTEl3qbmrjOpQt1Eu8fqC6ij1Jb7M35OA24Bd3htqF/5HDI5BFtCyEYkMheCTebGlSIix29Bdu87PEU4v3cQ9tKcMLyMXPFYUHgYwuUSKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288677; c=relaxed/simple;
	bh=LS1q6e4Vt4x297ZvIl3sL7goB2fni7UnZJG8b0A1mew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unXagfyqPZ6CYxZq7GW5FcdDDdW4g0epdKkBaXJCCAVL+KFZQuLL01WlOB/GEyoBURthDorAGTkaL3EK4LPFeFPc1z2k3RUwPc+OKysICzxcpi+lkbp4Rjdi6tnmRNLtiqa5VP07qrny4Owl9gLXc2fhAQdxnvdHr5GSlkiuLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oV//58og; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV//58og"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3d66515so240201a91.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788288674; x=1788893474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K617IIZDRvaoo1q6wYUe7bvKuOWAGUANIWVhutzbJsg=;
        b=oV//58ogBE/v0VvUX4huTm2m1HjkM/CYe4YRlc4Ch6fqqpFLaoFntFHhOeRf6mv0Lz
         bAO6f1gSH9fIyXjMKoZ98ld8B0CIPdiocNYLxaoutEKrK+EBZybHMnPWo7ipyTZXYJIp
         3MbukyvLVASBtkASicGk2bAw/yRI5ViaclW9k5WGy0CgtNFqkRC/tZt3JHol9QdrLpEo
         WXq6OuEofZ+IbAVdfciLFFXcUc9YihihNhVOJubOhgO8q1d7E8ESajeXdbOeP11s//Nb
         D8NlV5Ei5Aduoodm03YndApiZHWDxsLnrlvyiiM6sPH7gO5/Slwp9bSCeYtUnVhHyJS+
         Vj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288674; x=1788893474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K617IIZDRvaoo1q6wYUe7bvKuOWAGUANIWVhutzbJsg=;
        b=ERo30vOIeVvRjEYRK91L/H31ee4OjZ4GSIA8P4er6rSk7OWKOZracT0WroysBAVuan
         eJVv73MQBLwL4T8RlnguIC4r2zIqHauGgei3jre6AGz4+k4EIspp0D/rjPl5EBtLJJZN
         /FyVnxQ5t9ZqixEpYkwYZprshzrtlVQ72NxEJr8HGaY9VuL0kI2/t3+qRivYYkQpK2mn
         eAEIjVtuzpHgxlqjnt3IXsRcm7UQSsPFiCM+f3JcFMNXmT/BgJ3f0M92fmoS8y0ZKzpo
         92UR1Syo6FcxJPThQsLcw3uLEwFBq6iXQpTMzrD4dBwipf9Up+DNaTbWDsZsysCntTF/
         h8RQ==
X-Gm-Message-State: AFuF++lbN/LyTnbJK0OV5GxB5sIxFc6sYmpgj/lAE4hyHarvnagt8skb
	W4auPcUbTqckXI+VfN3O3cQt8MIfSowjS2c/vMh1M+XlD/JgUXP+APLPqUr+ww==
X-Gm-Gg: AYBFou0D1ckD0GXcQNE6x2IAfwc3Dg2avz+AfZQsgUyZwy49PfFMEalGw0LDvGLPo3/
	Rz9n4WRnK8BVRKr6TagW85nKBT29v/k1+HRfhGNUDEHVznPwtfoakOoVVfCRNRXV82Us3ro8Wk9
	J0g6+A5NPiT0MtMvlGi9/XV5cPr4NbSc0u1kI9WYrowEUdQrS6UoaxEK8A/OJcXyRdK2yTVRTKh
	YYY1oqgItRaMLbe6Rq0tATHH/JyXTCClZIkiyCKYkogfURi2Xtq/vzCexmRYvd/D6K5v9cvxCpY
	lWcwekanYPjQ2ToqQckjlLy4C8TiMBO8skPLTaEo886xEPnf/cFSxAnCwuZrKBRZswDeH+gAIDy
	jvhM2kWBJPaBeAlqQQ5l31iaEPcPmho0CiRVUOOBU4x6swSMqr5VM/Ey4mEHmM6TRC6vYz1vj9O
	KQRoiFmrkJ9Wrd1BFTgL4DqAo6n35DzipOJhQN2mvIf9I3epGsm1YxuecgFBkGy3rUYZ0gWseTy
	Jrr1y1EKGXfbxp5/Gq7mWJt1izxSM9GHiy8t/rQShPD8SSQ5XmYABmAFJVDqvwOXTsfhlKabn9J
	bJIMoGgIEsIiTCmxS2/R35WOMw+QwfsegLQf2CkgVSGA
X-Received: by 2002:a17:90b:4fca:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39ae83d787dmr167862a91.14.1788288673916;
        Tue, 01 Sep 2026 11:51:13 -0700 (PDT)
Received: from localhost ([2409:40e3:179:3f2e:d589:805a:9631:7949])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfe6b6sm954817a91.1.2026.09.01.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:51:13 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	toon@iotcl.com,
	ps@pks.im,
	karthik.188@gmail.com,
	justin@parity.io,
	peff@peff.net,
	phillip.wood123@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/1] rev-list: add --missing-only option to filter output
Date: Wed,  2 Sep 2026 00:21:00 +0530
Message-ID: <20260901185100.33948-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901185100.33948-1-siddharthasthana31@gmail.com>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260901185100.33948-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working with partial clones, callers often need only the missing
object IDs. Today that means post-processing --missing=print to drop
present objects and strip the leading '?':

  git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'

Add --missing-only. Use it with --missing=print or --missing=print-info
to print only missing objects. --missing= still picks the format;
--missing-only only filters. The leading '?' is omitted. With
print-info, path= and type= are still shown.

Require --missing=print or --missing=print-info. Reject --count and
--disk-usage.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
Changes from v1 include:
1. Replace --missing=print-only mode with a separate --missing-only flag
   (Phillip, Patrick, Stolee).
2. Require --missing=print or --missing=print-info.
3. Die when combined with --count or --disk-usage (Stolee).
4. Keep enum comment alignment (no spacing churn).
5. Keep print-info path=/type=; only drop '?'.
6. Simpler tests with test_cmp (Phillip).

 Documentation/rev-list-options.adoc | 13 ++++++++
 builtin/rev-list.c                  | 42 ++++++++++++++++++++++---
 t/t6022-rev-list-missing.sh         | 49 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index fd831f0ec6..bd9f345690 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1083,6 +1083,19 @@ If some tips passed to the traversal are missing, they will be
 considered as missing too, and the traversal will ignore them. In case
 we cannot get their Object ID though, an error will be raised.
 
+`--missing-only`::
+	When used together with `--missing=print` or `--missing=print-info`,
+	suppress all output for present objects and print only the missing
+	ones.  The selected `--missing=` format is preserved (so
+	`--missing=print-info` still emits `path=` / `type=` fields), but the
+	leading ``?'' prefix used by the non-`-z` forms is omitted.  This is
+	useful for scripting, as a simpler and faster alternative to
+	post-processing the output of `--missing=print`.
++
+This option is incompatible with `--count` and `--disk-usage`.
+It is an error to use `--missing-only` without `--missing=print` or
+`--missing=print-info`.
+
 `--exclude-promisor-objects`::
 	(For internal use only.)  Prefilter object traversal at
 	promisor boundary.  This is used with partial clone.  This is
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 02818b81c6..09c6d27220 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -111,6 +111,13 @@ enum missing_action {
 	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
+static int arg_missing_only;
+
+static inline int should_collect_missing(void)
+{
+	return arg_missing_action == MA_PRINT ||
+	       arg_missing_action == MA_PRINT_INFO;
+}
 
 /* display only the oid of each object encountered */
 static int arg_show_object_names = 1;
@@ -156,7 +163,14 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (line_term)
+	/*
+	 * --missing-only filters present objects out of the walk output.
+	 * It still uses the selected --missing= format for missing ones,
+	 * except the human "?" prefix is omitted (script-friendly OIDs).
+	 */
+	if (arg_missing_only && line_term)
+		printf("%s", oid_to_hex(&entry->entry.oid));
+	else if (line_term)
 		printf("?%s", oid_to_hex(&entry->entry.oid));
 	else
 		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
@@ -246,6 +260,11 @@ static void show_commit(struct commit *commit, void *data)
 		return;
 	}
 
+	if (arg_missing_only) {
+		finish_commit(commit);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
@@ -384,6 +403,8 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	if (finish_object(obj, name, cb_data))
 		return;
 	display_progress(progress, ++progress_counter);
+	if (arg_missing_only)
+		return;
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(obj);
 	if (info->flags & REV_LIST_QUIET)
@@ -749,12 +770,17 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(arg);
+		} else if (!strcmp(arg, "--missing-only")) {
+			arg_missing_only = 1;
 		} else if (!strcmp(arg, "-z")) {
 			line_term = '\0';
 			info_term = '\0';
 		}
 	}
 
+	if (arg_missing_only && !should_collect_missing())
+		die(_("--missing-only requires --missing=print or --missing=print-info"));
+
 	die_for_incompatible_opt2(revs.exclude_promisor_objects,
 				  "--exclude_promisor_objects",
 				  arg_missing_action, "--missing");
@@ -864,6 +890,9 @@ int cmd_rev_list(int argc,
 			continue;
 		}
 
+		if (!strcmp(arg, "--missing-only"))
+			continue;
+
 		usage(rev_list_usage);
 
 	}
@@ -910,6 +939,11 @@ int cmd_rev_list(int argc,
 	    (revs.left_right || revs.cherry_mark))
 		die(_("marked counting and '%s' cannot be used together"), "--objects");
 
+	die_for_incompatible_opt2(arg_missing_only, "--missing-only",
+				  revs.count, "--count");
+	die_for_incompatible_opt2(arg_missing_only, "--missing-only",
+				  show_disk_usage, "--disk-usage");
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
@@ -967,8 +1001,7 @@ int cmd_rev_list(int argc,
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT ||
-	    arg_missing_action == MA_PRINT_INFO) {
+	if (should_collect_missing()) {
 		struct oidset_iter iter;
 		struct object_id *oid;
 
@@ -994,8 +1027,7 @@ int cmd_rev_list(int argc,
 			printf("~%s\n", oid_to_hex(oid));
 		oidset_clear(&omitted_objects);
 	}
-	if (arg_missing_action == MA_PRINT ||
-	    arg_missing_action == MA_PRINT_INFO) {
+	if (should_collect_missing()) {
 		struct missing_objects_map_entry *entry;
 		struct oidmap_iter iter;
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 1e472a45af..1bd2c3bc4f 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,6 +198,55 @@ do
 	'
 done
 
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	test_expect_success "rev-list --missing-only with missing $obj" '
+		oid="$(git rev-parse $obj)" &&
+		path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		git rev-list --missing=print --missing-only --objects \
+			--no-object-names HEAD >actual &&
+
+		echo $oid >expect &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
+	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
+	test_grep "requires --missing=print" err
+'
+
+test_expect_success "--missing-only is incompatible with --count" '
+	test_must_fail git rev-list --missing=print --missing-only \
+		--count --objects HEAD 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success "--missing-only is incompatible with --disk-usage" '
+	test_must_fail git rev-list --missing=print --missing-only \
+		--disk-usage --objects HEAD 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success "--missing-only works with --missing=print-info" '
+	oid="$(git rev-parse HEAD:1.t)" &&
+	path=".git/objects/$(test_oid_to_path $oid)" &&
+
+	mv "$path" "$path.hidden" &&
+	test_when_finished "mv $path.hidden $path" &&
+
+	git rev-list --missing=print-info --missing-only --objects \
+		--no-object-names HEAD >actual &&
+
+	# Filter keeps print-info fields; only the "?" prefix is dropped.
+	echo "$oid path=1.t type=blob" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success "-z nul-delimited --missing" '
 	test_when_finished rm -rf repo &&
 

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
2.54.0


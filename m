Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEA377A80
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468383; cv=none; b=b9Q53mk5EpjwnLz59dhWQ7jXzePHXGQ6wLrmOqWVAZo5ADIKVXEltLrFcClFlE9nm5m1C0QhUqC1pvlTAY8/wYgI0bHfYJtqn1x9M/7A41pDxz6yOsP8ffwkEvmZ5cnRTZ5Ct5s0WXJvBkDhAtYllan6qiYc/Qp8DyFrOLDeWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468383; c=relaxed/simple;
	bh=p9nJwMsLeaiKT6W4Z8j02bJbvwZTGVBXWfzAisG57fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGrX+g4hbedXf7PWuplCuxtgtwOngL9nrUEkLq4e/ug9/3YYRVikKgQMtt5L19UvfnxiBCEjnMdQnRAx2Z+9ph/y/00ZufGfuTMzVrta3Bbr3rVuXr9L6ON7DH42JYvBnWOA7TlOtz4s1QhLzQ+l5RgKyyAYnceB+aDDPsMZYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjDl/DRg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjDl/DRg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso2424395ad.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788468366; x=1789073166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Vk0xvvJ7z+L+LYy7JA5Zs6TSZEyElld26ASY5M1eak=;
        b=XjDl/DRgCy9RceXD/NeuF3ckQyk0TmbGHpE1Obu2YXpX+gK0PN+PUKrpaU/ZC2jZAy
         PhXdNHObd07vwzwdr1lYNaG3kaRpLd6n50EwVNUkmazYzdRDt5xc8r/jziyg7ZCVja80
         iBGNdAsIxgW1gOxlPUNhrutNhSjDRh8k39r7MZ+8SRNLVI+iS8fxxMw8cf3YI+AHxkCv
         LMNQhDp8PO3l4DDYAs6PHS9f4ypo9b+s9cmG7kUnCpY55MmVQvKL93S+bN7YHL8OulqM
         ryKLEiHxKlrQsK8SugtyQoNU0yZ0km4gvU88dSTfDc7VP2HYmPGDN73jySubdFAsz5RQ
         4dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788468366; x=1789073166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Vk0xvvJ7z+L+LYy7JA5Zs6TSZEyElld26ASY5M1eak=;
        b=nV3cP90e0dvbleDI9BGqqBGcf/vKMhSRj/UL/FiEoNntpNvAjH2Z5c2nJ/+F9U6scx
         gztl59vqlcDRGKJBVGLoMJppT8kxctE9wBJwoAKb3+Te960VhZ3x1jIGtQAPv/QQSPJw
         GNd6op5e5OFi0i4UD/XKh22yg3o9aJQxGPuhSHP2CHmIIEm0zlR+xflUpaEQL1anVmhB
         +SL5zz+yLOIFDAg88/C710v5AdSI5tBTEAYyf9tJBMKhTK7ORASOkZOmPzk2n41jLylA
         bOAZqiFIbcwuhqxW9yncKn0dvLKvQlVUOwxBRw0P75nUBP5Xeml0XN1M00VktUzCyrUl
         YaZg==
X-Gm-Message-State: AFuF++lAXfckcSqO8oQcSgfAJ8R08ZeNEJwMy3QJfEAWtpHm8ENQODJ/
	1HyKX81ldh3a1Ba1L5V9crEfV693J74phMtx5xZ7K30p4MLWrLDTsjBgmhwf9g==
X-Gm-Gg: AYBFou0iK/0vy3hf7mG7MT4P7R3Rja0ZzHxiA4CxoBRRcS94aZhn2I2NlbLuomxy1Ln
	y4stj1SDjHCrAlSQbrF43GoU48j/97C9Ts99LNFDyE9TmhFlDjXDiIUcBUXtQ/enh2/5Q7sfi8v
	gRrbibDhXGvNldmz6srSrZzrFSDXHRbW4hybMsY6IUjXrsCNyHq/aNUxRgQNIHSx6E/eOt6aYMc
	HClxhBd9cIbQt5ixeIFW74YzbXojbGAOiBTBIeLA2TsNfF90x16YCeNdqKQdAI+cjlJhOA/ZBYZ
	k1ri+mIMZQCT75GhlkhB8+RAnMoId6drZzULm0aU+VM/7B+0PU+3H0VZXrUk/vUEOTPPms4Uv3/
	It7U0GFsamUXfVu4vBZTAMCqjYPnCI9lp5shHkPt+5aDHWL8vBGvIdsnx26HfpfG2HRiqPc3ebv
	yeoMHuE7ssy+dqk4oC1KQXN1dImMGbksAMkEYTWJ2513atg/qWjCvm5Y8ON3F+eij9RB9Y4tYQK
	9HGU1SedVN67s26N6+7xP42EBATh2vFLoFvgrbvtlXIRQUsD0/bOsQ15z5tdbEHnkt0UKgYz51l
	lIEgojJzu1APEwijUEMq3XAi
X-Received: by 2002:a17:903:4b04:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2db124b1ae2mr24291415ad.6.1788468365882;
        Thu, 03 Sep 2026 13:46:05 -0700 (PDT)
Received: from localhost ([125.17.164.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14959961sm937345ad.19.2026.09.03.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:46:05 -0700 (PDT)
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
Subject: [PATCH v3 1/1] rev-list: add --missing-only option to filter output
Date: Fri,  4 Sep 2026 02:15:51 +0530
Message-ID: <20260903204551.65592-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903204551.65592-1-siddharthasthana31@gmail.com>
References: <20260901185100.33948-1-siddharthasthana31@gmail.com>
 <20260903204551.65592-1-siddharthasthana31@gmail.com>
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

This is for a one-shot walk, not a fetch loop. Callers already have
--missing=print and strip the leading '?'. Gitaly does that when packing
a quarantine: '?' lines are objects that must already exist in the main
repo. Tests do the same (is this blob still missing). --missing-only is
just that list without the prefix.

Add --missing-only. Use it with --missing=print or --missing=print-info
to print only missing objects. --missing= still picks the format;
--missing-only only filters. The leading '?' is omitted. With
print-info, path= and type= are still shown.

Require --missing=print or --missing=print-info. Reject --count and
--disk-usage.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
Changes from v2:
- Strengthen the motivation in the log message (Junio).
  This is a one-shot walk (Gitaly quarantine deps, tests),
  not a multi-round fetch loop.

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
 

Range-diff:
1:  3c89e6bc38 ! 1:  c751ff41a4 rev-list: add --missing-only option to filter output
    @@ Commit message
     
           git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
     
    +    This is for a one-shot walk, not a fetch loop. Callers already have
    +    --missing=print and strip the leading '?'. Gitaly does that when packing
    +    a quarantine: '?' lines are objects that must already exist in the main
    +    repo. Tests do the same (is this blob still missing). --missing-only is
    +    just that list without the prefix.
    +
         Add --missing-only. Use it with --missing=print or --missing=print-info
         to print only missing objects. --missing= still picks the format;
         --missing-only only filters. The leading '?' is omitted. With

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
2.54.0


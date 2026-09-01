Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BF4A43F2
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288670; cv=none; b=OtXRxv1quLuq+a0j0U7hALXnscKKm+w0zAKF+aD/W/D7vlWafOBIytc8RgHQfGgJEfj0CvmuY//0MdAcLS3Sj/LkbaLGkb32g1NwHk7ZXwDAM5yloCYJya8IjPx8SCLzr95uzE4bDgwYQekIjCbucoNCr4Z3jYxrQs6hBPFJstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288670; c=relaxed/simple;
	bh=9+iL6R2Zb8SElqXu1/q6e0PgxteSakC7grrmMRJs14c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4TOOlm7Idd3rmsr6N4hdt4DQ99UOGJIssKtAGkzz0Zsjay/ASYCgk4IEb8YTNd6gDuogA/g67jyOYL9/NQ6HF4B+5bOxqVkHUAYuQ8ObRm+F4/fL0lucw7xnP/x7OP+Jg9yFDTXdWDL5My8UAsiY3Ut1VI5W7RkKFdekDcL32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7/JWFE+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7/JWFE+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d53197d8b5so1149525ad.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788288666; x=1788893466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNIR6jF9+R4l4IkX5JEDWkeIKqPEcpHFSEzwbIznXAg=;
        b=E7/JWFE+gaTR+8VarLPrA3B2mXlzAc0rnztMg730AbdPcg3+YhPK+peY4sQ9Y85Ns2
         TBLqHnmsE4hema5YFfNzHn60xrbmx40w8azT3Y/VqeOtoY5TzcyryYLy+fRN35ihhM4/
         X7mDQ+peoSqR4BcmxnyUgiqIKFYWVaNU5tHpbmtvxNY4zfbZV9T5GRCVzw5k76Wsv8+T
         x5OpuFyW9/GPQqwkaO5cje/XF5AHUiN0OMxFwdH4S8hiWvpBnGgaUJ7iCFijennble1W
         nkSQqdgK0QUEO+J+QO+JTguwiCCzDQcmS8OO3PCs4KhUGihnWwV3bTF95zC6iHVhSYqp
         wNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288666; x=1788893466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNIR6jF9+R4l4IkX5JEDWkeIKqPEcpHFSEzwbIznXAg=;
        b=G5kCtynhLLO3VY2SDYgH7knTlwMgJ5F7mIFoFANm5rBF36IdHTHp5xU+cE2HCk/ll8
         lTM++0ijCRk6XuEEUF1F1Ax8J51oa5tdItBPiS8nKTCGh99xLfyh9HRCQ8azg8baFVHZ
         p4OrnzjMCwitHnQ2lnRt7nU+63w/gzGdIKI3O4Kp2WE2SiJY1tVKxGpf8XVELa6drmPo
         XJP8T5hZGKdqTn/07fBBoXBRwi0pRiZuLURDaWBkdWQJuBifK0JRsVVM6JP8DvSqlD2y
         VKLmBr++UO3HyElpgcOrr+NzGfAteNxsyfv75YgUBQV+egi7/Bm0FXNmvf68f0M41Anm
         sGgA==
X-Gm-Message-State: AFuF++mhC837oyYnlriYDbGDwH26f2L6xrlSaHGSdHMLIDM1Wa8j20/3
	Hw6pBtb7WOHmJJcyhX+MYZJFSakRucjmFN88X56z8WegWx0OzH5fwl/ZeMVr43Kp
X-Gm-Gg: AYBFou2YFRBK3tEx2K0chbi5D7L9Odg+4UntjKtj8ATyQ+T0OCDYL4fLr9lVAqde53J
	FA+G1xUS+6o9QQj3E0JGga1fV/QK+b2qh4F+UPUZ6Jgl75gm75CD+Whh1E36mxQ14qlGZLv0Qut
	97l7eDg5TaHw8TfNH+O6pMA6OED5N7yeVo7Llqz7ec8CAyu3gz90PLNSZm9rmMEq6QlQSGl5Dvr
	dQCuPO8CrPCVnzc7rIu2+Z+7K3KuWlg1r+KqoNVzyoHN8Xdn/pDTQ55U9f8e6nMKhCyS4XerWW4
	npD2KeLGG5yFH7AgMXcVv9N9SUlhKUjHJS2cD7BYAM78Hc1DFTrh5yAfT6eadaK8hWAxleDKV31
	UgDWdgrIhQ82/jMU9nzCpWwLFeIaLq7EuFJ4/4VzchUlYcaOxJX8xT1Ysm2hYeut++mQWaL+eMD
	cKbWYobg50Nz1zfFoAxGSJW6cIucC2+8sBtUqcKuZhiwXDJezswbeGpQDvmH9NA2aIITWFUuPEe
	NKDA3Ba0BGd5BMjUByPer7lXUyntMs7NJHJQ8H9H1zCzfAJ9baEuZmnjaYJnSST+4FtwuGXs33R
	K5nbzFWfWWJV76LrY1stdVeXMe6PmwrR+Q==
X-Received: by 2002:a17:902:d54c:b0:2d7:f0:896b with SMTP id d9443c01a7336-2d94a8f448amr150641985ad.13.1788288666065;
        Tue, 01 Sep 2026 11:51:06 -0700 (PDT)
Received: from localhost ([2409:40e3:179:3f2e:d589:805a:9631:7949])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd6348f0sm2218665ad.23.2026.09.01.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:51:05 -0700 (PDT)
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
Subject: [PATCH v2 0/1] rev-list: add --missing-only option to filter output
Date: Wed,  2 Sep 2026 00:20:59 +0530
Message-ID: <20260901185100.33948-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260419084840.33986-1-siddharthasthana31@gmail.com>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

At GitLab, Gitaly uses rev-list --missing=print on partial clones to
find missing objects. The output mixes present and missing objects and
prefixes missing ones with '?', so we post-process it. --missing-only
avoids that.

v1 added --missing=print-only as a --missing= mode. Review preferred a
separate filter flag, so v2 adds --missing-only next to --missing=print
or --missing=print-info.

Based on 1630431f32 (The 21st batch, 2026-08-31).

Changes from v1 include:
1. Separate --missing-only flag instead of print-only mode
   (Phillip, Patrick, Stolee).
2. Require --missing=print or --missing=print-info.
3. Die on --count / --disk-usage (Stolee).
4. No enum comment spacing churn.
5. print-info still prints path=/type=; only '?' is dropped.
6. test_cmp-based tests (Phillip).
7. Link to v1:
   https://lore.kernel.org/git/20260419084840.33986-1-siddharthasthana31@gmail.com/

Thanks,
Siddharth

---
Siddharth Asthana (1):
  rev-list: add --missing-only option to filter output

 Documentation/rev-list-options.adoc | 13 ++++++++
 builtin/rev-list.c                  | 42 ++++++++++++++++++++++---
 t/t6022-rev-list-missing.sh         | 49 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 5 deletions(-)

Range-diff versus v1:

1:  7e8f1ad997 ! 1:  3c89e6bc38 rev-list: add --missing=print-only mode
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
    -    rev-list: add --missing=print-only mode
    +    rev-list: add --missing-only option to filter output
     
    -    When working with partial clones, it's common to want just the list of
    -    missing objects. The current --missing=print mode does this but mixes
    -    present and missing objects together, with missing ones prefixed by '?'.
    -    Getting only the missing OIDs requires an extra pipe:
    +    When working with partial clones, callers often need only the missing
    +    object IDs. Today that means post-processing --missing=print to drop
    +    present objects and strip the leading '?':
     
           git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
     
    -    Add --missing=print-only which outputs only the missing object OIDs, one
    -    per line, without any prefix. This makes the above one-liner unnecessary
    -    and the output directly usable by downstream tools.
    +    Add --missing-only. Use it with --missing=print or --missing=print-info
    +    to print only missing objects. --missing= still picks the format;
    +    --missing-only only filters. The leading '?' is omitted. With
    +    print-info, path= and type= are still shown.
    +
    +    Require --missing=print or --missing=print-info. Reject --count and
    +    --disk-usage.
     
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/rev-list-options.adoc ##
    -@@ Documentation/rev-list-options.adoc: Unexpected missing objects will raise an error.
    - The form `--missing=print` is like `allow-any`, but will also print a
    - list of the missing objects.  Object IDs are prefixed with a ``?'' character.
    - +
    -+The form `--missing=print-only` is like `print`, but will print ONLY the
    -+missing objects (not the present ones), and without the ``?'' prefix.  This
    -+is useful for scripting, as a simpler alternative to
    -+`--missing=print | sed -n 's/^?//p'`.
    +@@ Documentation/rev-list-options.adoc: If some tips passed to the traversal are missing, they will be
    + considered as missing too, and the traversal will ignore them. In case
    + we cannot get their Object ID though, an error will be raised.
    + 
    ++`--missing-only`::
    ++	When used together with `--missing=print` or `--missing=print-info`,
    ++	suppress all output for present objects and print only the missing
    ++	ones.  The selected `--missing=` format is preserved (so
    ++	`--missing=print-info` still emits `path=` / `type=` fields), but the
    ++	leading ``?'' prefix used by the non-`-z` forms is omitted.  This is
    ++	useful for scripting, as a simpler and faster alternative to
    ++	post-processing the output of `--missing=print`.
     ++
    - The form `--missing=print-info` is like `print`, but will also print additional
    - information about the missing object inferred from its containing object. The
    - information is all printed on the same line with the missing object ID in the
    ++This option is incompatible with `--count` and `--disk-usage`.
    ++It is an error to use `--missing-only` without `--missing=print` or
    ++`--missing=print-info`.
    ++
    + `--exclude-promisor-objects`::
    + 	(For internal use only.)  Prefilter object traversal at
    + 	promisor boundary.  This is used with partial clone.  This is
     
      ## builtin/rev-list.c ##
    -@@ builtin/rev-list.c: static void missing_objects_map_entry_free(void *e)
    - 
    - static struct oidmap missing_objects;
    - enum missing_action {
    --	MA_ERROR = 0,    /* fail if any missing objects are encountered */
    --	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
    --	MA_PRINT,        /* print ALL missing objects in special section */
    --	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
    -+	MA_ERROR = 0, /* fail if any missing objects are encountered */
    -+	MA_ALLOW_ANY, /* silently allow ALL missing objects */
    -+	MA_PRINT, /* print ALL missing objects in special section */
    -+	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
    -+	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
    +@@ builtin/rev-list.c: enum missing_action {
      	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
      };
      static enum missing_action arg_missing_action;
    - 
    -+static inline int missing_action_prints(void)
    ++static int arg_missing_only;
    ++
    ++static inline int should_collect_missing(void)
     +{
     +	return arg_missing_action == MA_PRINT ||
    -+	       arg_missing_action == MA_PRINT_INFO ||
    -+	       arg_missing_action == MA_PRINT_ONLY;
    ++	       arg_missing_action == MA_PRINT_INFO;
     +}
    -+
    + 
      /* display only the oid of each object encountered */
      static int arg_show_object_names = 1;
    - 
     @@ builtin/rev-list.c: static void print_missing_object(struct missing_objects_map_entry *entry,
      {
      	struct strbuf sb = STRBUF_INIT;
      
     -	if (line_term)
    -+	if (arg_missing_action == MA_PRINT_ONLY) {
    ++	/*
    ++	 * --missing-only filters present objects out of the walk output.
    ++	 * It still uses the selected --missing= format for missing ones,
    ++	 * except the human "?" prefix is omitted (script-friendly OIDs).
    ++	 */
    ++	if (arg_missing_only && line_term)
     +		printf("%s", oid_to_hex(&entry->entry.oid));
    -+		putchar(line_term);
    -+		return;
    -+	} else if (line_term) {
    ++	else if (line_term)
      		printf("?%s", oid_to_hex(&entry->entry.oid));
    --	else
    -+	} else {
    + 	else
      		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
    - 		       info_term);
    -+	}
    - 
    - 	if (!print_missing_info) {
    - 		putchar(line_term);
    -@@ builtin/rev-list.c: static inline void finish_object__ma(struct object *obj, const char *name)
    - 
    - 	case MA_PRINT:
    - 	case MA_PRINT_INFO:
    -+	case MA_PRINT_ONLY:
    - 		add_missing_object_entry(&obj->oid, name, obj->type);
    - 		return;
    - 
     @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
      		return;
      	}
      
    -+	if (arg_missing_action == MA_PRINT_ONLY) {
    ++	if (arg_missing_only) {
     +		finish_commit(commit);
     +		return;
     +	}
    @@ builtin/rev-list.c: static void show_object(struct object *obj, const char *name
      	if (finish_object(obj, name, cb_data))
      		return;
      	display_progress(progress, ++progress_counter);
    -+	if (arg_missing_action == MA_PRINT_ONLY)
    ++	if (arg_missing_only)
     +		return;
      	if (show_disk_usage)
      		total_disk_usage += get_object_disk_usage(obj);
      	if (info->flags & REV_LIST_QUIET)
    -@@ builtin/rev-list.c: static inline int parse_missing_action_value(const char *value)
    - 		return 1;
    +@@ builtin/rev-list.c: int cmd_rev_list(int argc,
    + 			revs.exclude_promisor_objects = 1;
    + 		} else if (skip_prefix(arg, "--missing=", &arg)) {
    + 			parse_missing_action_value(arg);
    ++		} else if (!strcmp(arg, "--missing-only")) {
    ++			arg_missing_only = 1;
    + 		} else if (!strcmp(arg, "-z")) {
    + 			line_term = '\0';
    + 			info_term = '\0';
    + 		}
      	}
      
    -+	if (!strcmp(value, "print-only")) {
    -+		arg_missing_action = MA_PRINT_ONLY;
    -+		fetch_if_missing = 0;
    -+		return 1;
    -+	}
    ++	if (arg_missing_only && !should_collect_missing())
    ++		die(_("--missing-only requires --missing=print or --missing=print-info"));
    ++
    + 	die_for_incompatible_opt2(revs.exclude_promisor_objects,
    + 				  "--exclude_promisor_objects",
    + 				  arg_missing_action, "--missing");
    +@@ builtin/rev-list.c: int cmd_rev_list(int argc,
    + 			continue;
    + 		}
    + 
    ++		if (!strcmp(arg, "--missing-only"))
    ++			continue;
    ++
    + 		usage(rev_list_usage);
    + 
    + 	}
    +@@ builtin/rev-list.c: int cmd_rev_list(int argc,
    + 	    (revs.left_right || revs.cherry_mark))
    + 		die(_("marked counting and '%s' cannot be used together"), "--objects");
    + 
    ++	die_for_incompatible_opt2(arg_missing_only, "--missing-only",
    ++				  revs.count, "--count");
    ++	die_for_incompatible_opt2(arg_missing_only, "--missing-only",
    ++				  show_disk_usage, "--disk-usage");
     +
    - 	if (!strcmp(value, "allow-promisor")) {
    - 		arg_missing_action = MA_ALLOW_PROMISOR;
    - 		fetch_if_missing = 0;
    + 	save_commit_buffer = (revs.verbose_header ||
    + 			      revs.grep_filter.pattern_list ||
    + 			      revs.grep_filter.header_list);
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      
      	if (arg_print_omitted)
      		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
     -	if (arg_missing_action == MA_PRINT ||
     -	    arg_missing_action == MA_PRINT_INFO) {
    -+	if (missing_action_prints()) {
    ++	if (should_collect_missing()) {
      		struct oidset_iter iter;
      		struct object_id *oid;
      
    @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      	}
     -	if (arg_missing_action == MA_PRINT ||
     -	    arg_missing_action == MA_PRINT_INFO) {
    -+	if (missing_action_prints()) {
    ++	if (should_collect_missing()) {
      		struct missing_objects_map_entry *entry;
      		struct oidmap_iter iter;
      
    -@@ builtin/rev-list.c: int cmd_rev_list(int argc,
    - 
    - 	stop_progress(&progress);
    - 
    --	if (revs.count) {
    -+	if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
    - 		if (revs.left_right && revs.cherry_mark)
    - 			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
    - 		else if (revs.left_right)
    -@@ builtin/rev-list.c: int cmd_rev_list(int argc,
    - 			printf("%d\n", revs.count_left + revs.count_right);
    - 	}
    - 
    --	if (show_disk_usage)
    -+	if (show_disk_usage && arg_missing_action != MA_PRINT_ONLY)
    - 		print_disk_usage(total_disk_usage);
    - 
    - cleanup:
     
      ## t/t6022-rev-list-missing.sh ##
     @@ t/t6022-rev-list-missing.sh: do
    @@ t/t6022-rev-list-missing.sh: do
      
     +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
     +do
    -+	test_expect_success "rev-list --missing=print-only with missing $obj" '
    ++	test_expect_success "rev-list --missing-only with missing $obj" '
     +		oid="$(git rev-parse $obj)" &&
     +		path=".git/objects/$(test_oid_to_path $oid)" &&
     +
    -+		# Capture present OIDs before hiding anything.
    -+		git rev-list --objects --no-object-names HEAD ^$obj >present.raw &&
    -+
     +		mv "$path" "$path.hidden" &&
     +		test_when_finished "mv $path.hidden $path" &&
     +
    -+		git rev-list --missing=print-only --objects --no-object-names \
    -+			HEAD >actual &&
    -+
    -+		# Only the missing OID should appear, without the "?" prefix.
    -+		grep "^$oid$" actual &&
    ++		git rev-list --missing=print --missing-only --objects \
    ++			--no-object-names HEAD >actual &&
     +
    -+		# Present objects must NOT appear in the output.
    -+		while read present_oid
    -+		do
    -+			! grep "^$present_oid$" actual || return 1
    -+		done <present.raw
    ++		echo $oid >expect &&
    ++		test_cmp expect actual
     +	'
     +done
    ++
    ++test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
    ++	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
    ++	test_grep "requires --missing=print" err
    ++'
    ++
    ++test_expect_success "--missing-only is incompatible with --count" '
    ++	test_must_fail git rev-list --missing=print --missing-only \
    ++		--count --objects HEAD 2>err &&
    ++	test_grep "cannot be used together" err
    ++'
    ++
    ++test_expect_success "--missing-only is incompatible with --disk-usage" '
    ++	test_must_fail git rev-list --missing=print --missing-only \
    ++		--disk-usage --objects HEAD 2>err &&
    ++	test_grep "cannot be used together" err
    ++'
    ++
    ++test_expect_success "--missing-only works with --missing=print-info" '
    ++	oid="$(git rev-parse HEAD:1.t)" &&
    ++	path=".git/objects/$(test_oid_to_path $oid)" &&
    ++
    ++	mv "$path" "$path.hidden" &&
    ++	test_when_finished "mv $path.hidden $path" &&
    ++
    ++	git rev-list --missing=print-info --missing-only --objects \
    ++		--no-object-names HEAD >actual &&
    ++
    ++	# Filter keeps print-info fields; only the "?" prefix is dropped.
    ++	echo "$oid path=1.t type=blob" >expect &&
    ++	test_cmp expect actual
    ++'
     +
      test_expect_success "-z nul-delimited --missing" '
      	test_when_finished rm -rf repo &&

base-commit: 1630431f326e15fcde608827b5ff38422528eb59

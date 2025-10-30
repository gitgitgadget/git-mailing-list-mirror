Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2272EA72A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827636; cv=none; b=BWaljlKXeltnXYhpJCwrz4oBTCfKtE121+qMRSAVgvbNXmPXr0eoQ8uKJDk36wiQEpfS8pS5NFU96YUPfsAea7jjyO7Pwwzw1x3RhnuZtG2es3yY2izz6VrVVMe8Ow3A2nDRKHGKnLL8y14rGgp1cyshbRl/VUco9NbCQBBeDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827636; c=relaxed/simple;
	bh=bYV2XEkt0swlcA1/YxuXrw/b8jV8zLxahVqOexgrtM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSuMTng2DvtV2hYJwPgS9Nst64yny1EYRQu/xA9sOiPkcczFlvs5KbWtaUyeJijuotrsvqr5GEWqHT1CEl7po34zTHAxdmNc44N/3T2Ctt+WAS0PCTcz++jYt17CLo4MrDx0N4Xdn/2A72PPFuGgKLv5sFn4e6OWVvf2RirltGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPrdLkGG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPrdLkGG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so812593f8f.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827632; x=1762432432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAX3dGrfZzUFK0Ygr36RicegT3VDUXz7Ae2imnfXnfE=;
        b=ZPrdLkGG3q3up2hDnk+2SAPhsPUemZcUV59kkYzSdtjg5njom+bwWV6+JnMUQq2jJt
         m60Kob5mOTNcGDUiWgpGPZFI5/bXChFNc6fkqE5oRu0ARR/xwmGKZl2X2HiaHlSC4LzZ
         1DYq7dXshetZCZl+WrclxwDPaG6icw2/A6WV/wnbdHA9zWK7IQvPCEr1mBSVWKd/k3ie
         OqYTlpLnhx3cCVOlFgAylSbRPA4HV7YCk5H0vMztEagJA9/aDcUdujwULtt6u3AzV/q5
         QjCEAJ8mo+mFuD3cmCADe8smWWRzlyHuuq40kzNWsXxMp7tq5onzyf3qEha56ltq4Siq
         Id0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827632; x=1762432432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAX3dGrfZzUFK0Ygr36RicegT3VDUXz7Ae2imnfXnfE=;
        b=opCVt5xt46nr99lkry2JHsdV1h4qve1Hab9EzO5twggqbaaKSQsbc0WEN+8Rl3pXN+
         0GDw5MhVvB2b5GTx3Tou40aiNN8Pc+v5icI4p92npOrp/M5R3C/eCJtaY1OdP8Rxh/B2
         NoO0hTfxITZlrLIm72rGzEyiOFk9ygzFxCqm3yoL04Ie2Sm6m0nOGHUIWqK8BQWWE5i/
         abiUYhgmWRODDlq7VhkaAu4PzTXyeibiDZ4WeVsQ72Og1StcXRvzoqE8S5GOIuLDTxoU
         wzbfR4/m2B2PrOy2woAjUbfAuqba9MoYk2KeUJitiKnBtvg6hNLfMnylRUmF5aqgZSkg
         H8OQ==
X-Gm-Message-State: AOJu0YwlZFcoW6vOnhKGONcoeUAfmnr1rZQFWshbUNF2ayiv+u8GtlfR
	nHumMgB1ZmbsxkLeeP8++ksLxT0TlDaVbNDzgVl2jtI75XOFMZmYwVglAKZuzw==
X-Gm-Gg: ASbGncvL43JtEm0mWFSls8JgvC3ex+qCnq0OvjMVUviMj7FsufYuxnD3yeBUC1ska4O
	00ROyL95yr1GDrQ1iDCXnW6m3GeJs4U8oB/QpBm8lfc4/+RtdfFd8UEeHXrM/KF101zPP0QNPB1
	7fdAM8ZYpWvIomhAlVcIsw0G2KJ1zpcSR1NvEdnVrUSmkiBWQ3YtL6dEqsJM6v/7ZrDIFrHNcOR
	1uD/2thZnaS/wBPr2OofpthXtcb++/iY/KZN/Cj5H9wI7vmUVnkg2AX71gR+uVgGjpPr3HXA7cZ
	R8sY5T7tQxDu4SMOR/RKxJZhgnSRw7Y+EV0wl+Yb7IVNg2IPclCKPjx3UyndyaKjc3ipZTycskw
	fdzVS+s4HzuHfq10mMH1bZnedXO4tA5D8hgakIYmpU6H6tNCFalKUL4OhR0oqSAOUSWFAJOUuwA
	KUEut17XwMvHDjljWFtALNgqdao16Nhdq54V1g
X-Google-Smtp-Source: AGHT+IEL02w/IrHtuc7CFW5OsC+vJJYGWWFuwtL+jv4LD1EyHPSs3bkZpNyLKetpietZFTnVp08nQA==
X-Received: by 2002:a05:6000:41cc:b0:429:b751:792b with SMTP id ffacd0b85a97d-429b7517c53mr1743135f8f.32.1761827631636;
        Thu, 30 Oct 2025 05:33:51 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:50 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] fast-export: mark strings for translation
Date: Thu, 30 Oct 2025 13:33:30 +0100
Message-ID: <20251030123332.3337684-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some error or warning messages in "builtin/fast-export.c" are marked
for translation, but many are not.

To be more consistent and provide a better experience to people using a
translated version, let's mark all the remaining error or warning
messages for translation.

While at it:

  - improve how some arguments to some error functions are indented,
  - remove "Error:" at the start of an error message,
  - downcase error and warning messages that start with an uppercase.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 79 ++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7adbc55f0d..0421360ab7 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -65,7 +65,7 @@ static int parse_opt_sign_mode(const struct option *opt,
 		return 0;
 
 	if (parse_sign_mode(arg, val))
-		return error("Unknown %s mode: %s", opt->long_name, arg);
+		return error(_("unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
 }
@@ -82,7 +82,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	else if (!strcmp(arg, "rewrite"))
 		*val = REWRITE;
 	else
-		return error("Unknown tag-of-filtered mode: %s", arg);
+		return error(_("unknown tag-of-filtered mode: %s"), arg);
 	return 0;
 }
 
@@ -107,7 +107,7 @@ static int parse_opt_reencode_mode(const struct option *opt,
 		if (!strcasecmp(arg, "abort"))
 			*val = REENCODE_ABORT;
 		else
-			return error("Unknown reencoding mode: %s", arg);
+			return error(_("unknown reencoding mode: %s"), arg);
 	}
 
 	return 0;
@@ -318,16 +318,16 @@ static void export_blob(const struct object_id *oid)
 	} else {
 		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf)
-			die("could not read blob %s", oid_to_hex(oid));
+			die(_("could not read blob %s"), oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
 					   type) < 0)
-			die("oid mismatch in blob %s", oid_to_hex(oid));
+			die(_("oid mismatch in blob %s"), oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
 	}
 
 	if (!object)
-		die("Could not read blob %s", oid_to_hex(oid));
+		die(_("could not read blob %s"), oid_to_hex(oid));
 
 	mark_next_object(object);
 
@@ -336,7 +336,7 @@ static void export_blob(const struct object_id *oid)
 		printf("original-oid %s\n", oid_to_hex(oid));
 	printf("data %"PRIuMAX"\n", (uintmax_t)size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno("could not write blob '%s'", oid_to_hex(oid));
+		die_errno(_("could not write blob '%s'"), oid_to_hex(oid));
 	printf("\n");
 
 	show_progress();
@@ -499,10 +499,10 @@ static void show_filemodify(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("Unexpected comparison status '%c' for %s, %s",
-				q->queue[i]->status,
-				ospec->path ? ospec->path : "none",
-				spec->path ? spec->path : "none");
+			die(_("unexpected comparison status '%c' for %s, %s"),
+			    q->queue[i]->status,
+			    ospec->path ? ospec->path : _("none"),
+			    spec->path ? spec->path : _("none"));
 		}
 	}
 }
@@ -699,14 +699,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 
 	author = strstr(commit_buffer_cursor, "\nauthor ");
 	if (!author)
-		die("could not find author in commit %s",
+		die(_("could not find author in commit %s"),
 		    oid_to_hex(&commit->object.oid));
 	author++;
 	commit_buffer_cursor = author_end = strchrnul(author, '\n');
 
 	committer = strstr(commit_buffer_cursor, "\ncommitter ");
 	if (!committer)
-		die("could not find committer in commit %s",
+		die(_("could not find committer in commit %s"),
 		    oid_to_hex(&commit->object.oid));
 	committer++;
 	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
@@ -781,8 +781,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		case REENCODE_NO:
 			break;
 		case REENCODE_ABORT:
-			die("Encountered commit-specific encoding %.*s in commit "
-			    "%s; use --reencode=[yes|no] to handle it",
+			die(_("encountered commit-specific encoding %.*s in commit "
+			      "%s; use --reencode=[yes|no] to handle it"),
 			    (int)encoding_len, encoding,
 			    oid_to_hex(&commit->object.oid));
 		}
@@ -798,11 +798,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (signatures.nr) {
 		switch (signed_commit_mode) {
 		case SIGN_ABORT:
-			die("encountered signed commit %s; use "
-			    "--signed-commits=<mode> to handle it",
+			die(_("encountered signed commit %s; use "
+			      "--signed-commits=<mode> to handle it"),
 			    oid_to_hex(&commit->object.oid));
 		case SIGN_WARN_VERBATIM:
-			warning("exporting %"PRIuMAX" signature(s) for commit %s",
+			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
 				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_VERBATIM:
@@ -812,7 +812,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			}
 			break;
 		case SIGN_WARN_STRIP:
-			warning("stripping signature(s) from commit %s",
+			warning(_("stripping signature(s) from commit %s"),
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_STRIP:
@@ -890,7 +890,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		tagged = ((struct tag *)tagged)->tagged;
 	}
 	if (tagged->type == OBJ_TREE) {
-		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
+		warning(_("omitting tag %s,\nsince tags of trees (or tags "
+			  "of tags of trees, etc.) are not supported."),
 			oid_to_hex(&tag->object.oid));
 		return;
 	}
@@ -898,7 +899,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	buf = odb_read_object(the_repository->objects, &tag->object.oid,
 			      &type, &size);
 	if (!buf)
-		die("could not read tag %s", oid_to_hex(&tag->object.oid));
+		die(_("could not read tag %s"), oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -935,17 +936,17 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (sig_offset < message_size)
 			switch (signed_tag_mode) {
 			case SIGN_ABORT:
-				die("encountered signed tag %s; use "
-				    "--signed-tags=<mode> to handle it",
+				die(_("encountered signed tag %s; use "
+				      "--signed-tags=<mode> to handle it"),
 				    oid_to_hex(&tag->object.oid));
 			case SIGN_WARN_VERBATIM:
-				warning("exporting signed tag %s",
+				warning(_("exporting signed tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_VERBATIM:
 				break;
 			case SIGN_WARN_STRIP:
-				warning("stripping signature from tag %s",
+				warning(_("stripping signature from tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_STRIP:
@@ -960,8 +961,8 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (!tagged_mark) {
 		switch (tag_of_filtered_mode) {
 		case TAG_FILTERING_ABORT:
-			die("tag %s tags unexported object; use "
-			    "--tag-of-filtered-object=<mode> to handle it",
+			die(_("tag %s tags unexported object; use "
+			      "--tag-of-filtered-object=<mode> to handle it"),
 			    oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
@@ -969,7 +970,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			return;
 		case REWRITE:
 			if (tagged->type == OBJ_TAG && !mark_tags) {
-				die(_("Error: Cannot export nested tags unless --mark-tags is specified."));
+				die(_("cannot export nested tags unless --mark-tags is specified."));
 			} else if (tagged->type == OBJ_COMMIT) {
 				p = rewrite_commit((struct commit *)tagged);
 				if (!p) {
@@ -1025,7 +1026,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, const char *full_n
 			tag = (struct tag *)tag->tagged;
 		}
 		if (!tag)
-			die("Tag %s points nowhere?", e->name);
+			die(_("tag %s points nowhere?"), e->name);
 		return (struct commit *)tag;
 	}
 	default:
@@ -1063,7 +1064,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 		commit = get_commit(e, full_name);
 		if (!commit) {
-			warning("%s: Unexpected object of type %s, skipping.",
+			warning(_("%s: unexpected object of type %s, skipping."),
 				e->name,
 				type_name(e->item->type));
 			free(full_name);
@@ -1078,7 +1079,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			free(full_name);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
-			warning("Tag points to object of unexpected type %s, skipping.",
+			warning(_("tag points to object of unexpected type %s, skipping."),
 				type_name(commit->object.type));
 			free(full_name);
 			continue;
@@ -1174,7 +1175,7 @@ static void export_marks(char *file)
 
 	f = fopen_for_writing(file);
 	if (!f)
-		die_errno("Unable to open marks file %s for writing.", file);
+		die_errno(_("unable to open marks file %s for writing."), file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
@@ -1191,7 +1192,7 @@ static void export_marks(char *file)
 	e |= ferror(f);
 	e |= fclose(f);
 	if (e)
-		error("Unable to write marks file %s.", file);
+		error(_("unable to write marks file %s."), file);
 }
 
 static void import_marks(char *input_file, int check_exists)
@@ -1214,20 +1215,20 @@ static void import_marks(char *input_file, int check_exists)
 
 		line_end = strchr(line, '\n');
 		if (line[0] != ':' || !line_end)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		*line_end = '\0';
 
 		mark = strtoumax(line + 1, &mark_end, 10);
 		if (!mark || mark_end == line + 1
 			|| *mark_end != ' ' || get_oid_hex(mark_end + 1, &oid))
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 
 		if (last_idnum < mark)
 			last_idnum = mark;
 
 		type = odb_read_object_info(the_repository->objects, &oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(&oid));
+			die(_("object not found: %s"), oid_to_hex(&oid));
 
 		if (type != OBJ_COMMIT)
 			/* only commits */
@@ -1235,12 +1236,12 @@ static void import_marks(char *input_file, int check_exists)
 
 		commit = lookup_commit(the_repository, &oid);
 		if (!commit)
-			die("not a commit? can't happen: %s", oid_to_hex(&oid));
+			die(_("not a commit? can't happen: %s"), oid_to_hex(&oid));
 
 		object = &commit->object;
 
 		if (object->flags & SHOWN)
-			error("Object %s already has a mark", oid_to_hex(&oid));
+			error(_("object %s already has a mark"), oid_to_hex(&oid));
 
 		mark_object(object, mark);
 
@@ -1394,7 +1395,7 @@ int cmd_fast_export(int argc,
 	get_tags_and_duplicates(&revs.cmdline);
 
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	revs.reverse = 1;
 	revs.diffopt.format_callback = show_filemodify;
-- 
2.51.2.617.g2aaa867cd1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9ABE20248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBVULT (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:11:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVULT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:11:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so3671437wrp.7
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBV62S6hyP3GujCTK4VUSI3pqpLptAd4Jr8uZtcKQgo=;
        b=CBIOKBjP3/rN4S+7qBXcVRZV+lIlW3YC5jdRL9l5uyOZWN8aOjXjBDwoS0JNbbs/R4
         QcimWLXI3kuJdf8287aE+744N4XQHuZNArwZVywlXmKDeqMQ5DnPSn2Q2i7ndVxwQC1P
         VUY2OaJ/JsuLUkOAtrmSMw74mVLoIpPGWbHzgdKubhyT5sIUqlXHI8rb8ixceoFLTnFp
         X1s1RGipwE5Qh9/znsEX0l0j6Cy350ZPcrJQJ9R+DpzZzx2oPPBw0cjp/eRhXuhoHm++
         INy3pDvd5JumZf5uYtKTjRLFnN96u7EQ0T6jdnr4DCI6jyi/nndjNCkz9Mcm589jhK0+
         pTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wBV62S6hyP3GujCTK4VUSI3pqpLptAd4Jr8uZtcKQgo=;
        b=W/B3SoeQQn3KqQgRs4VIBW73GcKNjXTw6e3w2GuG7NmsbAvgh06f5X/7AUImZ8Bk0X
         mnc4d6SIli6MrkaCyr+qRASIrYEYvNKtX6zvSZMoMsUcvFPcVQsNhrBclK4bBAvoweZV
         XXSk7MUNi0jizdySXs1LogERhOsB6YmAX5zsw3RtMIGeNN5MQ+HeG5VegkYjiSFEPJIp
         HAx6m0cBMpzx2LuWW/H/uwpPiS9nMDisU5XnhTAZ+mKoQG6BnhBISqBCbdRvgNhYqB3h
         K19yY+RDu7Gng/rS2NgT8owrTz1PFi/++mOgEqotCthBXIr1wxcCZtf2zsWQIZ6z74SF
         Xdrw==
X-Gm-Message-State: AHQUAub6bp19KzZkgP5zd6oTt0M4BDE/3g5okhPBlsETg+mJSP7vQlM3
        xa+erzYrqD0ypUbk9uYGfHfppAvw
X-Google-Smtp-Source: AHgI3Iaz+V45jpdots0vm6hH2Ckc9FQyuFxVDRmSwkQOdnCeytFNhZD322tRh8lcTH5tPzqXuc1XKg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr4538075wru.59.1550866275481;
        Fri, 22 Feb 2019 12:11:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm3288556wrq.96.2019.02.22.12.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:11:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] builtin/log: downcase the beginning of error messages
Date:   Fri, 22 Feb 2019 12:11:09 -0800
Message-Id: <20190222201111.98196-2-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-rc2
In-Reply-To: <20190222201111.98196-1-gitster@pobox.com>
References: <20190222201111.98196-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 57869267d8..f2d1fbf18a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -513,7 +513,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	if (get_oid_with_context(the_repository, obj_name,
 				 GET_OID_RECORD_PATH,
 				 &oidc, &obj_context))
-		die(_("Not a valid object name %s"), obj_name);
+		die(_("not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
 	    !textconv_object(the_repository, obj_context.path,
 			     obj_context.mode, &oidc, 1, &buf, &size)) {
@@ -537,7 +537,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	int offset = 0;
 
 	if (!buf)
-		return error(_("Could not read object %s"), oid_to_hex(oid));
+		return error(_("could not read object %s"), oid_to_hex(oid));
 
 	assert(type == OBJ_TAG);
 	while (offset < size && buf[offset] != '\n') {
@@ -631,7 +631,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 				break;
 			o = parse_object(the_repository, &t->tagged->oid);
 			if (!o)
-				ret = error(_("Could not read object %s"),
+				ret = error(_("could not read object %s"),
 					    oid_to_hex(&t->tagged->oid));
 			objects[i].item = o;
 			i--;
@@ -656,7 +656,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = cmd_log_walk(&rev);
 			break;
 		default:
-			ret = error(_("Unknown type: %d"), o->type);
+			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
 	free(objects);
@@ -894,7 +894,7 @@ static int open_next_file(struct commit *commit, const char *subject,
 		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
-		error_errno(_("Cannot open patch file %s"), filename.buf);
+		error_errno(_("cannot open patch file %s"), filename.buf);
 		strbuf_release(&filename);
 		return -1;
 	}
@@ -911,7 +911,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	unsigned flags1, flags2;
 
 	if (rev->pending.nr != 2)
-		die(_("Need exactly one range."));
+		die(_("need exactly one range."));
 
 	o1 = rev->pending.objects[0].item;
 	o2 = rev->pending.objects[1].item;
@@ -921,7 +921,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	c2 = lookup_commit_reference(the_repository, &o2->oid);
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
-		die(_("Not a range."));
+		die(_("not a range."));
 
 	init_patch_ids(the_repository, ids);
 
@@ -1044,7 +1044,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct commit *head = list[0];
 
 	if (!cmit_fmt_is_mail(rev->commit_format))
-		die(_("Cover letter needs email format"));
+		die(_("cover letter needs email format"));
 
 	committer = git_committer_info(0);
 
@@ -1214,7 +1214,7 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 	const char **dir = (const char **)opt->value;
 	BUG_ON_OPT_NEG(unset);
 	if (*dir)
-		die(_("Two output directories?"));
+		die(_("two output directories?"));
 	*dir = arg;
 	return 0;
 }
@@ -1321,7 +1321,7 @@ static struct commit *get_base_commit(const char *base_commit,
 	if (base_commit && strcmp(base_commit, "auto")) {
 		base = lookup_commit_reference_by_name(base_commit);
 		if (!base)
-			die(_("Unknown commit %s"), base_commit);
+			die(_("unknown commit %s"), base_commit);
 	} else if ((base_commit && !strcmp(base_commit, "auto")) || base_auto) {
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
@@ -1331,16 +1331,16 @@ static struct commit *get_base_commit(const char *base_commit,
 			struct object_id oid;
 
 			if (get_oid(upstream, &oid))
-				die(_("Failed to resolve '%s' as a valid ref."), upstream);
+				die(_("failed to resolve '%s' as a valid ref."), upstream);
 			commit = lookup_commit_or_die(&oid, "upstream base");
 			base_list = get_merge_bases_many(commit, total, list);
 			/* There should be one and only one merge base. */
 			if (!base_list || base_list->next)
-				die(_("Could not find exact merge base."));
+				die(_("could not find exact merge base."));
 			base = base_list->item;
 			free_commit_list(base_list);
 		} else {
-			die(_("Failed to get upstream, if you want to record base commit automatically,\n"
+			die(_("failed to get upstream, if you want to record base commit automatically,\n"
 			      "please use git branch --set-upstream-to to track a remote branch.\n"
 			      "Or you could specify base commit by --base=<base-commit-id> manually."));
 		}
@@ -1360,7 +1360,7 @@ static struct commit *get_base_commit(const char *base_commit,
 			struct commit_list *merge_base;
 			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
 			if (!merge_base || merge_base->next)
-				die(_("Failed to find exact merge base"));
+				die(_("failed to find exact merge base"));
 
 			rev[i] = merge_base->item;
 		}
@@ -1739,7 +1739,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-			die_errno(_("Could not create directory '%s'"),
+			die_errno(_("could not create directory '%s'"),
 				  output_directory);
 	}
 
@@ -1941,7 +1941,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 		if (!use_stdout &&
 		    open_next_file(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
-			die(_("Failed to create output files"));
+			die(_("failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free_commit_buffer(the_repository->parsed_objects,
 				   commit);
@@ -2065,9 +2065,9 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
-		die(_("Unknown commit %s"), head);
+		die(_("unknown commit %s"), head);
 	if (add_pending_commit(upstream, &revs, UNINTERESTING))
-		die(_("Unknown commit %s"), upstream);
+		die(_("unknown commit %s"), upstream);
 
 	/* Don't say anything if head and upstream are the same. */
 	if (revs.pending.nr == 2) {
@@ -2079,7 +2079,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	get_patch_ids(&revs, &ids);
 
 	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
-		die(_("Unknown commit %s"), limit);
+		die(_("unknown commit %s"), limit);
 
 	/* reverse the list of commits */
 	if (prepare_revision_walk(&revs))
-- 
2.21.0-rc2


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A06B1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeFAVKs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37570 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeFAVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so4700331wmb.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=YJgdSeTc+T1wDpPwWWkrCjcZn7YKGtWOb0Mbbj4ux6SZLta2Zclncu62NNaYpaYZz2
         ruqPdLLGReUBVhFsOGxuGk/iZJIj9mewwQsY3qh8m1M49TquOD5zYMJo4M5JCalWRc3b
         PhG0awVfOI3RcVfm9Uvebjaa4jufEIH1ckYQXsPUoDiBvi1e++x26CLjPC6bu0ebOt9D
         tOULeRl+Y5IHLTkfmgtKqlbm6NbEs9JPDLXG/rRWLU7RBQJJHrfc0rw2SiXJ+DcH+G5i
         IvgBK9dFHQY53jSmcuDmgYWpmzJRDktdOCNL6TdJpSphiwm5aj+ZPJ8hkUtPPqgha1mV
         ESTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=MIrETxTI+8wb7LnGjRmcWuLOlkmPdaRBBGf9dGeiqaGpD4AVIYs+5FVG/smbc7ueU2
         JRCjjRbjzta5Tnubaaeg+qpGQDVqINMydddESsEgCaxaSkHlCnzTaMxURvwBl0IzV4zy
         m62yTuMSy19PcEK6RkkEBIqlDILyLm0ZCWvUHzvEpBvg1LsqJn+f13ODjB2HY2Nq61oo
         9hXx0emUYS67XzR6/lcl9Wf3I/jVCCEmXXXTpNwRiJDM/3KMBwYZW6K9TQFo3rvZg7tq
         RpnVIH63gdKi60PCCrXramFQLQnm08j4pGd72mEVYQhb+2EIfK8dGu5dDVoJ4PHlAKm4
         H9XA==
X-Gm-Message-State: APt69E3NnPvn930AI5PSmHTlwBwRTXGWR5VU3fwvjWtCMZhvptIlbzqA
        6dxqUx44lZiIfNqQgz16ZLi8VUsQ
X-Google-Smtp-Source: ADUXVKJ42qjzytI5+vsSycxdhX47T39KQ/m0c2OmuFRB2HtwubgPsTHmX1u2wj+32agEGE5Ck4nRbA==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr3651003wmb.124.1527887440465;
        Fri, 01 Jun 2018 14:10:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/8] checkout: pass the "num_matches" up to callers
Date:   Fri,  1 Jun 2018 21:10:12 +0000
Message-Id: <20180601211015.11919-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the previously added "num_matches" struct value up to the callers
of unique_tracking_name(). This will allow callers to optionally print
better error messages in a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 10 +++++++---
 builtin/worktree.c |  4 ++--
 checkout.c         |  5 ++++-
 checkout.h         |  3 ++-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e1d2376d2..72457fb7d5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -878,7 +878,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
-				struct object_id *rev)
+				struct object_id *rev,
+				int *dwim_remotes_matched)
 {
 	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
@@ -972,7 +973,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = unique_tracking_name(arg, rev);
+			const char *remote = unique_tracking_name(arg, rev,
+								  dwim_remotes_matched);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1109,6 +1111,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
+	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1219,7 +1222,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, &opts, &rev);
+					     &new_branch_info, &opts, &rev,
+					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5c7d2bb180..a763dbdccb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -412,7 +412,7 @@ static const char *dwim_branch(const char *path, const char **new_branch)
 	if (guess_remote) {
 		struct object_id oid;
 		const char *remote =
-			unique_tracking_name(*new_branch, &oid);
+			unique_tracking_name(*new_branch, &oid, NULL);
 		return remote;
 	}
 	return NULL;
@@ -484,7 +484,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid);
+			remote = unique_tracking_name(branch, &oid, NULL);
 			if (remote) {
 				new_branch = branch;
 				branch = remote;
diff --git a/checkout.c b/checkout.c
index 7662a39a62..ee3a7e9c05 100644
--- a/checkout.c
+++ b/checkout.c
@@ -32,12 +32,15 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	return 0;
 }
 
-const char *unique_tracking_name(const char *name, struct object_id *oid)
+const char *unique_tracking_name(const char *name, struct object_id *oid,
+				 int *dwim_remotes_matched)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
+	if (dwim_remotes_matched)
+		*dwim_remotes_matched = cb_data.num_matches;
 	free(cb_data.src_ref);
 	if (cb_data.num_matches == 1)
 		return cb_data.dst_ref;
diff --git a/checkout.h b/checkout.h
index 4cd4cd1c23..6b2073310c 100644
--- a/checkout.h
+++ b/checkout.h
@@ -9,6 +9,7 @@
  * exists, NULL otherwise.
  */
 extern const char *unique_tracking_name(const char *name,
-					struct object_id *oid);
+					struct object_id *oid,
+					int *dwim_remotes_matched);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a


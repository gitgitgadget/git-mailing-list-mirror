Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FBD1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeEaTxn (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38003 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeEaTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so55829775wmb.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ln5EG56Yc5eNK3/llBsRn5nQUllzApkvzQxv8mkJ93M=;
        b=Ygcq+n0uD+Mf1A/W2zfgFUKwA7LdPuDL8BoSsETwnLohbuKPEjzBINVU7121DzATEv
         iTryhxExIIy/xE90acvefnSjnluaAoft+4Ie+cZMxL5agykzYErfbLqTmhjcan6jeO73
         9ISvywRwf7oz2wPRlh8MGoztl4ia6bVVlKYEnSdNbKbGi/yKxW79g1x/RQVoCUtdPZjw
         f9fS0xIOAMxbN82IF7+LS8kn9RlqMHpo5NKbaUVuhQLhMMy0VV2rf6QMDLlAIMkPxPDH
         2pug/5GRWaUrAkmqLsNNTKO0JNfguDPbShELMWJpZ1yz3/f/pCsrTctaelHjirFxC9XE
         XXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ln5EG56Yc5eNK3/llBsRn5nQUllzApkvzQxv8mkJ93M=;
        b=KuWRqs1MVrE/pNgZ6OOZV0jIMeAlabE7Jb2Owa4LNRj7SP9juurkm8Vgu08RKQMPX3
         OK9USW3N06Mvm9C3ATsrFFV68jMMcdu7x4ecegbSjlxoPuKJy/VBt1osfYvPbp9u8ySS
         5zY6IoGq8fmRwbu3xauSW3LcUIMf+daMcSgJFUhP+71bf/Jz/YtldlS35JJDtAi5dco6
         LoyhnifKG75akNXLg0JC1ddi9SPgls3UYVm9nnaohbzFWdQ2eWTx2e42Zeus4rCgh81y
         YUHRvJnFeSeouwfWVE8SPBk4qyaQRel1iwG/CFp4epSN16UUlMRKYegToravKZ2LHri/
         Q/aw==
X-Gm-Message-State: ALKqPwdfwC0lb/Sk/80aKsD8Ho91lqL/ijm1BwNmnbu2Fq+71krglmgB
        7EJkn/bSenijeeT76Yah04ZcFA7O
X-Google-Smtp-Source: ADUXVKKttFWRP7NIaaIW81B/j/p7CRS7SBMXChLrBYJ5CaXkHP/Q3wnZLpyq5E2rfn/Tt9nYEj6Oyw==
X-Received: by 2002:a1c:3391:: with SMTP id z139-v6mr788305wmz.136.1527796412926;
        Thu, 31 May 2018 12:53:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:32 -0700 (PDT)
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
Subject: [PATCH v4 6/9] checkout: pass the "num_matches" up to callers
Date:   Thu, 31 May 2018 19:52:49 +0000
Message-Id: <20180531195252.29173-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
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
 builtin/checkout.c | 16 +++++++++++-----
 builtin/worktree.c |  4 ++--
 checkout.c         |  5 ++++-
 checkout.h         |  3 ++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e1d2376d2..ec7cf93b4a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -239,7 +239,8 @@ static int checkout_merged(int pos, const struct checkout *state)
 }
 
 static int checkout_paths(const struct checkout_opts *opts,
-			  const char *revision)
+			  const char *revision,
+			  int *dwim_remotes_matched)
 {
 	int pos;
 	struct checkout state = CHECKOUT_INIT;
@@ -878,7 +879,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
-				struct object_id *rev)
+				struct object_id *rev,
+				int *dwim_remotes_matched)
 {
 	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
@@ -972,7 +974,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = unique_tracking_name(arg, rev);
+			const char *remote = unique_tracking_name(arg, rev,
+								  dwim_remotes_matched);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1109,6 +1112,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
+	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1219,7 +1223,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, &opts, &rev);
+					     &new_branch_info, &opts, &rev,
+					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
 	}
@@ -1262,7 +1267,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	UNLEAK(opts);
 	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new_branch_info.name);
+		return checkout_paths(&opts, new_branch_info.name,
+				      &dwim_remotes_matched);
 	else
 		return checkout_branch(&opts, &new_branch_info);
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
index 7ce5306bc7..c578782baa 100644
--- a/checkout.c
+++ b/checkout.c
@@ -23,12 +23,15 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
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
index 2decb9b820..4e518c801a 100644
--- a/checkout.h
+++ b/checkout.h
@@ -18,6 +18,7 @@ struct tracking_name_data {
  * exists, NULL otherwise.
  */
 extern const char *unique_tracking_name(const char *name,
-					struct object_id *oid);
+					struct object_id *oid,
+					int *dwim_remotes_matched);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a


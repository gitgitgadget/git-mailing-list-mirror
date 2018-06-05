Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95CD1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeFEOl0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46999 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFEOlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so2707673wrp.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=T1jTmSYHNgn74nI2qpLmj48l3fmZVFLw1IOv5ioMozeqt8qLNe56aVRSNIieZvRnYD
         wbVv8KPWhWpFXo4jo0AQfY37aANyfsHD0MsEbqmRlaqCeRTwFCHl7pW7j/6lj+DFxdSm
         QiDqCm/OD8uMuHTwPH6lGEBxySfAYXJRLN6pO8r4TOQZXTCtUBpNhQ0vj972eLfenQE5
         kOMzzofq9XwZNEwx/0H+5R8Bmoya3Dsd2grXbX4qMpnQlvTTS3gNnr6nThKspWb9lyHs
         GXwlDBpyMXn1RsxNMMLLbbRvja5qerJHs95CgzICDiaGhIaUP1gsKYwUeJ9I8GyYBRv1
         Qrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=MtzrqUiLGiueROM9KHcHbwrWKC3OkIXRvUnMI65VgLw0ZRraBEuXktzxe6PuGedgnB
         4L87iw9F4SWepU3/v8Vr6hYNk4/zlQjkQyUTeJ/iF5EICKd+unPYQOeGaQ6s4jMHQbxo
         TVgYG/eG/13I4/vzVQtdTrFijD/yeEauIMstw8v3ueufyVJymE4yyKHNnPDCrkPErB/l
         2f/nKPr97xBmR+goxWmrWgkDOMsMyT6THQUl+eXl4i7eIrJ2Kd9Jx/Wni7fS9Wdmm6NU
         8G3oqBWlJlGbP3Ehx2G8zOG0aLJJvONK+aDHmoaa8l+HqAzC7x3ZFjgqGAmP6GIqAi8E
         8mrA==
X-Gm-Message-State: APt69E1cpGFMqdD6LtqpeOhr6NlBzM+57QnIIQU5hfv2cm8BJZe2MwxT
        ahSxV4K1/NAVq54mOsAatOpEdP6j
X-Google-Smtp-Source: ADUXVKLWXphL29c8EZ2KxMmHst+QOmOFruAVa8JetvqCDULjs9S2IsPbuBGj80eX/NmmxpUJpZ9u/g==
X-Received: by 2002:adf:a6b8:: with SMTP id t53-v6mr2356678wrc.45.1528209666362;
        Tue, 05 Jun 2018 07:41:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:05 -0700 (PDT)
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
Subject: [PATCH v7 5/8] checkout: pass the "num_matches" up to callers
Date:   Tue,  5 Jun 2018 14:40:46 +0000
Message-Id: <20180605144049.26488-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
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


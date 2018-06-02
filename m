Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792781F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeFBLvK (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44397 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeFBLvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:51:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so38635671wrg.11
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=tekJJD3d7hCPD7xDkqNVVmcR2juPyl3sxgHc9sGSdA58OzBJRadWc3QU/PdyCIi9oS
         RXnJ3bntD+h5ajgtGWHgiut8qK5Po/k3wsWB4uMos3AuNdcln5ntdBffxJRZwsUzlHMf
         CbLAHH7M/Pn6ucPyPAw0f+2r5wwFDecVj2gJ8Lza3GTRwriWkg7tGNNG0V+FLbZct9Jk
         45LJ8RX0530ZDSFUyJ8nWfupd8lOal1Wlvmqukj4XOf1Tjai32/vNlnA3/fGo6CcuTR6
         SgGUIaUjO44+iJd/A38Spc9+PQofa632EzgL/7xWA+KTo6ve41/9YmgzS7JuCaIJdWJ8
         MXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=azXEXI7q67Ye2UZiJPGNTPEksWtlU4EXlto5g4CGiMw=;
        b=N1Y4psa3SI8c1+EFJGOCAm9YqbdHjExzPi3n41fW6WGcDM1hLvWHHI7kADnNlP+nnt
         hJPefA/egaEQcQ23G69kGzu9B0AzUrj7x+BWPDoYLa9/T1Ub0lj5UBpDnVcX6LpDjN1m
         l+UkUAsepWqUV2sLBj/CZdqWUu9m5iYwPnRglcDX30bhB7utAjvXlcUfYaBt3Egz9LOU
         NlCcFpBjG+J6bsMNrIxBd8+NyAQjAvLmU62FnbJbSupmAoDAK05uNxLMd2cfL4gaoLq+
         RMJHERX3X3r1PdSksLbfX+B01fbK7NAW0eq7fOXioIDGfbKDvDvoXeBdIUyHr8t1gJza
         t3dQ==
X-Gm-Message-State: ALKqPwc8Wdaf3jGENVSlxYldpGbdkL9Auu3zm4Hpu+3kYnev2Qix2BkB
        rUQgcOmPafnEcwwcUCbWvyg/DN2K
X-Google-Smtp-Source: ADUXVKLM47pUHQEfOTjXN+PFdN5NPzCxwyEy6Vmc+iOw7eEu0aTFYsFuHyQMwrFaofCWC/bCz6G69w==
X-Received: by 2002:adf:a219:: with SMTP id p25-v6mr11147398wra.19.1527940259928;
        Sat, 02 Jun 2018 04:50:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:59 -0700 (PDT)
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
Subject: [PATCH v6 5/8] checkout: pass the "num_matches" up to callers
Date:   Sat,  2 Jun 2018 11:50:39 +0000
Message-Id: <20180602115042.18167-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
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


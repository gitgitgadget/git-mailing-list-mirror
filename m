Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E991F406
	for <e@80x24.org>; Thu, 10 May 2018 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeEJVT2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 17:19:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35825 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeEJVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 17:19:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id i5-v6so2011249plt.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9I9Zn4XAzuHMqOS30bUqwTufoOdwXL1kXkoDdv2nExU=;
        b=ss+Wrp6PYeXeVVmSxLmKTbUANgARLl2pAv1FID+A3SB/+6fxCcy4BkY6nojSveaGCF
         6/E/GQqFGp1TVeMKDjvvlZjgYrS1CJcRrIfpDodMbyVJXvXJcBW94d6kAkSj6RgGjWXG
         nvxDQPgR2IzJ4Uf1NH15d2S0248E3FAPQFRyYSjGmF6cG8cJMToV0VDPF7kuAU4CertX
         Mczs2c6mtXfNjdeh5bypUni74ZSchbCzS4SidLvzpiUVYvoga5LQhh/poinMDMXgpwft
         XKx3HtwxpHiRM9uHwHudyssnzWywYVJjfjgW8KoemA4HLdyF7Xv4czcG3NI8pW7YrijA
         qJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9I9Zn4XAzuHMqOS30bUqwTufoOdwXL1kXkoDdv2nExU=;
        b=XE8olJ/w6mtYw1OwPHVugy61qKWj9q3eiBRGBan2pwHMibhiavtwGAhZInV6Iu24Af
         bifKeYNOgmqY6uPX4Ssq8tt35WInaUQxay4lCVJmU5y6hzkPMfrf0r40tHOhfeZwaqPY
         yMDcPQqsBYIKS1J66g8w+08JIYG493Hyu39/p08E39xmz/dDbnZIw2x2KiIiOPWbGtnt
         VLDs7T1HEU5RuGyjl9Omf+bLZ4Jtul2FO+cd/+ieMSIKx+/CQYlMjMRbdUyKp35+NAWv
         7oj24vPszRKd9azo6hwter5EfywDQwx5cCaoklBAngvf52PgEEwVaEl9E+PEP1paWHci
         TIFg==
X-Gm-Message-State: ALKqPwe/8PYACGBB8EFHYVmE/jT2mFvCNNTdEtyqjD9lANjTZtfwjmox
        wyqD2L7OfNFg92aB7/Wf3YJ4jw==
X-Google-Smtp-Source: AB8JxZqXtqERGv0JB6PQFezNPqraXve0qkq8YEnCEF8ASHS9cM0i7IiHdjuoPlvElgo9+mE5LVrDSw==
X-Received: by 2002:a17:902:7008:: with SMTP id y8-v6mr2808556plk.141.1525987164577;
        Thu, 10 May 2018 14:19:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z13-v6sm3014735pfe.77.2018.05.10.14.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 14:19:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     leif.middelschulte@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.ath.cx, sbeller@google.com
Subject: [PATCH 2/2] merge-recursive: i18n submodule merge output and respect verbosity
Date:   Thu, 10 May 2018 14:19:17 -0700
Message-Id: <20180510211917.138518-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510211917.138518-1-sbeller@google.com>
References: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
 <20180510211917.138518-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule merge code now uses the output() function that is used by
all the rest of the merge-recursive-code. This allows for respecting
internationalisation as well as the verbosity setting.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 700ba15bf88..a4b91d17f87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1048,18 +1048,17 @@ static void print_commit(struct commit *commit)
 	strbuf_release(&sb);
 }
 
-#define MERGE_WARNING(path, msg) \
-	warning("Failed to merge submodule %s (%s)", path, msg);
-
-static int merge_submodule(struct object_id *result, const char *path,
+static int merge_submodule(struct merge_options *o,
+			   struct object_id *result, const char *path,
 			   const struct object_id *base, const struct object_id *a,
-			   const struct object_id *b, int search)
+			   const struct object_id *b)
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
 
 	int i;
+	int search = !o->call_depth;
 
 	/* store a in result in case we fail */
 	oidcpy(result, a);
@@ -1073,21 +1072,21 @@ static int merge_submodule(struct object_id *result, const char *path,
 		return 0;
 
 	if (add_submodule_odb(path)) {
-		MERGE_WARNING(path, "not checked out");
+		output(o, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
 	if (!(commit_base = lookup_commit_reference(base)) ||
 	    !(commit_a = lookup_commit_reference(a)) ||
 	    !(commit_b = lookup_commit_reference(b))) {
-		MERGE_WARNING(path, "commits not present");
+		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
 
 	/* check whether both changes are forward */
 	if (!in_merge_bases(commit_base, commit_a) ||
 	    !in_merge_bases(commit_base, commit_b)) {
-		MERGE_WARNING(path, "commits don't follow merge-base");
+		output(o, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
 		return 0;
 	}
 
@@ -1116,25 +1115,24 @@ static int merge_submodule(struct object_id *result, const char *path,
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
-		MERGE_WARNING(path, "merge following commits not found");
+		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
 		break;
 
 	case 1:
-		MERGE_WARNING(path, "not fast-forward");
-		fprintf(stderr, "Found a possible merge resolution "
-				"for the submodule:\n");
+		output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
+		output(o, 1, _("Found a possible merge resolution for the submodule:\n"));
 		print_commit((struct commit *) merges.objects[0].item);
-		fprintf(stderr,
+		output(o, 1, _(
 			"If this is correct simply add it to the index "
 			"for example\n"
 			"by using:\n\n"
 			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			"which will accept this suggestion.\n",
+			"which will accept this suggestion.\n"),
 			oid_to_hex(&merges.objects[0].item->oid), path);
 		break;
 
 	default:
-		MERGE_WARNING(path, "multiple merges found");
+		output(o, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
 		for (i = 0; i < merges.nr; i++)
 			print_commit((struct commit *) merges.objects[i].item);
 	}
@@ -1205,12 +1203,11 @@ static int merge_file_1(struct merge_options *o,
 				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(&result->oid,
+			result->clean = merge_submodule(o, &result->oid,
 						       one->path,
 						       &one->oid,
 						       &a->oid,
-						       &b->oid,
-						       !o->call_depth);
+						       &b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (o->recursive_variant) {
 			case MERGE_RECURSIVE_NORMAL:
-- 
2.17.0.255.g8bfb7c0704


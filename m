Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D7E1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGRPyA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:00 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:34369 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:00 -0400
Received: by mail-pl0-f45.google.com with SMTP id f6-v6so2188898plo.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=jyDpV5BzG8iBPDyeyLv1XOV43R7/1fm/0Hrqc+sjK9w=;
        b=hzTZIoghPvECqWrzRiGPqdN2LQF1qt5svJTuV8jjzFqOGiTvex3C/ycFvcTvA4OOdB
         4DwIKc16Tcn58saFvfH1Rq8TwEZKPKOjlPABPhOjy2mHdSaqZ/Gcp5i/vloelViKoUWM
         PGmZl/PugsoUe1kXIDxlyqUSlogu5sFMwW0HdyS9LbkV79pwtD609CJHCIWDlt7J3sYj
         51TXMg5lcLP3MwX77XEwKs4dQVJC42afSDKrsT1VG0mA5BAboyTIFhWCpltEHkr0XCDP
         znz+sX3UBP5T1l7Po88Y/RjJ8qDnySWBA7kM4HXzxPwtamhWonBZoLSLutm1Cm6caG0q
         J3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=jyDpV5BzG8iBPDyeyLv1XOV43R7/1fm/0Hrqc+sjK9w=;
        b=l2TXdQ/PdlCTs/pLv6dDNJjfwyIOEqwkhBnYS4hO8ylT7Z8cYkzaCwcdgvai67uwjP
         GP9b+CoFUy1sQI6fOhm3LAquahFHvYwi2VxsC9Ww9szuBVzj2GoN5A07Pw62+YLPs1Vu
         mIVe8hTV8uWoqVmqnAEG/kanTltchtqAcDWiW545Y7bwlubcj/T95smxNIABoDgCE6ak
         SJNem4N4WK7JxVXC43vBJiDECYaQryNUb0fY4qY893hbGXnkZJuj2OHbetB1YkX4GPw3
         Wr90ShAPratXl1+68ThU8qRIWqyVpXpNCLENdfQxP63xRI929YJgdGi58JD/uwj3TZoQ
         fEwA==
X-Gm-Message-State: AOUpUlGl+DPnj9goQNXHQr+vYXnVqOyi7F8WVYn0VyM9U5hwtPZoMnmW
        QDAB7YIFeisfZ3uVvFCdoriTyA==
X-Google-Smtp-Source: AAOMgpc66Gxrt/cvbgemE5XrofXj+VGJWVtMSOpb8iajOiw4zMXGQdS070HV+P/S9g8MCpZXzPPF3A==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr6227579plg.68.1531926938212;
        Wed, 18 Jul 2018 08:15:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id s195-v6sm11422186pgs.76.2018.07.18.08.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:37 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:37 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:25 GMT
Message-Id: <22dc9ce8364dd20876ab5eb626ecc6a7396d3b3e.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Stefan Beller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/8] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/replace.c | 8 ++++----
 refs.c            | 9 ++++-----
 refs.h            | 2 +-
 replace-object.c  | 5 +++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index ef22d724b..d0b1cdb06 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -39,7 +39,8 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname, const struct object_id *oid,
+static int show_reference(struct repository *r, const char *refname,
+			  const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data = cb_data;
@@ -56,9 +57,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = oid_object_info(the_repository, &object,
-						   NULL);
-			repl_type = oid_object_info(the_repository, oid, NULL);
+			obj_type = oid_object_info(r, &object, NULL);
+			repl_type = oid_object_info(r, oid, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
diff --git a/refs.c b/refs.c
index 2513f77ac..5700cd468 100644
--- a/refs.c
+++ b/refs.c
@@ -1478,12 +1478,11 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(r),
-			       git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base),
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
+				    strlen(git_replace_ref_base),
+				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 80eec8bbc..a0a18223a 100644
--- a/refs.h
+++ b/refs.h
@@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace-object.c b/replace-object.c
index 801b5c167..017f02f8e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,7 +6,8 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(const char *refname,
+static int register_replace_ref(struct repository *r,
+				const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
 {
@@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(r->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
-- 
gitgitgadget


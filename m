Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A916EBEE
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962884; cv=none; b=tQpS7uic1qZ8/Hw7kYReohNuK73ps0ftbKySK1EmGXx8x9avDTZ61crYpnxVnrHq8z4MUqHUEN4cJr0N7nCBqA8lqO0Mg0PDaNbVj7ZlxE++fPAXY+7Ej2IEzGwdhc0G7WXd+UYzsJ438mrm+FoTxv/rIyP3G5ZLwsG5hTHU3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962884; c=relaxed/simple;
	bh=EQPL9hhy3Iin5rq05msozm6f5grxqnWQwKMf3CJ6850=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=K4xMbScer53R00GpM6w7Z6KV3K2PPBUJR2XHIHGgsH6hIobGNQsBrSBFeBIk5/zquovth/4evM2ZiSxHGCALwV5Jpc5ZeGkqp4tfuqw2kBvR1OkNR+oIoHglE200WKxfGLLdB+TsnhjlcYxXkS3XQ92kyVhlMRd0cG4AWM+yRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHFggaTt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHFggaTt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so623262466b.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728962880; x=1729567680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4JoUOYTi6ysrMqsURFCWSEi1+h2tJtGaKeTe2GAfypY=;
        b=PHFggaTtJ3wUXqA8I4daodD1+50+bAcLhU1fHImbkzJkyNhn4mGZC+oJ74HjnGgsWO
         XlLV9qNIu8djltpappAdjkZFnKGDTN+69uWC/nsO+TCsnNSvqtfD2tP0HFbf62vVVjDf
         coBg4+/DC3xtaeRqgaXuAe2YtDvWKY7lpQeIeRxt4AroRzyKEOw/whLBBdS7oFOQ8SbB
         EYVo5cCC/jSn3HeQePxtvvM0sJWDjGUpsWFJFqWmUv1jJpEU9l5b8sO5K+RxJK2mhvPl
         zKSzChTfr8PvnNKDVwht/z3WA2HkIiXmdqjhLY9phclXMBTIbPczVqEBSd0m4QM/WmOL
         MCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962880; x=1729567680;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JoUOYTi6ysrMqsURFCWSEi1+h2tJtGaKeTe2GAfypY=;
        b=dYVU1S7j4ooK0D3QGUvu1JUL1NSc45/d2BmupR2yn3rFvsWe44xM/ydu13jAh0Pskq
         795wZdVZou4xE+7fRJyzw54UGIjJcpJQEnThyj1/N4jdc6DEJSSrTk6vg0XOQU0/HLKy
         ETV3QE37ETlQW9fyHZm0UrhLJNConoprC5rOwB4EOHxcSE81DGX80K8mL/1jZVgC2wit
         Vd8j14UTU/mEc1twZbHe+B2Ek2mQxg2XDTpMLgK/bfnzKP2qxoGxAIgg3gPwJDRw5ghB
         r4oS6e/lWwvJd7J6wkXPSMofNsfx5W6nvHPhPKFpZ5JdHgCbHYoLVU1QjiDGiv36WR0s
         zXRw==
X-Gm-Message-State: AOJu0YwlbOMoAYLHRiK/DwP6cq+wLICCCeS4R7uHLd1OeLdnGHdrphqu
	d7uOaVBixHTOZRtQvy4/y57Dn17tu7ONrBcj1npUB7Xr7Etsa+wpUms2aQ==
X-Google-Smtp-Source: AGHT+IEqqM8N7xda58Phq0ycOfh6u0EfOO052BHQoEjkpTeB/0CZEWGzcWvaXeOF9Smpd+gX5P8Oeg==
X-Received: by 2002:a17:907:3ea8:b0:a99:fd32:11dc with SMTP id a640c23a62f3a-a99fd321240mr559429566b.24.1728962879828;
        Mon, 14 Oct 2024 20:27:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d503447sm205758a12.39.2024.10.14.20.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:27:59 -0700 (PDT)
Message-Id: <pull.1812.git.git.1728962878717.gitgitgadget@gmail.com>
From: "Liu Zhongbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 15 Oct 2024 03:27:58 +0000
Subject: [PATCH] builtin/fetch: iterate symrefs instead of all when checking
 dangling refs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Liu Zhongbo <liuzhongbo.gg@gmail.com>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>

From: Liu Zhongbo <liuzhongbo.6666@bytedance.com>

refs_warn_dangling_symref() traverse all references to check if there are
any dangling symbolic references. The complexity is
O(number of deleted references * total number of references).
It will take a lot of time if there are tens of thousands of branches in
monorepo.

So I first identified all the symbolic references, and then only traverse
in these references. The complexity is
O (number of deleted references * number of symbolic references).

Due to the infrequent use of symbolic references, there will be significant
performance improvements here. In my case, the prune_refs() time has been
reduced from 20 seconds to 4 seconds.

Signed-off-by: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
---
    builtin/fetch: iterate symrefs instead of all refs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1812%2Flzb6666%2Fspeed_up_prune_refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1812/lzb6666/speed_up_prune_refs-v1
Pull-Request: https://github.com/git/git/pull/1812

 builtin/fetch.c |  7 +++++--
 refs.c          | 35 ++++++++++++++++++++++++++---------
 refs.h          |  4 +++-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 80a64d0d269..ec4be60cfeb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1412,15 +1412,18 @@ static int prune_refs(struct display_state *display_state,
 
 	if (verbosity >= 0) {
 		int summary_width = transport_summary_width(stale_refs);
+	    struct string_list symrefs = STRING_LIST_INIT_NODUP;
+	    refs_get_symrefs(get_main_ref_store(the_repository), &symrefs);
 
 		for (ref = stale_refs; ref; ref = ref->next) {
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
-			refs_warn_dangling_symref(get_main_ref_store(the_repository),
-						  stderr, dangling_msg, ref->name);
+	        refs_warn_dangling_symref(get_main_ref_store(the_repository), stderr,
+				      dangling_msg, ref->name, &symrefs);
 		}
+	    string_list_clear(&symrefs, 0);
 	}
 
 cleanup:
diff --git a/refs.c b/refs.c
index 5f729ed4124..8dd480a7a91 100644
--- a/refs.c
+++ b/refs.c
@@ -463,16 +463,33 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 	return 0;
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname)
+static int append_symref(const char *refname, const char *referent UNUSED,
+			 const struct object_id *oid UNUSED,
+			 int flags, void *cb_data) {
+    struct string_list *d = cb_data;
+    if ((flags & REF_ISSYMREF)){
+        string_list_append(d, refname);
+    }
+    return 0;
+}
+
+void refs_get_symrefs(struct ref_store *refs, struct string_list *refnames)
 {
-	struct warn_if_dangling_data data = {
-		.refs = refs,
-		.fp = fp,
-		.refname = refname,
-		.msg_fmt = msg_fmt,
-	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
+	refs_for_each_rawref(refs, append_symref, refnames);
+}
+
+void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
+                               const char *msg_fmt, const char *refname, struct string_list *symrefs) {
+    const char *resolves_to;
+    struct string_list_item *symref;
+    for_each_string_list_item(symref, symrefs) {
+        resolves_to = refs_resolve_ref_unsafe(refs, symref->string,
+                                              0, NULL, NULL);
+        if (resolves_to && strcmp(resolves_to, refname) == 0) {
+            fprintf(fp, msg_fmt, symref->string);
+            fputc('\n', fp);
+        }
+    }
 }
 
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
diff --git a/refs.h b/refs.h
index 108dfc93b34..d3b65564561 100644
--- a/refs.h
+++ b/refs.h
@@ -394,8 +394,10 @@ static inline const char *has_glob_specials(const char *pattern)
 	return strpbrk(pattern, "?*[");
 }
 
+void refs_get_symrefs(struct ref_store *refs, struct string_list *refnames);
+
 void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname);
+			       const char *msg_fmt, const char *refname, struct string_list *symrefs);
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames);
 

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget

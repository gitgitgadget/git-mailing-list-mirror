Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2233D4F0
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619342; cv=none; b=Cq5OUdkVX3TTOWqhg01bZmqU7eKcorHEO0/gqAgMHz1lM0CUcAGNlVSnU9zLdJWFNMddA09dAtHzi8QFjpkCcct5nOuuzUANN5yEfYVSZQHP2CakVCK8bMAikIMAM7jL1oDnnSLDMH+VC2z8d6fS00uDqgEJ3Tr18fgYhLfDtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619342; c=relaxed/simple;
	bh=G3r3xU/PQI0vG8hmy6Nct5fL1q0yaZaz1Z1j7HxwmWs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CZRi0YmCSb3V2XvE4ZkxkV4eDwqL/ZzLxLU8kuCDFTe1LuIQHGM02+vtWL0ZHi70svM2wKZQMbKaz25UMih43H6kHpf04NMdNCfood3ayh2zeOSV2e3Fu4H2cAeS44I93ymkN8LZWITvBBQMx+KGEEOInWEnhD4efnaJnbdzXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+55Rolk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+55Rolk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93cb9e9405fso18016985a.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619339; x=1792224139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Y3fmGJpLs2bfEqu1ITTxk0rSFKfmOPYF86P4+4D40A=;
        b=g+55RolkjTBRcbz9OgT+TjbygKez/ggmRYZMFmoKXUuKC5DqdNygE/DysUVcIW2Fdo
         Oz4bP7wPHYJJPVgOv6FgmDqoxiZEuFGjQh9jwBxZjiISSp5yc2CBu3eXLF8KKGr0Vo78
         2oMYyMVrnGc2fmP2EotZ67nmZF8GjNCrvCPeUHKo6HF4vaZLQGZDOTFofnKP2GFyDFK/
         piLHXe8NjVHXdUC1i3SInaoZz8g29c1onlFkXBzJbHjFg/GekZ/xNhWqS8WG/M3xBPyD
         WpSTjUS8xbwL1kGa6qS+HXGwLW9iutGeVVY/Zc+4IeU8ep+JyGAxDcdZk1OVtW1PCyHZ
         u39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619339; x=1792224139;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Y3fmGJpLs2bfEqu1ITTxk0rSFKfmOPYF86P4+4D40A=;
        b=vZ8/xaZT02gIQMLmhuoc6WIHxx8QBZeYLFK6Krx/U67EK0j9ZnMZmAEI67J9kMjlrC
         gA8mBRrWM5ciHM2ydM3SNOuz6coJzsAZ+kaHK6LBkliwrvaBlI0f/hoDsvs4WjY5nLyF
         m429Hwlo/sVO4/uiAIVC6Wo0nZJXoCJXtYdYvAlxRo/n8flc6/m5uN3h9M78V0YHPmFk
         Uk+wHmWCv5rBhOz/3mc6BJHE+YWiIvBagOUmdP5bWvXUpoeBbePsda+sRAsxpz6XCpM/
         65liPZ8N3on8i6bRsShT+d27voryR7jrnuSBnINZJBVSqsvZjXFOl4dQUclFVAPJyGDp
         uACw==
X-Gm-Message-State: AFq9FYLc7wFm6xTUxkpjc5BfDPkwBoT5Wzyz1bs79hs5+nQJAO8c5id3
	2mr6Xy7iy2Q0QU68LqLAghLK9g01WL3fAuzV9/u8lLno3MBxwjz903gFGf/IaQ==
X-Gm-Gg: AYBFou1eTketWUB5k5bLQM9lJA1vzE8jgO3TWw6Q2GNS6i4I1T09AK+Mwl6mV1yUdiK
	qyYcyoSX9yxkKDKWXP79AlmIUvAgii9QAE2vTbJhf5jKSVpSFRdFhI51S2l4xOPNBQnD4f497hF
	jZv6WcMoDYug8bbt8VQEKKt/m+Vg4u9HGlN208hWeRZzXlWANALagq4hIl8Gue30hkSuNTufRow
	jOUNHIYqXW1d4Aji9o9RTGyVvWuEXIHuXUYbN9CZXdnf0mR9xxsGtcL16NqVj4ykejdTKbGuVUj
	jmjUjwq1wZA2LtnXXRnhQww33d4gK86g7NLGtr3C7FS5u/A9fMy9in68SzjFFD46mWS26dr+jqn
	p4RqBX8NqrKf32DZzY3y9MJa2rWs7NHAxwEdAvWFBspnWfwn6EkLEtLmY0uYiZOlWuJR9EX0Tc2
	CaU+TIXS2EfR37iHrBxiQrwCoVMP0v+NCCa+ck60wc48x7awCbRe85GJRfP63ii0XexZjpfldqY
	iI=
X-Received: by 2002:a05:620a:3947:b0:93e:78b7:fa4e with SMTP id af79cd13be357-93ebd24b2fcmr734289285a.37.1791619339313;
        Sat, 10 Oct 2026 01:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9847f37sm373359285a.10.2026.10.10.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:17 -0700 (PDT)
Message-Id: <08fea07a8be8a91ac54db44f9c035ecb49c86c9f.1791619334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:11 +0000
Subject: [PATCH v8 2/5] fetch: extract collect_upstream_from_remote() helper
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a fetch has no refspec to work from, we fall back to guessing
what to fetch: the remote's configured fetch refspec if there is one,
and separately, whether the current branch's upstream lives on this
remote. The latter is independent of the former on purpose: a narrow
refspec (for example from "git remote add -t") can leave the current
branch's own upstream uncovered, and we still need to be able to fetch
it.

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 43 ++++++++++++++++++++++++++++---------------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1c65c7528..4753656288 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1962,23 +1962,36 @@ static int do_fetch(struct transport *transport,
 
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
+	} else if (transport->remote->fetch.nr) {
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+
+		refspec_ref_prefixes(&transport->remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
+			do_set_head = 1;
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, &tracked,
+					      transport->remote, NULL);
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 	} else {
-		struct branch *branch = branch_get(NULL);
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
 
-		if (transport->remote->fetch.nr) {
-			refspec_ref_prefixes(&transport->remote->fetch,
-					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
-		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
-				strvec_push(&transport_ls_refs_options.ref_prefixes,
-					    branch->merge[i]->src);
-			}
-		}
+		collect_upstream_from_remote(the_repository, &tracked,
+					      transport->remote, NULL);
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 99a086ea5a..5e980625b8 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		string_list_insert(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..7c86c529b6 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget


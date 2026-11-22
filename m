Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348653;
	b=HpiNBnjZ+ZB010Ooe9LyRaYYs5j2BDeBwt56X++YG9qFkFBEo0GfqFrhgHGRvDRaFSca
	 dH8cy6LydH7yDydIE0Qntpt1i7vCjuA+dWivM5XHyxhObj70tc6c4xsc7GWbQL2Y+mgNZ
	 q8GR/KaFhsmOKQd3wuETSUtvsMdcuuT24Xei5kvo3AelvQ8rWcjhGTwYX00+t7vDR5JxV
	 5gBpJTDp1JsrRDPKW0njfAW7r26pMfV/6MVjcjfSOw7AI4jeUOirwJiLCuwaW3UZmmlU1
	 F0OsU/ug958CUleJQi7wBNR835cflPC72PhoqfL7jdMBUW2UHc5jyoQBahSMKzTjqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LQ/5MtT1LRCU1tD60JKHcfzmqfWcwCpf12ogPNtl6bU=;
	b=KZw1Kksn4Mzpc+luEeDgBLCpm5Ev+DK+pponNMV7kisqlGa3uqmyKbAt3kwXjVNKlbmv
	 7zein6QC5wCXfWxVONqf3K1+QtPdwQDCaRnX630VaQHgi8dWazJglVtNWbKlYOvBBjybJ
	 bDIUo3eyKfEGFrpl5cHPVsWm8Zx9UEn+3k+sdHlG3Y4xqydfJJT+StPHr5m34F1nC9nud
	 ycECMJRUK3E2E+jM00EacxnccUeK6QNgNTjMQG+juiN6iiVCiE5x0wGI6cdrA1jUarNEg
	 uZhHLN2S/4y9Z4W4/SHwPE/u9Mm7alwuX6+Lz7aPjyPXj4JALd0lZR0WXrOeMqgltBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJdVkR6Q;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4D606A32C
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A4D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJdVkR6Q
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so2742447c88.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348652; x=1795953452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LQ/5MtT1LRCU1tD60JKHcfzmqfWcwCpf12ogPNtl6bU=;
        b=YJdVkR6QrhWkbxQhp81i9AgYoEEqzf5XJedqqo4CEubK1E1JVgAgn5PUP5iQdE5rCq
         lIQAW9Yilsyk+PF3W03DCrOeoVTCrFUumaCyJZDM3yjgdU7RjNgvbuogLjy/oS6hjS8g
         oDV6KrpCMK/q+ou9qIC5PIIk3kwxcsAjyK77T9A3oeniCzZZOiXOQx2NpSj1NonXB0Wx
         xehILbU9m3eN62sWt5cjwwLLVz4t64nB9ToR0rznP524Tjw/CjtSf8HxhcvF8xBwqgUd
         BR+K2Iy6MRbq9+v6NCgq/Ez/SNeoeeE/2ZVz5wXSxb3zF1KHqGxQ9oqP3B17LZS9JxIT
         GISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348652; x=1795953452;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQ/5MtT1LRCU1tD60JKHcfzmqfWcwCpf12ogPNtl6bU=;
        b=D+HfvtcQwnAwvG0C9oNEbvZEquwa7aqADIW5RxeayPBhguvR/wS6vWILm4E7wTjf0O
         vsAQKmLLTxEmm9ncs/eSghCsrT/Z1IFPuWu07F64xsxL5Wj9jV725/uvc8U/sas3xCBl
         IP/8pPSdzYsjfMemVqhQZvocAIUeb27XRzS9QE5orscRNoNFImLY/YHTTFMyDvltYgBe
         fJE8u/4qEi6qr5Hfc8aPPz48XPjlUO6oLMdYOEyDNGWgpysr5bcW+g+xMgiw1kZovHDg
         stcnnpUugSrNV0KgSRH2RB8TgWDWWo2kkrvA51u2PFO6m76xW1svIbDagE3qFwmYsCzf
         dHrw==
X-Gm-Message-State: APuU4Z8esOKSG2BTu83OBNAU9R56K3PC+BcbkstYuaki6rQ0qhoJIkul
	MjKKlp8cUO06GXrzsYsFo+/pcYj6yJOoZWJN/RJ1cZWEn5ioPjMSbVMYcIVn+A==
X-Gm-Gg: AZFdTZeue8y8o1GKOSU0kZw4L8THqNQ+mcHMUm3PYKC8JSIZ8t6R37na+uqL3GKDEHE
	7PjiogFRPZjzyvQmSnIE2yRlyiJWWuOmWhiX/pVrEbihVb7NDvsHV/abkqKSxP77IRd1qqwhclZ
	CyHEupYBeysYxdoPSjm1VzQrKyMFvxPW+5KhoRKpJQO60HTv4QRJfyXs/HmaAV/HksVQhnC2TPn
	p5eSM8wsfEH15XMmKmk7HxtmwrE9K1vp1MFhB3yjd7ZnCLG+IvIVUUH0RRUWVk/qGWZ38nPwSL1
	0wu1MXYDnzAdwnyuQLqAa8BCbjRxWeFh8kDW+AqsqKM7VzeGZA8f0FXo9CXMjLaL90R3TD37il1
	2pmz+PRnRbcDXuf+6u2bP7HgKUVozU6bvIz68VDWZO7dwnpXKxavXRI3VEqW6UYXvTUSNNgD+rc
	xPC+gqantS93KXwibe//0GZgaw+3GTujtZ4vhpHgqDZkIb2TaTntUAoKbxCP5RBYmuLbY/EMs4r
	0rDdENZf3vyG+HXgZco0JGlLXG7ojAhEgl6QE7J7ftbBMIukd6+yk0F0uR0lK9JtzedZ601LEIh
	y2OIesswA7fih/E4heZTq4zk/xIwr99KNX+irrZE1wAxFn+iDnv2x7g=
X-Received: by 2002:a05:7022:ea47:20b0:1b3:ae7e:c1af with SMTP id a92af1059eb24-1b5568b6778mr9279036c88.14.1795348652082;
        Sun, 22 Nov 2026 03:57:32 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm18173535c88.5.2026.11.22.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:31 -0800 (PST)
Message-Id: <2e2bc76f79242a0d7f934827dc518ec03917d305.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:21 +0000
Subject: [PATCH v15 4/7] fetch: extract collect_upstream_from_remote() helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a fetch has no refspec to work from, we decide what to fetch from
two sources: the remote's configured fetch refspec, and the current
branch's upstream, if it lives on that remote. For example, after

    git clone --single-branch <url>
    git switch -c work
    git push -u origin work

the remote's refspec only covers "main", but a refspec-less "git fetch
origin" still fetches "work" into FETCH_HEAD, so that a plain "git
pull" finds the branch to merge. See 49ca2fba39 (fetch: add
branch.*.merge to default ref-prefix extension, 2022-09-08).

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 18 ++++++++----------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b83f9e5cc9..a9b7305f5f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2028,8 +2028,6 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
-
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
@@ -2044,14 +2042,14 @@ static int do_fetch(struct transport *transport,
 			else
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
-				strvec_push(&transport_ls_refs_options.ref_prefixes,
-					    branch->merge[i]->src);
-			}
-		}
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, transport->remote,
+					      NULL, &transport_ls_refs_options.ref_prefixes);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 6a6e2717c1..ffe892a326 100644
--- a/remote.c
+++ b/remote.c
@@ -1967,6 +1967,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		strvec_push(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..003c8fd180 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget


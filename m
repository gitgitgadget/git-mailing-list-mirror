Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664286;
	b=yvjxzkZ6Q554n4gxSTfb2xJm7HfkNTJbY0OhgYNEx05gd7O+vCoTSMBs0wZM5ezRfu4d
	 3ezVAKCiwcmkfbyKZrSrMvcmX4f44rW0vbRY2iwTloFcckBagQNpDI0q13VvWoe94NtLz
	 XZ88BZBqDlufLi8ePnao0zUj5WrtDW0OSNhChJiX8yOzloatLrJJGNXe5yZes7jO3coiJ
	 FGOHpNMzI9dOU6IfCRtcfseD09sjnkmLoqCOZFU/AF3uDzAl+tRMBTY1fEGmnpJ9F9f7R
	 7eFLHfxfFCUqs8NudXmfEs00ZxElIY4GmqI69889LcK4y+T16rhMzJW4+i0hfzyrkRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Fcc:To:
	 Cc;
	bh=I9f0dT8yeDqZ01JbBPcr9FlyRXgPoTy6QuVjEaRDW9g=;
	b=bP7eHLzHyehaoCFU0KcE/DS4/fdOSYmY592AvYiC/EesZtsHKDipEFBywA9sTIi5vrvc
	 p2qbS4LEtA7BkWc8nDlQCtat/deKB7gBByVcbglp93SVX7p/Qe1teVoAzrY3oRE0pRl4y
	 TZ3jkcXjWQjYYHQdWpdlXcZ6kwg0tZmdkITRLoeQ6jhP/K8T4EDxxC4sik+HMl9B6okKS
	 4Kk19G0JRxeb4SWlC3LilI/horUuD4HcQ7uKjm6SJ8Q4etjcAsVN+QJJfuf80IdUxSb6I
	 OnUhcOQ6x4KxsEXdLUnPOAb2kct0i0mckBBm9Vl/c8lUnt6C4EFkYMuinMft6MDh3aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYQ9v0Bf;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E1606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923E1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYQ9v0Bf
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-386d1859e1cso1150240eec.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664281; x=1796269081; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I9f0dT8yeDqZ01JbBPcr9FlyRXgPoTy6QuVjEaRDW9g=;
        b=uYQ9v0BfZ7Q8cAMB4d9tBzg9eB0RA9eYoHRUXf+PDy1VcjLrYp9I2w/YjGbWaIsHeM
         pdgvCf6lZCEc19IbKkVGoPL473M+eF9WvFpOmDcKbxprhLOD27p1rdpzym2b+rJWREkb
         yjBYNvtqetpn44z7LLyXAbBWLhUJBOBohmkaosy2LFQ5wYz/BUPpHXw6xYO3yNIjsWDH
         lPJ1+nEx8viLssIW4aK/GHr5qhkp6GrxhnCct9QSv8zobcO6OHB+m+gRjfRPmbkn2gK1
         6pGG7Awrq7PaLHxAW8RX4jKO0SKvw/CZOqvXdGbE2PVMa3KNQPhqz7vEXjWzp1ou/7/x
         PF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664281; x=1796269081;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I9f0dT8yeDqZ01JbBPcr9FlyRXgPoTy6QuVjEaRDW9g=;
        b=KDLZqmk7Z9lQ+uSfr49JB2ZwnKnkD9IseBzn9Kp4qxheWgf27m411GRcL2CMlSiSn1
         DoMrGwKT1NzoazWdejdFQ0K4WWKrakpYdMO8h0DZekOqYNTLN3RZw6/jYAOgS7AB/zDc
         TmK+f8JGtI7F/1yMHxk2rhMKlHXS3DW3Eo4ka+c4DQdB3Go1gSkCjQAgxJVA0YXtIdkv
         j8uIMP24p+lRnggABz2RoouSTtGD/GAs1c94oDmTTVA0X4t6aRON6WSOCwOLCHN4/K7e
         V0gomMMoNomEsF5721JsNqIIB12Zc4eKIw5P1XzW+iiPBh9ZOQOAsj63Kw1Wb/CPHaVw
         pgZA==
X-Gm-Message-State: APuU4Z9MKWjI/yrgb6vzD6i5FUHHWBGVENXt+iy14oXD3L6gfctkhCGJ
	TKVSv/PIJx7MjMorECY6qgLORp61Bn9d1yEWmedrzMl/8LofARsmiQBg1yhHpA==
X-Gm-Gg: AZFdTZde6aQG1NzuIJRLm4YmNkKOBpqDXa8AIU7wxmSF5wTcTrvlaOzbRofdqBhN4tr
	m7++x97A+WEYTZD8DFO3OS86WdElVTmz/oxduOR0R9OYFK/zDK2NKovbP9altPzpIIhe5U9bECp
	pGPTHmTOlVS54e6fFD5RCUqcCxmAlKzbsfhLCPPrT2SMyYATR+JxodIPcNfIFp96DUqAen1YXWP
	bNf3wQEaptWldQ5V+RiGJOnl+wdsaINF5f97reyUyDAkeLICxfCSOC4ZHf1yDXBhwG54iqjsljJ
	UVtCzgxfH0TRskLGdRrJ3rUmu8WRRzBDSZBA+y/114kW8cWE6V3ycKmp55WPC2GYXHbj3B6QbTK
	9eXCiSkF7rL+LCcbUD+rkRPFVgEMN2HKB7Lq2yyoI2yW+yuLOkhm6pKJMh/+y/f9Z2oRCnt3rLw
	UtAra068fGJljrpXr9lTLSPiLU4F2JqhfIGmxLTo8Svh820iyStNw7rRyvKTlg/e4gNMQ7YlLEQ
	lA8xOYiT2Qr5wdVNn+6/Eyep3llyHjnqeSag7RgO6xFJ8MYqcQ01FeVXlIOkaFqvlm09CF8UVMq
	BmzN8JE9UEhRoa168T02saf2d5VLnSca/cNkfZtOWix3GxcQivwaoQ==
X-Received: by 2002:a05:7301:3c0b:b0:386:d466:51f1 with SMTP id 5a478bee46e88-386db4e2b51mr2342692eec.4.1795664280386;
        Wed, 25 Nov 2026 19:38:00 -0800 (PST)
Received: from [127.0.0.1] ([40.75.162.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm69306909eec.10.2026.11.25.19.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:37:59 -0800 (PST)
Message-Id: <pull.2331.git.1795664279088.gitgitgadget@gmail.com>
From: "Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 03:37:59 +0000
Subject: [PATCH] refs/debug: release the wrapped ref store
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Onur =?UTF-8?Q?G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>,
    =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

From: =?UTF-8?q?Onur=20G=C3=BCnd=C3=BCz?= <ogunduz@gmail.com>

The debug ref store owns both the wrapped store and a copy of its
backend descriptor. However, debug_release() only invokes the
wrapped backend's release callback. This leaves the wrapped store,
its gitdir and the copied descriptor allocated when the debug store
is freed.

Release the wrapped store through ref_store_release() to free its
gitdir as well as its backend-specific resources, then free the
store itself. Embed the copied backend descriptor in the debug
store so that it shares the wrapper's lifetime.

Add a test helper that reads HEAD through a repository's main ref
store and then clears the repository. Exercise it with tracing on
and off. With GIT_TRACE_REFS=1, the test fails under LeakSanitizer
without this fix for both the files and reftable backends.

Signed-off-by: Onur Gündüz <ogunduz@gmail.com>
---
    refs/debug: release the wrapped ref store

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2331%2Ftetsuo%2Fsubmit%2Frefs-debug-lifetime-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2331/tetsuo/submit/refs-debug-lifetime-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2331

 refs/debug.c               | 13 ++++++-------
 t/helper/test-repository.c | 19 ++++++++++++++++++-
 t/t1405-main-ref-store.sh  |  7 +++++++
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 639db0f26e..78d1eb5a98 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -8,6 +8,7 @@ static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
 struct debug_ref_store {
 	struct ref_store base;
 	struct ref_store *refs;
+	struct ref_storage_be backend;
 };
 
 extern struct ref_storage_be refs_be_debug;
@@ -15,27 +16,25 @@ extern struct ref_storage_be refs_be_debug;
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store)
 {
 	struct debug_ref_store *res;
-	struct ref_storage_be *be_copy;
 
 	if (!trace_want(&trace_refs)) {
 		return store;
 	}
 	res = xmalloc(sizeof(struct debug_ref_store));
-	be_copy = xmalloc(sizeof(*be_copy));
-	*be_copy = refs_be_debug;
-	/* we never deallocate backends, so safe to copy the pointer. */
-	be_copy->name = store->be->name;
+	res->backend = refs_be_debug;
+	res->backend.name = store->be->name;
 	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
 	res->refs = store;
 	base_ref_store_init((struct ref_store *)res, store->repo, gitdir,
-			    be_copy);
+			    &res->backend);
 	return (struct ref_store *)res;
 }
 
 static void debug_release(struct ref_store *refs)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
-	drefs->refs->be->release(drefs->refs);
+	ref_store_release(drefs->refs);
+	free(drefs->refs);
 	trace_printf_key(&trace_refs, "release\n");
 }
 
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 9ba94cdffa..6184db863f 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "object.h"
+#include "refs.h"
 #include "repository.h"
 #include "setup.h"
 #include "tree.h"
@@ -65,11 +66,27 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	repo_clear(&r);
 }
 
+static void test_ref_store(const char *gitdir)
+{
+	struct repository r;
+	struct object_id oid;
+
+	if (repo_init(&r, gitdir, NULL))
+		die("cannot open repository %s", gitdir);
+	if (refs_read_ref(get_main_ref_store(&r), "HEAD", &oid))
+		die("cannot read HEAD");
+	repo_clear(&r);
+}
+
 int cmd__repository(int argc, const char **argv)
 {
 	if (argc < 2)
 		die("must have at least 2 arguments");
-	if (!strcmp(argv[1], "parse_commit_in_graph")) {
+	if (!strcmp(argv[1], "ref-store")) {
+		if (argc != 3)
+			die("usage: test-tool repository ref-store <gitdir>");
+		test_ref_store(argv[2]);
+	} else if (!strcmp(argv[1], "parse_commit_in_graph")) {
 		struct object_id oid;
 		if (argc < 5)
 			die("not enough arguments");
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 6d8f401a2a..fca3b7415b 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -14,6 +14,13 @@ test_expect_success 'setup' '
 	test_commit one
 '
 
+for trace in 0 1
+do
+	test_expect_success "release main ref store with GIT_TRACE_REFS=$trace" '
+		GIT_TRACE_REFS=$trace test-tool repository ref-store .git
+	'
+done
+
 test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	$RUN create-symref FOO refs/heads/main nothing &&
 	echo refs/heads/main >expected &&

base-commit: 03b41523c576f26ad34085378717a0c1b287470f
-- 
gitgitgadget

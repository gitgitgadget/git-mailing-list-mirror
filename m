Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702614;
	b=an3cqdOW6BwRJymLGNkDwG1Kv7+kvReFimjxQyNSYodK31/tV4Np5hHY3VQgJVr+fWlR
	 z/K9d+wVh7xfGou+UyU3loptKkycWjDcCq2OPHIfS3r2PnIHpi6zDcCfNULeyxnWTxthd
	 IJyLWcSjAZ2IV+whUWVYBjs8l9c7mS4LrtWdVDx8v5UHu9zoP1laJZa5QBDyigN3RkS9T
	 ap3oexqaZc889y2d7HOFnHGdLSP98zhKvFswfkE3ftDH1Qvc/PsL+OQDg/swXdH48Uaix
	 P1/vIZVdYj1nLtmXVHI0m4WEZAgNYr/pWnZ9WZSkt+RyCKBl0fc2nEgRqrP3KJgTBGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sM+AoiCmyZsHcA0ZO4/Gm7UdjU0FjigF8UJrOVzyAqw=;
	b=e+glxzGGYznKxNgiMK93tpwRcOb4PXouEp1E5kb+mg74FAOxdSQcMR2Gxhq+UdWF4MXU
	 Ma21E57Md0HtiCnRNznjOsVFM8/n6mVMeLF5jPoc3Oey0PpaCOF7Xsirlp0XRPtSuq4hU
	 O6q0q7S7mxV1LtSgMmLHHTDbO3b0zzhIwIvh+ffUwNkMrFhdzg+5YWTJHTNTN0P41Kmnr
	 B1jjrhFlXmbuc1lBC36Jrr/nRycItR3NTUmInYRrG3IRkO0Zw0gQENqRLZT3EAm6oI5Pw
	 1SCZHRvR972lQkmrcJNE/rv7DwX41DvkgeM7FOkMa6Gh9js7OKhigyjQAXWHANDBMqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aprhXTp9;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C2606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8C2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aprhXTp9
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso38209105e9.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702612; x=1796307412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sM+AoiCmyZsHcA0ZO4/Gm7UdjU0FjigF8UJrOVzyAqw=;
        b=aprhXTp9GeNlzGtXbMt9qOcRGlreYdeXbrk4T70ezzsQ3QD9ppN8FWStlGUHbg91sz
         U7nQ8MG9MQ7Ic/LeJmxp2hqZM2uq3R6tZwLv531y8zoTmgVHeUKzw33MXJdxZNMU8k5D
         Yxyy/rD8NA190dWQMPe3PWB24Qz5qn3znPM+HVRIeYjushP5bNCVkhkeiShrv7fAoIvA
         5wbUSgTZM35fqXRE7MUiOFcjLfUOvUDevQeVrtipUKJiUegtAb0/oByJKEZyTsOS7ZXC
         jmPoLFH2NFyX+2DdK9fN9WcSlqfsIDqMM9kNteIMsT+KVrqfuk7fRstTmV5gx1uHmA5R
         YfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702612; x=1796307412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sM+AoiCmyZsHcA0ZO4/Gm7UdjU0FjigF8UJrOVzyAqw=;
        b=oyt0qhJcgYfJjY1FfBtaAp8scYsCGNIoe7X7GuxLvPDG+mynhimq0izzQl7ilLeZmc
         lAEzM8NAFIb9vSuH3XEdkU4V9W/AljgV9LAUZalzKcdK3oSk0gvODPiF79Au4EdbKzUR
         8GnsoU+Ft42d2qFl2CV96lzSdxqhV9srBRNcQJyJbjVfIUwBAZsugeceslrM/vAQBx8D
         /xXxUcjl9Nwblr+D/rDoFnFaZJ5z+z3jzwyKOLk5Witvz9Wp071A+xRgkEqOxpOQA5Hm
         RCWYyuOIhcliObbQe4Rwi7Ne8rci7uaB0nmRiya1ZT4hDp+Bot08SKZn1/cOzufrqeb5
         z2sQ==
X-Gm-Message-State: APuU4Z+xamfLxzCjLo0zz0Wf5ye08mIpe4D1gp6dTVeePSGZP5JLt8sL
	Bs9UZAZ8pc6k5O9c1g5MrA1XwXzQhgy3SdZB/oSgvWvPGZuu6QjP+h36CUPSjg==
X-Gm-Gg: AZFdTZcCE2LXg3vT2fMzymdpGjiglcsSu+jdXmmnbFZ+WRn96QfxRbfVFKMp0Incxxt
	QLLM3fA9Up4ymp3zc10wmSPSys2k/DgCAthsMFtwFvQTqVYW/8mTK39aRK7Vq/iNF5qgLhAYAr+
	QdIFq48o5aQ7Sr31O9fRgl2c7koRWV5R+emXKYwHjuH4o15YbeQxsPTJnzsXXDwwux63I4z2zuI
	IDa7q6SFBiOxuT/ZoAFUKdQjZTv0XE4xjI7mraq9WPCsOrhWxklUqBILQQne/9CZoVBd8ewV614
	63TL559ECIjQ9Xd7qZ0IbpBzqlGrWz6MLLFhUJmxl0oXXdGzUiL6h5yN0/i/hsO4cmtBdz+AnHN
	wkT274r4hDhXxuV/K28FQShn1AYJacXb0LJHbT4l06bDsCa7vZgfKMTXwJAxGETTtqBOpss2RuP
	WmWgsHWSVbEykux0w8Hn1QFi5gWhYkD5caG1k+gHlCC8evtL9rrmuGJ68U3DHzbAxe+U6Qs9aYR
	hDf80zxCFKoRVT2rlPXB92MnPi+Fg5/9fyY23Y2WCuLOlcL+5Ynzk8o8UZrWVk5g7D1rxcwTft6
	v1iOjk0Zwn5Okb8bVpP7Qeq4zS5iTLu3jaF3Eohu4EP08diNv8t8CLY5ZWZFOCl68JuvE1ySIv2
	sAJ5Xp2NGYHzMOq7t62NdfPviMbdqU5lELZWZ1XyeJu0f+rnCEdz1Uh3FFpJKH/TP1R0bLcLTHI
	EnPgN0vh3hZBm6ZAtQm+Gwg/X2IgmB0kXB5VAVoUqBKzOJ8ovFMBH6W01fIRla+w==
X-Received: by 2002:a05:600c:1d09:b0:4bb:6b59:aac3 with SMTP id 5b1f17b1804b1-4bb88816050mr445900805e9.29.1795702611987;
        Thu, 26 Nov 2026 06:16:51 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b8e564e39asm10127999f8f.57.2026.11.26.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:16:49 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/2] promisor-remote: fix crash without a repository
Date: Thu, 26 Nov 2026 15:16:29 +0100
Message-ID: <20261126141626.914848-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.472.g808159e44e.dirty
In-Reply-To: <20261126141626.914848-4-christian.couder@gmail.com>
References: <20261113000600.202744-2-christian.couder@gmail.com>
 <20261126141626.914848-4-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `git ls-remote` is run outside a repo with some promisor remote
related config options that make it write to its config, namely:

  - "promisor.acceptFromServerUrl", which makes it auto-create a
    remote, or
  - "promisor.acceptFromServer" with "promisor.storeFields", which
    makes it store fields,

it crashes in configure_auto_promisor_remote() or store_one_field(), as
the `repo` argument passed to these functions has its `gitdir` member
set to NULL.

This has been happening since 3e20258d11 (promisor-remote: allow a
client to store fields, 2026-02-16) for the `storeFields` case, and
since 7a56394fc6 (promisor-remote: auto-configure unknown remotes,
2026-05-27) for the auto-creation case.

Note that `git ls-remote` seems to be the only command that can run
outside a repo and still process the "promisor-remote" capability
advertised by the server, as sending the `ls-refs` protocol v2
command makes it call send_capabilities(), which processes that
advertisement.

Let's fix that by checking, at the beginning of
promisor_remote_reply(), if the repository it is passed is NULL or
has its `gitdir` member set to NULL, and by returning right away
without accepting any promisor remote in that case.

It doesn't make sense to further process the promisor remote
advertisement there, as `git ls-remote` currently has no use for
promisor remotes anyway. And not replying is fine, as
gitprotocol-v2(5) says that if the client doesn't want to use any
promisor remote the server advertised, it shouldn't advertise the
"promisor-remote" capability at all in its reply.

Checking for a NULL repository isn't needed yet, as all the callers
currently pass `the_repository`, but it will make it possible for
callers to just pass NULL when they are not in a repository, once
the call chains leading to promisor_remote_reply() stop using
`the_repository`. This would avoid having to check whether the
repository passed is a real one.

While at it, let's document the behavior when `repo` is NULL or not
a real repository in "promisor-remote.h", and let's add tests in
t5710 for both cases where a crash happened.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 promisor-remote.c                     | 11 ++++++++++
 promisor-remote.h                     | 12 +++++++----
 t/t5710-promisor-remote-capability.sh | 31 +++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 85adb66c80..b37ec23a3f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1379,6 +1379,17 @@ void promisor_remote_reply(struct repository *repo,
 {
 	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 
+	/*
+	 * We can be called outside a repository, for example by
+	 * "git ls-remote", which has no use for promisor remotes.
+	 * Not replying is fine then (see gitprotocol-v2(5)).
+	 */
+	if (!repo || !repo->gitdir) {
+		if (accepted_out)
+			*accepted_out = NULL;
+		return;
+	}
+
 	filter_promisor_remote(repo, &accepted_remotes, info);
 
 	if (accepted_out) {
diff --git a/promisor-remote.h b/promisor-remote.h
index 198fe768e5..2811950d48 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -60,10 +60,14 @@ char *promisor_remote_info(struct repository *repo);
 /*
  * Prepare a reply to a "promisor-remote" advertisement from a server.
  * Check the value of "promisor.acceptfromserver" and maybe the
- * configured promisor remotes, if any, to prepare the reply. If the
- * `accepted_out` argument is not NULL, it is set to either NULL or to
- * the names of the accepted promisor remotes separated by ';' if
- * any. See gitprotocol-v2(5).
+ * configured promisor remotes, if any, to prepare the reply.
+ *
+ * If the `accepted_out` argument is not NULL, it is set to either
+ * NULL or to the names of the accepted promisor remotes separated by
+ * ';' if any. See gitprotocol-v2(5).
+ *
+ * `repo` may be NULL, or not a real repository, and in that case
+ * nothing is accepted and `*accepted_out` is set to NULL.
  */
 void promisor_remote_reply(struct repository *repo,
 			   const char *info,
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 463e9e00b0..50a73ec8b0 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -813,6 +813,37 @@ test_expect_success "clone with invalid promisor.acceptFromServerUrl" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "ls-remote without a repo doesn't auto-configure" '
+	git -C server config promisor.advertise true &&
+
+	nongit git -c promisor.acceptFromServerUrl="$ENCODED_TRASH_DIRECTORY_URL/*" \
+		ls-remote "$TRASH_DIRECTORY_URL/server" >out 2>&1 &&
+
+	# Refs are properly listed
+	test_grep "refs/heads/" out &&
+
+	# No remote is configured
+	test_grep ! "Auto-creating" out
+'
+
+test_expect_success "ls-remote without a repo doesn't store fields" '
+	git -C server config promisor.advertise true &&
+	test_config -C server promisor.sendFields token &&
+	test_config -C server remote.lop.token "fooBar" &&
+
+	nongit git -c promisor.acceptFromServer=All \
+		-c promisor.storeFields=token \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		ls-remote "$TRASH_DIRECTORY_URL/server" >out 2>&1 &&
+
+	# Refs are properly listed
+	test_grep "refs/heads/" out &&
+
+	# No field is stored
+	test_grep ! "Storing new token" out
+'
+
 test_expect_success "clone with promisor.sendFields" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.56.0


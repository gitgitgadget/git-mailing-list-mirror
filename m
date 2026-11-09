Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251104;
	b=VOYE7qzb29G+AXtss51IWdoN4bAIcR9UWTXtyV/7+affcRaSzKPotFyV72dMRWbFt9qx
	 +8WZpdT3krtfd+aiFaytp38/138YKhaaJBovYGPC07ikWzCIwgCqCTCdwip2nyhuuXWBt
	 6miDmTr5P7o9erzWnYMV+YcPeXc5FjMlGXgaUWC9CXgmeSIpqOBQQ2ITs8BnDFfh/FFIs
	 sKT+sID5K66IvMfKlfdgn/SlRVMMtdu4S6yzYNtaOCGAo8zcqbp/BkFWlSM+RKqbc3aez
	 9nJnA7mofInv+uqgk2Ljvh9BqDZJcWP2cN9ATBUFjhHgtrq2QSgp5gEEaXf9uaxHfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
	b=4lw4cELpdRW99Igmyt0Xvyne9MKewcHVSWz2qu6/6U+Ex+tOcC0v5D2hpRn3xNNuswwW
	 bXC8pdDsb8GkDkY6CdSqsw9mUHPmGE8I8DChab45pic9meCQuxttS7Z5KHUI0A8meeVJw
	 JVYz9WI4wLqu/Xk6nCir0UtaZFvbrBDyPJNDUJBzJxjp12pU6Ky9Yv9IPsTRkEOAnrP4A
	 99uaHEtVbwGwYS9qf2zto+EwVi00WWRegIYcTIM+0I7m0KPqs8wW91jw0JiPhzwaxju9/
	 3EwPhENpWQNPvCuLFBoEu9B7QYykxmCqjtthHg3uiiwMseuYKoylbtaw2DLn95hj6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAdubgjc;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272460A3823
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5272460A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAdubgjc
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3704d30b84fso1576625eec.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 11:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794251103; x=1794855903; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=vAdubgjcjHheIx8vdeW/mHh7JRvOMsh+Ec/3VZPWgOmEsNWFEZ64HuwZxAA2kgA5Wu
         LiCeEi1tkI88KeqkG+S+NRPvZsjg6ArUISj7HafdhrVymRcgBK13q8Gy/XpJCASErh0Z
         92whb4faYUl39N0JiCCO7HfULrP770wr2Fv+Tzk5bXFhAkMpI0RhjEkPmZYReDnKDexn
         pCX7TAtGrLWIORQuiWvlWv46iI1FeBqxDcR9jE4uvtq++bJ+oJd1MRitxxUGOsn/la9P
         XV4rhPfEheAd0Dl+hakgLefgM5W5Tz3/MkM/BAHxCtLSW7taE5XkxLV8bSgrH3H73XkO
         Bxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251103; x=1794855903;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=Qfztr/M9cs/bTT7TtZpYIaZNyEs8DLMu+ZahnSyRuLby3PmkmBbkvyQvz+OiD9Z01W
         3uDm8lAfE1Pyao0yXW6F7kn5mDxHJznit7S1bszLxPgd/9m+Za94sE+7aoBqgWKcnuoq
         Usa/ylYyuBa9zccGCj3JMy5AvGG20B73b+qOtKKFF7Gsp0WWSHvd9xFBV7EM0UepJ0QM
         +DxvoewyXW5kM+bCQnqnOPGDAJ/uNlK1MoaVj0cHnhTs3djK5g2PALtPOmWBQaCQc7s/
         Rxg5TxvmSKDjwZHwH7Yeah4L5Xr65mxCTiW8n8n+5FFyoDZdf2rN2yrCi+KNtlPba9W/
         /cdA==
X-Gm-Message-State: APuU4Z/J0nvn7VhcHQc1H9m8T5oI7PURefHH3lIPMYob+pkL4Nd9KqiI
	+fLU/uqq8Cd33qL/ABWID6zudqu2MwqqnUWSPfprQphRWFwTMEzxafF6O87qmA==
X-Gm-Gg: AYBFou0Ec0JPdOTQR7+llb0p5+vBn2T2QyW9voNcbmxXRPDQ8481XG6TwMloiUwYYrL
	beA9AfMuJsvQWPas1VNurMPD83KBzNlI/wArt0o2RsqHfa4BaNbETIbwLdbwROO+Gl3esDyLx7T
	Zs86aUFx3AGxWDlJEn9l8OtOwCnrdZNkz9kYTjn9V8588YXZk75EmZthkaHNs7JfycWJ/axiLjw
	tVFGdVtreREGGv0smn6Y/byjAWW6kuOAdFlOLhIemhZtUA24KLq4PQgrKdrM4oKaySGdd0MKM/1
	n6dBxTx5vj3Vb0IvFVzEkqmdxePw6tv9CPNldRIpyh1wuPYf34uGFUkxLMvq87x8cZpa3Ef11jQ
	Uno8CoeW3jqnKIXN9RIX7JfVH826NNJ+b5MSu5lyzMu/kipxyR0jzsJIId2W0jUWti0ZCwV58wf
	nSdiAUeEPXk+9TNan11pmRlDTijtCQDW6vm0591y9IvwgeDMERDA5ajPoq486VIPVFVz0P5ClMw
	3U38+puxXw3uiuYg20XfRnTER7G6e9X+MJdkkP5RB13lgOxweCbddt+TMC6CuDZ3R9RDsmZkW+L
	a/eR947ezN9Akj5gfq1SIkng1rSD12M=
X-Received: by 2002:a05:7301:d185:b0:369:f035:661 with SMTP id 5a478bee46e88-3751f07961fmr203837eec.15.1794251103231;
        Mon, 09 Nov 2026 11:05:03 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm313629eec.5.2026.11.09.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:05:02 -0800 (PST)
Message-Id: <01c3cc25738c43d61aff153805e02db872ff21de.1794251100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 19:04:59 +0000
Subject: [PATCH 1/2] submodule: use the submodule repository to abbreviate
 commits
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

The commit IDs shown in a submodule diff header belong to the
submodule's object database. However, strbuf_add_unique_abbrev()
uses the_repository, so it checks the superproject's object
database when abbreviating those IDs.

Use the submodule repository when it is available, and fall back
to the repository from the diff options when it is not.

As the expected abbreviation depends on the hash algorithm used,
the test uses the test_oid mechanism to switch the expectation
between SHA-1 and SHA-256 repositories.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6fcb606f7e..1302c11ddf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_options *o,
 		struct commit **left, struct commit **right,
 		struct commit_list **merge_bases)
 {
+	struct repository *repo = sub ? sub : o->repo;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
@@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_options *o,
 
 output_header:
 	strbuf_addf(&sb, "Submodule %s ", path);
-	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
+	strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
 	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
-	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
+	strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
 	if (message)
 		strbuf_addf(&sb, " %s\n", message);
 	else
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 4dd4954260..4539d6bba5 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -14,6 +14,29 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'submodule commit abbreviation uses submodule object database' '
+	test_oid_cache <<-EOF &&
+	submodule_commit1_abbrev sha1:0000000000e
+	submodule_commit1_abbrev sha256:24c81a5
+	EOF
+	test_when_finished "rm -rf collision-super" &&
+	git init -q collision-super &&
+	git init -q collision-super/sm1 &&
+	printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n\nb1rwzyc3\n" >collision-super/sm1/a0blgqsjc &&
+	git -C collision-super/sm1 add a0blgqsjc &&
+	tree=$(git -C collision-super/sm1 write-tree) &&
+	commit1=$(GIT_AUTHOR_DATE="1112911993 -0700" GIT_COMMITTER_DATE="1112911993 -0700" git -C collision-super/sm1 commit-tree "$tree" -m a2onsxbvj) &&
+	commit2=$(printf "child\n" | GIT_AUTHOR_DATE="1112912053 -0700" GIT_COMMITTER_DATE="1112912053 -0700" git -C collision-super/sm1 commit-tree "$tree" -p "$commit1") &&
+	git -C collision-super/sm1 checkout -q "$commit2" &&
+	git -C collision-super update-index --add --cacheinfo 160000,"$commit1",sm1 &&
+	git -C collision-super commit -q -m "Add submodule" &&
+	git -C collision-super diff --submodule=log >actual &&
+	printf "Submodule sm1 %s..%s:\n  > child\n" \
+		"$(test_oid submodule_commit1_abbrev)" \
+		"$(git -C collision-super/sm1 rev-parse --short "$commit2")" >expected &&
+	test_cmp expected actual
+'
+
 # Test non-UTF-8 encoding in case iconv is available.
 if test_have_prereq ICONV
 then
-- 
gitgitgadget


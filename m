Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821557;
	b=0AN8v/vL3v+BC57wNgWK5faT556yMooCan/TzTkTE7wo1t9+9aAs6dJiIHEvoxRe9WRr
	 1bA0JXyQVN6iwFS+9GBrMbtmOgishsGoIopBMWt/FkMHHTwS4lRRMgHyEjfkjDF8N0PHf
	 SDOEpRo3KUGIU97aN38XBR6q6kbSkyYzQTqfQ3t9zUNPzB3U1VoaemArl1XWCcwhlCJX3
	 bPtCJHbeP4t+Woh8HAKFdghn5OIf0l2ATh53GXUgybx9pBMOInqwxgnteH820ABQgSxIi
	 GqJ5tOv6wJ5zxCet8lJc9r/qWjA0ZaCeb1dx6VSf22+FO4M/5TFLq0c9xgZWZNvIWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=5kEy2sRkzvwB9wALfvRuAM9/g0odidxGH66nLtWyh34=;
	b=wR0x2/qa7IyX1CILEvgMGzO0VuBvA7PdlTpbc6yr8ms1Dyeg7qxE97Bol1QJfRS1Y40A
	 0wyZGPMJafqIG+KqdUrOPk/12IZsKM5UrAJT96Xd43lC35Xbg4++lvU8M6UAjin/xW4Tl
	 ISZRC8bbNU/8366Z/UOW7TQKfCUxbmRXv1y+qtnEd+X46LZqai66Vuo/eespkUf6dGpDR
	 cqypdz2raPSgoXOoreLlHk5pqtZmFOo5MCgt75CwyYmG5sK5MTRVBYpWV0UuZT3NyvYmr
	 Nqt6kKbsErM+fQky6ZIRXMCH8UdwBnVBTNXgXKXhgvFhuuhkdFRCvYBQneQBJlImVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NfXOXw0N;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E60608BC54
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03E60608BC54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NfXOXw0N
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-85a6c747dc9so1330695a34.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821556; x=1794426356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5kEy2sRkzvwB9wALfvRuAM9/g0odidxGH66nLtWyh34=;
        b=NfXOXw0NIqe5Geyt6O2X1QP4rbhiKlzDtGOCosBX1DIF/T389enOleES5/9INCKmfq
         Olvjy+GnZUIiIcNsgd/jvTb3P+i6dFEN4L/S5vwd3Id7XSaAUhgkaH69N6tVNqvtETC7
         pwrnHRU3qfyJUZL3pntRYCmDwXrAaZ9NpWOZuzlMd2k3Fki/ZCAjCoL9T0sCWI0OpNBm
         3awlqvj8Z9jMq4Ct5sGM88RuIyOkO8ua50zsajfbye/gSR4vgwTqgFE/YYAak7KP134R
         eRz9+xbjwnloQ68/lkTYHkrhYkXzicD+benqtbh3cf9mjlX8YqPiMAwr5DnDRZ5gExDl
         f/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821556; x=1794426356;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kEy2sRkzvwB9wALfvRuAM9/g0odidxGH66nLtWyh34=;
        b=kEOjngI4TPHqDC0Oi81pVtTHAZro47eu9uHkRdOHutiCBGefCL5D5DWKXjlXBkwJOW
         NAn2neoi24v9979MvnxVeE4tG+IbAUKIm9W9CBjRW86MXysC+aAColOwM6HgbXZHtpFP
         bTub/EVObAo93y0zJfhfaL1/MwXI7+AR2awrb1SuvuKymKGcMQIX+gwATORGPUNmd/r+
         t3EWJaHc6d6tNlZ90WDBaqlI5gQlSivuF5fxBsKElt4eNF90dV0xw6bdZ8iIu279l4wi
         GwFTWGRBlXyHG7iPTDpoHiWmX6tZ1UV9uJrnZa45TZeJBHFvbH715I5PJSbes287tKdP
         OnJA==
X-Gm-Message-State: APuU4Z84Gm873B80S1tEVFCcQbeUGY+k8D5KcRwqp1AVccD6ShNxQtte
	pQ2dUcVlEoHXZ/Zuu9NU/BIPkEhdCkI8b3tbTF8nVD4Xg5RFvA3fEI0zwwBkN8JJPCI=
X-Gm-Gg: AYBFou2qMGzunsZtORph4p6XcsZ13cyTlcme3nmsBtVHQcgJ1/EwjOhRrso0ts500Cn
	01jIlWjYGE9kgDRQvVtQP93i8Zo6MlS6hTpOIkfjGYxKKpiD90Qb2rEeFcFnE6dGmMZklsfGXAp
	WjT1t/RtmayzxNy05BrwUfxbzqAWpkSQ0qyGvZINxT9rf3tEqcWw7STqFXDF55/iJa8NYNrEV50
	fohUGB5nbBRe1eecz+hH9zkuqNNLys2dwBAjrJjnQKf9IUPEuvQn0JxaeUnAopDBZELZ6C8+O1O
	8YzTpOgNmM0UVMA2H6pxRTfF0YiOMrP5AVQuKIFmvVQq1vPT64nNHPo9rUbMRjdPR9ngzNmj9VF
	DFJAg9IhYop7Wvrc6dWUA5cHdQJQUwKbwEkjdpqAEznp2v7agWg0QdFkygPp9Y0C+s+joAFQbRh
	P47uOSxrbGr7rV2cJa9Ro0KdKKoMrWgPZMx2iTWpyJEuS+OzTvCh3nCGIoutAKJeaufGtbJoQdO
	9Cjuv5hnLG+LrC4izwaJ0/CKckTN4Sczkv8ieRFI7/xeNhmhkDZgoF0f6W0IuJq4lmDzrVk0K2F
	KY6tRYVIDAcz/y6SyEWUrg6kSrPrPlG6hh4=
X-Received: by 2002:a05:6808:2396:b0:544:9281:a3a9 with SMTP id 5614622812f47-567be32f67amr311744b6e.19.1793821555995;
        Wed, 04 Nov 2026 11:45:55 -0800 (PST)
Received: from [127.0.0.1] ([172.212.167.170])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm2420340b6e.5.2026.11.04.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:54 -0800 (PST)
Message-Id: <pull.2288.v6.git.1793821554097.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 19:45:54 +0000
Subject: [PATCH v6] submodule: use the submodule repository to abbreviate
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
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
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
    [Outreachy PATCH] t4041: use submodule repository for commit
    abbreviations
    
    Changes since v4:
    
     * Combine the implementation and SHA-256 test updates into a single
       patch.
     * Update the commit message to explain how the test uses test_oid to
       switch expectations between SHA-1 and SHA-256 repositories.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

Range-diff vs v5:

 1:  f94aa2476f ! 1:  01c3cc2573 submodule: use the submodule repository to abbreviate commits
     @@ Commit message
          Use the submodule repository when it is available, and fall back
          to the repository from the diff options when it is not.
      
     -    The expected abbreviation for a submodule commit depends on the
     -    repository's hash algorithm. Use test_oid_cache to provide the
     -    expected value for each algorithm and remove the SHA1 prerequisite
     -    so this test runs with both SHA-1 and SHA-256.
     +    As the expected abbreviation depends on the hash algorithm used,
     +    the test uses the test_oid mechanism to switch the expectation
     +    between SHA-1 and SHA-256 repositories.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


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

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
gitgitgadget

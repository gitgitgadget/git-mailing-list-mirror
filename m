Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290606;
	b=shd701JwBYSfp4cMQB4AHwgtpuAKPL8wNCix1rIFWC4VtuySWvvdC7t2cn4PHSILmNUP
	 UonGbIsGF4crxfv0FzrXtCjzZzUHov5lXWClIh3e5nXcxSFp5Nt44PLHfO2F1EJxMeS4v
	 wq2km3S7eS4Ysz0qdhNFnKAjqHKpvsKNxguzISfXA/WWK3BKqhg/bssjjyyZXsy7BnwuA
	 Wc7zK291U1T192SFlsWrxvUfbchaxuIRmt63T0iJE9SPi27kAOtkY79ZQiY5E01j6oQW7
	 u71qvVMveTNKPv7maoXQVRyFeXWBj0Lw2UlBin0L06i0cns009AU00fPLM9Q/N3cZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
	b=MMmZ2rnDPtYcaVMVQeEl767q/ItfqEdAmf9+W1gs1LpUhGpo3LfpkyR7lVTPVIicZjlg
	 l8JmsW6mBMDGijTTi0qNm2z6tYfmcHsx9tjClmRwBe1FLfMP7Fe0t6fIOzINCds1bF0Wr
	 nj8Z5al7ekXOSjZBm0z8pcFlmrksPLoWepKPVLbDofo6nDILVS6bcRJfPKnyNtTV1Ne5t
	 FSTpKor1FkvVlQzvmgowrUvKwLBQX70Xn9C96lIf2RU8emYuNlLa1zIIpvW3lJIghiLAl
	 eTLNhvpOMWYjkIJovFRSRCfTnUC5s2eJ5pBSrbaslISemchEMb3OvngupfCwjegxHxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPUnBYhL;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD6606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABD6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPUnBYhL
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8490a7d6696so919920a34.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 22:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794290604; x=1794895404; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=mPUnBYhLLe0I8YyzxdfHsi2yh8wueQiWUY9GaqUk23x5omA543hb3q7jeQhcxYH3nH
         knYkJKyMKpyoFYPcBlRk4sIcml2Aq4LxWnEQhz9CXVGiD+yzFB4/B02XhN1Av41uXogy
         EWvmOn/YgrSsvdGqcHYibLcLabJylav9lz4aaEV54l4KoOjiRs/VXpwMOfC6MS2BNQZV
         2njnSPnKr8M3Nt5Ng1bezIHDgjMLrXfrfQ6I6ky/y0ak/Ie+ibnAZH9nQHx+ST0AtGZg
         kzLX0zmXlNG3cOxfT/ygtbpgZSb+DlJQcKmBSSkZwooK99Ek0WP13J6goapB97f4rPZu
         p8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794290604; x=1794895404;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=lyFLHbrdKFOTkix9+LrBMLQKjOmEI+6W/+0VcMlv8sh4gu2x8F2wMg8vbABUHX5dK9
         b5k/8pqmka+RctANcnzJ1zgmiQwIp71LksQFcX2I1BEaNesyNqIzCtE6JkBdxy5GbsTs
         HFC7P94VXS6LkcInttGBZQGY2FJSyNtrNnmvrpj9b6gVefn5VBqX5r4vk5Qq+WzrOyHj
         ttjalE3y26m8VUHaxQ8cCZXL6jOU0ZkaOOdO36AHGUVGc0ia5w3E8ppV/h+V0mK5JZ1x
         AU1wIg3nofTuCfNstlg5KNp3Hc48AtqyTQ/FXuqIyLs2fQoXwErGU1F8Wa3JA0sdNvbx
         cddg==
X-Gm-Message-State: APuU4Z8SAq8+/5tqsErsLT81gPOygK274vECZoU7cKjztAn8Gr2+Czd0
	uiZPNiR7zZ41orlT/IEJjVuY9P8MylYYm5N+TgptZ+mBMnh6/YQ2hTuBf8hDtFAz
X-Gm-Gg: AYBFou0kDSl/9y7z2ckCDP8MV13GzXQFF231BacPgRhPj6pZpMU89YKMVvl+/kJzFax
	bWdRovzNOL7x3H3YdaFhuVhw7yBoA3nnrCLKnbNT4vLDnIzXGPlHPYr3YYG0F9Gd8WAB+PNLdZg
	aUIJHh4UM/rskEJMC2uZYVuTks0GHWzZSlaqOFyxt91hyH4RdXEHCsr25Hvf7YuxhfzUnw1xaT6
	P7hrS4r7xoGHkwUtU+UJ8l0aFKM0m7E/TTq+avWoZr4yUAgenPkBnpG+finCOmQrhBWHRCtU6lJ
	jzq5SmTdRmRi0c/LCzTu5KzEzsmCfMwozwqnThEQpfKuxaqBbFZm3odXjB/t2LCAroxp9vcZOqL
	INu9Yl3KExBKh4e1kR8vBQdPhGPN/V38hhRbkVeWkoLDFV+ma0zmMS8PUXJyORZllHBH/NA+QlP
	JamqM2VwGWG06gJD8l4KZnLLj9LT4Wyf/koKdSsQB9Qe91lBNez/TbJOCQS9z1jKXoojOd9MUon
	1kzKgC1xiy8KvJLskHOMbH9eeoMcQcacGjjvLo12wBUH/NYV9a0QqAj7Fo5YSLTFyQMqbBr1m4F
	mebEJXUcT+D990JPGjWeyoj3u4y2/Eni
X-Received: by 2002:a05:6830:719b:b0:85e:f911:5527 with SMTP id 46e09a7af769-860dc7005a3mr1168518a34.9.1794290603974;
        Mon, 09 Nov 2026 22:03:23 -0800 (PST)
Received: from [127.0.0.1] ([20.83.54.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm1232821a34.6.2026.11.09.22.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:03:22 -0800 (PST)
Message-Id: <01c3cc25738c43d61aff153805e02db872ff21de.1794290598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 06:03:17 +0000
Subject: [PATCH v2 1/2] submodule: use the submodule repository to abbreviate
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


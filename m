Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335974;
	b=Sap8lv3olIHEpW1KcLd1d64Ym1RcdBi1xaD9dR4c9q9InFZXx1fdHo57s1t47pgJcSH3
	 occDJy7pkvvlOwYbf7+zMTyIriakrhAqSYyzVC7hmmw/6qhLv2FjFBeMhfH/Qid/nCkHg
	 s51WuqJ4TJy0nXKIS7AxhSaa/lpb0ctSDtULCAbyzSa1FQcm27eGarA6NcLGR0qXZzNje
	 OphkJ04YcF0yARxnauzJpgoMng4h7knpxtrZp5wX6Ioz50hXRH60PmdoPY6AQpTc9EGDf
	 kfme9NAjwYTfXbLAAdzsQCCHnUB5jK/lAjvV9ABDSbdqH74qK1Dq12K+MxuCLPdCvqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
	b=ArlUUQQlRkAqQNQZrjnv8s5wDjFVvjJDD0826EaCwBCImmwpkyV0tQlMhsABlw6//0kd
	 dER1WO2OSYtjQt8zpInZ0mholWHYuoF7yMlbRbLsmmZTrteutB3D84gaHVLc3KT3qsARG
	 HH08P6fX4+1ENSRMPviBtgVN/70lMdFxiRH8JeMhDqQ0Pk+Fz+OYf5GPqWMMtpHZy7Vb4
	 My9plY+czGcamyjpF7sIctgwF/ikbUEFMKqU9wu6+vexzV1EpPw5rga8oFUj0w3W6QTQX
	 KWG8j1Q8HKmOK/xWQ1CTP7IQQcdWhZV2SvZIadfvykAjvvLwjZbdWJPkJf1YZR/JO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ty5qtFa9;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E660A2619
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028E660A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ty5qtFa9
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-37000e7234bso4392507eec.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335973; x=1794940773; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=Ty5qtFa9FeQICS1uj1b7DYB5lt0Qbmh73pbMayoMWNH7knrZp1HffdspdhLkcPaD1E
         AVk1/NmX+52vPbgnHk0dVzwHhOk6IMmSl/JAV3y+S1L2Ew1UVpEUvKY8+tljqP0MVtSY
         met7Z/A+eX1iIO6obtVKhARsBwUmj9AQA84kkY1AX4yVltoIIdnM3BRTuauWexnr7a54
         P+6T6RkUANtnsZgV6NDQxj5KrjXAGb8MpQEwrgTrnT7ctR9WZUJDitdIjOrZ9uqy7Nia
         7w4go87Iifv0JjYl+JlJ0VNRbdkSr8+17T0zMz+9FRw+JEz9LP4PlZ5JpOpeKLW40KZf
         +KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335973; x=1794940773;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhBmTfAbxV/m8Ae6MpVKaCXe5Xz1VX8IEvBrOUQ/31A=;
        b=cPIpQVnbFmn0AJ/3bXrhtVnJzfpxY3t4IuM0zFi2nqc7Ndu7SXt7tN5zE/jmYfPb2D
         hhQVsB1rl7KndQdVaiozSUgB5XGTZ5MwwWqsC3An/WIcdhTMqWUwTfmDsnwycbGwq7TB
         +RZh/voIhw4Xl3/51VzBWjUcKQlo1TdvVwVdo3yJQpvmyu8FWOHUQt+ycTwHvXsQL1rq
         SoTHmHbx/kDZPqx7LXokBgSrxV6xEuWJ1lfLruqoWi/x4GV/5FMpoCAkCwnoQjwozcyN
         w1X/yEo9dHdZJOfE+9GS2NG8x+4flcNq/ZfPIsulwctxkyo2xDMy2RMaJYwSNJ5oTPZO
         lUiw==
X-Gm-Message-State: APuU4Z/YsiueeBHR95EZXEzIHKhmZx1IV2Wr27DW9En8AE3JkRUkjVBt
	Qfg48NJItGoy6Rv5Tu2xVsCHPNFemUrVT61epDFpPBJCJHrsMh5khnBVs6pFupCs
X-Gm-Gg: AYBFou1cQnMb3vX6Eib6D9f0L5xy1luY9AAcT0XRBqNsGG1MI4f0K3vHLt3E8xO9SdI
	oDqxm2J9qC8RJqKBTCOcAl3snsf2KyfRRvbcCHOA85aRtihdGR2YdLzw3of6UOpnxhdzU4iIZhE
	25lw2CrjOtUt0lcBwPL2U6hePhwOzgAUkphl/H2B2NJnT0TSb9YXuF08jscPErkk4a3HdzboFJy
	NfGys7elgvczqc255Hp/YN8HcD39+M86INvXSwmVoBbRS4DWR2W3GdOBtSm/QB+2c47tK3Fg/MX
	0PR3xBtIZq+hKf/oQUm/QM6oJVwIDymjGz3YuBkSeQWHR58b81+rfHpqy0IhVQ/cd0WR+V2wh7F
	UmvcSBvj7RDe+kZkll8Io7vapGqY1VdTahsoMXushfVfilW6SP4qLc3XShXoqquLf0yPZ7M681u
	LmDSRZEBxVrTl0VUUvm12JTVfDfdrt1ykL9LRY97CVXI3XJXK1SsNGyeLI9dtWjBXr+jCh8wtUP
	rdsxZqJow8J904FNkcCJ5tkAXu9XeZ5sbv0/M8RKN9kLnU0picDKU4A4tyM97TeZpzU4x50ONtj
	njZgKVRLpBgWloiPUJPfqmDKCYFXnTs=
X-Received: by 2002:a05:7023:a87:b0:1ac:d029:70b5 with SMTP id a92af1059eb24-1b3bf16815dmr278809c88.33.1794335972646;
        Tue, 10 Nov 2026 10:39:32 -0800 (PST)
Received: from [127.0.0.1] ([20.171.32.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm12055089c88.5.2026.11.10.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:39:31 -0800 (PST)
Message-Id: <01c3cc25738c43d61aff153805e02db872ff21de.1794335969.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 18:39:28 +0000
Subject: [PATCH v3 1/2] submodule: use the submodule repository to abbreviate
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


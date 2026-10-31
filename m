Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474660;
	b=Ut1SFBG6eCJysoHyxcjock+CrcGLnWj05HmGifsixyCyIt2eBFA4hAfEX/NrSst20Rg3
	 zwk+Si2MdrogADVhjHX59iT26pZT0hrvyXAE7LtlnPdZxFykjGTnUKuDRhq+iLurHZn3x
	 IIQVRbU7Ind1MiYyOgg9rWmhnliZAA0wwBKYRgtoEHhv7g59/itGOPm7xxGSZzEfeBRmT
	 IdkUplGVJCbUugb8ffS71OWhluLcNE1AtjlwNIAYISIAvVuXGqXv7XQij6cABr7YCJQ3u
	 w6zlrudX1dhh2pvuPGkBa1eorVA32yPFNRxvCVK6xt3KaX1rfOqTt6nKpUGklOLJ/qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=lc48sswTd+pLFga8Upb8rkTJh0mEpL5/imgFlYLrleg=;
	b=ozcTXi0IzO7xLcwfojuw6Khn2qnti9r+VtgKLM30KI2FXe4IDNarnjYvzPwwEuwCQltn
	 zxE0Yvdi0PuoKDI/px+CAyFIeGnPXO+iwa12A8+3hh3L+hQG/ZvLNuMP5w6ENuGCwrXgC
	 HzxRemtwzwM63MZcNnFiOkQaRVkzcOjB3FPwteWbm5oV88M1B3RA9aSAHe/gKfCLn9Be2
	 MYQT5IGKRm6danWB3YUr4J6iL9QBUsPbuCKghIjh0uMJcvxvCtP7ZOA67k0uBw737PL+9
	 oa/DK92m/KzKrSRIH6Mf7wcvc9x2J/LXqKNEKdqo3oaU5mBniHssjV5YxWZ9ce/Wbtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nAXihX6R;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87060606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 19:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87060606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nAXihX6R
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-170135e43c7so1199828c88.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793474659; x=1794079459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lc48sswTd+pLFga8Upb8rkTJh0mEpL5/imgFlYLrleg=;
        b=nAXihX6RxRAxy+pUf973u/LwloeDfrTKb83fgLjS7uvkzdbtFM/COaRKXxtoq02+hr
         2s8/XaifNiP1oOrqe54SJ4GUpqLqIxHVnevKAzdDg2i5XrRj/KUHcrZyaoiJcrn1S9uQ
         r+eoifYSMc92StwilyXq8MIHJYe/djBFdgru7QIrF6vHIx9satftp3d3zSC4jLuvHhkK
         2Q9i6arHtb78HCnk0aZZTWFntx03/Hy+lR7iv/zwRKEGPzLBeH8P6FmAkoZkMXhRFfke
         JH05GSX2HtQdP78UFQU0Y1JOR7YxMmeO4Pyat/n0j8sxE95MSs+vprjwIAIlQFOlXgr6
         5KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793474659; x=1794079459;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lc48sswTd+pLFga8Upb8rkTJh0mEpL5/imgFlYLrleg=;
        b=ps5jNsVDLMnNoMRkkClR2hKFat1PSycwzKsQVSkMzHbs1ijFGnQVYK5RG3Se4kIr6A
         ydlcODUTKZNeljKB/x/0QMHD8tYGONZ9WojMUmCd3800hNMlInl/837+uAVBdqmQp9Rj
         EcM13rmDnV+nGkbypVVNSjP8w5LlpMfbt8/1HM2sTZkevX9Tapk53eflwM60WoJDOQE9
         T9StnxPy6733scGwkyiFRW0Ar3fDKnoPXg/hKBjlzqBhGEZRjUoRYpBqelL2Iat++dEQ
         N4lvfm5MY3xyp6EiiomBg1FfbJMTCzoz7nuUceEBzCYgzrc3OtjznObuyF88t75GOXqn
         aoFw==
X-Gm-Message-State: AFq9FYIF6b/6+6JEw/rVScxcC/6jHax6EK+Y+BipegiFBkHDLF7GEe3e
	9kT6Okt0ZbvTxCpR6y4fRH7PC8nj7UzTjME6jafCuhSLNk1uvz28MEuy75TTm+jV
X-Gm-Gg: AYBFou38tzkbFrD18rX5E+MdKLUJVX5XYMea6b+Stu0cYZlY4+2688w40Hu+O7nj6IT
	Uv2BAAjC337aWuHhG862CHl5pumiNfro6vbtN+VyLUZ7CdqMPtVgR4ZZCdYqQf7d6G+4bJgmivL
	rKsIyudGbhMDbNMan7cyDEXM2a8JtlVazKd+iutzDYUrN9wA3yFZkCf5Hd6rd4Rbfv8XnEWo/kG
	WM/wKfjJSqe3ASruDWfiU9bNnp9hAy1658vjTL2DidTOqHJq/36zIB2okvDuiaaC74+nJeqc1hV
	sSPgr9rBL2rDRi/VwrxEYjL8Jmjm7JD2SXByQi+eQEvl9PCs3hHu/P7rYkz0pb8qfd9+v3iMPOD
	Ic6+dQ8Ep2c/h9KZq9pYnS0a1iDJm5TEaMYuAaS3o7YyA6PmpW0d57NkQ3IISShoDhbyTlVu2c4
	Zh1iBA/CAhNW7lT9+vArfO7pF5Hdk6tljP6TlmEk7TMB3KVK2hvrIZW7a0NoFNJ8P7gz3G4Q6VQ
	RB1uav4r7MOhZDhnJT1/2fpV+SwJGqQh50GJnprYD61/ZuQ0ZSToQOEwhezhoCMGREPgEw9GsJC
	O9Woj2CwZeZa01Yokoa/yzJM1ANVLa8Wtg==
X-Received: by 2002:a05:701b:230f:b0:1ac:d029:70b5 with SMTP id a92af1059eb24-1acd029740cmr6825790c88.33.1793474659357;
        Sat, 31 Oct 2026 12:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.157.144])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm18531294c88.15.2026.10.31.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:24:18 -0700 (PDT)
Message-Id: <pull.2288.v3.git.1793474657981.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 19:24:17 +0000
Subject: [PATCH v3] submodule: use the submodule repository to abbreviate
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

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t4041: use submodule repository for commit
    abbreviations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

Range-diff vs v2:

 1:  3133cd3017 ! 1:  a8c54b9292 Submodule: use the submodule repository to abbreviate commits
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    Submodule: use the submodule repository to abbreviate commits
     +    submodule: use the submodule repository to abbreviate commits
      
          The commit IDs shown in a submodule diff header belong to the
          submodule's object database. However, strbuf_add_unique_abbrev()


 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index 4dd4954260..e80472af32 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -14,6 +14,24 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success SHA1 'submodule commit abbreviation uses submodule object database' '
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
+	printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
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

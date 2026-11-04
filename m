Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763784;
	b=gvVNju5XdDGoQIprVPxsID3LyVWj4NtNHl3rvIiNOhQI044i6SoGVK6Vy0EtZ3318W9X
	 KyKuDgeSDa43SoEGXd4QKlvgIH2yebTsttWjfLo3NRIq4TZmwEqt8Mgc/kg0EpplBYu5b
	 djTqbEHBtxR85sY+GRWSXSXG1wKR8Pu7D50OHcvYEU6uRUVlm8hhzjPzwWvZ70dwblPv5
	 eaTtSSziTImuOkAZIo0LNZf2iOUEjp2s6wtpOnDDvJEdP3GsH902cbJuXvuQgvAR/YYZX
	 1b/xMt/SNEOlrHdItnFBKmbtdWu3TA5NQ8Bo3bSt0CkN3Frskv9/nO8j+1L7/0kW83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Iz14B1hWRNn/Q7JlfzYpblfXoKrpsflaZTNFhPVx+8k=;
	b=cGxNNSY/PKyDRYHrR+CloecfoQFCmMf35Yoc+Uh9pjud5v1l9Qo38025ulyJ9NOXXCb+
	 njrz5NQQYLqU4Vgr10MWAB4svRJxKbXwLSnmHX9uRi2ToT2XYljYD87lj2pvZfDvIFhIj
	 QknS6P9rg4nWm9UMBgFS6ORsPKT5loXDA1Ot5+2IHTLmJyTmCXDABKy0E9hlNxZVKZeC8
	 bjSQig9kxlMgE4DXPAi/Oi6AKdUTqFj9HZZSwq7BS4hqvelR5QQqHRIofGkhqXnnQb4Jf
	 j7JKETz24KoBaIsdW+ws9+w71NMPhfDDOaT/bOouRV2OxZO+XVDV1jgXIh0Y7ShTWjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o6+bo8+x;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E8606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 03:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB5E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o6+bo8+x
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so293046c88.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763783; x=1794368583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iz14B1hWRNn/Q7JlfzYpblfXoKrpsflaZTNFhPVx+8k=;
        b=o6+bo8+xcvQOOUEoPlgVpDkt6h4IZRPE9iLtPA9pYIWJOsSCnXjSf/HEY87X6S9EtD
         lUuDsOEvVwoKpROZ4nRBgkcOffQNIFLDqYnl5MyFZolwZfYHBlWAeSWO1UhN7s7+8RUo
         gnnZDJ/QumL3/DElKNaUIKuPi4jSCM1pBkOP4ht9ODg9ngOsUJHsRiSWRDPXdz7YOMpq
         p513P4hk5rwfbGUv8BJJyJDZKRA+m+ullD3wU1qHGA6DYW3U028xF0RjqdL8jJDfqcjD
         nKPS9QetLP6ZQl6D7o/XndF6C5lotS5cPUFXxMMIdTDRC04s0doViNR1ohWp/ixGg5CO
         EYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763783; x=1794368583;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iz14B1hWRNn/Q7JlfzYpblfXoKrpsflaZTNFhPVx+8k=;
        b=Svp9IBeHs8ZkkvffoN+ZxMFh988eDZZwg9mpPcWll/0arBmtra8Ufw1t3Z4cufo1DE
         bFR61Gus2HqQRSs1CB8asRyCEZiyia9cgVqiWRUQPze76p19QBmZ9/B3Rqjbw9QdlOkQ
         nSh0RnwCuWsOA1/+jyr5xk1psyQaJm1zHyUd6bc3c6Dr9bXkoyC2QG+yd7JzwgWrzCoO
         Bgol24pLjk6QjHYIpKVcsubiGjMGiXAH4Fa+YviukuIr6WYjMLtEnPyta5WqtVvlWbWz
         WGczw8NrEQOf0iwPGP/Dn53CMyE9n9yUknUSIhYl/OOYtzihIM69eULrgtcEE1r4F1p4
         yj4A==
X-Gm-Message-State: APuU4Z8Osxy+wJMHp9z9gV17HExe2x/FLTIFKPFO+w7uXAyCDU26R+QP
	MPAPlsANe94EZAcEzK9MdLzReQuubXzgd7gjHbVtb7U18dQtKGKMjq/MZoaBbSLgcmc=
X-Gm-Gg: AYBFou2LGWPAEDDzbfiSMPenXvtfQqAV5saj9szBiJI4Z8+Kq/oI/zM7xAkQnL3gfcK
	RX7EETy0UspTSRP851t0urczSmIM7rQWYhyv75eDh+Q61QX4iAUlEKfswC6QpQ4GHKbVVbGKhzR
	H6wV2eP8XstTg9W8MWQEY55N690tR4RW8zfkPzTZr6B31oLAQCDpF446+7X2g7w+0lWEJGM53P4
	TDEhukdmyPxWB6MGi5HvcCGQQGZCH5mkCowIFo2fqR89w1OnNS7tm9LVHPGxiQUIpKygzEUrrvw
	t3+S9FNR7T4nVGdeVC40EvDXMOFKqiIC38cVJxi9eHGpmiyA1OtaQSryknoSBNpTwJp83QgaxXd
	KDB3kBDrs/vPL6GBjFSpP0JAqpGnhHGoIjPuEukODU9GFK8pVG71RP8HKhjuV/YawxVxeklm/jZ
	pwymg0K/BGtCkbEXPFzRqClbNYbfunvf6Pt7+UXI1CmpDarcsTkvZN48jmSZMZEtn++bxZI9cjT
	vu6YgpY3Sw6Hi0Op8u6PsdNGQuMdj6WijHaLKPWfMZM+E2cwS71WZZh82+WXQBvUWHIj5do7IVd
	xyLGtltyZmLBVCvDOf9Rg586BkdFGZTI
X-Received: by 2002:a05:7022:f507:b0:190:d9bb:281f with SMTP id a92af1059eb24-1ac5e3225aamr21381379c88.18.1793763782520;
        Tue, 03 Nov 2026 19:43:02 -0800 (PST)
Received: from [127.0.0.1] ([13.71.227.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2ddsm3453523c88.10.2026.11.03.19.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:43:01 -0800 (PST)
Message-Id: <pull.2288.v5.git.1793763781129.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 03:43:01 +0000
Subject: [PATCH v5] submodule: use the submodule repository to abbreviate
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

The expected abbreviation for a submodule commit depends on the
repository's hash algorithm. Use test_oid_cache to provide the
expected value for each algorithm and remove the SHA1 prerequisite
so this test runs with both SHA-1 and SHA-256.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t4041: use submodule repository for commit
    abbreviations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

Range-diff vs v4:

 1:  a8c54b9292 ! 1:  f94aa2476f submodule: use the submodule repository to abbreviate commits
     @@ Commit message
          Use the submodule repository when it is available, and fall back
          to the repository from the diff options when it is not.
      
     +    The expected abbreviation for a submodule commit depends on the
     +    repository's hash algorithm. Use test_oid_cache to provide the
     +    expected value for each algorithm and remove the SHA1 prerequisite
     +    so this test runs with both SHA-1 and SHA-256.
     +
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## submodule.c ##
     @@ t/t4041-diff-submodule-option.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
       . ./test-lib.sh
       
     -+test_expect_success SHA1 'submodule commit abbreviation uses submodule object database' '
     ++test_expect_success 'submodule commit abbreviation uses submodule object database' '
     ++	test_oid_cache <<-EOF &&
     ++	submodule_commit1_abbrev sha1:0000000000e
     ++	submodule_commit1_abbrev sha256:24c81a5
     ++	EOF
      +	test_when_finished "rm -rf collision-super" &&
      +	git init -q collision-super &&
      +	git init -q collision-super/sm1 &&
     @@ t/t4041-diff-submodule-option.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +	git -C collision-super update-index --add --cacheinfo 160000,"$commit1",sm1 &&
      +	git -C collision-super commit -q -m "Add submodule" &&
      +	git -C collision-super diff --submodule=log >actual &&
     -+	printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
     ++	printf "Submodule sm1 %s..%s:\n  > child\n" \
     ++		"$(test_oid submodule_commit1_abbrev)" \
      +		"$(git -C collision-super/sm1 rev-parse --short "$commit2")" >expected &&
      +	test_cmp expected actual
      +'
 2:  99a1234544 < -:  ---------- t4041: test SHA-256 submodule abbreviations


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

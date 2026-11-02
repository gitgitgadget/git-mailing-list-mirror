Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648433;
	b=E/HnBFv0KbDac1LkAEVBS6LTMuUu46j5wZ0b0Ji20oAbEsm5s+thB2hOQPABhA1k4Ux3
	 LDI6UKyrPK2oIvdjNZEi7Xk9NcIegK488y7zoTCAnzpywko61NFNT6cMyDpYTwNKgwSF0
	 bIyrvwBywzM1cq+qiY8Da1QrsvOUguvh6SgZ31jHEDo5tCmIKgpLnv4iZRetkEeeox1Dm
	 5Q3+hNXbevOxxziY1J9zrjBsfPLOrtJa4XXvBMuY66K7LzzaRi2a25sDgDVxP8BhDTJfc
	 c8a4rC6kUPaXa5v4okX+EnBGFki+eR9YL6hHg0HLoFl9sJrrdx/Fj5Z2IrUXEZf6Jlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Ot0/HfFleeGBJ75K8DPiUzM5ubwpKl+hE7A0DmwA5wk=;
	b=vQMhGNhvOEw1HO3LfFDSmnO+/csJb3eRWL+rUYqnNKRwRHZplQVHaUvCSicysDkMlUPh
	 Hm5HVnpTho75JER/fi+DCxvMnGOFa7aN5lA2UrkP2h780BTQh2hQjTRXsycUY4QmESHFq
	 Bd21jzBIFw/jz/Jzcx9VfUmCXiGyYFLmnxMrWuci1uTDJiqOJ3+RzfmVUNKbRtBS04/io
	 WYTkIkVAs570poqhTIV8whNPLu37E2fsESeApNP/vfcRxVNIYF2t01ZXZxjeot8Z2plfb
	 C9zRiWp5y5djmf9dsnSMf6smpDuQSb6tob5Xrf04vvlTdbOOh//TExSKCdGd/5gBBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=je8LX2YT;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251C6082BC9
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6251C6082BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=je8LX2YT
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53653e30353so59781761cf.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 11:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648432; x=1794253232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ot0/HfFleeGBJ75K8DPiUzM5ubwpKl+hE7A0DmwA5wk=;
        b=je8LX2YT/22W5U4xJEEUVAl6vn/p7v+GAB9M4P9/xPYJxYwPZDZUOXHXyOg7KraYN+
         2u5UVJputlavsGOwF3NP37rQtqHchj30FnuLbr5Ozsajo3sAmHtFL4t2SX2U7gSXfAwC
         zclYjEz9p0+pYIeLJ43uuKMGdRa/qFnNj2Y6WdYYIMQu0Rf1OrwgBPsCCbFURtx3jw0E
         TTANJB41OgYQvjO0mtZlCrDTiXclH1uekkvZ4N350+aduWHKTbAlrgWAaeIri3ozZicC
         WqWs1d4chBfvASCvtx97O8ZvuOhoXZVpHtbP2ULgUEfLzPUD5FcfUL5i421d/BXTGpiG
         nbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648432; x=1794253232;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ot0/HfFleeGBJ75K8DPiUzM5ubwpKl+hE7A0DmwA5wk=;
        b=fhJQ3jm2K6kPzvOew1+8b0uSPhcLdSa+/fq8Y1NtKisKvK1qAn1eNy1bOf/7bQ4Xdl
         GKZmaylU6cJMrhzrJgTGtbuuvbt1mX+Rez34K5x6SAzOhCwQATZmoKYji05F2euCPHCq
         UH1auU1eWnTNu8IOGXe/nvMTVDQi/yIpbZT4pnU764D2c9DfgU1FNh6mow7RTlycnqir
         iobwBI/GQM7B90jsP7jptdNegKNKeWuctRcnyIHorAEI4ocLWvVjHVzYC8F5YuLPXOaa
         czuGmwL1VZNSItQS0ihMvxNi66MtY4wXZZ+paubXNnjVqei2bCfRLIqEIak4cj8WPHEQ
         70kA==
X-Gm-Message-State: APuU4Z/vKjfrpw0t9Jv4MydrVw41DQggeCCnHhlFsg8YqwE0TkWFiMA5
	fAYChdzLqRQp7CzQsF8psgK/V8xPsaswdCK7YJtut6cujQG3NSxjA7p/1sUkB+Qq
X-Gm-Gg: AYBFou0UbrlVRShcUDiFfImFaTgtKp4XzlUZW0zvKgOsTFbhDzBqYKMhbB6dSdXUbyq
	K6obN4Dol4+E8A3QNIcsrBMDyRkeuYA7eHQOGudDmzvMUy26R1wLIuCc25SH1ZwVISIOBkJML2N
	ueI3NMHDPxPMEM40nO34TA4YATOTUfVOcQOSlIfj6RyQ3Bv2wH1+xz5G6VVbDStCMc/I9TpHciE
	8OaMwXriYwCCdjRrZ0n3wGpfVN8DJEZK3jKnM1Zg5tdaYpVLIZ+8VN2wMewWiK0nsJMtW/rwZwV
	7XHx4EcnZlL1xHT0vQ+dJd3ubX5S2ptXaNCMpZzNYW4JVyyYl4ql77CjI2e3rgWBgqmWYIX+8ST
	hGC83XLV+Bcm3bV1KGlU1LfDbmcXaDmoNgVuNmU03HjECZkhFe216TE7G7bwekjnKH+p/QEMOu9
	qtG+oTrw0X9QiUR4Mk1qPDwlKuxIU4TuZ6XLQFnxD71Kl8Gti00O2VOLIjA3s8yd3ckgmrc8hfH
	sxWVxcrOLnn2p+OD987e3qe44Di/psjuWWGi2XEXFAfGZTT8Rsqsa7v3PTko785wjPGobyZcFfp
	YKwiGQd5A2oq5TiZKRJK60yIe2j+iR+i
X-Received: by 2002:a05:622a:e0c8:10b0:542:d089:2060 with SMTP id d75a77b69052e-542d0894aa3mr120227721cf.37.1793648432374;
        Mon, 02 Nov 2026 11:40:32 -0800 (PST)
Received: from [127.0.0.1] ([172.214.47.41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498c08680dsm5819041cf.16.2026.11.02.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:40:31 -0800 (PST)
Message-Id: <a8c54b929255679ebd02ca06ef1f58de87448064.1793648430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 19:40:29 +0000
Subject: [PATCH v4 1/2] submodule: use the submodule repository to abbreviate
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

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
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
-- 
gitgitgadget


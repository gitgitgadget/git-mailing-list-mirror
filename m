Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473065;
	b=mY/DrKUhyJ9hRfbgIr11nfodbS8We6u/klI8z8uQJYOQH0Vi/g+IkMx8mMo/biPUzkV7
	 PXOqd+HZHObdoQm18lG6glgSUyw+BNorCpfcXny04i3tWRg25Tfg5br15Pv2e9GU5CpNP
	 0rbIXQHhi+Ne8HnvIhU73Jjgp5ILdROGyPWOSHZqzJcFKDfQG3YmN/LQqRoduRnde7jQS
	 0InjOALYXK5/Techdm1ISbx/XRVLXvnJ+uSlEH1EAxQXloxwcf28msI4ywSkDa1NGefig
	 cvmBrg766TxlTDblXQozGVmzw0HeoziYeXPGmdgqEH0Gf2gE2CygUcc8/arfqqm1e9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=yDJTiX2nd5T0VMAA+uCDDXZowR6buHjd1+bplWCLkM8=;
	b=UFWUPjIg58AJERQWrUby3AVs6Ld26ZqFqoJJAM9ARGW/IPpEvp7zL+AwB4BbgAdgRy4I
	 eTPio/2yiPhivnmxMO9safR3EcZiV034730Jy4jN2C2LT1YaWdN0aAYGQpVSsy4Dzzl07
	 Oiv87KmZbnU+ba3y1+9E39KQyhAkDjy/AEwrrxHQdgG0Ym11AQUZLs1PPMgiJTzrx7a9w
	 2bwyFbuu5N/eMu2UFMcLooyTAoXvTUD4qVzc5tDlfdHT1bNWoiC7o4vrRYCdCvKCIvSdX
	 rf605p1Fu/dtTGTeMkUjzgljt+1C/0UQvszXv5yhTc0FGnqIc42IEUqeX3IdU2KRNWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AV3D+OaR;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391C606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 18:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2391C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AV3D+OaR
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82109f51565so802832a34.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793473064; x=1794077864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yDJTiX2nd5T0VMAA+uCDDXZowR6buHjd1+bplWCLkM8=;
        b=AV3D+OaRZmKNocG7sLAeYaCV8hhQzwIaG7d3EQm9hd5GR3ZIS3LwXbdPXcpCA0XSpq
         cnvxtLVurQ/J9JLg065jgRExMOrlGBfQfBCMNvnyY7EmENUj9kA+Xtovoz5YvCHO4UTN
         7xJXsuNbJREKWQDs4r+lFPO/ZaGlc+lys17hc94ajnO8OFUQ9vaHcWV2MjfpdKPdaFNC
         vBhRPHCkLNwh8RcPoZb7YUv5QEuRQ5wXeGVQpBk/umaP1TpqF7vxJTeLnQWkFxpHc+ue
         +g9lhxXtVGr12g8UmoufSb7ZbNmhEGdmwT6dgcBmQeTlWZsoNd9G5uN06oa95qe8v3Tw
         PFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473064; x=1794077864;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDJTiX2nd5T0VMAA+uCDDXZowR6buHjd1+bplWCLkM8=;
        b=XMnk/ZySDgszzsp/zmC0kbgYdK/y9HbrD1b1Q4hFUtk28MI4Y85fI6jBRVhVyJVQpX
         jSYZ8ELCGrRygkrb0r3+BQMXNVWZHz5jsA9fMa1kEaAdWOjy/8Rm5KHXgP5p8ayb+d3a
         Ccbz6Mp7mVnDK27J8u4s/sbUUfnTzkofjPfiLVdgnFQ44xRNgmJ+WTDGbUOhfj2cklhF
         ZOGGWhiCWXNShTB/u7qaFt3BgBXFVz5XpYJ7nlLF6zE9vfbFLBUcLVY/JU27vLLnsn5G
         Bu+U51p8CLCiMDPOpVo89wi7UszvWtj/hnC5RWvHUuYXxwGoI++YkMcNXXk5bJ/ERgzT
         3sJA==
X-Gm-Message-State: AFq9FYIR2aTFW5Nu7YCp0yuQyssOppaSeQL/EvOk61osgN5gLV9zAvNK
	aphDf/xFfwZiqLe+K9R/na7FnIirAW1PMn6tWdBn7r4ZjJbpijEnb3xC1FEA5aWE
X-Gm-Gg: AYBFou30141rd0ibBr/NDfBqGWAgkpoCi3KF8FlPdx4zA+3tdvPN8wqOwfoc4i7aKzG
	tLm6yF6TTL7iBoifMg4URRjOgJ2cycOm5m5BDzGRfSkleTmCqXyhgaK72MMNn24S66OfIHCXFfK
	whE/S/8lJrkN/bhevMylnJxfd1wzgFZxENrukykOG2QC/Gdsot5+sRCyIibRnVQdl50KIW+uPn4
	6VeEPkeO0SIbUdFFGqvDXTyoUCjXc6G/etDIM2oFjVRDOFAEGTjdWRjs8ldeaGU55/SaEAozAAu
	oL26l9WQEs3AygxLuygkdTWtG4LgGgZS7OB/Y4Imx55jPq2ZBgZwU5QQHt1KzZUTVKaemOShYKD
	59Fp7UeBZyvm/ln1sUx3F9KjC4fn8GCQBDQBbzB1SRMFayxB3z8h2SHyQuPupoKRcuegmsHulwW
	cOcasrVkyBmqWF7/Ja5vmowLp7BWZtqxi39QoVKC2enfTK/vENJo2lTx1a++u6IrR9XxeToViNT
	4/ZkhG9wACQqHVXW0/Tcyet8d0mS9r8snxBxh5QmMvMNVgPxewnsF9rL4MCbMnBNyRIm7f4OTz1
	1KBt6ynyRgaGjkbW6WUCOMKuDwMg/G83
X-Received: by 2002:a05:6830:6815:b0:845:156f:58bd with SMTP id 46e09a7af769-85d3651b439mr5124622a34.14.1793473063933;
        Sat, 31 Oct 2026 11:57:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.240.186.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354efebesm5043875a34.19.2026.10.31.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:57:43 -0700 (PDT)
Message-Id: <pull.2288.v2.git.1793473062113.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 18:57:42 +0000
Subject: [PATCH v2] Submodule: use the submodule repository to abbreviate
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

Range-diff vs v1:

 1:  7b2af1b46a ! 1:  3133cd3017 [Outreachy PATCH] t4041: use submodule repository for commit abbreviations
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    [Outreachy PATCH] t4041: use submodule repository for commit abbreviations
     +    Submodule: use the submodule repository to abbreviate commits
      
     -    Use the submodule repository when abbreviating commit IDs in
     -    submodule diff headers, so uniqueness is checked against the
     -    correct object database.
     +    The commit IDs shown in a submodule diff header belong to the
     +    submodule's object database. However, strbuf_add_unique_abbrev()
     +    uses the_repository, so it checks the superproject's object
     +    database when abbreviating those IDs.
     +
     +    Use the submodule repository when it is available, and fall back
     +    to the repository from the diff options when it is not.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## submodule.c ##
      @@ submodule.c: static void show_submodule_header(struct diff_options *o,
     + 		struct commit **left, struct commit **right,
     + 		struct commit_list **merge_bases)
     + {
     ++	struct repository *repo = sub ? sub : o->repo;
     + 	const char *message = NULL;
     + 	struct strbuf sb = STRBUF_INIT;
     + 	int fast_forward = 0, fast_backward = 0;
     +@@ submodule.c: static void show_submodule_header(struct diff_options *o,
       
       output_header:
       	strbuf_addf(&sb, "Submodule %s ", path);
      -	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
     -+	if (sub)
     -+		strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_ABBREV);
     -+	else
     -+		strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
     ++	strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
       	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
      -	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
     -+	if (sub)
     -+		strbuf_repo_add_unique_abbrev(&sb, sub, two, DEFAULT_ABBREV);
     -+	else
     -+		strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
     ++	strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
       	if (message)
       		strbuf_addf(&sb, " %s\n", message);
       	else


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

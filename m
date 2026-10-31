Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435154;
	b=lSbIex+oM3EQBp7ujaB7rRtT8ZqM13MVnR4T+mCReRWa3sTrdZboJSuXL1OEYhzkqN3J
	 qf1dMi3r2JWxJE+dyjFcJ8weDJaOdc3g5qA2v8ZrpAQmh+3rXqOL6dA1/xG/AcR5GVLh9
	 a8EfKbeYbsfVcaQVF7VxlHyrtg6NZZZQr0NyfJUkn6NIuo6W41VuuJnBp9tyOv61iaE+r
	 1zwFQC7VHCJArpYJQpGdzi5Wng9qnyfc5WGqJqskkhFACzVdgmTRs3Y+SwzS00Cu6Dd0B
	 qvEVah7dLE+xjFKvwtxgE3dqysiDN68AHkGQ4+xzdBrx3DulyKhcUoCpRvIz9Oc3q3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=YPoUClDqliDRA/E/on2A/kuW0Yazuq6eSgtUEzEJ/+U=;
	b=AlXZN3vS+PvPpwbXXuis/2oNipm9dATUUSjHLSxF1vsLaONG4jQbfWq8Ll9MMWFmj7X8
	 R+GIE1UJtR5HHj3XKJ50REMpzLAuSzV5nlYli6l+vIWU2cj9VlNKWdad2AxdO/PupzdJU
	 uVSzmAul0q9VO9oInujOe5ZNfTkBFxc7cJp/yvdIzR2xnwipKPLUVaCeOUK3gtYGuVuTi
	 sJX7+bSTeZR+vQuRzTcMohzFTm0mEFgYBm23T8qTYQPRZNq3TF0R/zOKIvdEDr4Pc/TKD
	 R0G6vbnwzk2njO8xgUEzZilX5kSwiwMZkGT6BbpZWlXV63BBbxmWF5BmlSh5UqPJQUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pxNRlb/K";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE8606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pxNRlb/K
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so1919109c88.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793435153; x=1794039953; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YPoUClDqliDRA/E/on2A/kuW0Yazuq6eSgtUEzEJ/+U=;
        b=pxNRlb/K4Qv1oI4OFM83qxRayjDPCYubM3qi8XaB4mV3lQi9DGIM1ek06VwPDqqUwm
         4rVqbYasvQRLJfS9+LBFtCcphvoOMEo+fPUCyfJLH326zlANyXXMRwaWIOpoaoD92Srv
         L0grsXgaYgHq40R8n6DfaajgjYYq7n2VM1ZiXBn/v/VkPcfQtWvyKG7weGoNz3Fs/rmN
         nZBqHC88x4r86s613FPN650bkah9VPJFmjGx8xDUa7IC4niVWxK8FoEKrFx0TmkpRDyg
         gWDQpgHIxc1j2Evf57XTw4d8nCiVuWBciNFQVBclct4dW4z+qvmJXbAY/ajt7tNz+0n0
         Jhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793435153; x=1794039953;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YPoUClDqliDRA/E/on2A/kuW0Yazuq6eSgtUEzEJ/+U=;
        b=H4wjzZ5APVUCeYImnnVM2NJKozdIJ5b4aDouvho/NMMryf1JruwlWfDA+5tbQ88HAU
         gVysrDgKIjGlq7El/63v1z46XPPinbSbJuMNZVATqmSHLQsS5BTkzmBg8pBJI+LcaOLa
         0SnH7qPydjIpoFIZ84xLMXAZMpFUsSao93C/NASrsfWORftyZ8dYIJN1IbG5ekZEmNDx
         TL1s1IIOxCAmke4Q+tvSPTeGqKxbl+ZeXuSYb5SaaCWS7GDEbs55kR1M5TehOIQlzOd1
         ppunuNdH3e/ccT4LxGqGCCgD4qFGJXXd5xvKF+sIrzt55Se5pLyfk2AzwNcX1FPNrgLf
         eKBA==
X-Gm-Message-State: AFq9FYLjQhRZGb3Av9h6suAiyLuPLzHriEmPhvUZE6Pn0Jc+dkIwT0Kz
	p/8g3NnfezKtmT17FkNe92hcY+/VoXoWTj0d87b42UuVCO49KkE1/kTzGQtYdEId
X-Gm-Gg: AYBFou1ReKMzOiWZU/PR6rac1zZFf1f8tQTxO+B9E0qLaTscfZgKjtT7OTzXER9UFIa
	fp0eP4NyDV5NDDu2gsDFfTHTlTJckJwwh8eFWfVSHVWOeqcFupbDr34i4X8Ow5NxBcii5iKQW5l
	UGBVa1Gv4xeqZaYsTbSvYP//2GHkNM0z9lXLw70CiFR47qhEVFxN6bS4HsmAXXvKJHKlPWiJCUw
	Vxa9QBceN2i++EHodDjVMOnafp/5wlphcttr9m19mppyuOFuWsG/w7XfUxwSVTg7CttFrJbP92y
	Lcmm8hWMYs5EK+xXOhsRgHV7atzBL8iq4yVRIys1vEpfdR3lW4mRCqyX+7yjuCwWaSZlg2Ssxnh
	tVhjxJmJVWU32mQfyBGi3FvTA3mfEhSnxBmiPqney9oNnMIrm0eHrrex6H+yeUP3eU1SVw2MnnU
	pBDhqDv8G6rO1/Zr8Xg+zGV1nwo5XuvZw+qzmq2MTkL7z8ZBEpR3kwRtWMT8pH67SEIX9ne3soR
	LovEU8KcICaZqpyxJu/QD9ERshzJgH6RP7gKACL6RSVtSCYPkQyMJPkTBTunqIv6Wx+Lds5yfOE
	rwXj5+lw5KyHmdDHkg4zM0ElOviaa1I=
X-Received: by 2002:a05:7022:f903:b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1ac56d94becmr6532192c88.4.1793435153346;
        Sat, 31 Oct 2026 01:25:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.94.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1a16sm12314786c88.1.2026.10.31.01.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:25:51 -0700 (PDT)
Message-Id: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 08:25:49 +0000
Subject: [PATCH] [Outreachy PATCH] t4041: use submodule repository for commit
 abbreviations
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

Use the submodule repository when abbreviating commit IDs in
submodule diff headers, so uniqueness is checked against the
correct object database.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t4041: use submodule repository for commit
    abbreviations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2Fpoojarysrujith%2Fmicroproject-git-libification-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poojarysrujith/microproject-git-libification-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2288

 submodule.c                      | 10 ++++++++--
 t/t4041-diff-submodule-option.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6fcb606f7e..2215a50d9c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -599,9 +599,15 @@ static void show_submodule_header(struct diff_options *o,
 
 output_header:
 	strbuf_addf(&sb, "Submodule %s ", path);
-	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
+	if (sub)
+		strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_ABBREV);
+	else
+		strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
 	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
-	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
+	if (sub)
+		strbuf_repo_add_unique_abbrev(&sb, sub, two, DEFAULT_ABBREV);
+	else
+		strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
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

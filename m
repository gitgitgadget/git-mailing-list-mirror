Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B32338904
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968929; cv=none; b=Wme1v1dux+iRsMU8zXwUMjL7Ls11vtJyJC/BvQmHw1MtfpGsFHfkoUR/8nk30e9kvs6/kXk50WYfiNu8ryak8E8OSkO+GtlpvtkCuVv00dYciEDORQEKL0/qThsxo0a34zUpJQyMYSz/QuUog69LUhBj97ISy1RMhN6jcKIlBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968929; c=relaxed/simple;
	bh=nL/l8L9isnefRQJbrHLgTyQn96wA11x8KEEHRrthZnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VAcTpvpWECp3+0Pn9tnnfab8eopFU2JAL/q94nrD6wSCqy8RQjCtXE9nC8vYQyFPKOPlnu/+nWFLA1moMtruBx/yvqjCwAUzR7Aqsfa6Z0co86WDN2Rbli03YP5XXE08xzD5WRiab23af0tD4joixSpB/UxfOo6Hu40MHIlBPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDC6XcjK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDC6XcjK"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-503347e8715so72724401cf.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771968927; x=1772573727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=HDC6XcjKg5K/0YYp/sm2k3hG2kv84xnzyD8jLSVeZukO+8HcV0duZH2wHYxzIfnydN
         zs9Z4JVTMdjd/TWa1aHx//56G3WH3m0jXiWdpUTIvMH9gzNFNLwr94v6KwNczpcO+Wr1
         sAxs/pm7WfC0J1xEn2f6hEZOdKgpQ6yXKg0NSPIMwVljLZWzI91czzzCTIDcUGeng8ik
         cCmufvxSnLIRG4PrcKR1p9wS+i6ssNqoec14cD0ZpWBCFskYqa91blNI9b6wqXRY73Fw
         1e4cZELdA23dTXOk1FSNp5HuUfpXNmd0wqvh57vyayabHMKAv4iNRTKtPVZsVECaCROs
         V1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771968927; x=1772573727;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=Pj6iEye1PNbOpLCtLHH7+UVrK6HEXqntnGt3zfkJeyX20AVMXWA2TMH1jKdqtXdNw7
         SVGWx0CueQrMdm/d20RWgx9Grg9Rdxg+MxGlBjd6bg4yk2KwaQdHS0B9XglNGDnzYp3W
         VG01ZbBn56Vlvo/P66n7ZCZUVkW1c9LwVXlJb/5ZzdEJlsFOyvebjHoMpYylpfOutNbX
         oZj32FzszDNub3S5/l053WlYZhbv5/kA2W0WJs44e/+OQYcQv0X4QiAPj4h6+NqP2N8g
         /Gd/6RIZiZshP5KgjdVRyL3gGTRQT1NU6ARaH0Ue9BPew3mWYm/ntCXMf5W6RxQ0Trk8
         dbDg==
X-Gm-Message-State: AOJu0YwB8gsAnfegQF9Dq1XEPCxICHCQsrp+bNWCdP2AFlt0GBOR0y50
	NlO4dVHub5cX1B6y6h0svOOkmd0h5mwsirDuqMD+4t25mzT7d15bZg1KpmviCQ==
X-Gm-Gg: ATEYQzwtJ1zZiR56D7vkRp57hwmcjoOKml97eBmA6YDTooZM1+UcfOAQM23cM10DNtI
	W4Rucqyt+aejNi4Df2kRgXsxOkTILczlq6kx5bVFdvshiRBKDEwF1GTJNQ67V+5jx4xQ8KCTl65
	QIejUv2eGhwMsz4sKNrRIOggrjwrZAwwhqZo5xexVBrFTl9V3pUmF/n5xznhqXc3XfHRNg59ytz
	0UCojeCrDiCRVkU79bDe0w74RRPFG/UGv0kACpNTujXT1FniV9Ok9iw1xIcB3rubA897IUuapd6
	VAGKTPOTFxRNG9pHYmGCP8XGNSMb04OtCsXGlD067R54z6W2k2dcgzs4581HC00srQZeq9G6vud
	6EplnP3J98nJ5indmJZVwzkzPGMNsuxruL+BhLV4gjY3Cx4y8LxvsezNEP39JaGk2AQfg9ifQ/d
	c9UeFac0HET3vD3ZLIKMBo2Eo=
X-Received: by 2002:a05:622a:1909:b0:4f0:23b6:c285 with SMTP id d75a77b69052e-5073a2f31d6mr2679611cf.41.1771968926953;
        Tue, 24 Feb 2026 13:35:26 -0800 (PST)
Received: from [127.0.0.1] ([20.55.87.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d550785sm131488961cf.11.2026.02.24.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:35:26 -0800 (PST)
Message-Id: <6e9d4f3029daa2c0068bb16939b943e7ac924222.1771968924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
	<pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 21:35:23 +0000
Subject: [PATCH v2 1/2] for-each-repo: test outside of repo context
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git for-each-repo' tool is frequently run outside of a repo context
in the real world. For example, it powers background maintenance.
Despite this typical case, we have not been testing it without a local
repository.

Update t0068 to stop creating a test repo and to use global config
everywhere. This has some subtle changes to test across the file.

This was noticed because an earlier attempt to remove the_repository
from builtin/for-each-repo.c did not catch a segmentation fault since
the passed 'repo' is NULL. This use of the_repository will need to stay
until we have a better way to handle config queries outside of a repo
context. Similar use still exists in builtin/config.c for the same
reason.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t0068-for-each-repo.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index f2f3e50031..512af34c82 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -2,6 +2,9 @@
 
 test_description='git for-each-repo builtin'
 
+# We need to test running 'git for-each-repo' outside of a repo context.
+TEST_NO_CREATE_REPO=1
+
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
@@ -10,9 +13,10 @@ test_expect_success 'run based on configured value' '
 	git init three &&
 	git init ~/four &&
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
-	git config run.key "$TRASH_DIRECTORY/one" &&
-	git config --add run.key "$TRASH_DIRECTORY/three" &&
-	git config --add run.key "~/four" &&
+	git config --global run.key "$TRASH_DIRECTORY/one" &&
+	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
+	git config --global --add run.key "~/four" &&
+
 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep ran message &&
@@ -22,6 +26,7 @@ test_expect_success 'run based on configured value' '
 	grep ran message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
 	grep ran message &&
+
 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep again message &&
@@ -46,7 +51,7 @@ test_expect_success 'error on bad config keys' '
 '
 
 test_expect_success 'error on NULL value for config keys' '
-	cat >>.git/config <<-\EOF &&
+	cat >>.gitconfig <<-\EOF &&
 	[empty]
 		key
 	EOF
@@ -59,8 +64,8 @@ test_expect_success 'error on NULL value for config keys' '
 '
 
 test_expect_success '--keep-going' '
-	git config keep.going non-existing &&
-	git config --add keep.going . &&
+	git config --global keep.going non-existing &&
+	git config --global --add keep.going one &&
 
 	test_must_fail git for-each-repo --config=keep.going \
 		-- branch >out 2>err &&
@@ -70,7 +75,7 @@ test_expect_success '--keep-going' '
 	test_must_fail git for-each-repo --config=keep.going --keep-going \
 		-- branch >out 2>err &&
 	test_grep "cannot change to .*non-existing" err &&
-	git branch >expect &&
+	git -C one branch >expect &&
 	test_cmp expect out
 '
 
-- 
gitgitgadget


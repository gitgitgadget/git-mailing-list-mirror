Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD93E5562
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559120; cv=none; b=McJE7K2PMpsPvN7pbQKcpeH7DnbI3uqm4POSPVVjw6sI9gaJkOi2hZbM7GZj9MvN6Iw2qBNMIYjFmorq5gh/eYZyNe6N11tHisNhpvfGnEr/kMEOIvoUnOGEN4DyqwxGopQ4D0/3qcKpGSukILWfIB+1tKOt6Ggp9DyF9OkxMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559120; c=relaxed/simple;
	bh=nL/l8L9isnefRQJbrHLgTyQn96wA11x8KEEHRrthZnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xmh3JSXP7v50kYbuRJpRYjDjQ0zn5dRde/sNdVoHs+VR7lZVd7Ba0/BwRZngNi2k5Z7JyduIdL2cTve8qTyqKjQLBAmtCPDQetzSm2yfOazXhlp2odNJiDl/WNALYfiusferoLUOKrk9cIt1QYbNTVOIbN/woYRZ7xRK1oSHJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjrzdyKM; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjrzdyKM"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a0ecbc713so9422996d6.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559118; x=1773163918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=WjrzdyKMwZ6/khrDSvJY/Hlt+U5is+qSJ75FutncaJ0IGmy9onvPnupHe8/RVJAfsf
         XZ61cHoMVzmbYFtCcCBf153MOHTYdx7v6Fye6LEMw3R327m1uhORhNtj6cjdps96nrAB
         kOt3BaEyrRRpY3TVKUZnsEVzr/FI4H03DxRfaVKDMyvvmPjPAdEJJ4aCoTxulrpV1I8P
         7OPHVetiS3V+FE91bqOL1jXZjUCb7sDGseBMKjGk5E9YLCnkCVEhyhirgHBL1LAXQDmu
         U+d/jy9SObxv1cNLY8aiwO/WNCU1vZljIBdorLqQBY8To0a2CWg7Bmcxfv4dxx2ufHQ9
         x99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559118; x=1773163918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=nssCCOijjChE02Uv8OSQWuRxTiZ9JsMP/8gnMUb3GLyeqcFBVJ+FTe3/fYFA4Hrgmh
         qah/1Qc9mSv7O1HF6c2D655HNcAh5ngfK7AeTMlz3TELWttLk+P+ywH3u10wVuXCmoqv
         0vYm31sbVcVUpBzqsJ+3yUvg1r9lqvZYxyzX+EERQkwldkFzP/xId+YtJjTVJZwsHFR8
         D4YNYMvqk4Zkewd4j0WsOBVoSIfN2qOhteMeKZnyPLChkEJJOfmC0aCmYPcv0+LG4o17
         R3b1tb7BNRbCv/0Z6k1tWjfspxHLps1GY9pZRwW2pv/Nt77PICHa+2riyWJXvWDOf24c
         ElMA==
X-Gm-Message-State: AOJu0Yx23S7NI1y+LrAKF9CXUZF8cjPYQbBkOYc+OFr5zlkna4+/7h9t
	Ag+/HwHnhkvU0XMdtETyjitmeo1TMncGs9GHeOkllDZpBoRyL1mHitoH6pcqeA==
X-Gm-Gg: ATEYQzxqJFjqOTYO4xHaKnvwvdBJ4jB9Q/nLb8o0bIl864wkjiA/NLQzoSYH3L7nazn
	2kMz51gAx85Pj3nPfUJt72AYO3WmDZY/OLPdof3pLdK46VgCykV4s5zG30qFPQ6w+Yzf3SgCCt4
	XmUxLWDTG3PCSwinvNg5JuTkMSx7evvrOVb01m2Cr+biI8NDdleyS7Lp0sbgrZLId+KPJ9yD+hS
	UOV3PLAKQcsu+FHMei/DYAAjkom365Cozm7W4RuSNpnWGR3w4vBTp99J3U9qNpHAhpeBzYIVT2s
	71CCqsPkMjIeBT0z4/gJBgaUzBfieW/e2i8yh4Ao6OHgmevjwcvJelbRSBVTqggdVwsEjTYSNBR
	xZkxpLNjXMQ86suZmM7D+Zt/UA3vEEG866g1kKgbDDJwf57m6phShDt9sOL10ic6DkXShjPTaPF
	XoKxh4N5ZaZMP7IcSEPCNSMv/1
X-Received: by 2002:a05:6214:4109:b0:892:66bb:fdbb with SMTP id 6a1803df08f44-89a0a8b3f09mr33162686d6.23.1772559117784;
        Tue, 03 Mar 2026 09:31:57 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0fbdbcb0sm14883666d6.45.2026.03.03.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:57 -0800 (PST)
Message-Id: <6e9d4f3029daa2c0068bb16939b943e7ac924222.1772559114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
	<pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:31:51 +0000
Subject: [PATCH v4 1/4] for-each-repo: test outside of repo context
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
    Phillip Wood <phillip.wood123@gmail.com>,
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


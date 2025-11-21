Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B02ED16B
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723635; cv=none; b=AgiCgPURUIu3so53UXUE3FI77iiAMIQoyG+5CT5XilVakgVqtF+NTT67iUgeSxX3TjrbKzQBLl4GN9Ybe4RkUGPrPwNhbU3cbyx8J08gvEZCTEH3Jj5VD30gRUOCDw0QjkCIN+5qiuWV17m1ypQtR/jW7VMhjdTiKw70JuQ7Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723635; c=relaxed/simple;
	bh=KuhtwZwdLI292AJuVj4o4Z3Fv0WKrTXJAmh94iT9vAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d24hDbcu4cFjnTpw+DirYgiUDXLapHBMgui944rJQDqcJ3PSfoHiZFO72h49hBDK813x9D8DdvncdtKbZWGMzRb4WgnKXwWQLJyoC7EJz5anhIazQJjUIHdxEmr8VeM+alvmPizws/KsJZGDxTdXhv3iw1u27zSUETVBirOn5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJFiv/wx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJFiv/wx"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so3096060a12.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723632; x=1764328432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLzKNdSBF++AAOXi+SOWM27XRCh1kSdgJnTrtX/At+k=;
        b=EJFiv/wxZ81PjbQ/l5dliu52JWsVOcv4EzFVkoDIf7RtZmLpoKV0XPlODvYW5dgFgz
         Z/gL4u27fAav41XLCL1Q8j79omUMKMxcgdKotHKfxsSGNUgC7+E18dfXo3F/QdoXdlmm
         ZNIY2ByEYCmIlghr+8r+UqrnEd63/WEihIATPPglVl0mBl512ciKVU5qMXTgeLd2boeH
         8rU2VlMz3W0uPNbyEhlJyK0smgPedyyTvmuuWG2dsdZtaib6s9cfB7z8r2oS+NcstDEz
         YQcx19hwTa5HHYdawjyqoyXteVuthijUz4AWuilZt4ZkEgJqYblAQdVlJrW+Sq4F5Jjk
         v+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723632; x=1764328432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLzKNdSBF++AAOXi+SOWM27XRCh1kSdgJnTrtX/At+k=;
        b=l5E7ojbvtMnsDyMuzP0LO6xSY8nVafuphy5fRI5984X2W1G8+GWmWIhRykxO2cFIwE
         tPvgwwm22AnjBGhTZTePlUyBA6XpKQ8rbyqdbZGhzhIs4Ye5Fw6X63/iy6Oo01BIqUiv
         PKyG6ocye/ANVD14WLv4FmGLiRG4aI9WGjZ7XoYhy5sw96NnHkO6dkey1IQjMdIwv8fT
         fTuFcDq8y/rVYMgtDDL8QRzNTcEtroQh3csZ3DDOoEs/zATW117QARQdT2kzUhgwNBdh
         yjMSyAZ+DcK6+btbtCBJouiC8YQw72BFmc33RpDVc61GWI8EVSzyvON5obgQaJbPUG8Y
         7x/Q==
X-Gm-Message-State: AOJu0Yx2LmWRxI9cZMxG+PVbNheeBJZ361aWbU3U3fduwcibw5CnApdj
	uS/Gxb4U2Jo8zUwIvAqafhh89Uh3jqkEEGU63qtsw0SnLvZXiwdKma+S
X-Gm-Gg: ASbGncuOJvXvbFo9t/6kj93vkJKUd+nGRndNMtf3DlpFfNU//umrm3cZIHSG10UeSW4
	1ImyyvpQGmY3V5J9rV8pumNJ1jvUib1ERpCKc9IMd0a4L8Odnb2Ukgy9dRKNJHFs8Jotfivu6HG
	Lin/YAz1omSOiPXcJJc+xxyA6r0q4IiiW/12kgyYKoUcDT+pX0zBeF2TZ2G1xvtRb6nY79RlX/e
	UhsDndSqMI/laf7cD5SBYacRgtwMpEVuNm4fW5MEJHw4YjyMOGWqvLIeXNVnsXKIAdLf9JP9GKQ
	P2WARicf2wqfgDFhU97LA1Y/IZjTItf9hDQ1APc2cUBalyWGEKmorcwcnl1Bfi6TafxvrzZcTQ4
	2/gYoaLUVaDcyfPnoUhOb7PMO+6QBmU0OD4jtvlSMXPD1+xFPLgp3bak350sLB2C3SdrtPGQtkX
	0e9UgW6t8hI0HCOfT6/G6tV0S1F1xIVw==
X-Google-Smtp-Source: AGHT+IFfytaCCP6mqD0a+Zf8FEfpgw+qgvrYpBTRqf4Jvtx8lqxnG/JdGJ3QL2ByJtnWfrc6oNCUJw==
X-Received: by 2002:a17:906:c115:b0:b72:aa52:6034 with SMTP id a640c23a62f3a-b76716f630fmr171080066b.21.1763723631721;
        Fri, 21 Nov 2025 03:13:51 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:be79:897c:7a92:76c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm436206166b.4.2025.11.21.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:13:51 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 21 Nov 2025 12:13:47 +0100
Subject: [PATCH v8 3/3] fetch: fix failed batched updates skipping
 operations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-fix-tags-not-fetching-v8-3-23b53a8a8334@gmail.com>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
In-Reply-To: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4704; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=KuhtwZwdLI292AJuVj4o4Z3Fv0WKrTXJAmh94iT9vAo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkgSWymRBHUggOs2ZydYUEfLUzcWyJvMpI+X
 FaHQa8krFNzDIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpIElsAAoJED7VnySO
 Rox/i0wL/ibyTjnY5QSfNdMoIKx2Fe1Nj8lRDIqnIfMiXgmaYpmO2MwM1TdGTVZFP+MMIjiBaTm
 2OSqePpsmKFYbG6BvrtjIC2D7fIub/E5GcMAoCbG0KYkz+UmrIXfiBQSA0NcowcI74zQZNXYF2x
 LJuGweYWQPDxcPOr1WzK7KEwkveJ/3IVsDrsqt0B1mKIbof6grh6AULcfD2EJ0YlAaoWB8FnjHj
 /Ux/q2/6Qr9fX49HB+x/QeSC6s+1o7bAQCT6vYdzSQlaDuVN1QX/PRBQnxKo5XlWTBeJ8jmir8I
 iyd/LusxZU6JvIBY4PUVg3HBjmtCDDoPK3KNka25/aCEj49pioq9sxAm3qsBr7S4rKG4+WTZhIs
 heaXPu/8bMvEErSRmkLVbnoolxic64U+zEf5Coov+LiXS/95wIpcrEt0724PvIrhgsyJkRN9g76
 V+wjxNpfzi/Og5BFLjEUijrudq3gKIRpZn6GmoeAaLJicajS8zQ0A/yG0FVWLdx2/k6IfMdl3u2
 4o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Fix a regression introduced with batched updates in 0e358de64a (fetch:
use batched reference updates, 2025-05-19) when fetching references. In
the `do_fetch()` function, we jump to cleanup if committing the
transaction fails, regardless of whether using batched or atomic
updates. This skips three subsequent operations:

  - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.

  - Add upstream tracking information via `set_upstream()`.

  - Setting remote 'HEAD' values when `do_set_head` is true.

For atomic updates, this is expected behavior. For batched updates,
we want to continue with these operations even if some refs fail to
update.

Skipping `commit_fetch_head()` isn't actually a regression because
'FETCH_HEAD' is already updated via `append_fetch_head()` when not
using '--atomic'. However, we add a test to validate this behavior.

Skipping the other two operations (upstream tracking and remote HEAD)
is a regression. Fix this by only jumping to cleanup when using
'--atomic', allowing batched updates to continue with post-fetch
operations. Add tests to prevent future regressions.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  6 +++-
 t/t5510-fetch.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b19fa8e966..74bf67349d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1890,7 +1890,11 @@ static int do_fetch(struct transport *transport,
 
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
 					 transport->remote->name, &err);
-	if (retcode)
+	/*
+	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
+	 * continue to fetch head and perform other post-fetch operations.
+	 */
+	if (retcode && atomic_fetch)
 		goto cleanup;
 
 	commit_fetch_head(&fetch_head);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b113d7c27..a1ca4e1ac7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1639,6 +1639,94 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		rm -f FETCH_HEAD &&
+		git remote add origin ../base &&
+		>refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
+		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
+	)
+'
+
+test_expect_success "upstream tracking info is added with --set-upstream" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "upstream tracking info is added even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		test_must_fail git config get branch.main.remote &&
+
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/main.lock &&
+		test_must_fail git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "HEAD is updated even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+
+		test_path_is_missing refs/remotes/origin/HEAD &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/branch.lock &&
+		test_must_fail git fetch origin &&
+		test -f refs/remotes/origin/HEAD
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.2


Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8B359F8C
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057442; cv=none; b=CRn22qMvna0eVadmpnLtyjoYpXuLJCVGYbe2P/fRRvUAU7gSpaR8AHeT1EfuamrV099pAxPHH1n88gUc1qd/xZxV8DsEKUvUfP5a074WLuLX6DcAbW0L36Hm2UNYn+Te5IO00UYu/O3FhFsyJfURo/2DBVN9IuEN+JMI4sXwoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057442; c=relaxed/simple;
	bh=ujnHOCjJXD9a90Breisf5xqjLPnWHJPhQXzXl8QamFk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U+XzkBzWNy4NVAuMRZ/9OwD0wMsKMIz8ejXwpQSbBIVHMpX39cnoVS8LUEgz4RODwmQCtzmdurBwsf7JOrQHyBLWbZQTMlfhlhf74WNCkNMWOTaca8HtwwDPAAM3Lcpmr4LBllbSPYIpu6iyN+nm6scfdo5iIMYksu33WM+FPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtcimMFv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtcimMFv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298145fe27eso13012635ad.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057440; x=1763662240; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0te2rIJvsGdLJ27gUVXmQETyf2BDYYfc+/smxNyNFt0=;
        b=AtcimMFvIgR3v7Ptl/geh6Z9sQhKtc4vBhA3tW2f9FACnFzSoT1OmzHruaZT1GrBzd
         C5tob2tAHTjR32sK8BWECHQUuV5NWevOxMC6cep7EmrFzklbM5M/51WkQn4WAQ0AXaIZ
         8kEye6kJr2GsoihfbhceiRY+pB2XEL5QXYRe0dJUDsEso2rLK6FHdcv8VfE/FXD+J5EE
         wMoRWJGsLxDmNnJZprznt7yHT7Ka1r3r8WD9OoyWj6ta1OMu5Bw+nktsQ+NCuSFU2B2W
         XH9qS4j3XCdoG0zdCbOZsj4QGfBA0Bkr35guANVobYrmVIIDfNQZDwycjJGHAbcHed5a
         TJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057440; x=1763662240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0te2rIJvsGdLJ27gUVXmQETyf2BDYYfc+/smxNyNFt0=;
        b=Bf0gf+qGil0Eum/eX3ePv3gASPbgK4rHGMyAVhWbnQhZYmqBKhQjhDkA7Tl7PTWGBG
         PNzeRhNxDSbeGPlnsziUt2TF7jqERu2dFfTVXYhTyMuPO+M+HGDTo+je6OEHZ9ef4Q/O
         l5kpUT955V+5PtMWKt4KlC8DPedWHsoJj0Pu9WcrdWdES8K9c/9PMeYBhu94rh9chCd3
         wQzwIwiGCX0z4wU+y6U6CFDoRO5aZWHOUkBgwKKb+86GHUZia+QtBp/YSUF3BDNRtelC
         3XETGNsQXetLEmGiRRCaZphVjrTXgvjVbkNoJne95e7b0VxVo3R9bEh5IMd50S47eMBY
         x04w==
X-Gm-Message-State: AOJu0YxfckX/4R5C0uvch5UX87v9KfotEGSbLU+KD2qlzOg6Dmcv/uKF
	nf7A2UYwAveFCPooMRGCDyXUNrqF8wfG9UHLr88IMOXLT0J+nYrPy6mgU/2MAZH3
X-Gm-Gg: ASbGncs4kO5K2vyXMce7+i3uShleDph6rUEGAZhCfSmu7efyVyLxLOQt0sGfd6F96fJ
	RW48P+jrQA0pu71bOm1t9FhGmb/zhsJ7QZl59e+DxNcO6ohlrSqPfOOjcQBRoq407dC8pOw939g
	R+ApRHfsPHZjmtve4YNcEW8f9jSye9KflP2v9U9Y9DQfntBpokZ7Ctk3hWd1WFI+QmzLyESkmE4
	zKbQ1o5ESUsomBgfXbJg54xp6mesYv7yNk2Yr+1AFELIH5y/xmVQ44df7V9LetN8RgrGe+SZ5av
	hDzo8LYOMtO++e56i4cTwiHGQDoUT/B3UPj2mVVzLR7tgeQi+E/j4PnjUZQnrFRZF4FLko2yYAx
	vka9cQ57LrBkQs0n5j/c9XHIeuAxcHOb2BWyR9Fz+Ygy4V21YevxqwIQUd/Pr6Iq6N4sMKLok7S
	D4SQ==
X-Google-Smtp-Source: AGHT+IE+JobaUus9IIhu3rnyo7SFGj3Z6rGtIbL5eKp2UNiGs40U6ldszzpKR7oNR2jlxEbwb6aHHg==
X-Received: by 2002:a17:903:244f:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-2984ee0aba7mr93071165ad.60.1763057439524;
        Thu, 13 Nov 2025 10:10:39 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf158sm31726025ad.91.2025.11.13.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:39 -0800 (PST)
Message-Id: <93c95954f1fad9d52489798b7f9da0c94f92f79a.1763057433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:32 +0000
Subject: [PATCH v2 4/5] tests: fix existing tests when add an ignore=all
 submodule
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

There are tests that rely on "git add <submodule>" to add updates in the
parent repository. A new option --include-ignored-submodules is introduced
as it is now needed with this enhancement.

Updated tests:
- t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
- t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-update.sh )
- t7406-submodule-update.sh
- t7508-status.sh

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/lib-submodule-update.sh | 6 +++---
 t/t7508-status.sh         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 36f767cb74..fde5dbee02 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -95,14 +95,14 @@ create_lib_submodule_repo () {
 			git commit -m "modified file2 and added file3" &&
 			git push origin modifications
 		) &&
-		git add sub1 &&
+		git add --include-ignored-submodules sub1 &&
 		git commit -m "Modify sub1" &&
 
 		git checkout -b add_nested_sub modify_sub1 &&
 		git -C sub1 checkout -b "add_nested_sub" &&
 		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
 		git -C sub1 commit -a -m "add a nested submodule" &&
-		git add sub1 &&
+		git add --include-ignored-submodules sub1 &&
 		git commit -a -m "update submodule, that updates a nested submodule" &&
 		git checkout -b modify_sub1_recursively &&
 		git -C sub1 checkout -b modify_sub1_recursively &&
@@ -112,7 +112,7 @@ create_lib_submodule_repo () {
 		git -C sub1/sub2 commit -m "make a change in nested sub" &&
 		git -C sub1 add sub2 &&
 		git -C sub1 commit -m "update nested sub" &&
-		git add sub1 &&
+		git add --include-ignored-submodules sub1 &&
 		git commit -m "update sub1, that updates nested sub" &&
 		git -C sub1 push origin modify_sub1_recursively &&
 		git -C sub1/sub2 push origin modify_sub1_recursively &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cdc1d6fcc7..5c8ffed21b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1565,7 +1565,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
 	git reset HEAD^ &&
-	git add sm &&
+	git add --include-ignored-submodules sm &&
 	cat >expect << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
-- 
gitgitgadget


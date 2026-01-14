Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651448CFC
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376894; cv=none; b=kmeO+YimXXAtcC1WSPyY0xzeUl8wozYIrrTd4skM5XJ+Vy+VdytjM269kSd8WtE1IziJZ3T7PphVCzqweH3NN8Hs8pJxHqie2HI9Dk1DeHGjZL2drkUr/glpzcqZLecFDg+MKtTyAL/ryRMS3tzzIdIXB9PJCVIhhx1z3jCMnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376894; c=relaxed/simple;
	bh=sTvARXBGSIXdzWwsfu7sw/3xeP3O7wJtWoDe67PAeww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rCjnw38kV5gKC1/crUERhNviYSOpp6BAfOu6NqoFDxj9j7iW7t4xHfX4NfgPJ8TaQpgQ0iAFfkQsFLraFLVHKTvG3oNh5ipQ5pfV9cW83/+Ru2AG3ASVDGa6EmpaAi/sZbm/4WByIS2PF75Gq8IHbChc1cYFIZHLazt8yLYbxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6FrOLsZ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6FrOLsZ"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b04fb5c7a7so7955870eec.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376888; x=1768981688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2Om5lCEApDg8Xs3gJvXLdP3hhF22XIDCXkjS83JCZM=;
        b=I6FrOLsZPB9fc9espec3Aw72t/hgCaC0gFQ8g+5WjyBtVmP8/sDASddwQFCv9twwGt
         +/4y7vi7Xh1W+jMlG18s28NBsHfNLcNxIONLQ8yiRIVhQ6jvF08KR5JWJCmY+XEVrJMP
         iUV5k6nEzngN8LROYj7hpA5IAQTaSUEFfnYFKPcCrr0Koy6Pmjs+1sFjSC3c962Jy1PM
         MGGh5yCSUgdYRtXrUUxj7Qac89LK8pYq+SJ+bxCpagaJKyz+eRIDLzf4LHeZDsPS/s9N
         3fAz2BpDa7ll8aa+7udHwhZ8FFLtxCBdGiRiQy2B4qhviN2av9CqxwqkJKNcfXkuywDL
         JOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376888; x=1768981688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2Om5lCEApDg8Xs3gJvXLdP3hhF22XIDCXkjS83JCZM=;
        b=kPTsFVdQ2NKMv1I23DpbWORPu7UezW4Rr/0CmAXmvf0I/2OCKEekx1FX8/tEBmCY+s
         6qeP9CcBHiflFvCwpQ+haDsg1tUgCCEpvY/64MOgvKtLLoygB2lmicUw93dztZAhqOYT
         IJOZs5+6sGRNUnJu3c/kkJh7OEzAVZ+BsvAZI+DMIfSD5AQp56L5dPZzmJDRXzeZ/iPU
         KbwIVy/JGwswwvt9dUo13BUif/Iq/rxL4qfPwnPL09bWQ/x1Q6hIXK191SblYC/1jtkG
         RgOmezouF1kNLwLCsy5TmRzBcI0UNTAVNiZM6RHryR/ikMoux7mupkjF2Nz/USRySMiQ
         Uu8w==
X-Gm-Message-State: AOJu0YxEyZVs1WCkySPbSs3sln2QqzTgrbEq+F3HTpxbgDUqjU2D5zkf
	IIOnkcWNRIvPpLz5fMfctMnwPXogevJQAXwrgeZhdG3q2pmKRAmNXwiRhm9SzA==
X-Gm-Gg: AY/fxX5h5JBkXzrSb8+qKCvczFhPyn8mhZvBUgK8e52pvJghYZBK0zO/o1Q0LIF9Pw0
	l6zlGuITvvUqJpGQA3YedeS8rd5tn4sdCZSuhRgYgkDp2colphGd9lTwoo2yzywH3CoXGCAv2Ya
	9GxFNMMpbVEdL8zcNcMgOjX77Vzl3qIDsK69fOtCfqZIJ19jO+oVaQ9xoupmimI/Zlbi9XHEAJn
	cfGsDnpDtdhSPIlQzPb542vqkZjs6KNyNLBGyp4BMCFV6tnVrzHEJ5iHCH+fjHM2dUtcYPKuDbM
	E/tubfuSk7SmrZUCFN9kGnpsKJfnWnDjunzqTqaDlRaW2HVQECm845tUBp9y0SsPEQUW6FMqD6r
	6M7Rcl+DAuTCEI28IpF3CxQwyH7iUcPZCYqCT3LrhTMMoJIIm436pYsMjednCQSFaQ1zgXpw6eu
	HUkctZIQidUV5FSA==
X-Received: by 2002:a05:7300:a148:b0:2ab:9b40:fc78 with SMTP id 5a478bee46e88-2b48f5afa4bmr1578484eec.20.1768376888274;
        Tue, 13 Jan 2026 23:48:08 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm22342120eec.20.2026.01.13.23.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:07 -0800 (PST)
Message-Id: <6e44ab6804b6f50d19702b7a10e05c5d028f0da1.1768376879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:58 +0000
Subject: [PATCH v3 4/5] tests: fix existing tests when add an ignore=all
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
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

There are tests that rely on "git add <submodule>" to update the in the
reference in the parent repository which have been updated to use the
--force option.

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
index 36f767cb74..f591de6120 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -95,14 +95,14 @@ create_lib_submodule_repo () {
 			git commit -m "modified file2 and added file3" &&
 			git push origin modifications
 		) &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "Modify sub1" &&
 
 		git checkout -b add_nested_sub modify_sub1 &&
 		git -C sub1 checkout -b "add_nested_sub" &&
 		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
 		git -C sub1 commit -a -m "add a nested submodule" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -a -m "update submodule, that updates a nested submodule" &&
 		git checkout -b modify_sub1_recursively &&
 		git -C sub1 checkout -b modify_sub1_recursively &&
@@ -112,7 +112,7 @@ create_lib_submodule_repo () {
 		git -C sub1/sub2 commit -m "make a change in nested sub" &&
 		git -C sub1 add sub2 &&
 		git -C sub1 commit -m "update nested sub" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "update sub1, that updates nested sub" &&
 		git -C sub1 push origin modify_sub1_recursively &&
 		git -C sub1/sub2 push origin modify_sub1_recursively &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index abad229e9d..a5e21bf8bf 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1576,7 +1576,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
 	git reset HEAD^ &&
-	git add sm &&
+	git add --force sm &&
 	cat >expect << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
-- 
gitgitgadget


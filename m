Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752020B1E6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299121; cv=none; b=RXWIEph1ExBouMzgbS7tI0LdyWq8yFxtfpceyyqeUGZf4dJmyMfewo38xDzrsxyX/rOfDNYX+jgM8CGVfGIlPFmeIYbcjwDNFhZRrQApjRhwwc9/S9WshpyWY6UvUS6+Jiwx6YshmFeg6rUvEsuqEva1/a6V8EPi1GmaGAZWFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299121; c=relaxed/simple;
	bh=6RDRG+e6Lad8luH6RwQT+ZrmOrLBUP/E7iIlR2BW9Rg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LivIBhTa236cmPcftPEh8D6fPoM/AYOMHWkpSTe3gESZ1OvYf1+U5/HFUh7NxmOT/Imt14f1mJTFI5gfkY0SN1ikCOH7fXbH8BEiVkVxZ5uBZllljETNYdpQznPAcY9jIJlCWfCZLrV5KcId0G/gL5vC9NsX3UfamIBxGB4S9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTUONv5a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTUONv5a"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so21489355e9.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299113; x=1742903913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mtEg4O6CQwb1zUbAWqHTzayp15WYCTLUxUln/LBmE/A=;
        b=OTUONv5aRZQF/ldTxiLTW4SL9PwGvP88O8ft26Ppt+bZSrdGY59ORE5V64TqqeuWu3
         jsZiJR9NBfxknY1MldQrQXScEnf1jAzorjavmmh0V0c1jWoE7cLWaaYs0xfgRlITJFnO
         iMQuYGyZDkGhWx+42p74CsyiePmaE5ABkv12iSGNd9GQONVa+LH4JHB24+VlJzbVE++7
         aFnC987xWt/V03dPU9jy2TAW3/2fq2DQAhSmXUwFC5SZDx0QgYmvYlNGB0mV/SvDXWq7
         prbazLKgWOg8vELhTiCIgvycbs765WtClNJ8CfSjK1rzLCs2jbwUDYQCTPJt+hnAhpIX
         yvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299113; x=1742903913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtEg4O6CQwb1zUbAWqHTzayp15WYCTLUxUln/LBmE/A=;
        b=krmwKDbGSJUYrNDSnUnXkCUfHJwv277dC3Heeovj0daF7LUy7zZTHGziTr8X/JvGzV
         XXwKfMWfdqIuJA1Y17G65pg3cHJDMTolWJ3023kW7Eg6TDSD4S374sYf6G4tPcGUbVfB
         j6D4MT3JL2pELyIRvslxXYYaEEfQqx7quX83OBHJKFVSnD4KV3nDWTGqiDqK0ufsSMIR
         Qqo54WpQ/UuhJ9Usy2Wf214ypRj8QOr9DPnLE4Qfiv56Caf4LXvXrZkDYZaaO5xT5vPV
         B5L0P7Gky36X11FnswIm95hbaNGUP09QexEUMd2G4dizPJGCQNqFUDH/SGHTr+lrNX68
         pHVQ==
X-Gm-Message-State: AOJu0YySPVgWSiUH+gKfBMF56BkTi2naVgn4I6+ea7UocH/FAm8YHxQo
	rM4lVUPvgD2QTGBviSeTS//nUAaLQTHQDuZ4biGo+po6z9iPdEDm/ca5GA==
X-Gm-Gg: ASbGncuLrvWHo3bfDmM4r0lOPXPSXI6gOuG/8BDJ/u754o+auleRHXqTE/AGCsE2c4H
	9Hop3WNaAIB2JjfIEF1Ti4l1QRSr8KXKSBr9nZIAYeY+o1+Ra4YREw5+AHf1qB3POez08QTKbHH
	U5fDUKJ2G8ARJJw4nrE+ifzGXmCAsAeD0ky/FKEjN3yGaEXAe4YG7xmIINy7/MC/7MImL+zTav5
	xe5LUo/T7l4boIZulfhQX/EYRa8s7sbb8vuNNOgA0o6Sd1kHxt8wJfJaed6liVdlIPTyvt5CfJB
	DB73yyEhWew8WBgcppjVlSIb7wGKHwEh/BhfSsK59nTBj6cattTqUl1T
X-Google-Smtp-Source: AGHT+IH6IDvy6EET9btJWg+hGcRheLTyQC4qDPwcG3lKwnPSt3HbqPFmTaQwuQ/krGbTGN+L2/ObNw==
X-Received: by 2002:a05:600c:154c:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43d3b97f0bdmr16622605e9.7.1742299113233;
        Tue, 18 Mar 2025 04:58:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm133577495e9.1.2025.03.18.04.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:58:32 -0700 (PDT)
Message-Id: <pull.1918.git.git.1742299111861.gitgitgadget@gmail.com>
From: "Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 11:58:31 +0000
Subject: [PATCH] [GSoC Patch] Modernize Test Path Checking: test -(e|f|d)
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Sampriyo Guin <sampriyoguin@gmail.com>,
    rimo <sampriyoguin@gmail.com>

From: rimo <sampriyoguin@gmail.com>

test -e changed to test_path_exists
test -f changed to test_path_is_file

Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>
---
    [GSoC Patch] Modernize Test Path Checking in Git’s Test Suite
    
    This is my first git contribution. A simple fix as specified in Git
    Microprojects. I have tested using Github Actions on my private
    repository. Your comments and feedbacks are much appreciated. Thanks!
    
    , Jialuo She shejialuo@gmail.com , Christian Couder
    christian.couder@gmail.com, Ghanshyam Thakkar shyamthakkar001@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1918%2FRimoGuin%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1918/RimoGuin/master-v1
Pull-Request: https://github.com/git/git/pull/1918

 t/chainlint/chained-subshell.expect | 2 +-
 t/chainlint/chained-subshell.test   | 2 +-
 t/chainlint/function.expect         | 2 +-
 t/chainlint/function.test           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subshell.expect
index 93fb1a6578b..76393efcd20 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -5,6 +5,6 @@
 6 ) &&
 7 
 8 cut "-d " -f actual | (read s1 s2 s3 &&
-9 test -f $s1 ?!LINT: missing '&&'?!
+9 test_path_is_file $s1 ?!LINT: missing '&&'?!
 10 test $(cat $s2) = tree2path1 &&
 11 test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/chained-subshell.test b/t/chainlint/chained-subshell.test
index 1f11f653982..997f30eadd7 100644
--- a/t/chainlint/chained-subshell.test
+++ b/t/chainlint/chained-subshell.test
@@ -8,7 +8,7 @@ mkdir sub && (
 
 # LINT: preceding command pipes to subshell on same line
 cut "-d " -f actual | (read s1 s2 s3 &&
-test -f $s1
+test_path_is_file $s1
 test $(cat $s2) = tree2path1 &&
 # LINT: closing subshell ")" correctly detected on same line as "$(...)"
 test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index 9e46a3554a1..2edbeb5e4e2 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -4,7 +4,7 @@
 5 
 6 remove_object() {
 7 	file=$(sha1_file "$*") &&
-8 	test -e "$file" ?!LINT: missing '&&'?!
+8 	test_path_exists "$file" ?!LINT: missing '&&'?!
 9 	rm -f "$file"
 10 } ?!LINT: missing '&&'?!
 11 
diff --git a/t/chainlint/function.test b/t/chainlint/function.test
index 763fcf3f878..2f2a5c251f4 100644
--- a/t/chainlint/function.test
+++ b/t/chainlint/function.test
@@ -7,7 +7,7 @@ sha1_file() {
 # LINT: broken &&-chain in function and after function
 remove_object() {
 	file=$(sha1_file "$*") &&
-	test -e "$file"
+	test_path_exists "$file"
 	rm -f "$file"
 }
 

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget

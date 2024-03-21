Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFE133402
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052953; cv=none; b=iIZMO8yOcoHhF8g5qNwiw3ABDDpBUednjeb1zya7EUQGb1UEhzBsF4vgNIOE9OoVvgx7jV9FAQRC7snCrt1FEeZhUOoKgg7P9UilibMmOtJcO0xcoobZolOBMk8V5cG3yKQZSAj1bzT7qnWTjUqEJqcOzWjKGAxM9XL+3wmNDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052953; c=relaxed/simple;
	bh=TGhdwus/VX5J85zeAR/7/1Y5HkTTqocOu67CB4CQrw4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N5L1u2UOOiwf5h5qXsbp776Z81HED/75sG+b0R6MynfWc/1gnFsrvliGtmpQZrdWoxRqv/rWAgaF8SBH4aWZuRMArWa8Q69q2XC0jPzZnG40vJZZd3QhkL1bk6N6meeHwnnjSpJ7YuTUoTVNWe6If/nePmOKgwr6ZHppsOyg9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrfVZzl9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrfVZzl9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4141156f245so9976875e9.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052949; x=1711657749; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfzqRUpikjr4tFiZDQnD+q7FE5fMKcEiqXBSb22F80M=;
        b=YrfVZzl9sk4sj84JPS+ixpw7DjOj+IpdwRZtmV3LMhPKkGEP1QiiZ8uTPMqjGPdoYt
         bXjO+9HLxfzk/OmP9mnPwS6boucgg52hmSEIfki7PqjvMMaH+G4IESKcFiuJ+QW2xZZo
         95YLcN8scodNflae1e/K/AMBVZsWkXO52e1j/66Eezw6EHq8WzMF8wQxQxJHMWecW0DD
         Ss9S/6PO7w9V7Njdk5sOt63JZwEHxhz1KegBBOSNzHt8b0Y/KsQW/mUvcwloGNAaEl1s
         79XmdPIT4pGyp2V9ISMeN5+Wg2rY09nCAM+OSoMxWLop7HpN7U74Oxz+pUkRamJ9pn/v
         j0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052949; x=1711657749;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfzqRUpikjr4tFiZDQnD+q7FE5fMKcEiqXBSb22F80M=;
        b=KzLPWzr0fkzPlrBgWVqCr7nVUs2PXfdeGq2nBvE18QC79WUDA+sL481IcioNrpL2FI
         tDKodihDfkDGEasF9y1Wi0hE/cwQA9U+YqEXqTjTkUFW772tDExuK77DP474ZlN3+f2F
         tOdSIXIqozx5OdzWWJ4lUE3V+6CWTttIbfBH/OK6MCe77sVf3fhXyUQxA6E7tZ5VUUL4
         wztxZIexjQgulzkZvCOSB7ez4tPgOrzbLHlkm+ofVkFD4c2qYJr0ESyf/DqLbvXguLSO
         O+qJdQgq7soePLrkbRvzntPrrhg6tpkKBwWqOFrmMRsl8JtumCdmKEpbgibixkwdr3OZ
         nQ5Q==
X-Gm-Message-State: AOJu0YxzLohne3HjDRBN5PpoKOM2VhRRL7kZFKiH0Ee6PbulV43UQsE/
	UYRty0abPycAVpscpNCrEQkafyMHJ+ktBDiL4rHbY6w5hyZo6hpXaXkwb4+b
X-Google-Smtp-Source: AGHT+IFY+VHqf/Dvj+UUe2Rga7ctknI0W+C7qTfdxTUaInxs1ORjHYOJmw0yjRRlX/lFPC/2B3foUg==
X-Received: by 2002:a05:600c:1515:b0:414:6bc9:d01c with SMTP id b21-20020a05600c151500b004146bc9d01cmr149216wmg.22.1711052948768;
        Thu, 21 Mar 2024 13:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b004146bcdde06sm823234wms.6.2024.03.21.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 13:29:08 -0700 (PDT)
Message-ID: <b541ce7a49cedee5a3044af8b52bf1d155496211.1711052946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1691.v2.git.git.1711052946.gitgitgadget@gmail.com>
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
	<pull.1691.v2.git.git.1711052946.gitgitgadget@gmail.com>
From: "sanchit1053 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 20:29:05 +0000
Subject: [PATCH v2 1/2] t9803-git-p4-shell-metachars.sh: update to use
 test_path_* functions
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Sanchit Jindal <sanchit1053@gmail.com>,
    sanchit1053 <sanchit1053@gmail.com>

From: sanchit1053 <sanchit1053@gmail.com>

Signed-off-by: sanchit1053 <sanchit1053@gmail.com>
---
 t/t9803-git-p4-shell-metachars.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index 2913277013d..4905ed2ae9e 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -33,8 +33,8 @@ test_expect_success 'shell metachars in filenames' '
 	(
 		cd "$cli" &&
 		p4 sync ... &&
-		test -e "file with spaces" &&
-		test -e "foo\$bar"
+		test_path_exists "file with spaces" &&
+		test_path_exists "foo\$bar"
 	)
 '
 
@@ -52,8 +52,8 @@ test_expect_success 'deleting with shell metachars' '
 	(
 		cd "$cli" &&
 		p4 sync ... &&
-		test ! -e "file with spaces" &&
-		test ! -e foo\$bar
+		test_path_is_missing "file with spaces" &&
+		test_path_is_missing foo\$bar
 	)
 '
 
@@ -100,8 +100,8 @@ test_expect_success 'branch with shell char' '
 		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch\$3 &&
-		test -f shell_char_branch_file &&
-		test -f f1
+		test_path_is_file shell_char_branch_file &&
+		test_path_is_file f1
 	)
 '
 
-- 
gitgitgadget


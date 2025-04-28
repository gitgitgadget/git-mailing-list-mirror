Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E658836
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843637; cv=none; b=ZFYom3XzuqAglQ23lY8cZlorL0JnMx+7NfMll76JTec5auvH9Lvu+BQeFbnXV7O6K6e1KIFPdESusSJ2bwXOK00a/7aazHkeG6Efq+a8ULEKvFLTBIo3yGWnU5EIQ/amsaQMO5SkCZSj/V/94XC0yV6XmbQ3PaNcRp54UFJRkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843637; c=relaxed/simple;
	bh=rGdgufDF1gCLgcxBZX8+maSPgKMGzUNFaZgCsWnvhhI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pFLmKr8x4QdeiRks/q+FMcJ63i1/sV4Q5rEoMXsi+Q5YOlceb4nrtS7ys0E9VGniUAX/mMOMaq9W6GYmL0W2j3acPbVJuK9jYTO7wF5N2b6sqn7saiawr+PpisWMg3vNgR/u1sCXuxIa44RG35QC/iLR5NXaZ4Or3NGSPNqSglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5Llx09k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Llx09k"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so30313245e9.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745843633; x=1746448433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6NtHXY2Kuc9+JtgM/DehJCLpJ+syvhlY8PqAJ2OL6m4=;
        b=K5Llx09kTlGldBQLxPKc/Qnazu1YpVMhM5D7OqY3DpjmTl//Yub6FzSa0+VZ3cdqfH
         Kk9dLZj0V+POuP09CCq0xHgISVtFR88c7VE3KvQGWYxtIVgUqVktAb07D2wcOrU0SIm7
         nXamEYSTfKW6mH7UG7vWzm0Wm1KIMkoBrv9DwVljMlVrlJM6VY/geAH9B/CHiGIIGiv0
         njOTV+EUbb32oN6DvjnkK6+hRfBvjAL0SPeuGwOL1wfLJIDz/+YHFbxXBhCk8mxx/pPe
         WcI/hSzkczkTtaMu6GPvndnzil6baKwtIE2sFzMCoBzPlslN0d3KkyvCvRVt1v7ipmtG
         ak2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745843633; x=1746448433;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NtHXY2Kuc9+JtgM/DehJCLpJ+syvhlY8PqAJ2OL6m4=;
        b=qndpEekBxyLeMGdEWdCVPBxFRDbblpZTM/jEFJVrNTbdzHH6F3hqbn3jjpp0j4kt0E
         fztelQi8BO8Bv2v2iX87NF1+mKfApr+wtucfSJ8ZTd6lGZtsVbu7NFNrYsECoY5TmVHi
         tToycVa3T9G7aclm/FgGquypuvUgP5HjKw+jxtdFV4INwPYvSCrxaI3wRSD6WAmeVD2o
         W8EVXEC4+kuUGK4IiMTl0FSxCQD2POD0zriy09MHHtS+x/2xzXxIlC/ac8XuRApsgZc/
         IB4ZNwQp5oAnAUyw3znNFiUpZZCnBSShRbKfgQgrjaTz9IyqWZXaRjcYxfcIZcXoxZoG
         OMEg==
X-Gm-Message-State: AOJu0Yw4h2xRmVK9R1TYje74Bg5fyIVNKln5EDufTzk8Ler826+sCt2n
	bWOlWIRryCl7CpHurcs2j381tsRQrStpBzW9snqyIGGKFe7ho7b9ACrqQw==
X-Gm-Gg: ASbGncv0h2W5Y3pP+pMnSNEwsBIioT+J5ZjqQOCNewNIlfDCBXHiX6sBgKG1qRGj6iP
	oztVQGmiF3eAdNsLbDU15p6sHCVnlRp1gqBbARelz1qM4fSGib396UFHsZO555w/WrIQJNnEtO3
	+3e1Z79adSsV09rzhF1Gtpcb1tOr26Gon7X5zc5JiBICLtPjQseVHLUBN7DWA6AoXxCo7VPSS5w
	6SqlZqwhmexUfSM31e083H5OTPXyhG9ujAGWPvmtRnpAD5dYNYATFTiM3kMWEbIAkhresRgkqod
	mrQaeQe9XsAMdnXEWyCFkZi3yGFOFDFMxLz0VM2UqQ==
X-Google-Smtp-Source: AGHT+IHi9V/fF7/fGlE7Vu5ZP6nbq/rE8a+Ua48xGhSHy25LFOFnEPc38r3xfU86j4mOzz5mQSoK0w==
X-Received: by 2002:a05:600c:1e04:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-440ab848c1amr70148665e9.22.1745843633345;
        Mon, 28 Apr 2025 05:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53870f9sm122545585e9.33.2025.04.28.05.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 05:33:52 -0700 (PDT)
Message-Id: <pull.1910.git.1745843632085.gitgitgadget@gmail.com>
From: "Richard Quadling via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 12:33:51 +0000
Subject: [PATCH] Fix early wrapping of the command line when using
 git-prompt.sh
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
Cc: Richard Quadling <RQuadling@GMail.com>,
    Richard Quadling <RQuadling@GMail.com>

From: Richard Quadling <RQuadling@GMail.com>

When running git-prompt in Bash, the lack of \001 and \002 causes
the command line to wrap early.

The issue is the current \001 and \002 were not themselves escaped
and so resulted in binary 0b1 and 0b10 being present, rather than
the strings "\001" and "\002".

Signed-off-by: Richard Quadling <RQuadling@GMail.com>
---
    Fix early wrapping of the command line when using git-prompt.sh
    
    When running git-prompt in Bash, the lack of \001 and \002 causes the
    command line to wrap early.
    
    The issue is the current \001 and \002 were not themselves escaped and
    so resulted in binary 0b1 and 0b10 being present, rather than the
    strings "\001" and "\002".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1910%2Frquadling%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1910/rquadling/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1910

 contrib/completion/git-prompt.sh | 2 +-
 t/t9903-bash-prompt.sh           | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6186c474ba7..4a64aca3eda 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -147,7 +147,7 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
 # like __git_SOH=$'\001' etc but works also in shells without $'...'
 eval "$(printf '
-	__git_SOH="\001" __git_STX="\002" __git_ESC="\033"
+	__git_SOH="\\001" __git_STX="\\002" __git_ESC="\033"
 	__git_LF="\n" __git_CRLF="\r\n"
 ')"
 
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654e..fc6fdd36c69 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
-c_red='\001\e[31m\002'
-c_green='\001\e[32m\002'
-c_lblue='\001\e[1;34m\002'
-c_clear='\001\e[0m\002'
+c_red='\\001\e[31m\\002'
+c_green='\\001\e[32m\\002'
+c_lblue='\\001\e[1;34m\\002'
+c_clear='\\001\e[0m\\002'
 
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget

Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760626A8CB
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964115; cv=none; b=XfegOugdKAhyKVIUFDaZgCxKfqclA0BcLyDWffz6Z2VfbkqbbfQZF8CmuL7w9vP4f9LRZnSauO7+okI/N1mzN+JW8/rGf0lbqtnEfSr3sLGNt+2POvyttycnmOG82Kg5qSV0i8y6TwcgLhotC1sWjPHVLwz1NUVvBNmoTbI9T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964115; c=relaxed/simple;
	bh=pa6DPFCcTB+Ll4ME99JCWpVo9tE5KsXvripMygsgtPE=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=abVWLvYDIKIZ5CmUbec8lbppqC166g+Nng0q4kVKybm5t2RKYzGa1t7HTM56wJHunCoRb/TieLP4Nfw9y+q2sGLDV0+/xcyICMqG1ZY/reDE4HJIIqMLyDpOE+8ZTi1vh53ZjJEV90f2Fy27eK6PgvsnnMp3/3PAMtfAy/IFSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkA/ZFth; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkA/ZFth"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41413c99748so1884075e9.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710964111; x=1711568911; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++ee0WVCL+PerLenVodCb2xi6NjxPo5tqYqOgtzBcao=;
        b=QkA/ZFthRSdrEm0OWsXPGZLfeZFwBcyWUIrpdb6scMCtEwL5VUY79+4aCCESs1FCxx
         NwyyaLkOfisTxBKHSEBx/dTzMvENwPVQ92PGb25EA28MUozGL2jTfnJidAvs+e9HO+4w
         fkJzGFE75Xp5FT7Vu3fRFOGe/IAGt8TGB17Ka3372e8N23lMgF1MzoOfObkc740y7tCt
         BzELvx5kD177yjQ6OOX9v30L0Vpgkqtmfbx1IAPcYJIjLNhI9bNB9VNmQA++RmSjjQLd
         GYkTA9emHVNSPkV80vCjn42oNLYE0AgB1cA28WqVvFpbW63uiMn9XMmbuo2EAxm7vXWd
         sVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964111; x=1711568911;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++ee0WVCL+PerLenVodCb2xi6NjxPo5tqYqOgtzBcao=;
        b=wdA+gLMLUBYwdS+hto9R/F2WL9ZuNDQt4+1iVSln6ykPUkpi1r/5Tjb8AtwVEjghWy
         3M4EizZemXss7wkDl9q6k0F4OU3jZ10616HX9tX+chBlkKBt8tqWrawcLxdzbv6QjAPr
         SMxUWfa19En9556AW8sbU0eeLubOcfgIfiMFqb+a7Ltu8MP8ZHfVNnN9s8EDY3yDB1mc
         X6yqVxpqa5bCP5HRQlbNINm1eurFQnH4oP/97ul4tbHetwDLMlpkEazSmHggU2suOyqf
         5ghVcWmVM1i+Q3KNqMBfVq+MEjZ6a5QZ4B2g8N6yybbN1cHUWzyVqjwXBZL+vcZ7MD0v
         5pqw==
X-Gm-Message-State: AOJu0YwtqlRnpGSyaoEez/MH7SvET4R4KNVAJ5O7IKXelZ+c0OUlyyVV
	NzU/eSAqEfBk/dXdlhfRGmBhxnWoNroJt2HYdjhVm9t9k3EwgtQtmiqeHlan
X-Google-Smtp-Source: AGHT+IG5cDPpt8udbp87060So5BwwwN0T9BusExAYEzS8WuGPH7k01W75MZibPCuwe2XIX66GCj0Vg==
X-Received: by 2002:a05:600c:1d28:b0:414:101a:fa67 with SMTP id l40-20020a05600c1d2800b00414101afa67mr2494248wms.18.1710964110853;
        Wed, 20 Mar 2024 12:48:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b004146218fe01sm3183623wmo.22.2024.03.20.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:48:30 -0700 (PDT)
Message-ID: <pull.1700.git.1710964109659.gitgitgadget@gmail.com>
From: "Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Mar 2024 19:48:29 +0000
Subject: [PATCH] t9803-git-p4-shell-metachars.sh: update to use test_path_*
 functions
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
Cc: Sanchit Jindal <sanchit1053@gmail.com>,
    sanchit1053 <sanchit1053@gmail.com>

From: sanchit1053 <sanchit1053@gmail.com>

Signed-off-by: sanchit1053 <sanchit1053@gmail.com>
---
    t9803-git-p4-shell-metachars.sh: update to use test_path_* functions
    
    I have updated the statements test [!] -[e|f] with the corresponding
    test_path_* functions The statements are at the end of their respective
    texts and can be easily replaced
    
    I am having trouble with the git send-email and my institutes firewall,
    that is why I am trying to use gitgitgadget

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1700%2Fsanchit1053%2Fsj%2Ft8903_use_path_helper_fn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1700/sanchit1053/sj/t8903_use_path_helper_fn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1700

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
 

base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
-- 
gitgitgadget

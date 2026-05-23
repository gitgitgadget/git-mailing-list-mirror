Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A24381B1B
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534468; cv=none; b=YJ0D2siOZBfJIYp/8ZEslHejGtgNkPW3X+nI8zH9n5KFqbPCRj3RTs783jLK90VxdEncRFK00dpG0jPQKeU7Ryv5KcQLDUtVKDqGbrBK+UMgrmEYqmyXCo/vgwi6bV1tPBq6h7Wzf5J0zH6FUwM3l8YPvQSK5mp9j7q5cAiWT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534468; c=relaxed/simple;
	bh=urspriZ0fKCCMiwEsdk8yk2ejx/eE4/LNGH62MgGsg4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pf8xWotJait2bVSVA1xBR8JjSzSrXWSYvVhUmX+Z40LtTBJ4tZbteBMFoxrIxJ4UOyul/8VaPtJwXTHxHpexeC/wmFHqvCds42bhnO4uRUMOiEKHnA64fb16Fp44xin2L82oEeIc+RAa2tRB6tzPfXLmcTfPgA42ZlTpVnnac3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbfNAyy+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbfNAyy+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso97201436d6.0
        for <git@vger.kernel.org>; Sat, 23 May 2026 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534466; x=1780139266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/2yMQEGTFy/uT5vZjNUuyAN/lEYNNrDQUHRHlXdw+Y=;
        b=KbfNAyy+NmKrScElwTuoLVzypYnvx+SFPpneR7zLukcyQnFl3h4OOkCS/NL1h51JqA
         b6pU3UB4+/Y9v8t9Wx4tiGRBWDjB3AkmdVew/xDhlVJPJzzWDe9IFIIKlttJULafM45d
         R+gTzgZvilD9PLbXPDHaU1athWw8sKiLrf2piWsxcdBXVvN2cC6BocOLHBXor5nRn0Js
         tO4EuPSROk/Bm1lhBa8jXOJ4V96kF579ubiZG88ivf3FvDZ1kuuVW1msWdWAHIG/+aTD
         UNGrqqRF3OfFKP0/CL+UlwCOxvNnB2szhJCI9snXek6faCqUi+Btw5wS3RQTwynwcYU5
         AaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534466; x=1780139266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g/2yMQEGTFy/uT5vZjNUuyAN/lEYNNrDQUHRHlXdw+Y=;
        b=qIjlNJUv0Us1eUBMRM7aEBPPBylfu3WHxZV8oOpVWrVn9cf4WFH5kl7mDgdK/8DpV0
         SzsQuAyPBCxGD2jyXnKCsyGUupF+pHY0sYd3GyKEcTnlMwykZ7N7m2KiMCdWBi/Z4hrp
         e+og7NOOk3YWdUiorTApar/WzSRWDchJP86DeqWCheXyP+5EkhotH2IVrr3ZCFMMxSs0
         djYp2YvMrF6UhhE1cyl2BzJ3h4hRdBDffpGmRiohLR13bJ02ql0CYK5uZfttJDS5GbNn
         N8sjrunS5e5E+6r710hzdc4XHj1MDK3WfRXd6lJQ3WZKAG61gsQ9JdoOMvYGwE/WtEre
         cBpg==
X-Gm-Message-State: AOJu0Yx6OoXdlBRsehSJwG0ESm46Q8dM1VRTO4HamrEq+cgXun3nvWFn
	t4cQ9ntg4+UlVWLtYDaywvJ+50ybNBP8O4Klq0mC7gef5whZ8yDZjrmpYkqK1Knf
X-Gm-Gg: Acq92OGFumTi9aJC9A168VcvHrLPbMY3m1/1EdEZ3j7BtXQt3OzwLt5RelzbBdyiD5i
	ti+ZFSfLsiJ8E6BvPKOOKJ9I3oeycd22ZQiCXpU6amu/zRGWTpFCM/eor6KfVdiWfCx6f4rqAt4
	n8Mi9RiiNXuX1v4eQBIvDyQwLoA+YV3kS4jqj4wNBAbhv4vcIw+u9Lv4syE67D9ehSzYQCWLSPC
	QtHauYcLUWhZiRw/vmco6ipnEgFcyl152h11+n6R1iD0y3WMyNtLTWwsWpNPvkilzRjfGh8HunJ
	JEuyzh1sCK2ywL1VBMh2LPsUQ4XRDRSivKOEKsqAc8vPIBDJ6Zus1fA0NqcwfgZWnbBLdL7BJ+f
	cR1BZHvIopqx7XX4gd9Mil6WiB2l2V85goSqm5DOdYss3lXE1uKyxjB18YrYPSWe+Ka26EmZB8l
	oakAskieahgdUhDYMwraqajqPw5weoCak6PvXh
X-Received: by 2002:a05:6214:d86:b0:8ca:1cee:7c3b with SMTP id 6a1803df08f44-8cc7b6759f5mr123418726d6.29.1779534465912;
        Sat, 23 May 2026 04:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80df8b6csm45493736d6.20.2026.05.23.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:07:45 -0700 (PDT)
Message-Id: <87c80205cc3c7be131cafe37b786311a35b4e044.1779534462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
References: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 11:07:42 +0000
Subject: [PATCH 2/2] t2000: cleanup unused debug code and variables
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>

From: Zakariyah Ali <zakariyahali100@gmail.com>

Remove the show_files function which is no longer used after removing
test_debug calls, and remove an unused tree3 variable assignment in
the second test scenario.

These cleanups address feedback from Junio C Hamano regarding the
modernization of this test script.

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index 43ec901f9e..7b61370549 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -23,17 +23,6 @@ test_description='git conflicts when checking files out test.'
 
 . ./test-lib.sh
 
-show_files() {
-	# show filesystem files, just [-dl] for type and name
-	find path? -ls |
-	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
-	# what's in the cache, just mode and name
-	git ls-files --stage |
-	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
-	# what's in the tree, just mode and name.
-	git ls-tree -r "$1" |
-	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
-}
 
 test_expect_success 'prepare files path0 and path1/file1' '
 	date >path0 &&
@@ -96,7 +85,6 @@ test_expect_success 'checkout-index -f resolves symlink conflict on leading path
 	git read-tree -m $tree1 &&
 	git checkout-index -f -a &&
 	test_ln_s_add path2 path3 &&
-	tree3=$(git write-tree) &&
 	git read-tree $tree2 &&
 	git checkout-index -f -a &&
 	test_path_is_dir_not_symlink path2 &&
-- 
gitgitgadget

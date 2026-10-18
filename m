Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3123955CB
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299947; cv=none; b=QNWZdoGAU9Qr1OGc/EQbpsTJE4rY7rPfMhHiYTr4Vc+FfJyDuA14CVu/sUaLPalHIO5+IrryE/GGpnLsM0kx/sq+YQQrEyEWOXGLY2PIC9xOaOHpPAIYcJRygdgwasvX2ZuL2RzMa1TtcwdQZ0aDBl5U5IBQHeZedyyc3hTtPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299947; c=relaxed/simple;
	bh=GhvrTD8yuVPuc6Uve+e19bdSFNHcdiC4V+asgZy+xoQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f3BEcFyiwBTuwXoqm2ZKVkaqkp0WElfPVmR+6CzcJjHWwJzoiPZ8kJaddDzjfg7o4sxag/c+NJzTbIwWNIhkcJJAP8LdMdZfkWYMdjh+HDGIrUSvHTmZgp/5QjpDljmStM3XqytGpe5O977/01xvEQ4sSL32ptU/fdsZ6y13/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxFNTpKr; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxFNTpKr"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35ef6b49813so2156744eec.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 22:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299945; x=1792904745; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rf0BBZGvtd7v2fBEEuD+D110G6LcweqiLNq/pPqst1c=;
        b=GxFNTpKrq/lgQpZSGWywE4lGMHV6sKK+SneIm0bsGS8PcGz+AyECsq8ex7KC/g+FMn
         JTilWtvBjqkQyPtEr3Ge6LYEevKq1yuawIMQmlC6MIto8OJoh2c51V7hzl5eUAgn/mjt
         d5qC6AF5BwxFWkqIpd1J0c9e87ke/1ZF/HbUkNyA/e1ki0gD/v42scFOkyZ64aqHfK+C
         LZ7S9NadcEVnURTQfQrOetAXmrv41qAyTmIJaBIDCEd9r7rko6WLrYtXc3YPtk0wUTi0
         NLWpA8XioeNbnYnFAaDhwtFnTeAJFwIJ6n9KvRWevRKYXupOhkafoAMipCOWwSBIfvJe
         yQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299945; x=1792904745;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rf0BBZGvtd7v2fBEEuD+D110G6LcweqiLNq/pPqst1c=;
        b=mgDaFWa3DNu0ToMZ47pFA5UKAAAWG7jzAJpvrX5mIInFk/j3gERdQCUnnUoXqn6o/2
         leTJ5DCBjgq/rEN7Xc+KvBffkVQHGxqq/3MPDaOCBGtYQIStEYbrFWO8PYSPkEdJTkiH
         nP1TzIFa1dqkxdEMOZHrmHwQB/jg3wuyh5aenFFPaMqqeukG2s9L71WqPvubD6NzWGNr
         Z2R1thDRxTQl4aS3h1bOdX78CeaqaS7reyRNTF4x9V0RwWTVNm32RmfaE6SVcSUjOfU/
         ZlX6+kDU7xqe3sczYKryZXWVv98f578HTv5wNuKDesCCZnEkKG2lGJd+LjxD3A9cIGgW
         kTIw==
X-Gm-Message-State: AFq9FYLSNNOdCjoCMDMtIdsau/fogsbIPRT1r+vZXKZOua8yx9lEeYqO
	TX2cmlSpWJIhnAwU7bXV79VmD2WP9NtolkCBIohaDngrxmEi1YqrplSXsWbSzQ==
X-Gm-Gg: AYBFou3dp4qBjjuraLVz8AzNnTWD2LFK7O5Zt+fqqee8U2atpoJugi9vup5UatuwKPO
	bfSKjKdHQo5s30jslZxlFgJmgjpPJu1TTO7T5IGI3itNk96cG7n5pLQAQMWRjM4/L7XKfDi5VTd
	/QzpfaWMc0EX29PULj7cElGTJffEKexXtVpTEyfEeS0iGUYfyogc7TpgavU6XrNT7ZxoAznvggr
	yv7diR32ybUuuzEEwEAmax6XmZdpRGrGHidvRDXfq8Td8sWMx7lAFYUY++lqgTHLmPH5v7W1JwH
	wlmejk+olNFjVSsocRmvLv36yo83HLc72XNhkzwvSqixlQL6dMB756oaiyEV9lfhfr+ULeGo6n7
	QXiTtGUwWvXohXsulTezDJEtEN4+fVgDQMFfjrvBtSbDcS2OJtyregDNiPfQxPsYFtpRNH1F8Mf
	CyUPBJVyBE600UvkJjTyd9H+axTrWwyKmcLNVo6rW/wkqDyBjJDmCrXaBPsHNxF6Kv8SFPejUD
X-Received: by 2002:a05:7301:1884:b0:35a:4ad6:d215 with SMTP id 5a478bee46e88-361a2343db8mr6091415eec.22.1792299945118;
        Sat, 17 Oct 2026 22:05:45 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.99.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm35115651eec.28.2026.10.17.22.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 22:05:44 -0700 (PDT)
Message-Id: <pull.2256.v3.git.1792299943380.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 05:05:43 +0000
Subject: [PATCH v3] [Outreachy PATCH] t2030: modernize test path checks
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Replace old-style file checks with test_path_is_file and the helper

test_path_is_missing for clearer failure diagnostics in test output.

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    t2030: modernize test path checks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2256%2Fpoojarysrujith%2Fmicroproject-modernize-path-check-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2256/poojarysrujith/microproject-modernize-path-check-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2256

Range-diff vs v2:

 1:  93cf6c12f4 ! 1:  75086e1db0 [Outreachy PATCH] t2030: modernize test path checks
     @@ Commit message
      
          test_path_is_missing for clearer failure diagnostics in test output.
      
     -    Search with: git grep "test -[efd]" t/
     -
          Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
      
       ## t/t2030-unresolve-info.sh ##
     @@ t/t2030-unresolve-info.sh: test_expect_success 'rerere and rerere forget' '
       	tr "\0" "\n" <.git/MERGE_RR >actual &&
       	echo "$rerere_id	fi/le" >expect &&
       	test_cmp expect actual
     +@@ t/t2030-unresolve-info.sh: test_expect_success 'rerere and rerere forget (subdirectory)' '
     + 	(cd fi && git rerere) &&
     + 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
     + 	rerere_id=${rerere_id%/postimage} &&
     +-	test -f .git/rr-cache/$rerere_id/postimage &&
     ++	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
     + 	(cd fi && git checkout -m le) &&
     + 	echo resurrect the conflict &&
     + 	test_grep "^=======" fi/le &&
     +@@ t/t2030-unresolve-info.sh: test_expect_success 'rerere and rerere forget (subdirectory)' '
     + 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
     + 	test -z "$(git ls-files -u)" &&
     + 	(cd fi && git rerere forget le) &&
     +-	! test -f .git/rr-cache/$rerere_id/postimage &&
     ++	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
     + 	tr "\0" "\n" <.git/MERGE_RR >actual &&
     + 	echo "$rerere_id	fi/le" >expect &&
     + 	test_cmp expect actual


 t/t2030-unresolve-info.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 9af24b1204..f6f5dd7cb8 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -170,7 +170,7 @@ test_expect_success 'rerere and rerere forget' '
 	git rerere &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	git checkout -m fi/le &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	git rerere forget fi/le &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual
@@ -196,7 +196,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	(cd fi && git rerere) &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	(cd fi && git checkout -m le) &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -208,7 +208,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	(cd fi && git rerere forget le) &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget

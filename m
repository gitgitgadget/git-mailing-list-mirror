Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80A33DEFC
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332207; cv=none; b=ZshL2zDeoDEd5yFe7iYW8ANK5cgifnRmR0/J9AApNqqWeq45wcnMGtEink2hiJc4n5WQReTzUuSF5WboY+dU1zn0JTI9mIrFaN7O16uCLX7+s1NMEfdneH0n4HhIAIy1BDlwpOF7VubjxHhPDKV7IcmnryZvlB42MWqua+bZET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332207; c=relaxed/simple;
	bh=FZ3aKJNnoJCtsUbKksVTMbcxKtdv2bo7JLtxNwpmcFU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AGpQYmkvL1YAbN6YBetUS2OsmvFay2o+YoARoJvED+TM7KIsvgX42yw6OW4TIuP/eAg0nTZ4LJLlPmMestNRluVI/GIMrXphFMAbfTT4udz2p1sxOQOaiihmsSVX32p/YA2TLUo+I5tq6xg23zSo6W5aRSRu9R18BfN3kiUkETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuuQRvrq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuuQRvrq"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506251815a3so27968571cf.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332205; x=1775937005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hggOdtI0g8ZSbIRj+zy0lLMuGqdlSpGOoFYebO+v6jo=;
        b=DuuQRvrqDAitwis1/b4DqorG9jjNHQ+lZSWuB7JEAuaS+LkfzcsyAwFqPrwbEhyf7T
         7MzwaJ0eUQj0iAeoKLFXWVntdMZmrVeeJm9//pNXmdmMCHO2Igoh0Hc1OLkYIVeH47Qi
         M0vkI/U5Nk9YZrFVtp8bd4xzKvC7KcSCj+CN14OBduAKhhrT7tQKnnb7o7UYmjRl9q+k
         UzyEkICtaewLVJqOghV31SDLO0D/fSh3ZtsJdUR6D+1KkzrB+O67T+nfCxP8oCwK471k
         +8xiBwFpMejL8uH3hHri4kY/qxYKDN98AoZANu6ZZN0bm09Z7BgbCtoQLXK4mAHrTBbX
         t7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332205; x=1775937005;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hggOdtI0g8ZSbIRj+zy0lLMuGqdlSpGOoFYebO+v6jo=;
        b=KWzx67DuCDfxrlQFIkY5csDhLKuPKxyd70AX34HcxjbliNOvBq3Isl6Cla61G1IFj+
         q1L3va1khupag9KaN6I9f6uZW4D4m73J7YYWrIk5Q3ndYGS1csHuficK5BU2apJy54Ql
         HsWnhiQo6l/6rYVDRjE6EQFY2sI2d1b+vEPsOhdiOqm20eN9WwGFU5VwCEXExR0gwXYr
         H97/cN/364B5uC4Avw4jk7GlIjXXFg/tD7NEdgmdBZY2Vvpo7eEdBiqp1ggy85hSU71L
         hyK4L8OO7vuHbuhB3CQW3n/WgRRUUsuhfMrzedYI8aDGomxt8YhbGPrCRYhUD06L7o5c
         5+gg==
X-Gm-Message-State: AOJu0Yyrdvb5p/vkB5Mmf4xFXbvDjYafDL0BnfP59Nu4jMNsmcLtdhMa
	QPypjt/2S2gOU/FNmyJCVVeemeJ4xPznUTPzcVezjcVTHdmejbSasymwJar1KoFn
X-Gm-Gg: AeBDievHiFiJAA9a/neIY7Gee9/Vh1tIC5iJhxz2Y/MWX+2loDOT/uLXdeazqTIec4Y
	iEszTyZ+3oFwJDTtn2lyjq+RdQIVQT2sd+x3fXggDCGTN7K3+lenNR6yyrCScrbhd3B8ZfuQq9Y
	9vv5D+T3+fILHVozKDjmAbUJ2I42MXTOPsbLlPluvX3amScbI0uuttswQnVbyk8UfoFW+4hQVeW
	9/+tGgdrGTHv+j70PjAJ84WO1IbVQIOIg8ucbc3uq0juu13rMEjYX/txVBm3Ulil9pW0DZSzJZ4
	Ae0nirYnBEqqGsutcufiJEjg8/xxXOIxh2DHd0/TflJLNBR/PrrGCKkMptR72e3tgl13Wi1d4wM
	SZI+7P9lREx2vJgnKjkgmdMWv0r8gF+8jhzVz0TJr4rcP2JKTvAeUPC43Hs3AatdVcae56LcLuV
	K6Cxff7estwtFSRYfIUU9Et297WpM=
X-Received: by 2002:ac8:7e89:0:b0:50b:41b7:d6c2 with SMTP id d75a77b69052e-50d62ad8295mr116463171cf.47.1775332204776;
        Sat, 04 Apr 2026 12:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d5ea136a1sm53487601cf.25.2026.04.04.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:03 -0700 (PDT)
Message-Id: <c38f0a68f10df01ee2c99f05d0f33a0a517ffb50.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:45 +0000
Subject: [PATCH v2 05/17] t1020: use `--git-dir` instead of subshell for bare
 repo
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Replace an unnecessarily complex subshell pattern with a much simpler
`--git-dir`-based one. The latter is not only simpler, it also no
longer relies on implicit bare repo discovery, which would fail with
`safe.bareRepository=explicit`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1020-subdirectory.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 9fdbb2af80..20d2d306fe 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -177,10 +177,7 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo (explicit GI
 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	test_when_finished "rm -fr foo.git" &&
 	git clone -s --bare .git foo.git &&
-	(
-		cd foo.git &&
-		git show -s HEAD
-	)
+	git --git-dir=foo.git show -s HEAD
 '
 
 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
-- 
gitgitgadget


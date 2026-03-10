Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE2330D32
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109024; cv=none; b=i+zOxX+E86o/xcPdvGB9xsQtCqO0mfZ4Jd76W7QIQrr3PKnCvXev8RHPG+tGjx9E8RDFZBiJordYz2LRu31NvyGZxbROHXLwt1uQt+RabuAwhq2y4ivnbkpaSasT6vIGtFVn5iVPqxFOqen56fzwx2aVkWQT4L8UH8Tkic/5gP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109024; c=relaxed/simple;
	bh=fZHTOqFF/D88qZBmApAoXdTIUBoLzhByS6l8jaPEmwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=au9nFBHYm97b6bDPvIjTKM7ISFldjktueScR+EA00j99ctfF0rfakL6kN9xqhW4E0LZLA9CMFl3bfvmPTFse87TdGaloQEOHZNpcnX0ipWu68lYYQkjklDoQghJUMV3iOHz85tqrbqqyITHryGlJBFEGKMHTIG8EgDB6gjFs5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvAo72G9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvAo72G9"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d73dd9cb9bso1362726a34.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773109022; x=1773713822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J32NOa9h1n4sF/wL7RRI4NDSxdtojwgD4MomwJTEh8s=;
        b=SvAo72G9OGVpqqwgVnlb67gcGpCUFgFRV0OvIerQnwosgBWpq38wPU4nq4CLTYB2aM
         ETS7I6swSv4QNS++wRG8odW2T60JMXmW/Yxv3wTS40pc4agBufxwK5YedlIlFACgoOvn
         n0rsHHH9WgJlOtJxmJiElolr40a0yv7OBm9ENhra1t4VxXB0vX6C8mZV1IB+1AQjZAjP
         mpovBIeAsUiWhT19aGhPoDCwlyhca9tx5lx04/uNUuIZhazpBqmrmGAF6prEiE4/iKtv
         NmFID8reKsfz57knea1BYEaPCfftPMnYqBcflVdYVlzduySEjTx+PalWOjeVqO+7YhaB
         GJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109022; x=1773713822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J32NOa9h1n4sF/wL7RRI4NDSxdtojwgD4MomwJTEh8s=;
        b=TGzDl2aP7gYWj9ixbg+jgRBrKm1UV88GsvRwKnU2w6hvgZS6zJD2GGmo4TJoUAveg2
         p6T00hG7g2/UcjZUQAtXeNbK93l9yZ1LU01CUyJljE5I0M0NXOk/v55UPjOopvJTI+oo
         AHmwehUPoopWRut++YjCoy0OeYPyYcSprk5Xi4ncjyLVZ6IOtdlxfpFVy8Xg3oSvHDEU
         kXlcbi+IRcj9A6mSPfCm+pn2Q0w7FJ7e2XBTtLinACkfbwm+Ync1llXfE7nYowP3hB/c
         qjXhssSMHZ1yx7iYqv6+cvS0vOQboRXQ1EKge9ICmO/xeEwaQsvjSQYnFT0ZV6+uqt/a
         zQTQ==
X-Gm-Message-State: AOJu0Yzfo2JhuBt3/kHsOBtOHz+F1CuucxDOyQ8MjuUVmU6Fgl3QpS5R
	B+kpsOjZWTXZpAc6YK2c3KOK4DIHcKglrkYbeSiuZp5Y0ZpKhiMyINngkCeuuHRK
X-Gm-Gg: ATEYQzzyJDdIm5tFPH2GeF6LhGI6lb/24TCWWTf8M7GDXf2iYx0sWmtR3k3zHwSqWkm
	y8W5bXz4KtJ0xXRKt2WNgJ3N1cOjD2jj5mpweNOyJlNPt8gjPg+1qyTR3YECfJOZ7dRNw1ebMMt
	KdCNS7wyl114np2usPUZWtVi84mp1KlkSGFwK39MxvpXX+OxwmqHhquKh2N04SMmk/+YLRu3RQP
	snSLJATLmcFiYXhNZ+UHDQmsSRFpFNjOCJpd1vW/vidHCbCx98Mjx4cwyUJ23iKJ+rFaF8hLngg
	bhk7wROpCc1leXYUQQ8nFFoNZAIERzbwP74CHdTjnfuAfcwW4kPso2IZC1NMbdyYfR28F6mutxP
	tDMiFVw9WZkbL/5QLBwXm+mSVMZxSXd0piMEHmoHkOu+7wdaGEWxtB6QrdHtl3q71O0UJZbsnKR
	dFhsjwY1wa6m8FsW5I30fazicQ
X-Received: by 2002:a05:6830:838b:b0:7d7:5460:49cd with SMTP id 46e09a7af769-7d7546055e6mr2204322a34.14.1773109021944;
        Mon, 09 Mar 2026 19:17:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.164.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d74a4cdd70sm3263004a34.12.2026.03.09.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:17:01 -0700 (PDT)
Message-Id: <11724e9310f30da72d2b60a8bae190a46fbb5269.1773109018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
References: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
From: "Mansi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 02:16:57 +0000
Subject: [PATCH 1/2] t7605: use test_path_is_file instead of test -f
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi <mansimaanu8627@gmail.com>

From: Mansi <mansimaanu8627@gmail.com>

Replace old-style 'test -f' path checks with the modern
test_path_is_file helper in the merge_c1_to_c2_cmds block.

The helper provides clearer failure messages and is the
established convention in Git's test suite.

These instances were found using:
  grep -rn "test -[efd]" t/ --include="*.sh"

Signed-off-by: Mansi <mansimaanu8627@gmail.com>
---
 t/t7605-merge-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c38546..44de97a480 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
 	test 3 = $(git ls-tree -r HEAD | wc -l) &&
 	test 3 = $(git ls-files | wc -l)
 '
-- 
gitgitgadget


Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC54F4FC
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241623; cv=none; b=Sweu74NO+Xba7ROEUeE2yJEf+Ugr/AoQUXAoWrpBdC8T7TiwUxUGO5CQrkw9ziNBqDQ7o1Dlxl1SLIh3SDXwoRZI+Xzydu3td8vG/JKYuLTDh2G76zYsf4shOKy9Udss3drA8ro7dR7nmLZnn+PBvPE/oHMizFHDsP4sNC+plic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241623; c=relaxed/simple;
	bh=6aE2xtTX7MCYi8osIR5IG8bWfOk0xPylK1Yham/3J/4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LnHbyT18qq5X0GUN+F5Eusqw5Hf4Tyw6tpN2E6mXFJ4HuzoR/xsSwMZEexq1+LqFCqFl9xWznSOyflZFtgN/366BqhleF7s8ukGGjCtDBjMuSpZk+h73xkYmtp8c3lXomgi65Ru0pDxkEbnL/5q1sWWzamNpVK/lTGf2MXRQ6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3pFqzTz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3pFqzTz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4125ea5d913so4687825e9.2
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241619; x=1708846419; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smv2uvExotzcskWd364Z/h/YcZbOyVk197y3lT1L1lY=;
        b=W3pFqzTz92dorp7VCJVwFO+z48SsKDAx0sDN2R2r3vEI5R1R5h8kzIhSmjfOeAIOnE
         ZLFKWTiUqMaagckoUEBhdqSa0dJ+EnKHjs4Ry/aRUn63jgPCWYHvtQVrnWCTHcz68uE4
         kT7If5mLtcp0pYTr9HflEiiYp+Cz8Wvtlg1CWHrzFHYGg6wOKhhIMxIyxldLEZAP5i5e
         w7jkpnGpmSUCulrRHQbcBjozaBtywWn3FeWMblrfybr1Z3w5ijRJZYXdJhOBXZuxm5TL
         8o00Hayrepd8sLUG5mehnORw3s7nYHsAjMP3c/q4A4jOVpec1urs+IuisrUCDW09MW0i
         EPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241619; x=1708846419;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smv2uvExotzcskWd364Z/h/YcZbOyVk197y3lT1L1lY=;
        b=uL605r9v60dzXwKyVOP6z0HauK5LV2kGeoEd9x31qOJZVr4ZQUUBrD4TvuRfnWQiCF
         2cNgVuM5NJPAVWIs5N87OgICcdkX34L7JbsorZ3x2rX5dF9A9R7NgE0ttuvKF4QkQMa/
         a8f2A27pSxhANvhMdvNXH6F0lQE2cyconAh45SezSFuTgolrTNvQnFXdqOrrMwhEVN14
         AmYAa1lhAr0KrR3JRZYANNgNRFGLwiA2zZU1DZG7pwqnm5p/u6PdHUqHYwtX4DRPQAX1
         ui3lxqVqEs6456bFCcAmOgfzq2kZ3ubB70G9xVutfGzfTqt8qr3fHo4tlrZvxNFCWzJ6
         MUAg==
X-Gm-Message-State: AOJu0YywtZ2/MRdmFSDRBIObeVXc5tptSzVDx0wghV/RaAU2Q8awHRpl
	BGVG21voQmN3krNZJkTvPxHosPRCe4XPw9Ga+6mSh92ojGuJ1PuDMcH+ruyV
X-Google-Smtp-Source: AGHT+IE1jjcFtK843ntOvd59aL4Nr7PgsQblTt1HByXEyjuWFskpzODlslxfkaa75HBlW95so/OuRA==
X-Received: by 2002:a05:600c:46ce:b0:40e:f693:94f6 with SMTP id q14-20020a05600c46ce00b0040ef69394f6mr6739990wmo.35.1708241619242;
        Sat, 17 Feb 2024 23:33:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b00411d3a414c6sm7261721wme.47.2024.02.17.23.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:38 -0800 (PST)
Message-ID: <c6cbb7b5875cd67485429200369b13a32c2ca886.1708241613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:32 +0000
Subject: [PATCH 5/5] am: update test t4254 by adding the new error text
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
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

The old error text was shorter than the new, so this just adds the new
context message to the expected text.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 t/t4254-am-corrupt.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 45f1d4f95e5..265bcc41bbd 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -60,7 +60,14 @@ test_expect_success setup '
 test_expect_success 'try to apply corrupted patch' '
 	test_when_finished "git am --abort" &&
 	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
-	echo "error: git diff header lacks filename information (line 4)" >expected &&
+	space=" " &&
+	echo \
+"error:$space
+	could not find header
+caused by:
+	could not find file diff header
+caused by:
+	git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

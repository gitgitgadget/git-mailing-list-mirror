Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHH4r/uf"
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8606E6
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 08:56:04 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d87501d6e6so1300964a34.1
        for <git@vger.kernel.org>; Sun, 03 Dec 2023 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701622564; x=1702227364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bszifoqlI8O3DxEVNdXs+mzZZYGbMsUd0bkkHdVP8QU=;
        b=KHH4r/ufIl7EbcwwfwFttEFuT2KV+7by1E3BO/CWSpTjzGv24BUrNnVbXpnvcqX5tV
         ZFrKevWRBrv6gEdbY/E1i6UugZvxrhmC0saeccE2oGqgImzOvs0BoFpBwK4vb6BghJ+Y
         sDOW+KToDHE0adU/B3GSFz6yVZT3vUglNPLXYyFCvD9oBPzdafCrnSm/e3JxSFGmQ1Xq
         lTKyvHi8O6DdC4V7inU5UxuDDuueo/JRL0WWLs1Ees+UCRZsHyN9TEYTMvkJOftSQgv7
         /c/JeN9yWXsmj/IEEIrlIgXaDUs0peYSS57DKa3MP3IOP4wbpUmFP3JrfqZorL8jsQ7U
         Dp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701622564; x=1702227364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bszifoqlI8O3DxEVNdXs+mzZZYGbMsUd0bkkHdVP8QU=;
        b=moRBPs7uP3s8cfq5ZietHW5wxn+uw98gNeF51/BzT2JnpBp16tYHfAW9+BKK8QlOPP
         jZILKXg75R2sBKsnBNjiubmXEJDp9ZFWbzfvySPs3n1Kg8RxRS9UEI/LhoTf21C+kNEv
         D0OsdPBX0FojqNjLkPmXcncY7kvPPK6o4vP424FMZrbMbMcC2Wkretph+ncM48K5AL4V
         S4RQ6EsvpWOaUbn0uTq3AZOSl4hMm33l2hkZmdygZrX2XrlxEZgIMOsnSJP3c3bYWkuB
         Q2I6rKau4IXn16qAfrsxMxSFwdUVNXIHJJEdg4gY1eMSZkLY304omuf0kDUD3REi++qD
         +mwQ==
X-Gm-Message-State: AOJu0Yx0ya/rP2ISEshHiJhzk152PcI7QioOQFrzu5R6/0ie7SW8k/7K
	F9X2cValWJ3bm2r60uJMiQyoXs6paT8=
X-Google-Smtp-Source: AGHT+IEoUJyk7jF6YC3lNSCOmmlA5d2WJTv5NtPq3mo8koMezx7kXDdz3aIpk+Zdgf8PhUzf2iXG2g==
X-Received: by 2002:a05:6870:ab0d:b0:1fb:3241:be3c with SMTP id gu13-20020a056870ab0d00b001fb3241be3cmr928536oab.34.1701622563763;
        Sun, 03 Dec 2023 08:56:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f38:f8b:64f3:df46:3399:9fcc])
        by smtp.gmail.com with ESMTPSA id a1-20020a656041000000b005891f3af36asm5506575pgp.87.2023.12.03.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:56:03 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: five231003@gmail.com,
	gitster@pobox.com,
	shreyp135 <shreyanshpaliwalcmsmn@gmail.com>,
	Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
Subject: 
Date: Sun,  3 Dec 2023 22:21:43 +0530
Message-ID: <20231203165539.341-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shreyp135 <shreyanshpaliwalcmsmn@gmail.com>

Subject: [PATCH v2] test-lib-functions.sh: fix test_grep fail message wording

In the recent commit
2e87fca189 (test framework: further deprecate test_i18ngrep, 2023-10-31),
the test_i18ngrep() function was deprecated.

So if a test employing this function fails,
the error messages may be confusing due to wording issues.

It's important to address these wording changes to ensure smooth transitions
for developers adapting to the deprecation of test_i18ngrep,
and to maintain the effectiveness of the testing process.

Signed-off-by: Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..8737c95e0c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1277,7 +1277,7 @@ test_grep () {
 	if test $# -lt 2 ||
 	   { test "x!" = "x$1" && test $# -lt 3 ; }
 	then
-		BUG "too few parameters to test_i18ngrep"
+		BUG "too few parameters to test_grep"
 	fi
 
 	if test "x!" = "x$1"
-- 
2.43.0.1


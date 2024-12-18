Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9935FC0E
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482542; cv=none; b=qB1pTRmuYmPD8k52LKiNA+oTJSN2rkuAmhy63tna496bVI6/0pAqKP3JBqpX7RfGYX+v4H4cilCGpIb5UXa+eYQ+N7qwbtVM469VEyHoAaf8SxPe4DTpfjGOy/yTPuWNSxkrca2xZwmcn98K1vKQM3fMyrFx5MdFMUN8kpwxaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482542; c=relaxed/simple;
	bh=h+xmG0cf1Vn5BNQ5QhRYg0RRi4zNL/JUc7gGWdaEFJI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EcDUzdxt5WCW2xUOH9+eserwHk7CtwBuYK+W2Z4vx5bibkUT2eHmJog1u9p92NOMw7A1n1Kn1NGqGpzrgbw1C9i/tnBvKMYkvKe3oqOqeKyUhi+KMS2zcrZRs2kE3i0sKxa5tjduW62WMHWMO/vpdJtS7wvL8f1qNndipSratHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpY2hY06; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpY2hY06"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4895092f8f.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482538; x=1735087338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW6JsaC1Hbi3vYKMY2RpG1d5S8cNC+v8oVr7rbpS3aA=;
        b=JpY2hY06LYC7rzVkZHUa+y65J1ckWkyVRneaMmL8owc8PV1NU9Km+sJ5ygO85OnE+g
         /GcfdldHWS1mDWZg3kTlj0wecrlZu2fesccFrSroz/We0GT7VjupIHnVtHeEM5jezt1B
         hjQqTE0M5OhJfJP1v+35cf1H+DJJJ6qsQ/M3nH5nHqrYkyZgr+sP3Pf0n3V27H5Az6Q5
         KU7INoAoCsopuZrUREoC6fhxA+FALS8pW+9B2nlqvLzCS1+H3TzyYZzS8qcN1GI0XBbs
         3b2LfRAdiY7ukn0mI2RXgRvbuBVSilXeIqs7ULR0yKMBUPB5WNAnsaZVmuiQ61zU/Kz5
         17VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482538; x=1735087338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW6JsaC1Hbi3vYKMY2RpG1d5S8cNC+v8oVr7rbpS3aA=;
        b=cY7FrL9m12CKGQ0lknFBHwxTNhrQRS151adwWGfjRG2qMKwScijqT/R9MVNKrngKO3
         cyhs8OICen+IiRuS4jCPfeLeOVVYAdOsibOH6+anQCu71X4aV9sXbPynxpAF4P6ggbI2
         ECCVdA7w6FSVw1CDqOf0ZssuM3aoLZd7w2J38IobOTgEy+huAOuu1LqhBwXrb4Lr8zrQ
         ZFqJtnkQWZE6bw64NG2D59P14QOuIRT7WLvNaQxqFb/0/M+ELkbb0tnrKHUY1XH7gPTy
         cyuEGO9+RLpcMsnJn75Hw+pcU3YX3yw7nYUXRxt8uvCGNmCEt+YWIPP21LDCYfstTfSy
         SLHA==
X-Gm-Message-State: AOJu0Yz1NtNWqJpq0IpVuNFlcvgut1x/uGVa/CZyMqhxFmPyxQIJl+Nj
	fQGIsuML79Ts+JQUeBoSXVtbtzzJzspD1U5qRPMieKyPyPCDzQX3+QhKYg==
X-Gm-Gg: ASbGnctDP9sDOJD24kD5uaGR+ewFBFGMVQVpKf4EfE0toSd05lEjhznRrLAn9w8kscw
	w7OIGbrQDgXk8w0Rd/Rj5REWRC+LgjbxR4vnCW6U6qklqMz10YQRM591DwKpJOUs6yHaduekZJ5
	LL0mX04g3jTYfdb6l3PM2l6rzDyGq46LrwbNWnq4aDkygzvQxwfMnMI7UYOWOnKdCjQcEM00AVK
	1ot3+HnOzeaxfB8e2adPMonugHsvf/9PEprinUgFCXUa9KiBRtohyf1MQ==
X-Google-Smtp-Source: AGHT+IH3ybVa8uFF5AQUp5UP4560V35EqsIIxoA4Zaw/lZo7/LivMJy7EDf+0TGPhPO7xjC5eu03HQ==
X-Received: by 2002:a5d:6d8a:0:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-388e4d9aad6mr661472f8f.53.1734482538333;
        Tue, 17 Dec 2024 16:42:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801af46sm12435951f8f.61.2024.12.17.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:42:17 -0800 (PST)
Message-Id: <pull.1620.v3.git.git.1734482536998.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.v2.git.git.1734481009264.gitgitgadget@gmail.com>
References: <pull.1620.v2.git.git.1734481009264.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:42:16 +0000
Subject: [PATCH v3] git: use ^=1 to toggle between 0 and 1
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
Cc: Dragan Simic <dsimic@manjaro.org>,
    Jeff King <peff@peff.net>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

If it is known that an int is either 1 or 0,
doing an exclusive or to switch instead of a
modulus makes more sense and is more efficient.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    git: use ^=1 to toggle between 0 and 1
    
    If it is known that an int is either 1 or 0, doing an exclusive or to
    switch instead of a modulus makes more sense and is more efficient.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAreaZR%2Fbuffer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1620/AreaZR/buffer-v3
Pull-Request: https://github.com/git/git/pull/1620

Range-diff vs v2:

 1:  5819a51526b ! 1:  f6e75d8eff0 Use ^=1 to toggle between 0 and 1
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    Use ^=1 to toggle between 0 and 1
     +    git: use ^=1 to toggle between 0 and 1
      
          If it is known that an int is either 1 or 0,
          doing an exclusive or to switch instead of a


 diff.c                     | 2 +-
 t/helper/test-path-utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 266ddf18e73..5c2ac8d6fd1 100644
--- a/diff.c
+++ b/diff.c
@@ -1231,7 +1231,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							    &pmb_nr);
 
 			if (contiguous && pmb_nr && moved_symbol == l->s)
-				flipped_block = (flipped_block + 1) % 2;
+				flipped_block ^= 1;
 			else
 				flipped_block = 0;
 
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 3129aa28fd2..0810647c722 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -188,7 +188,7 @@ static int check_dotfile(const char *x, const char **argv,
 	int res = 0, expect = 1;
 	for (; *argv; argv++) {
 		if (!strcmp("--not", *argv))
-			expect = !expect;
+			expect ^= 1;
 		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
 			res = error("'%s' is %s.git%s", *argv,
 				    expect ? "not " : "", x);

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget

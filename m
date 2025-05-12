Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF61E32D3
	for <git@vger.kernel.org>; Mon, 12 May 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747015653; cv=none; b=CTHIv/YH4J6dV6l8eGaCEglc8neaQ6HfYrV/F5NuUBQdf/q+ia6Sh1cttaQyoJofp3vRAvdUOpwhZt8/YS/kqK+wCYzC1qxpdMNb8DIxPulkhybHfvY4DH5DYGFUpk2SYh8l8+0gnvLEQzNMh/ijSvyJ6lBulfzRpY+UsbLUq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747015653; c=relaxed/simple;
	bh=m+mO9YpXjqFrGYhRCj5FHnTYeEtDchdqc088AcWirx0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B7NMjJOex+MhwCsSkacSGpRgFPbIomLhPSTzfeR8zjdM0g+6qCdqXM6nwtYit5XGzeUogSUo9fvSqugX39sa3Wln+FJsYFNK/+BiN38fR75uM0N1kyJTYwPfSPtNCPhDmnCdGeyYYbX519pTqIRr6Ula++e57L+nzUre9GNGb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo4PE3bP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo4PE3bP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ede096d73so27142145e9.2
        for <git@vger.kernel.org>; Sun, 11 May 2025 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747015649; x=1747620449; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fFn6xlednI08xe2T8VWuoFbgMLpjb2/A7o3lfioFjxg=;
        b=Jo4PE3bPHrWTD5647FivbnHBp0ddFjGkkK5PLVRja1TXViIOLqMppJpvlBADuVQh+E
         i2/FPJRMn5sJ2BMK2uqqVREgVxjfVsVtRR2CYvKKwfFMd8QBBDtCRkq7aw73eIWkM67b
         6bnCmLd63ZRT5IxkywADnz4+bHOf5FjxNl0lT97hBKqGj7Gje+tkz5J559l+Hd6i83NT
         rFugMjEXtzfWr5RO7glxnVBD44EiVJ5H3FHzYAr+68i65LpagcR/YFcPmzm02+ovCegK
         osTdQ4HOwISaTSoWmPNdiErw5nmWkccIi0IUIyEHuKyEYa582Ekfa53NkjiMqsUsGlkS
         ZXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747015649; x=1747620449;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFn6xlednI08xe2T8VWuoFbgMLpjb2/A7o3lfioFjxg=;
        b=D6lBENNiAdRBYh1MGlGbaIcaoL18GrJuhCuU/gDJZFpLhsgCNd4YHKyQyXoRSD/QJF
         Cm556gnRmCDa9zIey580dT3Czvl8y8+pACNNytsTLrHd7xjvKvbNsXjnvSSkBnNKq0uW
         i4OpI8a3Xk6Fg+SadwkA/lcd48A5txTrCag8oclbXOQySSAAOXmhaO/eR8qDVVzy7iVD
         K//x/fCFAABkSWOTwzJWN9vY8U5LFkuqPCeE0AAIagJZ268BZMe4qAfJShKOyfHAKEhT
         lmatRYuIYNrIhpmgdIiWJaaJFEXvJHWy1kHgiMUHRrqWQVtHJMSOhkBQe4eV8KwkNvpj
         1LvQ==
X-Gm-Message-State: AOJu0YwZmepPVUHLkkCLiKe7BYCnngrnzvIiAOIX1wMQn4jmVN7TPcgz
	DGGfYObqlNRfUyaOxLk+qwO+UPOxF3x19pV7X5JS2HfvfHvkBJTb2htqbw==
X-Gm-Gg: ASbGncvDTvVhy3uGszeVRD/PZq23BVBTxHanRY+BXTLEn+JfmLWfBV994WopK9Eameh
	u5+f+JOVEYzzQXxXinmvIJroIr03yklYnnswdDPKG4L2aXFCPUgR+Oey3h3TMMs3Nr2t5dfyt2B
	+3NvrOo1F5DOhlysza3SFuYutssPvisddPl2Y49HilcRPyK+OV4XaofqKxg+htj+NOfczw6BW7P
	JU+e9T2HPSo3huIhYbxUyee1N3gYe+6MTyiZ8QiZ8s2xqg6+Ocr80XYAfEXpFUe0pGgoR2PBTmO
	D4mXxgf5mBqAWsJeTGJKn6Py1USmuMUNp6nUKzwh5XibfXvyHYZZ
X-Google-Smtp-Source: AGHT+IFE6aXmdDaGlco31uDxaQB6hbmVJ1IEQbhD5tgtd9R/R1t3/tymUduXW0kBHOGdmPR6b27AOg==
X-Received: by 2002:a05:600c:4e90:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-442d6d3e35amr71356535e9.11.1747015648836;
        Sun, 11 May 2025 19:07:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d7806a73sm48077115e9.3.2025.05.11.19.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:07:28 -0700 (PDT)
Message-Id: <pull.1961.git.git.1747015647505.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 02:07:27 +0000
Subject: [PATCH] builtin/am: fix memory leak in `split_mail_stgit_series`
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In builtin/am.c:split_mail_stgit_series, if `fopen` failed,
`series_dir_buf` allocated by `xstrdup` will leak. Add `free` in
`!fp` if branch will prevent the leak.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    builtin/am: fix memory leak in split_mail_stgit_series
    
    In builtin/am.c:split_mail_stgit_series, if fopen failed, series_dir_buf
    allocated by xstrdup will leak. Add free in !fp if branch will prevent
    the leak.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1961%2Fbrandb97%2Ffix-am-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1961/brandb97/fix-am-leak-v1
Pull-Request: https://github.com/git/git/pull/1961

 builtin/am.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4afb519830f..e32a3b4c973 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -850,8 +850,10 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	series_dir = dirname(series_dir_buf);
 
 	fp = fopen(*paths, "r");
-	if (!fp)
+	if (!fp) {
+		free(series_dir_buf);
 		return error_errno(_("could not open '%s' for reading"), *paths);
+	}
 
 	while (!strbuf_getline_lf(&sb, fp)) {
 		if (*sb.buf == '#')

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget

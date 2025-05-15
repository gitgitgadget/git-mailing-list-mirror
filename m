Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0229A9DE
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313151; cv=none; b=mjC8FcgX7Tax5eC6xnQ75T98l9X/kg+0j7lKTVbOQmnEMJpCN99PUzrqqdLgntDlAR+GdX8Uso+1mN+QiGG/bu+rWzPXzIf3TNosFOkiMy7x5OusSKc/l/f2xVSkix2DUQVVNVYjpdk6P1HOWOwkdr6T6uEvanx2tRWT/U2Svls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313151; c=relaxed/simple;
	bh=C1Her6R5v9CKKNuAG/egSt94q66IHcdge6mw4Zpz/IQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fiO+8VKXczUNtV7Hdd5g4RJlYai2pFehjX2R66ekp/HjTibsH8akRe8jrq5fGJ25VGrHevb1GV3k/7GX1fMcyVa5O46MsYOpsvxsh03Qdr5ZijyQY5QlDvI3lAmYf+NsJjRdO8BbgxnaRXmP4lWo0w2arWoCZMueO4bhnLDbObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Rcip0P; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Rcip0P"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a20257c815so758713f8f.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313147; x=1747917947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wkq7UzCTWymkvYT4K7fNJZJZ9SrUMS94lwHE37c1F+E=;
        b=V5Rcip0PP83FQdlkSNzfeJaFsy8za5xAkgwMyaFasw/HV3cmcgOvEr4Mj3b2kbzzNO
         oMuMbTDYDwSmbtsiZUVrRGNnkDVwJWovuldbeHeuLAxj8tBrll4bArSPPoXoVF00/Jy2
         Zrs9DbPeJA8Hu1BIhIHaV3vgyFeH8xgEqqk7DAItIuO1GYYAwwijwcCc/2PCZxMv30gZ
         OeX7PsY3N3wn8TAZkKYKxpL7gwbnW5RjdQaAPduBMEAwMOTs+hp93FN7Ud9oTVWNJXVT
         TzAhefLBfhm8DiwSkH7iOAJjWfnYeU34sIq/1AKP8oCChEWhXBkXTw2Xh9VXk6ORGC/g
         OkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313147; x=1747917947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wkq7UzCTWymkvYT4K7fNJZJZ9SrUMS94lwHE37c1F+E=;
        b=Rkhzw+fzxHahQxVhd+SCFjGkd++LP62ObKOhuU59AYwEuoMTXnwMYtwXa/2TGRJ5tX
         Fv+37In0sYUyb4x14kBvpvDPbu+V69G+mfcXpHssedsniYCQ7gAOFSIxKSQB0udxUwCB
         54MlY79M1JMDMJokJW1pQPj6JiJmCbuhc6RnZ228xCE93LBZ5f58ezAGMLqpRRhWUF5W
         OaMptYhXD1jYlUoJrXO2UlQFY6KBHRfdqGwIgNmdIZAt7mUVDvnp/48EV1eFovpvg7fO
         AOeXuWaY1VDu8Q/8T7pKcpRN/+XrYJxFJA2+p0M3YDLjdodSdwIK/Prq7VlF6iyPm7Y0
         iG9w==
X-Gm-Message-State: AOJu0YxznvVtA6e1IBFbaWxXjcEF3WaA5WXSuCCGZ/bkadqNZB12/KeU
	CbpwR4m2/gJMbffcVLDvsAUGa42+1hm1xZWelVnqHrn8JxxmvVMMMzbOOw==
X-Gm-Gg: ASbGnctSFkmFNTlupucXNTWfL9zVB9+kJJHlp8Vx6CBEPBn92+hqFBtcnKvPBLjFMGR
	qcE18ZVtqLcDPf9W766oY5GyAeHbSbZxn6NzDv003eCEzYwXPujwYUkp1lnCMo40bPffgo5o63/
	lzrUrDyiY1H6b7NnPm1Pruo3/67RxhRepBHhyHVGfyjvud/5p9d3fR/YRyDZnLg3a+swzGE2EkV
	Uo/CORhflZRuIBacEDYsYtvAV6NfioCTSF2kAK/vhQA9DMsIUFNxHf1BE2IGEHurz3DlxpQRBAD
	AJqlMh4Sh/9UM3EdTv9tcyVWILeI1D9q3TWFwmwsoVH6L2G42aIe
X-Google-Smtp-Source: AGHT+IHMm5fXZAK+k8AqMG6HUIvRHdarxYVqop6sqzfnJ3fTiuslmwsy07Dq5flKAM8XF6O1YTqlIg==
X-Received: by 2002:a5d:5989:0:b0:3a0:830e:d1a8 with SMTP id ffacd0b85a97d-3a3537a0b33mr2404494f8f.46.1747313147298;
        Thu, 15 May 2025 05:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2961sm22632936f8f.45.2025.05.15.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:46 -0700 (PDT)
Message-Id: <81e873ea2ce5180006be9ad0121d2d5aafb44730.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:32 +0000
Subject: [PATCH 07/14] stash: defensive programming
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

CodeQL points out that `lookup_commit()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 23c4bbd3e21e..8efcd31d6c61 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1396,6 +1396,11 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		goto done;
 	} else {
 		head_commit = lookup_commit(the_repository, &info->b_commit);
+		if (!head_commit) {
+			ret = error(_("could not look up commit '%s'"),
+				    oid_to_hex (&info->b_commit));
+			goto done;
+		}
 	}
 
 	if (!check_changes(ps, include_untracked, &untracked_files)) {
-- 
gitgitgadget


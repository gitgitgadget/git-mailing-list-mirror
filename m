Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB34D901
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885584; cv=none; b=ZSRONzIpyaXb5UCz49TYEyB32SSFxf0ZJkUZtRS3SEUHEbcN0+Ttv0F/K4T0TnutSzaFoCkNqosW7wyBmnLjkz9/4xUMPonJ7GICQTgOrrYnlOZ9jUOartgRsZE0mHehMd5V5PYkb3nM0z6Uh6V9XQSHyq5Vmnc/UomLYlU88Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885584; c=relaxed/simple;
	bh=ZbvltTBk2RxO6u673XwmN6IKn95QiVwaX+EYx22ScSM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WB7+bbXnZZWUfi+eKBkzHfnOoM9gfzeTTEw6c90IS+7ncvtfsaEXnvwDlaCVWk7ry+EXNm33wsaeZ8js4fPzWZZgDaazcqRmGUiJov7LJV8lrKrQGOj/2/Zv5Jb+EiL7oJX+kW8ASloYViZ//Mq7RgMIU12Dq/Libb/GrJHpCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjgWGDx/; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjgWGDx/"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ae24015dc0so2330137eec.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885582; x=1766490382; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=BjgWGDx/jQmnzCCA5II5J+4uN/TGTqiLnvyfls4M0Qt5sOvh6tCHEzzrh0zmE0yrEr
         BPeHQIEVn57RqxcnVx+vcczrKvVaLhPHkSg7uZcvm3WJqmdgZ6ZncjHDYb1CEz25jTUn
         Ed3Djv7ghQqfQfH5AvVnpgxyq0ptPShTI1lXvkcqB8Feh0qXRRooK8EI282V5Fn/90Oa
         guANIp99ePo5dJ9RIh97buMFgy5OEn9x/0/7TdwKOhxqrnwD1zI55zQ5I9hnMj2Ly82x
         YI80+Ey1IFQT9jiaXSL/3kFoRq2VeYd8UJnRyfoYrWydcWjHIPatvjYZ8KQHOLhtDcnq
         ACTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885582; x=1766490382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=sgAXgf9NaLe5js/kuJ3ThNAGoB0+X5ddLrToWr5eIWddeEeYRLeBozYyAoRoGfZ3Sh
         eWEKHKO6QEc2XmoHvEhZUCvy0MlxX2WTcx0GAxsd6CFO1VqYnpLJqmVF//uXI7TVSj1H
         9Mv7DnPiRsYbBCiBVsXbKU5Gdmu1rncTUiz/l1Is2eu7ra93VCXHEwI5FQ3KPipY0znx
         HgDFxikS353hdM94VsonTsLxAi7EQ4VVB0Tctgw7Ei0MLFNl82Jvwq5huk4MNsFFvs2T
         RlKUdMNO/nIvSU85R0u464bUOlO1iGHZGz6IcX5hcH0d3LNIJooye8sSROiOM5TCwxQB
         F8/Q==
X-Gm-Message-State: AOJu0YyqP69ixVdMO1zut4DNHtb4g0ndQMKmcuZQE2cKyAmedAQWPS9+
	9iyvLORt9XZuN6wIrZPlRLLMggbDea6FCzknJ2e3A+DowGaRU5UIOV5u9fHlTg==
X-Gm-Gg: AY/fxX7XJAa1ndAY6xIa5m3LozQS3CUfrJkSjCjbc9p92u/48O8F+ET5wpPAWjBrC4M
	8NCRCCYkE4Ltuv2WcUDRWoipZL4rNxflhmJuEotfFQVGCxF1vDdxjT0PcODfGCM+SqzPcEbXs2Y
	QIRzKgwI07ubZeC0l4AArvg0smaS0PInbPdY99gT6L34QWyTw8VMyoER18j7Q4kGELV9+UrecBF
	Z6PhZI5Sm0XTUksAbhJu/Ubu0Z43xj1t3GevC6FkJgq403KHlSw0uqubi81pLjjNQ06iwmBMp96
	mEHH9cwzflkAANRxZ4nCjwpBlWNTozDgUpyDFNvZWNXlbbyvRCOKiU+khTtywj2ZMObQOpgUgMH
	jmtXYn4hJi2hO7aqQCATXIBv9G7YkqecA4DSGhyBjgcNnxDqHbgR/TqE8d2qyZwzNcptatw9Tmo
	SpoU9eGuRcIrUn
X-Google-Smtp-Source: AGHT+IEP4URTxKrFMvNNke27yrH4sGWD0XY+xlNcs6xg/DQYcNxFC9XMmxAF+2PxIy27PBpizZT+SA==
X-Received: by 2002:a05:693c:8006:b0:2ab:f74a:6a63 with SMTP id 5a478bee46e88-2ac3119e045mr6975555eec.16.1765885581674;
        Tue, 16 Dec 2025 03:46:21 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f054711sm900608eec.34.2025.12.16.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:21 -0800 (PST)
Message-Id: <b97afa9a5c28aa89fd94f210a0dec5de891eb221.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:09 +0000
Subject: [PATCH v3 02/10] apply: symbolic links lack a "trustable executable
 bit"
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When 0482c32c334b (apply: ignore working tree filemode when
!core.filemode, 2023-12-26) fixed `git apply` to stop warning about
executable files, it inadvertently changed the code flow also for
symbolic links and directories.

Let's narrow the scope of the special `!trust_executable_git` code path
to apply only to regular files.

This is needed to let t4115.5(symlink escape when creating new files)
pass on Windows when symbolic link support is enabled in the MSYS2
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index a2ceb3fb40..de5750354a 100644
--- a/apply.c
+++ b/apply.c
@@ -3779,7 +3779,7 @@ static int check_preimage(struct apply_state *state,
 		if (*ce && !(*ce)->ce_mode)
 			BUG("ce_mode == 0 for path '%s'", old_name);
 
-		if (trust_executable_bit)
+		if (trust_executable_bit || !S_ISREG(st->st_mode))
 			st_mode = ce_mode_from_stat(*ce, st->st_mode);
 		else if (*ce)
 			st_mode = (*ce)->ce_mode;
-- 
gitgitgadget


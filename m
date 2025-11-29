Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D930FF39
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440915; cv=none; b=Ge05/6huuE5GXaKpD7hWjWfanufSGOlZNIaS8wTE+d7MqL+qo47oVoECM6CQOQa7BnmsK/SVsU8SbscC6s0PuDpOAJ7XWM86SOgvuQx2/98XnAZWL+U3SyGjCYSzgE1EqyjNqbN+feQ6mJMSfu18o1wLw8GJiYaSFLywe8ykXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440915; c=relaxed/simple;
	bh=ZbvltTBk2RxO6u673XwmN6IKn95QiVwaX+EYx22ScSM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fyYT2wVSEfmm5XfCHgr/OiM+agFJoSuLpku1piKcXDztgGmH6o1nRml27KlcKsvLTEhR7+l+BWtT3/v5/SaMp2mRCNoMG/XF10lle2bBZf5jiwLXNl/DQggHO/1dD9lubBrRxsXHoNUCpSgTI0LPG6clIiIEW8wg0HgV7187pG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIlPW5F0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIlPW5F0"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88244d1559eso37744386d6.0
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440912; x=1765045712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=dIlPW5F0TWb0SaqB1pWEyloDr1Rb8ZjuBNCcNTUN+qjwtxMOtfltmVPkFiYZXGLUvl
         XqGDg3RFFfYq4OxFP4FJgKUaIEw+p4/I+G4YRwIbx94H6vDXLRRzKIdwwTTRwQouODrF
         yCVzx49Bk4j0gIMSyWH4G2jhcD56ypayYGtjTo24ZEIdsVVWl9+FI6FgcHeT4hOQ64FG
         objzbZhvka1vQ14BZqsywbd1IJens3Okkzif1HewMXv2A+QoO+2GZtUyYf+nE9vzUZjd
         nil+wFX905rQsmisSXQE9Rbj7zMWDuA7yV73T3GBH2kJGBjwbSZR2Pmg1isJCARwmrAO
         nkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440912; x=1765045712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=b5Apm5q7iEE7+jXr2pkPDIk9wbDj5qp/xeYnrbLOWqispEiQVyuP2w8cbeUwpITEy8
         pdlH5khvRNzRKgnAzkQOzF0XVnDNCfE+BmUvHAYCOq51ATNeEHZPGyqWeWNzGB9+HAkz
         KFhCVqtYOLibGlcRDO4SxsfEhOfw9mTYOi7KYMzY6GZz63FeTZVR2fYBdJZcb3/Sq0Q5
         tUdv1WcDkes2IrPWp6U+mxxlEfhhRXVfFzYI29y3bjH/j8DWAwsrjjuiMsvNqmVRzFTO
         Mz6WeoDuWJKVXZg9OZwC7bwXKB+lypuw0lwMCqu5JuHzbS9A2ELeaeSCc+0D/Cwr/9Y9
         G8sg==
X-Gm-Message-State: AOJu0YzzxSqpPR24aR6U/85AnUDtpjYkoLltL8geEsVh8aLjCu4/0vqz
	itNyUE+tQ6T01sc0WYu4lPuYmuTwUlNo4t1S6kDFv+n8mF/Qyd0ubeFaEcp+Dg==
X-Gm-Gg: ASbGncvlgVc3xlgJv5OOMebXNrw3lOKwrZwb8DZrGi5gEAQHQ6iyhSt5JSgS/o8BMKk
	yitj7lwI6biWur5OVET8DqMYCKITEzmggQxEh/dU/NWZ0G3Cbj2xHbcHrA/Ieq1NYLiMKhxnnXO
	bnIm43L+p0JxPCUZSR4FdlRFnpPzPnPXPLawZH6qYo2hxxV7ZS0ZmN/hhHzBRvM+C73zTqDnPuS
	kQxr0tvrOoOSchmpyA1pGUySbGyPI/ho/+s1zKOTHacDRF0yOzFwX6+jO1xHim+O5nn7FbXSEH2
	7C/2N8LLmvD+Qjx83hH9iMVdbORZI5n6Afimmdf8TXMHJkQV6uypoX3Ls4JZIAhme7x9W70su/E
	NLRdziYwr6p1t49tTAbUW0lMok4gSc/2PDlMOScJXpWdk6vKFNvThl1Vdt6uLaPDaeGWk8SlDAS
	RmabBthFQzoFxn
X-Google-Smtp-Source: AGHT+IG/fX0heR9xC5bLLuk6awvJ8+J1EGFypGY1x70kK9u1ZaJ7PXo3GLXCkz229Td1frpKanva9w==
X-Received: by 2002:a05:6214:e6c:b0:880:88cf:59ff with SMTP id 6a1803df08f44-8847c4d301bmr474423006d6.22.1764440912212;
        Sat, 29 Nov 2025 10:28:32 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524af1aasm51324316d6.12.2025.11.29.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:31 -0800 (PST)
Message-Id: <b97afa9a5c28aa89fd94f210a0dec5de891eb221.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:18 +0000
Subject: [PATCH 02/10] apply: symbolic links lack a "trustable executable bit"
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


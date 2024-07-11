Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAE16D320
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739502; cv=none; b=uwEpg6MjicUAoyDhBCO6WWcJVMmXcqKCEgBeTnnMLi6AfCiySZQYRRNvLtwmefRo69j4a0FFpZyvLMv+bo+aC/XDep3afiAP0O0ZrTSI0ML1WHfMF7pzlWgljDEVtXZXAz9+BmbGbzlPH7DE7GX2dM2kP2Fhz88o4PxcfMbskgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739502; c=relaxed/simple;
	bh=u8yaTDujhV2/Nu4OVUSQjQlDfgzdR329gA/H50m5rl8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YKrdbtMHcdXytE1wrvlqfF++zlGwNrpLjrtfBvoabcflmgziDHLVWKy0VPRgtwRm3XPer2/MkqG/ueSvEWXVPaG0eMpNH8miYMv831u8mXVCjObyys6o/uoCQiUcVPXt5WyxvsxddgAQ/2zxCkdCS4wwT2ILKqqzmm58lSUVVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVfFTtwM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVfFTtwM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367940c57ddso840722f8f.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739499; x=1721344299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CocVMwk0JIazwXWV9OwSdYVdQb6i/4AS+rSFmyyw4fI=;
        b=XVfFTtwMopt7vCa34kb6NOmFUVT0EZLj8+EyhVUzWaPTdJzGXDcScm8wxnsj6MTHTR
         6GiVyds7tizuxePlM0N5FghbskBMBCtWoPIZJRNnz4M4jS3mz6BBtR2dDvo454HBGonM
         mwrZMufekFVK3W7mumAjGCLYagJYE+Agml9tjX1JLb4QaXTpX4RAAre9JTplfiXJQDu1
         wyUoOrSTBhrLk3/9zV7JFgDzHjmYvz3rgvyx0Qco0ehnV4kYAt9PXhAwc+hCOFizJZaQ
         LSNEo66BVNqY9AvqS5zd5ozYzcFPzsvTsi+rKEKgmq60Y1LFJbpTBAqdAiiwOwY08RaM
         PXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739499; x=1721344299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CocVMwk0JIazwXWV9OwSdYVdQb6i/4AS+rSFmyyw4fI=;
        b=IOdm8SdN0IN+mGH2uyY0sAjQ0RQM5tSziuh/cJ1k84c8kHHZIKe8//6gNELEFH34eb
         ydcneX28TJp1UhW2ONOecu5y3Srky4rCHrbUYaQmCmiyWRH7YABTPK+FCro03vqAUcVw
         vGEZGxoXZawIaEIXtdSd9rANiBypGiueeqaknqhN/JUz9/bFm+yQU9rQS+3VzSYIdF90
         IbpkoY9diVoTmGUICLtOohpVeEX7ti7S+4e4MzYn2M4wm46ia5Prf1DhtWeikD3ifyi3
         YTse/0ocU0H8BPZU1aQRsM7CunPHO9BW07zQmUQzQ06NX/9hwpV4IVEzOUvFvvawKl+8
         djdA==
X-Gm-Message-State: AOJu0YyRiRkqIUAJvjjF+FKCra3jDTaiGwswrX3LxLMXhy4FDI9hDRff
	R5ZOS1DSl1fBOUHuufb2fmVQ7RTFSYYIuhM1aRw5uex8c893Y/UqraFDGQ==
X-Google-Smtp-Source: AGHT+IF2p/D5f5FGdYudJ9valiEKFEMndT7oHDT72iSp4LrzZjQ7Q0h44BTTSRCWB+J/2u8VvEAxyg==
X-Received: by 2002:adf:e181:0:b0:368:517:5d07 with SMTP id ffacd0b85a97d-36805175e15mr44880f8f.28.1720739498747;
        Thu, 11 Jul 2024 16:11:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde848cfsm8790207f8f.37.2024.07.11.16.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:38 -0700 (PDT)
Message-Id: <e0970381042e4e35074c5f095959d3379aad6d9d.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:30 +0000
Subject: [PATCH v2 1/7] run-command: refactor getting the Unix shell path into
 its own function
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This encapsulates the platform-specific logic better.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index d9f80fabe6e..59e433bf91c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,17 +274,22 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
+static const char *git_shell_path(void)
+{
+#ifndef GIT_WINDOWS_NATIVE
+	return SHELL_PATH;
+#else
+	return "sh";
+#endif
+}
+
 static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 {
 	if (!argv[0])
 		BUG("shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-#ifndef GIT_WINDOWS_NATIVE
-		strvec_push(out, SHELL_PATH);
-#else
-		strvec_push(out, "sh");
-#endif
+		strvec_push(out, git_shell_path());
 		strvec_push(out, "-c");
 
 		/*
-- 
gitgitgadget


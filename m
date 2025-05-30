Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DDC2FB
	for <git@vger.kernel.org>; Fri, 30 May 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569961; cv=none; b=oHxvb8XSICJ+Ia3OtZtD7AYYp6ceJHaGxkgvHP6vQxtg64JhGMXBs6eJI0sa4uX0TGwZ7Jyw4JuqmuvD4FqFineS+JrqIoaji0+gfYwSlYLaOaI9jmCsUFAzMCu92HvM6htXL4rE+8TrzCVJU2QsMEzClEOphbFvoW+BIkGIStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569961; c=relaxed/simple;
	bh=WI5KPsvfrBEc/pHP6SorKiU3XsHrJyd1zfQTTO43RJI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZzWQEGP12Qu22c2sA9ui1Rm1+/7tzYtFju39M96WglVI7C6RG9CCwAGPsR7MUjNbBaY7ldZybuCZEenfv6LNsu06Ura1rDlzD2XQcjnhIkuMA66ceoQjjhbXW4SU8Lajnhs18wIicYXzgWY0Vx1o7pfkF7tF0RHQroCJlPHNcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ1mUsZY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ1mUsZY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso9124615e9.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748569957; x=1749174757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1cBDgi0vNS/awr62/Zsv6Hz+pRGKt66Q7F3sxhgcJ8=;
        b=UZ1mUsZYqLnvch/2kWgcThPhbJ1H0gLm9DYriAjixneURUfWfoxqquwy6rr+j4zodZ
         za3aTGMGh388R6tVsLjayhjIgrlC3VPMd1BBh/oMUFnqS8zVLntLP33C3vVXUFXYdPLI
         4k5KRPFqlrea2+PKKGScOPEAEl4gfidizrye7qd81R7O0xC8nQqrhERmw/mn+rmk4RYo
         iL9zorkOzbU/72VeWdTQZpyAGnI5FtwRyta6512evFUWbkM+J084bZb8P/6btp4F4ElY
         sQRGOxJxbl1pamvcPgG0MX6Xg4T2ffwoCGdZikN7+eJua3bAimE6uhZ0zm2Q3Za35owh
         6JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748569957; x=1749174757;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1cBDgi0vNS/awr62/Zsv6Hz+pRGKt66Q7F3sxhgcJ8=;
        b=OeqKd+P1oapEFAQ9csJqIDNFVw/prnTPIK4fmfbYrXz/q66PSd7wvBPfr9tbfHUdu2
         IqNAlNl1x6zJzSXReg8LgGuOdwewzd2O+t1ipSxpJTgqgs1JnGxtxvtyrDyIWbmSj4tM
         yLqo7Y1KEvnMLchQewRtyxrrRi80Nr6hoU7qXmvBhX7Q7Ideav3M01SzuK45D7ujyQus
         KGaJuvP6xBfo1cUB7RThYCoZnGlE5CPX1fqhuzDm6UcCvovpNw1heZp9m4ZxnNLqzHFd
         4WBLKDvS0cRun6G/ANY1IFIFj6XeqfdJevWql6OX1ZP/qBRiXZxXXQGUNa1DOVz8BOS6
         Uk3Q==
X-Gm-Message-State: AOJu0Yy/uYFox7flF4H10766QsZjr+HolC+xdvFNjJdO2dFEKyXoaCO9
	CISZd7XRvGYf92mslsw56jLFhQrP2YI2GTLWty66zbtIPfJuTiztFiat3vbM9g==
X-Gm-Gg: ASbGncvB5HU3XqezlfyoGLpkZLmx8tYWQlDR8X7xBsRkjfhK7APxMK3Fu+uFIQEXsic
	NqbktLVEyq/iCAIM9LcfQaJTYbg+UXgnXHDb9P5g9yMd9r8VNdFQ/SuWsCnGnM/EcF7ZeKsrSlf
	SRqr53plvsu2nFAdlTZyEIF/kpoU9k9KnMXY4OSktHo5zAqhNJ2c2Tdyt3hY0letEF3xXLNPNLS
	iezK3KIv8YmLOSnQU9eZIWsHZqk4VUq5ft5jJI2X8JgxfEJndg2MnTPCiXUFFcwU534xh5phNoM
	Pc4GUEIwPoWauxgyTAPQ/bLxBrt4O4FDxwDgWnM+fkCihR57MM6a
X-Google-Smtp-Source: AGHT+IGQbx+P7hQKDCmFxKTuqN9qtiWs2p+9zVieycG4D8Y1wchQXfTEYzjDrtvmgH8Aw0s2FQbeIA==
X-Received: by 2002:a05:6000:2083:b0:3a3:ec58:ea81 with SMTP id ffacd0b85a97d-3a4f7a6d2d3mr874275f8f.42.1748569957055;
        Thu, 29 May 2025 18:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edf9sm3890495e9.3.2025.05.29.18.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:52:36 -0700 (PDT)
Message-Id: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 01:52:33 +0000
Subject: [PATCH v3 0/2] sequencer: replace error() with BUG() in update_squash_messages()
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

Lidong Yan (2):
  sequencer: replace error() with BUG() in update_squash_messages()
  BUG(): remove leading underscore of the format string

 builtin/mktag.c     | 2 +-
 builtin/worktree.c  | 2 +-
 pack-bitmap-write.c | 2 +-
 sequencer.c         | 6 ++++--
 4 files changed, 7 insertions(+), 5 deletions(-)


base-commit: fcfe60668e05ffde2610bfef9045797618c145ac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1964%2Fbrandb97%2Ffix-sequencer-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1964/brandb97/fix-sequencer-leak-v3
Pull-Request: https://github.com/git/git/pull/1964

Range-diff vs v2:

 1:  aa5ff030b37 ! 1:  b812f973d18 sequencer: replace error() with BUG() in update_squash_messages()
     @@ Commit message
      
       ## sequencer.c ##
      @@ sequencer.c: static int update_squash_messages(struct repository *r,
     + 	const char *message, *body;
     + 	const char *encoding = get_commit_output_encoding();
     + 
     ++	if (!is_fixup(command))
     ++		BUG("unknown command: %d", command);
     ++
     + 	if (ctx->current_fixup_count > 0) {
     + 		struct strbuf header = STRBUF_INIT;
     + 		char *eol;
     +@@ sequencer.c: static int update_squash_messages(struct repository *r,
     + 		strbuf_addstr(&buf, "\n\n");
       		strbuf_add_commented_lines(&buf, body, strlen(body),
       					   comment_line_str);
     - 	} else
     +-	} else
      -		return error(_("unknown command: %d"), command);
     -+		BUG(_("unknown command: %d"), command);
     ++	}
       	repo_unuse_commit_buffer(r, commit, message);
       
       	if (!res)
 -:  ----------- > 2:  e1f84c111f6 BUG(): remove leading underscore of the format string

-- 
gitgitgadget

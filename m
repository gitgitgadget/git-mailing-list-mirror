Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674823A98E
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731562; cv=none; b=f1DQTjsimvrq20QJQWkOoBvsavnTjPMfMF+weR2twWZH6QCCtPyq1KrvSlap77Dx8d9MOKpwYCy837uBqB7bP3DitJSBM5buEWsV85opLVrt1F4fqku+GzZ7fg6IfgCN4V0iAv4SWtT9B524Ac/O3hPoR66lwd9jA2PkrSiYARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731562; c=relaxed/simple;
	bh=ltL0lRFmngsOqAg0vvZ1UCOUlrJL0bTqkZOLCIh4wYY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=h7pGPLUyUhlXP+A/HlQtzJvHlirn6QFl/YfzOQpqzMvOHEA2WLilF7tv2NnOZ0RChWznKXfvbk5dcO5dblLiEYbfFcu3NirO827sJzEXGSh2AygJPfqPqKgbXS8ESEpqoDCuKFL6owElA7WG32paW1x1LtXaMS3pAfDQwi/qVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8Xus+R0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8Xus+R0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a1603a098eso1585686b3a.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731560; x=1761336360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ILm6B7Wp1+bYh0inJY9tweHi4Dv8rIQssbNpF5QzrP4=;
        b=a8Xus+R0AtgQVHxtoxUItESueJhAfHUqZqmu8oPnylCcCLzE3+WB6E1bVqC74TIXYW
         hIQA97QzTnKuhE+i9v58VC11i7fiJGAseX3XKAp8epdCU+BnsBayyUz1XPZXTmSpnYYi
         PoigEf9mkpgcaiYwPdKO3SSq4l2q2trGZur8KnKC/JEC7DrS62r4cjLpnR8nyN6IiOZz
         BXQXT1bbDZ/2X6+lBBiSjyxpG6yof6Z8APzFjbzS/+AxRibcjk+yXLovvyStStZ0nOKN
         CcEiXvsUnRvQccnK+PI7hTv+ROJm5inOIvO0DPiMW0tUs//OMGfhJXCbedYm1V6eRuxz
         lDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731560; x=1761336360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILm6B7Wp1+bYh0inJY9tweHi4Dv8rIQssbNpF5QzrP4=;
        b=rfl0dElv/T6aoptRX8L8sOlU8TOFPB/yi5fQV+vEB6+hJ1607bVhfOzeoHXIrsFYUU
         hl3Ou8eGdU1NM8Qkp7LSF/dgM6LrxPhHwsCccAesNGOE92iCNRNI2iQ/e/R8igC8bmT9
         lnxWbn43nc1cDHupgwKWAklDGjvN3dI0vIC4AMRL14ZVlWtgHc4MDp1rHCquJ2OLQB03
         12hRa4gGmWYCnSSqGO7GVAI6F2F9L2lcxJGSWT8hay6nF9UYWkfExARmu1yvNOCc4b1V
         axoSZV+LoNqgRG4oNBGsfEoY3E6nUj5kkkEWvvGeL5PzIzy6z9P1EmGenyyxd4iaPYkV
         tcKw==
X-Gm-Message-State: AOJu0YxllZGhhgo+mUGKk4J+OPM6IlAZ7sHh6xJZ9gTdEp7TtwyMObPC
	THTRQzgmBQjJM2cS8Hyw+bIUFsTpkpJ85uxAD2bvT1ZzlxojZtwHT6oUHk1Ozw==
X-Gm-Gg: ASbGncsKIM7rR81FAc7mOq2wca7BiHTEA3p+eCyd8mLT5HYHK5KNm8BOcc0f5V9DF5S
	k8SnmnpeeKCoXbdb3IJUmqIp+YVNuBwwSBI5sgu2mkuHfz8WD3ECOxbsRYg11/3I9+f0eVn9tRz
	uWBaH0Zu4AnD4AhMjCe3QdTBrfqXXd/f2zLwmwvxozv/g8nrJh31Jp1Me7ZBxdaNX0wjKpK2yuA
	8w2WmpB/kAO+6YorEi2FRCNURA0Lucv2IPcYWmix9Td68WI37msOBfm+xFNusblcGLD0lrA4wQi
	7V7x43xLmA3P5jPPRucPj+jhBI0eQADDmSzEw1kfll2DBQwFfarHBLF++LO82fT5EkPesUfbUgV
	U+f108sCN69GGNDwAnrUKxKuOgHdw9qz+n1SvilSc6iYbAleOUS03qmMD5hJlfuMyxZSB7n85yB
	RytA==
X-Google-Smtp-Source: AGHT+IE7QdH8Z9Ctj9OyvojnU5qf2YIqW/d7kFHjfRfpGeU3csgQYIAceu2ETfcoGrt1wrOn2NDk1w==
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id d9443c01a7336-290cc9be17amr52636915ad.48.1760731559647;
        Fri, 17 Oct 2025 13:05:59 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde09sm3480885ad.93.2025.10.17.13.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:05:59 -0700 (PDT)
Message-Id: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:05:54 +0000
Subject: [PATCH 0/4] doc: git-reset: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

I got feedback from 24 Git users about the current git reset man page, using
this tool: https://text-feedback.wizardzines.com/git-reset.

My main goals here are to highlight the git reset [--soft | --hard |
--mixed...] <commit> use of git reset that many users commenting said they
considered the "main" use (which is currently at the end), explain how
--soft, --hard and --mixed work more clearly, and to avoid using terminology
that users don't understand when that's realistic.

Like we discussed with git checkout, there's some tension about using the
word "index" since on one hand many users don't know what it means, but on
the other hand (especially with commands like git reset --hard) it gets very
awkward to talk about what's going on precisely without using that word,
since the index is a core concept in Git's data model. I've done my best
here to use the word "index" where I think it's appropriate and use the word
"staged" otherwise.

There were also quite a few comments about the EXAMPLES section which I
think could also be made clearer, but I'll defer that to a separate patch
series to keep the size of this one under control.

Julia Evans (4):
  doc: git-reset: reorder the forms
  doc: git-reset: clarify intro
  doc: git-reset: clarify `git reset [mode]`
  doc: git-reset: clarify `git reset <pathspec>`

 Documentation/git-reset.adoc | 102 +++++++++++++++++------------------
 1 file changed, 51 insertions(+), 51 deletions(-)


base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1991%2Fjvns%2Fclarify-reset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1991/jvns/clarify-reset-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1991
-- 
gitgitgadget

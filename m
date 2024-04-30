Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042511A0AEA
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514000; cv=none; b=SQbvMIxt8hWHdhccyBWOelW6TLALjZJ114pjj2jaPyQW/WGNwKZhKcIN636Q1zz3DnoqjImiGR3leyScmWU2GOv7DNh/OUPHitxDWB2IrVTZz997arZtepJQGGGbQse+/MEdfeKFLHul+/xCNr9aFENlzztgOYIxoDl6cXkT9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514000; c=relaxed/simple;
	bh=I9q0idZZoM4Ym7WCfwHZDEoLVw137ckGUJeidIHuk88=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=GSfBbsPhYouh9JDhQ3BRPm2dGjtfQ0EW4K8r7/XLFm9C3ds28NvSYbteuPaHGcEoVeDNaI8X1P6/TQHq5GvJDjEUAnfi4eXI/j236evspIG8kUBFQMiXcgN3fIGJWdkJwJAx2QrLyar4nkBjpe8BTyedhbcNCnVkcfhX+IbJwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRRFIGbW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRRFIGbW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso43850425e9.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513997; x=1715118797; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Be4znYojXgCg7AMg1aRu+FeNKkqCQZzt9FZ2EhglDOA=;
        b=TRRFIGbWNGoaRGM2/BUIA5/xK3V1rL+HXtqojngkMmm9CbFevu4xTkWNoKxjLH3PtU
         aU6x0zFg2NiOW1w7tyTz/EA/MOuzsVIOgVQVIbTXeEnoMv/+hf4a6WSg6nmYSnoU6YC/
         RMF1LemvxcZrsfRIqiZtSEiDXLRuDn0qrYieZUjKzuIy0Rf2E4kWw1ns6ICjvqcWsdp0
         b0weEYYVpeux5qR2ujMt9btXGMo7E6C4RiGBcMEb86MvY5E8Gr77LpZjqN8fGX70vaRc
         OQDw/yd+crdDUljl2VU3PaF5dc+PeiKmHPwRQ/CN5W+K5ohIA6P8nrrPHhoSe6hq3Y6U
         bECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513997; x=1715118797;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be4znYojXgCg7AMg1aRu+FeNKkqCQZzt9FZ2EhglDOA=;
        b=gd/1hLJ+wDb0Gb7aR8GptBLAM8C+vdJPkLupZjL6e5PSxvGbXtrEnP4yOfTIFruADU
         s8jEoprnTx3oB5DkC9Lyacgt69Telx0yrBy9f1X0avCPCmPsBc8Il0yj75IvvOtFLeKO
         7++dfk4iNVraaJ+lMFvqakLWyroPQjhwprWCqrTDBBwZfI6LEIhlmkXK4OCaMHROpQ03
         HPURjoYgi/DMmDuRL4UhQmZj+Mmz417oeGB5Y78lQlmNcNvngofKyu4SvZJq5jOUwwi5
         JU9Jey+EAcY4/AnjTQAc94EkaI4F9MiCu+ufmD92KOuNzCwKAzrnp8nWUMElb5ByTv2w
         SJPg==
X-Gm-Message-State: AOJu0YwsdVgCNKL9CzoQUli4tSzNIiS/+KQf2eU1J++Io0h0W9bTx1w+
	oSiuplZ490DzwG4DvNhnnNT1RngM9FCLmWkTV38Jy5i9pmF/fjqJxSyr4w==
X-Google-Smtp-Source: AGHT+IHFeGyWlEj7sxIr46nW9FigThTdeoA0saDU0GXnm0KsSENZdOpSIsz3+/AIlfXKgTYi7pKX3Q==
X-Received: by 2002:a05:600c:4e09:b0:418:df23:ae0e with SMTP id b9-20020a05600c4e0900b00418df23ae0emr446744wmq.40.1714513996850;
        Tue, 30 Apr 2024 14:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b0041aa570bcd3sm177692wmq.35.2024.04.30.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:53:16 -0700 (PDT)
Message-Id: <pull.1725.git.1714513995564.gitgitgadget@gmail.com>
From: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 21:53:15 +0000
Subject: [PATCH] completion: zsh: stop leaking local cache variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

Completing commands like "git rebase" in one repository will leak the
local __git_repo_path into the shell's environment so that completing
commands after changing to a different repository will give the old
repository's references (or none at all).

The bug report on the mailing list [1] suggests one simple way to observe
this yourself:

Enter the following commands from some directory:
  mkdir a b b/c
  for d (a b); git -C $d init && git -C $d commit --allow-empty -m init
  cd a
  git branch foo
  pushd ../b/c
  git branch bar

Now type these:
  git rebase <TAB>… # completion for bar available; C-c to abort
  declare -p __git_repo_path # outputs /path/to/b/.git
  popd
  git branch # outputs foo, main
  git rebase <TAB>… # completion candidates are bar, main!

Ideally, the last typed <TAB> should be yielding foo, main.

Commit beb6ee7163 (completion: extract repository discovery from
__gitdir(), 2017-02-03) anticipated this problem by marking
__git_repo_path as local in __git_main and __gitk_main for Bash
completion but did not give the same mark to _git for Zsh completion.
Thus make __git_repo_path local for Zsh completion, too.

[1]: https://lore.kernel.org/git/CALnO6CBv3+e2WL6n6Mh7ZZHCX2Ni8GpvM4a-bQYxNqjmgZdwdg@mail.gmail.com/

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
    completion: zsh: stop leaking local cache variable
    
    Prevent leaking a local variable used to cache the repo path, which
    breaks future completions in different repositories using the shell,
    when using contributed Zsh completion.
    
    ------------------------------------------------------------------------
    
    I made a few attempts at starting a test script for this based on
    https://unix.stackexchange.com/a/668827/301073, but that code doesn't
    work and it was all becoming precariously complicated (sh starting zsh
    to start zsh in a pty which would receive keystrokes and check specific
    outputs: I couldn't make certain pieces work in a normal way locally,
    let alone as part of Git's test suite). Suffice to say I have tested
    this myself?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1725%2Fbenknoble%2Ffix-zsh-completion-repo-cache-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1725/benknoble/fix-zsh-completion-repo-cache-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1725

 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f618817..f5877bd7a1e 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -272,6 +272,7 @@ _git ()
 {
 	local _ret=1
 	local cur cword prev
+	local __git_repo_path
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
gitgitgadget

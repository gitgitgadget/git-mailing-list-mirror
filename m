Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58B204F6A
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379328; cv=none; b=TvQ7WKPOVfvMKA+7nZ5UGOFffHmRS4PXxfrn8bsSKphocUqlFdH8Vivk2BQ7zkHPmPOL5qn+fL/l2t8sedIbwipSmg2LKLzK3LlSaDEhxnfecnQMTRclf30+8oyZIZMIMDfPzzlahnVY83x4uyVeHxNFYSMM0DeXkm92uat+S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379328; c=relaxed/simple;
	bh=9z9WwDoIL4d1o4w7w+AUzCi+f0laywChg22TNRFsgPQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=udIIft2dYoc1GavnUqSgcPxF4+iL4H3vN0o8vnVmU+6wErIQSYwhk5N51A9rAfBGuVGLvm9KMUzrT0UcBjIqKO4siEYVG+9C1/bQQdDE1QP/4+0M5VKwQ1MFsL2+akloY7MLwDkcD8nl9JNYqJLotFby3/p+UuFOoSithmwqwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4dzf/Yz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4dzf/Yz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43635796b48so2224195e9.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 15:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736379325; x=1736984125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNGBIS2S2/OffgiN+WoKAtWlHt639QCQVPzCza2rJms=;
        b=k4dzf/YzYUG8f2xjZgsGP3Xw/eZJ6RtiytPjvjSzSGPVpXPwEnS8MVqENxgc9vJwcs
         Bb9wlZLOP5swG9ZbwdB8onbGAD0V0uJwGVzx5AH5YbxyKZKciSs9qL94iXZ9yk5wnlJ0
         moVv/4jujByPQdg/ZXFIe8nnuAoG9De7r7WR4yxacTYu4lbB+7cJC+lFZ90wO/s+vFVV
         utFUAkoXgiSHvZkMAW+lSxNnBtwhlUzKJyAO+R+quh3NtS0J4qooWP3173I9FBrmvKFG
         0e1tbjWUhJp5WnfaLB07VYBTK5xzJZgv6xPy16V+GbkV9aPO+jHumsdEzRlecGYAYoJW
         T7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736379325; x=1736984125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNGBIS2S2/OffgiN+WoKAtWlHt639QCQVPzCza2rJms=;
        b=FWW3AhHrhVQ69+DX/Y5Gk+RL5V1MnwNIXXaqimKa8Zs5J26GhGFO+Cl7ci13Toq5SB
         W4GPXwiM2bJN0e3i4Q9G3GexOUC0Xb1BW/lkIB+H2nqsyhAc+6cdUGccWxivRLhvKjeC
         TF7mAVHaCQrdnN6Ln2txTpp22eiNHtqNlC5Dhb0RkdKJdn66Hv1BUQSAm1Y+YtDnjj1b
         r4UF8S2vJ+ncxdD0nwQArelsRxeN2CDd6bV0VkADkYP0gFtFLUFcOjKwYW0exXibkoMD
         cuJzyixlvCFwPfYTqhZNehidnUWqK7Da3wOtoEuUUlBDkfx/Gfz4sXNETd0pkU5lzPmV
         RSOQ==
X-Gm-Message-State: AOJu0YxFxQ0dJtb61gQicxbCaLyke+O+8QbIOO228RjlUuzYLcXPi4yg
	g8jDwvLi7HgLyrPAW9Ur3xl01vB1cfak+4cc57EOExDVBQk9eJkJCSIKlw==
X-Gm-Gg: ASbGncuva9zQJv7PztBChfFaMSmbneLfgjqz33e5QqJJu+zNlJU/2QolOO1KSSC/zXa
	b10mAoiE652gUdk+wsL7+7lpcLPgdLH6w9SHEjj1Vrx50q4HCaA7UwPhRnaB+Ttz9AGSlbb29Je
	03nMIRKvKLek4Z0/hZVZsMd/wmc5NljQjcAv5X0mC/aIOUn2C0wxImcdMl+sLPiuomhfSY5/FQB
	OBpW+0R/0BkN0GT4S1G+onfy2E9yiXyaG3+Qp1NXuprX1qYK7DgUsnXqw==
X-Google-Smtp-Source: AGHT+IFAqGxJhFWqLkppc8eSnz1RKhaoq/FhdPU5hrUW2QdK1bKCL00T77Le06JYr+oPbvpu3mFwgw==
X-Received: by 2002:a7b:c454:0:b0:434:f2af:6e74 with SMTP id 5b1f17b1804b1-436e9d81064mr1257635e9.15.1736379324455;
        Wed, 08 Jan 2025 15:35:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1c01sm164041f8f.97.2025.01.08.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 15:35:24 -0800 (PST)
Message-Id: <pull.1849.git.1736379323427.gitgitgadget@gmail.com>
From: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jan 2025 23:35:23 +0000
Subject: [PATCH] difftool docs: restore correct position of tool list
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Matheus Tavares <matheus.bernardino@usp.br>,
    Adam Johnson <me@adamj.eu>,
    Adam Johnson <me@adamj.eu>

From: Adam Johnson <me@adamj.eu>

2a9dfdf260 (difftool docs: de-duplicate configuration sections, 2022-09-07)
moved the difftool documentation, but missed moving this "include" line that
includes the generated list of diff tools, as referenced in the moved text.
This patch restores the correct position of the included list.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    difftool docs: restore correct position of tool list

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1849%2Fadamchainz%2Faj%2Fgit-difftool-docs-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1849/adamchainz/aj/git-difftool-docs-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1849

 Documentation/config/diff.txt     | 2 --
 Documentation/config/difftool.txt | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index fdae13a2122..1135a62a0ad 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -218,8 +218,6 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-include::{build_dir}/mergetools-diff.txt[]
-
 `diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index 447c40d85a2..6cd47331a91 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -13,6 +13,8 @@ diff.guitool::
 	and requires that a corresponding difftool.<guitool>.cmd variable
 	is defined.
 
+include::{build_dir}/mergetools-diff.txt[]
+
 difftool.<tool>.cmd::
 	Specify the command to invoke the specified diff tool.
 	The specified command is evaluated in shell with the following

base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
-- 
gitgitgadget

Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54E2E84F
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479472; cv=none; b=NP/NgKo7Ldsw5Hi+vWY0VeFFB+bMxozueFq0+MJ3dAUZDVo2iaQl0x6q9/QZOvRNBSdYQRNMyYDXXoyTWggzMW1zkbmysr1rEplWA2tI+5jTd96d9WnIED6edakqEW0jSwm2DiNh7qhwUhk8Mk9vytgUlwHMsr6YjJFh4Wq/69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479472; c=relaxed/simple;
	bh=bS53j1BDDydxIros7Sv/03zhTn4NWH1u/v94Oqat9vg=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=qy6u6aknKHCGTEL0akYE2h0hr5wVHyBw8iy581OD7A58HPI+396WswJDSqENIqfvF4evYTPq9/ldJzQjr+P3gYmUBQTvA4wi463xj9YiI94uRzzGPQC6BoJFi+myf2q+BOqXTYlX9IKx7ahC7X+IyqO6u0laHlIG/A3ClxXhSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkY2QLvx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkY2QLvx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4107ed0c536so433845e9.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707479468; x=1708084268; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yh6gnJ1LNThabU2rVlGRcGLxe2dcRG9wTeolcc1VseQ=;
        b=OkY2QLvxe+Gb3tYH98DFiH7wamAYdSoj735AnPuWOWvafJj7WuI3Hwc37FH5k6LjFa
         ADcjJaabYvzABPYUQ4M4uVWIYhpPP5P0a8UNaPSaZPl0vYcR11/MrGVnctfwFDqCeqxv
         ObQhESKDo6gxFMcgBWPYlXW7IL2IlG7ei1LzRxxRdzIb/r/gF6fyaozLhMJglckjxHEm
         AILU8W8iLDR1VTuPxcr6f7GrvVuWggT/KZ/QLZZSnJDMw2KyjmTsNCh8rr/yjDMDJYkP
         YRqv9OeKwo7JCMSZ5MKNhqECc7mAnJtUGOFw7Sb2CcV2RGiJgKcudb4keASfxtlSM5K8
         jaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707479468; x=1708084268;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yh6gnJ1LNThabU2rVlGRcGLxe2dcRG9wTeolcc1VseQ=;
        b=uzNJlqEH+P5lW5/HafHLxY/uHcwBVebVsECtE3iJRvj+uScSBbWery63cegFgrGy+Z
         c5x5uwMBS6h5kj9L7sSsoTBJyU46p8p9TjEbrC8dBOwC8vGvpFKwEb3NQphnpXtA38O2
         lShSr3oGfjbsYvbS/idLKxg7XX8XZE+MeqDfSD+QNw3uPgL1wbCurJaL9ShewHOBoYyJ
         ktP5PhWUSFFx18yUjY24zw4XDQncykjY17OW9rSsr04BFFpiYYJCLtogxlN2WFTuHmcp
         qOVbEAPCaDpgrE0P8ZCGukvuVVJY0ff+QQBQBCl3GRt07ypu/Vkpi0nOOnjOFAtxFEq0
         Wk5g==
X-Gm-Message-State: AOJu0Yxkxy2AgQzO43WwF85+jsS9FDGw8rTqXeRrHpBoeMRmZyUMpRmv
	Ng2ZIg7Y35Lz3LJRyfaQ0dngQIaK3FnP70YCu2gzKGIFrxkmAuJHgFH5TAbW
X-Google-Smtp-Source: AGHT+IGExaalLpzoEsNM/EDl3+8iYtukqTLx/UyeZN/jZLW2rlGNqLhIGUw+2BwskebOHCnUZCiWMQ==
X-Received: by 2002:a05:600c:35cc:b0:40f:dc50:aea5 with SMTP id r12-20020a05600c35cc00b0040fdc50aea5mr1134813wmq.22.1707479468425;
        Fri, 09 Feb 2024 03:51:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b0040fe0bb761dsm392159wme.16.2024.02.09.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:51:07 -0800 (PST)
Message-ID: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 11:51:06 +0000
Subject: [PATCH] doc: git.txt-Fix inconsistency param description
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
Cc: =?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?= <ttdlyu@163.com>,
    =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

From: =?UTF-8?q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC?=
 <ttdlyu@163.com>

Signed-off-by: 秃头灯笼鱼 <ttdlyu@163.com>
---
    Fix the inconsistency in the description of the namespace option's
    parameter
    
    Since the parameter of the --namespace option can contain path
    separators \ and can be correctly parsed, I believe that
    --namespace=<name> in the SYNOPSIS section should be changed to
    --namespace=<path> to match the description in the OPTIONS section.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1669%2Fttdly%2Fdoc%2Fgit.txt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1669/ttdly/doc/git.txt-v1
Pull-Request: https://github.com/git/git/pull/1669

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0d25224c969..eee277495bd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
-    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
+    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<path>]
     [--config-env=<name>=<envvar>] <command> [<args>]
 
 DESCRIPTION

base-commit: 5216f8f5c4089ec29ce49afa147434c23e0f0163
-- 
gitgitgadget

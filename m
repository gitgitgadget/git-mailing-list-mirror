Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A612FF70
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496858; cv=none; b=Giu2D+MxKuCavsSudcMKjtyy2D+BFB+S+pQp5S37dkzV6HxCOYU+GtFDreaaT1PkoDxvRal9rofWoLc1IIChghICrIpfKE0PJfaHxf9FRNH+i2VZj+L5HbAKSj5+1Nx5LubCSicMdI0vNRpvcE1xh+Jai070m59vIzuloY7Am3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496858; c=relaxed/simple;
	bh=RIoBuo1eMFLS07PfAEfibAkUdpAgpzsVQXUYnI35ZF4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=nZj/dpkPr4/Bj7dyZ7V0SQpLyXFPq63ApFPbxn3PMtIPlXOAhEUGqAOVK5miah9UGAFy57wABr/4UKIAergaMnHcyDyaUA8xtgfnP7cgpCRz6biOl91ZSiqUYiv+uNV8AbaJu7h8xXpyNvvlcX1icV4w1WOaCVThrwS+0S+ByIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYAOpbyo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYAOpbyo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso19962375e9.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721496855; x=1722101655; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYyzzKDTOADggQiYzayKZwt2Pel6N9agcql1kNgMr2w=;
        b=XYAOpbyolpvhl/xdNFdIdShQcex+OQRgKdDlSil7spLrZOHVE8u+GbTXzBassfkJ9l
         ZtMaIBlP/e/9LPLwUPr5r0E16pqFLXfxfWMd4BrPYxkAsuqQhSFSkTtkoo69Bclgqe0q
         xIcxY7lTjGHKOvgWvpk6yPifrtWV36HUgGx3xmL+bvLVpKAVJmdFOWaxx+RSQhqWypD/
         uTXAWnxofvE1OTw69718aulBL+lHQKIIdrWlfuqy3IXcXucISq96WJ7JnHXc5jn8QIBz
         n1cMwmkbCLVFp0VygV2VneytC3JRgSCu/SMfuDQhh6bVlYTC5f4tPLI/cFCrH7iuJLY0
         dZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721496855; x=1722101655;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYyzzKDTOADggQiYzayKZwt2Pel6N9agcql1kNgMr2w=;
        b=vzZ/B26zn3hADK2OW/NVGFUldCiMOAHksnWroXycJJagBOHsNL6stdTt6l/gxejQlK
         DNO71Y14BI83hS6dW1TvT7KtuzRgrLRGDFDnaRVYpB+43Om6SmT0n0DxrkQSI4kQN4Gk
         dUgXK0/EiQ4IontLt1qwaVGqhuIwnJZ/B+E5XJ36r8nZYINHVAJBEIT9cNzoVD/rZjH5
         GehYmZ51uQdHqjxn7CfieX0RWLKnyfu1qF1Bdpm8mZGYkOJ9gmeBvHAoss3wpJk6RD/V
         uHCc0+ySTidT8aC3T6e32rXEyoGAqpaOOvfK2J5nGfvGq2JHrDLcv0n4PPL14sZBiyzL
         6FfA==
X-Gm-Message-State: AOJu0YyTnVfx/AdtpMsI6jS4F6mMoKmM/dLjcX6phSX5OvXNKcf68cY4
	GG1L8woEvjJsDeKF5K9WNLUkmm6b5VC9Vrz9fjfcKmO7Z/jrvKi60d7Klg==
X-Google-Smtp-Source: AGHT+IHedRKUzA2shnLxlNU8+EyYIRBMjDzeOs8bVSZAaFxJ6JuV7rHoSdgmvr6+ZlIS9Pb/fakUyQ==
X-Received: by 2002:adf:dd8e:0:b0:368:4b3a:2022 with SMTP id ffacd0b85a97d-3684b3a20fdmr5362869f8f.6.1721496854689;
        Sat, 20 Jul 2024 10:34:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed595sm4298266f8f.107.2024.07.20.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 10:34:14 -0700 (PDT)
Message-Id: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 17:34:13 +0000
Subject: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Asciidoc.py does not have the concept of generalized roles, whereas
asciidoctor interprets [foo]`blah` as blah with role foo in the
synopsis, making in effect foo disappear in the output. Note that
square brackets not directly followed by an inline markup do not
define a role, which is why we do not have the issue on other parts of
the documentation.

In order to get a consistant result across asciidoctor and
asciidoc.py, the hack is to use the {empty} entity
to split the bracket part from the inline format part.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: git-clone fix discrepancy between asciidoc and asciidoctor

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1765%2Fjnavila%2Ffix_git_clone_format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1765/jnavila/fix_git_clone_format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1765

 Documentation/git-clone.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5de18de2ab8..8e925db7e9c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,9 +13,9 @@ SYNOPSIS
 	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
 	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
 	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
-	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
-	  [++--recurse-submodules++[++=++__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
-	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
+	  [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`] [`--no-tags`]
+	  [++--recurse-submodules++[++=++__<pathspec>__]] [++--++[++no-++]{empty}++shallow-submodules++]
+	  [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
 	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
 	  [_<directory>_]
 

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
gitgitgadget

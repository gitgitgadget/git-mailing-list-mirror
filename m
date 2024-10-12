Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCEF156871
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745405; cv=none; b=Fu9uEybHJa+wKDuwTGR0GVDJ/kaWOnFkE/eTgyr9nJAdwJDCfaC05fIs4uMqL2gKKbW/ltNAOBWC5eNTgSZ4LWPxCo4IEAjt5ywxcfrJZSEeUc10Df5lR5wCH+Bf6J7Fg4QrlTYdZL0K6bMZZDEDmAzkMjdKxldS5YUa4JY10mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745405; c=relaxed/simple;
	bh=IsKekA7fY7AOSeTiRkdgm1qCEdEe17bda4aJsWf+vEI=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Je8T0EJfDg0YXP0E5vaonoWfciiCDx/ejhVl6vF5sKgE/ycPOVfmvGQXpDvDK8aJXG89AKjXkEJsz/mg+BlhJ83wQBDbTwjvcMBlnlfaYyc1kUF5q9tyb5ktBjXbBSBb3G7F0wIZbG8h7ta7DWBLXqC1Ju2WwnSiYsCoOAOS5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyHLTxzl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyHLTxzl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9952ea05c5so450785566b.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728745401; x=1729350201; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uTdTjKNq1i+JagqCOfJsVrAXvkvXnUjw449ZL0TT060=;
        b=GyHLTxzlQjsmXCQVfvuRjFIB58Q0Zp082858lpQy4BPwuvTWSdM/GHBoNZZrj/0qtd
         oKAMRDoPisV5E6EZzWN9GW+aAsE8TLHkgFE5l89nHbUAf/iHtB+4RAc0HX48cZlga9X6
         xUnq0AoJpSfInfkPx28X5ctfq6uq8B0i2ldi9COb9tFacE61aZ0JIsTYhS69IUm8rdNo
         BcGGE7rLkhHpki9TblVuSLWJk3Cu/QJkPrOwVVq3LOXLSKPyTbumqV49sLf8ibM6HezS
         8ajaCDNiHzg/vyhdmcjkd/buo41qqzA/lkz49KvF5VYCmqSjnw8F0SR7HESqql6yzPjP
         YPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728745401; x=1729350201;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTdTjKNq1i+JagqCOfJsVrAXvkvXnUjw449ZL0TT060=;
        b=nqcoxf7TXbnkht/TXZbLJHzlydmUr5MIU3Qe8KKPhOE0SKx3SpQj9HeDViDAHgIQBl
         hj4jGL9ZXsMIxR2640LSqmZOddZMyCaaX3Y7cBMQRXk+3yvurH+yGDFr7ApSdUGc5Jyh
         GzkWynXcgpwTMNJtKY2lq693NXgcCPpe9pZwJWALjBnhRnrmo3WESR+nSs/4AUN1f+lK
         eOOciDnc9yrk7IUCiAzIppQvNziHh86RwP1PcikmvtYI1JSxOTtP0gV0QUUOKv54UlsP
         s4oekveFxizr97hdfGqDb44uSJlTyuDGOiU0/GbJ25HEoAC4wxPU42iqZRk2adNJDLM/
         rKpg==
X-Gm-Message-State: AOJu0YwI3r4WVP667QwlAD+s4Lp1ufqlksGern4bSTozR7DLAbgOIZ9C
	c4vz2KvPyLnmz/FCQOVWQO4emxY0KIMD5rP/8uYg42p3HOF3uERQFRNhgw==
X-Google-Smtp-Source: AGHT+IGpcaT9ueKF8+Y7Q/xPcnRfJcgZEGdUtCFCLFwBDbHGNZOXcbnWmAJjGoOro2RepJmkeRrWow==
X-Received: by 2002:a17:907:f7a6:b0:a86:fa3d:e984 with SMTP id a640c23a62f3a-a99b945dca9mr569994166b.20.1728745401131;
        Sat, 12 Oct 2024 08:03:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25411sm331586966b.67.2024.10.12.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:03:20 -0700 (PDT)
Message-Id: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?imme=C3=ABmosol?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 15:03:19 +0000
Subject: [PATCH] diff-highlight: link to diff-highlight in DESTDIR #Makefile
 #diff-highlight
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
Cc: =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>,
    =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

From: =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

Make git's diff-highlight program immediately available to the command-line.
Create a link in DESTDIR that
refers to the generated/concatenated diff-highlight perl script

Signed-off-by: immeëmosol <will+developer@willfris.nl>
---
    add symlinking diff-highlight into DESTDIR
    
    In order to immediately make git's diff-highlight program available for
    command-line instructions; add a symlink to the generated/concatenated
    diff-highlight perl script(s) in DESTDIR

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-938%2Fimme-emosol%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-938/imme-emosol/patch-1-v1
Pull-Request: https://github.com/git/git/pull/938

 contrib/diff-highlight/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index f2be7cc9243..10c588a7929 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -9,6 +9,7 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
 	cat $^ >$@+
 	chmod +x $@+
 	mv $@+ $@
+	ln --symbolic --target-directory=$(DESTDIR) $(abspath $@)
 
 shebang.perl: FORCE
 	@echo '#!$(PERL_PATH_SQ)' >$@+
@@ -19,5 +20,6 @@ test: all
 
 clean:
 	$(RM) diff-highlight
+	$(RM) --force $(DESTDIR)diff-highlight
 
 .PHONY: FORCE

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget

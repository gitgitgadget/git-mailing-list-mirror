Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118F329394
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882582; cv=none; b=E5Zm+mX8TKaHARDl2VAjBdavBsP5s8Q988r/sJqZj2IlZknVLWiWLbXm9yNFoauUmsmG93vdg33EufbuthJqbbKEkG0h/r+ffZeNJ5b5a+WiKVcH40orlk19BvuFoCkx7NVMYG1KK1P8eaaAt0G2OCpDW3JMzdiLJq52bhriR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882582; c=relaxed/simple;
	bh=ouSuM9o1W/4Pk3dZTHqcLD04vsW4MFvub1d28uAQRzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmWQtf8O6Ytr/6YWx5lXA6AoTZqu+G7DNCWgcSSdCYuyUNYmrku4SFPNCn503gMZFFCXLRNm7ZT/gST9f/6K/olaF51vRymQadKH8iMhxSKxnNaA8OyqM327/ZRG/lwDALRFPVUrsqCc9o/u5brsZ4Sq/h/caWBYUEDfrFKnZTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jelRv2A3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jelRv2A3"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bddba676613so922313a12.2
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882580; x=1765487380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOajHTO+VZ/xPNcVebIQefbT2GfpOftgWfktOYBWjDM=;
        b=jelRv2A3Aj+FOWPXEM9Drl4Vw1j56pwxucQ9gDOs8UfyORRkzpIB3a6fjlHHib83XO
         my0mdgoqcU+OYydIXTPvhKziwbLJ0LL8GcFeQiBl4gxfXYzijignAlWHn3rcamAirMnB
         cIOy2o0h0AwJuRrkLiiwY9ZLv9RftRehAla9TZD9d9SuJI0EqRxb4TIzWfJIHvEumhSP
         87CImowcl7iaNaVs0d11HHYhvk3zegZX9RpcxwbcgyJyDeWq4NUNeUVHWxBBBmsIvkxI
         OWU9qkTujPQYtCNdrRd1BU55MD/tj+lnS/ts7kNPNzlyOcaJLQf32pmt8xqcNUnyxIm2
         Xb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882580; x=1765487380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOajHTO+VZ/xPNcVebIQefbT2GfpOftgWfktOYBWjDM=;
        b=V0PYWSHwjUT90SsYprtQRc3O9Y9o4uWfWcY17TYswZHySCTkaiUKpKozerpbBGrdYh
         SartBCm5DbGlcosF3nN3MVQtpooNYdPEVOSNUTzgYu1HSrKvdX80lXfG0+dhJUDD1/sL
         g9lrHszok/e1cqrmcqlsj7XNKYIJV+YjLMJr+kzGo3b0xMYevqmyYHtPOUbclP3Up/qr
         sk0mX47RtyTXhMp8X/GApJoqpv7bzrHdo6AF3UB9r/DHXzGiO20KLswE/UW5kRtzBhWH
         27e/J1Gx6TBvejXGM8wNrqE134pT0A5jjGLkpG5RJHwFQNXG/iGRKhlM31u2CxKlOyuc
         kwfg==
X-Gm-Message-State: AOJu0YxOUWQ4+0Q4Fx/gM537vePxHiH25yZaCCO+Olc5s6KzQJArsTCH
	vpgm7xOPo47zDPwlXmyQ9Oi2dfdR+8veXxsk+bjT04J+zN/R5sOmCSnAFrY/oA==
X-Gm-Gg: ASbGncu3or2oyM+gRI8EuGEd1dauyZ6xbgvLl0uT4GBtHU4qXIdtbVjf6877yKAIGBa
	PfbTSzvThrsin4+uBCe623tZJEUS+bzB5IzmN5+INIT/rRcqq465y7C5uONHF7CV+QsMNWvAgfV
	fszg6WubiDTbjP1sCRe5nzHWP6Tat8cx236fzqMoGaW2n6oLK+NqmreWLCfNzstD0ACb1Eo0tEW
	B2G8FyDtZQAoIe1xIBgr2vzEKi6hITXxpyqcCefdN3v95PyI19hqw9kw1tsfv5zYi3bVvibxeuE
	YHPfOKv4pc5qKc9WZX1Eg2yrdMq6FY1dG/FnQko7S4Bn8ffEOWOMvpN7A/uWTX8INBtg+GOUGYe
	6AIpEcC2SVmlR2ugDTIaTUPdcv7JbxB+ecSmfKdMytCZjdS/Dchhf5FZIg6bSK4aM8ZoKkA8DX9
	6uXPAvy2hXhlt/25mcqsJId36gaIV5jI0vzwyYeYk+pKDOjHBtR/ZP0A==
X-Google-Smtp-Source: AGHT+IG5GWev/UutZsoAfWgp36sGt97ObgvB3JuYRG+HsSjcRrb/XhaYsfygLSesQw8wGEkZrKMlOA==
X-Received: by 2002:a05:7300:5a0d:b0:2a4:3593:c7df with SMTP id 5a478bee46e88-2ab92ee610bmr4461300eec.31.1764882580105;
        Thu, 04 Dec 2025 13:09:40 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8e1d:1817:8b3:9658:8ab6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba822b615sm7882624eec.0.2025.12.04.13.09.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 13:09:39 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jltobler@gmail.com,
	ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 2/3] repo: use [--format=... | -z] instead of [-z] in git-repo-info synopsis
Date: Thu,  4 Dec 2025 17:10:11 -0300
Message-ID: <20251204210843.79411-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204210843.79411-1-lucasseikioshiro@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag -z is only an alias for --format=null and even though --format
and -z can be used together and repeated, only the last one is
considered.

Replace `[-z]` in the synopsis of git-repo-info by
`[--format=... | -z]`, expliciting that the use of one of those flags
replace the other.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++--
 builtin/repo.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 5d9c7641c2..f24514deaa 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
+git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
 git repo structure [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
@@ -19,7 +19,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [-z] [--all | <key>...]`::
+`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
diff --git a/builtin/repo.c b/builtin/repo.c
index 2a653bd3ea..cc97dd1836 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -15,7 +15,7 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
+	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
 	"git repo structure [--format=(table|keyvalue|nul)]",
 	NULL
 };
-- 
2.50.1 (Apple Git-155)


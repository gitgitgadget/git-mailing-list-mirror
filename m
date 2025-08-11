Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD21EB1AF
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949877; cv=none; b=HxYWfgbo9QaIwAJOpRCIZgfWJVJYiKiKfzPu0ae12IEYp3eEwvlkbYiZ2ZDbxy86eIlvANjCe53SdL7mszx3Wjdjo7bK5ij0TLv+kBERskgxaf+lfxrOmgX/4np3bssGvYQHoV6465vR4Tg2ZamY32nWwIV3S8a9Mb0cP+W7nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949877; c=relaxed/simple;
	bh=6OvRAMKSIJbl00jFXTU7oHANUewnjw3VIt1bZAn5c74=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=njKWUXffhfQnDj+++WZ3T28f0tFY+C0jimRIYa2Pfq6ekTb9Xp6xllhAc4Kn6krc9i4ci8L7fln3e9w9u5ebUdctBLc/+Lk7cQS8C4qsZ+5gUYETWjHOTVWccxxQoPHzwgwRYwZA0tZTjgxYpBs+PiVQHlI/tJDZrSw35goPMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvGppfYP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvGppfYP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459ddf83023so29626875e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949874; x=1755554674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a62vmRMi1htCJq97nCgi9k2KD/y38MqPAfe+0tNh+s=;
        b=CvGppfYPM4T3hM8aGDszas02TrIQ4PgXjKDP6ePWw/xI8PwROZV9xEAcCP/TfXVRDt
         5o8ZYxolsNvVfxABvSQ+CHEOA7bDUfDf9Ybhj62ewFyro+72UKs/L6rI8u+y1VU39AG/
         GJGXOZ2A2NY2OM4ypt0BnSHylvqoCD/4csYUovlGDEduf9NtkF+wPC1WqBfges1IXmV2
         lUCrYcCCpOdYljanHU848ckRJ0iiyJWifVBe5fU7Q9zughsoqvvglvt8yffbnVu38B1U
         LE00U4SBQve8PRylFN1zZ6iLWCmD6Q0xJD2WRL8dxT9HuURJKhsY3JTYiPl7IsM+cVp7
         OvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949874; x=1755554674;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a62vmRMi1htCJq97nCgi9k2KD/y38MqPAfe+0tNh+s=;
        b=fDK2T72Zs1ubM96/qQ1+8/BMr0E79efmcZxl3MYrpHzYw5ZV/ieJcgmray+5its223
         mlrE0tA0pRNTdGK3alciWLK+ZH8hY1ZParu44pDdzwKcajdXkMWwpX9f1j3egsUeXVbR
         m71C3k70qO6MG2JREja07rAlLsPnoJUk5/IRqcMdk+HDZUtHHbn/udADflnleWM5EH4g
         FF3mXUtrv2CnxWxKAk6YH3+yd3Jp3MxnHNl7ApFvLZfRlpX/2GikQ9SgTyAosfsdzeKh
         meXZXUUexp/jhizYOjOvt4ZH+H731zXuexlHDeLdf0e78JEWwYSh/QFZr36RfiFmglre
         NDkg==
X-Gm-Message-State: AOJu0YwkLJpbMdZX7BIskExGhOx8n3Ta8gZm7c9YDA10kj/nDpZU5kga
	r5frbkbGpbugcnmlPTyIMe+VlTi8WNKrSmtjsZauRYPNxyDUKojXpGk78+eg5w==
X-Gm-Gg: ASbGncuUjK/9VE3uhJZ05oCAabzEaF+YrUZ0lLIi0NMmAc9v2JzOFgHYNjOg8/DYbVW
	4hE2FXMQl2zBP+EMZfAnN1beeQJNTMKKbmcFvRbNuknMSJMdJ++IhldIE2B/Pswr2NF42cpDXU8
	9xpgFe1UzZbq8cj7r4kvYKFHi8Fq1ibpNvL+8DmlW9d+lpOL7HkGgeDVRKkdmfWu3rB2Y7Bypk8
	5XwExgdH50t1HnTEPtQ3jI2ABDyj5+P1A/wtYPEo053QepnpCsI0m+qgsNko2KQLNM2nFk/21IJ
	2gbd9sWrTZFuSjIR7tZHZ9/T5wG8KsWvvuc9kW08liPcLAbliLw+sTZRaxQQI4b7Obh1BtaASl4
	9ymmIEmunxq9tIq+Ttw/kGWI=
X-Google-Smtp-Source: AGHT+IEVZ2X4xE3msuEibiG9kj4IGaeyALdXXo9dByJf2szJcPDm8Wzxi8KtgCAlRgcEloy2pDphLg==
X-Received: by 2002:a05:600c:4f86:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-459f4f1278dmr139712625e9.17.1754949873853;
        Mon, 11 Aug 2025 15:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm40907807f8f.57.2025.08.11.15.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:04:33 -0700 (PDT)
Message-Id: <pull.2023.v3.git.git.1754949872593.gitgitgadget@gmail.com>
In-Reply-To: <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
References: <pull.2023.v2.git.git.1754861423787.gitgitgadget@gmail.com>
From: "Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 22:04:32 +0000
Subject: [PATCH v3] docs: remove stray bracket from git-clone synopsis
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
Cc: Knut Harald Ryager <e-k-nut@hotmail.com>,
    Knut Harald Ryager <e-k-nut@hotmail.com>

From: Knut Harald Ryager <e-k-nut@hotmail.com>

Remove the extra and incorrect closing bracket, so that the line reads:

    [--filter=<filter> [--also-filter-submodules]]

instead of

    [--filter=<filter>] [--also-filter-submodules]]

Note: Both filter options were grouped when --also-filter-submodules
was added by commit f05da2b4. The extra bracket was added
later by commit 76880f05.

Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
---
    Remove excess right bracket from git-clone docs
    
    cc: "Kristoffer Haugsbakk" code@khaugsbakk.name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2023%2FKnutRyager%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2023/KnutRyager/master-v3
Pull-Request: https://github.com/git/git/pull/2023

Range-diff vs v2:

 1:  bb158425b8a ! 1:  c1a167a16fd Remove the extra and incorrect closing bracket, so that the line reads:
     @@ Metadata
      Author: Knut Harald Ryager <e-k-nut@hotmail.com>
      
       ## Commit message ##
     +    docs: remove stray bracket from git-clone synopsis
     +
          Remove the extra and incorrect closing bracket, so that the line reads:
      
              [--filter=<filter> [--also-filter-submodules]]
     @@ Commit message
      
              [--filter=<filter>] [--also-filter-submodules]]
      
     +    Note: Both filter options were grouped when --also-filter-submodules
     +    was added by commit f05da2b4. The extra bracket was added
     +    later by commit 76880f05.
     +
          Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
      
       ## Documentation/git-clone.adoc ##


 Documentation/git-clone.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 222d558290e..d829206d1b5 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -16,7 +16,7 @@ git clone [--template=<template-directory>]
 	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter-spec> [--also-filter-submodules]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
gitgitgadget

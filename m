Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0228A3EF
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578089; cv=none; b=Ppbg804B4Kb6ydLIeiH2RyjtC47vZ0y6ix/uOgSeAilFFtqQNjRUuJMIG9g/Sv0c+sYkl+jVmPAqHPGFxbVNa9BSYv/G9YLA5jwBF9ZL6cnAebIu6YAVfIObZbsRnBYwH3HxrzCqsfBc5IDiHNx/Fkx1GdjbV8KUES4++YQ1K9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578089; c=relaxed/simple;
	bh=vkChuBJwFs+V5E0AbKYvQVEDahRTfCQwUyLOaGWfaco=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HfDwmBPV9RFUUiNr4uYcwh1Ifhou3JReyCFoTmBsyO9SOREDTXkaK10oCkD77qCC4rDzJfBcxTO1+3t7T/ZjgHka4nOa2cgG6SCFWsoBUcYuXB8JcqRbTzjMwDDPyYBwIX4U5uIdPStMldFoMFwJ/rbgI1lediqs96rErRno79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlG7I8AN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlG7I8AN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26e68904f0eso28250765ad.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758578086; x=1759182886; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/W55tTP7Jgkg3E+UxX8sBVf/gVy7hU+dt9dgGtWnrTs=;
        b=MlG7I8ANOqNf79JeyFMb7wHY31Bjh+wQgSPsei4A2Jkt2vDdeKVP7Um6NZiJtZzbpJ
         muaKCRnMk5PQIELr6YcTc8CMwZBgtdCHzbWxr7bur1BbDeag+8e8cYQ46UlC9MJjjjJa
         /yMzoPQXK9SuP9GVQIlOS0CJmsPveH/03G+gFHTIa7Ng73NtFrkpslzJA9xzeYT+cTB8
         ClYItQJDhfFuG1mtz4B+LEzzzAjH8TyogiKWo9GvQOSaqZEcphML+TqnB2/pBmFWsKBa
         lvRhh/MvtjjUrjUFWABSvGnljSSxnqcPz46HkJMrLvH6ERfcGsnzQJ+XU4hVs0iOag3/
         Pe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578086; x=1759182886;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/W55tTP7Jgkg3E+UxX8sBVf/gVy7hU+dt9dgGtWnrTs=;
        b=vgNsiFR34gYVUuuPcP+tMeO0s3mBAy4TkJlLJoghgDjrAckS68oU7WKG+N77SYei5H
         pZYfEQly3cciW/w49KWCJ92Zpvqxi8OvCRnkScj+nvFZChTpX/mevGKcyEK0XTly4g1g
         Qqrnu2JMmPJ0FlGGB6LL7GXKh6R6oCRw5oNDdLiAIOUzzeIz/nw6YxtkzyyRTvxpLCwn
         7mpP9Tkj3Ktw6Y08/z2EMzWxjmiq4B/cV/vNVk6twdABLvwuc2kg7inppOpR/HN0a8xc
         JR8BnKKlnKvnjOlORjZrCellasE6vCeeyFQvTsH/qLQbfusNjFdHinLfGpr8bW2AvnPC
         tI6Q==
X-Gm-Message-State: AOJu0YxTis/Tez+h1VXSx8myFupkvkW3RK5nM8OysA0+bcI+2k9f5fWH
	IJaXZhpJd3JKMZywHwPCvEI4fEx8BQ1zyVVTBl/7JpNi5I65zK3lUTtU/Tlazg==
X-Gm-Gg: ASbGncvOjQROfppffLCrlvHk2dR/90DUvYhORNfzRzpDayAFzaJ1kbc2HBvdMe51dIU
	4c0Nz4Z2x6mBmBzpkH4/q73fNj134fLR6kRl8ehjqoCriasIJYDcQtVWg2OikTivpFmrvs0G2+Z
	/Ajrp1M7NFE7zdiSLx1JKVb879Q30BaqZsrXp564G3GrkuLQEi7HfNZXyhoP723rbqFlgQB+eK7
	KYQxbWjoiGYxHtQuvXeCuVqw5jxEH3St+WHL2hSzuPQV1pIlGzVsTZgrTHOm+5PkSLNlaWYQOQ2
	npmYPpe/e5szR53jJE1Kl6mZp59nGp3DEzgPsGl2UXfgE2qau3gTdAAnZ8QKondnfoUc3zeE3OP
	UVM95Vk+dqkFpilcONVKkkXmv
X-Google-Smtp-Source: AGHT+IF5VpoErYiXxFvuT2SYj5+4InqWGO1nh+WiMGDdcRrOxv/aEOzt6XzjLyMqbvxRErVsFMmsjw==
X-Received: by 2002:a17:902:db09:b0:274:3db8:e755 with SMTP id d9443c01a7336-27cc79ca32amr3784955ad.30.1758578086017;
        Mon, 22 Sep 2025 14:54:46 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm142952695ad.109.2025.09.22.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 14:54:45 -0700 (PDT)
Message-Id: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com>
From: "Alan Da Costa via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 21:54:44 +0000
Subject: [PATCH] lockfile: add case insensitive filesystem note
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
Cc: Alan Da Costa <alandacosta@gmail.com>,
    Alan Da Costa <alandacosta@gmail.com>

From: Alan Da Costa <alandacosta@gmail.com>

* Add note of case insensitive client filesystems may error due to a lock
  on a case variant ref to more quickly identify failure in fetch/pull

Signed-off-by: Alan Da Costa <alandacosta@gmail.com>
---
    lockfile: add case insensitive filesystem note
    
    When running git fetch or git pull on a case insensitive filesystem
    (e.g., default macOS), if multiple case variants of the same remote ref
    exist (often after a case-only rename), both variant locks map to the
    same on-disk path. When a local update is required, Git creates a lock
    for the first variant and then attempts to lock the second, which
    collides with the same lock file, so an “existing lock” error is
    reported. The underlying issue is mixed-case refs; resolve it by
    consolidating the remote to a single-case variant and update local refs
    accordingly.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2053%2Fadacosta%2Flockfile-add-case-insensitive-filesystem-note-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2053/adacosta/lockfile-add-case-insensitive-filesystem-note-v1
Pull-Request: https://github.com/git/git/pull/2053

 lockfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..99a470bd3d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -156,7 +156,10 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 		    "an editor opened by 'git commit'. Please make sure all processes\n"
 		    "are terminated then try again. If it still fails, a git process\n"
 		    "may have crashed in this repository earlier:\n"
-		    "remove the file manually to continue."),
+		    "remove the file manually to continue.\n\n"
+		    "On case insensitive client filesystems, multiple mixed-case refs will resolve\n"
+		    "to the same lock file, possibly causing this error. If so, ensure your remote\n"
+		    "refs have a single case variant."),
 			    absolute_path(path), strerror(err));
 	} else
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),

base-commit: ab427cd991100e94792fce124b0934135abdea4b
-- 
gitgitgadget

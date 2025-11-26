Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B930276D
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167632; cv=none; b=gsLHrh0endcQ2vf7GwK7eyW6lsrKDzgNs5RhIoWmbtZGT2cQmX4KC/FNrgK69V02fMGHLqFLMuEw6cGalXc2LIzBHpORajHTx//ar0gzb2QIEnvZTDCOoJqi/6fiobytw9sb96FwC+p6jLjtlZxOwQcLo8q5XYmiXsgcYzApdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167632; c=relaxed/simple;
	bh=iKmT0LNDDYk2KIliLWJZXOJep0qdttG9yP25hNDb5VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOhgxAAVuIz0WXdl/d7NYeVSWIO1DBxmkqEdaGAlcwuUJYmU2xhtW5SCoeXsbhwPHpdAAgpKSk/MRcgTFpJ5cogyuQRXgQF0W9LDaOAZXaJajyHJcaZ2Ouh0cWTcxliTVmXiMdKr+J86IqvnOuC6bjlTI5/sUyQbjLwNFDZcKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLvNb944; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLvNb944"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so48012865e9.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764167628; x=1764772428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inLw6P403PVCjdCrnZ3KiTkhwHLqP3SHDGypF/i5VfA=;
        b=mLvNb944iGA76PsSwg5N2LfWLbEYjI9VTJXe06itHrnZ8P6xk60N7GGRxPdGsSCwyt
         V6nMd5x2OfudSZkpk6Dm9TCbIBZ68Dp/8MlHl5iLDXGTPzugx6ylHzmAVL/HC8Fj/p8G
         soLJQ9XdR9SE939adewYXBZ5Adez2TptPnVf+FxyFxdsMphj+0s2OqxdeCHqrK8RO9h4
         sMeRLIHIAgtHLcKdlT0Au3CPM9DHOioRo8N0YlTDBweyglpv9P9CFBucXUu4zx8D1FMy
         /mTXB8Javx3ccfQr5dRHpy7etn4gF2BsJXg/312MDqGlFW85fA5dzttJ1d9Hc5+IZwYv
         5OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764167628; x=1764772428;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=inLw6P403PVCjdCrnZ3KiTkhwHLqP3SHDGypF/i5VfA=;
        b=QdOMzm79j8JpzAaOccU+bX5YM0WLzHLJP6L7bsuT9Ml1/K/21rEQNLvfEBDLCygSMv
         gFoJtv4bTA48mTaxTAtgUp7qBAlBZGVmbwo0e4bBTjvJkfKbAbIhBFbFXQQMWj+vrBzu
         DZ/uPMCuupWVNStBmVszUdiCT2PKve+V29liS4Q0vnKyZQ5Bq5SaFqLg3cPLqcvVjFpr
         aaX7dhPn/AlRhLT7qzLeE36gauvKVURNwXsCkgLp/Yhat1+B6nqJeGZOH0yWGvuqKm0w
         sKILzPtC2UTlzu2iZpDLiQdM9ojEFMgjPvwd/VoYAPdDx+ek4Hh0UVSL+/yBsM/bq9yB
         dcwQ==
X-Gm-Message-State: AOJu0Ywl4KGDcpN3aCOC1Pk/4bokwuDHdlUbdT/+90B4J576QV6fq+5e
	2EzFwSj+SmeybwJyLuecQLu9lubLNTWdsV09oZJgUEgfWscU8vl/4HI9Ody0bA==
X-Gm-Gg: ASbGnctir2eRuAOzC449m9N7r8tO9ouXvHjSKwo0TMmQZrwp42gljdPqW0x3FlMbBAj
	gpwLNU8lXCuPcr4m/nGDbnSLWPdT9GcXxxPnFnccoLd0ZuTrT9MB7W96CEyBXRX1D9ncPY5wb1s
	M9gEwGOI8I3mYqrGP6qQ7Af/3i4ZGUF6NRoFbVCTdxNM0qC+UAZp+LSaF8w+AX5SuNLDzemEUgp
	NkZ0j7RSs9Y7AnQ6NakUuEuDb5UFSWVSYDbyNZ9kAKO4M+xRXEFdriqYHxa+yDUvCojo12h6Obj
	xPrahJeD8+lWZSK3JN6Jyns3R9wTDpDrGjkj4erkRcSw4ZQvF6Y7nt+PrBoh1omEBurvXHHzDUW
	L1rkF7q9tUSPoJpnk/eDb+NHLBqqgBM2gEd2/mBVbT0SgQXrXE8nwFCyLHnaN628G2lXqj0IaP4
	T37cfTdqeIC56Dxg==
X-Google-Smtp-Source: AGHT+IEsGsvcatOnrADNMCejYnBXF5lLmSQmV6+9STFqx7yDy/9IrSPnZLjdvc6KBL296clclPyJ1g==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr11528615e9.3.1764167627684;
        Wed, 26 Nov 2025 06:33:47 -0800 (PST)
Received: from berwick ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm38671467f8f.8.2025.11.26.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:33:47 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] replay: do not copy "gpgsign-sha256" header
Date: Wed, 26 Nov 2025 14:33:37 +0000
Message-ID: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "git replay" replays a commit it copies the extended headers
across from the original commit. However, if the original commit
was signed, we do not want to copy the header associated with the
signature is it wont be valid for the new commit. The code already
knows to avoid coping the "gpgsig" header but does not know to avoid
copying the "gpgsig-sha256" header.  Add that header to the list of
exclusions to match what "git commit --amend" does.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
We should perhaps think about how we can centralize this list of
exclusions as we now have three copies of it in builtin/commit.c,
builtin/replay.c and sequencer.c.

This patch is based on maint to make it easier to backport.
Unfortunately that means it conflicts with ps/history which moves the
code that's changed here to a new file. I'm happy to rebase on on top
of that branch if we decide it is not worth backporting this.

Base-Commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-do-not-copy-gpgsig-sha256-header%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/9a2fb147f...4f04af579
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-do-not-copy-gpgsig-sha256-header/v1

 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc9..d12e4d54872 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -67,7 +67,7 @@ static struct commit *create_commit(struct repository *repo,
 	const char *message = repo_logmsg_reencode(repo, based_on,
 						   NULL, out_enc);
 	const char *orig_message = NULL;
-	const char *exclude_gpgsig[] = { "gpgsig", NULL };
+	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 
 	commit_list_insert(parent, &parents);
 	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
-- 
2.52.0.362.g884e03848a9


Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0133EAFF
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156416; cv=none; b=iw3YFIsZmnq4fEfAI8eIRPTFKtOhF62IRy4ZtDKC/OeuJ7QqetvkkI0VGS5rgqzQHVsNFYNf4n+ngQcr0zneWSHjjz/GobIFWhMf0+omogiRc3ozNAHF9KtDlOmI2mLv47UTI66qwqh5nWTtr5HJmfzJIB/Lr9NkZdIM9bvU4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156416; c=relaxed/simple;
	bh=k2XEVi8M2Rc6YmP9+H+RIFOMOGMb0o8owl36Iaj6QmY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BZUB+1H7B2ukFUmRdDrMDxF7sAtAYXYfcBEAm0YQTmaYuSDoB9181ihtFgNXD0Hhj1VP5y81dYsjHJdOme7b7EplXZXnwe8RdvsT5+MdxsR9G8OtPRMmBpEaAfiKjltmlMd9hE5ddYXNN3/zutaTRDFqaiCrY7m8qUPT/CTNer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdNp32G7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdNp32G7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f1b147eaa9so14206591cf.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156410; x=1766761210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6F2BgqE/CNqxSv+DMW8HPBnGZQ8GJiPdb4TjBtp0Og=;
        b=hdNp32G7mE+BzxDYugW2qTzAFzHcAs48+DJmx+YIHdWxhKJTuz1rglBsE58dYxEk5T
         uMfsSyVOm28YmXE5uSoty9tuXFx4pNA8212M6ieB2CBAPS87MNaz8at7aeP07iENpUq7
         4wRhs3pQWOV9fHNxTLivpfWwjHv74RCDTkmnwlMFQDXHullGxNOUdDaf/DqAdRLky7IA
         NcdWexnF/qSNGZhQRpKOzsgyafEorS4/K+JNtl1zehq7c0K70ALXZZF6XWIWCzBEwY78
         yRNAGTBUd26dwh0zVsrW0sjRE++np8l7gxp0x0BphfrVMNunReoysTfCwhxo3YUOpXlD
         lS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156410; x=1766761210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6F2BgqE/CNqxSv+DMW8HPBnGZQ8GJiPdb4TjBtp0Og=;
        b=pA9UcXSjtG0x3rtNDDVc7T3LRLgeI8wRnY2uNakZ6pdqWRFJpMdSMto3zI3kuTu9AE
         qVgVRTo21ds17VxSUvYRufu6frx/WNqfDXF7CuoQXOo5ye6TRPQ6PUWgd7h+ekUJT7ps
         0LbPNHGmws08EtH6SpkK5N9Zyce/9XYjMBmyZkZT7+SCGDgU4cXGCheQtrs6ij2Zv8Ag
         Z1Zd1v24NTxGOztcUP++15ACZ96BPDe/7OVS119APeveGutfndZCJDclX0MYddfoxcJx
         8WOfDEsRYkBJQJ86CBwoY7oX0fTMPE/3/mFNrfuLeJEhQcfLI5HYYjwbWEQGw9sohh/V
         FA0Q==
X-Gm-Message-State: AOJu0Yw8yRdsVI0XCyJcpySgzhCQgqb8nA29mlcF/5sP5J+//JaAAVdy
	EvpKdM1RwzUuOwlcrt/Ka0brGtrPc78lpxfiYCMt3F16ZwGWSUJQKhDsEQSxYQ==
X-Gm-Gg: AY/fxX6XehGvC8y+XQ3J+R+U/+LHQybAU55neaosBwitXRS7ovrIXeLgoQ8t+4Bm/Q4
	/cFISAJiHYdkvXr1qaqkIJwqdWx/Y3TWeP+ANpRwH0zi4qQhVv5+IChPjoP7k8dToXzcwAwNn8d
	INF/92l5VmQ31R82kmO3Qxk3cet0th7e87yD6h8eukWrzG9vSrjdsAEW8DxVhTsiqfMkpN3D433
	hrerJFgM6iOLnz+EJXmq2t0QOtkDpQHcZ/XlFVijrC5f1rVZbkIlQ+uw4ukw9DqKAQWWkSAd88U
	/xe+YL6eUTuRzqxA30jX2Z3KSj+NCubnSC4xtwygmxNkfHz6Wv+SKfGuSbkjDSlU7e8D3TYRIHI
	Uy+w387peOD5eaQuXKTIK2UzWAlqq9HR5zKZi8/bQ/F/NeA3BslZBupJ79caWDHIGaEIvcozX4h
	BWFEEjCO2GZyM1V3I=
X-Google-Smtp-Source: AGHT+IGuHG2ULT1oCkpK9wTV1fFRZTCK5LqZXy9RyRwz/bNQNQC1ZpcRpT6E1mQCsrDXUkiH1mNCPg==
X-Received: by 2002:ac8:5746:0:b0:4f1:df6f:6399 with SMTP id d75a77b69052e-4f4abcf6820mr43389771cf.14.1766156408532;
        Fri, 19 Dec 2025 07:00:08 -0800 (PST)
Received: from [127.0.0.1] ([172.208.126.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aed21sm24832456d6.30.2025.12.19.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:00:07 -0800 (PST)
Message-Id: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 15:00:07 +0000
Subject: [PATCH] worktree: clarify --expire applies to missing worktrees
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
Cc: Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

The `--expire` option for `git worktree list` and `git worktree prune`
only affects worktrees whose working directory path no longer exists.
The help text did not make this clear, and the documentation
inconsistently used "unused" for prune but "missing" for list.

This updates the help text and documentation to consistently describe
these as "missing worktrees".

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
    worktree: clarify --expire applies to missing worktrees

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2135%2Fsambostock%2Fexpire-missing-worktrees-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2135/sambostock/expire-missing-worktrees-v1
Pull-Request: https://github.com/git/git/pull/2135

 Documentation/git-worktree.adoc | 2 +-
 builtin/worktree.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index f272f79783..402d363064 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -271,7 +271,7 @@ mismatch, even if the links are correct.
 With `list`, output additional information about worktrees (see below).
 
 `--expire <time>`::
-	With `prune`, only expire unused worktrees older than _<time>_.
+	With `prune`, only expire missing worktrees older than _<time>_.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
 _<time>_.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..82fcbfeccf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char *prefix,
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("expire working trees older than <time>")),
+				N_("expire missing working trees older than <time>")),
 		OPT_END()
 	};
 
@@ -1070,7 +1070,7 @@ static int list(int ac, const char **av, const char *prefix,
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
 		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("add 'prunable' annotation to worktrees older than <time>")),
+				N_("add 'prunable' annotation to missing worktrees older than <time>")),
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("terminate records with a NUL character"), '\0'),
 		OPT_END()

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget

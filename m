Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABC72628
	for <git@vger.kernel.org>; Sat, 10 May 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914567; cv=none; b=c2EA/bTPSKyj54453Z0u3YS6oGX6H8x3tuaLsRSJUCpar1Jcztw/aIQIFKWb6OT+kvRNNOa3/rVQ6Z7iu7qzrcTIVbe25cBz2D4quj8+IXr3ZELpIJ69yEWGWyHBAwSvPxPS5im2O+Mk11oyyEbRS/LU253qfG4IH/uwlyuKOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914567; c=relaxed/simple;
	bh=anWjeK0fpQx4gaFGlt89W1i/LEZREagwYvsEBjoICmU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=A+pcziom2kamJ8M++dBsGZ9dzhBBTTmUTvY90CTs/5a7DCxwo0NNZh8aKE7kGjzD9sDXr8NuNoTWOLFm0GQ59WHUqAU49ND5Z+lwoAHMxNhs4iZXnMOVF2LQH2lnj7cMLDtDLGbJDqgfgOUvQd2siz4TyWrU+yj86W0cu4fGE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZacmP/V; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZacmP/V"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso962810f8f.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914563; x=1747519363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=akLIZJwYx92RdGoBkgsiciKvcX+R5w9GZJ/imUnVMow=;
        b=NZacmP/V2YvFoI+sP23TZkceicDn/6FJMQTCY38BUAqyS7GCljF7zzL1bqxgv6wuqO
         ANYdGFduiHItfFVzHtH6Y7/uL4cLIJl0AEq2tkRZigXcOevX67c3ObNpcWMv91t51BO+
         1dgCUfjHTSrnpJbhWBiS9rQYxfrB7x1pk9kazR2MQ3LntEH8QrPHXKBjKP63N9Qy6oqW
         6RXP9BdPP0Jk2T9GRJJelkiQ9G/sEZsEPNxSFos34hlMAPAdTvTil9xYDIvJBSFSVPaM
         s+LpD1sot4lz//CfhHIyqk7YVpxXemCOjOzgvyyHsQEkeuB9jii/NHYKSPejZMCmJ/Ym
         fDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914563; x=1747519363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akLIZJwYx92RdGoBkgsiciKvcX+R5w9GZJ/imUnVMow=;
        b=nEMx+za/kjjADhRDszxDQ/HeScgMlK1NBHf0ZgNx04mmDxKyt4Lo2Gka8H0ZLVzlzF
         RzzQiLWtL0X3KFTSsldC8QmOVvzBPEL9znEF5WCLuJMcRB6j0yqsNRFCnkPbi5n3t/fz
         idsfDqXStCXTQ8oKerMLe7KjToK5pFGI4M7+aPA/xVQGktfiprkmmRxngWkb/X6daVOe
         LOy2KwxDLtFnQIFJJailgU5T+cQFfrEweNRi0vaxDNn2r4CHQv9quPqqG4cgRXxGUOQQ
         jesR9q+alOjkfO1xQTaNLuT8ME/GRZk4pLXRp9Gk3opBwLiwreBjTwAqwcqVb5Ka5GXv
         7ytw==
X-Gm-Message-State: AOJu0YyM5kpHmc4HOpfqrqGs8B4d8/Ty8svvRoJMMko7p7AKSZrUHw0I
	dOav5Jnx04NKYk5PvnUxHgmEPVLp8Kgl3XOVBpMwLB2awZIXkX1njM65uQ==
X-Gm-Gg: ASbGncvUn8orexqT0huvOgzZRPJUZzpAwfbN8mwEFrsDhWqNFQwtPqs1YmhSF4w5QRW
	ZcCRmImQbe45CywYAaNLbB16RikVK9G6ftLjRZ/125MlO6CLsNf1UvRuT52esUC5BMYzZgDgS3v
	Xw6eQW8cGv7w+gR39jzfVm4rbAw3byR4rUkEX3/E8Le5HkklSjTeL8sdPkMUPiYeOaCSeQ1nT/x
	aAsSuUMaQITKgWFjm6u4TIEwXYM8unkd4ywy4Iywr7Ar6g7TAEkhqpcDJugPcSws2NHRa2K/Z+J
	a+RhnjjsbF8YjJA+DPsakI8cPkqNs8syVlGUocfy6Gd3h36ALxwC
X-Google-Smtp-Source: AGHT+IGEhd9aKWT2F/NIV5XxkoBgXmELoX2g6LCKrGcFvhGsUxrSPzuYZTXujYXklBJKPxC2nm2SwA==
X-Received: by 2002:a5d:5f4a:0:b0:39c:1f04:bb4a with SMTP id ffacd0b85a97d-3a1f64277e7mr6380514f8f.10.1746914562700;
        Sat, 10 May 2025 15:02:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4bbf0sm7413602f8f.82.2025.05.10.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:02:42 -0700 (PDT)
Message-Id: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 22:02:39 +0000
Subject: [PATCH 0/2] merge-tree: add new --mergeability-only option
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
Cc: Elijah Newren <newren@gmail.com>

This adds a new flag, --mergeability-only, to git merge-tree, which
suppresses all output and leaves only the exit status (reflecting successful
merge or conflict). This is useful for Git Forges in cases where they are
only interested in whether two branches can be merged, without needing the
actual merge result or conflict details.

The advantage of the flag is two fold:

 * The merge machinery can exit once it detects the first conflict, instead
   of continuing to compute merge result information
 * The merge machinery can avoid writing merged blobs and trees to the
   object store when in the outer layer of the merging process (more details
   in the first commit message).

Elijah Newren (2):
  merge-ort: add a new mergeability_only option
  merge-tree: add a new --mergeability-only flag

 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 22 ++++++++++++++++++
 merge-ort.c                       | 38 +++++++++++++++++++++++++------
 merge-ort.h                       |  1 +
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 7 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1920%2Fnewren%2Fmergeability-only-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1920/newren/mergeability-only-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1920
-- 
gitgitgadget

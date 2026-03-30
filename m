Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33ED262A6
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869513; cv=none; b=tpx0C89CVQXTXLmy5ek0tOy4teXeDp86JmSH+xj8X+zJmJ3mvaPtnUX6DR2x+zuhhdVMVV3ECO/pPMZYWp5fhFbTUNkmGuaSxjTtBXrUG4jkW/gz2CL2zKMhSjBPmTMQCk0d16xcm1JmF6j0ZQUalBHs9LWcN3lT6pzzIyKnACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869513; c=relaxed/simple;
	bh=mwhXYGVNJXC5XGMQYd+FUj2Iua4QT2AWP0l0llD87Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/StMabuQ46TZpGkbqf9qKSitrzdxCV/Ia6mEFFzIgUeECGKyKtkr49jlC9dWSYsQiRbtSsC8osxhrI5/u4onop7ib76320u6yup4l9uFIOvFpw8WiasWcJARginlVs4ItFKfSldfPY7bvMhFtAHcBs083A0OO1+V4FXe4dzzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRV7WgvL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRV7WgvL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b983bb07eso2158310f8f.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774869510; x=1775474310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/A6pXoxK1GaXFKY149WWSQHeHW0pBkwxb400qNsT+s=;
        b=DRV7WgvLjeizqc4IXRnJN041J9RsP3bLN8CkgZb69D93eYRExIGn3VSD6qVJMmPgpF
         7/vOsz1KAAdmB07JRYvWFqDXK5REfH86o/KSO7B+MY0gXaIcSZuLoxDUoKU8L7LU0Xd0
         TVOfsmTmeS/L38Qs3eE6m2XMk7uh1Ft0xBFxzkERaPylOzm68LA6v+SeCGgFOTMHO1+f
         aKBd9rKhhrwIO8vP0bf3wUQ2HeFj9WKZ6iVCXtFqk2Wqinw9Wf+0A4w82yvNx2Feyp2q
         Z10MXNPmWREdYXXcxIUWFTk12n/P+fbaZP4V43G1Pml7SJAa5+OYy0ZKGbvQ4okq9trM
         i2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869510; x=1775474310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/A6pXoxK1GaXFKY149WWSQHeHW0pBkwxb400qNsT+s=;
        b=MKs+ifLWJxYhLbDJteQoz3kildouGUkK64ev137b7JvyuL/otF6CwzcXcFPDMT/y5u
         yCZlEcl58cnu28M65R4e9dFVq4uCue6E9KUqLrche02M1gQATYDS8816Blw4wAY6h2F8
         Sh6c3FyWincBgN6l2efwPkMrx+rADF0wuMuTIkptNgE+NZdWsRXMF0SubTuG8yP/0DRt
         iXDbOCk0/KTriz6eTpysV3mRwDoNndXZPX3zes+TbCAQ98C/K2gNDjax2mqxO6gJ4EF2
         r16IFcUK8DASyzDmRty0Wf6kxKnbRdM1wYJSi0g8hFCeHKXe7sVFXvYHVNUBoIQ/TaoR
         Mqww==
X-Gm-Message-State: AOJu0Yzqxa8NIu7adUqktcyrszpFtkcay2mVwQBOhVcncdp3r7oNTbJV
	oyHJTAaDH4QtiwMg+Gwa6ckt3HfRXHfwd+4ovZF/WtzQ4wHt1DQGkpoZC9E5Gsv1tW0=
X-Gm-Gg: ATEYQzztC0Ko4s3G5kjQEGa5JTA6F7UYJ6FyUNzp4I/6wHT7Y3QbH8KsxYv7lbxTG8i
	PHcfrn8LG/cNZFCI6KHwhY8dpdrLjndOR9A9s53HdjuqZHryf19wnJawwpbWunpivIadugqQ1qz
	UJ7Ls98U+Nn6EVfsynG3KlbNMdWtHj1sdzg3EUbuFqpRdwvNMZCXyfqaz3UTMoMs5EKMDjUDo77
	j1M5Cr1dL+yB39BYJHzgYkP2STkOrGFskiNcZchZEvB/Hqj+ygn7IqTMjLeOGfvj0CI3gq962Y5
	WzZUCvRc3fCdi3BwQnA1jcDa7kg5t0Xif+XaHMZguPPRuFvEuvdROmZ42PxsCNccZPhpj6w1BaT
	z0hQ968ByJINUeGiif8Etc9t1sIkPGC/JaY+dNg1y15I6eX1j+vzLc2lJ5mPG2lkbjyLLzjwfD7
	U5+6U3ChRlG8rspW9Vh0rvyMiMPLU9nFp7Wc9ONkaJzc5uoQD3n3jBKuai+UFpuYg3lgTpROL6y
	O5L8uR13Q7fw+yzEjf1bU+t1AhRlAvgNVUFLa2YWnGG2HjoWc4EptrO8e53r18CPLprKA==
X-Received: by 2002:a05:6000:4203:b0:43b:62fa:e3f0 with SMTP id ffacd0b85a97d-43b9ea766e9mr20013000f8f.48.1774869509796;
        Mon, 30 Mar 2026 04:18:29 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm19140821f8f.11.2026.03.30.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:18:29 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: me@runxiyu.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH 0/3] receive-pack: fix HEAD check for updateInstead
Date: Mon, 30 Mar 2026 13:18:19 +0200
Message-ID: <20260330111822.165188-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223141236.22476-1-me@runxiyu.org>
References: <20260223141236.22476-1-me@runxiyu.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bare repo has linked worktrees, and its HEAD points to an unborn branch,
pushing to a wt branch with updateInstead fails and rejects the push, even if
the wt is clean.

This happens because HEAD is checked only for the bare repo context, instead
of the wt.

This series includes Runxi's test, a cleanup of a test that messes with Runxi's
test and the fix for the issue.

Pablo Sabater (2):
  t5516: clean up cloned and new-wt in denyCurrentBranch and worktrees
    test
  receive-pack: use worktree HEAD for updateInstead

Runxi Yu (1):
  t5516: test updateInstead with worktree and unborn bare HEAD

 builtin/receive-pack.c | 39 +++++++++++++++------------------------
 t/t5516-fetch-push.sh  | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
2.43.0


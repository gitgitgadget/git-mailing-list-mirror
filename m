Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28036680E
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775333; cv=none; b=ZkOv5/fIlQOZsgjtI9Yps89QPnmtOKQlzsR0HlgCSrlUjlifxpdAlW6nYoALnvkgZUK72ObEEoZElFjw8rQ0klvPzNK3oRLmRCe36tI4e0EGj+qmQfEBHay9HcHA7ZxvFyHuaLeBMg0vczkWvw7ixsVrinpc9Qx/2RDsoMQFOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775333; c=relaxed/simple;
	bh=3Hlgd8uMV0Agal/5OW0q2ue7DwCCXv2/KHZe35CJSx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GhvnJdUBSKuSQlu0bXGFXEtqifUByHS8Nzr1F9Y31ndUffu5aFUwxFS4F0GLkzeTUsiZSPO9eT/kd/RYAtO3yFRtfiBV59DgJ/QT+JPiZKNIU4MP8zyozrVEBjgkJ8mBSby8bvfUHXaTZLd1O/To8LisrBu6BXRm3hp+qXDExmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC351RFq; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC351RFq"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c726f46baso4957698c88.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775330; x=1777380130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=NC351RFqjGI5EsZfVNQmtLv/lxCoix5mRUWWt0gBaireUBjdiFu1tJ3VUpWVvRRX4K
         wpe1VuXCl5sOIzV4X9YPC2n3VIw3HI/0aPQd2dOnpBRhJcgDCIa6bCh1N/jnzhuj2i/t
         3CoqMsz+coHXBKEI6+UkO8d9d2kfbIJURWPu4YwuTb5xE7QGAITir0cFtwBmnM9lY4Vs
         KqMyFX/OcdFYE/e3Y3nroOX+Oo9gf51zLamd3+lcDxzQd3VbbIcRy7n/wvL+9XYqCUaV
         AVTXVzqTibzF7uhyoCNRPSFIFMkPHWxNGAxeUWFwE3WTEvnIWlL5j1olrp9nOnEf9G8I
         yDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775330; x=1777380130;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=To6Z10YB3aEn7wLUk1RVWuha5OwqXSsxeu+A6ufTyy8QlFn1t2RJx1CEAeBP8/dtCu
         DDlhI148TdPAH9KC+yoQCTPYhRtFe9tUrbbMXdNMejCkDtMCSTgOBXgGHrUgCCEr8TbE
         u6XupcfiZYzEbcgGBftb7ISMVNOrYP5sGxkIl9tDdVTS80v/7FdKil+w6os7HU3C46f9
         UC45RCwX9UeuGd/Slryd3Cj14bq2JopepbP2hevrnV2qbKhyzO/Hfd7wvRlpwKA4Oduc
         0Oz+ZEETnwx4l5R1BpT7rwPr/cxDwqriPH6xZsn0gCxEH7hBGxdwTEEHrPGH6jVw9Jtr
         xs0g==
X-Gm-Message-State: AOJu0YxZLmc10/Vc4DofSTDMzDNylWSwlXoYPLRJWJZo+YlwssAdCSbJ
	xqRmG8gxdbpwSmQJD/V6BxqAR7FYX2HgCCkfGfVXpTDGnknCjY1EjkYacP895g==
X-Gm-Gg: AeBDiesuRIvbyDpEVx44j+dyGB5Tjrg7/cB2zQv6Kcmu1D/Q5L6JkAyMIPKuDLKGTiv
	8uU0v9HEZLCvGNtMUuo84jMO0N0CHGVTaylqG1BIAPqH78wRWkA7P2HzLrAWzCXh3R2jgWzOjk5
	iBvd4+30DqF+nnpJtf8t+ptgIcp6dpYxVn6+iuJgy0hhsoigyivA6cdKkvPpM4mQOKmBuTLAm5S
	Nhkb7NkNXPK1jEBn7HF0HdEUJ9j2DTLBkeL5Eb5gfJT3TELdAWwf4h36BrBSUdk6g07aotus8Si
	6684X2Vt0ZOlkeLYLqcEDAYRr4tPbxF6eMM454Qo6GR3VN8f9ohT5zaflh39XkD928O/fCZ2LHH
	KdJ/2GNQ1zjbss8kLk4TT4eCrPoqKaMymUrbos+zYYRUdi/2FLivJU1zFoItHXI1BdlwjQ82Veu
	Ks+2nPbLctmW+WEeLEBkJjHT8mrqX0NuyYOGA=
X-Received: by 2002:a05:7022:6606:b0:128:cc34:35fc with SMTP id a92af1059eb24-12c73f90c0amr8926006c88.16.1776775330062;
        Tue, 21 Apr 2026 05:42:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm23872845c88.14.2026.04.21.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:42:07 -0700 (PDT)
Message-Id: <bfbe0db67f5a0454378bd5fd71e2cbc1493bcb59.1776775319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 12:41:58 +0000
Subject: [PATCH 3/4] ci: bump actions/github-script from v8 to v9
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The only use we have of `actions/github-script` is the "skip if the
commit or tree was already tested" step in `main.yml`, which checks
whether an identical tree-SHA was already built successfully. It
currently pins v8; v9 is the latest release.

What v9 changes:

- The `ACTIONS_ORCHESTRATION_ID` environment variable is now
  appended to the HTTP user-agent string. This is transparent to
  our script.
- A new injected `getOctokit` factory lets scripts create
  additional authenticated clients in the same step without
  importing `@actions/github`. We do not use it.
- Two breaking changes affect scripts that either call
  `require('@actions/github')` (fails at runtime, because
  `@actions/github` v9 is now ESM-only) or that shadow the
  implicit `getOctokit` parameter via `const`/`let` (syntax
  error). Our script does neither -- it only uses the pre-supplied
  `github` REST client and `core` helpers -- so the upgrade is
  safe.

Risk analysis: the step is advisory. It sets `enabled=' but skip'`
as an optimization to avoid re-running CI on a tree that was already
tested successfully. Even if the v9 upgrade broke the script, the
surrounding `try { ... } catch (e) { core.warning(e); }` block would
degrade it to a warning and CI would still run normally. In practice
the script continues to work identically on v9.

See also:

- Release notes: https://github.com/actions/github-script/releases
- Compare: https://github.com/actions/github-script/compare/v8...v9

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index da31b10c79..6d7f26e71e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,7 +63,7 @@ jobs:
           echo "skip_concurrent=$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v8
+        uses: actions/github-script@v9
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
-- 
gitgitgadget


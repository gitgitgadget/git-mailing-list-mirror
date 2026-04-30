Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E23D6CC8
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534517; cv=none; b=QLx+gsjJL4NPlxh7x3lFmN4L8ceaR7+MA/kdauyvXiHPRWvQCx5wXHTt67RBqVN2yXAanL4TF/0WiNbK5Tl3s1GbBlH9vtYf97H6Ln6R663sji0FGwLmKUp75Zzaz4AgH4AtGCY88HarQC61yBJ+Ndxro+pDDpu5K2DhNz+Bgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534517; c=relaxed/simple;
	bh=Q9/t58UVjf6EE6wKAvsUBnbNjqgQKdA5KDuhQTqzWsA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ohOdVdgz6bitjSLZreGp9tI4g+/DN0gW0QCrhcPbaxGWoX/XLoMlaDnFzSMGmClYdqgfaOOOkJ5B5q0vOtn/WGbXNhf0sza+wQlgJsHhEgZUSasNF40TyDxUsrrxqF5dq3wrFqc/pZZ9Lke/5Uf83WvPahay/xGxKCkdn1pGjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9dG43qA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9dG43qA"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d7c12e48eso4879031cf.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534502; x=1778139302; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuLeetRgO4hfTkyv3pt+e+P+LRvhMUUVHUfVL/BbyV0=;
        b=b9dG43qAzMaR08b+17QjmRoWepnTAMqmKASLPGKnvIsP/72KSzcb/KVZ3skcQ86JUM
         a02+jMheGLPGLWKOD8UnhcNHgSUYDC/GqjUBGJ1+GZvibxo8IYr49D9mHTCCqNE+PsEY
         PF/H1ZLbs9pUOv651+gakDW1Q/9ysDk67+POhN/Yr0WlhwDLv/q4ESxta5RpiP7CZQXy
         HxhEbjPTyVWueyvy6pUlZ9lTwv5910eFGHX7Dr2760q9/vw6YbgDmECGiXwckuj+EUY/
         aL8g3/+o3AzKTqy+DREzcqcf7VM3hfWwNtp2f6RVotpjHtHymlbyWch2lxBBJ+nsFhDs
         wwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534502; x=1778139302;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OuLeetRgO4hfTkyv3pt+e+P+LRvhMUUVHUfVL/BbyV0=;
        b=M+g1noC8grck/nhGJfvHNJ6weRbWHRkzTCJoH6+JkWOaYcPkl1oc8RdkvLZjGmmBqN
         dT5QHoGCYMmNbrkXOK6KnMxtXdFqewK4Pqqm1qCCvNF5DXN1HKtEZrtrjeqshNQjDWmE
         WsbTycHeaq/nkuOMIWifrNQZ7R0a+lO+woJu1j84FW+JCJm9J6mIBDCFH71wygvu9SFa
         f0dlvwWaM23HJBJz8xk8fmz5bFk2O0JFRUFHT1VO4xIAPXXsYvWm6lc5MiYHw1KYfNVP
         I7FqFXxBEMhreW33UAKfYhK9WEiWt+sTqH2AooAeAYhdXikdqP/gsRuRb/MjrK76iugf
         UxYg==
X-Gm-Message-State: AOJu0YxDwYLZv3zZsschb132ZL6hXlN7rJZ3iV8fVKijtFlf/9ctS+aC
	5UX/1tBzw3qEfMhHMOJAPg9bOOrkyfbIjuAsTeCUOBxMSrIscRLA/wokfm9N2Q==
X-Gm-Gg: AeBDieunFLCKKlS+vyDtsUmyN75kyrNjlh7AWIlSjss6L7fsLsUFIr/1dEt1JeYIAsX
	TVjBGG39tICy/wA4PznP1d25JE+pnVnBh4wxhWcadY5nHSQ77jEJsY7jS8hFBMhbVcBX0aYe1oM
	pXPZL6s4+EHmrfXiVVVXRREQBxCh1IcCaJ7gfuZW8QbXRb3C03E4usMvfFTMIhGOqEQQDF769+M
	S6GHfLk0BYSW9az2VejetmOVoc1LCGuzqmG95G0qRc7HQVxcow1FPjhT7OLn4QfRw/PljLWb98T
	OBgLlDwJ+9QFHg7ZHMxJ/uJmIhqklhl5jrB4zI8EsQT85v2wfk1iHG7Wou4Cm+Xt56paQtVQZCj
	QuBEwI+o1CmU+1CofKgkbGULWmHKF+rhSnvnCHV2cuP2zuW24uPuUSl0MSBjGkdlIVimKXIyeRV
	8UR+3k53bWZrcNPhsUe+rm/hRfp70Xs+RwOjh9
X-Received: by 2002:a05:622a:8b:b0:50d:a8bd:dc07 with SMTP id d75a77b69052e-5102d218429mr14646821cf.35.1777534502557;
        Thu, 30 Apr 2026 00:35:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae64bffsm42745561cf.20.2026.04.30.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:01 -0700 (PDT)
Message-Id: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:54 +0000
Subject: [PATCH v3 0/6] ci: GitHub Actions updates (brought to you by Dependabot)
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
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Dependabot (which my voice-typing software frequently mis-translates to "the
panda bot" 😉) is enabled in Git for Windows' fork of the git/git repository
to lighten the maintenance burden a little bit. Frequently, the updates are
not actually for Git for Windows' patches on top of git/git, but apply
directly to git/git.

Here is the latest batch of those updates, with heavily augmented commit
messages.

Changes since v2:

 * Included the version bump for the freshly-updated
   setup-git-for-windows-sdk GitHub Action (which now also requires Node.JS
   24, at long last).

Changes since v1:

 * Also bump mshick/add-pr-comment to the newest major version.

Johannes Schindelin (6):
  ci: bump microsoft/setup-msbuild from v2 to v3
  ci: bump actions/{upload,download}-artifact to v7 and v8
  ci: bump actions/github-script from v8 to v9
  ci: bump actions/checkout from v5 to v6
  ci: bump git-for-windows/setup-git-for-windows-sdk from v1 to v2
  l10n: bump mshick/add-pr-comment from v2 to v3

 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  4 +-
 .github/workflows/l10n.yml             |  2 +-
 .github/workflows/main.yml             | 58 +++++++++++++-------------
 5 files changed, 34 insertions(+), 34 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2097%2Fdscho%2Fdependabot-updates-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2097/dscho/dependabot-updates-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2097

Range-diff vs v2:

 1:  0d2fdc1cf4 = 1:  0d2fdc1cf4 ci: bump microsoft/setup-msbuild from v2 to v3
 2:  5d719b3729 = 2:  5d719b3729 ci: bump actions/{upload,download}-artifact to v7 and v8
 3:  bfbe0db67f = 3:  bfbe0db67f ci: bump actions/github-script from v8 to v9
 4:  5694ca1016 = 4:  5694ca1016 ci: bump actions/checkout from v5 to v6
 -:  ---------- > 5:  c6e8df1eff ci: bump git-for-windows/setup-git-for-windows-sdk from v1 to v2
 5:  faa83723f4 = 6:  b9ccb66405 l10n: bump mshick/add-pr-comment from v2 to v3

-- 
gitgitgadget

Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DD391517
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114725; cv=none; b=s3E+OGPBjoYODNqOptl9iAFSLwxwQZJNY0E8th7UD1Q89GzOmiAQ2HzAcb5lzxzrdOZcwve/xvpkYBeK62VabIpX0fn83u3yjf3UTsze5ZTXrUhuV5Qp3sS3J0+i/yd7aDaafkmBOXr3+KLYMqckXqWUweNsXvxcVOcSsApxMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114725; c=relaxed/simple;
	bh=jvsPNDskm13OPTJn9lIZ1eE4LBwQtA+Mli8pMCK+oG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SSlX8VFxnh/57RHm2cIXAu639TosI0pBjdR9qDCNxeTtKkRc7i+s5ruloG58158cQ2DXzm6UEl7zaz2qnkvabGBW/uzT3sutXMy2KKPxHHQrmuXESNof3OmpdtX6Hee3rKiSCKNYIsaYVRmojSIZqRQ+DJp7yLil8q5AHUvoLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8GQEYE2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8GQEYE2"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso430857685a.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114722; x=1777719522; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fNqPHgy4lMUebseT298lP6ZYbq/Pvzz1kVtnLDv0uA=;
        b=d8GQEYE2Ela1acCJCEbZUTvSs2HsdHct5r6LFgFbR41h/MFATapFZ0cu4MThzCms6S
         bxQQbtfRYIU523WfCJqTC6poJxK5moS0JQwcycKAj7cr+2Qfv7Q9JomIiH/DrLZL8v0N
         uE7n322pNw30FqNEgQG1saarhmR/N8eQlbSqSnEsyjb7hUmv34qjWG5eYGNTc/mA/h27
         D3CjyEaLLi3qekt2fNYYDglE0b+oMEG40LiCF7+xaQAuEEwYX2FFjBsTh+3qy8jgVpE7
         RDaMRS9joT8xfMuOj+SM6TX4Kk8PoKExRCe40opq97qoD15LuDGze/d4xP41j/tn3UT+
         3utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114722; x=1777719522;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fNqPHgy4lMUebseT298lP6ZYbq/Pvzz1kVtnLDv0uA=;
        b=KPFCs1DyS4Xpdm1fOvQnWUbcz/WA3Xl6Vek9RD/2EdnKGw9gxmKjzHwitky2LGrRP5
         dJEqJHOhyqssNeh8ohCA41VLVvFsS7pRcR6h3v6FhtCfTL7WsLbTvah7NsKuWSGCOSy5
         d/kcJ9msHr1rNJdLvaBVjrY799bA5CY/Jp77BfE37ylhzcGxVODe+3O2DMjEPg+TXUaZ
         ZBLmoQN+2sYXnCA+DrfqHZFNE/U6dLal06cgnuEfxSIHCx4PJ5nOG91zE50uaSMDfixa
         VRQaZnP6hqNhaBTFUn8miwygf2oLW3305Ze9Xk0C4kdlSFOlkyDuce+Uqpv2+h6pY1S7
         u4rg==
X-Gm-Message-State: AOJu0Yxp0cEMclEmj9Y4zhdPaOufwCZGmXMuJtRx+UOfwB+JLdmFFiBm
	6XQaV3+dOLZgowV2DccigHeREsZl+iZTVtIdJjysetshB85i26ShCk3Fh/MbXw==
X-Gm-Gg: AeBDietRKTXDHfAUHMPBhH1MlM8t31zhqRHwvKgxu2uouzW4hgW0N9/dKGv8tmerqJq
	zRTlHgQs0FejNaiciQbcR1hyFUY4FkGp5ujOzWIA8Hb8ziBlAloFqCDDA+o3LGfzkr6v/fIs6+S
	uaAQzFAy+GF/3dwlft9IiovzdKvht8tNdXEHZcDq4i3POpUNhs+jj4+oy3VybnXhh+oj3zHJNe/
	kximXSUcPtzl+/LgvTFfgFWxSq4t9T5rtFVtSqHZzp12vo2p/0VTYbfgglzAzSrCa+h/CDXqg6V
	ZBsAeUpD3NRtYVIzYhPI867yRUqnorwVQV6kzBAOAgwsEZhCTOVhCl2zngN79O1zaig38xP1RJ3
	MoB7uU47RxOcWw16ObiuLKBuyl6AjCMcAP1B1vKODx+t4KgcZWGQ1NfM8/Hja01Th3Alo58O+2f
	8EzijKRMbzAew0tGyyn0o/T6z/5s0sr4sui0tU0Q==
X-Received: by 2002:a05:620a:4086:b0:8ea:bcc2:4519 with SMTP id af79cd13be357-8eabcc24b5bmr3971192485a.61.1777114722180;
        Sat, 25 Apr 2026 03:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm2145512485a.13.2026.04.25.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:41 -0700 (PDT)
Message-Id: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:35 +0000
Subject: [PATCH v2 0/5] ci: GitHub Actions updates (brought to you by Dependabot)
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

Changes since v1:

 * Also bump mshick/add-pr-comment to the newest major version.

Johannes Schindelin (5):
  ci: bump microsoft/setup-msbuild from v2 to v3
  ci: bump actions/{upload,download}-artifact to v7 and v8
  ci: bump actions/github-script from v8 to v9
  ci: bump actions/checkout from v5 to v6
  l10n: bump mshick/add-pr-comment from v2 to v3

 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/l10n.yml             |  2 +-
 .github/workflows/main.yml             | 50 +++++++++++++-------------
 5 files changed, 29 insertions(+), 29 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2097%2Fdscho%2Fdependabot-updates-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2097/dscho/dependabot-updates-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2097

Range-diff vs v1:

 1:  0d2fdc1cf4 = 1:  0d2fdc1cf4 ci: bump microsoft/setup-msbuild from v2 to v3
 2:  5d719b3729 = 2:  5d719b3729 ci: bump actions/{upload,download}-artifact to v7 and v8
 3:  bfbe0db67f = 3:  bfbe0db67f ci: bump actions/github-script from v8 to v9
 4:  5694ca1016 = 4:  5694ca1016 ci: bump actions/checkout from v5 to v6
 -:  ---------- > 5:  faa83723f4 l10n: bump mshick/add-pr-comment from v2 to v3

-- 
gitgitgadget

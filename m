Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE42F0664
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029254; cv=none; b=NokmNFL7AVKtdD4/rA5bRaFTbr1ttXXyb4pzaI2DqHgENldxCLRWvJhkAaK+1or4BimskR/Y7tgyGgtimEK08OsWAsZqUUsrAG+UU3LCx2Xoi5P2VBBeDjAc4dA4bUJ7aUd5FjTBmy5JBtL4w+zDSfu2pn9NY8qJGq0ygAnMcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029254; c=relaxed/simple;
	bh=Ejme0INTa7lfb+wmeCRR4ph4BYLp4cW9bi9nzfe2r5Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nO4DI/o0P1Lq/hBwYw11NBAmV0G/UsMIMDxSwi8nwNCcQ0S/1QdsAhzEtQpw8nWgo3ZQ4Y7uZc9PphPrwPCt6RJBjRG2eJTGZAFHy99wsBObEgMRyY7yNwC5HMa0i/cph3u19X7AoUlDLO4jrKs5zNKSwVsoDTqeLFnPcY5uDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llcqTitz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llcqTitz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so53969005e9.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029251; x=1755634051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6O2Uii/MC6Q3ttDPz5TQs7QHyw8CjBynl3rRIqU31to=;
        b=llcqTitzm99bsN6QeyAvCSXnf9Wtp6jxARfaqG0LS5ZH633WxXd1FdlbU+OAxv3HNC
         IwbArGHT7r1coGPKeygrApAB0C0ofKhjijTCIlYIU/exnfl9wtNatHw/efiar03yn4Wm
         wWsCi0ocnGY/RMITZd91iYrg1adI/VFHS+TzCqtXaup5bSLyCj+X82LeAS8kLSK4vyBS
         VHyvVxhhSIzsqb1Xhm5goVBicFxF9/++HMVnKy6yUtsfsUVg/iLlaEiRL+p0q38ws4p4
         nHD24s3bezCeh0n3WNBjQDTOFjZ7BY0IRenYw+WlS+3ZunYHrINJjQyAieYDNqM8VTi9
         24Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029251; x=1755634051;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6O2Uii/MC6Q3ttDPz5TQs7QHyw8CjBynl3rRIqU31to=;
        b=aHqFxsMbeBWiWBkWNYBKuNq4grVBHDRGR6fUici6RwBrxtJMm27eJh52WLFYb0kic+
         /UB9F2NEmgwd4Zb6V6hnrjr79gzOx6CDcCKE9yWEik9H5Os13nHmn59TUhX2U1Fqg5qI
         kobeBTIHEDlif9qZkTqtqjvF9OJB0HXId6glZUmqQzSa3FT3yLJZRUril3lmSV0NfaA+
         xP/GOW+aK07pkEDtK8US4MDe21mStryvu1yWYcn+GKdvos6tgBXkAjdKsWJqjjrFO3vu
         C1oVvTisiCW+vXv7UTGEmWcbM6PWgJ+b9o1xdQPylPBgoY0knccjG5xYS4jKi2fxh/rZ
         YD+A==
X-Gm-Message-State: AOJu0YyWZoWPljHruwW9kKZ3hspR7GTpiKQYRMc95l+X9bbMxBlZWplt
	6SXbIyUi4+LcttH2Coz0gXF1ksn1PUVex5Ro1u7+CSM9R1OGUv3MR9C2MJpz1w==
X-Gm-Gg: ASbGnctB2X7LYOv2OpTtPdm+++4bLGPlFU8JKHRpiiwfELMbv5tJlZGUv0VF9NKc9/0
	szhPw34GaImfLNctGeQCHoGKbUcPfMJqniQO+NKxjB2ZUKSsMY7Rb4dpE+7GVT6VAhTDHjB2eVO
	mQ/5is03TJKD6oyA/aT4sMiGIN5WZoqvcXNxpTw86TLUqvKk8B5pgDZueG1leJmtmhmV0k1jmXz
	kdaJMeboixWtl1dR5/PnG3C6cyEIsGX929N1B12cz25jhqfEV5kkd7QnzA7mmtYp4mFxbPn5yZj
	lNCBFSwaKxMZLpcdt+XrO03HZBSX7zB90cMoE2FmXZgKs3TJZX0roL6MFEo/RvSCBOzT8Y7ZjR6
	PQvjeSxPFbO5xuF5ZzduRIc0=
X-Google-Smtp-Source: AGHT+IHE6qmWgxrJ4u0rTp9KacjyOapfVMoeyknIFvsFxwPtAtwKVdVkxaP3WD1Oaap94o1r1QNDtA==
X-Received: by 2002:a05:600c:a03:b0:458:bdd1:b7ef with SMTP id 5b1f17b1804b1-45a165fb20emr3407425e9.19.1755029250440;
        Tue, 12 Aug 2025 13:07:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16de5f27sm359165e9.13.2025.08.12.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:30 -0700 (PDT)
Message-Id: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:24 +0000
Subject: [PATCH 0/5] doc: git-add: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

This patch series aims to make the git add man page more accessible to Git
users who are less familiar with git jargon like "working tree" or "index"
while communicating the same information for advanced users.

Some notes:

 1. I'm not sure about the SYNOPSIS changes, it seems useful to have a
    reminder near the top of what some commonly used options are, like
    [--patch | -p] but also I find listing all of the options at the
    beginning really distracts me from the command's core syntax.
 2. I know there's a longstanding discussion about the use of the terms
    "index", "cache" and "staging area". I've tried to address that as best
    as I could.

Julia Evans (5):
  doc: git-add: remove options from SYNOPSIS
  doc: git-add: start man page with an example
  doc: git-add: simplify discussion of ignored files
  doc: git-add: make explanation less dry
  doc: git-add: explain inconsistent terminology

 Documentation/git-add.adoc | 72 +++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 36 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1952%2Fjvns%2Fclarify-add-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1952/jvns/clarify-add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1952
-- 
gitgitgadget

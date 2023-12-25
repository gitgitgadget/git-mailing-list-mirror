Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C953E08
	for <git@vger.kernel.org>; Mon, 25 Dec 2023 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4tSgDHi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d2376db79so39421945e9.0
        for <git@vger.kernel.org>; Mon, 25 Dec 2023 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703539290; x=1704144090; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FAsF9MJ9skmo0nPiiqrkJC6pPLLeMSlp1c4eqJeHdU0=;
        b=B4tSgDHiXVyYnO3PLlcZfgZsT3bZS3df7HcNbOnmJSB3XM0CmpzYZj0o8i/terGvoL
         SG76XIQaqHlubNpe3niwvP60KoTDBLmw7mlQ1C68S3CrjwBUihg+HnaGvEou/9v+zZZo
         P/20Yn8wsH3T/thgjTWilW6uRWQEjkpBJD+S2MlpMRPdEa9K0Hu4jJMrr8UZar6acPCp
         y/1Vzvr/qwXqN2YSEfR3Z0OYNl0qwdgiti/dvUafmjAeRC8JaZhFt3SrL4HCms+QJtZK
         FECrrD3EUNWiBgdWX/hht67nM0Ye8OZFRg4QwL5CMjs/jWgv1hdlOYf2hXZaxAwxOvZ3
         l33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703539290; x=1704144090;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAsF9MJ9skmo0nPiiqrkJC6pPLLeMSlp1c4eqJeHdU0=;
        b=aUYauxiy+5hLigQjXeDsWyR/htwJCMyAnaX5pgBwKq4jQrx2xYHEffTaX/K3mCAh3v
         XYbwKjAAd/s7omRprxHgArMZu0NJULgba8Lh3gyKHHeXtUWqbYV9+1/SkRkcMvLCxxud
         07b37tsPDogYkzD2K61ysgWMXkxwIXOZf9/XG8+y1KX9PjcnrV/63hIK5nfvnSajL5tn
         tj0jEdSoPuEG2JJpU+JSbsNnaFPkHg/VMQNR1sIktFh4UxHqGzY5B1Su3StHFljXyGR+
         hWdw4+1kb7Wx/OUuAz/+PrcJ4w6Ng5HffEwDzQbJm3blQc83aAwZ9tzzvpUyQ8UsmpSg
         hyKg==
X-Gm-Message-State: AOJu0Yw8j2jL7q7vg2iAzEGyipZdkb/YKVRpSQRJqSw2e1gSTUMF1WWK
	EQxtwBk3TwKpYCPwLyD+VAfrVNQ7C5A=
X-Google-Smtp-Source: AGHT+IHHMtpPFA0CWmQPA6yVY+oJQ9LuT3yjxydVmO5x9B8o1AERT4IrKuu3a1Ch50sdjMf6LY/UKw==
X-Received: by 2002:a05:600c:548d:b0:40c:2822:958f with SMTP id iv13-20020a05600c548d00b0040c2822958fmr3700517wmb.73.1703539289594;
        Mon, 25 Dec 2023 13:21:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0040b4c59f133sm18467973wms.1.2023.12.25.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 13:21:29 -0800 (PST)
Message-ID: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Dec 2023 21:21:25 +0000
Subject: [PATCH 0/2] Fix doc placeholders
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

While setting up a check of (the absence of) translations of commands,
options and environment variable in the manpages in the manpage translation
project, some false positives appeared.

Here is a series that enforces the formatting rules for placeholders in
documentation and help.

Jean-Noël Avila (2):
  doc: enforce dashes in placeholders
  doc: enforce placeholders in documentation

 Documentation/diff-options.txt             |  2 +-
 Documentation/git-blame.txt                |  2 +-
 Documentation/git-bugreport.txt            |  4 ++--
 Documentation/git-commit-graph.txt         |  2 +-
 Documentation/git-config.txt               |  8 ++++----
 Documentation/git-cvsserver.txt            |  4 ++--
 Documentation/git-daemon.txt               | 10 +++++-----
 Documentation/git-diagnose.txt             |  2 +-
 Documentation/git-difftool.txt             |  2 +-
 Documentation/git-fast-import.txt          |  4 ++--
 Documentation/git-fetch.txt                |  4 ++--
 Documentation/git-filter-branch.txt        |  6 +++---
 Documentation/git-format-patch.txt         | 20 ++++++++++----------
 Documentation/git-mv.txt                   |  2 +-
 Documentation/git-notes.txt                |  2 +-
 Documentation/git-replace.txt              |  6 +++---
 Documentation/git-revert.txt               |  4 ++--
 Documentation/git-send-email.txt           |  2 +-
 Documentation/git-status.txt               |  4 ++--
 Documentation/git-submodule.txt            |  4 ++--
 Documentation/git-svn.txt                  | 18 +++++++++---------
 Documentation/git-tag.txt                  |  2 +-
 Documentation/git.txt                      |  4 ++--
 Documentation/gitdiffcore.txt              |  8 ++++----
 Documentation/gitformat-index.txt          |  4 ++--
 Documentation/githooks.txt                 |  8 ++++----
 Documentation/gitk.txt                     |  4 ++--
 Documentation/gitprotocol-capabilities.txt |  2 +-
 Documentation/gitprotocol-http.txt         | 14 +++++++-------
 Documentation/gitprotocol-v2.txt           |  8 ++++----
 Documentation/gitsubmodules.txt            |  4 ++--
 Documentation/gitweb.conf.txt              | 10 +++++-----
 Documentation/gitweb.txt                   |  2 +-
 Documentation/trace2-target-values.txt     |  2 +-
 Documentation/urls.txt                     |  8 ++++----
 Documentation/user-manual.txt              |  4 ++--
 builtin/commit-graph.c                     |  2 +-
 37 files changed, 99 insertions(+), 99 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1626%2Fjnavila%2Ffix_doc_placeholders-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1626/jnavila/fix_doc_placeholders-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1626
-- 
gitgitgadget

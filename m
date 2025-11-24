Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC3274B26
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988538; cv=none; b=t5Qce8bIbGXTP37XVD6vZkEqRH7sm1WtJAs2J1mcutxxerHK2YAf23bu3R9ed1Zo6NGVQiQPMUulicTPgehfpSgITPk4D23fwp+qv6aWMuQaZxEmFRz7lE661Dih1APVOZZCxrfMpc+4UP645VfSXmk/BX1Gdc6eKsKgzyH2UQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988538; c=relaxed/simple;
	bh=9b4vZhPIW8LZ64Wesz46nqtvzRZdBOni2AfZKcII23M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=nurVdrUtz1T6mQtTe0BN5bpqDZZAxI8783CRNokW50UE1lSdBrvbWZ+HjPhdbQdKycyjdtcaTppF3nZujAz4XNPwzMEDKSARJB+lZf4QODTiHBEHGddZ9oO/PwS1VpKqh0Rdsm6ARiSHb3qoMZ30ZSZDHs44MRZjbcN3wS1cgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWh1JxY5; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWh1JxY5"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-434a80e5463so15491205ab.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 04:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763988536; x=1764593336; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga37LYX/Owd0WsRu68+OW5NhLOOHYS8wx2x0xvzVeLw=;
        b=cWh1JxY5rg2mfgx8coeX4QFICs7uzxYVATFmD4LVnIuFZvsbXjiBBlP+6OHXn7KIJ0
         S2kBZmb4Hsr7NywfX6IkzO7y4T5/kq6WibY3bEBQTmW65QrjUslYWGbq2jxaKG8PbkK5
         hfCeliVFObnqvRdl/VFfeO56cqVLC9Iltu6hnfl92aBlUYLGi6aSwg0ix7JLKNo0fNmg
         Q2SOdR2p7+B0xRNa2x1Cd1P4A95/6uV0r2QD0RaPPbaD5qQbOTAb/Sl2BmuhG41VF/V4
         TeoMWy4wPm8WK27nvUuxU/sijqhwzmDXaOR2tglXN+7TAGrc0wJ3zEiY+VNTux61ijI6
         wPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988536; x=1764593336;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ga37LYX/Owd0WsRu68+OW5NhLOOHYS8wx2x0xvzVeLw=;
        b=vjF3zyuXdSmRIeCAJjAn3JKAyj3QnQZKJagS6xtuCvtRsHI1r8MLO9yjLKIrozPRsQ
         FCrh8k7zPxEMx77Wvz/lRguUop8UKLyUNgrPbRbhN5A5SOkBrxXlvilAPgtxObnC0j6i
         bUGlBBXG8CJX7/6XFx06xK99Z8GukIbKvANFmUtpz1zrhHAjhowH2BDH1208bx6zuAXH
         ZV9rjp7T5PC2RqrWj8TS5R2cdk6oTxUE/8jqNb1OVuSMH+w+ukVBCBWJcqJm9L/O88y1
         RUBEwQlI0Crl5PKipHuVB13QdJKTNmxMt7rLlYIkI0amura7ldgC1SehHEPF1sHDVXxW
         XT0A==
X-Gm-Message-State: AOJu0YzUUpMF3cR+39bNqvVZlfv43kZSstx3s826OrUR9/8ia+4/tIgE
	Z3CI+EjRkbF8QJn4bnvC+78NSriRlLl9eJEn96T/d1y/IgGDBzjh781UREPyVQ==
X-Gm-Gg: ASbGncuPCwFNs5T+dDpRQBcHxaG36cdnqxeqSmJc79lNxrBZFg98iHbh7vOR8xCM5co
	3atJ3a/anZwh+p3aIICaw+hNIJwW3TnaamJkwxvotBOg4l3oi3kBcMEKsCV5tHZhD9A63sJFujO
	VYF7Do10WAawpql7DWRYsW0rkZK/ThhoC2dWNN6XpTIvzqda3YSKxtN3BGaJjxuaKdbsdEeCJn3
	qshbRGoOm/IGyedS/eFkaXfpHhlmkG7HcBSaGfstT7SUtWkkejq/vNxpFj5nYM5r5kE4PCfuIwr
	XWHqRe/2UAp1xP7jW+d8xrMHl4i7vXHuuy5xzsEBeHyaGMdD3/6k9joWoCNtgykja+50kRVK8ox
	EXlGzjkBtq1zyQce91YGXxyYnx/3sKST084IqB2vJ/9t7sd2amNCPB1R0ROh77U43vZj/6gFLwG
	usXGXd0lYvPC4u
X-Google-Smtp-Source: AGHT+IE6G91kJPL4VBKigJLZinJ6HN1cwGpj/nlQj0+M95l2oi85MfYA1CpwCpmuJEHTm0oUOxt5bg==
X-Received: by 2002:a05:6e02:1f03:b0:433:209d:fede with SMTP id e9e14a558f8ab-435b984471bmr80096335ab.1.1763988535611;
        Mon, 24 Nov 2025 04:48:55 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.66])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a905e719sm57607575ab.13.2025.11.24.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:48:54 -0800 (PST)
Message-Id: <pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Nov 2025 12:48:49 +0000
Subject: [PATCH v2 0/3] doc: convert fetch pull push to synopsis style
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

This is the continuity of the conversion to the synopsis style with a few
additional formatting changes.

Change since V1: While proofreading again, I found a typo (extraneous
underscore character).

Jean-Noël Avila (3):
  doc: convert git fetch to synopsis style
  doc: convert git pull to synopsis style
  doc: convert git push to synopsis style

 Documentation/config/fetch.adoc     |  60 +++----
 Documentation/config/push.adoc      | 113 ++++++------
 Documentation/fetch-options.adoc    | 211 +++++++++++-----------
 Documentation/git-fetch.adoc        |  48 ++---
 Documentation/git-pull.adoc         |  61 ++++---
 Documentation/git-push.adoc         | 267 +++++++++++++++-------------
 Documentation/merge-options.adoc    |   2 +-
 Documentation/pull-fetch-param.adoc |  50 +++---
 Documentation/urls-remotes.adoc     |  18 +-
 builtin/fetch.c                     |   2 +-
 10 files changed, 427 insertions(+), 405 deletions(-)


base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2002%2Fjnavila%2Fdoc_git_fetch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2002/jnavila/doc_git_fetch-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2002

Range-diff vs v1:

 1:  397f56d874 ! 1:  994f6ee414 doc: convert git fetch to synopsis style
     @@ Documentation/pull-fetch-param.adoc: namespace it's being fetched to, the type o
       +
       Until Git version 2.20, and unlike when pushing with
       linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
     -@@ Documentation/pull-fetch-param.adoc: object.
     - When the remote branch you want to fetch is known to
     - be rewound and rebased regularly, it is expected that
     - its new tip will not be a descendant of its previous tip
     --(as stored in your remote-tracking branch the last time
     -+(as stored in your remote-tracking branch the last time_
     - you fetched).  You would want
     - to use the `+` sign to indicate non-fast-forward updates
     - will be needed for such branches.  There is no way to
      @@ Documentation/pull-fetch-param.adoc: must know this is the expected usage pattern for a branch.
       ifdef::git-pull[]
       +
 2:  5b1e64bdf8 = 2:  6e9ea10311 doc: convert git pull to synopsis style
 3:  e5526eaf58 = 3:  9c70b341bb doc: convert git push to synopsis style

-- 
gitgitgadget

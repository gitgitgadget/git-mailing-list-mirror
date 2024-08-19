Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A312B8B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724028318; cv=none; b=OXAkJ+jRL/JxrRYtDcRz3hCfk7d3uyO9GFk0eMCgyMBF/SJqUj8A8SCtXDkCxVR/OUY7KnOK7JER3M09VVgkUgiZ2tJ7MuGIMlq5+up6SbWqi51L5a6LdJOHyea5cof1GU+hluLzlXC0ha4xfpXMtjw/24RKL2u258FqABTUHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724028318; c=relaxed/simple;
	bh=0WoGSB2mb2very34mRatIU265wGvpTFUbLQRiznqUhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rtXcWTMFUsCSmc6AyylRDwIhclepT2h/5MzdJoXzv+wzqYee37boR+6zLj3NCAQGeNdR7KuMxHGeVVIId95+xwOPtBcVGtInnyoPzAbULC2gMCbWfZIoc7t7X5c4R7W5RpW1zR6MGymUdIL8JmrWMQlwmpADBdj3Nucl+a7NqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOW3Ne+A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOW3Ne+A"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-454b12cc82cso11173891cf.1
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 17:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724028316; x=1724633116; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pR/DQwJnbAo9jMm6EXOiuwPPHdFTZVe/8/AJ65wv2tE=;
        b=HOW3Ne+A7saGuqwp2KFRJOlEmnkX7SiRFOhFcJQ0QWx7PqXuvucjy8EPBEd3FttIgy
         h1fBSyN3P63oARg7uONnn0htNVlEl6YtT8N5qlImHsFoXBokjMD20P7i7GEHki7g0VnY
         USysSaBm5XN9+nBGol2rmSGt4IMS8f7SBKYc/5bXjipc0a45pIyU7Lg3nEq07RdEUiiK
         9p25LK6FE2XvCP/SLdWRxLXzXKK21v9F8HIfscNkXjLLVsbbrwySjCopv9JKh/siQol+
         UY4i5oqQiHbGwPwvCWaaMIUbmKN+4nVHqhukrPHOAt7d55DhdGp6OBONfUIw+5aAFxVT
         IGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724028316; x=1724633116;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pR/DQwJnbAo9jMm6EXOiuwPPHdFTZVe/8/AJ65wv2tE=;
        b=ZnA0ETrTIeB4Gnb4LzgdJToYLWK/KNhQ/QY5ThOI6PJBwwtxOYFuGQ/ym+Mex0GjqV
         QU/rU9porGz60WW+2spdN7P4Ftm0rSh9CWqggR5QES/WeaPFmcDdlAwMhOCy+s1D0mqd
         v3jan+83nqJVTBjgaMN2XFnRauHrbLqAVNmx+yIrOyQdWUipDr/ZJlLpcdYt66FORtNy
         zSssxDufTWH9UxcTpCywn94zWyQLy9el5EJwo8WDIN/W3p6/EZy4fMjf0UBM7ncCCq3P
         4Ri8lF/WToDOhA3I3F9+xlF6T3ynuz4REuNfQTXm/LG2nop/Mr/yruFUVdnxmVhG6XMy
         PUkA==
X-Gm-Message-State: AOJu0YzfnUiCQadgKA7Z4Z7zxL0Vpv06qHOL+A7Pdlsk4j1UEvWWcIsH
	uoVdY66gE7oSA9gy3loeKpx/s/hqJ6Sz0Tikm9z1k7mfLrv2TBLIvQNjNR2e7N57y40mEjddmvI
	tehAmVTcOgX30qm2D4adK0X7awSRQwUc8
X-Google-Smtp-Source: AGHT+IFrr/ATyFMuQ/gRuxdO8ccIzzitR8CyORA94FIyxWPn0Dc6oFM24T4g0QBf/8WE4/mBEtY6pgk/ktl4BuAX6+w=
X-Received: by 2002:a05:622a:5811:b0:447:f11d:3a59 with SMTP id
 d75a77b69052e-453743ce5ddmr119990861cf.63.1724028315730; Sun, 18 Aug 2024
 17:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Mon, 19 Aug 2024 08:45:02 +0800
Message-ID: <CAEg0tHRL9+tqY0k2GiGzhc-VgMVsHqppLRFHbc=M33R6AoLXEg@mail.gmail.com>
Subject: [PATCH] doc: add --show-names for git config
To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Option "--show-names" was introduced along with the "get" subcommand
of git-config(1) [1]. It was used in Deprecated Modes doc examples,
normal and completion tests, but not documented.

It's known by both "get" and "list", though has no effect on "list".

Signed-off-by: Yukai Chou <muzimuzhi@gmail.com>
---
 Documentation/git-config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 65c645d461..525c29fcff 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -268,6 +268,10 @@ Valid `<type>`'s include:
  all queried config options with the scope of that value
  (worktree, local, global, system, command).

+--show-names::
+ Output also the names of config variables for `list` or
+ `get`.
+
 --get-colorbool <name> [<stdout-is-tty>]::

  Find the color setting for `<name>` (e.g. `color.diff`) and output
-- 
2.46.0

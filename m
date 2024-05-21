Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A51142910
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318124; cv=none; b=Jx5cOeXeePBsqWq8HNsQjWddUVEcBzxNX0JqpUbY1BE416bio3TcEeFjE81NddS5sA7hv+fbiN5b05Itr3JwdT7jhUvKVptszoLmRUatHNIq4va56CWbsAf6/C0GWFkK/SWO8yMWJAZET+6e/aAk265QNLraaCOjk/CSlujlx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318124; c=relaxed/simple;
	bh=bNb0gZpxJxKA3rx6NX4mpLBLw43vYS0sAB14XI294b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fylOCeKHO2Ee6gr3tj3xd0UVwDJa4/kIUzVY47c5mX/E9VHFDcBvrmf/wfaOR364XI9TfJxAdsq97B9EXq05HdWDLHXuP5DLoq7t0CpPgrmbxSESZgKrvXzbvqEkiE5ixLNg4nlYxMIMV8G0Ja8QZIqFKrbxISgGDD68bo1/7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IyAu/CoU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IyAu/CoU"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43f7fe8b041so3126421cf.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318121; x=1716922921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpacc1qntbi0ZQD0xLsmfEsTBV/Op9X8U7EJfh2gzxc=;
        b=IyAu/CoUNpYmRI2Bla49m24GHALNo+Utjxj0YQwVGuZZWwypNJTuzsxOXEWj7sOnHQ
         7B9X6xqHf51f3Bw/zNKSlFl+uhhjNSvIChZhDWuYiXSiOhP9TG+RjwRFXChCHeqO/z17
         UvoVy1nDkb/Ss2I+a4O4a9EJ28bJt2aXpnbpYTNYboKzsExJJKRScJmNR3bN2ue09arx
         nTUnuiA4fc5ctW0j0Mw9ZXwoOf8siouO7mT/wnFmPsi1p0rnnVOG0d8Ocmo2YVhge31L
         xpXBWnUbP310YsPQ7iStYx0yDZ6XIfEV/kvbnH7OhhWbXK4R+KxOrwiXVsxHZcfBhtfW
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318121; x=1716922921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpacc1qntbi0ZQD0xLsmfEsTBV/Op9X8U7EJfh2gzxc=;
        b=nLySIKV6q5KNOPwzOWUWbxn2qyvFEcJ74kmMVfFDGsxHo8uXs9o0DrFjuz+kmpTwn+
         vwE8afG2ts4pND6t7jXDD+xG2NG6ePXsoXB6bdwhXopkjlDXZRum7BTDjAAabaIr4u2t
         /Fyj++kxtP17IbJkWpqslVAipUPip9jw68uCrBYQEbX9uy2fLF5lknZu1IIwGDL7lcOC
         3iINNJAlY1yYzbltNGNfRLnY7wlRtGJbD5W2FpZnsbCmY/c6dtK/eTCbvR01r8N4UgKZ
         Ld6EIpR1dCDl3Ok4NgA2BTVcyVpdJMXfNdtT0UjQ1ZrN5YZzTbW8YtY5ZuVpbbwQ2xjh
         hljw==
X-Gm-Message-State: AOJu0Yy7Vquu406QFMjd+LB1Str99f600GbLjKIlSsWKBKmQM/bz8FHW
	l8YBGt63Dqe6uPh7AVFlY5kBsXYUfQyIFV6xS7V5KF6ltIH0L2VrDw8LgXhDN8LqpK2NvSmto4r
	a
X-Google-Smtp-Source: AGHT+IEM+5XUAHXrYVz0+glTsNPRvRZ0xhVgpykbUNTwDSOifzCZ68k2S30FnuroMzbQpE/x5yCNEQ==
X-Received: by 2002:ac8:5d12:0:b0:43c:5d37:5a97 with SMTP id d75a77b69052e-43dfdaed391mr390627581cf.31.1716318121235;
        Tue, 21 May 2024 12:02:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0d56dce5sm134596151cf.58.2024.05.21.12.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:00 -0700 (PDT)
Date: Tue, 21 May 2024 15:01:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/30] Documentation/gitpacking.txt: initial commit
Message-ID: <0f20c9becf452ef7a7e931b36336ccddba0f1d13.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Introduce a new manual page, gitpacking(7) to collect useful information
about advanced packing concepts in Git.

In future commits in this series, this manual page will expand to
describe the new pseudo-merge bitmaps feature, as well as include
examples, relevant configuration bits, use-cases, and so on.

Outside of this series, this manual page may absorb similar pieces from
other parts of Git's documentation about packing.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile       |  1 +
 Documentation/gitpacking.txt | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/gitpacking.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c7..920b6248aa4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -51,6 +51,7 @@ MAN7_TXT += gitdiffcore.txt
 MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitfaq.txt
 MAN7_TXT += gitglossary.txt
+MAN7_TXT += gitpacking.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitremote-helpers.txt
 MAN7_TXT += gitrevisions.txt
diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
new file mode 100644
index 00000000000..50e9900d845
--- /dev/null
+++ b/Documentation/gitpacking.txt
@@ -0,0 +1,34 @@
+gitpacking(7)
+=============
+
+NAME
+----
+gitpacking - Advanced concepts related to packing in Git
+
+SYNOPSIS
+--------
+gitpacking
+
+DESCRIPTION
+-----------
+
+This document aims to describe some advanced concepts related to packing
+in Git.
+
+Many concepts are currently described scattered between manual pages of
+various Git commands, including linkgit:git-pack-objects[1],
+linkgit:git-repack[1], and others, as well as linkgit:gitformat-pack[5],
+and parts of the `Documentation/technical` tree.
+
+There are many aspects of packing in Git that are not covered in this
+document that instead live in the aforementioned areas. Over time, those
+scattered bits may coalesce into this document.
+
+SEE ALSO
+--------
+linkgit:git-pack-objects[1]
+linkgit:git-repack[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.45.1.175.gbea44add9db


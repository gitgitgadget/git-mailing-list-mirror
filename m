Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A17279785
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855779; cv=none; b=Rh4sJVpjMy3SGy0XsYNpUpw7wxVBj9cuj7Qa9Yef8H3+AzqCOe6twpo4W3zcfEpGhBt/P9WHNQlGZx80j4jxnIMJQOAxI60kGhvC2R4AuzJo7NQ3Zi47uAwjLqrK/wWdNNEjUlotKL+wWgxt8pBE1eCaTOWmevuk35moTf++0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855779; c=relaxed/simple;
	bh=n8yOlKFM9WYlc52wAf0goD8rGOovEWh2IDj1dNH+Lck=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kd6AMkvd3rQf/Qp/0X4JhLOgKPmcFYvAQSJu0BJFdHFEK4pYuo+ie3+xY7VwMcSKe9Yv0xJHyQB4r7Ru2Pj8RZPZMxZzA0UKMdAbr7DDmxHhWp43mYUfPG1iKMuYk7DECJo31giyKAk1j2AnHrLkYPET+Iwp6xhHRngLBQO+Qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk2gUwje; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk2gUwje"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3644138f8f.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745855774; x=1746460574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zHtSJSu9AWi7kVN4UiHi7ShpApRn7C0GUPB9sOm5lr8=;
        b=Hk2gUwje/FycS34WAILif2YEBt0CKUVxZCO5eR4wW9IYgG58/HYkEGsaBV9TuCJ4p+
         3JUAMl9MK1K7xH3p41BCnIosPVKhjxQF/XniQkKPBbeq6cvABXSy3LQ0dwEvZ5WmCjyx
         KI8dSBTyCehUP7HqMS5cZu5tV3PnYKGGZK2hPsV0CQhUGZb0FHyLyeAi8rlAMXqrlju7
         VjdaXqHyQjwlYLrWVgaVhtrKnwPi5qbFjT3WGMyUx23gLbIrYD1ujD5H4Ln1KKLWTWoG
         OV4QYjawmtSiT4LYQDe/TnlmlF09x8BzZMe5cpcyVZc0ZQz6BNEoAsGuCbkhinZ4YNdn
         tUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855774; x=1746460574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHtSJSu9AWi7kVN4UiHi7ShpApRn7C0GUPB9sOm5lr8=;
        b=mMrA++YSJxoTVPUUTDFgbSMJdOQsdr57YMUWu5V+iozS1JOW9eGoI8nxEFNRcHMdVC
         ZyK40j/tBpHEnNzOYBV3Ylwe3MdEI1WKXgzBEkmU4fEWgVUpydViAmIe7S39D61tyAeV
         D94/lDVYhVtNKL91cIkVTkYcVSHGZaUu2BUyjCse5aUjYPEOtMCCRsMaNvhkJq1vbZaZ
         zNoBual7oWdaZb3WcSQIkpjd9DaexKloG2tjAG/Ewytsr8GsPjE543J5K1xS7xQYTF0Z
         mJ6guaXUu/Jetr5U7djsLHTIaZeYPbCVlFxA9FajJGqWriPSfBryuLfxuwLE7qtsxeRa
         i2Fw==
X-Gm-Message-State: AOJu0YwvPQVfKHKX3IyGLd20XVWVRALUakI0PVmZKMDE1dM4gs+fle1O
	C+fKAK+Q3mDLTVw1nsvqESe6seMp2vD1E3nyFeG6d1im9HjOTqHemTZ+aw==
X-Gm-Gg: ASbGnctA0P7d+FxpqOlH0kDeh3sTEx5deADgesX8Ip83lsyRJDytBIRIwiIowZq1qZb
	Y6GqCxL4uZNuVvV5K654n5u1K64HU8xAu7l6Y2wfR3e+mqjJFD2wRzc6B5PZYQJLYXO8DsKT8Fk
	Cra03clNY12V5X6Mij6oMBsUZElbIF4aKI0CkM90LBCDxK4DBSpltiE2zk1GcWz9CwYnr0Pq85D
	KxAKdr9NCqzbsDIbnymE+rFIJCtgB5/frrD/hNaQm75lJrGDdYUr+syyubJpnI4PHb0cbd0we/t
	SS1PbwKUcFLg6YtB1JGbBgjl/RBfbpTkqijxr5eTBQ==
X-Google-Smtp-Source: AGHT+IGYksSNlwUrj0FXS5oac5sC/iP0yBWww4ZEfaOhwpL0q7j+1Rwuuu8jWh1FNPTmKS2QUZe3iQ==
X-Received: by 2002:a05:6000:1ac9:b0:3a0:82b4:f220 with SMTP id ffacd0b85a97d-3a082b4f240mr4390015f8f.41.1745855774282;
        Mon, 28 Apr 2025 08:56:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbed98sm11297030f8f.48.2025.04.28.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:56:13 -0700 (PDT)
Message-Id: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 15:56:10 +0000
Subject: [PATCH 0/3] gitk: small quality of life improvements for themed Tk
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Christoph Sommer <sommer@cms-labs.org>

These three closely related patches build on
https://lore.kernel.org/git/pull.1835.git.1733767737.gitgitgadget@gmail.com
to:

 1. also allow changing text wrapping preferences for users that do not use
    themed Tk (that is, users that have turned the "use themed widgets"
    preference off);
 2. no longer change the background color when using themed Tk (the default)
    as - at least on the platforms I tried - most widgets and the main
    window do not change their background color anyhow, whereas some widgets
    do, leading to a messy looking UI where different widgets seemingly
    assume different background colors; and
 3. use the now-available uicolor preference to draw a "sash" (grab handle)
    between the many panes of the main window when using themed Tk; on the
    platforms I tried, themed Tk was both the default and it was not
    rendering any sash, thus requiring users to guess where to click to
    resize window panes. Manually setting uicolor to a platform-dependent
    color (see https://www.tcl-lang.org/man/tcl/TkCmd/colors.htm#M4) in the
    config file works to get sashes that automatically adapt to light mode
    and dark mode.

Christoph Sommer (3):
  gitk: fix text wrapping preferences for unthemed tk
  gitk: do not set fg/bg color scheme for themed Tk
  gitk: on themed tk, use uicolor to draw a sash between panes

 gitk-git/gitk | 60 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1909%2Fsommer%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1909/sommer/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1909
-- 
gitgitgadget

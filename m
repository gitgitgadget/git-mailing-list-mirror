Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2568CA45
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454334; cv=none; b=ihMMRvOU8Enbr/a1fZpQAAFIKKLZxL3+skK+Mg/q6dx6ewX8F+DQWAs3yCSBqm9kWsSNQQlpXe7WU7jOF2ZfcpfBQkPmFuB4KAgdr4UxglDTUAdLSyTDHl/qiVo/SD7W+LJMWZ0w6RQ9dt42QHb//Qzo8I9QieqyIyBXIRHwcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454334; c=relaxed/simple;
	bh=L5xPrWium907hf8UM1KApJrnU1kfdN6h7s16hHcQ/Fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KPs1rv4qBCrwwJxtAwIFqIy3z1Uo5JWpnRIZozY1ZB2PISJqzdpD5UVs81M0weP41dxlk8NYwKSL+QWPyeaIDI4N1BCNAEswrf6cfsUBUsB6adqDKec2Qt+rq4LTIJ9WbB9FTTOzaKwnH7r5e0TC4SsE9I+Vw/b63hkqwY3o09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFvfBFH0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFvfBFH0"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a110e06b4cso48375076d6.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775454332; x=1776059132; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipeWVKq83BU5zknde2NsYx4+YyDxBO4IA72zmlqA7XQ=;
        b=HFvfBFH0RSCD8oLyaJuWnO717dF0C3jHF0b2teAWk6EP7PS3c6G/4lQO8qBC5yBLpF
         E01NnaNtEG5iBh71RRNjd7loyNsWzwRX/hkOaXPQJOygQlSb+N6M11EkZtytpeup38u/
         y2dK3fBJlPeXnBM8jV4llZxVhP/j8wLT+x4SDw3rlS3bifYDV0xo9iiMncIE98h+FvjS
         EYTqGTIDRmeGGjrbIOB5sz0m4JDbIigSu6/mIFjxrgRNdHFhsci7CdrdIhSSyB3rkD/9
         J0KSkCzQEe/UhMVYNoI38KCv07abhDqae+jbyAgn7NtOzW3CeoVJNsmbWL/vq2eYNkmg
         W2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775454332; x=1776059132;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipeWVKq83BU5zknde2NsYx4+YyDxBO4IA72zmlqA7XQ=;
        b=WXbI/7Qucf3yb7ZJH/x6/LkJ3B5LtoPy119VN20H5H0Bh9PgR0DmTsQxqX1ffo9cFi
         uSBKLmTaXLBwsLWruuT8h1MlvSQApe2ShM0K5R589fG4/yeugTZHD50lQuMioG59RwIn
         O/YA2clr3jSmwpGYdeC40nSsIsgMWRUQxaCvtNTbKr0uZa3nUTgRCtg4Z2pQFKxA18Vp
         g5Ft7JbgPh6pggCXm6RbkpKbqdop+h+2PJrmM1+jlx9NRR7+BLW3A1EyykEdUJftdR1z
         S32myfAi9sHLBFa565ATGYdLjxF7p9LefEYUOLefzmT6AVARF7eTb5iaa30HDUUwIH9+
         DZBQ==
X-Gm-Message-State: AOJu0YxLU4dsqGpJjadM1zvglal51HXYnSMMtJqopuGqH/EuPt9eI2mN
	HMPdK0JIhKFV8BYvc+70C7uileeISqDMztpO+99K6eL2tdkrSF4p6jq3qVbjjg==
X-Gm-Gg: AeBDieutGq64iSYJTCeVTe2hoK1PNKhG00ek/Os2YndgPyJvC83xy8I6A+MRN91iksP
	Kq/l23Awy1GH1C+9XEKbHmHonqXjpAYqgiB6o2PZg0AlvHKe2+YTgEKH2xjdGyR7i6FCbgsgHMp
	xB0W2mYa+I6wTybaDeUzRe+BVcr6m302LJfVAdQ2OPq3ksQXr4WvwdWCyVuAdOJC68VqBmeOR4/
	KwX3ey9U6D/BuYA0US8kWGEJuU0En5aY5mb66Tsz7DxRvXBVqVeMU3PA4UVY4SbGsbGTCdRaxA3
	vaOZrhQ6+BK+rYgZ0bKSxmN78napkhJ/IZvDSK1+F6a2DHttTxRJ1I02/TCeqJ29y3SZ8ecQpEz
	0saVDkq1cm3j9pDglDt7a3PkHNDOP1c8HiM5rLYTlau3+TIpBZKOYxJLbE6fXEyBkCjyY8MPxw5
	yi03BQQaqKaNQKK44A2+gN9pm/ojI=
X-Received: by 2002:a05:6214:4c42:b0:8a5:104b:e361 with SMTP id 6a1803df08f44-8a704cb122amr163124916d6.50.1775454332194;
        Sun, 05 Apr 2026 22:45:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596ff619asm138413816d6.37.2026.04.05.22.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 22:45:31 -0700 (PDT)
Message-Id: <pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
In-Reply-To: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
References: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 05:45:28 +0000
Subject: [PATCH v2 0/2] unify and bump _WIN32_WINNT definition to Windows 8.1
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Clean-up while preparing for v2.54.0.

Changes since v1:

 * Added a patch I had forgotten to include.

Matthias Aßhauer (2):
  unify and bump _WIN32_WINNT definition to Windows 8.1
  compat/winansi: drop pre-Vista workaround

 compat/mingw.c              |  2 +-
 compat/nedmalloc/malloc.c.h |  2 +-
 compat/poll/poll.c          |  4 ++--
 compat/posix.h              |  2 +-
 compat/win32/flush.c        |  2 ++
 compat/winansi.c            | 37 ++++---------------------------------
 6 files changed, 11 insertions(+), 38 deletions(-)


base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2081%2Fdscho%2Fdrop-windows-vista-support-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2081/dscho/drop-windows-vista-support-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2081

Range-diff vs v1:

 1:  949696de7a = 1:  949696de7a unify and bump _WIN32_WINNT definition to Windows 8.1
 -:  ---------- > 2:  0b50c30cdd compat/winansi: drop pre-Vista workaround

-- 
gitgitgadget

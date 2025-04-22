Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3F28EA63
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333592; cv=none; b=gdQ1GHoUFnS3pnijgCATGG5xmxGkMM8sY4QymaxNhBfAyY90PVbuIQsA0USrsyCPDdplI6b0ux/35+8PDtq/rYWHahW923AW+VcYuXE5ct955obMGQjmUoxJiaUGnWxFuTCYLdhHSlIEbEmFbVkDWUDRlCxlf3KSgJ0jErDntCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333592; c=relaxed/simple;
	bh=pGivLqgxWYawi07cxIyCKacjE18vKVERGBUY1BDmnWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ajRPX8aYKIwHeajcLajKrgMhTGrwcz70M1lUleREnJcU1jiefq0NEgULgro+qbNEQnrmPPKWDRPU38L1MDGAmfaQxYmz9Ieqyp1QpqHKZVcHEm29DVDUZKJ1BDlVCobJHfor7U+C9Swr6KGt3QxxSWmO7CqeiLJRZ5yTWjzX2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGsqboZz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGsqboZz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2279915e06eso54302425ad.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745333589; x=1745938389; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8lRnQSU3O6dthqSHDd7eSHWNSIHYSEvJldBOGB13to=;
        b=BGsqboZzpD8VzrnYqjpXKvhXFx5GnUEz7icR6qZq+QD6AUwbneGpMwBiF2Otpkj3n0
         +bSqKATzDnHBwXRpcMtAXoMBuCVakiuWG+qREvGGqIxTz5Xsi8Pske5flKjKWPyv43tF
         koyBjEgJyVPN5JT6DbLYF5+Fyjp6nZsZ4UW94AxmjVu7SQDLtz/GXXs2pOPnrlx4LWhc
         n1pzZvlA/zJQTvJc51atbM4CUoRGXDWkwHj/jiVVp6CPZD7HBu0HOKV5hkMLPq+tsGfZ
         ce77ztY/NpE8DuBjOcLC389tNYQO6Eu2aNbtswlpszZNrzZMy6s4qI59RyTHIBeGnGdH
         Cp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333589; x=1745938389;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8lRnQSU3O6dthqSHDd7eSHWNSIHYSEvJldBOGB13to=;
        b=EVkbPo/lwXGr1usWhW2RXAKAprQjc1Eb0b0GZq2I1GLrWXx0BRGv4H9dK6dbfYUg+Y
         yFiad+RbcWk+z3ffEpKl+mkQud1klXdD5Q7oOftG1dxSPlKSqVM6ss9qBE/FsWFPImpC
         F2AyGqQrO/fLiYW/7Q5TvFG0XEQs9kZITosK3FkLdBeHDVmcFu49tIzlqcL0JwGJS3im
         JTFz86E9Kh2Kr+EGkozHRd0ezqzsP6H8Y2EFESCAb2ppvuqfQgSj3uuMP7s1zGMt0Xm7
         H9I/4p5LZQpGiTuxgncb0edPlyVgiBCI4lccvImzdnFyTLN7Xf3jL2gIc1x8HRcTWrA6
         hSvw==
X-Gm-Message-State: AOJu0YwGspR1hqM6LdrilsZPJoVv9sNNU/buDMdSNJHd7zziHmspsQWA
	B7cFNxlPzh6tHp9FSYXqEo88WrdZAmTBwd6cZw8h8WZywhp/xNseksf7W/ZW
X-Gm-Gg: ASbGncvLhS8Uz+RB5fw+pzbtraJkPzZn8RleXPLBI9SxiKnZqRx9mJqT5qt+0QRpM2g
	H2ibK/CXKh/2Y80hXbZMeWatfGeP2BkRIFYtTbVPri9xRQopYSN4PduHtewcDsOddizvLEvFdmM
	BLWW+TlbQ76MoMcLQR4p/rI1mvyP8Nz9URtQwGfaMtIrH2F8d4mOGEFaFdwoNJc9Ojy1JQST9yH
	OGLzG1I+jwVfAOEm3JfFir51lp9zQjntV4cMp0B05zJp5gTCdTshz5+IuFyQh4phSnYWjv/y4kw
	vmM1KpVxOZF91dY2k9NnwlpIwi90+LuFCKlz
X-Google-Smtp-Source: AGHT+IFm4D5aoHeZ6myvZhgMNsf7uF+/on04vN6tObU9NVFI3k+Wfl1SRf364yLog2rj/kKtzNhb9g==
X-Received: by 2002:a17:903:19f0:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22c5360dc9bmr235714485ad.39.1745333589338;
        Tue, 22 Apr 2025 07:53:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fda1a5sm86408135ad.230.2025.04.22.07.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:53:08 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:53:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] enhance "string_list" code and test
Message-ID: <aAetW0dan8S3Fljq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all:

During I study and learn the Git source code, I have found something
which could be improved for "string_list".

And this patch mainly enhances the "string_list" code and test.

    1. For code, I mainly fix sign compare warnings.
    2. For test, I move the shell script to clar based unit test.

Thanks,
Jialuo

shejialuo (5):
  string-list: fix sign compare warnings
  u-string-list: move "test_split" into "u-string-list.c"
  u-string-list: move "test_split_in_place" to "u-string-list.c"
  u-string-list: move "filter string" test to "u-string-list.c"
  u-string-list: move "remove duplicates" test to "u-string-list.c"

 Makefile                     |   1 +
 string-list.c                |  30 ++---
 t/helper/test-string-list.c  |  96 --------------
 t/meson.build                |   2 +-
 t/t0063-string-list.sh       | 142 ---------------------
 t/unit-tests/u-string-list.c | 238 +++++++++++++++++++++++++++++++++++
 6 files changed, 253 insertions(+), 256 deletions(-)
 delete mode 100755 t/t0063-string-list.sh
 create mode 100644 t/unit-tests/u-string-list.c

-- 
2.49.0


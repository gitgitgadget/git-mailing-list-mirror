Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6623D561
	for <git@vger.kernel.org>; Wed, 28 May 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437337; cv=none; b=a1w4Sj5YKe2wEY1T1CHJAl8D1hjbVe5tUPKpfiR+vdRhERHIkbS5/6ToPT6+ciwnvP18HQ/F8qeKKHoVs/j/2eVaJvx5kqFB3g2+m5x6pwgQWdP7NMMM796jo0+jIes089DVORN1/igHf3CxJA11c8XPfF02SFwlwlR1Oz4kChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437337; c=relaxed/simple;
	bh=1Ng15xmu8nCQ06oTxFQ9/1MBzi0G21iNBDPaXyfXM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K47UpeJ+OOtG7SyFxw2ikCd8/rNb+SkOwXTzY7u0+b3pQA5bP4ry1pdH3zGr3/s57b6JgtLiapDJ7xiuTD5k25AWxmIIWCWgo7Bo9/FaqktCIUI/1atNb2l/HPk4H41le5Gn22EwBE0rWSVENOyXWStaRGskg/7Eh8YKRLclwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b=yFELB0nS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b="yFELB0nS"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5e39d1e0eso459428385a.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pspdfkit.com; s=google; t=1748437334; x=1749042134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKzFc+q5kQiQmUUcoT2xcr95S65iejaGTJvTPAlGBu0=;
        b=yFELB0nSlxdB87oUptoZLyh8Rmq0/buHdK/oYWd/HQNp9dA4DvxKryoVOEF4DNeiMO
         sylZs//tzEC71PcIdi5oSmWfBniXgV2MOzoXbpODlZHSikcrPNKVKbFTvj4U0r+PZClR
         BQJi2NhGwjGTvDy/GFJyT97etBkfV0fJA11bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437334; x=1749042134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKzFc+q5kQiQmUUcoT2xcr95S65iejaGTJvTPAlGBu0=;
        b=wG+kYLuw86WNrOJiH0HTBWpIe0IaZkRl0tqw4OPjUhDxNXHHBYsrP345ddjlMxjXPZ
         DUdMfPnkQDPlLoM0bXe46Pr36YJVDFAeLH00sRdeshbeVdP+aWK6PMBCKpKVvNnFlj5A
         FgqsW4ZwBqwAMp7JWnBla74cv1UX/WDG6s1RB+djvcOtVBmpHD30YVd2yRJvt4jSJMjq
         oNnSWv73VdSgUAufudCSnR8dSTpVKMakvTD3lRC79/Me+52JvKNeDA5ZRDC1wdjgAoUh
         r81fGZfTbJW/i8qUtF+pjDCNEAHPxS/lGiLQZ7A1Lon9pBWfqoX+emmTmzefkpzzywbG
         oWVw==
X-Gm-Message-State: AOJu0YxvChShVKGHABwjCZldKWUb9hGQcy9fGkY81lwzCPtGwuh7X0vG
	ActtJQ635zvVsCOEb1/GX6NVxmLcYf+cXm3PpsuIfejduf0S8J/MQ3mKd2Psj8uLwjltIUugReq
	kmdGLb+1cVjb+KVXXNUCPU6OKfhQshjJRZ4L5X3X2pDareFrwvQlvbeXIk/CHklClcv3kRWeZPt
	etypWrqchywO4auKQqDN4VlqQSfM7pl3CgjrQHWKs=
X-Gm-Gg: ASbGncvXungRvufWdB6SzxTuDR8TRwtL4FlrZ9nZ0jx0F/sCY2+xKO5Vl9PldMBaeop
	ey57o+xnw8oca/nOBy/o6Coib/pZ4L53xBfMTt+vZekZpyApZPVWr+UsqibWTo1im5mjjo0HBrU
	/rI0TaIZBMlWqDzhJe/BzO/Ek7JKruleRya+RNONhajmOeCx8aaD6CWZl2kxCQ/XN0QMsTNzeiP
	ktBIJL+bm+rh28FcHE2FxKvSbduJUCHgZkiLsPlkylMPy/XcYGPIPR5V2sQDvRCztyQyjAxbRK2
	CBgEmMtL1ttOwJfojDVxEy9J173mHhBKPuQI6atJVUexD4pLl+GZsqDUjk8hvI20SGDAysFMrMB
	2+HeTE7KC7uCDgLQEhCNBmu7p5lXMnchCaMgptvY=
X-Google-Smtp-Source: AGHT+IG9SID63jGd9LwTkSRdwkBUJWletf+/s+tVn7mgXiwxS0pYSoRO+YuQs9dPgjYrE6Qcd2Mo6w==
X-Received: by 2002:a05:620a:254e:b0:7c5:49e3:3347 with SMTP id af79cd13be357-7ceecc2653cmr2495050985a.35.1748437333386;
        Wed, 28 May 2025 06:02:13 -0700 (PDT)
Received: from localhost.localdomain (syn-024-208-163-239.res.spectrum.com. [24.208.163.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d06801f3d8sm54269585a.14.2025.05.28.06.02.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 May 2025 06:02:13 -0700 (PDT)
From: Patrik Weiskircher <patrik@pspdfkit.com>
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
	Patrik Weiskircher <patrik@pspdfkit.com>
Subject: [PATCH 0/2] contrib/subtree: Add -S/--gpg-sign option
Date: Wed, 28 May 2025 09:01:14 -0400
Message-ID: <20250528130116.21534-1-patrik@pspdfkit.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

We use git subtree a lot to manage our dependencies, but recently started
requiring signed commits. This patch adds support for signing commits to
git subtree.

This is my first submission to the Git project - you don't have to be gentle,
but please let me know if I can improve anything.

Thanks!
Patrik

Patrik Weiskircher (2):
  contrib/subtree: Add -S/--gpg-sign option
  contrib/subtree: Add tests for -S/--gpg-sign

 contrib/subtree/git-subtree.adoc   |  20 +++--
 contrib/subtree/git-subtree.sh     |  50 +++++++++----
 contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 19 deletions(-)

-- 
2.49.0


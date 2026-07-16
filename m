Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3E13AA2D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180163; cv=none; b=CbSbyaLYeRXknOdgjmUs2cc1lgxIBj14uea/kLGCHeZbW8qOOD0g6Ay4Wue10gtT9mniid6cQfL4uyCBMC29iNbxZsHqlys0DKGGoBl5kNKEW0APBMshi2VNGnDmXDYduAuzGRAipPTX7rY+ag7rMe7GFMNfTmY47UnyGX3J1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180163; c=relaxed/simple;
	bh=uE/wzx7UxIU3W4sqxEVW+WCCObbdukDvX3XdwQSuQTY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UAnIm0Ya6MV9fTbmZ3ARqa/ifFVuol/r8JN1bzxbXnoJgF2dK/HPVlT/8Y2cQrickLBb8TBmMndUELVMdzjzb7Y6+FR9axvYknFALFFp/TSHiF0CaAR3FaF2zrepHfoXWqjS1n6Tw1nB33HZtl4dmBFTbOUHpzaBocEa6GU+i+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X80+qei2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X80+qei2"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c1805b8a7so63875391cf.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784180161; x=1784784961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bwMn9lqYHli3Rtlr0xCyx1FIDTEPnkSDN5QMpohlWSw=;
        b=X80+qei2Z6oVdndLUhaMWYkJqSHTZroIh0IO7fyiA2rJicCUuAR3VSPwgkhLgsugJK
         a/qtyZzYiLfC0JfWeRr+bN/ReqdBdjj9LGZa8+m6+Y6c2j22pifspkQ8xKNBLCOStpBV
         YrDpF0S1CfUpI6NX0nUPb/uze1x+q7ejPn7E6loc90Ax8Jx9gCryu4ytB7vZZ43MbPvi
         MZ9aV9eylJpE2tgp1GWKdO9SgyPu/vvt70KXuRg7N4dfLmK/GXMLb533XD/EdHw0XQyz
         MyYOtV/8BRUTsRtksbb46E/1VX4nA1uzly08dcFS0OOoFLZvgIkx5s39EA8g1wouihDO
         s7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180161; x=1784784961;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bwMn9lqYHli3Rtlr0xCyx1FIDTEPnkSDN5QMpohlWSw=;
        b=Si4xXsuuCrVvaUTTihej+IFqZwjQZvXRmpF2vV8bchwMfpXYQBDx6UIo6N+VEzhpyj
         0MjpryFN8354uGhGPpmloFThs8UX74Qq6wTjsHuJQ1GZHL/YJaaNTwHtp2TinDtVaGUu
         X1QoYPbovb4vyEp+bgkLKSrI5sM11TGadn9HqWVQJupwV2TyppSLQrbXa4JfoG4yod0P
         ad+DwW4ivYAp8FAH7iHRIDYhRJw4XYsMbtw+rwXN9IjTNthnpfencoDiWPSOE8ZNqsj8
         kTXR0Bj5KyL+chtjoK/t9g9UtY/CoDiFYClismcbvF5ds4dPVNWPjokCz7A0ok3FksyA
         09QA==
X-Gm-Message-State: AOJu0YzH/zVGpREPPOgJqMz3sqdg1FyjEocUEuT6svluW5rFm8cVk03I
	GiDcRWP2axRFNBufaVpR+ltURbtPCsuvdYgEf/VKnbE/r0ITr8K9SVRe7vsjG3ds
X-Gm-Gg: AfdE7ckp/VlwYAU89Xlctz8NPbWcuQuywKfdv5rsR2HVd4cQ5XfeBZM7k1jFtyCcrYZ
	ilwDNSXNQNJbY8lgyDO3aYxOcTjtdi5jRDE8JWjzhvz3KxVaboBCL/xSedfZ9U1YBKHUAB9mqPY
	nIwQ3r148JrLi4RQI30NaC/gFzxSBWKLzkOuIlEI9cL9ji0E1bLMdIhid05x8/zN1y4oa9eHpIL
	I2UPXSgEggJd2gwX/N3Hsq3tQgzoBRk0ytMBdFwvGMerHHdn2rwr/db7u9adWSdKJKHnnQ6ParT
	qixmjkDXyvzaAn3ElW/raJtovWlLbRAuNGLtE/dXrS0XLZN+dxAN+biU0nhe3cZbik3BRJtk3ci
	NrfCVllmfxfNdG1O48jP0rt8xHqYK5g4T0P2sYWFce26+VqtPiLDI2yL8wxnBkwIrFIZLoITV0L
	WlbmapX33AE3s9
X-Received: by 2002:ac8:7f13:0:b0:51c:981:94a6 with SMTP id d75a77b69052e-51e4eff6bf9mr61632531cf.23.1784180160919;
        Wed, 15 Jul 2026 22:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.199.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm151879181cf.3.2026.07.15.22.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:35:59 -0700 (PDT)
Message-Id: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 05:35:56 +0000
Subject: [PATCH 0/3] bisect: add --auto-reset to leave when done
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Add a --auto-reset option to git bisect start and git bisect run that
returns to the commit checked out before git bisect start as soon as the
first bad commit is reported, instead of leaving the session active until
git bisect reset is run by hand.

Harald Nordgren (3):
  bisect: read run output from the open descriptor
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --auto-reset to leave when done

 Documentation/git-bisect.adoc | 12 +++++++--
 bisect.c                      |  2 ++
 builtin/bisect.c              | 51 ++++++++++++++++++++++-------------
 t/t6030-bisect-porcelain.sh   | 34 +++++++++++++++++++++++
 4 files changed, 78 insertions(+), 21 deletions(-)


base-commit: f60db8d575adb79761d363e026fb49bddf330c73
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v1
Pull-Request: https://github.com/git/git/pull/2335
-- 
gitgitgadget

Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61992D321D
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468508; cv=none; b=SV3QiY0MouLE4mciOTMehkkI58KfrlE7xV2nxgj3dxVzkxtxiBehzMJfMrAIcUtd+vAF8RLRz2uBT4JKYLevYi/baAO/bv/GykBYKBDZZG0VoZNE75T6sccjLPVbgA9IdXvqYo+PXICcq7AxJKeIpyoVTjoPuJPIVlIB4ZiSCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468508; c=relaxed/simple;
	bh=rZrs/GsUl1/AABsiYSFtfUsRozKF2QQEkisflcZnbQo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FpaYLO9GFAo35ag7LifkGCYXzWSUjtW6kYS2qgl07DjHPUx+cisaKcVRxSBwzfVjgMtq/8DEnzxWtt+Jg7mT/F9677XC0hzsTJ7Ts9nnA8AjfEgeIZQx+K9A/OnQ1+UkKwPYo2MTrEGsh+/UhWR6FUsRi6lKA1+mJVonprqYdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok3e3pZX; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok3e3pZX"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432a1ed9aso16665939f.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756468504; x=1757073304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpgcQHKHiE0HYfDCKVBAyXv8cL61VemustuPY/LrEFU=;
        b=Ok3e3pZXUl/ryJAuR/S82WnRLx4qLAqalbhDIs8kidUeQHQWgKzYRfZX+l4rnlNQqa
         0EKsD40kF68S/3CG662j8rTjAICaXx2rbTr1PTKtRIjiiWx3YdSfO1+zmPKOdCPURjle
         ENlpfvj2N0abWY1zt3IgWynPH8C+kLRbA320HcogrGXepukTO/SCcb9K7L8hF1eVUXFt
         bnK0onZ+MbpD3I+kKJjmFZkl+IvbvXEWYhaShHb7c7tl39BIeiF54tGuUuompousVXKh
         6VCVVqw4NmOucy4lh7w0iFoRwZ4XzjuTl0nDEQX7C6E05xLX5ZGW7t44NmY1526zu3rc
         Gryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468504; x=1757073304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpgcQHKHiE0HYfDCKVBAyXv8cL61VemustuPY/LrEFU=;
        b=ufGiyyV2Y7Pdc+lKzqBfXvvIa40mTI5R3E3Y4SA5C/9lkKtVAju/t13tQcfuIwuBBJ
         vzf0DOxwz26nBsQvXrPdQ1KFLbRR5kmca7wMiecdafVoBm9Ta4/QOtdmL9ISqDbtp6YH
         IzPbRGENAkzjlNrtxsfgN/oAICN1LQzm/B3+hs2aNwIStC69R3zmzG9GQw0Jpnh7QGf4
         kAjz0nQqOKfH+w26HbkU9LIuPANr4ZZYFhV5KULtcr7Uan6GMKLuQI9YJGc+3ozVc+Nx
         jKudotdOIgh2b7rSqdU5hh9/bdJEvHALBkl+MwgKu+WyMoOgFcUShcdQ1sXrCDpulSay
         mxLw==
X-Gm-Message-State: AOJu0YyRi2J7XpZHtzERP64kkSzdm5sYYCG7wDjv/Dk/43oBK1OgWChs
	sHjIKabn7FDWaIvrSe7dPr/feNAJ8xGSdcalskEZhlaxiz7xBYTEdIsmN1M65i8C
X-Gm-Gg: ASbGncsUFk0Tc0M9Xp50trsufcmxOug6bF4isYvWSKSCFzzEl5YknAA9/gkvRjWzo8b
	zrupUHGk/HiR9zAomUXTMzVrKsS19kuL4FL55bfbuKXTU4GcSde0cbfheoDW3+EuyVm2598+r0Z
	truoaEuqbzUT00vowZr1pbG6XRXjHuWPHtdgW9E9M/j0FlXB3l9BR2xosSRhLsnrtyUFbue4FEc
	n+F322CtIfKpIAr3mGyJX+eOpHKS4blo9ZIqTKc8KxZvrSXcCGApBfN1XvhZn45/2JJDeGgBFjc
	NW6o6sbeX5r+BMV+QcDOMZF/a08OMjJZVzB2Qox9zV0Il5hlEXCGItTswvqVpLMG87QQCveGSnS
	OF7erTJb+ds8N7w48zSW4ud7qVNs=
X-Google-Smtp-Source: AGHT+IF667pFNF0D/o+xEfMutrm/UHLfkwT0cwzba2KRm1K0kVe8dGOSU6ZAQuPlObCv5EdE7WWjfg==
X-Received: by 2002:a05:6602:600b:b0:887:601:c5f6 with SMTP id ca18e2360f4ac-8870601c63amr1335364339f.7.1756468504270;
        Fri, 29 Aug 2025 04:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.182])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88714d62146sm41497439f.5.2025.08.29.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:55:02 -0700 (PDT)
Message-Id: <pull.1952.v4.git.1756468502.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
References: <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:55:00 +0000
Subject: [PATCH v4 0/2] doc: git-add: clarify DESCRIPTION section
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    rsbecker@nexbridge.com,
    Julia Evans <julia@jvns.ca>

Slightly reword the first sentence ("you use" instead of "Git stores")

Julia Evans (2):
  doc: git-add: clarify intro & add an example
  doc: git-add: simplify discussion of ignored files

 Documentation/git-add.adoc | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1952%2Fjvns%2Fclarify-add-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1952/jvns/clarify-add-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1952

Range-diff vs v3:

 1:  c44beea485 < -:  ---------- Git 2.51
 2:  080720c059 ! 1:  57947d5a3e doc: git-add: clarify intro & add an example
     @@ Documentation/git-add.adoc: git add [--verbose | -v] [--dry-run | -n] [--force |
      -the commit command, you must use the `add` command to add any new or
      -modified files to the index.
      +Add contents of new or changed files to the index. The "index" (also
     -+known as "staging area") is where Git stores the contents of the next
     -+commit.
     ++known as the "staging area") is what you use to prepare the contents of
     ++the next commit.
      +
      +When you run `git commit` without any other arguments, it will only
      +commit staged changes. For example, if you've edited `file.c` and want
 3:  fc2ec305a9 = 2:  f57effdd2b doc: git-add: simplify discussion of ignored files

-- 
gitgitgadget

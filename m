Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F12874EB
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650560; cv=none; b=p8z7/dDL0p1JHsHNiK6x467Y/MFKx+usp/5nhEMaHUPkV8OdFicVP+F28+aiirXqVVzPCPBMDIaIC0TfPenK4VJujc/uBLCSJepCRHOw6goWl2S/Co/Vi9+Dqgivyab0yTsxaXo4o/SNO2OxBKCJg/97r2Si/9J+8j9sincCOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650560; c=relaxed/simple;
	bh=SLm+sPAkcMx44bfDXlMI7R/VVvWsFQWFcJpcjOOLhKI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WNznduw/AHPguArRS00FVW9tF/gXDEyrc2Nobo1eTdguGbxYGJeUGN1I2aydckmOnch95KOGjrES3BtF8Hvwip//POKYTEhVCxP4DoJC0Yf6OOxDVFqomWiTA4duq6rVjkPgUYCz2/KRBby1eXGrbVX+xNIs040WrgN/ZOPJDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff0Rsn5+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff0Rsn5+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so56227325e9.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749650556; x=1750255356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxTsJyCX9mAUOecvMzkIdHHrYD9aJIYIN+cgvCuUxSQ=;
        b=Ff0Rsn5+iEsyQrQ4B7Q6P5wosiitvg/cxqAiKWLP9pNh0axlvCcyvBXpVTAuOQEqox
         oA5gbPXxc/YezcabMTyJ95tGrXFg+QWEVn5k94RsDtomzHPeu8r6PdD/vSF+lKnojfT8
         pWnn99fncn0sjo88h/BKZXy9dKmcC3vDKLHjdHOlNcBpVO12XiCdKBG0DEp/5w7E4yTz
         aRknfUoaOANbegPGI1KwvsgeBJKPfZ7u72ui/BrX/UqvgStm4Xkt6xib4zCwwNHYoXYK
         7akgGxw5ECsw6fv446npffhgeIEept9LGq3iSZtJcWqfHYjmLiSeIUpaGO+kUtlPIeFQ
         k9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650556; x=1750255356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxTsJyCX9mAUOecvMzkIdHHrYD9aJIYIN+cgvCuUxSQ=;
        b=wwPsMFGEsQ6evUGcvz2OUey0oRUrudIrzFRpVRLFfzpo22mFh5SJNrbYFCRMS6BcXV
         Vo+z72ly7cmTXy83yBrnzEHisbc1I2vzFsQEdL0kNgBmdwuesSMQbx4F7wd5SRjWCJ15
         m9W41R7NHn/WmfHiZW1m25BYeCiyob/1GHyFG/d9IvT0nWRMEk0kZR62gnlYwVi9RamQ
         IuzGtAuZ46daxlczBqkavwjmwiKz1bWHOYqc8uzUtl7sp525p3VZDa92JU077kObX7Pg
         9En/xB7RdW2IOZJ4mWcSmkBk34frmVXsEzASxq1c0nNJuJ6kMUaCbgWNyn2LUwCUdaTt
         iEiQ==
X-Gm-Message-State: AOJu0Yxx9pETBCzQr1Te+2Ev/s5a06eRhNN0s6i6+hmY5IaAE0+UsLdl
	5KF4DZK9huwxOzfZPwyp7r9ULnI/8Xj77hjsHw4O3FUUD5ASQ0RmU1Si+MwAlQ==
X-Gm-Gg: ASbGncvg+GoPlLcOSvEfCcNXxPG66x7CM0Vq73Kj/yRoNOGcfPoYpDHtx/hQZzPRAE9
	tTsDxB/W8OGf7RjUTu2AFPz1V/TjR4exsxQOnJWQZiyp14FN2CfMLVaR6QaKAMsplC3PiR/iWTN
	59Xo6KAAVS5y4eDbJ5DjtwgqUNBfiEEZmPW4f8+VNDTCUhpba7TR5WDGeAhZBvC71ga4vVagh3y
	/oRW3ktZdOY8aC85jXIFHx9X+rHXCZJVkmb1SXZoHZHpSpFQ/0OhnLzXsMtdHKWO9rX5Yc78XAm
	L4mjrcp4MOXOmPKccKFgaiocqUFB28nDGPxTQ9NstxY+3RY3ACaZ4qYl/NnK51s=
X-Google-Smtp-Source: AGHT+IEmTca8HO13aFkTpozdr5Ol+ALn/i6oApssjdVp+kWkKeEoo1L7MeqcJmBfvN7xtGeK4GFMCA==
X-Received: by 2002:a05:6000:1885:b0:3a5:2465:c0c8 with SMTP id ffacd0b85a97d-3a558a9275bmr2667089f8f.7.1749650554118;
        Wed, 11 Jun 2025 07:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244ed76sm15455597f8f.78.2025.06.11.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:02:33 -0700 (PDT)
Message-Id: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 14:02:30 +0000
Subject: [PATCH 0/2] Fix Coverity builds on Windows
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

As of three weeks ago, Git for Windows' Coverity builds fail
[https://github.com/git-for-windows/git/actions/workflows/coverity.yml?query=branch%3Amain].

The reason is most likely the most recent Coverity release, 2025.3. Its
release notes
[https://documentation.blackduck.com/bundle/coverity-docs/page/webhelp-files/relnotes_latest.html]
do not shed any light into the issue (and do not mention that they bundle
JDK20 and JDK22 in addition to a JRE, because what's better than a single
Java installation: three, right?).

My investigation turned up .dll files that are located in Coverity's bin/
directory which have the same name as .dll files in Git for Windows' SDK. As
a consequence, the former override the latter and throw off MSYS2's logic to
find the MSYS2 root directory given the location of certain .dll files.

This PR fixes this issue, and while at it, enhances the Coverity workflow to
print out the build log in case of failure.

Johannes Schindelin (2):
  ci(coverity): fix building on Windows
  ci(coverity): output the build log upon error

 .github/workflows/coverity.yml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1934%2Fdscho%2Ffix-coverity-builds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1934/dscho/fix-coverity-builds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1934
-- 
gitgitgadget

Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA281E4B0
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749663; cv=none; b=s2Zmo4c9PDTcPHWSGoGjrUwGCg+2MOPMB+aG8HnLxPDIU8WZVHvGVfoM4uYs0HdJYqeLsIlR/95K4j2wGCDEl51F/a3CIL1DPzm3mxfmTxQ3OHjKh1SoGBRDQXMiHWvf0SZOUsmqrKoakJ1Pe+efK7UJzo4mFSbfuoGMjkuZTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749663; c=relaxed/simple;
	bh=XQKFMiazbfayu3n0V0CmcOxc9dPQ82eme6S7fiuISNs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mSEig2GTXr89IrMw7mm7TMQPMExEPY9sMUgCB2b4CvKnsdZ5fFRlQ4XOOSSXd4VkLlqfJ+n1utNAt9+a0tZ0h7pY575As2eTP72p0I2k8j9bWVNFmvzFOb/U/iNO60TwlFKwAySvwD4X0wfyYIwD3yeBwFO2E2sSHcqIYwoXXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bulwohy3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bulwohy3"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53660856a21so748268e87.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726749660; x=1727354460; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQKFMiazbfayu3n0V0CmcOxc9dPQ82eme6S7fiuISNs=;
        b=bulwohy3CizXptza74wOKyvyg2vuAGOCql22+fWWJhwubJPD7caDGqAGVtcLdD3J8g
         iOyNM6YhK/rvWUtLL1GKmlzFec75Rkmo1v+A9Cuhb87TI1zbfC8GVmaU4Nxe7WqHsRud
         obdFczWD4JKbUiTcoxofCHEn3nHKHzkbiZcQRJpHGGT+0ax5v6NC++FfXCKWiytdUuOi
         llgMYDu7xiDAiqLCJc7iMudi5vee2oDvnGBSGh4AWsquqfceuOeszEAqvyXb1qjOvEUZ
         i4/4mqDVrOfPhIsIXUbDOBL566IfdWaP1ZgVTdSHdUfso+fCWMlbb9n0GDZbh0IvtYn8
         WUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749660; x=1727354460;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQKFMiazbfayu3n0V0CmcOxc9dPQ82eme6S7fiuISNs=;
        b=xRN/XQVMCTCHFETlMw46dk725MhYV6QJqBoywXfFnS5r/FmncGueTKjeW22HaaIOOt
         2s+Og8Fi39PnQIKu4greIxmdMLJsJKykPqlAPjS3jKoj1E+xjrUVGJ2qfX6XCNzgvx3w
         Y4Cmfi29PXeOSwGbz3JXbmrI1eu94lpjqfDoH2JBxWwJkPOnUAjFDoz467QJJhZ9ZIeD
         Bg0dk3BFNJJGC1CcAzSUt2QKTLfAmEXkdyYeGpI+DJ2ai4WGeKkNa8/qU9UIupjk4hM8
         WeFGZyELAUZ4Thw3n4XmaEH9McCrGE634xolkjfFa3hPQbeoCxqYqow92lGe9UNnE5gv
         8aqQ==
X-Gm-Message-State: AOJu0YzRYxjeoSU2oz2AmK1rkCK9xKOHzmAjPspPjog8OCqyUh6JgRLz
	030Uu2RMCpCkotZXXnG3ZgARWPbNUw7+k/Xb0QSjIwe/XDlfcDkr1XCiH2y6li3cWuQB/mabA3f
	bt+dE4BOMgF5RSOygXF3Fom2VkubDQVJcrlSfNA==
X-Google-Smtp-Source: AGHT+IFEp+vPR+qcSgw30DhhvoY0cyRc/DLPvLcMzqTzgTbdlXwPuqqzQ/3kHWe4mxO0ML7p6XNq6AOMBmDLr1Um0A4=
X-Received: by 2002:a05:6512:318a:b0:530:dab8:7dde with SMTP id
 2adb3069b0e04-5367fef16d9mr11223583e87.34.1726749659542; Thu, 19 Sep 2024
 05:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5YiY6ZKf5Y2a?= <liuzhongbo.gg@gmail.com>
Date: Thu, 19 Sep 2024 20:40:46 +0800
Message-ID: <CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com>
Subject: The maintenance tasks will never run if maintenance.lock is
 accidentally not deleted
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In my work, I found that the prefetch task of maintenance often
failed, causing the fetch command to take a long time to execute in
monorepo.

After investigation, it was found that the maintenance.lock file was
not deleted correctly for various reasons, resulting in the inability
to trigger subsequent maintenance tasks.

The maintenance task needs to be executed in the background for a long
time. Therefore, due to various reasons, the maintenance.lock file is
easily not deleted when the process exits abnormally.
Unlike ref.lock, which will have an error prompt in the fetch command,
maintenance will only fail silently, which makes it difficult for most
people to find out where the problem is.

So is it recommended to add some mechanism to ensure that
maintenance.lock can be correctly restored when it is not deleted? For
example, add pid information to maintenance.lock, or add a lock
timeout mechanism.

I'm not sure if I missed any information, but if this is feasible, I
would be happy to contribute such a patch.

Thanks.
liuzhongbo

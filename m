Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4728F3
	for <git@vger.kernel.org>; Sat, 11 May 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715430041; cv=none; b=aI9QZ2C3H+VXBWveki6DmsPv627GTsYoHQSGQ24XM5bKBXIlQgvLNqOvzt8kUUGw7QjnVgDWYue2YKMSv6xnGeXWa0Mr/5i1xUtfymg3A/aPajEWqaj2JzJe/xhFYwmvqp2ih05gnpBHYPnSq3goNRvgDm44/cw4Q7kWfDhxIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715430041; c=relaxed/simple;
	bh=erhs5OMCt199N8MYdmRTANAOjSdIErn+7odrX6wFoXs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T26Ki56wG2K311h86u2ul8nbmyYuBUQGcn5RiGHIa/hXffyWovWncFsdcjNuUUm14lHiJYEB/W89KDIN74UGKS7moG3rD8HXrp/HTQpmCyjcOaPT2BNap7HbJdhmeixypkR6vWEtdLloRvYxFiJaK+WsPfhd3pdkfw7eFhwS4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=JC8+Fmyi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="JC8+Fmyi"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dee52317cbdso1527081276.3
        for <git@vger.kernel.org>; Sat, 11 May 2024 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715430038; x=1716034838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=erhs5OMCt199N8MYdmRTANAOjSdIErn+7odrX6wFoXs=;
        b=JC8+FmyiAjE6ocTqPpmzQtBIF5NXrBtSIp8eAuq7cWo67E9u38IzxALhgfyAZUUvcz
         TLR9RVy6Atd97nZpMiysm2ZAHk2dj5jdUuCpCDW3e36A00IU+prJtrYKd2s/jCLsp3KS
         rtNHaoMXL/47oYiHdEibyS55ARhVDrVOtzdFftl5OJ07SZnF/+tseNIEYvF9tyLqarPw
         x/QLLIWL+f91VH/wEMATX5UxvzLhis4wr0Ip3kX4hjQwdb0Ar78vtO1jNe6TiJZdFyU6
         L/wVhk1tjXVdGjbVldSHw5tZV6sRiD4dDYEk8w79hctONGh4gfP814P9aFOMLlevUzQm
         rtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715430038; x=1716034838;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erhs5OMCt199N8MYdmRTANAOjSdIErn+7odrX6wFoXs=;
        b=e9/k5sBFSYBfawiHuDaZkhbB/7Wi8uaLXPsL/BuMT6KO37xrfq9oJP3ZEtQx/d/cUm
         y8bswK2Vg7z8nep8a9U4k6H4cVk0V2RZDVrUBrxvKf+EGShlH1r8BJwnS4s3DYImKRna
         Y10tyykUg1JvpdKaF+cCkHfOkui7lB1Bre6TTGQ/07eD7N5LhYLia42rz2a0eXJ2Kets
         FMGe9EWCCSQBjjJlV3tvUySLwQgNGBDnW3pFxlWlQqPX2jz2qyNfVp0pvxgOVi9EqS5W
         VOcZAGARRWBSmPf06t+50YgTrErNz9s5e8fOi5FHVlDnA6l+2quIiAQp6XGQcsRTBrpT
         Vyuw==
X-Gm-Message-State: AOJu0YxWS8QPlEQr3RcklXvnk1kR7lpI2OMYvIJ6G2uTRpl0B30C0yxG
	q+VZAKb9lxIZ3UW/1TId3UN0541IHBksVdK0Ba/x7h3XPz9lPu6uDgjYf1ParaeqiyYKbDjhYWP
	+lQeHAjiNH2YZLi7q+LD3lLpdmckVCNQQCQTcyd7eAw+RBiaBqCGD2tLhyK52ygpXj7YiXFRCHG
	DWjvBQ22119+oSAYRhworj4cmfdoYtn3JcQ5hhmfPxYh8/attdhkHkBWsMv1RLasmrfTsXAdrhm
	n7Xy8eicctZ+MYRnVrYZ9zdMjne7JIZlSmZo5a+rs9B7MYM3Nx3y7bgqsrfAsjoGd8QE5BvteDJ
	IoqAgVLZoTs=
X-Google-Smtp-Source: AGHT+IHlH3vdsEqjHWOx2/iqyTTOPVW8fX8HPDWqpG+ifJK1NSohjQ4inmKQyLJza0UKaIAPxpBscOeBjjEDCBeMQ+Y=
X-Received: by 2002:a05:6902:390:b0:de6:80a:f7fb with SMTP id
 3f1490d57ef6-dee4f2cf742mr5061346276.17.1715430038446; Sat, 11 May 2024
 05:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sat, 11 May 2024 21:20:27 +0900
Message-ID: <CAOTNsDxmKfPeXhAWSeHUfzwKQjqB_ZgS9E08buXT-jOeKntnsg@mail.gmail.com>
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, Bo Anderson <mail@boanderson.me>, peff@peff.net, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Thank you all for your discussion and suggestion. I updated the patch to
utilize the state[] feature. I keep the original "exlock" logic as I
think it is still appropriate, but if it should be removed, please let
me know.

Koji Nakamaru

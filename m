Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE182325485
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847191; cv=none; b=avLRp/Aelg1+6wmvkc+mcssCKZPDyqkklT3OUQ6dGxzQrAJcwdD+4T03s2TYgYFL8fR8Nhuw4q9yLwhU9eFIUC1ExixrLcyQNiVU/Sp3a/q+Qbmmzfe59+b8eX9a8GnBIzgsPh6yPWyf+oYJMvQgR08K4KdaARfyT1aN9D5tqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847191; c=relaxed/simple;
	bh=1grH39EF1jFICJ3w/5fLR2UT1f7FPAwfcS0/OpwWP1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxafLCJVk7hcVCDRtAfVa7zDK1LVXLJKK+LqR9vFwgL9AYKMR0aBgqRMD3/zz2414SnciPKJC5JVr5eERe28di9ft+CPbiX1c4mCTfXcrF2ltRgQG3m21qmGW7XjgCzkBLfrM2c/QkT6Ajo6PHfrKEcplLNVEEJGKMBzXDngkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOjc4fze; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOjc4fze"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2bd236adbso2666026e87.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775847188; x=1776451988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbDvK5cq12gzUDF67aUnJw9ayS0l9ffNPj4vDwIJKLs=;
        b=QOjc4fzeEmUo74gTdp4dOQBH4JI0l0Crtra9u50DlDlXyXa42CX5/2np5cqx0/s1jw
         C4MRt65Xv+QElVOjge8Z1Go68GKhR91o50IZdmsO2uYuX/08IrqzWxwe5uTnHoazfCew
         tEmrbfXPZfra8raUBsEqZiSB6XIxBr7VfmESObe62AvfRZODeObcJYvPT97eJkD5iwvb
         QhKoslLLDPGJZ+WBiEdws0PYbnoMKLlVJ0rFZf8yzsBAelw7h0NssBYaoS9+pQFSqpr8
         Cw2QhEbX6AAH1itQHSSxI9r2gB8mQEMg+LnsTffIlwbEhsoGJfdZuuI5vX2zP8bULkIm
         4q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847188; x=1776451988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbDvK5cq12gzUDF67aUnJw9ayS0l9ffNPj4vDwIJKLs=;
        b=IYahjImY4nEOIeBiXNn0PdKOtT9tVcZYRYhLyL4EqbViq5pBWBkKGAlLUXb5JPfo4e
         xV6WynktgOEWMn9xBNaZ+jKPqD9HRjJ/Fhv6nCTlLftUnLVg1uVj8GFP2Y8xKDTVyxs6
         fRVqAuLx6Kw4G7dKksQg9XLs/ljNIJZH+9nXDadqZCUDnsRUxk/vvpZaTzhXs8CK/hWW
         Dvs71hXms1m7POK/2s+3aRoAPtL3SVMgx8c4ecTwyCZW2gZptFGt/PlKN3sYdmCeqlyq
         ZuEAWots4bKuh9XooDPVDxT6/u+FeAXM9XFZTDIe7OwGeX3D3mfDvBw/QM/AWq3SXsNk
         1sWQ==
X-Gm-Message-State: AOJu0YzUV1+XcvCBjT9Fwn+z7Ig5qLwmrUCmJqsnsDDz9OeHbVEQRyxN
	YnaSmIZs+TyCjxMHV2RHASjuEWPeJ6myz0S9JFtPNDVotsoCCRe7XdG0
X-Gm-Gg: AeBDiesXW2z6GwpbMrLjB1hLAhNlBxjD6k5MTrdPNgE1+tsga5miPCYRId070aeWS9g
	tLmkk0NTZmZdGawW8wH5NnlTmD/XwekDaV2Tw5vUxA/1SEfsHA9nLHIRiJcWA5qQasojp8uXHHq
	MEJnCV5EtsEQH8rFiS9S2WwUfiMFCrc26eNctyLF7WGLiR0r6nCYNlGz7poyMBk9cgcRPI5IG7o
	6Wcim5qWcJ2uBPRrn45ppjf7zRwSvSnXU1ZzlRtDd371a6HrQWmVeOYu9KVi3s9YEwFrSIkorrZ
	86czupQ3/sfiTrQwVOM/MhF5JInszVChQ9vbwAB4+lRwj2GKYwskzkFCKZHgGB+ePhiNp6NsBRR
	u7UUuepmCxJT6VPJHg49XkfX/Bx80o6YpLWiR0ytpOkkMMrs3o0xTgV3PS/lpcjHrd+PajzTHLh
	qUxP6RMeDyWtLosqVP4A+coNGUZY7n1x0Es9iEgUez0Lcbqy227Sy6I0eOrxcUPU79XafTiTEew
	9uEmmMB135qULG7
X-Received: by 2002:a05:6512:6d3:b0:5a2:b70b:c216 with SMTP id 2adb3069b0e04-5a3f0840be5mr1278448e87.5.1775847187718;
        Fri, 10 Apr 2026 11:53:07 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee86778sm904362e87.16.2026.04.10.11.53.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 11:53:07 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 10 Apr 2026 20:53:06 +0200
Message-ID: <20260410185306.73987-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <f8902ea9-8b18-48b2-9daa-08c7324e60f4@gmail.com>
References: <f8902ea9-8b18-48b2-9daa-08c7324e60f4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why do we want to change where the message is printed? It is not 
> necessarily a bad idea but it would be helpful to explain why we want 
> that particular change.

No good reason, and I will revert it.

> This could be a "bool" and the users could pass "true" and "false". 

Agreed.


Harald

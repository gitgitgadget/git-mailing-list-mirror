Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75548986E
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785639777; cv=pass; b=J7LyypDMj1mh/nJRB4PDBWDaqLkkr3RD3VMw+h0N8ad6nv+mQVXIWqKenK37WXWBWKyVp2T2IK3EgKgGV/lA7z4C5L+vIbybymg1esEBYg2DcS6Wi8hFIRndSO1kJzXqRUNk1Veq99X86KJOWZNSrhdyXUeyQt1qs6U4pBT24Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785639777; c=relaxed/simple;
	bh=FcVEo6uw9zTY0u1tAqJl/JOcemRZuADoLsYnBvZOU4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXIDf2sW3LS5e0T3Ejl08noepWowscjMy3FdL7h307DWeUEDiZyLvzf2g7W0+FuueHHqR2kWGo+pvKAkOfVGC/N12UdrZ/xbft1sUqEmjmn2olwvxxFBf0OMw1/aZTjquhGGQ3hM20HwhJw3xRfEqQ4xPNLPFgOKWZEf9l2/d+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUJjTRcD; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUJjTRcD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso2258628a34.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 20:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785639775; cv=none;
        d=google.com; s=arc-20260327;
        b=GXaQj9VbkoJd98xD74g9n2LNwTJ+dEv+lzhVO6lT3vKBqSiLQ/kmKRwBIwt9QqQWnk
         HlyZs2xLGDS6FRuyfU3IhL7phUe11hXRrgbLI03+liJNb3+KGBa6B0ui1sLeW9HW1+Gy
         XwuDgvd8DeVK1bJiaSImN/tK058uXcZ6aKsD55qBkdNDw4LDiMwMkBVrJ7eef82FYosi
         lLjGqEAD4mqsnC56JYx8YAhdmzEFgiVA/wEzaiKUZlBopvTnHlvm2ObB0Z0RNLi9WSN6
         YQSb5XjE55UGrEKqPIQdpw7uHxr0xkRVWvnA/SbhvkrENOntaf9Umr0A7m+OuOelkqhz
         SQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FcVEo6uw9zTY0u1tAqJl/JOcemRZuADoLsYnBvZOU4w=;
        fh=m1MofRN69pENEnPr5pDWRgu2WTNSavpM4K+NMxAO+tU=;
        b=Vj0F88oDHwEQdiEP3JscoyafahQ5DBQ5XmeeF8wmUepF5kw77/O/ZHvTeHW4zG8xmU
         uWJn9AUyS0YYeoflvmV/9EDWVwiAvocBqbgZX88aNYXpGSZjbLDfr1mhXl5u2UB2cX2H
         A/tzjOULuSqgtZPMwMNICyu1QRj18JGHLNq7OXwUboKencnD1QLv0lBTJ3hyNxSrOPdV
         KUXMEMgaIrh/M3iYKjglUbEYJRUgiISBD5z9LGv4uy1xZtPflB8QWyDr93VbYagnVez7
         ZPYCd+5piPlNw30jF+1/iOv2cNpd9VYQpe0goOg46stu5k4v39Ysa+rnP7d3e4Id9v5V
         9zRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785639775; x=1786244575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FcVEo6uw9zTY0u1tAqJl/JOcemRZuADoLsYnBvZOU4w=;
        b=dUJjTRcDRClIahxiQQjEo5ihRvBiCiuePZsTa0xuFacbku45ARPjIa7ZbpCZQ8oBCQ
         HzVNJ6RXTbaE+dcPE3Ziaea3AfUWU8xR0U9INXGK9u6/+VKcHFiQ2lCKNVp55lYBF0eK
         rc4a3o7Two8+klICc7XjOs2V7h43NU3kXmdkZ6kOk5GVh5xvu5YzymUJx5xulxevl7F3
         ctGlSON35yTVizXvnbTZ8FTohEsBfmwTXbs2eecaaj7ICD0Kqr6uXFZBiyzTJoVp7DMJ
         0LKP2GhvQbytyGWc7YbDvrs+mrwdVLhz9Vx/TqlNe+DkhyAxyLWgcAAHjBdLGITCW3FR
         tLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785639775; x=1786244575;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FcVEo6uw9zTY0u1tAqJl/JOcemRZuADoLsYnBvZOU4w=;
        b=i2zxUsjvDfjdH3ciAXO2LW7hZDIqy+MMa0cajoUjJCPOCbthWOgmKDBFEVWZ1a7ma4
         Jwg8ZS3SPBk3Aieyq2Z/dyipvMKJU7tl3vAQ530oQqTBcnrIsOZytLsDYqUsofw+QMfI
         m0ADqiNsogzWbVTfLn+nDCzRwUJmwtcg3dXS/MiO5iLhXLu1ql/zMuoq1rbds3rQXoWU
         kjsfSXUXcHsTioQ6PdM5qDfx2jU+FAQGGV8V3/8NGnRjrT4D8WVLZmExwHEKcoCEBaWJ
         KzYCPZpYV4ig0sRa33yv2R9lIAI/p4nqOcs9d3EeNJVB0cMYWlDHl89pp1uTbJfq+tFV
         qJcg==
X-Gm-Message-State: AOJu0Yy2nQQYtcjKPvyjNgN9XPZEwD10cOqaUi5MpyzmE7Og1Dp2a4M6
	MSajAc/59wGIOuYIjXkjSC5L/I8qcGgZOffZ6j1MjQR3cb5Gj6G+c4ZvIIa2Xmg6sOO62jT0amy
	eO+3V9IS5O/34WlR2aKPmTh9NDhsk9aJ9C0Ez
X-Gm-Gg: AR+sD10OUqjHB28BjHHBhSr/W00IDzgxCElyH3vRuefWsR44+M8xXqusNBtch6Zustx
	ggGhk/u+xNCaP7+YqgZRvD7ibicxd7yHvu8RupaBpdQKX+lJxC1kYs/QUcE4WjDr4C0fPjebtQJ
	JtOBUArdjoX+hpOukqwG9XMu2x8ysgNWrnkP7P+om37rTAMCznM2//Eh8cLE1u4lwQW0arQyZHC
	tGCqvRDoaCx5XrJcYviiR3qzFYDFAmu/vkGoNyxQbyKg7ZdI8ZE4+/yfrJTS9HE5sK8/1VUOKum
	egGKUfTDePWvX9wzXALxlZfJv+XCZLes0nCmCp5xmtsNuQ2DDNpdC6NFuIqwpKy6Q1L1/+wZ68c
	hc0dF1vG8s0jpSHXOSV3B0eCGB4ASdY59ks8bAtf0wnIsfDZsT+CDnkK+Ebh6SU0=
X-Received: by 2002:a9d:4c93:0:b0:7e9:df35:ff99 with SMTP id
 46e09a7af769-7f1894120d7mr3834010a34.16.1785639775250; Sat, 01 Aug 2026
 20:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com> <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 1 Aug 2026 20:02:43 -0700
X-Gm-Features: AUfX_mwKPgJsiMWFwmdK5VttyTxWekIN0wr08YurMV_NPa43X1-awjtti59evW4
Message-ID: <CAC2QwmLWkk4JS2XKLdj4i4CAtr7zZo=9tV_=pPQ77zR+R=pGUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Friendly ping. If it makes it any more enticing, I believe the flake fixed in
this series is responsible for at least a couple CI failures[1][2] since the
submission occurred.

[1] https://github.com/gitgitgadget/git/actions/runs/28983114431/job/86006743571
[2] https://github.com/git/git/actions/runs/29063352938/job/86269734698

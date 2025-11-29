Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA81373
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764441175; cv=none; b=OOmjZOXu5g8mJPwZBrJWZcfxZSEgfiLykf2g4/waTUeswyGWRafbDgElHV35rJScDNQOOT13GWhvABGaUaRKDiU/Z6xLIbG5FNt54XmcobwWnZtMElIkrZpmWIVwPx94JLosQwouiNX30zDjbIKVmja+rHa3quNtlFXBXmxfDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764441175; c=relaxed/simple;
	bh=z6pr2nHF4Fym0XsMRJJy7KXo3zKM8dwy0uPHoQbNsKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DGcrnotqHwnSEDs825xgb1zRdL3th720SVz0dL8Qb6EQzCLRKyYPv9aP4qwIzE0G6Qj1nDrIv2ldmkIjCx4/ikwCtyM9zQiiLIpQ56tH/V1z/0o6LHjwNmRKqDbBTyfEGtE0Z1/83vO9QV2Z8aqKYrrA8vEo1OOFyvZHa+vuEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPOMUeSJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPOMUeSJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso2397435e9.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764441172; x=1765045972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myCe/lq+JFDecwgqQPLG9hrrslglukmSsif/xq67Tig=;
        b=DPOMUeSJjspc5oMtZJhYj4a01cR/jRxzOgYvc0XMEeHTXt6UwmaUSFPpAxtW4m+B0b
         EOutyhqY08e+5iY9qHKO0/NXYAwvwZCKHr4ZQ2aukIa9wMKDFAEg3Soezb27K29l3OxK
         +eJ8ZlXnANVMY0aI7kmRWDSUxo74kdPEJhACUwypo8z/hyKow69BWhRbKvoJZfEuOdJS
         SWuXbTCWcF9hbvus8hc5UNM24h/CT/q58ynjmkLu5Vc1aPQcSZLLVXa2V/bIa5GX291s
         VMLfirRikfDJcyYAXIcbXThu4X1pHeB3ngpodL1oLFEYFTOvLU1uMwmQc7kdHjJUpibb
         diQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764441172; x=1765045972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myCe/lq+JFDecwgqQPLG9hrrslglukmSsif/xq67Tig=;
        b=Z3cfVEkPI0h9Hhgx+nHHU6epc5/YeVU9j+pYsAntP8xrQUwZg/mFLDk9I4neNRkkJU
         PkWzuy8rg3tu9kq5E9UiJ1mrnkF3c+wjCcN1qYvKc8fM2sG6D3k3fezdkmKke3GzL89h
         +AwW5e0vkzPveuqYmaw4b7JzgIES0+G4FS81WrXvFvqeumEgWw0MS9XZe9j4akL4o/es
         80TItBQ8H1VghfhAuc/987nmY448PlIxBzq5B4zKUoW7ywjxRvnEWrISSzkxESa6FR6w
         u7IAVFxGZTOhZVPVhFISvhgmbxCA4r8x+Q6UxUHnrTjiu8DRxJGC5zRxjipP/kBJpE0G
         fa9w==
X-Gm-Message-State: AOJu0YwKuFXFVT6rN9ilsYpgUTyCOCv1gdJLbIW0Rdd4y7r7zgk9XjBg
	6nL8ruAS9zAt0AOStdt+UCBT8Vd+IXX4QmLJsQW8HIOGsROd5GB7NKza/hdHsimx/0k=
X-Gm-Gg: ASbGncuC5MBijLt6GIhHgOW5XkkfCBR/fYXi/7gKvzrkvMTz6R7oAI7qJ34ZN6Gsplh
	ID8kJfqc3j1OMoybJqnIAof35mhLrP2nKI8CrBD1YjGID6hz9VXBF4k0j/LvzoM0TlzyW32Wyol
	bedfCd517Uwp4vKlk/SWDMNgQvYwkGcyUE/4vAhx2kEh+FhgyMdh4spvddBNUDZkwza1QL9Xu2m
	iffKzbnyOnwGdLRv3+MDemEijpZakaXqYzhQV8ZQ9SNxVEth1uEb83RzIsRVnU04t/ONzyYkT6o
	MDyMtEPM1Sl1ctUBBd7fE64RDt4nkvbIVbo/kyhEuKNw6dwgwr/j/o0STLFMAUH01L+L19Q0C3c
	Bx7zDK1v+BuNSJahwOXFSgvHXonaan7/BpvLCW/BJbq3aemj/wSKHkJBK+hz6kdgCTW2JfR8Jgh
	7xUDc96ezYQiUltw==
X-Google-Smtp-Source: AGHT+IE4hcLB5v581eXcVeETQwwqYjFnfZX4oHejzKNfeQglkqTmQdzzg/dK33THWIfTh8bRXP71BQ==
X-Received: by 2002:a05:600c:4443:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477c01ddc08mr193741205e9.6.1764441172083;
        Sat, 29 Nov 2025 10:32:52 -0800 (PST)
Received: from desktop ([194.127.199.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0e21e8sm223529425e9.15.2025.11.29.10.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:32:51 -0800 (PST)
Date: Sat, 29 Nov 2025 18:32:51 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH v2 0/2] Update documentation/discoverability around `scalar`
Message-ID: <20251129183236.52760-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A couple of changes following on from a discussion around the
discoverability of `scalar` config changes[1].

Following that thread, I was additionally working on a patch that would
involve commenting each of the changes and why they're set. But that was
taking me longer than expected so I figured I get these smaller changes
up rather than waiting to complete everything.

---
Changes in v2:
- Add missing commit signoffs

Link: https://lore.kernel.org/git/vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd/ [1]

Matthew Hughes (2):
  scalar: add comments when setting config
  config: document `gui.GCWarning`

 Documentation/config/gui.adoc | 5 +++++
 scalar.c                      | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.52.0


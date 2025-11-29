Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA904182B7
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436920; cv=none; b=K2WMxs53Xikvt4nfZgnaEVk3Ol7Pz3j3HhYGgWdtpkCUjDAD7zHRhMPb9ANCa+rngBV8qA1Nk4w+hLpODJwLRH7TVMvSmNTKlZrJ87woZqntbzPJduijj0dlPtVvF5GueYoRhAcCJwT2hZU0EKVupvoMuGj1IlRskmIIdd/Ynz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436920; c=relaxed/simple;
	bh=07eEJ8REH0s/E0kl0e9J2rOmpgBiLmPAuHiH/ndYNFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AC20SDgh/p0V2pcL1wRKbGAIIuWlLFC4eigPlypQi6zeAmtCk0i47q84cIJ4J/RZcoEArkdKKDGQhvIVMoiaEnDJkm70uDQg58/kjUCAFVPCDmn4Ob1Tvrf3R/c2LGPV+WoIRzw5bPKu5n9KkIQLfd/rHWjTcCNS6XoUUJDMT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRZ9t87c; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRZ9t87c"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b76277b9d02so35459466b.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764436917; x=1765041717; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Og1mmPZj0wMW58wUJ4NN3wjjrQpss0oNAXOP5jtz2U=;
        b=XRZ9t87cMpkh5SfHoYEEKLYj9bQ0H3/Yesi9EKf+GcLe5c4zIxkGC6Hl84ti6d+Ii0
         D5SwHJYvjwFaDkCTuv4gARTBH4b5r4GYu+b4hKINAfZ9MX1MPv/aFh1gLTd7Rxf6m1tm
         loOD3KHJ1ncckLAWT0Zkr5bTGxwKehS1S6vMc7TwTAhf35g1s5FBnR488GiaeJL63o34
         ptMKc3gdyF1qIp4mrFE9Q5Xo84HED/JvmuFtjYsyfC6RyWgQZrgfyOXtDDn/t6VajPoJ
         8amP5u+z2mvb+KNZL068B2e6dlxnm6T3OZeVltajJ5k1bCmMHUbIySIYMeDlcJR3jbAI
         m2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764436917; x=1765041717;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Og1mmPZj0wMW58wUJ4NN3wjjrQpss0oNAXOP5jtz2U=;
        b=NCHveKDLgVIHdxg+KBLqRHFes5DJul6S/7z6WM65islYXd80va8deI6N5ArBwPMU9X
         XqK0rEcCRka3DJyAVkuvlM+yIecUyUeY0JNQ8BNubTE6dIQdZYZ84wusEco/V8T9JEPV
         dX1fksKyKCj0IcChW9Tz3JUlF4IrBa9Y933wRrnXhmZOycUbb3N/EF2t9xkrcoL6lFnr
         3jfaYtFgyUqErCALV/1yqcBKL4uFCWlgL6bUXopWpUf60Vi5JNcKKq6BLr6HVH62Bozf
         UjbL01fWvbpPLksUHYrbssWjCpcRuc12pneHAuoorEY48L4BgZHvCyc0HEY+kZmIiPSF
         BO0g==
X-Gm-Message-State: AOJu0YxkTFpSOWLOfMejAVER/CSyQGcAzamz5EH5tYVUQfpjjACh8JWR
	fyqIcXyYBgcuc+jnoTyWa5Kfhh7TkmKIUCDJtJ/ejtfXMMM1MEMVN2RtvXkrgGM4ivM=
X-Gm-Gg: ASbGncvQYegaJuULHdQPYLxvVJaLJ8xNj/M96C6XcSgTlOQT2C5JoHhO5jc4I6PUpx2
	ZjxXLtdpZ7rZ0cEixv/9HomiUUASP7rGMSUTvy9gVSvbB/JTY0dq+Y6hI6/r5u/Ly7sSV1G+ly7
	ztMISBdTXmiPpPcvdA2TIELJXIEfFQvLU0A2xnL1QF07HsRzYIsfweN42tRk3sL329djJ8qXc3Y
	UWGqjQamHhKJuDW8Fz3xx5Pr5i/LcYo3U1TSopG+245CTiiLJ12zsImqugofPVxP5hWj9AgeM9F
	C4x1hwXZdcN67C/BKeE8MhVB8hwZ7UfyLCL+9jKzr965KC6IS94ocagq2IsOe/MSBkvL4+3mU89
	Hp6HNIE+VCYMaHdFMScmIRIJSBMGlok8tjK+faDku3YF98rz99bF+BpeBwHori1dzW90ORoi3Q7
	quv0ecYLtO3h2VG5EJ
X-Google-Smtp-Source: AGHT+IH6dFhCTS2Y/ylz4CjEN+0REAL8jSMWq76WFH+b7Lv8WJhNMzp8mn5P2BMNn1p1HLOr6hgjow==
X-Received: by 2002:a17:906:c115:b0:b73:29d2:b774 with SMTP id a640c23a62f3a-b76773c0eafmr2042521366b.5.1764436916628;
        Sat, 29 Nov 2025 09:21:56 -0800 (PST)
Received: from archP14s ([194.127.199.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aecd4sm751070666b.44.2025.11.29.09.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:21:56 -0800 (PST)
Date: Sat, 29 Nov 2025 17:21:55 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH 0/2] Update documentation/discoverability around `scalar`
Message-ID: <20251129172124.4164-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Link: https://lore.kernel.org/git/vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd/ [1]

Matthew Hughes (2):
  scalar: add comments when setting config
  config: document `gui.GCWarning`

 Documentation/config/gui.adoc | 5 +++++
 scalar.c                      | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.51.0


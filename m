Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BAA199FCE
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819697; cv=none; b=nP5oOsUP4gQsEdEMUqA+YDiuz5mpC7GeRbfEtfNa6f2Uo65Qd3Y1sTkzJ/egNZVY3nXovpUxrmFmDAffpfAyEAiivtllC7tiOO2xvSSNeSDbmj8YnZtVsXvHx7QPXSMh9hU8eYms6TVkSUjLsuo8jjzG0UE7nhnRuO1Sd49gLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819697; c=relaxed/simple;
	bh=NYxjygHwiC+XSI/XsQHumE+hBsKyNniZVUgk6DnGgsY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e610ykyqJz97gMfry2EhXgU4T0vxZpG3rCnPrhwSx2vfgp8s4wQHVFvdwnEfo036FGW+OB1oSHuS8z/g/ByoUonnnFBkkjrIFwSEmxiZ4ARWl3LWtHD1OzkV2HVzfaEkKJmly0QcUP2GfHK2SVZlVnFo0f/+hL3uoSZoWJUdVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ2G5axC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ2G5axC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b9b35c7c3so24044295ad.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727819695; x=1728424495; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYxjygHwiC+XSI/XsQHumE+hBsKyNniZVUgk6DnGgsY=;
        b=FJ2G5axCG63xRpklqQMYBP9Yu8EnWw8+oXqDqhudbEDwxa/JxW8147/BcuRkZiFNvr
         vzUIU20bkrNDKoSCHObrMLL6tmQ+vMog8c7nhtUjs87MRdIdg3kfXaePGh+dgpHFX0wG
         +C3yILwsBH+8jiWV4UDsVdN2NKmwl2fh6k2RbfFNadlE2DifOqGj7k3sXKMy1uvyVvSe
         1OHYgoS37r8TEziQGT1KzPQddbh21BWc7c6f+42AKuMztqG4ur9T4kS2E6d9ZC0A8R/V
         wFknPWx7pI7rnITOXbLIdswBF94dGahBVv9B8XoQCrxKg0w6EC1b0Ywhgg7iMSz+xLhF
         6w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819695; x=1728424495;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYxjygHwiC+XSI/XsQHumE+hBsKyNniZVUgk6DnGgsY=;
        b=LWoGO68S63rAUZB8B3AHLdMrz4Z/HiVSNpYcMHp82hnH45qIp8juKrADCOvrySYZgv
         LRRVmY6LBBkJ5xtxbFBQD9sz2TUqVfJA3X0i7gf7OIMwRUdYgKhiAWk/z9Srv1aPk0Os
         Ae/p1ss4/ZM5janwwCYJJd3XLx3AltaifCxPJhs79C5zGR5en0g8y9V8v3D4KcE6+b+s
         jS6sJ4dDIvN04DNaSN2bJTIXXMuEFanxNvKVx+Vl6ik5FbmWt9LMu8zz8VriKBexWJ2/
         L/1qam4b8l04e5LIVFPQvj7G9PqfOEgeU1/X7ZfaFIqNGWwc5ftr7sHbB7unweSlSYUP
         CYuA==
X-Gm-Message-State: AOJu0YwAoSLLINBvM/CExU8VF1e3pOsRJpCuTp+jvaDQLJCk3JGLBse1
	6HfxbpivMqHVZG6le/5RTCTJLXDguMV9tGxSXaagDUuLwuE31iHCckMXpHlb/NI4ddpOC7j7vfN
	cOz8U5Yu0QHab+eUy/bROdTnQuzW+HQ==
X-Google-Smtp-Source: AGHT+IGcjQl6TG7KA0u376qZ9/6dAipzt3fhdpMs+QsBeBFsym27RLlXuhnBopdAzc/GQ6AdCo4eNy7zV4fyZDV8UZA=
X-Received: by 2002:a17:90a:7103:b0:2dd:6a40:dd86 with SMTP id
 98e67ed59e1d1-2e18468601cmr1318319a91.16.1727819695312; Tue, 01 Oct 2024
 14:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: N Alain Jr <njokomalain@gmail.com>
Date: Tue, 1 Oct 2024 22:54:44 +0100
Message-ID: <CAECe19JKjsASasm4bxvsYxezj0L5_z=H=3VJ9CXzwdBCezRc+w@mail.gmail.com>
Subject: [Outreachy]
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.
I'm Alain, an outreachy Intern. I am very excited about the prospect
of contributing to this project for Outreach 2024

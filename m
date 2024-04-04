Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E581803D
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224499; cv=none; b=gELFPAleSwNApG7WUlScx4241OL44s4UI1UwmL2GR4aKZVoVGwpqjf/ul1iKL0D7xcwDTw/3OVfvm1ZEdrkkBBmWtiLBSjGhw5au9OSOxrAXbhooNtGCELO1hmUlLtIx64DaB/1oorjCPanITdI4Fyk3W3+5jBglFzhT0fNUk4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224499; c=relaxed/simple;
	bh=5xzaD91bW5ajNVBAtrc4ihRvZnJw1bZ6z+F4LpHCYrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XsUN9KECB87Jfwr5RgiLWc6wTUmbhw60kihxV8k0/qB03bl7r9TjFboKMajlmlAiJnl5dR2TAaA2SktbamDGqco8fnohmVko+t41C+v8qMJ9nBsro07+efYJvnq1aGYEcFfBdKDtZwARcUsm1hrTXHIf+ccxeGETrx27c0ZxSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1wZz0SS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1wZz0SS"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc745927098so805808276.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712224496; x=1712829296; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5xzaD91bW5ajNVBAtrc4ihRvZnJw1bZ6z+F4LpHCYrA=;
        b=X1wZz0SSBKpBn01Av0zuAKS46DgxpERgF+uUUEUNKBjbwYQkpDbFnWYW0+EQrYCiXA
         +ch6oeVBsA/1mjHANLOYfzboyDzGrHRvQYF0ng2b5wjhVUwcqSV57WSZd8LOtizqWs/B
         5Z6UKXwl+V7cdJXK+Ex4K6hxvSlpBfzZOv++ZNEciOKCfoP9ZOMiLRoP/A0o4Ol1lHLV
         9BR6SJM6s/fZda6EwXNomJA3pOjrw70IEWLzRzfs1VOHrIYsol3GRdVqfZcEjIZJ18Ls
         GPb3QZHRP5OjijDApdojFI+Ikm1eqAC0J3FRvaq4x7chAAqd3tRKH472BOiKgnBNIspe
         2Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712224496; x=1712829296;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xzaD91bW5ajNVBAtrc4ihRvZnJw1bZ6z+F4LpHCYrA=;
        b=wHOBffkyLegJI8fHo96aWKibgQ+sb207bD90hmJosW6c3yBTRMC68c/9fDh899EZYv
         5YFBpc0YG73ueer1a7fGFAL0XV41kKKiJbdUXCsgqhil5mbiXMnt017yDCyR0A+Kh8/1
         q1Zf6lPLa1BPnxUOqCzqfkr7KoIX8tpeaT7pF+bNPaFRQKjdYv040jl1XmFmRjgkss6f
         PfC09oN1DQn14jlrc1XyfICE2bv8Iq+koxIakaODdtg+39pqzTSf9iFpaZnvIADAQX3Y
         4S5KmQfT2c1M5ALRw4YKZXYhtx4OS6HPqUHB85VLSsp4goVd9R2H004HNNUqqaF4YZg2
         ZVTA==
X-Gm-Message-State: AOJu0YxiEAishNlUf9806sMMxgxBkVxufdL1jmVvuYmwRupEXTsOt50K
	trEFHAYQxBXrbCUxMF2qH+VFiPyVgq2tw0Ao7v553rXDOb9SAvCwH2qBiSToSBepleaLbaO5mDE
	C1Nd5NNQCpqzLi/sw0u3ZInZHRm5XNxLlTOs=
X-Google-Smtp-Source: AGHT+IHYEmLNCvtbdjC5a7Nh4oS0Iywwpwn9L2HRDLSOk2PN3YtreTtCAJyF629QtbwBmWhn4DUxLPFD3LMOVJpdESM=
X-Received: by 2002:a25:a3c5:0:b0:dcc:8c7d:970d with SMTP id
 e63-20020a25a3c5000000b00dcc8c7d970dmr1898755ybi.47.1712224496282; Thu, 04
 Apr 2024 02:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Phai <simonphaikm@gmail.com>
Date: Thu, 4 Apr 2024 17:54:44 +0800
Message-ID: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
Subject: Git Server
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guys,

I want to host my own git server, may I understand the server OS can
it be windows?

Best Regards,
Simon

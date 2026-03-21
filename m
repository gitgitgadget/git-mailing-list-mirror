Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D2282F0B
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774128506; cv=none; b=TQQgKRKdqS+Ui2oDVqTwc8fvpJohl1iw0oeyu4AoBpk8B/v/s+k/ZyHjfRRdM0DPcNul2qkzvGtRIqRGDXCmjp4uc2pU1R3MHao2KIApItoiMni9sv/8mBzldtCXzFoLF+iuV7wC2Z/hceahu1GuOytROkwCeZczHlCf0FcmM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774128506; c=relaxed/simple;
	bh=cuEBIzIEMDdWFOhLWVgNmvEk3WL++xYZ/8/Mv+OwDfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o352jVcnTXXVFevSdB59LWVl8HWrxblVJM/EMfBlvQ99DueCuXaVBvkdLrOo9aS187rhdNyo/URri41mpxxdNsphltnA8fFTh4reY38YGKeDrBd0nZ+XuPwEQ1Mn5obE9kzQ1+ycxTL8fMIo4AMn6EeI5aeNFRWbJRa+iOjVEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjMnUWKQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjMnUWKQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so16506365e9.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774128503; x=1774733303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVNq/enaZuiNgDcrGhoNqdFWJ419o+cBa2bXKFQlmgU=;
        b=WjMnUWKQq1vBM05TSBSh1sLj5Jpf2iJ+7FDurTdxMK74u80wDJ5eW1+XRTLR4PgL3d
         NiLISurEN9h/W4RihsYnRyoR/TwzHSsfxS6yoHtNzldKp9byKnM5HQdHvl3MTzY5JhS2
         6wZPNeMHJ5Xr7dv4FUPOHCfQgjyzbScNJbiFB/pZ5gh/RTAjC217nlQZEySe211CQP8D
         mrGWvorPoZNpUblqMyC+RxnoSTu7ke9cimEJzOuRFroHb7NlFnPa+wnB0dMgSxlhg7qX
         t0pem8UsOgp3nuXdLYhigBSL02NlBYarU0S2GUczstwytq4CrP2V54kjLP1lzdpZyoMr
         3K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774128503; x=1774733303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVNq/enaZuiNgDcrGhoNqdFWJ419o+cBa2bXKFQlmgU=;
        b=hUbVpCAAedkqgEcO9sN59GsHNHM5tqXNNziHb77ruqqK6qXN3am4ejDXAZrforPDLv
         bqcQxFyjtC8ItMeOhByuhubl7iujy3fAxquTsDEjxUvp/hGq1OEU8T5ZYoQMAEF8rr/B
         GmKfrhrjzUZQYkrX/+KAAUot2PaaQEHU+kMJmk84TIRqSHBeqZ7qVnHg22kunkmtPLR0
         pwe1yyymWKY5tLLgf6ehcWFMZ3WQvm2u8485jz7FQXL5BL25KR9Jx+7BoF9LkuHzGUhO
         eUAP0quiI4GusmZJ6HzkIV0/B24NEz9NcBwQpfB8abxbKY9lrmJFnDIHLGsmQ/D3rMYI
         pd0Q==
X-Gm-Message-State: AOJu0YyNaNlULH3L5suZ+JnSrnlmQjfAfJ4+5/nBjL+6Pe8qvp0Qeq14
	IzOxieqpGnZeIfYVs1k/oMgkOzsv8JarepotTR1w9PGZPtGTszLib8KHy4+0W4XLxrI=
X-Gm-Gg: ATEYQzxne3ee0UYWjK3ckxUY9ctGQOrSinGCAL1fd/dQdM989DFTu2hAAJH66mFMiBi
	VFJPM8Basv8G+JU8B9eEyWiY6L01vLGUM0c3tzZRQfKmFFF13q/OA1mAl2p7G9o71pmC+kH+ClF
	sS/mC8/4as4ETD1umi7AofSbuQ4aasfM6GbYRze48EMB1UD9ic47Da5PjQXnLnVPANHcB74dBjL
	sWGJIMziqT9qPIO5MYyZtnljcVh34My4+xDCw1G5LEvqHbUaOxVEpS+ecD8/B6XNjQtdA4oKhTD
	+rg4sNiSoO4J2sURkGl0e+tKN6VPJXsEeJ3sRKoW4VkehOO7Dy3/ms/gPPlBWDaPK5rKtv0Y9mD
	lPHupaPO4UzF0BN1ZZ2BNRjBGhuQMon9F6ygUQ0073DNNCOmw2Mm4CWRoRwvBrm7YQPcorXfgg5
	XEHAgd0FXFpmAAwA7mZ8yR9mTUf7eR24s0
X-Received: by 2002:a05:600c:5291:b0:485:34b3:8589 with SMTP id 5b1f17b1804b1-486ff04d42fmr108452785e9.31.1774128503034;
        Sat, 21 Mar 2026 14:28:23 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm144307125e9.13.2026.03.21.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:28:22 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:28:20 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 0/3] preserve promisor files content after repack
Message-ID: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

I am not satisfied at all with this patch, and I would love to have some
feedback for the v2. The issues/questions that I had while writing these
patches are the following:
 * Is there a way to not have to check line by line if the content of
   .promisor files are already inside the destination .promisor file?
 * Does it make sense to copy everything inside the first .promisor file
   created by the repack? Is it worth the effort make sure to copy each
   ref (and associatde hash) inside the .promisor file of the packfile
   that contains that ref?


LorenzoPegorari (3):
  pack-write: add explanation to promisor file content
  pack-write: add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack

 Documentation/git-repack.adoc |  4 +-
 pack-write.c                  | 71 +++++++++++++++++++++++++++++++++++
 pack.h                        |  1 +
 repack-promisor.c             | 23 ++++++++----
 4 files changed, 89 insertions(+), 10 deletions(-)

-- 
2.43.0


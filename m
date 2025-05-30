Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590A22D7BF
	for <git@vger.kernel.org>; Fri, 30 May 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628852; cv=none; b=uH9QfeJ6DFhIG4o96KblbGOTxtlPZT4S0uYwnO5BnVm4ac0NRtipJykD+jwaLYZGuhAqfgT5+bSyOSjgg6DzlxACwsWpO4D5lFOfO1iB/+lXHmBChROHPKG4dyo7cCgrcOpc4G+6NX/c6GFc9v2/A2RNIA5eCJaO+5eul73jjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628852; c=relaxed/simple;
	bh=KvxOgkhO6u6jQk41JX7OJtI0E1lkZf7Y8OlRU0aXWfI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=PH6W96hj6bYugF35ZTIUgLQpQRiO43/+tEhpj9E7vLKW4x2EZrCm33UF8/f9X9wMG9xiRVkoQLVcYU/6f9bcuSG56PKIiQWOsoyhRDiY6dDTEu7mcE2mWdcBgf8ZmpFHJqBEeN0NN81Bz2HXPTZ2LLY2LrWudbuLcaDx1SIaGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnU0KB9o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnU0KB9o"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so8018225e9.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748628848; x=1749233648; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/cHT0SD+Q6e49UajmoV7jD4lcL2wlNL5TA1jw1QQMc=;
        b=BnU0KB9ovPqzX4CaQd7+Zja5ofG486xNr73m7V81+4Z3vyQUqdEHOlSh188b1lj+kU
         G+qsU8+v/CF4Ma/Q0+g537tQ3EXFDdVuBZAHxcxGsrA5/+ZEizDHUCvsEuh/Acz3iyCU
         PXUyvQOMb7cy/AfBYKyby1H1p5J1M5uo912UXQ4rKZw/A4VD/Jlea/t8/JVSHGkZoaJM
         R75thYk2YgyGV5c3GswJzXNv11ap+6X5effWdDX7FFOkBWBCp3gwAq2XF9qtIepD6Uo0
         D6l93uKpkzBeV6Y4d5YlvMLZU0cUISzL00CT28LtIBTaqhdqRBZJYaTGvAujHv+S2exx
         U+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628848; x=1749233648;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/cHT0SD+Q6e49UajmoV7jD4lcL2wlNL5TA1jw1QQMc=;
        b=CpWSAN7wKofj6Dd/2rHx7g+CO7k0nzU7k/KOOPWPTaIfg8BWRqUpAsmploWnudkSs6
         TYCpvR6y1MG+zHOLgYl+Dnzs7p9GllDlEg/PiHbj4Qe+iQD88neCDw2CUdv4TFFIvHIb
         553EOgd3kNSrzt2VX47d9iECcU7AIAFkyEKO8KeoNRTIPA1y7dhZraeFHSh/dY3wFXWb
         PUxbnwcUnDt2UiugsGXXLocjuN7pi1YXWUMkQ5GC1GPnW9r3seOyzcr/cXmUremOItu4
         9kuUxyiK5JZ0FxyYphrsiB/sYYop/nQev8mSnNjdcWcqpL6+gyHfum4rHb4VvHDjo1nB
         TqCQ==
X-Gm-Message-State: AOJu0Yx8Gz/ntyx3DxX2DJcbsEmFpbseu7qhYqaZUU4HA39SnrXtW1UX
	veI6Etbbsalhfp9DzBk6pd7Au/N0bObs3qI62bUUW1qLTt6Yf2HP8BjX4HvemA==
X-Gm-Gg: ASbGncsyojEnVIDve+zgFKGzFjJoVXhupR7sbdUOhGuPLrsBTYer4BG5DakI7PIEmPA
	U/MbR7SJSE7JT38A56PICUD0CIpwQFceMEFqzZJ9KvOQDqL0P9/Jv0HGK7izdagKczByHCPhOCI
	+iBPdFAuhP5OsgNKdPDDVmSg+pDNa/q9j3ZxOky2iTlvIJ6slj+gITaxxOzso6HOKOHOT3ip4L2
	15BDWx9FCsVo2+YIZZ16bUh1AJSgcu46SoOFMyDX8smvMFfgiHitIQpAZHxozfM3Ko9FagIi5Cl
	tmICLWIXbQghle0K4smoHAZLeFlFDIcNdmN0mfyz7Rnm5djHpgXs
X-Google-Smtp-Source: AGHT+IF18dCB6Cmi4yKtYhgxa83gbgEynXnJdVN1NUr2rwppYvfjiFoohI2noQJFRATIgcs4yGUuEw==
X-Received: by 2002:a05:6000:230b:b0:3a4:d915:d652 with SMTP id ffacd0b85a97d-3a4eedd4eefmr6252771f8f.29.1748628848367;
        Fri, 30 May 2025 11:14:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb80e9sm24153435e9.27.2025.05.30.11.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:14:07 -0700 (PDT)
Message-Id: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 18:14:04 +0000
Subject: [PATCH v2 0/2] pack-bitmap: remove checks before bitmap_free
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects, remove cascade success check and
always free roots_bitmap afterward to make static analysis tool works
better.

Lidong Yan (2):
  pack-bitmap: remove checks before bitmap_free
  t5333: test memory leak when use pseudo-merge in boundary traversal

 pack-bitmap.c                   |  4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)


base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v2
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v1:

 1:  19677bcbc3d ! 1:  d7b7a0e29ec pack-bitmap: remove checks before bitmap_free
     @@ Commit message
          pack-bitmap: remove checks before bitmap_free
      
          In pack-bitmap.c:find_boundary_objects, we build a roots_bitmap and
     -    cascade it to cb.base. However, I’m wondering why we only free
     -    roots_bitmap when the cascade succeeds. It seems we could safely remove
     -    this check and always free roots_bitmap afterward, which might provide
     -    some performance benefits.
     +    cascade it to cb.base. Only when cascade failed, roots_bitmap is
     +    freed otherwise it leaks. Since cascade_pseudo_merges_1() only use
     +    roots_bitmap as a mutable reference not takes roots_bitmap's ownership
     +    we'd better remove `if(cascade_pseudo_merges_1)` and frees roots_bitmap
     +    anyway.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
 -:  ----------- > 2:  56b24d681cb t5333: test memory leak when use pseudo-merge in boundary traversal

-- 
gitgitgadget

Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD0471D1F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529578; cv=pass; b=aJSEisivSvcwe7R00vcsYBD+hXM7dKQ9m2fR2Rai4iiIKRVJrUxfh/3DILARN17+LT8ZWnSiPbkX4IQZ3SNm9MBBAQPOVRO8Z2JB5khUekQzUYN1w2KqH/bkW4IMtFYZBF/BVBcnUKwnBQYrKQyjddnQJE9eFcOKz/MswRZ+Sz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529578; c=relaxed/simple;
	bh=/yw+R0a+0gR3+0Pm0/XLnWycfL2+oJc4b3nRZVps05U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw1Y1xe+SsJVcPyePgebfiKIlp58ATvAGIbR26Iq+fGW9ypvewzDgHqHp5PW7/8qa0vSiVxmCght7vpqDNe5Ma+hIwggamoGJgw5+YU4wSQ5OcHbOuETiUVIHCaFgW/zDQ53bTnEd73l2LvhI4mJ0w9ZZn8jlVK+c2u22SGKtTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTc38G2O; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTc38G2O"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so8571293a12.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 00:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529574; cv=none;
        d=google.com; s=arc-20260327;
        b=P6Ynr+ujtli31gCdAC4lOp/zyUPY7SVBgeEgZLfx6NRpVXpWSdvhDPeKbdZuwGJE2a
         yzGzx1F7F2NJU4bM+P0P+g6TqazulVQ4nySN41IEyQU8JdCU2yqjYtguJOtfzxSbFNj8
         ++yeGUaoRSr8z8OhVHwgVNYXWrFj+jzHj2miFwTZKZ0G5mjOYR8TZeDLgzimFpFHWlWc
         5HOgqhbRVOZqul5MCdDlDM2vzW/aY0Tl3jcLqmmd6+e/Em0p8tYRudyP/jwYQD5AQpmu
         3rwFoxDAtexTeBuW6y1sGASVNs+duDtMMvXRlebfaVaqvpubztyDbuoKukyfH4BGXbaY
         WvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IKwXTkOKauEEYzRd0teP04vLovzlY2S5il/6RDx4Zi0=;
        fh=a3HxRdcHHwYkQpVHe3r0U2D6HflTva9aqcaFg57pXkU=;
        b=O0s0ESWtowEeqSONNBFaM1B6jynCfsCWg98+Ts96Kc7qJzK5ySyNuh0LJSDrbycbsV
         cJydJ6ZpDrW9Gup4uzaBz0Xl38F+VgAgzqviAVbkaYppBV13knhxxi48jzdIQIL9pPaS
         a4ZRV8TMtibGS5hXx4WTbtrMDD7nRDcevfGjCCzBr7AweNC1aqHd2sS2ynG7pqZLNHkw
         eOSCRa/urhwNgWynxhd2oAQEFHihkQpcqW3iZ7VmNJMd9WvxzBcqn0l4LnD2tuyPwKQK
         iQWI40y/4LG/WcUDQjRw6xmPCLRB4KabYXvIFdUBYkretZFUdl+uRSqcxmvq7Jlztx4T
         ExFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791529574; x=1792134374; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKwXTkOKauEEYzRd0teP04vLovzlY2S5il/6RDx4Zi0=;
        b=lTc38G2OBjPEU/Es4qx59qUK3C5SXVEN8b5+bfioy45MpWpWZH4cbQqDY+yZvsG83K
         TcIxatCjszHhO3WbN46oSSq9qs+6GWGG80tMleE7QNcyJqyybbg4tCZl3dYTFquCAFGS
         EK/wpxoh+EyyEdblDbptv4aK7K9DYglswT0nI8ScDo/2D5R7wTMDVCLhp5ejyVzqw3am
         jSFOmKvBsAyOLcCmDR8k7axHcezYZ9Obi8zYGFYSbrk0tP3mU/srZgedr4vpddiicNEk
         0FWNI4Ifbzz31kyde4k3Oo20RfVKAYhvne964UQlm0FxEhElQtJit50PoiClI3spLXpY
         kNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529574; x=1792134374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IKwXTkOKauEEYzRd0teP04vLovzlY2S5il/6RDx4Zi0=;
        b=HnuKYVdSwa8o6SuhHkmWERSsJp+vVgoMRtD+b0Ih2BJ6SSNTWqYDpe6enIrH3Im+46
         82d18bqhMLF37pEDvWgjHC266Pyqs3+86lkjhPiq9SsGWUVwiYFGQGTnAuegwC5IGmUZ
         zhhe10TJUOZtGHmr+TJ2HBxKzY4inv7zSzEpgcsYAdlMD+0lgC+Jv6jm271Y9eVWWxgi
         Dr1pyeG+DoPZyhb97jZhHUU1TFvQrkQMjVI3qWfKnHFwuWicFoxRd13mKwH5yT6apPBM
         It0WuQajJzzSyYee8qFhyt4AgmhUDW6johIf+jP5C9heidJ5W51ZnDqYFNpj1VUFnMnP
         66oQ==
X-Forwarded-Encrypted: i=1; AKwUvByr4ovm2Zroi0e+tIrwI2Y0c0Ei5t4aJdkD6fDCLiPK2uEn78LTjGUBkHd3yJwmb3utkf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdGd3zGOW7CN1tX6qJZwXK9VXP+PXiZxSeYJ5SoUeNLiYI+vRu
	3uMr64cLOe8/Tiq7wWj5f1/lK63hJIxwka7CfE0v03779ayMkcYD/C6ckOu3QnCaqYIgNlWj1LX
	FK/qoFFlGtXUc4rI8gWZIg0HB1XQJnos=
X-Gm-Gg: AYBFou08+PGMK9XIwhr9O7IoumOxtZhyXjiGM90aHJVmzVYzy3eieT+appIJwLQM7Bm
	52IV8b4fIuFwD9LvvpAiSIwMEF3mz67iMv/S7VqbGlGjSHwLbDXLQ22pxfobC4gcPpTJ+xmlgrI
	xgtOYiMg3Q0UkwkrwXC650bK97EcWGv+BqCukaHemTOzlXNPHDKiuJaPnVdN+E/0QuQNazK7j8G
	wOH4EqYiSC3cjkOX30xAY3R8zL+w8QS6fzAwc9cejXEe/brUR8pwLEGPKUstLJIeOA9Beyey2mo
	wbBii5x3MGRnW3BaF94eW9mw0muIdGUZS1Db09t1eyUUmG0I0WlUrHzt
X-Received: by 2002:a05:6402:52d4:b0:6ae:236d:870a with SMTP id
 4fb4d7f45d1cf-6b17c26c298mr601568a12.26.1791529574238; Fri, 09 Oct 2026
 00:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com> <fd6864daaf47dc3cfbd3cc7dadb5f0bd76d4eb79.1791410164.git.gitgitgadget@gmail.com>
 <xmqqo6d4163l.fsf@gitster.g>
In-Reply-To: <xmqqo6d4163l.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 09:05:37 +0200
X-Gm-Features: AclHuK925es8tfKNj1GMZTRTxpIkRlDn3Lb0iZDXObyHrxVhSfOVEMb_jQVuIwg
Message-ID: <CAHwyqnWzYvvtEWLxquOfq5yFHBTkcKCaK5z2cNa=omPtuwww4w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] fetch: infer branches to fetch from a refmap-only remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> By the way, when merged to 'seen', it seems to have some
> interactions with other topics and makes t5505 and t5586 fail.  I
> didn't have time to dig down to the cause.  Can you perhaps help
> finding the cause when I push the integration result out early this
> afternoon?

Yes, there is a conflict between
'ch/fetch-followremotehead-lazy-validation's' and my v7.

But that way it's looking now, it will go away when pushing out v8.


Harald

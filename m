Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289B3DBD4D
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918247; cv=pass; b=ZBaYWifNBk5x2AzWrWOAolNveeca4F0h5UdNkxCNrHtMYzJdVEE0f+NblQ1bYDP4K7MoKTxvMWCleuusA5Fia58oMD8fQMJGSyNhV3s96+e7GoC37PrdZFaOaXETw9RxvBa/MNUKV7bpQN0yhzIuMjUnz/wqldfuAmW+x6EeESI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918247; c=relaxed/simple;
	bh=hCW/d0/ygPlq8F+jRmuMm3zYxX6mwvEB94MXKftIdM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Slmn0S4MB9QoIk3Mm8CFK7Fd4X8THL26QuLtYluYU4VB5C8SxAmQV5JiEEumaaT+A7U82wX1/K4HY0fx62ps6NLf2Y3aRD0KZgqt4XVfTS2O5w5MzVNnr2uwVeW2TGwKpanGC/BKYiPRapE98zoLFtd84ROboaPsoGCNmgu4gsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhpe86nz; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhpe86nz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8111c0c7561so8201487b3.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 08:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782918245; cv=none;
        d=google.com; s=arc-20260327;
        b=PzljA9AcZgbTE5ZFQI/M/lGUiNbW+XC05pYJOkET4xYVvRUWgskPT9iQptaAqCwYxn
         mFWfYwIReACFImWFQg9L3uqiXqS9D9r2+yl7ukhtqnrLo9TlY0BhAv9B4R6w1l+PudSV
         yFPRFp8IZUxN3iiKlwwWVhsX5i6MfzDtSL1Q2IL99qL+kuBjo661UbCmN0GXFnalTgC2
         Sj40vbX8HmsjzDIMjr52fUuhJC/dRj90kyBCb1d5+WYQ0CE0sqRQ1qWGbJX3W6q0qrtW
         AmKIJjSxaIEHsw7cMzVUmK5zZoqaJf+ADmoanRpGOibSF9qkSLZCfgdtbsB7MWILydN2
         H+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=hCW/d0/ygPlq8F+jRmuMm3zYxX6mwvEB94MXKftIdM4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Ln70HI4pPfE4lOrk+2D2PGAG0iFzMJzl8Ju+pvcBXr/uqHe2kvWYHhAX3XSy6jU/hu
         +rGPnGPvfptOt3W6aMYcwmYTWSO95KXMH9A3+vF7gaQIyHmIiDdlGhfpXIEe+LimWUyQ
         8HAnNfrAfEMm+qwAwmaRuhNrd6YM+eNRBdwNs4N6OevRlNzxrWEThLOOjb175klF3wlO
         YCpE8EcBbXLFgZCZAwL3PqJdWuvguGm5A10c/FzLVdY/S/czDSBkXzNUEUJgIDy1JHPO
         7wdT5QBmUe0gqDQ9IVLs1CjS5K2zz1qt1YdJ3WkMb3tTnIYscShfM+SC8HqWJNLMyoyx
         JoRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782918245; x=1783523045; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCW/d0/ygPlq8F+jRmuMm3zYxX6mwvEB94MXKftIdM4=;
        b=Qhpe86nzW9dRmwjZeZpCVgjfdg749xDtQY4rYxJZXyNyAWdiFclatlrugJib5WXsIU
         5+8DiXG4Q1w0kv7vKaiarn8Rl3eSEOvlxvKJKxIH4XXFnFZIJCgpZXJSf6iti5cDCi50
         blvDuNbJd5Xp3AgYR/9MIX4y0JHC3N+BUw/JgB+B6Ozv06AOzBaBnn2Wpwh2ktNADfXd
         f/9jVGlMUcgayFSUTYlCxI8rsKw24DkP++EMwd73LD2a2scdBUtGku9CcNbwmTz9bDSU
         WQg0PUbCYtTqTcs9mMqbMVrewJa1cCltf1Sdc7IA/3UxhyeDGNvykWLtCBNRJYPESo1e
         Vf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918245; x=1783523045;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCW/d0/ygPlq8F+jRmuMm3zYxX6mwvEB94MXKftIdM4=;
        b=q5ZOlyH7o9nBbLxqQez5Z+xKAHQ3+EC9CvAexfod6mMm91QjaYJXxX4qrTo7d95rZH
         4nxoOSKV2/Zz/3s4pYr0v5SdSnKv5Nl9ZRmCk+x1W0bOvszyt7rCogUNY+KI6IIa1eIH
         jMuFvP80lElLJec0BlYUthOoHKyTZNpFoTz1oHVGmaH/lPOCTDSbF5efun+NymPFE4d9
         7t4dcV82qm3WNmwA7At4O7UV/gxMV8SHeDIGI/w60xUtB2Pf9I2B9sH1VXkX4Acv3fEA
         CUbYI6C/yWbE9ALThzTPZ73pgz5eoleRI6+Kq7Nfo0FThaqPWJJyAVy2OgKUY6pYWcQ3
         OuUw==
X-Gm-Message-State: AOJu0Yx5p5Y4n4jdO9CHnIKFPhx/pKGUNrWwbHvxwcZc9JoWeQhBixv1
	X4CY/BCprePGahGzxqLZ3usrVClTdkghhZh2saBrknWYQ4bTKYjGvCFDKvArL7I5Ku3R9/0TOMy
	P+yY+7ZILJSlN42gPgXBZ0ACrsQn5UTXZvPHw
X-Gm-Gg: AfdE7ckd7rqsYrUOIS95NsJUl2tflLvPUdfDyFpAwixDuuzVlf8+zt8J6LsYUaenWaE
	ge090iUyhJjK4QLKbLkAoouU00gvpEsf5kXnAbE3dTZfnB7YfaI5kVAWPXJfdE0iIBy4m/BWHAA
	EU+Zl/MUA9tyV/xa8xwyCu22JZi56N/tO8b+XGAFKZhMwzBbfRqMwqbK1wwBVXEBC97gKCAAjaG
	PRCl4tU2l9rZNBVOPiosPHgPYcQcHwuCPVNgwmkHMq6kay3gW5xyZFQt5RePC95C56s8bL8sdVk
	EOaxTyex/mE6y2zdN0uHVGWNQZ81cZ5WSKqu6IBDu2a32NVUXz90cWBin6K0MzNKa1jGbGrWXLR
	hzVQczVebeFpKngxD3gHznfovFC8nCSNl94RJFr1tVcd5AlYlKdM/LdNN2dZGYE1eH0jO9c8=
X-Received: by 2002:a05:690c:893:b0:80e:2592:5218 with SMTP id
 00721157ae682-812eb767dfdmr22151767b3.50.1782918244307; Wed, 01 Jul 2026
 08:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNT1C6O+xHKfbptO5eohx3Md=h4pKRdqpY8+pD9YT_-3Og@mail.gmail.com>
In-Reply-To: <CAN5EUNT1C6O+xHKfbptO5eohx3Md=h4pKRdqpY8+pD9YT_-3Og@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 1 Jul 2026 17:03:52 +0200
X-Gm-Features: AVVi8CeqTeaAaNelPNcVhe9fpXOgeVYYVW6tq4G_fHcDXstpolLQRyWNXBrPOHw
Message-ID: <CAN5EUNSuwptaVY+rBvDpND2NMuGC72-vUSNLyOyucXEY9QAhkQ@mail.gmail.com>
Subject: Re: [GSoC Blog] week 1 and 2: Complete and extend the
 remote-object-info command for git cat-file
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

I just posted my week 4 and 5 on the blog.

https://pablosabater.dev/posts/gsoc-week-4-and-5-coding-period/

As always any doubt, idea or opinion are welcome.

Thanks for reading it,
Pablo.

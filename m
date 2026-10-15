Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABB53CA92
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077900; cv=pass; b=AkM3RB1+xT30mviVbkQVQV3xS/qbXVozwCxWlfGSfg7RvJgyt2gKn2a357Ky0LXDiH3HVbVacxeb0koAI339b3NaOzDP1mHCP4JtP4xq5KKwa8qs5SE/thWhyd8B9q2XXdNFwflYTch0QgnzJ2qtKJ0TEt1SzWQ03TKk7m9eqbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077900; c=relaxed/simple;
	bh=m3Ks30b7Yj0H9Sy6FZ3CfQ+JFYrGs1/LdpJ9dYL6XxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGSK7kJDRMdKuLGSw9gxxJ5fpo3uRgBvjEC+JZvkb65il2s7OojQE8owlWnZhIBE3kaEg5fSHZJ4rqXdQXvXoN474D6uTt9U4WSBwSVsgaa6Uz73R8XqsAr/5V7HsfzusmtBaBKLNRkD8CnIoq6vcypuLMeIAYiFK1NJBpklEGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqCc3m/e; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqCc3m/e"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2207987a12.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077892; cv=none;
        d=google.com; s=arc-20260327;
        b=qhATUHlgpoq8Od9DTdo7O2XDQXeiCfiHumYl0pNcQwFsxQ7kVonyStf64nVqS2COe4
         heGst56etSzrd+P4mzz5vmptRPxj1M5PoXZL8U08qG7tOj0k5h0gO3xCkJReKBAoVPv0
         BQkaToUJLGu28Ec5Ri0L1iV2i2ZY3ZOTs7NsCp73mMFGs3Ft+l6APRqErO9M9jpJJQRS
         8O6a0yItkaCo/aF+VS4E9UFOPclsFgaDub0Wuym6zjn5t9ph1lDYUoJyVCj0yv/S99qX
         tZwqzYF4De6G39ngKtO8kwr+gZG8OvfggXyJBZP+CpaRbyBi8w0pyQmivM479kvIIcwp
         UebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m3Ks30b7Yj0H9Sy6FZ3CfQ+JFYrGs1/LdpJ9dYL6XxI=;
        fh=8KVHYsQo7SpvtQKH4KOhABWHBpdVCe8lMQmYQdwqDkY=;
        b=qOGVqpoRYZGLHijSULhpU0/bFI4nBkdb1Qfq6FR9iygDL0dUX2ii+nDFMdV/EGkYXs
         26EHAzLi/B9Dm66B5r2d5YzJZpMXeX5LoDlVzO+4ZG7TgNGaHtNXJDw/9ypWc9Py+bAV
         r3cryFeKRXlsGd/hzyjMhwx7/QiD4+Gef1XLji+XdRcFbu9ELRsZPfqDaxhUjvSjep15
         8lUMq1C+c8NLRvdIaEJz+nMmabtKPNkfvxtF0bfVNzJbtTxR/X/KDn2nMWVOTdQaNaSq
         ctYrICqKRh/4K4+SX5AdEzAnxQsA1LY82YtW/rBRM8Mk1G879OA+PwAjnHDuzwAZMCNW
         B1tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077892; x=1792682692; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3Ks30b7Yj0H9Sy6FZ3CfQ+JFYrGs1/LdpJ9dYL6XxI=;
        b=FqCc3m/eX52f2oC/37R3E8004F80b4JWmE/cDN069ZAN1ymSb7JJzN6uTi+5jGPDLU
         CeygKTQd7sZxvu0tRgwr3xjvXty6Rk53Uu121Sk7CM32MjD0Kbmh8QAnVODc5WFwQctg
         VyUzrx1KEzOnY2tXkLZqfeeG+53nbwjGddJ3b+qvUotLGwayvU/r0EA3taqSbRHn4B3n
         0nMtpWnZrwwg3ZUVLNRPXjLwiMRcBVg/3MdlscrC48IKCwoKCJtcsI8VafJoadvpQu4h
         XGkRMvjlrVolsqBkWtqwd8YC8fO8iNCAM9xHQNMjqWxV9yqR50whOWMkmzms3P9XJwu0
         p2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077892; x=1792682692;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m3Ks30b7Yj0H9Sy6FZ3CfQ+JFYrGs1/LdpJ9dYL6XxI=;
        b=E+srkqnH7JIozdrgdfOkqEAdWh8e6h/4peO8TsALpr6yILAjCMPi/14nID2DDNFdyv
         BQZZUuKjhOCxQ2TxExdeYifHqIRxPbd6IWOKWiHzfXNvKu9OA/Fvhr1yueBnYrGZnyFO
         qjMRyBx+Lk+sG1pKp8K/de4T7jiYOuuhrCuwUzyBKQxZK+RRH1kTpllE/PhN1lRjfBsz
         8NmJ2l8sxLw+vGsrs4I8TNKa/XQvXpTBeb6LBZskqIwL70TAEOt67KbcL5/FsOMEzjl7
         vLRpg55INHsgaqXFW0o/UBuPgtUWyBxMvk0pDjjYGCZfmJu8qtSUZ7l7Z2EnfoNL1KoQ
         vong==
X-Gm-Message-State: AFq9FYKCxHzWXwPitqCywe3Tc3NR1Y5tf9KKU/O8v0/QY4aN7yx/eeNW
	CEihnimpQbEcQgOb2cjzExj+9gkADyVuhu91meVRv6IDkiMDsBrLsS52UlFaFZedzSqX3goMU4A
	/Hf7s51cEESZGtDjnyHuPL45jX3Ohm2o=
X-Gm-Gg: AYBFou2bzjq6/GC2n+1tfOrdXzDubxlIynrIwcxxHyPDpF6TEY2PXHDK+pKojxCtURz
	rJWpP1z3guSCVQjGj0szf86481CGLCDbsgYzWOpv1c41b7qpjdge+0oaQmTsqCZgSpJUcSeRTRS
	6L/Poms84aBBffDvlGKXeMM33R2hM3ah/pYMAm3r6I96vxEFEnRmGtLcKpmDKovGgoZIgENBmyM
	5jlUUAPznQhkpBSGGojaCYPg8vBaBGDQjU1TDRO3C5utH8AJktsRMkIS6ihlEdfpQyRlaJXoyzW
	++kFWisqQcldj5re2/OTZSVhVdg8pmFGbUyFneRN+MFUNLk9jXUgXME=
X-Received: by 2002:a05:6402:501d:b0:6b1:e474:e0e2 with SMTP id
 4fb4d7f45d1cf-6b1e474eb97mr7443841a12.43.1792077892306; Thu, 15 Oct 2026
 08:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com> <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
In-Reply-To: <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 17:24:15 +0200
X-Gm-Features: AclHuK8To24Nr2Y-vaA5tS15ZbuSHGeOpNYym10QW9NhHxRD1V8NpOGJNtx7o0g
Message-ID: <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> This sounds very useful. That you rebase many commits and then the reset
> points (where each one started and ended) get obscured in the reflog is
> classic for me. And I think many have had the same issue. This is why I
> sometimes use `ORIG_HEAD` instead, or maybe make a backup ref.

Yes! I love the reflog. But I'm also endlessly confused by it.

Sometimes I'll just pick all the commits one by one and do 'git show'
on them to figure out which one to actually pick. Not a great
experience.


Harald

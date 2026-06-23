Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44337C923
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222108; cv=pass; b=bDjbZ4YaDpKbcCEvdl9neXaIcFYtvT/GQT5/i5iEMC0o166AAyPB+ep9BNCNLGW0aFGBbCproWJHdUXlMrv016Xjlyt+mS5ywPUvGe4xmznnXruiKRF8vaqzy0c3ef+C6W5lTjfIUafqTI2EA0w7VJdgZPx2Y4JhTNXBGhnNtxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222108; c=relaxed/simple;
	bh=iPIL3wc6IS9AF5NwS6gqrJqARK61xUdBsWXE9ifiwIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Vwh3zIv3qbo4vTzZxYpN2QuLb9WtYUEvynqkgNV3+NfbBHTBnBKWVRudLId5HkpG2jzQYlI63YLguIh+IH0+2XomW2C4epSelo3bESZAHTZ/bi4OWlILZqm8rsXihh5O2oOWso4d/slF3s+7It78XV302b/E6XS6LYRg8UEw0rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TytobUk5; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TytobUk5"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-399f5e574b0so9599151fa.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 06:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782222106; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6sDCP37Q/jsf9Iu0Oz349YvSCztmDoxLXYYv/FUHhWOWq21Qb9zKZlc2gWVXqV41q
         ldQU/U+QLWXyA9v+UPpp6hJG65pHFrJYgmunXuBoXVslhXMfciVP38bHEwHWkCWAO9GS
         XNTRxqf+kGM7/sTpFUEQDIkkAzWy5Qa+rVhU7SqglLwSyh/bdaG5QreBkfnIpecTgKX+
         ysTQvXeXkH67ybc/co8skIPm2M8Xve+fehE3cwoYf+ttOOsRvcntJSPiIGcK7rEWQ9m1
         GsZm8GAGNr2oTMrw90SOWWeN4QWJmk+Tbm1kxnM0hg5Kc1i79e46cPJWI77TRDmx3zDR
         udUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=iPIL3wc6IS9AF5NwS6gqrJqARK61xUdBsWXE9ifiwIE=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=C1u2AemTVD0UYoLJFOBf02Bro6Q36YcY91JvBPl6KrESCSPYROXGw29EL+nwsgWXU6
         aTyC0WbujOf1D7nMPmCFexTQxB2+5Gv+UuBF8o+YUBEouyZHiHKFichzzuCx7orq7/9q
         9bNNbdjSCqfN68U1HX824g9sshE7A9mXZFcWDcQP0e9/2Pp+qrbRxW/gOUigmiRN7X7E
         QO/IDS1q/+P0dGC6evCx2hK5BOdRNvdiDT1fImanqx87HXv06BxHKIHYXym9jC5lTsT/
         qf7a/BnzkcDPXyVXUcU+O2y4cdmO5yYaDPWbCBkWajxQzs8aqa/FSnbF65mM8/lwNcSL
         gFSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222106; x=1782826906; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPIL3wc6IS9AF5NwS6gqrJqARK61xUdBsWXE9ifiwIE=;
        b=TytobUk58mS13a777/eDmmJWbEN4JA9eSHOZvvQB4AjZjBlyFMWdDXhlsxnFvpl9zq
         N5ISa+bdea9Xc9tjPSPfPIzozHQbHRazH+aNr5LgPy8EHLxE/NiE+foHb5hZgXjjbqh1
         YGxYY99ygejd5BG5/i7D7tJJ9IePeI/YiRUPgC2WusQ7dFU0j/FAPUI0hu7Yh/iroTtu
         ZyEyB+wYExiPruuTCDOXJJx3cvhrRB2vkZgp0Jvo0tBYbFsqfd5rAPtEGsHfy0P/woiv
         io384RnmIGFXHmEJ68SfjQAjLCX9VIo9OEsNEsRvNxqS5HBHSvydxd1+37a1TtjSA8Mv
         L3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222106; x=1782826906;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPIL3wc6IS9AF5NwS6gqrJqARK61xUdBsWXE9ifiwIE=;
        b=q57gdZbK7XQmy+Z9Hld+viwjQBH6iKvj8XrhBrDt7OpgH/BlDk39j5q+4eqWLEeiSL
         BG67E+TtTH24ZxIABwVcyCn7wi+bhi2E+4xn/ibk7x43h4VJ4QgvEnlf9k395Cxz9dyL
         wZ+ubZ6dPOBf5spuBvXkAvF67QRVmrhrxk39CPcJlu91Mm3a2k7GjWnEB/2UWYVaU4qw
         o2WkWHXrayY4Ws1g4CFSi9UEfBYJRZE40UP9xvp5Ax550YVVHXYJiLTWNYfe0h72AgSi
         F95nLVhieU0Ae0Dq8SSd/GCRN/2hp9CZiIIg94LLIDhO6Oc108qN+wIiORBneKnD9jpT
         yH1Q==
X-Gm-Message-State: AOJu0YxH+xrURTPyePg8XMsY7Nl4x3mlzedEuFq2BtQzL7j5tQXVJpn5
	JXzu5ZGxuYrXnDOBz62QZWTolDhT4pAP/zAPI134l8phzqg0Vg+LuhrWyl2z1qyW8A2SFy14Lw8
	Ag4LT+88JnkAfeLsfFYz47l1X6uFKeGBbUmbE
X-Gm-Gg: AfdE7ckE2lvJSKg1kZBedn1IY1nJs2oYRrFyAAzRC0yI2dUXaXr8ht4e25LEUfl0kQn
	JUXxTCKlsHqehFP8uVL0+y8EwdgkrFJuaOReZjYwKusWpZdnO70KoEuYSWlDAK6cRdCzy8PO/I2
	OBukxDNcf1wFJleznkLnwrNU17uQNCbVVaYu9Ph+elomAad0O8HdIvfwhTbjyViv9UbBE0GzTAy
	1Lp+U3gN6UU5cA+s+nRAY3elAn+vEo+Zn0Cwhm0wMl8hPg3WvV/Jp186/aloIgsNOubjBgqQ5EE
	tJOz6KpUuYiwpFKqLDswaMFSNoH+LaUKFuOn3P0bujNwhub2xW209yVSATFpT0SVHhJT/Op51ZL
	Sk+Q/h+veAjebJtY=
X-Received: by 2002:a05:6512:3087:b0:5aa:6395:9a00 with SMTP id
 2adb3069b0e04-5ae3e5242cdmr886377e87.45.1782222105544; Tue, 23 Jun 2026
 06:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com> <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
In-Reply-To: <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 23 Jun 2026 19:11:33 +0530
X-Gm-Features: AVVi8CeviWVFYLshBODl2atuQevqH6YS7l1-HH0eyW2lQTZ1VtYi2mkwi_93InQ
Message-ID: <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com>
Subject: Re: [GSoC] [Blog] week 4: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 4 GSoC blog is live!
https://jayatheerth.com/blogs/gsoc/week-4-phase2

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth

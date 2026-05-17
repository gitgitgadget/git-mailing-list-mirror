Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154FA2F7F01
	for <git@vger.kernel.org>; Sun, 17 May 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779046992; cv=pass; b=nTifuznLsJ+7v67Jnd8vzZRPv3k0T6JHzjQkVpXUV4lK93Vev8o2a0LcQ3foekSRoiZlQiwgXwfPRnQDauG4kYYHvie4q7xiHkMLHWmsfKoCgv5oXwsuTJdxIJrjNOvFHMMVGoUSTr5JbUoSAYiHIYkI7WfoV0KlZw8JC+0ZI2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779046992; c=relaxed/simple;
	bh=gchZsQadrfGX/TyNNhy27n4i2BnMCXyWfBcqrKTQ3oo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EtJKxyBzG3eSYLlgIOFKGy0ujtiAJ3R0Y7l7aQZmfpjUWIMJwACxd2pgRg1blNjMZfRA+Dgum07pIfn+zM8fXjyOr+zXxk0p9KSFuxZ8BxNI6GREKROK09aBAYVFw4TcOt/N492612l/ALyznOAP7OW01XDks2VvmO5q2hHAl6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enr+5Sss; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enr+5Sss"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d2e3b45a1so168268eaf.0
        for <git@vger.kernel.org>; Sun, 17 May 2026 12:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779046990; cv=none;
        d=google.com; s=arc-20240605;
        b=kcH83xP7jC97iBHhuXdSdKgIb7Jep1lc5NQ6YdDe+LDVqLACp0Zs0zeIb44WmQms92
         2ERUq8Ws7KThSKXYpV5E87oC/3Sr3d93MrVdgkfg/rucaPaHdroGYQDHuvuq/8BVS1YY
         fO26ycJ0VUk5IGGc2razwelyPj8ppt/4QVf8m1mepXSlZgMwNKYex6nkD8eCKSy8G82N
         Kvw5mwgaYPC640r9Qg36MPZJd1eQapctSOyCJxjeu0GONO8OubJHwOj7WyhLLsNLSdrT
         jTftBgifc79tSH+IX+rGy1dBlWSVrjf/S99GNgftZu/lgaGM+c5R8y3n/RNrMamH3ZqZ
         7YRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gchZsQadrfGX/TyNNhy27n4i2BnMCXyWfBcqrKTQ3oo=;
        fh=Alk48k/bNmKhH3Coci7urZ1OhtMb0W9ZKbaSUroax+E=;
        b=aHQHBBtOdoeFETiWC/vZeE58t0yVJBzVspqMMa833D6ewenb0UXj8iL6rYRjhPwdEk
         naHQ/HM9BDDIELEHb794LLEzxe/GKGsKGxaFyiXXnZVhNJ6q+A92bTKZ9pvukvWxyXUx
         SYc6/E7w6juRFMAeAKWfDGXn+nO0TX8dZ3fmGx//ppxdfGgOqHFLF1Rr0obrj/n7xyQT
         JCvNcotcMAFft5OT9W0JwnV4VGHIMAn22fP+LFFYZe8bQqcVebrbMOhUuI5QIns+0eN2
         zahGkR2aX8sn7Fsjut2RzcLhkCBISC66GDYQu7JChaMcOc0AHKgk8yR/f3ebvOjxobSu
         To3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779046990; x=1779651790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gchZsQadrfGX/TyNNhy27n4i2BnMCXyWfBcqrKTQ3oo=;
        b=enr+5Sssbez4RC98BaHogPnpLLmwux2c2teOFQnuaf2raZwjkYOG1vbOklmFFFpqi9
         4C+XfRoks9Q/TlIWReeQelwC/spT+Vqne/83pAKfrWiUoA9MwTYF4U6aw5MpG3NaFNub
         mdB1a5zdKUv9KIL9Yymbr5PnPpKlc4CJUDA3eRzNV/wqS+2fGDACNO3aKU+kw3VM9i6x
         6KHUKMXFrQOYaWxzFaX7YLwlbWqYUhwZwO9zUaP0o8QFGi2tXc2MGiCrliJqjhM/QhBM
         VzeQHHjXEzVnnCOxf+/64F66Sg6q5G5mR+9sqia//m9Gtd72h+cscjdxixA7aKihVbBM
         x8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046990; x=1779651790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gchZsQadrfGX/TyNNhy27n4i2BnMCXyWfBcqrKTQ3oo=;
        b=VrWRkGBplf6B/ZrvwgpNvgMyW3RCzqbKDHVXNJYDWx2iMFBDrpdkzUcmBMnep7LIBp
         IGc+vLgbis+GcAYcdekgcIwmlLbvzHTUNJY/N7olsVCkPaP+OpMUMApI7ahWMNjsrCjD
         /PsdzlWRmAcPGInHJG6bRzEtPauNrtRndBDsBS8fA6yhpiOu6mynPbZIwOp3nhOf6Adx
         gbz7+yXLZJa5bCwm7PlLRPFtgPuD69sL2rSOPxRcCDjdcdSXjr9/UPHv0O9BTAiJdlMD
         0CpURorWPuPSF/PxSSKeS2vrf9k1CHYcEIFtGOYtHnF20ZkaEfzGkhI+gMMM4ZaROkMn
         GbCg==
X-Gm-Message-State: AOJu0YxwZtzRmg90KtizUaobPL7skwscJeWOQ2Hp4ZqrYr8N/elJJaki
	DPc6fnpj4Tsq1wvdZWerueL3PBVGep+0EgVtGara08IrEKKEUjwSx8Q9j+21O1mWR8gye3Wg9lr
	L6PB1ddRA6WJKVBFzQOR8VkP+wd4b/HbHlyRM
X-Gm-Gg: Acq92OE0Usu71cUwgRqXps0k4pl9SuVHMAxDd9TdhIFTBeoyqGHf9oHCDsyonWVnxWs
	GE60HG2qvI8ZN0p+ew/z/4Z/dWqFSaTmZ5mGNqzWDU5xusdhEmfM4sDaZKBTT/cb2r46oSiwrkQ
	4jnDxXVLOWWqkmErOf1tAPoiIZP2FvvDd7mDWW7iPJyOnO2VOKGymKvn/pwHPCuUaOxKhiImV5a
	w3pbodIr8eBvRlu/6NLAKAI9LuAiJlV71VBU55chAQNscIZINRSBW441RKYwM8iiTO4P/TEkkV+
	2y4p1/QukJhhe2Y5mwVzVq9eFTIdxQZllW2/NEr9
X-Received: by 2002:a05:6820:f034:b0:696:6f52:95f8 with SMTP id
 006d021491bc7-69c94290f7fmr8251903eaf.3.1779046990032; Sun, 17 May 2026
 12:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 17 May 2026 12:42:59 -0700
X-Gm-Features: AVHnY4K1gVuFlFh40SvGoW72YjpXBqNab4_Fz2-GpgcU0GgluYh7F0MC69Y7JQA
Message-ID: <CAC2QwmKi8wD_cE5aOCtX0SGhvv=yFJhKo5Vb1vyTKLq0RFWKvA@mail.gmail.com>
Subject: Re: git rebase --continue segfault
To: admin@leshe4ka.ru
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 12:19:50 +0300, Alex Naidenkov <admin@leshe4ka.ru> wrote:
>
> Hi, ive encountered on segfault when ran `git rebase --continue`.
> Hopefully this would help
>
> - i was in the middle of big rebase
>
> - entered pin for signing commit
> - segfault happened

Does `git fsck` show anything / also crash?

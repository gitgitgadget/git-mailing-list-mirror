Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795572318;
	b=TRvEKvLNajcZ12kkj0cZMZivdVQMAwETtifRZ6jnuzofsRK3kG0zsvDOmI0mGuO0KMkQ
	 mG0D028Hu6CYsm8gbH/3fH8+JnWYKg39mYa6xhYIwm6JmlTrRU2AhrM+f+DhZ3UZ10mVc
	 +QNyXnbHgmykYtgRhJEinEkfV8i4XeW+mnIMzLJmSz6x94lQXK02o0DC66HB83UyJqv59
	 LjV2zthtpfk/t8sMcXZsmWkxQW9JGYajL+3MRd/7DSWXLO70Nm+2PZ+vZFoegkOwdFaj1
	 4pOy8xabqQJgNv5p1WGbqnBXi635qyWhSWDt4Sx2hkk9KSYyFcJEL67TfgLJE32D1JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Klr2RjQu8H5qEhUm1+thfEYjMxTPUuIhx/W29lz8j7c=;
	b=kEsS0SnUCKEmht7lS9j+4jg6oa7uoed2biPnqLKINSbZ2FVjP93qZ9LHq4a+yFHF/VJM
	 YeMTeVjS6rBOOhiAYNyh/uAUNIo47B/1XQ0bAv0ImU7NWdOhO5H+BGATDpqugLbHWmfry
	 T4n2urKtJrqI6KUrYyvA4lR9qcGIOid2ynURN+sIVu+7HzdWKmhzgPm0n3t4mbt51DFHO
	 15BW6ieboPtnlmYfmIUORTrRgXc6o/lIhU0uX7+eNRKywfFWCTUeP4IDNZueHBh8R69zp
	 wnB1AYgWJJTQZA3gMohQjddlmy9q7BFyZVaXAHFLZquzQ3rg53Ho9CaGu2/jGCfQD7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i43dmZT4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B651606A32C
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 02:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B651606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i43dmZT4
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-716c0217635so6271354eaf.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795572317; cv=none;
        d=google.com; s=arc-20260327;
        b=pfjLUugZG7a9GWrLYIafy8iglvHJlfQ/DLNW8b8ipTc3V4Nqc2zlXh4hDMRflkmv53
         9mtOrFaHhLuqV9T3i+nmC1VhgPdqeznk6UHyErxVs1q/M6z/unw+fb35PaQVg1yxsWIn
         DlFUsVkj9VjHL5D9T0RgIhMFvecL1x5RH6gtTP3/X+KZ+7T7Nm0ppaIas5eqFV6hmgQR
         sja9HjxrRbxdhsbYR6+PHiqkSJX3HEKnh/IAplMMimVsGNHfPWRu9ijDRmQ4OypXLdBN
         8JagQ7EHmsH6DNbr5HqJYMxjplTH4SAYJO/4NO3e/u2aSlY21ARpd/HynetE0NwrHxGm
         gFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Klr2RjQu8H5qEhUm1+thfEYjMxTPUuIhx/W29lz8j7c=;
        fh=tJbo10YBDfXJfl6HsuXn4kwyWC0FAZokToz0LxBhLo4=;
        b=FoaPcInt2rB7pYNA2wm8Vh1vSveP/SdWagun0AaQMTpChv4jXaYivWRtLAI6XmAoX1
         20UNUVGDuvHbZxhBzTjzQq6fgYgiVk/ACQTEnzrshDCI49jRXQpKcbjbciScs2LqAuhd
         LxzGBAsb09H5bHLCg/0l8xpQ4+kuf5ZWKX8b99GuAmghJct1eRBab8IRzJDPrR/yeBVx
         dg+/oo44cRAQinxNmOb8tMIps9D8gq+oSvxhFvOJdD6U14zP3lX6JMG/HfxaIZb3uWFF
         MuV7Z+XuI1sg4u4eeBcfG5X/KKE0CI8gxJ0a8CDWEOgci2GgPuXW3Z+/v/ceIETXF9Ds
         rQJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795572317; x=1796177117; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Klr2RjQu8H5qEhUm1+thfEYjMxTPUuIhx/W29lz8j7c=;
        b=i43dmZT4vwWW1Ox7W+iUvfkleT4R2ZDCyXb7wSZE8sXLeVC9801V/MoqT7w1BSP2df
         945L0wmRTIduUkka0JCl9ajbu8i2plVlsLJ1vfbvM9utPx61EPxDSk5bnF67QtEb0h0s
         hmtRlY4UIdgfOkZUxLZoto1N813pgEUWMlk7GcDd26XsweZpFtLDKmwsFAJXGpH4toJ2
         ccpWAZvM6LCVzUhPkclQr2NTIkD3dsR0wSGD7HFnP2QGXROQvOjxTHvOuv+a4gA1tIyF
         GlLSVFkFpYJit20jK3END/fged+aT3+KUXBC3ePqUR1IUmzwmPlI9TwWcndZ7Iqe8jo9
         iRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795572317; x=1796177117;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klr2RjQu8H5qEhUm1+thfEYjMxTPUuIhx/W29lz8j7c=;
        b=x/Grd97836uJGHqNEyDa1BE36fK5jFtX9lYdPPM2421QNW+IPr+mHj7GEmzBtvHf6x
         lTU7QWXFqoWJ9Fm00rPyEPJP4juexY+WfirtaT9mVmbp42Gsoeepi3KUyXDfOGaZ88sN
         XIl5HIYOpLuCcGQWYHasPLBsBH8K5KIuifcjrNg4sx1uifbGMkw7mB/5S9jaDdR2wO3C
         yIH/m7VJlct2164CAqMu917v1M/uNSd0i/CJEloAtbQPmE7GLNozwOrDe2Fjr+B9mTQt
         Wodksn54hOjxu/Egh4BFDGKh502F5X9GXU0CHnesSPpuLBdDtzPQQuORZWt1/4oTpyMB
         Oyxg==
X-Gm-Message-State: APuU4Z/ZO1LAUXeVkjjA2a87ZoqFNLjwV9XGObgdGmO6LDbmaOwvP7IW
	jNqy/kBwFf6oF6T/IxU4iri3DTslY9PwpAHGN4aNLLzJBUxXVTwVXVdoBaJMUZB517Ifvx5HIX/
	s+yjNqnblECXl8H8gvihzb/28VeiyXzrruCNtzcCSdA==
X-Gm-Gg: AZFdTZcVO0hVx3WcvNTMpeXJOu9tWAuHK9yLenZesu+ybpZcJgmnZEYEQc8ef6hIPCQ
	PWp+mcZmOSUBt15m+uRxFdmwOfUV+JinNkuIwM+rHY3xunMj5OOxr13Y73qxijB/DISO/8qLQVG
	/OhKXOdhbA8PDVfZW3ZzJxs/VdyYx549fXqR8vXhCCDldCfik5dFcl1YE2JsxpBxG5iWd4j550U
	46zCuYrH8LB3P20bXALYjOy9fNHWU5zwWFFMS2czBJL4Sca1OpKObRveYU1MJAFxuGlKQz7k8b6
	q0UKjxiRXo4JXpPgW3I89XevrUC0h8JiwO/lLRPjpGHngKELfyR/aeEoJPxNLwG8p1QMp8s9f9f
	Pi/dPqdvmox4GDgLP3c9RZxKowRoQhv+oG5YKV71ZqrV3PdfHLZrg1oXAGjROLiuEWPzhW3/Rie
	Bx+yxYKsEgyIZrT9eS7iwvvHCwOFsncZS5D9QADZ/cb2V0UMaVu5XEAw==
X-Received: by 2002:a05:6820:f00c:b0:71b:7b7e:d5e3 with SMTP id
 006d021491bc7-71b7b7eda0bmr400407eaf.13.1795572317054; Tue, 24 Nov 2026
 18:05:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAQS9U+Ht3x=V3e1XJT9V120Tj5jCuCMTrxTnZyzTpsg-G9uBQ@mail.gmail.com>
In-Reply-To: <CAAQS9U+Ht3x=V3e1XJT9V120Tj5jCuCMTrxTnZyzTpsg-G9uBQ@mail.gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Wed, 25 Nov 2026 05:04:40 +0300
X-Gm-Features: Aa3M54rWKLmI2-U8xIBIX2Glj1AsROaGIpqBsM7hY48p-Dnt66v2kYMnCcO9qBE
Message-ID: <CAKrRMNpHHHHw3goFMwLKF2GRzQefcXJaXZcjY6yz_7QdbgJ_cA@mail.gmail.com>
Subject: Re: User-initiated recovery for stale index.lock
To: Steve <steves.sk@gmail.com>
Cc: git@vger.kernel.org, quark.zju@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Steve,

On Tue, 17 Nov 2026 at 20:51, Steve <steves.sk@gmail.com> wrote:
> Could Git add a user-invoked command to recover from a stale
> `index.lock` when no Git process runs anymore? It could wait briefly,
> then remove the lock and continue, but only if no other Git operation
> contests it.

Git already has part of this. Since Git 2.54 there is
core.lockfilePid. With it set, Git writes the PID of the lock holder
next to the lock (index~pid.lock), and if it can't take the lock, it
tells you whether that process is still running:

  Lock was held by process 99999, which is no longer running; the lock
  file appears to be stale

You still remove index.lock yourself, though.

Jun Wu also has a series in 'seen' that adds core.indexLockTimeout,
so that commands wait a little for the index lock before failing [1].
That covers your "wait briefly" suggestion.

Removing the lock automatically is tricky. A PID can be
reused by an unrelated process, and it says nothing when the
repository is also used from another machine, for example over NFS.
When the PID file was discussed, Junio was wary even of telling users
to remove the lock [2].

[1] https://lore.kernel.org/git/20261017073231.3357477-1-quark.zju@gmail.com/
[2] https://lore.kernel.org/git/xmqqbjj4hnkr.fsf@gitster.g/

Thanks,
Tanga

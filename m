Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0D40D572
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973024; cv=pass; b=GLN1kT3hqkk4qmnz5H2lPiGK7Ur+YD0++eU8iyoDfzozDlYgd74Hip1r2EF8YEpbmz2auPHgGtll78fJXvCUlhUyR2QYhsm0hE22+iR7TIbPNei/qHLuyT7J6tvbH6X7HB8mz5/SJBf5vL/53u/7yXGoeVbW+o8xEuY/sCjGCBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973024; c=relaxed/simple;
	bh=IrYlSi3zYxiM6ziVVgK6gwxUnkN2+5djyIdF238YeRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9kn9trizYL0VUbQmL2SblyJ/KnGhVNujKQ82/pem+EvlPWgT5vAF38HHaOkFuB7ivr/Bvc0zgz4kgeAVagwDDZIahCEU0F1Cm1kSMmxel/iXzVV74X0NGbi5SO+z0wP/u6oY74s5qLdG2cNkLZeuJmSc+Gm2OdTJZxUWUOq4o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0mkH3J0; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0mkH3J0"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad583dc41eso1896093e87.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 09:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781973021; cv=none;
        d=google.com; s=arc-20240605;
        b=jVcZF03n4IYStYby9CLs4gOrbRK5mnuY/XSk5VbubUvDejHn8T0ruYRRvxqXPYSmoH
         kUTWaqpuRYUp6to2MHBNcDxuXbNKHskXbPJLDxTpYzSXrZNhz1kp6+8ZCSViP5DDiNrg
         o7hNj+bL9+qv4ehC6Wwz8IhdUYbzZWAm/CpSoT05oYlvov6h7a6bMSr1Xbl9VY64hCvl
         9iKAUXB7HSfgirfFsDgVAW+SU//ZfaJYu24zhEUbe/ueYtnxzfEYS5UqW//pfNTDtjNX
         F1jrkQxWUtgw7hqlkduFbIaLrxNqPxONJv7XzyqgyyQ9iazL4pnHSiE/jr1kypKKzsk2
         qLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IrYlSi3zYxiM6ziVVgK6gwxUnkN2+5djyIdF238YeRI=;
        fh=RmX6VTpA6WARwju1QjHTilMXhXt1nLq8K1jl6IWe7Hw=;
        b=RYACzfdi9o5n1/HSMYA6Hesb2aktuSeUWm2lzxG5rtY/XBQ+XNGBFwN5cJK54fvYc0
         yn+TVp5qUcwsDzwp1rmFx0qckhKMpW19HQloNG6DK9ouQKU8Hxc6OvPJYrssBB+4RUf9
         Wt5uZDPG0D/gVCKzllL4uJvnBy1+r0+UuWFfO6RwLgCNX9t7JgRyPvJNFXimOUPHOBu7
         kcBCBd4IqyNmsEvV28JIyznjc2czXb/NdQxDW0SWUZZyA3meVXZiBoJWbWaa0dL54Pbc
         ggd2H1l4yezlYcRMcbLdSxIV50tnq2yDUx8xmfDjTGl1GHS0Ikqpxjwor7tSbJBxab3t
         Fb/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781973021; x=1782577821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IrYlSi3zYxiM6ziVVgK6gwxUnkN2+5djyIdF238YeRI=;
        b=L0mkH3J0UsB7/acyzB18wnLP0bBB5nDWlfo73TGO20i10+GJHZxL9nurGHsGkQWD00
         NoLpVSKV/yi6c0RWSYDRNYfVbYSh768qaxlsFQ1i/GK0pwJ1ab5j2lWzf/xy+5xIqnPa
         ZgIUwTFOi1+NKHsYTWA5gXWsU8ddk15IAZpRS4+wJ97i5Md0txUkE+IuylLumCV6HjmU
         WCynmvNVlRgCTTvBbaVViXfSAeV6ea60hQXriOIHNF42RNZ/NBJQ63uaO1ItJi96usGA
         pX71YpLepUCMceGuo6EJFkHJsCbW27V9L9JNa3Gjze+Wgc1YNuKmy1A/laV6RfKx/U+j
         SQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781973021; x=1782577821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrYlSi3zYxiM6ziVVgK6gwxUnkN2+5djyIdF238YeRI=;
        b=guz/Kvaz9X2gmNouHy10fUk6fzth3LxbMvE8ZWERmLzmqTBRM83lr0n3XC/IU/g0D0
         4y4Mn8kanoeGB6QfF3cm8iG/oRONBcDJ5w9+VfqMygu0jWVXSVyjXHDXT7bIULTt90Xw
         zL1YQJcwt9AcEvcv9Aj1ZMlwqprQf0UPxQ+X+j0s5AQE3qFwXOZVmJAGW0C4B5ymrbbJ
         D4TETONso1GHo4WjtvpQ3yIT7VryObzalFjD4zA6dt1KGUTttW2T82qKTYf2OpT5NSyF
         qigUChlnoaLTLLXYOBRxLv5Q7DjaG533asbeXtn8ymhhglrtthS8bHOZY6AaMxwPxFd3
         oZQQ==
X-Gm-Message-State: AOJu0YyPIYscbitbXeYEnENT6+18BXZ0LvlAuhKWZOJWA9R8VEftPQZ6
	f20Ji0mMFdmX2rlLMkmfWn58yg2GLfEGVTtrR+C5r7L71VU+vwOnaU+lKhIPppNgj3aIyPitx4C
	DWj/ALtY0ApR9t19KW++6VeHWhZ9qd9U=
X-Gm-Gg: AfdE7clE9l2G+08aeop8DdjhKf+QbR0bI9TAdoGcNXfQiKwtg7+C8p0941oNP+CDzm0
	oYZrud54W7TUZgenkgylajPE+sR/otlMhIwaY6aLxxF7wylcuTz+Xj5msZSrtA1ztJ4/loCS0xE
	GiUhF2inJhg5/wqL1570IsIXH6Nla5jjLRBKQyqFBEJ5gDNRX1T6dXP2WYPgZjSJZTfVnUSmgcd
	q1fEvsk573vVohyWhHyBPKqNW2uFFUAlxOxdSSWBXqswthBE+MfizigR5j2n4m6cm7Xb3jwp1vA
	hPexiKlHXIyUcITjovxH/ilLbQ11idkMi/DjL2NMAZXRCeWAnHE9Vu/2AMo5RwSG0vUHvh5XXil
	t9UF+nKH3dgABxZw=
X-Received: by 2002:a05:6512:2c03:b0:5a2:c0ab:b57f with SMTP id
 2adb3069b0e04-5ad5628460amr2163991e87.14.1781973020883; Sat, 20 Jun 2026
 09:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-2-jayatheerthkulkarni2005@gmail.com> <xmqqbjd5guci.fsf@gitster.g>
In-Reply-To: <xmqqbjd5guci.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 20 Jun 2026 22:00:09 +0530
X-Gm-Features: AVVi8CfWuMoaLPMYoIykBAcDNF5_psrZLN0KUTad_LFmkAoaY3zaEvzDFF8mEqk
Message-ID: <CA+rGoLcibxaEs7KzS8a=A9kxV8+3KCqVXOK+zoiFtNvJkVHvCA@mail.gmail.com>
Subject: Re: [GSoC Patch v6 1/4] path: introduce append_formatted_path() for
 shared path formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net, 
	kumarayushjha123@gmail.com, a3205153416@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

> It often, even though not always, is a sign of a bad topic structure
> to have an insertion-only patch without any removal of existing
> code, that adds totally unused code.
>
> If the step is to "extract the core algorithm", shouldn't it be able
> to replace existing code already?

Giving the helper and converting its
first caller (`rev-parse`) in the same step proves the implementation
avoids leaving unused code lingering in the tree, even temporarily.

> We may want to add new features to this helper function near the end
> of the topic, but wouldn't it make sense for the topic to first
> consolidate various path formatting logic already present in the
> existing code into a single helper for ease of extending it (which
> means replacing open-coded logic in existing code paths with a call
> to the new helper, which would have a code that may look very
> similar to the original code that was replaced with a single call to
> the helper function), and then expose the helper for use by new
> callers, and finally further add new features that existing code
> paths wouldn't have needed but the new callers would want?

Consolidating the existing logic first ensures
we aren't introducing unnecessary complexity up front. I agree with
restructuring the topic this way.

> How else can we make sure this new implementation added by the first
> step in the series is (1) capable enough to reproduce what we
> already have in different parts of the system, (2) does not bring in
> what the current codebase does not need, and (3) bug-to-bug
> compatible with the existing code paths?

Introducing the helper and swapping out the `rev-parse`
implementation in the same step is the best way to prove bug-to-bug
compatibility and demonstrate its immediate utility.

For v7, I will squash patches 1 and 2 together so that the extraction
and the replacement happen simultaneously, guaranteeing that the new
`append_formatted_path()` perfectly mirrors the old behavior before
we introduce the new `path.*` callers.

Thanks for taking the time to explain the rationale!

- K Jayatheerth
